package com.onejune.service.impl;

import com.onejune.dao.NoticeDao;
import com.onejune.pojo.Notice;
import com.onejune.pojo.NoticeExample;
import com.onejune.service.NoticeService;
import com.onejune.utils.StringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

@Service("noticeService")
@Transactional
public class NoticeServiceImpl implements NoticeService {

    private NoticeDao noticeDao;

    @Autowired
    private void setNoticeDao(NoticeDao noticeDao) {
        this.noticeDao = noticeDao;
    }

    private NoticeExample noticeExample = new NoticeExample();
    private StringUtil stringUtil = new StringUtil();

    @Override
    public String addNotice(Notice notice) {
        notice.setId(stringUtil.getUUIDInt());
        notice.setIssuetime(stringUtil.getTime());
        if (noticeDao.insertSelective(notice) > 0) {
            return "success";
        } else {
            return "failed";
        }
    }

    @Override
    public List<Notice> findAllNotice() {
        try {
            noticeExample.setOrderByClause("issueTime desc");
            return noticeDao.selectByExample(noticeExample);
        } finally {
            noticeExample.clear();
        }
    }

    @Override
    public List<Notice> findByTile(String title) {
        noticeExample.createCriteria().andTitleEqualTo(title);
        try {
            return noticeDao.selectByExample(noticeExample);
        } finally {
            noticeExample.clear();
        }
    }

    @Override
    public String deleteNotice(Integer[] ids) {
        int m = 0;//定义一个变量记录删除的公告数
        for (Integer id : ids) {
            //删除一条记录 m+1
            if (noticeDao.deleteByPrimaryKey(id) > 0) {
                m++;
            }
        }
        if (m == ids.length) { //如果删除数和传过来的id数量长度相等，删除成功
            return "success";
        } else {
            return "failed";
        }
    }

    @Override
    public Notice findById(Integer id) {
        try {
            noticeExample.createCriteria().andIdEqualTo(id);
            List<Notice> noticeList=noticeDao.selectByExample(noticeExample);
            if(noticeList.size()>0){
                return noticeList.get(0);
            }else {
                return null;
            }
        }finally {
            noticeExample.clear();
        }
    }

    @Override
    public String updateNotice(Notice notice) {
        System.out.println(notice);
        notice.setIssuetime(stringUtil.getTime());
        if(noticeDao.updateByPrimaryKeySelective(notice)>0){
            return "success";
        }else {
            return "failed";
        }
    }
}
