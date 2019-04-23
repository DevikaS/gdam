package com.adstream.automate.babylon.JsonObjects.ordering;

import java.util.List;

/*
 * Created by demidovskiy-r on 05.05.14.
 */
public class Bookmark {
    private String _id;
    private String owner;
    private Integer marketId;
    private String name;
    private List<BookmarkDestination> values;
    private String agency;
    private Boolean shared;

    public String getId() {
        return _id;
    }

    public void setId(String _id) {
        this._id = _id;
    }

    public String getOwner() {
        return owner;
    }

    public void setOwner(String owner) {
        this.owner = owner;
    }

    public Integer getMarketId() {
        return marketId;
    }

    public void setMarketId(Integer marketId) {
        this.marketId = marketId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public List<BookmarkDestination> getValues() {
        return values;
    }

    public void setValues(List<BookmarkDestination> values) {
        this.values = values;
    }

    public String getAgencyId() {
        return agency;
    }

    public void setAgencyId(String agency) {
        this.agency = agency;
    }

    public Boolean isShared() {
        return shared;
    }

    public void setIsShared(Boolean shared) {
        this.shared = shared;
    }
}