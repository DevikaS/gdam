package com.adstream.automate.babylon.monitoring;

import com.adstream.automate.babylon.LuceneSearchingParams;

/**
 * User: ruslan.semerenko
 * Date: 24.07.13 18:46
 */
public class Argument {
    private ArgumentType type;
    private String value;
    private LuceneSearchingParams searchValue;

    public ArgumentType getType() {
        return type;
    }

    public void setType(ArgumentType type) {
        this.type = type;
    }

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }

    public LuceneSearchingParams getSearchValue() {
        return searchValue;
    }

    public void setSearchValue(LuceneSearchingParams searchValue) {
        this.searchValue = searchValue;
    }
}
