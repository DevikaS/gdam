package com.adstream.automate.babylon.sut.pages.mediamanager;

import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import org.openqa.selenium.By;

/**
 * Created by janaki.kamat on 13/02/2019.
 */
public class MediaCheckerMezzReportPage extends MediaCheckerPage {
    public MediaCheckerMezzReportPage(ExtendedWebDriver web){super(web);
    }

    public boolean checkQCErrorMessage(String message){
        return web.isElementPresent(By.xpath(String.format("//div[contains(text(),\"%s\")]",message)));
    }
}

