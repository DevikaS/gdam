package com.adstream.automate.babylon.JsonObjects;

import java.util.List;

/*
 * Created by demidovskiy-r on 03.10.2014.
 */
public class HeartBeat {
    private List<ExternalComponent> externalComponents;

    public List<ExternalComponent> getExternalComponents() {
        return externalComponents;
    }

    public void setExternalComponents(List<ExternalComponent> externalComponents) {
        this.externalComponents = externalComponents;
    }
}