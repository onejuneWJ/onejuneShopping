package com.onejune.pojo;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class GoodsExample {
    protected String orderByClause;

    protected boolean distinct;

    protected List<Criteria> oredCriteria;

    private Integer limit;

    private Long offset;

    public GoodsExample() {
        oredCriteria = new ArrayList<Criteria>();
    }

    public void setOrderByClause(String orderByClause) {
        this.orderByClause = orderByClause;
    }

    public String getOrderByClause() {
        return orderByClause;
    }

    public void setDistinct(boolean distinct) {
        this.distinct = distinct;
    }

    public boolean isDistinct() {
        return distinct;
    }

    public List<Criteria> getOredCriteria() {
        return oredCriteria;
    }

    public void or(Criteria criteria) {
        oredCriteria.add(criteria);
    }

    public Criteria or() {
        Criteria criteria = createCriteriaInternal();
        oredCriteria.add(criteria);
        return criteria;
    }

    public Criteria createCriteria() {
        Criteria criteria = createCriteriaInternal();
        if (oredCriteria.size() == 0) {
            oredCriteria.add(criteria);
        }
        return criteria;
    }

    protected Criteria createCriteriaInternal() {
        Criteria criteria = new Criteria();
        return criteria;
    }

    public void clear() {
        oredCriteria.clear();
        orderByClause = null;
        distinct = false;
    }

    public void setLimit(Integer limit) {
        this.limit = limit;
    }

    public Integer getLimit() {
        return limit;
    }

    public void setOffset(Long offset) {
        this.offset = offset;
    }

    public Long getOffset() {
        return offset;
    }

    protected abstract static class GeneratedCriteria {
        protected List<Criterion> criteria;

        protected GeneratedCriteria() {
            super();
            criteria = new ArrayList<Criterion>();
        }

        public boolean isValid() {
            return criteria.size() > 0;
        }

        public List<Criterion> getAllCriteria() {
            return criteria;
        }

        public List<Criterion> getCriteria() {
            return criteria;
        }

        protected void addCriterion(String condition) {
            if (condition == null) {
                throw new RuntimeException("Value for condition cannot be null");
            }
            criteria.add(new Criterion(condition));
        }

        protected void addCriterion(String condition, Object value, String property) {
            if (value == null) {
                throw new RuntimeException("Value for " + property + " cannot be null");
            }
            criteria.add(new Criterion(condition, value));
        }

        protected void addCriterion(String condition, Object value1, Object value2, String property) {
            if (value1 == null || value2 == null) {
                throw new RuntimeException("Between values for " + property + " cannot be null");
            }
            criteria.add(new Criterion(condition, value1, value2));
        }

        public Criteria andIdIsNull() {
            addCriterion("id is null");
            return (Criteria) this;
        }

        public Criteria andIdIsNotNull() {
            addCriterion("id is not null");
            return (Criteria) this;
        }

        public Criteria andIdEqualTo(Integer value) {
            addCriterion("id =", value, "id");
            return (Criteria) this;
        }

        public Criteria andIdNotEqualTo(Integer value) {
            addCriterion("id <>", value, "id");
            return (Criteria) this;
        }

        public Criteria andIdGreaterThan(Integer value) {
            addCriterion("id >", value, "id");
            return (Criteria) this;
        }

        public Criteria andIdGreaterThanOrEqualTo(Integer value) {
            addCriterion("id >=", value, "id");
            return (Criteria) this;
        }

        public Criteria andIdLessThan(Integer value) {
            addCriterion("id <", value, "id");
            return (Criteria) this;
        }

        public Criteria andIdLessThanOrEqualTo(Integer value) {
            addCriterion("id <=", value, "id");
            return (Criteria) this;
        }

        public Criteria andIdIn(List<Integer> values) {
            addCriterion("id in", values, "id");
            return (Criteria) this;
        }

        public Criteria andIdNotIn(List<Integer> values) {
            addCriterion("id not in", values, "id");
            return (Criteria) this;
        }

        public Criteria andIdBetween(Integer value1, Integer value2) {
            addCriterion("id between", value1, value2, "id");
            return (Criteria) this;
        }

        public Criteria andIdNotBetween(Integer value1, Integer value2) {
            addCriterion("id not between", value1, value2, "id");
            return (Criteria) this;
        }

        public Criteria andBigtypeIsNull() {
            addCriterion("bigType is null");
            return (Criteria) this;
        }

        public Criteria andBigtypeIsNotNull() {
            addCriterion("bigType is not null");
            return (Criteria) this;
        }

        public Criteria andBigtypeEqualTo(Integer value) {
            addCriterion("bigType =", value, "bigtype");
            return (Criteria) this;
        }

        public Criteria andBigtypeNotEqualTo(Integer value) {
            addCriterion("bigType <>", value, "bigtype");
            return (Criteria) this;
        }

        public Criteria andBigtypeGreaterThan(Integer value) {
            addCriterion("bigType >", value, "bigtype");
            return (Criteria) this;
        }

        public Criteria andBigtypeGreaterThanOrEqualTo(Integer value) {
            addCriterion("bigType >=", value, "bigtype");
            return (Criteria) this;
        }

        public Criteria andBigtypeLessThan(Integer value) {
            addCriterion("bigType <", value, "bigtype");
            return (Criteria) this;
        }

        public Criteria andBigtypeLessThanOrEqualTo(Integer value) {
            addCriterion("bigType <=", value, "bigtype");
            return (Criteria) this;
        }

        public Criteria andBigtypeIn(List<Integer> values) {
            addCriterion("bigType in", values, "bigtype");
            return (Criteria) this;
        }

        public Criteria andBigtypeNotIn(List<Integer> values) {
            addCriterion("bigType not in", values, "bigtype");
            return (Criteria) this;
        }

        public Criteria andBigtypeBetween(Integer value1, Integer value2) {
            addCriterion("bigType between", value1, value2, "bigtype");
            return (Criteria) this;
        }

        public Criteria andBigtypeNotBetween(Integer value1, Integer value2) {
            addCriterion("bigType not between", value1, value2, "bigtype");
            return (Criteria) this;
        }

        public Criteria andSmalltypeIsNull() {
            addCriterion("smallType is null");
            return (Criteria) this;
        }

        public Criteria andSmalltypeIsNotNull() {
            addCriterion("smallType is not null");
            return (Criteria) this;
        }

        public Criteria andSmalltypeEqualTo(Integer value) {
            addCriterion("smallType =", value, "smalltype");
            return (Criteria) this;
        }

        public Criteria andSmalltypeNotEqualTo(Integer value) {
            addCriterion("smallType <>", value, "smalltype");
            return (Criteria) this;
        }

        public Criteria andSmalltypeGreaterThan(Integer value) {
            addCriterion("smallType >", value, "smalltype");
            return (Criteria) this;
        }

        public Criteria andSmalltypeGreaterThanOrEqualTo(Integer value) {
            addCriterion("smallType >=", value, "smalltype");
            return (Criteria) this;
        }

        public Criteria andSmalltypeLessThan(Integer value) {
            addCriterion("smallType <", value, "smalltype");
            return (Criteria) this;
        }

        public Criteria andSmalltypeLessThanOrEqualTo(Integer value) {
            addCriterion("smallType <=", value, "smalltype");
            return (Criteria) this;
        }

        public Criteria andSmalltypeIn(List<Integer> values) {
            addCriterion("smallType in", values, "smalltype");
            return (Criteria) this;
        }

        public Criteria andSmalltypeNotIn(List<Integer> values) {
            addCriterion("smallType not in", values, "smalltype");
            return (Criteria) this;
        }

        public Criteria andSmalltypeBetween(Integer value1, Integer value2) {
            addCriterion("smallType between", value1, value2, "smalltype");
            return (Criteria) this;
        }

        public Criteria andSmalltypeNotBetween(Integer value1, Integer value2) {
            addCriterion("smallType not between", value1, value2, "smalltype");
            return (Criteria) this;
        }

        public Criteria andGoodfromIsNull() {
            addCriterion("goodFrom is null");
            return (Criteria) this;
        }

        public Criteria andGoodfromIsNotNull() {
            addCriterion("goodFrom is not null");
            return (Criteria) this;
        }

        public Criteria andGoodfromEqualTo(String value) {
            addCriterion("goodFrom =", value, "goodfrom");
            return (Criteria) this;
        }

        public Criteria andGoodfromNotEqualTo(String value) {
            addCriterion("goodFrom <>", value, "goodfrom");
            return (Criteria) this;
        }

        public Criteria andGoodfromGreaterThan(String value) {
            addCriterion("goodFrom >", value, "goodfrom");
            return (Criteria) this;
        }

        public Criteria andGoodfromGreaterThanOrEqualTo(String value) {
            addCriterion("goodFrom >=", value, "goodfrom");
            return (Criteria) this;
        }

        public Criteria andGoodfromLessThan(String value) {
            addCriterion("goodFrom <", value, "goodfrom");
            return (Criteria) this;
        }

        public Criteria andGoodfromLessThanOrEqualTo(String value) {
            addCriterion("goodFrom <=", value, "goodfrom");
            return (Criteria) this;
        }

        public Criteria andGoodfromLike(String value) {
            addCriterion("goodFrom like", value, "goodfrom");
            return (Criteria) this;
        }

        public Criteria andGoodfromNotLike(String value) {
            addCriterion("goodFrom not like", value, "goodfrom");
            return (Criteria) this;
        }

        public Criteria andGoodfromIn(List<String> values) {
            addCriterion("goodFrom in", values, "goodfrom");
            return (Criteria) this;
        }

        public Criteria andGoodfromNotIn(List<String> values) {
            addCriterion("goodFrom not in", values, "goodfrom");
            return (Criteria) this;
        }

        public Criteria andGoodfromBetween(String value1, String value2) {
            addCriterion("goodFrom between", value1, value2, "goodfrom");
            return (Criteria) this;
        }

        public Criteria andGoodfromNotBetween(String value1, String value2) {
            addCriterion("goodFrom not between", value1, value2, "goodfrom");
            return (Criteria) this;
        }

        public Criteria andNameIsNull() {
            addCriterion("`name` is null");
            return (Criteria) this;
        }

        public Criteria andNameIsNotNull() {
            addCriterion("`name` is not null");
            return (Criteria) this;
        }

        public Criteria andNameEqualTo(String value) {
            addCriterion("`name` =", value, "name");
            return (Criteria) this;
        }

        public Criteria andNameNotEqualTo(String value) {
            addCriterion("`name` <>", value, "name");
            return (Criteria) this;
        }

        public Criteria andNameGreaterThan(String value) {
            addCriterion("`name` >", value, "name");
            return (Criteria) this;
        }

        public Criteria andNameGreaterThanOrEqualTo(String value) {
            addCriterion("`name` >=", value, "name");
            return (Criteria) this;
        }

        public Criteria andNameLessThan(String value) {
            addCriterion("`name` <", value, "name");
            return (Criteria) this;
        }

        public Criteria andNameLessThanOrEqualTo(String value) {
            addCriterion("`name` <=", value, "name");
            return (Criteria) this;
        }

        public Criteria andNameLike(String value) {
            addCriterion("`name` like", value, "name");
            return (Criteria) this;
        }

        public Criteria andNameNotLike(String value) {
            addCriterion("`name` not like", value, "name");
            return (Criteria) this;
        }

        public Criteria andNameIn(List<String> values) {
            addCriterion("`name` in", values, "name");
            return (Criteria) this;
        }

        public Criteria andNameNotIn(List<String> values) {
            addCriterion("`name` not in", values, "name");
            return (Criteria) this;
        }

        public Criteria andNameBetween(String value1, String value2) {
            addCriterion("`name` between", value1, value2, "name");
            return (Criteria) this;
        }

        public Criteria andNameNotBetween(String value1, String value2) {
            addCriterion("`name` not between", value1, value2, "name");
            return (Criteria) this;
        }

        public Criteria andCreatetimeIsNull() {
            addCriterion("createTime is null");
            return (Criteria) this;
        }

        public Criteria andCreatetimeIsNotNull() {
            addCriterion("createTime is not null");
            return (Criteria) this;
        }

        public Criteria andCreatetimeEqualTo(Date value) {
            addCriterion("createTime =", value, "createtime");
            return (Criteria) this;
        }

        public Criteria andCreatetimeNotEqualTo(Date value) {
            addCriterion("createTime <>", value, "createtime");
            return (Criteria) this;
        }

        public Criteria andCreatetimeGreaterThan(Date value) {
            addCriterion("createTime >", value, "createtime");
            return (Criteria) this;
        }

        public Criteria andCreatetimeGreaterThanOrEqualTo(Date value) {
            addCriterion("createTime >=", value, "createtime");
            return (Criteria) this;
        }

        public Criteria andCreatetimeLessThan(Date value) {
            addCriterion("createTime <", value, "createtime");
            return (Criteria) this;
        }

        public Criteria andCreatetimeLessThanOrEqualTo(Date value) {
            addCriterion("createTime <=", value, "createtime");
            return (Criteria) this;
        }

        public Criteria andCreatetimeIn(List<Date> values) {
            addCriterion("createTime in", values, "createtime");
            return (Criteria) this;
        }

        public Criteria andCreatetimeNotIn(List<Date> values) {
            addCriterion("createTime not in", values, "createtime");
            return (Criteria) this;
        }

        public Criteria andCreatetimeBetween(Date value1, Date value2) {
            addCriterion("createTime between", value1, value2, "createtime");
            return (Criteria) this;
        }

        public Criteria andCreatetimeNotBetween(Date value1, Date value2) {
            addCriterion("createTime not between", value1, value2, "createtime");
            return (Criteria) this;
        }

        public Criteria andPriceIsNull() {
            addCriterion("Price is null");
            return (Criteria) this;
        }

        public Criteria andPriceIsNotNull() {
            addCriterion("Price is not null");
            return (Criteria) this;
        }

        public Criteria andPriceEqualTo(Float value) {
            addCriterion("Price =", value, "price");
            return (Criteria) this;
        }

        public Criteria andPriceNotEqualTo(Float value) {
            addCriterion("Price <>", value, "price");
            return (Criteria) this;
        }

        public Criteria andPriceGreaterThan(Float value) {
            addCriterion("Price >", value, "price");
            return (Criteria) this;
        }

        public Criteria andPriceGreaterThanOrEqualTo(Float value) {
            addCriterion("Price >=", value, "price");
            return (Criteria) this;
        }

        public Criteria andPriceLessThan(Float value) {
            addCriterion("Price <", value, "price");
            return (Criteria) this;
        }

        public Criteria andPriceLessThanOrEqualTo(Float value) {
            addCriterion("Price <=", value, "price");
            return (Criteria) this;
        }

        public Criteria andPriceIn(List<Float> values) {
            addCriterion("Price in", values, "price");
            return (Criteria) this;
        }

        public Criteria andPriceNotIn(List<Float> values) {
            addCriterion("Price not in", values, "price");
            return (Criteria) this;
        }

        public Criteria andPriceBetween(Float value1, Float value2) {
            addCriterion("Price between", value1, value2, "price");
            return (Criteria) this;
        }

        public Criteria andPriceNotBetween(Float value1, Float value2) {
            addCriterion("Price not between", value1, value2, "price");
            return (Criteria) this;
        }

        public Criteria andBuytimesIsNull() {
            addCriterion("buyTimes is null");
            return (Criteria) this;
        }

        public Criteria andBuytimesIsNotNull() {
            addCriterion("buyTimes is not null");
            return (Criteria) this;
        }

        public Criteria andBuytimesEqualTo(Integer value) {
            addCriterion("buyTimes =", value, "buytimes");
            return (Criteria) this;
        }

        public Criteria andBuytimesNotEqualTo(Integer value) {
            addCriterion("buyTimes <>", value, "buytimes");
            return (Criteria) this;
        }

        public Criteria andBuytimesGreaterThan(Integer value) {
            addCriterion("buyTimes >", value, "buytimes");
            return (Criteria) this;
        }

        public Criteria andBuytimesGreaterThanOrEqualTo(Integer value) {
            addCriterion("buyTimes >=", value, "buytimes");
            return (Criteria) this;
        }

        public Criteria andBuytimesLessThan(Integer value) {
            addCriterion("buyTimes <", value, "buytimes");
            return (Criteria) this;
        }

        public Criteria andBuytimesLessThanOrEqualTo(Integer value) {
            addCriterion("buyTimes <=", value, "buytimes");
            return (Criteria) this;
        }

        public Criteria andBuytimesIn(List<Integer> values) {
            addCriterion("buyTimes in", values, "buytimes");
            return (Criteria) this;
        }

        public Criteria andBuytimesNotIn(List<Integer> values) {
            addCriterion("buyTimes not in", values, "buytimes");
            return (Criteria) this;
        }

        public Criteria andBuytimesBetween(Integer value1, Integer value2) {
            addCriterion("buyTimes between", value1, value2, "buytimes");
            return (Criteria) this;
        }

        public Criteria andBuytimesNotBetween(Integer value1, Integer value2) {
            addCriterion("buyTimes not between", value1, value2, "buytimes");
            return (Criteria) this;
        }

        public Criteria andImgIsNull() {
            addCriterion("img is null");
            return (Criteria) this;
        }

        public Criteria andImgIsNotNull() {
            addCriterion("img is not null");
            return (Criteria) this;
        }

        public Criteria andImgEqualTo(String value) {
            addCriterion("img =", value, "img");
            return (Criteria) this;
        }

        public Criteria andImgNotEqualTo(String value) {
            addCriterion("img <>", value, "img");
            return (Criteria) this;
        }

        public Criteria andImgGreaterThan(String value) {
            addCriterion("img >", value, "img");
            return (Criteria) this;
        }

        public Criteria andImgGreaterThanOrEqualTo(String value) {
            addCriterion("img >=", value, "img");
            return (Criteria) this;
        }

        public Criteria andImgLessThan(String value) {
            addCriterion("img <", value, "img");
            return (Criteria) this;
        }

        public Criteria andImgLessThanOrEqualTo(String value) {
            addCriterion("img <=", value, "img");
            return (Criteria) this;
        }

        public Criteria andImgLike(String value) {
            addCriterion("img like", value, "img");
            return (Criteria) this;
        }

        public Criteria andImgNotLike(String value) {
            addCriterion("img not like", value, "img");
            return (Criteria) this;
        }

        public Criteria andImgIn(List<String> values) {
            addCriterion("img in", values, "img");
            return (Criteria) this;
        }

        public Criteria andImgNotIn(List<String> values) {
            addCriterion("img not in", values, "img");
            return (Criteria) this;
        }

        public Criteria andImgBetween(String value1, String value2) {
            addCriterion("img between", value1, value2, "img");
            return (Criteria) this;
        }

        public Criteria andImgNotBetween(String value1, String value2) {
            addCriterion("img not between", value1, value2, "img");
            return (Criteria) this;
        }
    }

    /**
     */
    public static class Criteria extends GeneratedCriteria {

        protected Criteria() {
            super();
        }
    }

    public static class Criterion {
        private String condition;

        private Object value;

        private Object secondValue;

        private boolean noValue;

        private boolean singleValue;

        private boolean betweenValue;

        private boolean listValue;

        private String typeHandler;

        public String getCondition() {
            return condition;
        }

        public Object getValue() {
            return value;
        }

        public Object getSecondValue() {
            return secondValue;
        }

        public boolean isNoValue() {
            return noValue;
        }

        public boolean isSingleValue() {
            return singleValue;
        }

        public boolean isBetweenValue() {
            return betweenValue;
        }

        public boolean isListValue() {
            return listValue;
        }

        public String getTypeHandler() {
            return typeHandler;
        }

        protected Criterion(String condition) {
            super();
            this.condition = condition;
            this.typeHandler = null;
            this.noValue = true;
        }

        protected Criterion(String condition, Object value, String typeHandler) {
            super();
            this.condition = condition;
            this.value = value;
            this.typeHandler = typeHandler;
            if (value instanceof List<?>) {
                this.listValue = true;
            } else {
                this.singleValue = true;
            }
        }

        protected Criterion(String condition, Object value) {
            this(condition, value, null);
        }

        protected Criterion(String condition, Object value, Object secondValue, String typeHandler) {
            super();
            this.condition = condition;
            this.value = value;
            this.secondValue = secondValue;
            this.typeHandler = typeHandler;
            this.betweenValue = true;
        }

        protected Criterion(String condition, Object value, Object secondValue) {
            this(condition, value, secondValue, null);
        }
    }
}