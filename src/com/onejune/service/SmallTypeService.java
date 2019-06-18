package com.onejune.service;

import com.onejune.pojo.Smalltype;

import java.util.List;

public interface SmallTypeService {
    List<Smalltype> findByBigid(Integer bigid);
    Object newSmallType(Integer bigid,String smallname);
}
