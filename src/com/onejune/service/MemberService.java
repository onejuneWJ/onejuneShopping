package com.onejune.service;

import com.onejune.pojo.Member;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import java.util.HashMap;
import java.util.List;

public interface MemberService {

    HashMap<String, Object> login(String loginName, String password);

    String register(Member member);

    String checkPhone(String phone);

    String checkName(String name);

    String deleteById(Integer id);

    List<Member> findByCondition(String condition);

    HashMap<String, Object> uploadAvatar(CommonsMultipartFile commonsMultipartFile, Integer memberID, String path);

    HashMap<String, Object> update(Member member);

    String checkPassword(String password,Integer id);
}
