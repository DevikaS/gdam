package com.adstream.automate.babylon.migration.json;

/**
 * Created with IntelliJ IDEA.
 * User: solomin-y
 * Date: 7/7/14
 * Time: 11:38 AM

 */
public class UpperLevel {
    private LevelUp query;
    private int from;
    private int size;
    Object[] sort;
    Object facets;

    public LevelUp getQuery() {
        return query;
    }

    public void setQuery(LevelUp query) {
        this.query = query;
    }

    public int getFrom() {
        return from;
    }

    public void setFrom(int from) {
        this.from = from;
    }

    public int getSize() {
        return size;
    }

    public void setSize(int size) {
        this.size = size;
    }

    public Object[] getSort() {
        return sort;
    }

    public void setSort(Object[] sort) {
        this.sort = sort;
    }

    public Object getFacets() {
        return facets;
    }

    public void setFacets(Object facets) {
        this.facets = facets;
    }
}
