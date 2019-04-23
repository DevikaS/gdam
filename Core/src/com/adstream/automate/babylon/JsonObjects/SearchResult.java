package com.adstream.automate.babylon.JsonObjects;

import java.util.List;

/**
 * User: ruslan.semerenko
 * Date: 02.04.12 17:18
 */
public class SearchResult <T> {
    private List<T> list;
    private boolean more;
    private Integer total;
    private int esoffset;

    public List<T> getResult() {
        return list;
    }

    public void setResult(List<T> list) {
        this.list = list;
    }

    public boolean hasMore() {
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

    public int getEsoffset() {
        return esoffset;
    }

    public void setEsoffset(int esoffset) {
        this.esoffset = esoffset;
    }
}