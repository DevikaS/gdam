package com.adstream.automate.babylon.JsonObjects;

/**
 * User: ruslan.semerenko
 * Date: 06.09.12 16:07
 */
public class AssetFilterFolder extends BaseObject {
    private AssetFilterFolder[] folders;
    private String[] filters;

    public AssetFilterFolder[] getFolders() {
        return folders;
    }

    public void setFolders(AssetFilterFolder[] folders) {
        this.folders = folders;
    }

    public String[] getFilters() {
        return filters;
    }

    public void setFilters(String[] filters) {
        this.filters = filters;
    }
}
