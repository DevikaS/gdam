package com.adstream.automate.babylon.sut.pages.adbank.projects;

import com.adstream.automate.babylon.sut.pages.adbank.AdbankPaginator;
import com.adstream.automate.babylon.sut.pages.adbank.projects.elements.AddColumnsProjectWindow;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.page.controls.Checkbox;
import com.adstream.automate.page.controls.DojoSelect;
import com.adstream.automate.utils.Common;
import org.apache.commons.lang3.time.StopWatch;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.ui.ExpectedConditions;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.TimeUnit;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import static com.thoughtworks.selenium.SeleneseTestBase.assertTrue;

/**
 * Created by IntelliJ IDEA.
 * User: savitskiy-a
 * Date: 08.02.12
 * Time: 20:02
 */
public class AdbankProjectsListPage extends AdbankPaginator {

    public AdbankProjectsListPage(ExtendedWebDriver web) {
        super(web);
    }

    @Override
    public void load() {
        super.load();
        web.manage().timeouts().implicitlyWait(60, TimeUnit.SECONDS);
        //web.waitUntilElementAppear(By.cssSelector("[data-dojo-type='adbank.projects.projects_list']"));
    }

    @Override
    public void isLoaded() throws Error {
        web.sleep(6000);
        super.isLoaded();
        assertTrue(web.isElementVisible(By.cssSelector("[data-dojo-type='adbank.projects.projects_list']")));
        web.manage().timeouts().implicitlyWait(1, TimeUnit.SECONDS);
    }

    public AdbankProjectsCreatePage clickNewProject() {
        web.waitUntilElementAppearVisible(getNewProjectButtonLocator());
        web.click(getNewProjectButtonLocator());
        web.waitUntilElementAppearVisible(By.cssSelector(".projects_action_form_popup"));
        return new AdbankProjectsCreatePage(web);
    }

    public AdbankWorkRequestCreatePage clickNewWorkRequest() {
        web.waitUntilElementAppearVisible(getNewWorkRequestButtonLocator());
        web.click(getNewWorkRequestButtonLocator());
        web.waitUntilElementAppearVisible(By.cssSelector(".projects_action_form_popup"));
        return new AdbankWorkRequestCreatePage(web);
    }

    public String getFistProjectName() {
        List<WebElement> projectNameElements = getObjectsLinks();
        return projectNameElements.size() > 0 ? projectNameElements.get(0).getText() : "";
    }

    public void clickProjectName(String projectName) {
    //   web.click(By.linkText(projectName));
       //web.click(By.xpath("//a[contains(@class, 'project_link')][contains(.,projectName)]/ancestor::div[contains(@class,'column')]/div/a"));
        web.click(By.xpath("//a[contains(@class, 'project_link')][contains(.,projectName)]/ancestor::div[contains(@class,'column')]//a[contains(@class,'project_link')]"));
    }

    public long getProjectLoadingTime(String projectName) {
        StopWatch pageLoad = new StopWatch();
        pageLoad.start();
        clickProjectName(projectName);
        web.waitUntil(ExpectedConditions.presenceOfElementLocated(By.linkText("Delete project")));
        pageLoad.stop();
        //Get the time
        Long pageLoadTime_Seconds = pageLoad.getTime() / 1000;
        return pageLoadTime_Seconds;
    }


    public AddColumnsProjectWindow clickByAddColumnProjectListButton() {
        web.click(By.cssSelector("[data-role=\"dropButton\"]"));
        return new AddColumnsProjectWindow(this);
    }

    public boolean isDeleteButtonDisabled() {
        return web.isElementVisible(By.cssSelector(".button.mls.remove.disabled"));
    }

    public int getCountOfTotalProject() {
        return Integer.parseInt(web.findElement(By.cssSelector("[data-id='total-count']")).getText());
    }

    public WebElement getSortFieldByFieldName(String fieldName) {
        return web.findElement(By.cssSelector("*[fieldname='" + convertSortFieldName(fieldName) + "']"));
    }

    public String getClassOfSortField(String fieldName) {
        WebElement webElement = getSortFieldByFieldName(fieldName);
        return webElement.getAttribute("class") == null ? "" : webElement.getAttribute("class");
    }

    public void clickSortField(String fieldName) {
        web.click(By.cssSelector("*[fieldname='" + convertSortFieldName(fieldName) + "']"));
    }

    public void selectViewFilter(String type) {
        DojoSelect select = new DojoSelect(this, By.xpath("(//table[descendant::input[@name='View']])[2]"));
        if (!select.getSelectedLabel().equals(type)) {
            select.selectByVisibleText(type);
            Common.sleep(1000);
        }
    }

    public List<String> getProjectsList() {
        return web.findElementsToStrings(By.className("project_link"));
    }

    public List<String> getListOfProjectsFields(String fieldName) {
        fieldName = convertSortFieldName(fieldName);
        String css;
        if (fieldName.equals("jobNumber")) {
            css = ".row.clearfix.pointer > .unit.cell:nth-child(11)";
        } else if (fieldName.contains("name")) {
            css = ".row.clearfix.pointer > .unit.cell:nth-child(2)";
        } else if (fieldName.equals("enumsFull__advertiser__name")) {
            css = ".row.clearfix.pointer > .size1of5.unit.cell:nth-child(3)";
        } else if (fieldName.equals("enumsFull__product__name")) {
            css = ".row.clearfix.pointer > .size1of5.unit.cell:nth-child(4)";
        } else if (fieldName.equals("_modified")) {
            css = ".row.clearfix.pointer > .size1of5.unit.cell:nth-child(5)";
        } else return new ArrayList<>();
        return web.findElementsToStrings(By.cssSelector(css));
    }

    public String convertSortFieldName(String fieldName) {
        if (fieldName.equalsIgnoreCase("lastActivity")) {
            fieldName = "lastActivity.dateTime";
        } else if (fieldName.equalsIgnoreCase("Client")) {
            fieldName = "enumsFull__advertiser__name";
        } else if (fieldName.equalsIgnoreCase("Product")) {
            fieldName = "enumsFull__product__name";
        } else if ((fieldName.equalsIgnoreCase("Title")) || (fieldName.equalsIgnoreCase("ProjectName"))) {
            fieldName = "_cm.common.name";
        } else if (fieldName.equalsIgnoreCase("jobNumber")) {
            fieldName = "_cm.common.jobNumber";
        } else if (fieldName.equalsIgnoreCase("Media type")) {
            fieldName = "_cm.common.projectMediaType";
        }
        return fieldName;
    }

    public boolean isCreateNewProjectPopUpVisible() {
        return web.isElementVisible(By.xpath("//*[contains(@class, 'popupWindow')]//*[text()='New Project']"));
    }

    public boolean isCreateNewWorkRequestPopUpVisible() {
        return web.isElementVisible(By.xpath("//*[contains(@class, 'popupWindow')]//*[text()='Create new Work Request']"));
    }

    public String getProjectsActivityName(String projectId) {
        return web.findElement(By.cssSelector(String.format(".activities_list a[href*='%s']", projectId))).getText();
    }

    public boolean isProjectsActivityEmpty() {
        return !web.isElementPresent(By.cssSelector(".activities_list")) || web.findElement(By.cssSelector(".activities_list")).getText().isEmpty();
    }

    public List<String> getAllTabs() {
        return web.findElementsToStrings(By.cssSelector(".line.plm a"));
    }

    private By getNewProjectButtonLocator() {
        return By.cssSelector("[data-dojo-type='common.newProject']");
    }

    private By getNewWorkRequestButtonLocator() {
        return By.cssSelector("[data-dojo-type='adbank.projects.createWorkRequestButton']");
    }

    public int getItemsCount() {
        return web.findElementsToStrings(By.cssSelector(".first.vmiddle.link.no-decoration.project_link")).size();
    }

    public boolean isTabExist(String tab) {
        return web.isElementPresent(By.xpath("//a[text()='" + tab + "']"));
    }

    public boolean isTabVisible(String tab) {
        return web.isElementVisible(By.xpath(String.format(".//*[@id='app-tabs']//a[normalize-space()='%s']", tab)));
    }

    public List<String> getProjectFieldNames() {
        return web.findElementsToStrings(getHeaderColumnsLocator());
    }

    public List<Map<String,String>> getProjectsFields(List<String> neededFields) {
        List<Map<String,String>> result = new ArrayList<>();

        for (WebElement headerColumn : web.findElements(getHeaderColumnsLocator())) {
            Matcher m = Pattern.compile(".*dataId:\\s*'\\s*([^']+)\\s*").matcher(headerColumn.getAttribute("data-dojo-props"));
            m.find();
            String columnClass = m.group(1);
            final String fieldName = headerColumn.getText().trim().replaceAll("\\s+", " ");

            if (neededFields.contains(fieldName)) {
                List<String> fieldValues = web.findElementsToStrings(getProjectsListFieldValuesByColumnClass(columnClass));
                for (int i = 0; i < fieldValues.size(); i++) {
                    if (result.size() <= i) result.add(i, new HashMap<String, String>());
                    result.get(i).put(fieldName, fieldValues.get(i));
                }
            }
        }

        return result;
    }

    public List<String> getProjectsFieldsasList(List<String> neededFields) {
        List<String> result = new ArrayList<>();
        for (WebElement headerColumn : web.findElements(getHeaderColumnsLocator())) {
            Matcher m = Pattern.compile(".*dataId:\\s*'\\s*([^']+)\\s*").matcher(headerColumn.getAttribute("data-dojo-props"));
            m.find();
            String columnClass = m.group(1);
            final String fieldName = headerColumn.getText().trim().replaceAll("\\s+", " ");

            if (neededFields.contains(fieldName)) {
               result= web.findElementsToStrings(getProjectsListFieldValuesByColumnClass(columnClass));
            }
        }

        return result;
    }
    public void scrollDownToFooter() {
        web.scrollToElement(web.findElement(By.cssSelector(".footer.clearfix")));
        web.sleep(2000);
    }

    public void clickLinkActivity(String link) {
        web.click(By.linkText(link));
    }

    public void sortProjectListByFieldWithOrder(String field, String order) {
        if (!web.findElement(getProjectsColumnLocatorByName(field)).getAttribute("class").contains(order)) {
            web.click(getProjectsColumnLocatorByName(field));
            Common.sleep(3000);
            if (!web.findElement(getProjectsColumnLocatorByName(field)).getAttribute("class").contains(order))
                web.click(getProjectsColumnLocatorByName(field));
        }
    }

    public void selectProjectsColumnCheckboxByName(String name) {
        new Checkbox(this, getProjectsColumnCheckboxLocatorByName(name)).select();
    }

    public void deselectProjectsColumnCheckboxByName(String name) {
        web.scrollToElement(web.findElement(getProjectsColumnCheckboxLocatorByNameNew(name)));
             new Checkbox(this, getProjectsColumnCheckboxLocatorByNameNew(name)).deselect();
    }

    public void clickProjectsColumnsDropdownButton() {
        web.click(getProjectsColumnsDropdownButtonLocator());
    }

    public List<String> getProjectFilters() {
        List<String> filters = web.findElementsToStrings(By.cssSelector(".tree-item:not(.none)"));
        for (int i = 0; i < filters.size(); i++) {
            String filter = filters.get(i);
            filters.set(i, filter.substring(0, filter.lastIndexOf(" ")));
        }
        return filters;
    }
    // NGN-16211-QAA: User from multiple BU's should see all Advertiser values in Project Filters code Changes Starts
    public List<String> getProjectFilterHierarchy() {
        List<WebElement> expandBtns = web.findElements(By.xpath(".//*[@ng-click='expandItem(items)']"));
        for(int i=0;i<expandBtns.size();i++){
            if(expandBtns.get(i).isDisplayed()){
                expandBtns.get(i).click();
                Common.sleep(500);
            }
            expandBtns = web.findElements(By.xpath(".//*[@ng-click='expandItem(items)']"));
        }
        List<String> filters = web.findElementsToStrings(By.cssSelector(".tree-item:not(.none)"));
        for (int i = 0; i < filters.size(); i++) {
            String filter = filters.get(i);
            if(filter.contains("\n")){
                filter =filter.replaceAll("\n"," ");
                filters.set(i,filter.substring(0,filter.indexOf(" ")));
            }else {
                filters.set(i,filter.substring(0, filter.lastIndexOf(" ")));
            }
        }
        return filters;
    }

    public void selectProjectFilter(String type) {
        List<WebElement> expandBtns = web.findElements(By.xpath(".//*[@ng-click='expandItem(items)']"));
        for(int i=0;i<expandBtns.size();i++){
            if(expandBtns.get(i).isDisplayed()){
                expandBtns.get(i).click();
                Common.sleep(500);
            }
            expandBtns = web.findElements(By.xpath(".//*[@ng-click='expandItem(items)']"));
        }

       if(web.findElement(By.cssSelector(".unit.text.h7.ng-binding")).getText().contains(type)){
           web.findElement(By.cssSelector(".unit.text.h7.ng-binding")).click();
        }
            Common.sleep(1000);
        }

    public void selectClearFilter() {
        web.findElement(By.cssSelector(".valign-middle.ng-scope")).click();
        Common.sleep(1000);
    }
    // NGN-16211-QAA: User from multiple BU's should see all Advertiser values in Project Filters code Changes Ends
    private By getHeaderColumnsLocator() {
        return By.cssSelector("[data-dojo-type='common.table.header'] [fieldname]:not(.none-display)");
    }

    private By getProjectsListFieldValuesByColumnClass(String columnClass) {
        return By.cssSelector(String.format("[data-type='tableRowsContent'] .%s .cell-content", columnClass));
    }

    private By getProjectsColumnsDropdownButtonLocator() {
        return By.cssSelector(".simpleDropdown .dropdown-container");
    }

    private By getProjectsColumnCheckboxLocatorByName(String name) {
        return By.xpath(String.format("//*[@data-role='table-control-item'][.//*[normalize-space()='%s']]//input", name));
    }

    private By getProjectsColumnCheckboxLocatorByNameNew(String name) {
        return By.xpath(String.format("//*[@data-role='table-control-item'][contains(.,'%s')]//input", name));
    }

    private By getProjectsColumnLocatorByName(String name) {
        return By.xpath(String.format("//*[@data-dojo-type='common.table.header']//*[@fieldname and not(contains(@class, 'none-display')) and .//*[normalize-space()='%s']]", name));
    }

    public List<String> loadDataFromColumn(String fieldName){
        List<String> orderList = new ArrayList<>();
        String rowLocator =  "//div[@data-type='tableRowsContent']//div[@data-type='tableRow']";
        String projectNameLocator = "//a[@class='first vmiddle link no-decoration project_link pls']";
        String lastActivityUserNameLocator = "//div[contains(@class,'column-17')]//a";
        String mediaTypeUserNameLocator = "//div[contains(@class,'column-9')]";

        int rowsCount = web.findElements(By.xpath(rowLocator)).size();

        for(int i=1;i<=rowsCount;i++){
            if(fieldName.equalsIgnoreCase("Name"))
                orderList.add(web.findElement(By.xpath(rowLocator.concat("[").concat(Integer.toString(i)).concat("]").concat(projectNameLocator))).getText());
            else if(fieldName.equalsIgnoreCase("Last Activity"))
                orderList.add(web.findElement(By.xpath(rowLocator.concat("[").concat(Integer.toString(i)).concat("]").concat(lastActivityUserNameLocator))).getText());
            else if(fieldName.equalsIgnoreCase("Media type"))
                orderList.add(web.findElement(By.xpath(rowLocator.concat("[").concat(Integer.toString(i)).concat("]").concat(mediaTypeUserNameLocator))).getText());
        }

        return orderList;
    }
}