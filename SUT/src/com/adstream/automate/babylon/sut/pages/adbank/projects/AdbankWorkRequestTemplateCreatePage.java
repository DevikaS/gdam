package com.adstream.automate.babylon.sut.pages.adbank.projects;

import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.page.controls.Checkbox;
import com.adstream.automate.utils.Common;
import com.google.common.base.Function;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;

import java.io.File;
import java.util.Map;

/**
 * User: lynda-k
 * Date: 19.07.14
 * Time: 20:02
 */
public class AdbankWorkRequestTemplateCreatePage extends AdbankTemplatesCreatePage {
    public AdbankWorkRequestTemplateCreatePage(ExtendedWebDriver web) {
        super(web);
    }

    @Override
    public void init() {
        super.init();
    }

    public void load() {
        super.load();
        web.waitUntilElementAppear(By.cssSelector("[data-dojo-type='adbank.templates.templateEditForm']"));
    }

    public void isLoaded() throws Error {
        super.isLoaded();
        web.waitUntilElementAppear(By.cssSelector("[data-dojo-type='adbank.templates.templateEditForm']"));
    }

    public AdbankWorkRequestTemplateCreatePage fill(Map<String,String> fields) {
        super.fill(fields);
        return this;
    }

    public void uploadBrief(final String path) {
        if (path != null && !path.isEmpty()) {
            web.findElement(By.cssSelector("#brief_uploader [type='file']")).sendKeys(path);
            Common.sleep(100);
            web.waitUntil(new Function<WebDriver, Object>() {
                @Override
                public Object apply(WebDriver webDriver) {
                    return web.findElement(By.id("upload_progress")).getText()
                            .matches(".*" + new File(path).getName() + ".*");
                }
            });
        }
    }

    public boolean isRemoveButtonPresentNextToUploadedBrief() {
        By locator = By.cssSelector("[data-role='remove_file']");
        return web.isElementPresent(locator) && web.isElementVisible(locator);
    }

    public boolean isPublishImmediately() {
        return web.isElementPresent(By.name("publishImmediately"));
    }

    private By getAllowOtherUsersInMyAgencyUseThisTemplateLocator() {
        return By.cssSelector(".popupWindow [data-role='isPublicTemplateWidjet']");
    }

    public void checkAllowOtherUsersInMyAgencyUseThisTemplate() {
        new Checkbox(this, getAllowOtherUsersInMyAgencyUseThisTemplateLocator()).select();
    }

    public boolean isAllowOtherUsersInMyAgencyUseThisTemplate() {
        return web.isElementPresent(getAllowOtherUsersInMyAgencyUseThisTemplateLocator());
    }


}