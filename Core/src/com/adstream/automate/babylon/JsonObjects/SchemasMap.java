package com.adstream.automate.babylon.JsonObjects;

import java.util.List;
import java.util.Map;

/**
 * User: lynda-k
 * Date: 22.04.14 17:00
 */
public class SchemasMap extends BaseObject {
    private Map<String,String> _sourceOne;
    private Map<String,String> _sourceTwo;
    private List<Map<String,String>> _map;

    public String getSourceOneAgency() {
        return _sourceOne.get("_agency");
    }

    public void setSourceOneAgency(String agency) {
        _sourceOne.put("_agency", agency);
    }

    public String getSourceOneGroup() {
        return _sourceOne.get("_group");
    }

    public void setSourceOneGroup(String group) {
        _sourceOne.put("_group", group);
    }

    public String getSourceTwoAgency() {
        return _sourceTwo.get("_agency");
    }

    public void setSourceTwoAgency(String agency) {
        _sourceTwo.put("_agency", agency);
    }

    public String getSourceTwoGroup() {
        return _sourceTwo.get("_group");
    }

    public void setSourceTwoGroup(String group) {
        _sourceTwo.put("_group", group);
    }

    public List<Map<String,String>> getMetadataMap() {
        return _map;
    }
}
