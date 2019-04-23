package com.adstream.automate.babylon.sut.pages.adbank.projects.approvals;

import com.adstream.automate.babylon.sut.pages.adbank.BaseAdBankPage;
import com.adstream.automate.babylon.sut.pages.adbank.projects.elements.AdbankProjectTabs;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import org.openqa.selenium.By;

import java.util.List;

import static com.thoughtworks.selenium.SeleneseTestBase.assertTrue;

public class AdbankProjectApprovalsPreviewFilePage extends BaseAdBankPage<AdbankProjectTabs> {

    public AdbankProjectApprovalsPreviewFilePage(ExtendedWebDriver web) {
        super(web);
    }

    public void load() {
        super.load();
        web.waitUntilElementAppear(By.cssSelector("[data-dojo-type='adbank.files.approvals']"));
    }

    public void isLoaded() throws Error {
        super.isLoaded();
        assertTrue(web.isElementPresent(By.cssSelector("[data-dojo-type='adbank.files.approvals']")));
    }

    private By getCountOfFilesLocator() {
        return By.cssSelector("[data-dojo-type=\"adbank.approvals.fileViewSelector\"] [data-role=\"caption-text\"]");
    }

    public String getNumberOfFiles() {
        return web.findElement(getCountOfFilesLocator()).getText().replaceAll(".*of+\\s", "");
    }

    public String getCurrentPositionOnView() {
        return web.findElement(getCountOfFilesLocator()).getText().replaceAll("\\s+of.*", "");
    }

    public void navigate(String position) {
        if (position.equalsIgnoreCase("next"))
            web.findElement(By.cssSelector("[data-role='next']")).click();
        else if (position.equalsIgnoreCase("previous"))
            web.findElement(By.cssSelector("data-role='prev'")).click();
        else
            throw new IllegalArgumentException(String.format("Incorrect parameter %s", position));
    }

    public List<String> getApprovalStageName() {
        return web.findElementsToStrings(By.cssSelector(".snowblue-bg span.h4"));
    }

}
