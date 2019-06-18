package com.onejune.utils;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.TagSupport;
import java.util.ArrayList;
import java.util.List;

public class NavigationTag extends TagSupport {

    private static final long serialVersionUID = 1L;
    // 传参或指定
    private int num; // 当前页号, 采用自然数计数 1,2,3,...
    private int size; // 页面大小:一个页面显示多少个数据

    // 需要从数据库中查找出
    private long rowCount;// 数据总数：一共有多少个数据
    private List<?> list;

    // 可以根据上面属性：num,size,rowCount计算出
    private int pageCount; // 页面总数
    private int startRow;// 当前页面开始行, 第一行是0行
    private int first = 1;// 第一页 页号
    private int last;// 最后页 页号
    private int next;// 下一页 页号
    private int prev;// 前页 页号
    private int start;// 页号式导航, 起始页号
    private int end;// 页号式导航, 结束页号
    private int numCount = 10;// 页号式导航, 最多显示页号数量为numCount+1;这里显示11页。
    public List<String> showPages = new ArrayList<>(); //要显示的页号
    private Object queryClass;//保存查询条件
    private String queryUrl;

    public Object getQueryClass() {
        return queryClass;
    }

    public void setQueryClass(Object queryClass) {
        this.queryClass = queryClass;
    }

    public int getNum() {
        return num;
    }

    public void setNum(int num) {
        if (num <= 0) {
            this.num = 1;
        } else {
            this.num = num;
        }
    }

    public int getSize() {
        return size;
    }

    public void setSize(int size) {
        this.size = size;
    }

    public long getRowCount() {
        return rowCount;
    }

    public void setRowCount(long rowCount) {
        this.rowCount = rowCount;
    }

    public int getPageCount() {
        return pageCount;
    }

    public void setPageCount(int pageCount) {
        this.pageCount = pageCount;
    }

    public int getStartRow() {
        return startRow;
    }

    public void setStartRow(int startRow) {
        this.startRow = startRow;
    }

    public int getFirst() {
        return first;
    }

    public void setFirst(int first) {
        this.first = first;
    }

    public int getLast() {
        return last;
    }

    public void setLast(int last) {
        this.last = last;
    }

    public int getNext() {
        return next;
    }

    public void setNext(int next) {
        this.next = next;
    }

    public int getPrev() {
        return prev;
    }

    public void setPrev(int prev) {
        this.prev = prev;
    }

    public int getStart() {
        return start;
    }

    public void setStart(int start) {
        this.start = start;
    }

    public int getEnd() {
        return end;
    }

    public void setEnd(int end) {
        this.end = end;
    }

    public int getNumCount() {
        return numCount;
    }

    public void setNumCount(int numCount) {
        this.numCount = numCount;
    }


    public List<String> getShowPages() {
        return showPages;
    }

    public void setShowPages(List<String> showPages) {
        this.showPages = showPages;
    }

    public String getQueryUrl() {
        return queryUrl;
    }

    public void setQueryUrl(String queryUrl) {
        this.queryUrl = queryUrl;
    }

    @SuppressWarnings("rawtypes")
    public List getList() {
        return list;
    }

    @SuppressWarnings("rawtypes")
    public void setList(List list) {
        this.list = list;
    }

    public NavigationTag(int size, String str_num, long rowCount) {
        int num = 1;
        if (str_num != null) {
            num = Integer.parseInt(str_num);
        }
        this.num = num;
        this.size = size;
        this.rowCount = rowCount;

        this.pageCount = (int) Math.ceil((double) rowCount / size);
        this.num = Math.min(this.num, pageCount);
        this.num = Math.max(1, this.num);

        this.startRow = (this.num - 1) * size;
        this.last = this.pageCount;
        this.next = Math.min(this.pageCount, this.num + 1);
        this.prev = Math.max(1, this.num - 1);

        // 计算page 控制
        start = Math.max(this.num - numCount / 2, first);
        end = Math.min(start + numCount, last);
        if (end - start < numCount) {
            start = Math.max(end - numCount, 1);
        }
        for(int i = start; i <= end; i++){
            showPages.add(String.valueOf(i));
        }


    }

    public NavigationTag(int size, int num, long rowCount) {
        if (num <= 0) {
            num = 1;
        }
        this.num = num;
        this.size = size;
        this.rowCount = rowCount;

        this.pageCount = (int) Math.ceil((double) rowCount / size);
        this.num = Math.min(this.num, pageCount);
        this.num = Math.max(1, this.num);

        this.startRow = (this.num - 1) * size;
        this.last = this.pageCount;
        this.next = Math.min(this.pageCount, this.num + 1);
        this.prev = Math.max(1, this.num - 1);

        // 计算page 控制
        start = Math.max(this.num - numCount / 2, first);
        end = Math.min(start + numCount, last);
        if (end - start < numCount) {
            start = Math.max(end - numCount, 1);
        }
        for(int i = start; i <= end; i++){
            showPages.add(String.valueOf(i));
        }

    }

    public NavigationTag() {
    }
    public static void main(String[] args) {
        NavigationTag navigationTag = new NavigationTag(10, 1, 102);
        System.out.println(111);
    }

    @Override
    public int doStartTag() throws JspException {
        return super.doStartTag();
    }
}
