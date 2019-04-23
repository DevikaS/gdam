package com.adstream.automate.babylon.sut.pages.admin.approvals;

import com.adstream.automate.babylon.sut.pages.admin.BaseAdminPage;
import com.adstream.automate.babylon.sut.pages.admin.approvals.elements.ApprovalTemplatePopup;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import org.openqa.selenium.By;

import java.util.List;

import static com.thoughtworks.selenium.SeleneseTestBase.assertTrue;

/**
 * Created with IntelliJ IDEA.
 * User: lynda-k
 * Date: 25.09.13
 * Time: 12:07
 */
public class ApprovalTemplatesPage extends BaseAdminPage<ApprovalTemplatesPage> {
    public ApprovalTemplatesPage(ExtendedWebDriver web) {
        super(web);
    }

    @Override
    public void init() {
        super.init();
    }

    @Override
    public void load() {
        super.load();
        web.waitUntilElementAppearVisible(By.cssSelector("[data-id='approvalTemplates']"));
    }

    @Override
    public void isLoaded() throws Error {
        super.isLoaded();
        assertTrue(web.isElementPresent(By.cssSelector("[data-id='approvalTemplates']")));
    }

    public List<String> getTemplatesList() {
        return web.findElementsToStrings(By.cssSelector("[data-id='approvalTemplates'] a"));
    }

    public ApprovalTemplatePopup clickCreateNewApprovalTemplateButton() {
        web.click(By.cssSelector("[widgetid*='approvals_save_template_button']"));

        return new ApprovalTemplatePopup(this);
    }

    public ApprovalTemplatePage openApprovalTemplate(String templateName) {
        web.click(By.xpath(String.format("//*[@data-type='tableRowsContent']//a[normalize-space()='%s']", templateName)));
        return new ApprovalTemplatePage(web);
    }
}
