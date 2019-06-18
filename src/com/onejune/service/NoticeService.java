package com.onejune.service;

import com.onejune.pojo.Notice;

import java.util.List;

public interface NoticeService {

    List<Notice> findAllNotice();

    List<Notice> findByTile(String title);


    Notice findById(Integer id);

    String addNotice(Notice notice);

    String deleteNotice(Integer[] ids);

    String updateNotice(Notice notice);
}
