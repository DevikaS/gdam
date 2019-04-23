package com.adstream.automate.babylon.sut.pages.mediamanager;

import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import org.openqa.selenium.By;

/**
 * Created by Janaki.Kamat on 15/02/2019.
 */
public class MediaCheckerQCReportPage extends MediaCheckerPage {

    private static final By COMMITBUTTON = By.xpath("//*[@class='actions']/button[contains(text(),'Commit')]");

    public MediaCheckerQCReportPage(ExtendedWebDriver web){super(web);
    }
}
