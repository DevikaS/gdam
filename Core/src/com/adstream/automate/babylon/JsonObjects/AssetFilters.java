package com.adstream.automate.babylon.JsonObjects;

import java.util.List;

/**
 * User: ruslan.semerenko
 * Date: 06.09.12 15:15
 */
public class AssetFilters {
    private AssetFilterFolder root;
    private List<AssetFilter> filters;

    public AssetFilterFolder getRoot() {
        return root;
    }

    public void setRoot(AssetFilterFolder root) {
        this.root = root;
    }

    public List<AssetFilter> getFilters() {
        return filters;
    }

    public void setFilters(List<AssetFilter> filters) {
        this.filters = filters;
    }
}
