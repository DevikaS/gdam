package com.adstream.automate.babylon.monitoring;

import com.adstream.automate.babylon.LuceneSearchingParams;

/**
 * User: ruslan.semerenko
 * Date: 25.07.13 11:59
 */
public enum ArgumentType {
    String(String.class),
    Search(LuceneSearchingParams.class);

    private Class clazz;

    private ArgumentType(Class clazz) {
        this.clazz = clazz;
    }

    public Class getClassForType() {
        return clazz;
    }
}
