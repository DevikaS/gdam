package com.adstream.automate.babylon.JsonObjects.ordering;

/**
 * Created with IntelliJ IDEA.
 * User: demidovskiy-r
 * Date: 04.09.13
 * Time: 14:58
 */
public class Market {
    private String id;
    private String key;
    private String name;
    private String country;
    private Integer priority;
    private String marketType;
    private Integer marketTypePriority;
    private Market map;
    private String[] values;
    private Boolean more;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getKey() {
        return key;
    }

    public void setKey(String key) {
        this.key = key;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getCountry() {
        return country;
    }

    public void setCountry(String country) {
        this.country = country;
    }

    public Integer getPriority() {
        return priority;
    }

    public void setPriority(Integer priority) {
        this.priority = priority;
    }

    public String getMarketType() {
        return marketType;
    }

    public void setMarketType(String marketType) {
        this.marketType = marketType;
    }

    public Integer getMarketTypePriority() {
        return marketTypePriority;
    }

    public void setMarketTypePriority(Integer marketTypePriority) {
        this.marketTypePriority = marketTypePriority;
    }

    public Market getMap() {
        return map;
    }

    public void setMap(Market map) {
        this.map = map;
    }

    public String[] getValues() {
        return values;
    }

    public void setValues(String[] values) {
        this.values = values;
    }

    public Boolean getMore() {
        return more;
    }

    public void setMore(Boolean more) {
        this.more = more;
    }
}