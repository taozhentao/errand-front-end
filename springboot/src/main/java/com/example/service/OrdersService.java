/**
 * 功能：
 * 作者：陶振涛
 * 日期：2024/4/9 15:37
 */
package com.example.service;

import cn.hutool.core.date.DateUnit;
import cn.hutool.core.date.DateUtil;
import cn.hutool.core.util.IdUtil;
import com.example.common.enums.OrderStatusEnum;
import com.example.common.enums.RecordsTypeEnum;
import com.example.common.enums.ResultCodeEnum;
import com.example.entity.*;
import com.example.exception.CustomException;
import com.example.mapper.OrdersMapper;
import com.example.utils.TokenUtils;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

/**
 * 订单信息业务处理
 **/
@Service
public class OrdersService {

    @Resource
    private OrdersMapper ordersMapper;

    @Resource
    private UserService userService;

    @Resource
    private AddressService addressService;

    @Resource
    private CertificationService certificationService;

    @Resource
    private RecordsService recordsService;

    /**
     * 新增
     */
    public void add(Orders orders) {
        ordersMapper.insert(orders);
    }

    /**
     * 删除
     */
    public void deleteById(Integer id) {
        ordersMapper.deleteById(id);
    }

    /**
     * 批量删除
     */
    public void deleteBatch(List<Integer> ids) {
        for (Integer id : ids) {
            ordersMapper.deleteById(id);
        }
    }

    /**
     * 修改
     */
    @Transactional
    public void updateById(Orders orders) {
        if(orders.getStatus().equals(OrderStatusEnum.NO_RECEIVE.getValue())) {
            // 骑手送达订单 给骑手打钱
            User user = userService.selectById(orders.getAcceptId());
            user.setAccount(user.getAccount().add(BigDecimal.valueOf(orders.getPrice())));
            userService.updateById(user);

            // 记录收支明细
            recordsService.addRecords("下单" + orders.getName(), BigDecimal.valueOf(orders.getPrice()), RecordsTypeEnum.INCOME.getValue());
        } else if(OrderStatusEnum.CANCEL.getValue().equals(orders.getStatus())) {
            // 记录收支明细
            recordsService.addRecords("取消订单" + orders.getName(), BigDecimal.valueOf(orders.getPrice()), RecordsTypeEnum.CANCEL.getValue());
        }

        ordersMapper.updateById(orders);
    }

    /**
     * 根据ID查询
     */
    public Orders selectById(Integer id) {
        Orders orders = ordersMapper.selectById(id);
        Address address = addressService.selectById(orders.getAddressId());
        orders.setAddress(address);
        Address targetAddress = addressService.selectById(orders.getTargetId());
        orders.setTargetAddress(targetAddress);

        Certification certification = certificationService.selectByUserId(orders.getUserId());
        orders.setCertification(certification);
        return orders;
    }

    /**
     * 查询所有
     */
    public List<Orders> selectAll(Orders orders) {
        List<Orders> ordersList = ordersMapper.selectAll(orders);
        for (Orders o : ordersList) {
            Date date = new Date();
            String time = o.getTime();
            int range = (int) DateUtil.between(DateUtil.parseDateTime(time), date, DateUnit.MINUTE);
            o.setRange(range);
        }
        return ordersList;
    }

    /**
     * 分页查询
     */
    public PageInfo<Orders> selectPage(Orders orders, Integer pageNum, Integer pageSize) {
        PageHelper.startPage(pageNum, pageSize);
        List<Orders> list = ordersMapper.selectAll(orders);
        return PageInfo.of(list);
    }

    public void addOrder(Orders orders) {
        Account currentUser = TokenUtils.getCurrentUser();
        BigDecimal account = currentUser.getAccount();
        Double price = orders.getPrice();
        if (price > account.doubleValue()) {
            throw new CustomException(ResultCodeEnum.ACCOUNT_LIMIT_ERROR);
        }
        currentUser.setAccount(account.subtract(BigDecimal.valueOf(price)));
        userService.updateById((User) currentUser);

        orders.setUserId(currentUser.getId());
        orders.setOrderNo(IdUtil.getSnowflakeNextIdStr()); // 唯一订单编号
        orders.setTime(DateUtil.now());
        orders.setStatus(OrderStatusEnum.NO_ACCEPT.getValue());
        recordsService.addRecords("支出" + orders.getName(), BigDecimal.valueOf(orders.getPrice()), RecordsTypeEnum.OUT.getValue());
        ordersMapper.insert(orders);
    }

    public void accept(Orders orders) {
        Account currentUser = TokenUtils.getCurrentUser();  // 骑手用户
        orders.setAcceptId(currentUser.getId());
        orders.setAcceptTime(DateUtil.now());
        orders.setStatus(OrderStatusEnum.NO_ARRIVE.getValue());
        this.updateById(orders);

    }
}