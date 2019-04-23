package com.adstream.automate.babylon.sut.pages.adbank.projects.approvals;

import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import org.openqa.selenium.By;

/**
 * User: lynda-k
 * Date: 09.04.14
 * Time: 12:00
 */
public class AdbankProjectsApprovalsReceivedPage extends AdbankProjectsApprovalsPage {

    public AdbankProjectsApprovalsReceivedPage(ExtendedWebDriver web) {
        super(web);
    }

    public String getCountItems() {
        return web.findElement(By.cssSelector("[data-id=\"all-items\"]")).getText();
    }

}