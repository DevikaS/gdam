package com.adstream.automate.babylon.JsonObjects.ordering;

import com.adstream.automate.babylon.JsonObjects.CustomMetadata;

/*
 * Created by demidovskiy-r on 19.06.2014.
 */
public class AutoGenerate {
    private Integer index;
    private AutoGeneratePattern[] patterns;

    public AutoGenerate(CustomMetadata cm) {
        setIndex(cm.getInteger("index"));
        setPatterns(cm.getArrayForClass("patterns", AutoGeneratePattern.class));
    }

    public Integer getIndex() {
        return index;
    }

    public void setIndex(Integer index) {
        this.index = index;
    }

    public AutoGeneratePattern[] getPatterns() {
        return patterns;
    }

    public void setPatterns(AutoGeneratePattern[] patterns) {
        this.patterns = patterns;
    }
}