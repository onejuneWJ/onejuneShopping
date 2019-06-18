package com.onejune.service;

import com.onejune.pojo.Comment;

import java.util.List;

public interface CommentService {
    List<Comment> findByGoodsId(Integer goodsid);
    String addComment(Comment comment);
}
