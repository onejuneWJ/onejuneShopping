package com.onejune.test;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.onejune.dao.GoodsDao;
import com.onejune.pojo.Goods;
import com.onejune.utils.StringUtil;
import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import java.io.FileReader;
import java.io.IOException;
import java.io.InputStream;

public class AddGoods1 {
    public static void main(String[] args) {
        StringUtil stringUtil = new StringUtil();
        JsonParser jsonParser = new JsonParser(); //创建json解析器

        try {

            JsonObject json = (JsonObject) jsonParser.parse(new FileReader("web/file/shouji.json"));
            JsonArray auctions = json.get("auctions").getAsJsonArray();//商品列表
            int rows = 0;
            for (int i = 1; i < auctions.size(); i++) {
                System.out.println("-----------------");
                Goods _goods = new Goods();
                JsonObject goods = auctions.get(i).getAsJsonObject();//单个商品

                JsonArray tag_info = goods.get("tag_info").getAsJsonArray();// tag_info 功能

                String tags = ""; //手机功能 添加在商品名称后面
                for (int j = 0; j < tag_info.size(); j++) {
                    JsonObject tag = tag_info.get(j).getAsJsonObject();
                    String tagStr = tag.get("tag").getAsString();
                    tags = tags + tagStr;
                }
                System.out.println(tags);
                String title = goods.get("title").getAsString();//商品标题
                System.out.println(title + " " + tags);
                String img = goods.get("pic_url").getAsString();//商品图片
                Float price = goods.get("price").getAsFloat();//商品价格
                // String from = goods.get("item_loc").getAsString();//商品产地
                _goods.setId(stringUtil.getUUIDInt());
                _goods.setBigtype(4);//大类别
                _goods.setSmalltype(1317253761);//小类别
                _goods.setCreatetime(stringUtil.getTime());
                _goods.setName(title + " " + tags);
                _goods.setGoodfrom("广东深圳");
                _goods.setPrice(price);
                _goods.setImg(img);
//
//                if (goodsDao.insertSelective(_goods) > 0) {
//                    rows++;
//                }
                System.out.println(_goods);
            }
            System.out.println("总共有" + auctions.size() + "个商品");
            System.out.println("成功插入了" + rows + "个商品");
//            sqlSession.commit();
//            sqlSession.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
