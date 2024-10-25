/**
 * 功能：
 * 作者：陶振涛
 * 日期：2024/4/21 15:10
 */
package com.example.service;

import cn.hutool.core.date.DateTime;
import cn.hutool.core.date.DateUnit;
import cn.hutool.core.date.DateUtil;
import com.example.common.enums.OrderStatusEnum;
import com.example.common.enums.RecordsTypeEnum;
import com.example.entity.Orders;
import com.example.entity.User;
import org.slf4j.LoggerFactory;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import org.slf4j.Logger;

import javax.annotation.Resource;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

@Component
public class OrdersSchedule {
    private static Logger log = LoggerFactory.getLogger(OrdersSchedule.class);

    @Resource
    private OrdersService ordersService;

    @Resource
    private UserService userService;

    @Resource
    private RecordsService recordsService;

    @Scheduled(fixedRate = 60000)
    public void task() {
        log.info("========================订单扫描任务开始========================");
        Orders params = new Orders();
        params.setStatus(OrderStatusEnum.NO_ACCEPT.getValue());
        List<Orders> ordersList = ordersService.selectAll(params);
        for (Orders orders : ordersList) {
            String time = orders.getTime();
            DateTime dateTime = DateUtil.parseDateTime(time);
            long seconds = DateUtil.between(dateTime, new Date(), DateUnit.SECOND);
            // 超过10分钟自动取消
            if (seconds > 600 && orders.getStatus().equals(OrderStatusEnum.NO_ACCEPT.getValue())) {
                orders.setStatus(OrderStatusEnum.CANCEL.getValue());
                ordersService.updateById(orders);

                //取消订单后归还用户余额
                User user = userService.selectById(orders.getUserId());
                user.setAccount(user.getAccount().add(BigDecimal.valueOf(orders.getPrice())));
                userService.updateById(user);

                recordsService.addRecords("取消订单" + orders.getName(), BigDecimal.valueOf(orders.getPrice()), RecordsTypeEnum.INCOME.getValue());
            }
        }
        log.info("========================订单扫描任务结束========================");
    }
}
