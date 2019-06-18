package com.onejune.pojo;

import java.io.Serializable;
import java.util.Date;

/**
 * smalltype
 * @author 
 */
public class Smalltype implements Serializable {
    private Integer id;

    /**
     * 大类id
     */
    private Integer bigid;

    /**
     * 小类名称
     */
    private String smallname;

    /**
     * 创建时间
     */
    private String createtime;

    public Smalltype() {
        super();
    }

    private static final long serialVersionUID = 1L;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getBigid() {
        return bigid;
    }

    public void setBigid(Integer bigid) {
        this.bigid = bigid;
    }

    public String getSmallname() {
        return smallname;
    }

    public void setSmallname(String smallname) {
        this.smallname = smallname;
    }

    public String getCreatetime() {
        return createtime;
    }

    public void setCreatetime(String createtime) {
        this.createtime = createtime;
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
        Smalltype other = (Smalltype) that;
        return (this.getId() == null ? other.getId() == null : this.getId().equals(other.getId()))
            && (this.getBigid() == null ? other.getBigid() == null : this.getBigid().equals(other.getBigid()))
            && (this.getSmallname() == null ? other.getSmallname() == null : this.getSmallname().equals(other.getSmallname()))
            && (this.getCreatetime() == null ? other.getCreatetime() == null : this.getCreatetime().equals(other.getCreatetime()));
    }

    @Override
    public int hashCode() {
        final int prime = 31;
        int result = 1;
        result = prime * result + ((getId() == null) ? 0 : getId().hashCode());
        result = prime * result + ((getBigid() == null) ? 0 : getBigid().hashCode());
        result = prime * result + ((getSmallname() == null) ? 0 : getSmallname().hashCode());
        result = prime * result + ((getCreatetime() == null) ? 0 : getCreatetime().hashCode());
        return result;
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append(getClass().getSimpleName());
        sb.append(" [");
        sb.append("Hash = ").append(hashCode());
        sb.append(", id=").append(id);
        sb.append(", bigid=").append(bigid);
        sb.append(", smallname=").append(smallname);
        sb.append(", createtime=").append(createtime);
        sb.append(", serialVersionUID=").append(serialVersionUID);
        sb.append("]");
        return sb.toString();
    }
}