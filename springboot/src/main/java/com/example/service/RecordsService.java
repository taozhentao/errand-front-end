/**
 * 功能：
 * 作者：陶振涛
 * 日期：2024/4/12 15:58
 */
package com.example.service;

import cn.hutool.core.date.DateUtil;
import com.example.entity.Account;
import com.example.entity.Records;
import com.example.mapper.RecordsMapper;
import com.example.utils.TokenUtils;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.List;

/**
 * 收支明细业务处理
 **/
@Service
public class RecordsService {

    @Resource
    private RecordsMapper recordsMapper;


    public void addRecords(String content, BigDecimal money, String type) {
        Records records = new Records();
        records.setTime(DateUtil.now());
        records.setContent(content);
        records.setType(type);
        records.setMoney(money);
        records.setUserId(TokenUtils.getCurrentUser().getId());
        recordsMapper.insert(records);
    }

    /**
     * 新增
     */
    public void add(Records records) {
        recordsMapper.insert(records);
    }

    /**
     * 删除
     */
    public void deleteById(Integer id) {
        recordsMapper.deleteById(id);
    }

    /**
     * 批量删除
     */
    public void deleteBatch(List<Integer> ids) {
        for (Integer id : ids) {
            recordsMapper.deleteById(id);
        }
    }

    /**
     * 修改
     */
    public void updateById(Records records) {
        recordsMapper.updateById(records);
    }

    /**
     * 根据ID查询
     */
    public Records selectById(Integer id) {
        return recordsMapper.selectById(id);
    }

    /**
     * 查询所有
     */
    public List<Records> selectAll(Records records) {
        Account currentUser = TokenUtils.getCurrentUser();
        records.setUserId(currentUser.getId());
        return recordsMapper.selectAll(records);
    }

    /**
     * 分页查询
     */
    public PageInfo<Records> selectPage(Records records, Integer pageNum, Integer pageSize) {
        PageHelper.startPage(pageNum, pageSize);
        List<Records> list = recordsMapper.selectAll(records);
        return PageInfo.of(list);
    }

}