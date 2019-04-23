package com.adstream.automate.babylon.sut.pages.adbank.projects;

import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.google.common.base.Function;
import org.openqa.selenium.WebDriver;

import static com.thoughtworks.selenium.SeleneseTestBase.assertFalse;

/**
 * User: ruslan.semerenko
 * Date: 20.08.12 17:32
 */
public class AdbankProjectFromTemplateCreatePage extends AdbankProjectsCreatePage {
    public AdbankProjectFromTemplateCreatePage(ExtendedWebDriver web) {
        super(web);
    }

    @Override
    public void load() {
        super.load();
        web.waitUntil(new Function<WebDriver, Object>() {
            @Override
            public Object apply(WebDriver webDriver) {
                return !getTemplateName().isEmpty();
            }
        });
    }

    @Override
    public void isLoaded() throws Error {
        super.isLoaded();
        assertFalse(getTemplateName().isEmpty());
    }
}
