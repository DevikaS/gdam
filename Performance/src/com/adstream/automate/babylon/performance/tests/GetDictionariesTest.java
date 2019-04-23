package com.adstream.automate.babylon.performance.tests;

import com.adstream.automate.babylon.JsonObjects.dictionary.DictionaryType;

public class GetDictionariesTest extends AuthenticationTest {
    @Override
    public void beforeStart() {
        super.start();
    }

    @Override
    public void start() {
        for (DictionaryType type : DictionaryType.values()) {
            long start = System.currentTimeMillis();
            getService().getDictionary(type);
            addPartialTime(type.toString(), System.currentTimeMillis() - start);
        }
    }
}
