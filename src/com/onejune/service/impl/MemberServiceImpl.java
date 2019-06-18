package com.onejune.service.impl;

import com.onejune.dao.MemberDao;
import com.onejune.pojo.Member;
import com.onejune.pojo.MemberExample;
import com.onejune.service.MemberService;
import com.onejune.utils.StringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;

@Service("memberService")
@Transactional
public class MemberServiceImpl implements MemberService {

    private MemberDao memberDao;

    private MemberExample memberExample = new MemberExample();
    private StringUtil stringUtil = new StringUtil();

    @Autowired
    public void setMemberDao(MemberDao memberDao) {
        this.memberDao = memberDao;
    }

    /**
     * 登录
     *
     * @param loginName 登录名(会员名或者电话号码)
     * @param password  密码
     * @return 登录结果
     */
    @Override
    public HashMap<String, Object> login(String loginName, String password) {
        //判断登录名是否为手机号码
        if (loginName.length() == 11 && loginName.matches("^(13[0-9]|14[579]|15[0-3,5-9]|16[6]|17[0135678]|18[0-9]|19[89])\\d{8}$")) {
            memberExample.createCriteria().andTelEqualTo(loginName);//条件查询：where tel=loginName
            List<Member> memberList = memberDao.selectByExample(memberExample);
            memberExample.clear();
            return checkLogin(memberList, password);
        } else {//不是手机号登录
            memberExample.createCriteria().andNameEqualTo(loginName);//条件查询：where name=loginName
            List<Member> memberList = memberDao.selectByExample(memberExample);
            memberExample.clear();
            return checkLogin(memberList, password);
        }
    }

    /**
     * 判断登录
     *
     * @param memberList 根据手机号或者用户名查询出的用户列表（长度原则上为1或0）
     * @param password   登录密码
     * @return 结果
     */
    private HashMap<String, Object> checkLogin(List<Member> memberList, String password) {

        HashMap<String, Object> hashMap = new HashMap<>();
        if (memberList.size() > 0) {//存在，判断密码是否正确
            Member member = memberList.get(0);
            if (stringUtil.toMd5(password).equals(member.getPassword())) {//密码正确
                hashMap.put("result", "success");//登录成功
                hashMap.put("member", member);//返回登录会员信息
            } else {//密码错误
                hashMap.put("result", "failed");//登录失败
            }
        } else {
            hashMap.put("result", "failed");//登录失败
        }
        return hashMap;
    }


    /**
     * 判断手机号是否重复的方法
     *
     * @param phone 手机号
     * @return 判断结果
     */
    @Override
    public String checkPhone(String phone) {
        memberExample.createCriteria().andTelEqualTo(phone);
        List<Member> memberList = memberDao.selectByExample(memberExample);
        memberExample.clear();
        if (memberList.size() > 0) {//根据此号码查询到了会员，表明重复
            System.out.println("repeat");
            return "repeat";
        } else {
            System.out.println("not repeat");
            return "not repeat";
        }
    }

    /**
     * 判断会员名是否重复,是否符合规范
     *
     * @param name 会员名
     * @return 判断结果
     */
    @Override
    public String checkName(String name) {
        String vname = stringUtil.trim(name);//去掉name中的空格

        if (vname.length() < 3) { //长度小于三
            return "illegal";
        }

        memberExample.createCriteria().andNameEqualTo(vname);
        List<Member> memberList = memberDao.selectByExample(memberExample);
        memberExample.clear();
        if (memberList.size() > 0) {
            return "repeat";
        } else {
            return "not repeat";
        }
    }

    /**
     * 根据条件查询会员
     *
     * @param condition 条件
     * @return 查询结果
     */
    @Override
    public List<Member> findByCondition(String condition) {
        if (condition != null && !condition.equals("")) {
            memberExample.or().andNameLike(condition);
            memberExample.or().andTelLike(condition);
            memberExample.or().andGenderLike(condition);
            memberExample.or().andEmailLike(condition);
            memberExample.or().andReallynameLike(condition);
        }
        List<Member> memberList = memberDao.selectByExample(memberExample);
        memberExample.clear();
        return memberList;
    }

    /**
     * 注册
     *
     * @param member 注册会员
     * @return 注册结果
     */
    @Override
    public String register(Member member) {
        member.setId(stringUtil.getUUIDInt());//设置用户ID
        member.setName(stringUtil.trim(member.getName()));//用户名去空格
        member.setPassword(stringUtil.toMd5(member.getPassword()));//密码MD5加密
        if (memberDao.insertSelective(member) > 0) {
            return "success";
        } else {
            return "failed";
        }
    }

    /**
     * 删除会员
     *
     * @param id 会员id
     * @return 删除结果
     */
    @Override
    public String deleteById(Integer id) {
        if (memberDao.deleteByPrimaryKey(id) > 0) {
            return "success";
        } else {
            return "failed";
        }
    }

    /**
     * 头像上传
     *
     * @param commonsMultipartFile 头像文件
     * @param memberID             会员id
     * @param path                 项目路径
     * @return 上传结果
     */
    @Override
    public HashMap<String, Object> uploadAvatar(CommonsMultipartFile commonsMultipartFile, Integer memberID, String path) {

        HashMap<String, Object> map = new HashMap<>();

        System.out.println("路径:" + path);
        String fileName = commonsMultipartFile.getOriginalFilename();//获取文件名
        System.out.println("文件名:" + fileName);
        fileName = stringUtil.getUUIDStr() + stringUtil.getFileSuffix(fileName);//以uuid的形式重命名该文件
        System.out.println("文件名:" + fileName);
        path += "member/" + fileName;//文件储存路径
        System.out.println("路径:" + path);
        File newFile = new File(path);
        //如果文件路径不存在，就创建目录
        if (!newFile.exists()) {
            newFile.mkdirs();
        }

        try {
            commonsMultipartFile.transferTo(newFile);
            Member member = new Member();
            member.setId(memberID);
            member.setAvatar("/onejuneShopping/img/member/" + fileName);
            if (memberDao.updateByPrimaryKeySelective(member) > 0) {
                Member member1 = memberDao.selectByPrimaryKey(member.getId());
                map.put("result", "success");
                map.put("member", member1);
            } else {
                map.put("result", "failed");
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return map;
    }

    /**
     * 修改用户信息
     *
     * @param member 用户
     * @return
     */
    @Override
    public HashMap<String, Object> update(Member member) {
        HashMap<String, Object> map = new HashMap<>();
        System.out.println(member.getPassword());
        //修改信息时，密码可能为"",把他设为null，不然会出错
        if (member.getPassword().equals("")) {
            member.setPassword(null);
        } else {
            member.setPassword(stringUtil.toMd5(member.getPassword()));
        }
        if (memberDao.updateByPrimaryKeySelective(member) > 0) {
            Member member1 = memberDao.selectByPrimaryKey(member.getId());
            map.put("result", "success");
            map.put("member", member1);
        }
        return map;
    }

    /**
     * 判断原始密码是否正确
     * @param password
     * @param id
     * @return
     */
    @Override
    public String checkPassword(String password, Integer id) {
        Member member = memberDao.selectByPrimaryKey(id);
        System.out.println(member.getPassword());
        if (member.getPassword().equals(stringUtil.toMd5(password))) {
            return "success";
        } else {
            return "failed";
        }
    }
}
