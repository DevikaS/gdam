package com.adstream.automate.babylon.sut.elements.controls.complex;

import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.utils.Common;
import com.google.common.base.Function;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;

/**
 * User: ruslan.semerenko
 * Date: 27.04.13 13:17
 */
public class LogoElement {
    private By imageLocator = By.cssSelector("#avatar > img");
    private ExtendedWebDriver web;

    public LogoElement(ExtendedWebDriver web) {
        this.web = web;
    }

    public void uploadLogo(String logoPath) {
        if (logoPath != null && !logoPath.isEmpty()) {
            final String oldSrc = getImageSrc();
            web.findElement(By.name("file")).sendKeys(logoPath);
            Common.sleep(100);
            if (!web.isAlertPresent() && !web.isElementPresent(By.cssSelector(".message.error"))) {
                web.waitUntil(new Function<WebDriver, Object>() {
                    @Override
                    public Object apply(WebDriver webDriver) {
                        return !(getImageSrc() == null || getImageSrc().equals(oldSrc));
                    }
                });
            }
        }
    }

    public void uploadLogoBig(String logoPath) {
        if (logoPath != null && !logoPath.isEmpty()) {
            final String oldSrc = getImageSrc();
            web.findElement(By.name("file")).sendKeys(logoPath);
            Common.sleep(100);
                                }
    }

    public String getImageSrc() {
        return web.findElement(imageLocator).getAttribute("src");
    }
}
