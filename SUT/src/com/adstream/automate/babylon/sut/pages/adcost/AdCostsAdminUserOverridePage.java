package com.adstream.automate.babylon.sut.pages.adcost;

import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.page.controls.Button;
import com.adstream.automate.page.controls.Edit;
import org.openqa.selenium.By;

/**
 * Created by Raja.Gone on 24/04/2017.
 */
public class AdCostsAdminUserOverridePage extends BaseAdCostPage<AdCostsAdminUserOverridePage> {

    private Edit enterUserId;
    private Button updateBtn;

    private static final By  userIdLocator = By.xpath("//input[@ng-model='overrideCtrl.model.userId']");
    private static final By  updateBtnLocator = By.cssSelector(".ng-valid.ng-scope.ng-dirty.ng-valid-parse>button");
    private static final By  userLoginLocator = By.cssSelector(".ng-binding.ng-scope");

    public AdCostsAdminUserOverridePage(ExtendedWebDriver web) {
        super(web);
        enterUserId = new Edit(this, userIdLocator);
        updateBtn= new Button(this, updateBtnLocator);
    }

    public void load() {
        super.load();
        web.waitUntilElementAppear(userIdLocator);
    }

    public boolean loginToAdCostsSystem(String userId, boolean isPageRefresh){
        closeWakeMePopUp();
        if(!isUserAlreadyLoggedIn(userId)) {
            enterUserId.type(userId);
            updateBtn.click();
            if(isPageRefresh)
                web.navigate().refresh();
            return checkUserLogin(userId) ? true : false;
        } return true;
    }

    public boolean checkUserLogin(String userID){
        if(web.findElement(userLoginLocator).getText().contains("NONE"))
            throw new Error("Unable to login to AdCosts System with userId: "+userID);
        else {
            setUserId(userID);
            return true;
        }
    }

    public boolean isUserAlreadyLoggedIn(String userID){
        return web.findElement(userLoginLocator).getText().contains(userID)?true:false;
    }
}
