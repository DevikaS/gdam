package com.adstream.automate.babylon.sut.pages.traffic;

import com.adstream.automate.babylon.sut.pages.adbank.BaseAdBankPage;
import com.adstream.automate.babylon.sut.pages.traffic.element.Comment;
import com.adstream.automate.babylon.sut.pages.traffic.element.ReassignOrdersInTraffic;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.page.controls.Button;
import com.adstream.automate.page.controls.DojoDropDown;
import com.adstream.automate.page.controls.Edit;
import com.adstream.automate.utils.Common;
import org.openqa.selenium.*;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by denysb on 26/11/2015.
 */
public class BaseTrafficPage extends BaseAdBankPage {

    protected static final By searchField = By.cssSelector("[ng-enter^='$tabSearchCtrl.updateSearchText']");
    private static final By searchhDropDownButtonlocator = By.cssSelector(".input-group-addon.dropdown");
    private static final By searchDropDown = By.cssSelector(".input-group-addon.dropdown.open");
    private static final By downloadCSVLink = By.cssSelector("[uib-tooltip=\"Download CSV\"]");
    private final static By backButtonSelector = By.cssSelector("[ng-click=\"$detailsPageCtrl.goBack()\"]");
    private Edit searchOrders;
    private Button searchDropDownButton;
    private DojoDropDown searchType;
    //private final static By scrollRightTabRowSelector = By.cssSelector("[ng-click='moveScrollRight()']");
    private final static By scrollRightTabRowSelector = By.cssSelector("[ng-click=\"$tabListBarCtrl.scrollTabListBar(100)\"]");
    private final static By progressBarPageLoadingSelector = By.cssSelector("#loading-bar");
    private static final By addCommentButton = By.cssSelector("[ng-click=\"$selectionButtonsCtrl.addComment()\"]");
    private static final By reassignOrdersButton = By.cssSelector("[ng-click^=\"$selectionButtonsCtrl.reassign()\"]");
    private final static long pageLoadingTimeOut = 20 * 1000; //20sec
    private static final By selectedTabSelector = By.cssSelector(".uib-tab.active");
    private static final By searchByParticularSchemaButton = By.cssSelector(".tab-actions-container>tab-search .dropdown-toggle");
    protected static final By commentSelector = By.cssSelector(".comment-block-item-wrapper div:nth-child(2)");
    protected static final By commentsSelector = By.cssSelector(".comment-block-item-wrapper div:nth-child(2) p");
    protected static final By SuppDocSelector = By.cssSelector("[ng-repeat='doc in $supportingDocsCtrl.documents'] td:nth-child(1)");
    private final static long tabVisible = 60 * 6000;
    private Button searchBy;
    private Button scrollRight;
    private static final By AssignToMe = By.xpath("//small[contains(text(),'Assign to me')]");
    private static final By UnassignMe = By.xpath("//small[contains(text(),'Unassign me')]");
    private static final By ReassignOrder = By.xpath("//a[contains(text(),'Reassign Order')]");
    private static final By toggleDropdown = By.xpath("//button[@class='btn btn-info btn-md dropdown-toggle']");


    public BaseTrafficPage(ExtendedWebDriver web) {
        super(web);
        searchBy = new Button(this, searchByParticularSchemaButton);
        scrollRight = new Button(this, scrollRightTabRowSelector);
        searchOrders = new Edit(this, searchField);
        searchType = new DojoDropDown(this,searchDropDown);
        searchDropDownButton = new Button(this, searchhDropDownButtonlocator);
    }

    public void enterSearchCriteria(String value) {
        searchOrders.type(value);
        web.findElement(searchField).sendKeys(Keys.ENTER);
        web.click(By.cssSelector("[ng-click=\"$tabSearchCtrl.updateSearchText($tabSearchCtrl.searchText)\"]"));
        web.sleep(5000);
    }

    public void selectAll(){
        web.findElement(By.xpath("//*[@class=\"btn btn-default search-type dropdown-toggle\"]")).click();
        for(WebElement we:web.findElements(By.xpath("//*[@ng-click=\"$tabSearchCtrl.updateSearchFilter(filter)\"]"))){
            if(we.getText().equalsIgnoreCase("All")){
                we.click();
                break;
            }
        }
    }

    public void clearSearchCriteria() {

        web.findElement(searchField).clear();
        web.findElement(searchField).sendKeys(Keys.ENTER);
        web.sleep(5000);
    }

    public void clickDownloadCSVLink() {

        web.findElement(downloadCSVLink).click();
        web.sleep(5000);
    }

    public void checkboxSelectAllAtClockLevel()
    {
        web.waitUntilElementAppearVisible(By.xpath("//select-all[@items='$tvClocksListCtrl.clocks']//input"));
        if(!web.findElement(By.xpath("//select-all[@items='$tvClocksListCtrl.clocks']//input")).isSelected())
        web.findElement(By.xpath("//select-all[@items='$tvClocksListCtrl.clocks']//input")).click();
    }


    public void checkboxSelectAllAtSendLevel()
    {
        web.waitUntilElementAppearVisible(By.xpath("//select-all[@items='$tvDestinationsListCtrl.destinations']//input"));
        if(!web.findElement(By.xpath("//select-all[@items='$tvDestinationsListCtrl.destinations']//input")).isSelected())
        web.findElement(By.xpath("//select-all[@items='$tvDestinationsListCtrl.destinations']//input")).click();
    }


    public void selectTab(String tab) {
        long start = System.currentTimeMillis();
        boolean tabFound=false;
        while(!web.isElementVisible(By.xpath(String.format("//a[contains(@class,'nav-link')]//span[contains(text(),'%s')]", tab)))) {
            if (System.currentTimeMillis() - start > tabVisible) {
                throw new TimeoutException("Timeout during waiting to see " + tab);
            }
            web.findElement(By.cssSelector("[ng-click='$tabListBarCtrl.scrollTabListBar(100)']")).click();
        }
        web.findElement(By.xpath(String.format("//a[@class='nav-link']//span[contains(text(),'%s')]", tab))).click();

    }

    public void deleteTab() {
        web.findElement(By.xpath("//button[@id='tabEditDropdown']")).click();
        web.findElement(By.xpath("//a[@ng-click='$tabOptionsCtrl.deleteTab()']")).click();
        web.findElement(By.xpath("//button[@ng-click='$confirmationModalCtrl.allowConfirmation()']")).click();
        // WebElement element1 = web.findElement(By.xpath("//span[contains(text(),'OrderStatusAndMarket')]"));

        // web.getActions().moveToElement(element1).perform();
    }

    public void clickAllOption()
    {
        web.findElement(By.xpath("//input[@ng-checked='$selectAllCtrl.toggle']")).click();
    }



    public void clickCommonButtons(String button)
    {
        switch (button) {
            case "Assign to me":
                web.findElement(AssignToMe).click();
                break;
            case "Unassign me":
                web.findElement(UnassignMe).click();
                break;
            case "Back":
                web.findElement(backButtonSelector).click();
                break;

            default:
                throw new IllegalArgumentException("Unknown button name given");
        }
    }



    public boolean verifyCommonButtons(String button) {

        boolean isExist;
        try {
            switch (button) {
                case "Assign to me":
                    isExist = web.findElement(AssignToMe).isDisplayed();
                    break;
                case "Unassign me":
                    isExist = web.findElement(UnassignMe).isDisplayed();
                    break;
                case "Reassign Order":
                    web.findElement(toggleDropdown).click();
                    Common.sleep(2000);
                    isExist=web.findElement(ReassignOrder).isDisplayed();
                    break;
                default:
                    throw new IllegalArgumentException("Unknown button name given");
            }
        }
        catch(Exception e)
        {
            isExist=false;
        }
        return isExist;
    }

    public boolean isTabVisible(String tab) {
        return web.isElementVisible(By.xpath(String.format("//a[@class='nav-link']//span[contains(text(),'%s')]", tab)));
    }

    public boolean isTabAvailable(String tab) {
        return web.isElementPresent(By.xpath(String.format("//a[@class='nav-link']//span[contains(text(),'%s')]", tab)));
    }




    public ReassignOrdersInTraffic clickAndGetAssignOrdersPopUp(){
        web.findElement(toggleDropdown).click();
        Common.sleep(2000);
        web.findElement(ReassignOrder).click();
        // web.click(reassignOrdersButton);
        return new ReassignOrdersInTraffic(this);
    }


    public void scrollTabRowRight() {
        scrollRight.click();
    }

    public void selectSearchForParticularSchema(String value) {
        By schemaSelector = By.xpath(String.format("//a[contains(text(),'%s')]", value));
        searchBy.click();
        web.findElement(schemaSelector).click();
    }

    public void enterSearchCriteriaForParticularSchemaType(String type, String value) {
        selectSearchForParticularSchema(type);
        enterSearchCriteria(value);
    }

    public String verifyHouseNumberGroupingOnOrderListPage(String getdestination) {
        String getHouseNumber=null;
        Common.sleep(5000);
        int destinationCount = web.findElements(By.xpath("//table[@class='table-head-inner']/tbody")).size();
        for (int destination = 1; destination <= destinationCount; destination++) {
            String destinationList = web.findElement(By.xpath("//table[@class='table-head-inner']/tbody[" + destination + " ]/tr[1]/td[2]")).getText();
            if (destinationList.contains(getdestination.trim())) {
                getHouseNumber = web.findElement(By.xpath("//table[@class='table-head-inner']/tbody[" + destination + " ]/tr[1]/td[3]//input")).getAttribute("value");
                if(getHouseNumber.isEmpty())
                {
                    getHouseNumber=null;
                }
                break;
            }

        }
        return getHouseNumber;
    }

    public boolean isCustomTabVisible(String tabName) {

        boolean flag=true;
        try {
            return web.findElement(By.xpath(String.format("//span[contains(text(),'%s')]",tabName))).isDisplayed();
        }catch(Exception E)
        {
            flag=false;
        }

        return flag;

    }

    public void waitUntilLoadOrderSummarySpinnerDisappears() {
        getDriver().sleep(20000);
        getDriver().waitUntilElementDisappear(By.className("orders-spinner"));
        getDriver().sleep(2000);
    }

    public void waitUntilPageWillBeLoaded(Integer timeOut){
        long start = System.currentTimeMillis();
        do {
            if (timeOut > 0)
                Common.sleep(timeOut * 2);
            if (System.currentTimeMillis() - start > pageLoadingTimeOut) {
                throw new TimeoutException("Timeout during Order Item page Loading!");
            }
        } while (web.isElementPresent(progressBarPageLoadingSelector));
    }

    public BaseTrafficPage clickAddComment(){
        web.findElement(addCommentButton).click();
        return this;
    }

    public Comment getCommentPage(){
        return new Comment(this);
    }

    public ReassignOrdersInTraffic getReassignOrdersPage(){
        return new ReassignOrdersInTraffic(this);
    }

    public String getSelectedTabName(){
        return web.findElement(selectedTabSelector).getText();
    }


    protected String convertFieldName(String fieldName) {
        switch (fieldName.toLowerCase()) {
            case "media agency":
                return "mediaAgency";
            case "clock service level":
                return "orderItemServiceLevel";
            case "service level":
                return "orderServiceLevel";
            case "service level minutes":
                return "orderServiceLevelMinutes";
            case "clock service level minutes":
                return "orderItemServiceLevelMinutes";
            case "title":
                return "title";
            case "submitted date":
                return "submitted";
            case "clock number":
                return "clockNumber";
            case "first air date":
                return "firstAirDate";
            case "last comment":
                return "orderLastComment";
            case "send last comment":
                return "deliveryItemComments";
            case "agency":
                return "agencyName";
            case "market":
                return "market";
            default:
                throw new IllegalArgumentException("Sort Field " + fieldName + " is absent");
        }
    }

    public void clickOnSortFieldTitle(String fieldName){
        getSortColumnElement(fieldName).click();
    }

    public boolean isSortFieldSelected(String fieldName){
        return getSortColumnElement(fieldName).isDisplayed();
    }

    public String getSortFieldOrder(String fieldName){
        if(getInnerColumnElement(fieldName)!=null) {
            if (getInnerColumnElement(fieldName).getAttribute("class").contains("glyphicon-chevron-up")) {
                return "asc";
            } else if (getInnerColumnElement(fieldName).getAttribute("class").contains("glyphicon-chevron-down")) {
                return "desc";
            } else {
                return "";
            }
        }else{
            return "";
        }
    }

    // mediaAgency, orderItemServiceLevel, title, clockNumber


    protected WebElement getSortColumnElement(String fieldName){
        WebElement retEl=null;
        List<WebElement> el=web.findElements(By.cssSelector("th[class^='table-head'][ng-click*='{schemaDefinition: definition}'] > p"));
        for(WebElement wb:el) {
            if (wb.getText().equalsIgnoreCase(fieldName))
                retEl = wb;
        }
        return retEl;
    }

    protected WebElement getInnerColumnElement(String fieldName){
        WebElement elem=getSortColumnElement(fieldName);
        WebElement inner;
        try{
            inner=elem.findElement(By.xpath("../span"));
        }
        catch(Exception e){
            inner=null;
        }
        return inner;
    }

    public List<String> getRowElementsValue(String fieldName){
        return web.findElementsToStrings(By.cssSelector(String.format("[name-row='%s']", convertFieldName(fieldName))));
    }


    public String getMarketForInternalOrder(String market) {
        String getMarket="";
       // int orderCount = web.findElements(By.xpath("//*[@id='ordersTable']/div/div/ng-include/table/tbody")).size();
        int orderCount = web.findElements(By.cssSelector("[ng-repeat-start=\"order in $tvOrdersListCtrl.orders\"]")).size();

        for (int order = 1; order <= orderCount; order++) {
          //  String marketList = web.findElement(By.xpath("//*[@id='ordersTable']/div/div/ng-include/table/tbody[" + order + " ]//td[@name-row='market']")).getText();
            String marketList = web.findElement(By.xpath("//tv-orders-list/table/tbody/tr[" + order + "]/td[9]")).getText();
            if (marketList.contains(market.trim())) {
               // getMarket = web.findElement(By.xpath("//*[@id='ordersTable']/div/div/ng-include/table/tbody[" + order + " ]//td[@name-row='market']")).getText();
                getMarket = web.findElement(By.xpath("//tv-orders-list/table/tbody/tr[\" + order + \"]/td[9]")).getText();
                break;
            }
        }
        return getMarket;
    }




    public void pinTab(String tabName){
        long start = System.currentTimeMillis();
        boolean pinFound=false;
        do {
            try {
                if (System.currentTimeMillis() - start > tabVisible) {
                    throw new TimeoutException("Timeout during waiting to see " + tabName);
                }
                web.waitUntilElementAppear(By.xpath(String.format("//a[contains(@class,'nav-link')]//span[contains(text(),'%s')]", tabName)));
                WebElement anch=web.findElement(By.xpath(String.format("//a[contains(@class,'nav-link')]//span[contains(text(),'%s')]", tabName)));
                WebElement pin=anch.findElement(By.xpath("..//following-sibling::span[contains(@class,'pin-button')]/i[contains(@class,'pinned-tabs')]"));
                pin.click();
                pinFound=true;
            } catch (Exception e) {
                web.findElement(By.cssSelector("[ng-click='$tabListBarCtrl.scrollTabListBar(100)']")).click();
            }
        }while(!pinFound);
    }

    public boolean checkFirstTabName(String tabName){
        long start = System.currentTimeMillis();
        boolean found=false;
        do {
            try {
                if (System.currentTimeMillis() - start > tabVisible) {
                    throw new TimeoutException("Timeout during waiting to see " + tabName);
                }
                web.findElement(By.cssSelector("[ng-click='$tabListBarCtrl.scrollTabListBar(-100)']")).click() ;
            } catch (Exception timeException) {
                timeException.printStackTrace();
            }
            found=web.findElement(By.cssSelector("[class='tab-list'] li:nth-child(1) a:nth-child(1)")).getText().equalsIgnoreCase(tabName);
        }while(!found);
        return found;
    }


    public String getInternalOrderStatus(String destination) {
        int rowCount = web.findElements(By.xpath("//table[@ng-if='$tvOrdersListCtrl.schema']/tbody/tr")).size();
        boolean isDestination = false;
        String status="";
        for (int order = 1; order <= rowCount; order++) {
            web.waitUntilElementAppear(By.xpath("//table[@ng-if='$tvOrdersListCtrl.schema']/tbody/tr[" + order + "]/td[1]//toggle-expand/span[@class='icon-Add']"));
                    WebElement expand = web.findElement(By.xpath("//table[@ng-if='$tvOrdersListCtrl.schema']/tbody/tr[" + order + "]/td[1]//toggle-expand/span[@class='icon-Add']"));
            web.getJavascriptExecutor().executeScript("arguments[0].click();", expand);
            Common.sleep(1000);
            try {
                isDestination  = web.findElement(By.xpath("//tr[@ng-if='$tvOrdersListCtrl.isOrderExpanded(order)']//table/tbody/tr//td//span[contains(.,'"+destination+"')]")).isDisplayed();
            }
            catch(Exception e){}
            if (isDestination == true) {
                WebElement expanditem = web.findElement(By.xpath("//tr[@ng-if='$tvOrdersListCtrl.isOrderExpanded(order)']//table/tbody/tr//td[1]/toggle-expand/span[@class='icon-Add']"));
                web.getJavascriptExecutor().executeScript("arguments[0].click();", expanditem);
                Common.sleep(1000);
                status = web.findElement(By.xpath("//tr[@ng-if='$tvClocksListCtrl.isClockExpanded(clock)']//table/tbody/tr[@ng-repeat='destination in clock.getDestinations()']/td[4]")).getText();

            } else {
                WebElement collapse = web.findElement(By.xpath("//table[@ng-if='$tvOrdersListCtrl.schema']/tbody/tr[" + order + "]/td[1]//toggle-expand/span[@class='icon-minus']"));
                web.getJavascriptExecutor().executeScript("arguments[0].click();", collapse);
                Common.sleep(1000);

            }
        }
        return status;
    }

    public String getOrderItemDetailsForClones(String destination,String key) {
        String getFieldValue="";
        int rowCount = web.findElements(By.xpath("//table[@ng-if='$tvClocksListCtrl.schema']/tbody/tr[@ng-repeat-start='clock in $tvClocksListCtrl.clocks track by clock._id']")).size();
        for (int row = 1; row <= rowCount; row++) {
            int tdCount = web.findElements(By.xpath("//table[@ng-if='$tvClocksListCtrl.schema']/tbody/tr[" + row + "]/td")).size();
            for (int td = 1; td <= tdCount; td++) {
                String getDestination = web.findElement(By.xpath("//table[@ng-if='$tvClocksListCtrl.schema']/tbody/tr[" + row + "]/td[" + td +"]")).getText();
                if (getDestination.trim().equalsIgnoreCase(destination.trim())) {
                    List <WebElement> list= web.findElements(By.xpath("//table[@ng-if='$tvClocksListCtrl.schema']/thead/tr/th"));
                    List <String> columnTitles = new ArrayList<String>();
                    for (WebElement webElement : list) {
                        columnTitles.add(webElement.getText().trim());
                    }
                    for (int i=0; i<columnTitles.size();i++){
                        List<WebElement> cells = web.findElements(By.xpath("//table[@ng-if='$tvClocksListCtrl.schema']/tbody/tr[" + row + "]/td"));
                        if(key.equalsIgnoreCase(columnTitles.get(i).trim())) {
                            switch (columnTitles.get(i).trim()) {

                                case "Ads Delivered":
                                    getFieldValue = cells.get(i).getText();
                                    break;
                                case "Cloned":
                                    getFieldValue = cells.get(i).getText();
                                    break;
                                case "Destination Name":
                                    getFieldValue = cells.get(i).getText();
                                    break;
                                case "Order Item Status":
                                    getFieldValue = cells.get(i).getText();
                                    break;

                                default:
                                    throw new IllegalArgumentException("Unknown field type given");
                            }
                            break;
                        }
                    }

                    break;

                }
            }
        }
        return getFieldValue;

    }



    public String verifyDestinationDetailsForClones(String destination,String key) {
        String getFieldValue="";
        int rowCount = web.findElements(By.xpath("//table[@class='table-body no-border']/tbody/tr[@ng-repeat-start='clock in $tvClocksListCtrl.clocks track by clock._id']")).size();
        for (int row = 1; row <= rowCount; row++) {
            int tdCount = web.findElements(By.xpath("//table[@class='table-body no-border']/tbody/tr[" + row + "]/td")).size();
            for (int td = 1; td <= tdCount; td++) {
                String getDestination = web.findElement(By.xpath("//table[@class='table-body no-border']/tbody/tr[" + row + "]/td[" + td +"]")).getText();
                if (getDestination.equalsIgnoreCase(destination)) {
                    web.findElement(By.xpath("//table[@class='table-body no-border']/tbody/tr[" + row + "]/td[1]")).click(); //expand the clock
                    switch(key)
                    {
                        case "Broadcaster Approval Status":
                            getFieldValue = web.findElement(By.xpath("//span[@ng-switch-when='broadcasterStatus']//span[2]")).getText();
                            break;
                        default:
                            throw new IllegalArgumentException("Unknown field type given");
                    }
                    web.findElement(By.xpath("//table[@class='table-body no-border']/tbody/tr[" + row + "]/td[1]")).click(); //collapse the clock
                    break;
                }
            }
        }
        return getFieldValue;
    }
}
