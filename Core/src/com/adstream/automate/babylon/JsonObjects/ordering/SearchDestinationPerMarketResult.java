package com.adstream.automate.babylon.JsonObjects.ordering;

/**
 * Created with IntelliJ IDEA.
 * User: demidovskiy-r
 * Date: 05.09.13
 * Time: 14:29
 */
public class SearchDestinationPerMarketResult extends BaseSearchResult<Destination> {
    private String key;
    private String country;
    private Integer priority;
    private String marketType;
    private Integer marketTypePriority;
    private Market map;
    private boolean more;
    private Integer total;

    public String getKey() {
        return key;
    }

    public void setKey(String key) {
        this.key = key;
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

    public boolean isMore() {
        return more;
    }

    public void setMore(boolean more) {
        this.more = more;
    }

    public Integer getTotal() {
        return total;
    }

    public void setTotal(Integer total) {
        this.total = total;
    }
}