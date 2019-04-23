package com.adstream.automate.babylon.sut.pages.admin.metadata;

import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;

/*
 * Created by demidovskiy-r on 21.11.2014.
 */
public class GlobalCommonTrafficMetadataPage extends GlobalCommonOrderingMetadataPage {
    private final String ROOT_NODE = "[data-dojo-type='admin.metadata.table_setup_traffic']";

    public GlobalCommonTrafficMetadataPage(ExtendedWebDriver web) {
        super(web);
    }

    protected String getRootNode() {
        return ROOT_NODE;
    }
}