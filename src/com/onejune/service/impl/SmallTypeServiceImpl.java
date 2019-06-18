package com.onejune.service.impl;

import com.onejune.dao.SmalltypeDao;
import com.onejune.pojo.Smalltype;
import com.onejune.pojo.SmalltypeExample;
import com.onejune.service.SmallTypeService;
import com.onejune.utils.StringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service("smallTypeService")
@Transactional
public class SmallTypeServiceImpl implements SmallTypeService {

    private SmalltypeDao smalltypeDao;
    private StringUtil stringUtil=new StringUtil();

    @Autowired
    public void setSmalltypeDao(SmalltypeDao smalltypeDao) {
        this.smalltypeDao = smalltypeDao;
    }

    private SmalltypeExample smalltypeExample = new SmalltypeExample();

    @Override
    public List<Smalltype> findByBigid(Integer bigid) {
        smalltypeExample.createCriteria().andBigidEqualTo(bigid);
        List<Smalltype> smalltypeList = smalltypeDao.selectByExample(smalltypeExample);
        smalltypeExample.clear();
        return smalltypeList;
    }

    @Override
    public Object newSmallType(Integer bigid, String smallname) {
        Smalltype smalltype = new Smalltype();
        smalltype.setId(stringUtil.getUUIDInt());
        smalltype.setBigid(bigid);
        smalltype.setSmallname(smallname);
        smalltype.setCreatetime(stringUtil.getTime());
        if (smalltypeDao.insertSelective(smalltype) > 0) {
            return smalltype;
        } else {
            return "failed";
        }
    }

}
