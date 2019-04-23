package com.adstream.automate.babylon.JsonObjects.projectsaccessrure;

import java.util.List;

/**
 * User: lynda-k
 * Date: 12.08.14
 * Time: 12:35
 */
public class ProjectsAccessRuleTerm {
    private String key;
    private List<String> value;

    public ProjectsAccessRuleTerm(String key, List<String> value) {
        this.key = key;
        this.value = value;
    }

    public String getKey() {
        return key;
    }

    public void setKey(String key) {
        this.key = key;
    }

    public List<String> getValue() {
        return value;
    }

    public void setValue(List<String> value) {
        this.value = value;
    }
}
