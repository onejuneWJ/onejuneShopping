package com.onejune.dao;

import com.onejune.pojo.Bigtype;
import com.onejune.pojo.BigtypeExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface BigtypeDao {
    long countByExample(BigtypeExample example);

    int deleteByExample(BigtypeExample example);

    int deleteByPrimaryKey(Integer id);

    int insert(Bigtype record);

    int insertSelective(Bigtype record);

    List<Bigtype> selectByExample(BigtypeExample example);

    Bigtype selectByPrimaryKey(Integer id);

    int updateByExampleSelective(@Param("record") Bigtype record, @Param("example") BigtypeExample example);

    int updateByExample(@Param("record") Bigtype record, @Param("example") BigtypeExample example);

    int updateByPrimaryKeySelective(Bigtype record);

    int updateByPrimaryKey(Bigtype record);
}