package com.adstream.automate.babylon.migration.objects;

import javax.xml.bind.annotation.XmlElement;

/**
 * Created with IntelliJ IDEA.
 * User: solomin-y
 * Date: 1/12/15
 * Time: 11:58 AM
 */
public class Markets {
    private Integer[] market;

    @XmlElement(name = "Market")
    public Integer[] getMarket() {
        return market;
    }

    public void setMarket(Integer[] market) {
        this.market = market;
    }
}
