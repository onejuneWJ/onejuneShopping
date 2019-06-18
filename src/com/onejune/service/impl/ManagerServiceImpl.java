package com.onejune.service.impl;

import com.onejune.dao.ManagerDao;
import com.onejune.pojo.Manager;
import com.onejune.pojo.ManagerExample;
import com.onejune.service.ManagerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;

@Service("managerService")
@Transactional
public class ManagerServiceImpl implements ManagerService {
    private ManagerDao managerDao;

    @Autowired
    public void setManagerDao(ManagerDao managerDao) {
        this.managerDao = managerDao;
    }

    /**
     * 管理员登录
     * @param account 账号
     * @param password 密码
     * @return 结果
     */
    @Override
    public HashMap<String, Object> login(String account, String password) {
        HashMap<String,Object> hashMap=new HashMap<>();
        ManagerExample managerExample = new ManagerExample();
        managerExample.createCriteria().andAccountEqualTo(account);
        List<Manager> managers = managerDao.selectByExample(managerExample);
        managerExample.clear();
        if (managers.size() > 0) {
            Manager manager=managers.get(0);
            if(password.equals(manager.getPassword())){//登录成功
                hashMap.put("result", "success");//登录成功
                hashMap.put("manager",manager);
            }else {
                hashMap.put("result", "failed");//登录失败
            }
        }else {
            hashMap.put("result", "failed");//登录失败
        }
        return hashMap;
    }
}
