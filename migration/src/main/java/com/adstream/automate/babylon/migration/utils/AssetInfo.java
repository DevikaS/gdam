package com.adstream.automate.babylon.migration.utils;

import java.util.HashMap;
import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: solomin-y
 * Date: 10/6/14
 * Time: 12:21 PM

 */
public class AssetInfo {
    private String assetName;
    private List<String> commonEmptyFields;
    private List<String> videoEmptyFields;
    private HashMap<String, String> wrongValues;

    public String getAssetName() {
        return assetName;
    }

    public void setAssetName(String assetName) {
        this.assetName = assetName;
    }

    public List<String> getCommonEmptyFields() {
        return commonEmptyFields;
    }

    public void setCommonEmptyFields(List<String> commonEmptyFields) {
        this.commonEmptyFields = commonEmptyFields;
    }

    public List<String> getVideoEmptyFields() {
        return videoEmptyFields;
    }

    public void setVideoEmptyFields(List<String> videoEmptyFields) {
        this.videoEmptyFields = videoEmptyFields;
    }

    public HashMap<String, String> getWrongValues() {
        return wrongValues;
    }

    public void setWrongValues(HashMap<String, String> wrongValues) {
        this.wrongValues = wrongValues;
    }
}
