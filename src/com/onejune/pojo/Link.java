package com.onejune.pojo;

import java.io.Serializable;

/**
 * link
 * @author 
 */
public class Link implements Serializable {
    private Integer id;

    /**
     * 链接名称
     */
    private String linkname;

    /**
     * 链接地址
     */
    private String linkaddress;

    private static final long serialVersionUID = 1L;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getLinkname() {
        return linkname;
    }

    public void setLinkname(String linkname) {
        this.linkname = linkname;
    }

    public String getLinkaddress() {
        return linkaddress;
    }

    public void setLinkaddress(String linkaddress) {
        this.linkaddress = linkaddress;
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
        Link other = (Link) that;
        return (this.getId() == null ? other.getId() == null : this.getId().equals(other.getId()))
            && (this.getLinkname() == null ? other.getLinkname() == null : this.getLinkname().equals(other.getLinkname()))
            && (this.getLinkaddress() == null ? other.getLinkaddress() == null : this.getLinkaddress().equals(other.getLinkaddress()));
    }

    @Override
    public int hashCode() {
        final int prime = 31;
        int result = 1;
        result = prime * result + ((getId() == null) ? 0 : getId().hashCode());
        result = prime * result + ((getLinkname() == null) ? 0 : getLinkname().hashCode());
        result = prime * result + ((getLinkaddress() == null) ? 0 : getLinkaddress().hashCode());
        return result;
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append(getClass().getSimpleName());
        sb.append(" [");
        sb.append("Hash = ").append(hashCode());
        sb.append(", id=").append(id);
        sb.append(", linkname=").append(linkname);
        sb.append(", linkaddress=").append(linkaddress);
        sb.append(", serialVersionUID=").append(serialVersionUID);
        sb.append("]");
        return sb.toString();
    }
}