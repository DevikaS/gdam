package com.adstream.automate.babylon.sut.pages.adbank.projects;

import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.page.controls.DojoCombo;
import com.google.common.base.Function;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static com.thoughtworks.selenium.SeleneseTestBase.assertFalse;

/**
 * User: ruslan.semerenko
 * Date: 18.05.12 18:38
 */
public class AdbankProjectSettingsPage extends AdbankProjectsCreatePage {
    public AdbankProjectSettingsPage(ExtendedWebDriver web) {
        super(web);
    }

    @Override
    public void load() {
        super.load();
        web.waitUntil(new Function<WebDriver, Object>() {
            @Override
            public Object apply(WebDriver webDriver) {
                return !getName().isEmpty();
            }
        });
    }

    @Override
    public void isLoaded() throws Error {
        super.isLoaded();
        assertFalse(getName().isEmpty());
    }
}
