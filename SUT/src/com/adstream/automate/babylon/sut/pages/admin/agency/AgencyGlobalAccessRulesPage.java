package com.adstream.automate.babylon.sut.pages.admin.agency;

import com.adstream.automate.babylon.sut.pages.admin.BaseAdminPage;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.utils.Common;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;

import java.util.HashMap;
import java.util.List;

import static com.thoughtworks.selenium.SeleneseTestBase.assertTrue;

/**
 * User: Devika Subramanian
 * Date: 15.02.16
 * Time:
 */
public class AgencyGlobalAccessRulesPage extends BaseAdminPage<AgencyGlobalAccessRulesPage> {

    public AgencyGlobalAccessRulesPage(ExtendedWebDriver web) {
        super(web);
    }

    @Override
    public void init() {
        super.init();
    }

    @Override
    public void load() {
        super.load();
        web.waitUntilElementAppearVisible(By.xpath("//button[contains(text(),'Save')]"));

    }

    @Override
    public void isLoaded() throws Error {
        super.isLoaded();
        assertTrue(web.isElementPresent(By.xpath("//button[contains(text(),'Save')]")));

    }

    public void selectGolbalRole(String globalRole) {
        web.findElement(By.xpath("//li[@project-roles='projectRoles']/div[2]/a")).click();
        List<WebElement> roleList = web.findElements(By.xpath("//ul[@role='listbox']/li"));
        for (int i = 1; i <= roleList.size(); i++) {
            String actualList = web.findElement(By.xpath("//ul[@role='listbox']/li[" + i + "]")).getText();
            if (actualList.contains(globalRole)) {
                web.findElement(By.xpath("//ul[@role='listbox']/li[" + i + "]")).click();
                break;
            }
        }
    }
    public void selectMetaData(String metaAttribute, String metaValue)
    {
        switch(metaAttribute) {
            case "Media type":
            case "Advertiser":
                web.findElement(By.xpath("//li[@project-roles='projectRoles']/div[4]/div[1]/div[2]/div[1]//a")).click();
                List<WebElement> metaDataList = web.findElements(By.xpath("//ul[@role='listbox']/li"));
                for (int i = 1; i <= metaDataList.size(); i++) {
                    String actualMetaAttributeList = web.findElement(By.xpath("//ul[@role='listbox']/li[" + i + "]")).getText();
                    if (actualMetaAttributeList.contains(metaAttribute)) {
                        WebElement element = web.findElement(By.xpath("//ul[@role='listbox']/li[" + i + "]"));
                        web.getJavascriptExecutor().executeScript("arguments[0].scrollIntoView(true);", element);
                        Common.sleep(500);
                        web.findElement(By.xpath("//ul[@role='listbox']/li[" + i + "]")).click();
                        break;
                    }
                }
                Common.sleep(3000);
                web.findElement(By.xpath("//li[@project-roles='projectRoles']/div[4]/div[1]/div[2]/div[2]//a")).click();
                List<WebElement> metaValueList = web.findElements(By.xpath("//ul[@role='listbox']/li"));
                for (int j = 1; j <= metaValueList.size(); j++) {
                    String actualMetaValueList = web.findElement(By.xpath("//ul[@role='listbox']/li[" + j + "]")).getText();
                    if (actualMetaValueList.contains(metaValue)) {
                        web.findElement(By.xpath("//ul[@role='listbox']/li[" + j + "]")).click();
                        break;
                    }
                }
        }
    }

    public void selectProjectRole(String projectRole) {
        web.findElement(By.xpath("//li[@project-roles='projectRoles']/div[5]/div[2]/a")).click();
        List<WebElement> role = web.findElements(By.xpath("//ul[@role='listbox']/li"));
        for (int i = 1; i <= role.size(); i++) {
            String actualRoleList = web.findElement(By.xpath("//ul[@role='listbox']/li[" + i + "]")).getText();
            if (actualRoleList.contains(projectRole)) {
                web.findElement(By.xpath("//ul[@role='listbox']/li[" + i + "]")).click();
                break;
            }
        }
    }

    public void clickSave() {
        web.findElement(By.xpath("//button[contains(text(),'Save')]")).click();
    }

    public HashMap<String, String> verifyGolbalRuleIsSaved()
    {
        HashMap<String, String> globalRuleData = new HashMap<String, String>();
        String userType = web.findElement(By.xpath("//li[@class='b-rules-item ng-isolate-scope']/div[2]//a/span[1]")).getText();
        String metaData = web.findElement(By.xpath("//li[@class='b-rules-item ng-isolate-scope']/div[4]//a/span[1]")).getText();
        String role = web.findElement(By.xpath("//li[@class='b-rules-item ng-isolate-scope']/div[5]//a/span[1]")).getText();
        String neverExpired = web.findElement(By.xpath("//li[@class='b-rules-item ng-isolate-scope']/div[6]/div[3]//label/span")).getText();
        globalRuleData.put("UserType", userType);
        globalRuleData.put("MetaData", metaData);
        globalRuleData.put("Role", role);
        globalRuleData.put("NeverExpired", neverExpired);
        return globalRuleData;
    }
}