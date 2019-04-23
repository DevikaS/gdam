package com.adstream.automate.babylon.JsonObjects.activity;

import com.adstream.automate.babylon.SearchingParams;

public class Pager extends SearchingParams {
    private int size;
    private int offset;

    public Pager(int size, int offset) {
        this.size = size;
        this.offset = offset;
    }

    public int getSize() {
        return size;
    }

    public void setSize(int size) {
        this.size = size;
    }

    public int getOffset() {
        return offset;
    }

    public void setOffset(int offset) {
        this.offset = offset;
    }

    @Override
    public String toString() {
        return "size=" + size + ", offset=" + offset;
    }
}
