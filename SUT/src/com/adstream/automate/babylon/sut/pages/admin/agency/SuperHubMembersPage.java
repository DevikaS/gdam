package com.adstream.automate.babylon.sut.pages.admin.agency;

import com.adstream.automate.babylon.sut.pages.admin.BaseAdminPage;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.utils.Common;
import org.openqa.selenium.By;

import static com.thoughtworks.selenium.SeleneseTestBase.assertTrue;

/**
 * User: Devika Subramanian
 * Date: 15.06.16
 */
public class SuperHubMembersPage extends BaseAdminPage<SuperHubMembersPage> {

    public SuperHubMembersPage(ExtendedWebDriver web) {
        super(web);
    }

    @Override
    public void init() {
        super.init();
    }

    @Override
    public void load() {
        super.load();
        web.waitUntilElementAppearVisible(By.xpath("//button[@class='button valign-middle ng-binding']"));
    }

    @Override
    public void isLoaded() throws Error {
        super.isLoaded();
        assertTrue(web.isElementPresent(By.xpath("//button[@class='button valign-middle ng-binding']")));
    }

    public HubMembersPopUpWindow clickNewSuperHubMember()
    {
        Common.sleep(5000);
        web.waitUntilElementAppear(By.xpath("//button[@class='button valign-middle ng-binding']"));
        web.findElement(By.xpath("//button[@class='button valign-middle ng-binding']")).click();
        return new HubMembersPopUpWindow(this);
    }

    public void clickSaveHouseNumber()
    {
        web.findElement(By.xpath("//button[contains(text(),'Save same house number')]")).click();
    }

    public void enterHouseNumber(int j,String houseNumber)
    {
        web.findElement(By.xpath("//div[@class='itemsList clearfix size1of1']/div[" + j +"]//input")).clear();
        web.findElement(By.xpath("//div[@class='itemsList clearfix size1of1']/div[" + j +"]//input")).sendKeys(houseNumber);
    }


}