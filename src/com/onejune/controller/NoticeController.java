package com.onejune.controller;

import com.onejune.pojo.Notice;
import com.onejune.service.NoticeService;
import com.onejune.utils.StringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
@RequestMapping("/notice")
public class NoticeController {

    private StringUtil stringUtil = new StringUtil();
    private NoticeService noticeService;

    @Autowired
    private void setNoticeService(NoticeService noticeService) {
        this.noticeService = noticeService;
    }

    /**
     * 显示所有公告
     */
    @RequestMapping("/showNotice")
    @ResponseBody
    public List<Notice> showNotice() {
        List<Notice> noticeList = noticeService.findAllNotice();
        for (Notice notice : noticeList) {
            notice.setIssuetime(stringUtil.changeStrTime(notice.getIssuetime()));
        }
        return noticeList;
    }

    /**
     * 查询所有公告
     *
     * @param model model里加入所有公告列表
     * @return notice页面
     */
    @RequestMapping("/allNotice")
    public String AllNotice(Model model) {
        List<Notice> noticeList = noticeService.findAllNotice();
        model.addAttribute("noticeList", noticeList);
        return "admin/notice";
    }

    @RequestMapping(value = "/findById/{id}",method = RequestMethod.GET)
    @ResponseBody
    public Notice findById(@PathVariable Integer id){
        return noticeService.findById(id);
    }

    /**
     * 发布公告
     *
     * @param notice 公告
     * @return 结果
     */
    @RequestMapping("/newNotice")
    @ResponseBody
    public String newNotice(Notice notice) {
        return noticeService.addNotice(notice);
    }

    /**
     * @param ids 所有需要删除的公告id
     * @return 删除结果
     */
    @RequestMapping("/deleteNotice")
    @ResponseBody
    public String deleteManyNotice(Integer[] ids) {
        return noticeService.deleteNotice(ids);
    }

    /**
     * 修改（重新发布）公告
     * @param notice 需要修改的公告
     * @return 结果
     */
    @RequestMapping("/updateNotice")
    @ResponseBody
    public String updateNotice(Notice notice){
        return noticeService.updateNotice(notice);
    }
}
