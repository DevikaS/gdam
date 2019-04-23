package com.adstream.automate.babylon.sut.pages.admin.metadata;

import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.page.controls.DojoCombo;
import org.openqa.selenium.By;

/**
 * Created with IntelliJ IDEA.
 * User: lynda-k
 * Date: 29.05.13
 * Time: 12:07
 */
public class GlobalMetadataPage extends MetadataPage {
    public DojoCombo advertiser;

    public GlobalMetadataPage(ExtendedWebDriver web) {
        super(web);
    }

    @Override
    public void init() {
        super.init();
        this.advertiser = new DojoCombo(this, By.cssSelector(".advertizer"));
    }
}