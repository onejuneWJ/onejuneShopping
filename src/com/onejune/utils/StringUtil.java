package com.onejune.utils;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;

import org.apache.commons.codec.digest.DigestUtils;

public class StringUtil {
    public StringUtil() {

    }

    /**
     * @param pass 需要加密的字符串
     * @return 加密后的字符串
     */
    public String toMd5(String pass) {
        return DigestUtils.md5Hex(pass);
    }

    /**
     * 去除字符串所有的空格
     *
     * @param str 需要去除空格的字符串
     * @return 去除空格后的字符串
     */
    public String trim(String str) {
        String s = "";
        for (int i = 0; i < str.length(); i++) {
            String a = String.valueOf(str.charAt(i));
            if (!a.equals(" ")) {
                s += a;
            }
        }
        return s;
    }

    /**
     * @return 返回String类型的 UUID
     */
    public String getUUIDStr() {
        return UUID.randomUUID().toString().replace("-", "");
    }

    /**
     * @return 返回int类型的 UUID
     */
    public int getUUIDInt() {
        String uuidStr = UUID.randomUUID().toString().replace("-", "");
        return uuidStr.hashCode() > 0 ? uuidStr.hashCode() : -uuidStr.hashCode();
    }

    /**
     * @return 返回当前时间字符串
     */
    public String getTime() {
        Date date = new Date();
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        return simpleDateFormat.format(date);
    }

    /**
     * 把yyyy-MM-dd hh:mm:ss格式时间转化为yyyy年MM月dd日 hh:mm
     *
     * @param date 需要转换的时间字符串
     * @return 转换后的时间字符串
     */
    public String changeStrTime(String date) {
        String str = date.substring(0, date.lastIndexOf(":"));//除掉秒
        String year = str.substring(0, str.indexOf("-"));//截取年
        String month = str.substring(5, 7);//截取月
        String day = str.substring(8, 10);//截取日
        String time = str.substring(11);//截取时分
        return year + "年" + month + "月" + day + "日 " + time;//拼接时间
    }

    /**
     * @return 返回根据当前时间生成的随机订单编号
     */
    public String getNumber() {
        Date date = new Date();
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyyMMddhhmmss");
        String dateStr = simpleDateFormat.format(date);
        String randomStr = String.valueOf((int) (((Math.random() * 9) + 1) * 1000));//生成随机四位字符串
        return dateStr + randomStr;//在时间字符串后面再添加四位随机数
    }

    public String getFileSuffix(String fileName) {
        return fileName.substring(fileName.lastIndexOf("."));
    }
}
