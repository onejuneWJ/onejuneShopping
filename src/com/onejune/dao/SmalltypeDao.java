package com.onejune.dao;

import com.onejune.pojo.Smalltype;
import com.onejune.pojo.SmalltypeExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface SmalltypeDao {
    long countByExample(SmalltypeExample example);

    int deleteByExample(SmalltypeExample example);

    int deleteByPrimaryKey(Integer id);

    int insert(Smalltype record);

    int insertSelective(Smalltype record);

    List<Smalltype> selectByExample(SmalltypeExample example);

    Smalltype selectByPrimaryKey(Integer id);

    int updateByExampleSelective(@Param("record") Smalltype record, @Param("example") SmalltypeExample example);

    int updateByExample(@Param("record") Smalltype record, @Param("example") SmalltypeExample example);

    int updateByPrimaryKeySelective(Smalltype record);

    int updateByPrimaryKey(Smalltype record);
}