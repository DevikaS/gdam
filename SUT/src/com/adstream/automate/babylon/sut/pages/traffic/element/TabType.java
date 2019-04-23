package com.adstream.automate.babylon.sut.pages.traffic.element;

import com.adstream.automate.babylon.sut.pages.ordering.elements.OrderSlider;

/**
 * Created by denysb on 13/11/2015.
 */
public enum TabType {
    ORDER_ITEM_CLOCK("Order Item (Clock)"),
    ORDER_ITEM_SEND("Order Item (Send)"),
    CLOCK("Clock"),
    ORDER("Order");

    private String tabType;

    private TabType(String tabType) {
        this.tabType = tabType;
    }

    public String getTabType(){
        return tabType;
    }


    public static TabType findByType(String type){
        for (TabType tabType : values()) {
            if(tabType.getTabType().equals(type))
                return tabType;
        }
        throw new IllegalArgumentException("Unknown Tab type: " + type);
    }

}
