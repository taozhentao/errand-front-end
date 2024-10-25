/**
 * 功能：
 * 作者：陶振涛
 * 日期：2024/4/12 16:13
 */
package com.example.service;

import cn.hutool.core.collection.CollUtil;
import cn.hutool.core.date.DateUtil;
import com.example.common.Constants;
import com.example.common.enums.OrderStatusEnum;
import com.example.entity.Account;
import com.example.entity.Comment;
import com.example.entity.Orders;
import com.example.mapper.CommentMapper;
import com.example.utils.RedisUtils;
import com.example.utils.TokenUtils;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

/**
 * 评价表业务处理
 **/
@Service
public class CommentService {

    @Resource
    private CommentMapper commentMapper;

    @Resource
    private OrdersService ordersService;

    /**
     * 新增
     */
    @Transactional
    public void add(Comment comment) {
        comment.setTime(DateUtil.now());
        commentMapper.insert(comment);

        // 设置缓存
        this.setCache(comment);

        // 更新订单状态 待评价改为已完成
        Integer orderId = comment.getOrderId();
        Orders orders = ordersService.selectById(orderId);
        orders.setStatus(OrderStatusEnum.DONE.getValue());  // 已完成
        ordersService.updateById(orders);
    }

    public void setCache(Comment comment) {
        List<Comment> commentList = commentMapper.selectUserComment(comment.getUserId());
        List<Comment> AcceptCommentList = commentMapper.selectAcceptComment(comment.getAcceptId());
        RedisUtils.setCacheObject(Constants.REDIS_COMMENT_KEY + comment.getUserId(),commentList);
        RedisUtils.setCacheObject(Constants.REDIS_COMMENT_KEY + comment.getAcceptId(),AcceptCommentList);
    }

    /**
     * 删除
     */
    public void deleteById(Integer id) {
        commentMapper.deleteById(id);
    }

    /**
     * 批量删除
     */
    public void deleteBatch(List<Integer> ids) {
        for (Integer id : ids) {
            commentMapper.deleteById(id);
        }
    }

    /**
     * 修改
     */
    public void updateById(Comment comment) {
        commentMapper.updateById(comment);
    }

    /**
     * 根据ID查询
     */
    public Comment selectById(Integer id) {
        return commentMapper.selectById(id);
    }

    /**
     * 查询所有
     */
    public List<Comment> selectAll(Comment comment) {
        return commentMapper.selectAll(comment);
    }

    /**
     * 分页查询
     */
    public PageInfo<Comment> selectPage(Comment comment, Integer pageNum, Integer pageSize) {
        PageHelper.startPage(pageNum, pageSize);
        List<Comment> list = commentMapper.selectAll(comment);
        return PageInfo.of(list);
    }

    public List<Comment> selectComment(Integer id) {
        List<Comment> commentList = RedisUtils.getCacheObject(Constants.REDIS_COMMENT_KEY + id);
        if(CollUtil.isEmpty(commentList)) {
            commentList = commentMapper.selectComment(id);
            RedisUtils.setCacheObject(Constants.REDIS_COMMENT_KEY + id,commentList);
            for (Comment comment : commentList) {
                this.setCache(comment);
            }
        }
        return commentList;
    }
}