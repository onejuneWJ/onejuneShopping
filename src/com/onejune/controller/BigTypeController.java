package com.onejune.controller;

import com.onejune.pojo.Bigtype;
import com.onejune.service.BigTypeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
@RequestMapping("/bigType")
public class BigTypeController {

    private BigTypeService bigTypeService;

    @Autowired
    public void setBigTypeService(BigTypeService bigTypeService) {
        this.bigTypeService = bigTypeService;
    }

    @RequestMapping("findAllBigType")
    @ResponseBody
    public List<Bigtype> findAllBigType(){
        List<Bigtype> bigtypeList=bigTypeService.findAll();
        System.out.println(bigtypeList);
        return bigtypeList;
    }

}
