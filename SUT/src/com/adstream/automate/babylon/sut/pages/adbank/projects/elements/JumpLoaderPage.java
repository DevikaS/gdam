package com.adstream.automate.babylon.sut.pages.adbank.projects.elements;

import com.adstream.automate.babylon.sut.pages.adbank.BaseAdBankPage;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.page.jumploader.JumpLoaderProxy;
import org.openqa.selenium.By;

import static com.thoughtworks.selenium.SeleneseTestBase.assertTrue;

/**
 * User: ruslan.semerenko
 * Date: 19.06.12 17:19
 */
public class JumpLoaderPage extends BaseAdBankPage<JumpLoaderPage> {
    private JumpLoaderProxy jumpLoader;

    public JumpLoaderPage(ExtendedWebDriver web) {
        super(web);
    }

    @Override
    public void load() {
        super.load();
        throw new RuntimeException("Some troubles with jumploader. Do not wait for load. Throw exception.");
//        web.waitUntilElementAppearVisible(By.id("jumpLoaderApplet"));
//        web.waitUntil(new Function<WebDriver, Object>() {
//            @Override
//            public Object apply(WebDriver webDriver) {
//                try {
//                    return isAppletActive();
//                } catch (WebDriverException e) {
//                    return false;
//                }
//            }
//        });
    }

    @Override
    public void isLoaded() throws Error {
        super.isLoaded();
        assertTrue(web.isElementPresent(By.id("jumpLoaderApplet")));
        assertTrue(isAppletActive());
    }

    public JumpLoaderProxy getJumpLoader() {
        if (jumpLoader == null) {
            jumpLoader = new JumpLoaderProxy(web);
        }
        return jumpLoader;
    }

    private boolean isAppletActive() {
        return (Boolean) web.getJavascriptExecutor().executeScript("return Applet.isActive()");
    }
}
