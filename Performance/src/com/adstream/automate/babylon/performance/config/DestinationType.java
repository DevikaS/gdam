package com.adstream.automate.babylon.performance.config;

import com.adstream.automate.babylon.core.BabylonCoreService;
import com.adstream.automate.babylon.middleware.BabylonMiddlewareService;

/**
 * User: ruslan.semerenko
 * Date: 22.06.12 18:17
 */
public enum DestinationType {
    CORE(BabylonCoreService.class),
    FRONT(BabylonMiddlewareService.class);
//    NVERGE(BabylonNVergeService.class)

    private Class service;

    private DestinationType(Class service) {
        this.service = service;
    }

    public Class getServiceClass() {
        return service;
    }
}
