package com.adstream.automate.babylon.JsonObjects.dictionary;

/**
 * User: Ruslan Semerenko
 * Date: 30.03.13 11:01
 */
public class Dictionary {
    private Integer _version;
    private String _documentType;
    private String _id;
    private String name;
    private DictionaryValues values;

    public Integer getVersion() {
        return _version;
    }

    public void setVersion(Integer _version) {
        this._version = _version;
    }

    public String getDocumentType() {
        return _documentType;
    }

    public void setDocumentType(String _documentType) {
        this._documentType = _documentType;
    }

    public String getId() {
        return _id;
    }

    public void setId(String _id) {
        this._id = _id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public DictionaryValues getValues() {
        return values;
    }

    public void setValues(DictionaryValues values) {
        this.values = values;
    }
}
