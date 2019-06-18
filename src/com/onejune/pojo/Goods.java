package com.onejune.pojo;

import java.io.Serializable;
import java.util.Date;

/**
 * goods
 * @author 
 */
public class Goods implements Serializable {
    /**
     * 产品id UUID
     */
    private Integer id;

    /**
     * 大类别
     */
    private Integer bigtype;

    /**
     * 小类别
     */
    private Integer smalltype;

    /**
     * 生产厂商
     */
    private String goodfrom;

    /**
     * 商品介绍
     */
    private String name;

    /**
     * 商品添加时间
     */
    private String createtime;

    /**
     * 现价
     */
    private Float price;

    /**
     * 购买次数
     */
    private Integer buytimes;

    /**
     * 商品图片
     */
    private String img;

    private static final long serialVersionUID = 1L;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getBigtype() {
        return bigtype;
    }

    public void setBigtype(Integer bigtype) {
        this.bigtype = bigtype;
    }

    public Integer getSmalltype() {
        return smalltype;
    }

    public void setSmalltype(Integer smalltype) {
        this.smalltype = smalltype;
    }

    public String getGoodfrom() {
        return goodfrom;
    }

    public void setGoodfrom(String goodfrom) {
        this.goodfrom = goodfrom;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getCreatetime() {
        return createtime;
    }

    public void setCreatetime(String createtime) {
        this.createtime = createtime;
    }

    public Float getPrice() {
        return price;
    }

    public void setPrice(Float price) {
        this.price = price;
    }

    public Integer getBuytimes() {
        return buytimes;
    }

    public void setBuytimes(Integer buytimes) {
        this.buytimes = buytimes;
    }

    public String getImg() {
        return img;
    }

    public void setImg(String img) {
        this.img = img;
    }

    @Override
    public boolean equals(Object that) {
        if (this == that) {
            return true;
        }
        if (that == null) {
            return false;
        }
        if (getClass() != that.getClass()) {
            return false;
        }
        Goods other = (Goods) that;
        return (this.getId() == null ? other.getId() == null : this.getId().equals(other.getId()))
            && (this.getBigtype() == null ? other.getBigtype() == null : this.getBigtype().equals(other.getBigtype()))
            && (this.getSmalltype() == null ? other.getSmalltype() == null : this.getSmalltype().equals(other.getSmalltype()))
            && (this.getGoodfrom() == null ? other.getGoodfrom() == null : this.getGoodfrom().equals(other.getGoodfrom()))
            && (this.getName() == null ? other.getName() == null : this.getName().equals(other.getName()))
            && (this.getCreatetime() == null ? other.getCreatetime() == null : this.getCreatetime().equals(other.getCreatetime()))
            && (this.getPrice() == null ? other.getPrice() == null : this.getPrice().equals(other.getPrice()))
            && (this.getBuytimes() == null ? other.getBuytimes() == null : this.getBuytimes().equals(other.getBuytimes()))
            && (this.getImg() == null ? other.getImg() == null : this.getImg().equals(other.getImg()));
    }

    @Override
    public int hashCode() {
        final int prime = 31;
        int result = 1;
        result = prime * result + ((getId() == null) ? 0 : getId().hashCode());
        result = prime * result + ((getBigtype() == null) ? 0 : getBigtype().hashCode());
        result = prime * result + ((getSmalltype() == null) ? 0 : getSmalltype().hashCode());
        result = prime * result + ((getGoodfrom() == null) ? 0 : getGoodfrom().hashCode());
        result = prime * result + ((getName() == null) ? 0 : getName().hashCode());
        result = prime * result + ((getCreatetime() == null) ? 0 : getCreatetime().hashCode());
        result = prime * result + ((getPrice() == null) ? 0 : getPrice().hashCode());
        result = prime * result + ((getBuytimes() == null) ? 0 : getBuytimes().hashCode());
        result = prime * result + ((getImg() == null) ? 0 : getImg().hashCode());
        return result;
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append(getClass().getSimpleName());
        sb.append(" [");
        sb.append("Hash = ").append(hashCode());
        sb.append(", id=").append(id);
        sb.append(", bigtype=").append(bigtype);
        sb.append(", smalltype=").append(smalltype);
        sb.append(", goodfrom=").append(goodfrom);
        sb.append(", name=").append(name);
        sb.append(", createtime=").append(createtime);
        sb.append(", price=").append(price);
        sb.append(", buytimes=").append(buytimes);
        sb.append(", img=").append(img);
        sb.append(", serialVersionUID=").append(serialVersionUID);
        sb.append("]");
        return sb.toString();
    }
}