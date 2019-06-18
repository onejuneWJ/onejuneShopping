package com.onejune.service.impl;

import com.onejune.dao.BigtypeDao;
import com.onejune.pojo.Bigtype;
import com.onejune.pojo.BigtypeExample;
import com.onejune.service.BigTypeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
@Service("bigTypeService")
@Transactional
public class BigTypeServiceImpl implements BigTypeService {

    private BigtypeDao bigtypeDao;
    @Autowired
    public void setBigtypeDao(BigtypeDao bigtypeDao) {
        this.bigtypeDao = bigtypeDao;
    }

   private BigtypeExample bigtypeExample=new BigtypeExample();
    @Override
    public List<Bigtype> findAll() {
        return bigtypeDao.selectByExample(bigtypeExample);
    }
}
