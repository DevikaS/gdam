package com.adstream.automate.babylon.migration.json;

import com.google.gson.annotations.SerializedName;

/**
 * Created with IntelliJ IDEA.
 * User: solomin-y
 * Date: 7/7/14
 * Time: 11:34 AM

 */
public class FinalCondition {
    private String default_field;
    @SerializedName( "_private.a4.id")
    private String query;
    @SerializedName("_deleted")
    private String asset_deleted;

    public String getDefault_field() {
        return default_field;
    }

    public void setDefault_field(String default_field) {
        this.default_field = default_field;
    }

    public String getQuery() {
        return query;
    }

    public void setQuery(String query) {
        this.query = query;
    }

    public String isAsset_deleted() {
        return asset_deleted;
    }

    public void setAsset_deleted(String asset_deleted) {
        this.asset_deleted = asset_deleted;
    }
}
