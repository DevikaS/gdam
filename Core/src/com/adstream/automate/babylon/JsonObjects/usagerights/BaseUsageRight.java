package com.adstream.automate.babylon.JsonObjects.usagerights;

import com.adstream.automate.babylon.JsonObjects.CustomMetadata;

import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: User
 * Date: 24.10.13
 * Time: 21:13

 */
public class BaseUsageRight {

    private CustomMetadata[] usages;

    public BaseUsageRight() {}

    public CustomMetadata[] getUsages() {
        return usages;
    }

    public void setUsages(CustomMetadata[] usages) {
        this.usages = usages;
    }
}
