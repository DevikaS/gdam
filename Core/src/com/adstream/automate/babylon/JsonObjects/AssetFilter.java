package com.adstream.automate.babylon.JsonObjects;

import java.util.List;

/**
 * User: ruslan.semerenko
 * Date: 06.09.12 15:19
 */
public class AssetFilter extends BaseObject {
    Boolean isDefault;
    private List<String> assetIds;
    private CustomMetadata _cm;

    public Boolean isDefault() {
        return isDefault;
    }

    public void setDefault(Boolean aDefault) {
        isDefault = aDefault;
    }

    public Object getQuery() {
        return getCmCommon().get("query");
    }

    public void setQuery(Object query) {
        getCmCommon().put("query", query);
    }

    @Override
    public String getName() {
        return getCmCommon().getString("name");
    }

    @Override
    public void setName(String name) {
        getCmCommon().put("name", name);
    }

    private CustomMetadata getCm() {
        if (_cm == null) _cm = new CustomMetadata();
        return _cm;
    }

    private CustomMetadata getCmCommon() {
        return getCm().getOrCreateNode("common");
    }

    public List<String> getAssetIds() {
        return assetIds;
    }

    public void setAssetIds(List<String> assetIds) {
        this.assetIds = assetIds;
    }
}
