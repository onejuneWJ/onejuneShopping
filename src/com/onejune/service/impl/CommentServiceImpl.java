package com.onejune.service.impl;

import com.onejune.dao.CommentDao;
import com.onejune.dao.MemberDao;
import com.onejune.pojo.Comment;
import com.onejune.pojo.CommentExample;
import com.onejune.pojo.Member;
import com.onejune.pojo.MemberExample;
import com.onejune.service.CommentService;
import com.onejune.utils.StringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service("commentService")
@Transactional
public class CommentServiceImpl implements CommentService {
    private CommentDao commentDao;
    private MemberDao memberDao;
    private StringUtil stringUtil = new StringUtil();

    @Autowired
    public void setCommentDao(CommentDao commentDao) {
        this.commentDao = commentDao;
    }

    @Autowired
    public void setMemberDao(MemberDao memberDao) {
        this.memberDao = memberDao;
    }

    private CommentExample commentExample = new CommentExample();
    private MemberExample memberExample = new MemberExample();

    /**
     * 根据商品id查询评论
     *
     * @param goodsid 商品id
     * @return 评论列表
     */
    @Override
    public List<Comment> findByGoodsId(Integer goodsid) {
        commentExample.createCriteria().andGoodsidEqualTo(goodsid);//查询评论条件 根据id查询
        List<Comment> commentList = commentDao.selectByExample(commentExample);//查询到的评论列表
        commentExample.clear();//清空查询评论条件
        for (Comment comment : commentList) {
            memberExample.createCriteria().andIdEqualTo(comment.getMemberid());//查询会员条件 根据id查询
            List<Member> memberList = memberDao.selectByExample(memberExample);//查询到的会员列表
            memberExample.clear();//清空查询会员条件
            if (memberList.size() > 0) {
                Member member = memberList.get(0);
                comment.setMember(member);//设置评论的会员
            }
        }

        return commentList;
    }

    /**
     * 添加评论
     * @param comment
     * @return
     */
    @Override
    public String addComment(Comment comment) {
        comment.setId(stringUtil.getUUIDInt());
        comment.setCreatetime(stringUtil.getTime());
        if (commentDao.insertSelective(comment) > 0) {
            return "success";
        } else {
            return "failed";
        }
    }
}
