package com.onejune.dao;

import com.onejune.pojo.Gorder;
import com.onejune.pojo.GorderExample;

import java.util.List;

import org.apache.ibatis.annotations.Param;

public interface GorderDao {
    long countByExample(GorderExample example);

    int deleteByExample(GorderExample example);

    int deleteByPrimaryKey(String number);

    int insert(Gorder record);

    int insertSelective(Gorder record);

    List<Gorder> selectByExample(GorderExample example);

    Gorder selectByPrimaryKey(String number);

    int updateByExampleSelective(@Param("record") Gorder record, @Param("example") GorderExample example);

    int updateByExample(@Param("record") Gorder record, @Param("example") GorderExample example);

    int updateByPrimaryKeySelective(Gorder record);

    int updateByPrimaryKey(Gorder record);

    List<Gorder> selectByBigType(int bigType);

    List<Gorder> selectBySmallType(int smallType);
}