package com.adstream.automate.babylon.sut.pages.adcost;

import com.adstream.automate.babylon.TestsContext;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.utils.Common;
import org.joda.time.DateTime;
import org.joda.time.format.DateTimeFormat;
import org.joda.time.format.DateTimeFormatter;
import org.openqa.selenium.By;
import org.openqa.selenium.ElementNotVisibleException;
import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.WebElement;

import java.awt.*;
import java.awt.event.KeyEvent;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

import static com.adstream.automate.babylon.JsonObjects.activity.ActivityType.role;

/**
 * Created by Arti.Sharma on 31/10/2017.
 */
public class AdCostsAdminUserAccessPage extends BaseAdCostPage<AdCostsAdminUserAccessPage> {

    protected String userLocator = "//*[@class='table-items']//*[contains(text(),'%s')]";
    private String adminOptionLocator = "//*[@class='md-nav-bar']//*[contains(text(),'%s')]";
    private String costUser;
    private String primaryBusinessUnit;
    private String email;
    private String diabled;

    public String getCostUser() { return costUser; }

    public String getPrimaryBusinessUnit() { return primaryBusinessUnit; }

    public String getEmail() { return email; }

    public String getDiabled() { return diabled; }

    public AdCostsAdminUserAccessPage(ExtendedWebDriver web) {
        super(web);
        closeWakeMePopUp();
    }


    public boolean checkAdminPagePresent() {
        return web.isElementPresent(By.xpath("//div[@layout-align='start stretch']"));
    }

    public void waitForAdminSectionToLoad() {
        web.waitUntilElementAppearVisible(By.xpath("//div[@layout-align='start stretch']"));
    }

    public void waitUntilUserAssignRoleSectonLoaded() {
        web.waitUntilElementAppearVisible(By.xpath("//*[@ng-repeat='access in userEditCtrl.accessDetails']"));
    }

    public boolean isUserPresent(String userEmail) {
        web.waitUntilElementAppearVisible(By.xpath("//div[@layout-align='start stretch']"));
        return web.isElementVisible(By.xpath(String.format(userLocator, userEmail)));
    }

    public void clickUsernameOnAdminPage(String userName) {
        web.waitUntilElementAppearVisible(By.xpath(String.format(userLocator, userName)));
        web.findElement(By.xpath(String.format(userLocator, userName))).click();
        web.waitUntilElementAppearVisible(By.xpath("//*[@layout-align='start stretch']"));
    }

    public boolean isOptionPresentUnderAdmin(String option) {
        web.waitUntilElementAppearVisible(By.xpath("//nav//*[@class='_md-nav-bar-list']"));
        return web.isElementVisible(By.xpath(String.format(adminOptionLocator, option)));
    }

    public void clickOnAdminOptions(String option) {

        web.findElement(By.xpath(String.format(adminOptionLocator, option))).click();
    }

    public void waitUntilBudgetFormPageLoaded() {

        web.waitUntilElementAppearVisible(By.xpath("//budget-form-template-component/section"));
    }

    public void searchUserOnadminPage(String userEmail) {
        By searchUserLocator = By.xpath("//ads-md-input//*[@placeholder='Search']");
        web.typeClean(searchUserLocator, userEmail);
        Common.sleep(1000);
    }

    public UserRoleAccessAssignSection getUserRoleAccessAssignSectionNew() {
        return new UserRoleAccessAssignSection();
    }

    public BudgetFormSection getBudgetFormSection() {
        if (web.isElementPresent(By.xpath("//budget-form-template-component/section")))
            return new BudgetFormSection();
        else throw new ElementNotVisibleException("Check if Budget Form Section is loaded on admin section");
    }

    public void loadUserDetails(){
        String tableHeaderFormat = "//div[contains(@class,'table-item header')]/div";
        int tableHeaders = web.findElements(By.xpath(tableHeaderFormat)).size();
        for(int i=1;i<=tableHeaders;i++){
            String tableHeader = web.findElement(By.xpath(tableHeaderFormat.concat("[").concat(Integer.toString(i)).concat("]"))).getText();
            String columnValue = web.findElement(By.xpath("//div[@ng-repeat='user in userViewCtrl.users']/div[".concat(Integer.toString(i).concat("]")))).getText();

            switch (tableHeader) {
                case "Cost User":
                    costUser = columnValue;
                    break;
                case "Primary Business Unit":
                    primaryBusinessUnit = columnValue;
                    break;
                case "Email":
                    email=columnValue;
                    break;
                case "Disabled":
                    diabled = columnValue;
                    break;
                default:
                    throw new IllegalArgumentException("Unknown Table header: "+tableHeader);
            }
        }
    }

    public boolean isUserDisabledAndNotEditable(){
        return web.isElementVisible(By.xpath("//p[@ng-if='user.disabled']"));
    }

    public class BudgetFormSection {

        public void uploadBudgetFormTemplateOnAdminSection(String filePath) {
            String filesFolder = TestsContext.getInstance().testDataFolderName;
            if (filePath.contains(BudgetFormTypeTemplate.AUDIOALLSUMMARY.toString())) {
                String uploadlocator = "//*[@id='uploadBudgetForm%s']";
                String filePath1 = "C:\\Users\\arti.sharma\\Downloads\\Audio - All - Summary Only.xlsx";
                JavascriptExecutor jsx = (JavascriptExecutor) web;
                jsx.executeScript("document.getElementById('//*[@id='uploadBudgetFormAudioAllSummary']').value='" + filePath1 + "';");
            }
        }

        public String checkUploadFormDate(String fileName, String columnName) {
        String date = loadBudgetFormPage(fileName, columnName);
            DateTimeFormatter formatter = DateTimeFormat.forPattern("dd-MMM-yyyy");
            DateTime dt = formatter.parseDateTime(date);
            return dt.toString();
        }

        private String loadBudgetFormPage(String fileName, String columnName) {
            String columnHeaderLocator = "//table/thead/tr/th";
            String rowItemLocator = "//table/tbody/tr";

            int ColumnNumber = 1;
            int RowNumber = 1;
            for (int i = 1; i <= web.findElements(By.xpath(columnHeaderLocator)).size(); i++)
                if (web.findElement(By.xpath(columnHeaderLocator.concat("[" + i + "]"))).getText().equalsIgnoreCase(columnName)) {
                    ColumnNumber = i;
                    break;
                }
            for (int j = 1; j <= web.findElements(By.xpath(rowItemLocator)).size(); j++)
                if (web.findElement(By.xpath(String.format(rowItemLocator.concat("[" + j + "]/td[contains(text(),'%s')]"), fileName))).getText().equalsIgnoreCase(fileName)) {
                    RowNumber = j;
                    break;
                }
            switch (columnName){
                case ("Uploaded"):
                    return web.findElement(By.xpath(rowItemLocator.concat("[" + RowNumber + "]").concat("/td[" + ColumnNumber + "]"))).getText().trim();
                case("Download"):
                    web.findElement(By.xpath(rowItemLocator.concat("[" + RowNumber + "]").concat("/td[" + ColumnNumber + "]"))).click();
                    return "Test";

            }
            return null;
        }

        public void downloadBudgetForm(String fileName, String columnName) throws Exception{
            String parentWindowHandler = web.getWindowHandle();
            loadBudgetFormPage(fileName, columnName);
//            String parentWindowHandler = web.getWindowHandle(); // Store your parent window
            String subWindowHandler = null;

            Set<String> handles = web.getWindowHandles(); // get all window handles
            Iterator<String> iterator = handles.iterator();
            while (iterator.hasNext()){
                subWindowHandler = iterator.next();
            }
            web.switchTo().window(subWindowHandler); // switch to popup window
            Robot rb =new Robot();
            Thread.sleep(2000);
            rb.keyPress(KeyEvent.VK_ALT);
            rb.keyRelease(KeyEvent.VK_ALT);

            rb.keyPress(KeyEvent.VK_ENTER);
            rb.keyRelease(KeyEvent.VK_ENTER);
            web.switchTo().window(parentWindowHandler);  // switch back to parent window
        }
    }

    public class UserRoleAccessAssignSection {
        By userRoleLocator = By.xpath("//md-input-container//md-select-value");

        public void assignRoleForUser(String role, String region, boolean smoUser) {
            if (web.isElementPresent(userRoleLocator)) {
                web.click(userRoleLocator);
                String locator = "//md-option[@role='option']//*[contains(text(),'%s')]";
                web.waitUntilElementAppearVisible(By.xpath(String.format(locator, role)));
                for (WebElement element : web.findElements(By.xpath(String.format(locator, role)))) {
                    if (element.getText().equalsIgnoreCase(role)) {
                    element.click();
                    if (smoUser && !(region == null || region.isEmpty())) {
                        web.findElement(By.xpath("//md-checkbox//*[@class='md-icon']")).click();
                        clickOptionFromConditionDropdown(region, "Condition");
                    }
                    if (role.equals("Region Support") && !(region == null || region.isEmpty())) {
                       clickOptionFromConditionDropdown(region, "Condition");
                    }
                    if (role.equals("Finance Manager") && !(region == null || region.isEmpty())) {
                       clickOptionFromConditionDropdown(region, "Budget Region");
                    }
                    break;
                }
              }
            }
        }

        public List<String> getUserRoles(){
           if (web.isElementPresent(userRoleLocator)) {
               web.click(userRoleLocator);
               Common.sleep(1000);
               return web.findElementsToStrings(By.xpath("//md-option[@role='option']"));
           } return null;
        }

        private void clickOptionFromConditionDropdown(String region, String condition) {
            By condtionLocator = By.xpath(String.format("//md-select[@placeholder='%s']",condition));
            String regionLocator = "//md-select-menu//md-option[@role='option']//*[contains(text(),'%s')]";
            web.waitUntilElementAppearVisible(condtionLocator);
            web.click(condtionLocator);
            web.waitUntilElementAppearVisible(By.xpath(String.format(regionLocator, region)));
            for (WebElement ele : web.findElements(By.xpath(String.format(regionLocator, region)))) {
                 scrollToFieldName(ele);
                 ele.click();
                 break;
            }
        }

        public List<String> checkBudgetRegionsUnderConditionDropdown(String role ,String condition) {
            if (web.isElementPresent(userRoleLocator)) {
                web.click(userRoleLocator);
                String locator = "//md-option[@role='option']//*[contains(text(),'%s')]";
                web.waitUntilElementAppearVisible(By.xpath(String.format(locator, role)));
                for (WebElement element : web.findElements(By.xpath(String.format(locator, role)))) {
                    if (element.getText().equalsIgnoreCase(role)) {
                       element.click();
                       if (condition.equals("Budget Region") && !(condition == null || condition.isEmpty())) {
                           By condtionLocator = By.xpath(String.format("//md-select[@placeholder='Budget Region']", condition));
                           if (web.isElementPresent(condtionLocator)) {
                               web.click(condtionLocator);
                               Common.sleep(1000);
                               return web.findElementsToStrings(By.xpath("//md-select-menu//md-option[@role='option'][@ng-value='budgetRegion.id']"));
                           }
                       return null;
                       }
                    }
                }
            }
            return null;
        }

        public boolean checkRoleExists(String role) {
            if (web.isElementPresent(userRoleLocator)) {
                web.click(userRoleLocator);
                String locator = "//md-option[@role='option']//*[contains(text(),'%s')]";
                if (web.isElementVisible(By.xpath(String.format(locator, role))))
                    return true;
                }
            return false;
        }

        public void clickSaveButton() {
             web.findElement(By.xpath("//button//span[contains(text(),'Save')]")).click();
             Common.sleep(8000);
        }

        public boolean checkSaveButtonEnabledOrNot() {
            return web.isElementPresent(By.xpath("//button[@disabled='disabled']//span[contains(text(),'Save')]/../.."));
        }

        public boolean checkTheAssignedRole(String role) {
             String assignedRole = web.findElement(By.xpath("//*[contains(@id,'select_value_label')]/span[1]")).getText();
             if (assignedRole.equals(role))
                return true;
             return false;
        }

        public boolean checkTheAssignedCondition(String region) {
            String assignedRegion = web.findElement(By.xpath("//md-select[@placeholder='Budget Region']//md-select-value/span/div")).getText();
            if (assignedRegion.equals(region))
                return true;
            return false;
        }
    }

    public enum BudgetFormTypeTemplate {
         AUDIOALLSUMMARY("AudioAllSummary"),
         AUDIOALLSUMMARYANDDETAIL("AudioAllSummaryAndDetail"),
         VIDEOPPALLSUMMARY("VideoPostProductionAllSummary"),
         VIDEOPPALLSUMMARYANDDETAIL("VideoPostProductionAllSummaryAndDetail"),
         VIDEOFPALLSUMMARY("VideoFullProductionAllSummary"),
         VIDEOFPALLSUMMARYANDDETAIL("VideoFullProductionAllSummaryAndDetail"),
         DIGITALALLSUMMARY("DigitalAllSummary"),
         DIGITALALLSUMMARYANDDETAIL("DigitalAllSummaryAndDetail"),
         STILLIMAGEALLSUMMARY("StillImageAllSummary"),
         STILLIMAGEALLSUMMARYANDDETAIL("StillImageAllSummaryAndDetail");

         private String BudgetFormTypeTemplate;

         private BudgetFormTypeTemplate(String BudgetFormTypeTemplate) {
                this.BudgetFormTypeTemplate = BudgetFormTypeTemplate;
            }

         @Override
         public String toString() {
                return BudgetFormTypeTemplate;
            }

         public static BudgetFormTypeTemplate findByType(String type) {
             for (BudgetFormTypeTemplate budgetFormType : values())
                 if (budgetFormType.toString().equals(type))
                    return budgetFormType;
             throw new IllegalArgumentException("Unknown budget Form Type : " + type);
         }
      }
    }
