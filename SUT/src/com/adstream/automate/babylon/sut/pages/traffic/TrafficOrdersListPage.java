package com.adstream.automate.babylon.sut.pages.traffic;

import com.adstream.automate.babylon.sut.pages.traffic.element.ApprovePopUp;
import com.adstream.automate.babylon.sut.pages.traffic.element.TrafficNewTabPopUp;
import com.adstream.automate.babylon.sut.pages.traffic.tableList.TrafficOrderList;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.page.controls.Edit;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;

import java.util.ArrayList;
import java.util.List;
import java.util.NoSuchElementException;

import static com.thoughtworks.selenium.SeleneseTestBase.assertTrue;

/**
 * Created by denysb on 04/11/2015.
 */
public class TrafficOrdersListPage extends BaseTrafficPage {
    private static final By isLoaded = By.cssSelector("[ng-app='trafficWeb']");
    private static final By searchField = By.cssSelector("#txt_filter");
    private static final By availableOrders = By.cssSelector("");
    private static final By addNewTabButton = By.cssSelector("[uib-tooltip='Add new tab']");
    private static final By expandAllButton = By.cssSelector("[ng-click^='$expandAllCtrl']");
    // private static final By orderReferenceSelector = By.xpath("//a[@ng-if='$first']/*[last()]/*[last()]/*[last()]");
    private static final By editTabSelector = By.xpath(".//*[@id='tabEditDropdown']");
    private static final By orderReferenceSelector = By.cssSelector("[ng-if='::$first']");
     private static final String CONFIGURE_ITEM ="Configure Order Item";

    private Edit searchOrders;
    public TrafficOrdersListPage(ExtendedWebDriver web) {
        super(web);
        searchOrders = new Edit(this, searchField);
    }

    @Override
    public void load() {
        web.waitUntilElementAppearVisible(isLoaded);
    }

    @Override
    public void isLoaded() {
        assertTrue(web.isElementVisible(isLoaded));
    }


    public void checkOrderVisibility() {
        List<String> availableOrderNames = web.findElementsToStrings(availableOrders);
    }

    public void expandAll() {
        WebElement we = web.findElement(expandAllButton);
        web.getJavascriptExecutor().executeScript("arguments[0].click();", we);
        web.sleep(6000);
     /*   web.findElement(expandAllButton).click();
        web.sleep(4000);*/
    }

    public String verifyColor(String getDestination)
    {


        String getServiceLevelColor=null;
        int destinationCount = web.findElements(By.xpath("//tbody[@class='small']/tr[2]//tbody//tr[2]//table[@class='table-head-inner']/tbody")).size();
        for (int destination = 1; destination <= destinationCount; destination++) {
            String destinationList = web.findElement(By.xpath("//tbody[@class='small']/tr[2]//tbody//tr[2]//table[@class='table-head-inner']/tbody[" + destination + " ]/tr[1]/td[2]")).getText();
            if (destinationList.contains(getDestination.trim())) {
                 getServiceLevelColor = web.findElement(By.xpath("//tbody[@class='small']/tr[2]//tbody//tr[2]//table[@class='table-head-inner']/tbody[" + destination + " ]/tr[1]/td[8]/span")).getAttribute("class");
                break;
            }

        }
        return getServiceLevelColor;
    }


    public ApprovePopUp getApprovePopUpPage(){
        return new ApprovePopUp(this);
    }

    public void openOrderDetailsPage(String orderId) {
        web.sleep(8000);
        web.findElement(By.cssSelector(String.format("a[href='#/details/order/%s']", orderId))).click();
    }

    public void openOrderEditPage(String orderId) {
        web.findElement(By.cssSelector(String.format("a[href*='/ordering#orders/%s']", orderId))).click();
        web.sleep(5000);
    }
    public void openOrderEditPagewithOrderItemId(String orderId,String orderitemid) {
        web.findElement(By.cssSelector(String.format("a[href*='/ordering#orders/%s/items/%s']", orderId,orderitemid))).click();
        web.sleep(5000);
    }

    public TrafficNewTabPopUp openNewTabPopUpWindow() {
        web.click(addNewTabButton);
        return new TrafficNewTabPopUp(this);
    }

    public List<String> getOrderList() {
        List<WebElement> data=web.findElements(orderReferenceSelector);
        List<String> href= new ArrayList<String>();
        for(WebElement w:data){
            String link=w.getAttribute("href");
            href.add(link.split("/")[7]);
        }
        return href;
    }

    public String checkOnHoldStatusForOrder(String orderRefference) {
        TrafficOrderList.TrafficOrder order = new TrafficOrderList(web).getOrderByOrderReference(orderRefference);
        return order.getOnHold();
    }


    public TrafficOrderList getTrafficOrderList() {
        if (!web.isElementVisible(isLoaded))
            throw new NoSuchElementException("Order list is not present on the page!");
        return new TrafficOrderList(web);
    }

    public void clickConfigureOrderTab()
    {
        web.findElement(By.xpath("//schema-config[@uib-tooltip='Configure Order table']/div[@class='dropdown']/button")).click();
    }

    public void clickConfigureOrderItemTab()
    {
        web.findElement(By.xpath("//schema-config[@uib-tooltip='Configure Order Item table']/div[@class='dropdown']/button")).click();
    }

    public void clickConfigureOrderTabSaveButton()
    {
        web.findElement(By.xpath("//schema-config[@uib-tooltip=\"Configure Order table\"]//button[@class=\"btn btn-default btn-md save-button\"]")).click();
    }

    public void closePopup()
    {
        web.findElement(By.xpath("//schema-config[@uib-tooltip=\"Configure Order Item table\"]//button[@class=\"btn btn-default btn-md save-button\"]")).click();
    }


    public void clickApprovalButtons(String button)

    {
        web.waitUntilElementAppear(By.xpath("//small[contains(text(),'" + button + "')]"));
        web.findElement(By.xpath("//small[contains(text(),'" + button + "')]")).click();
    }

    public boolean verifyButtonsatBroadcasterLevel(String button)
    {
        boolean isExist;
        try
        {
            isExist=web.findElement(By.xpath("//*[contains(.," + button + ")]")).isDisplayed();
        }
        catch(Exception e)
        {
            isExist=false;
        }

        return isExist;
    }

    public void selectByIndividualClock(String clockName)
    {


        int itemCount = web.findElements(By.xpath("//table[contains(@ng-class,'TvClock')]/tbody/tr")).size();
        for (int item = 1; item <= itemCount; item++) {
            String clkName = web.findElement(By.xpath("//table[contains(@ng-class,'TvClock')]/tbody/tr[" + item + "]/td[11]/formatted-schema-value[@item='clock']/span[1]/span[1]/span")).getText();
            if (clkName.contains(clockName.trim())) {
                web.findElement(By.xpath("//table[contains(@ng-class,'TvClock')]/tbody/tr[" + item + "]//toggle-select[@for-item='clock']//input")).click();
                break;
            }
        }
    }

    public List<String> getApprovalButtons() {
        List<String> actualApprovalButtons = new ArrayList<>();
        int cnt = web.findElements(By.xpath("//approval-buttons/span")).size();
        for (int appButtons = 1; appButtons <= cnt; appButtons++) {
            String actualApprovalButtonsList = web.findElement(By.xpath("//approval-buttons/span[" + appButtons + "]")).getText().trim();
            actualApprovalButtons.add(actualApprovalButtonsList);
        }
        return actualApprovalButtons;
    }

    public void hideItemsForOrderTable(String visibility,String itemFromList)
    {
        String itemName=null;
        int itemCount = web.findElements(By.xpath("//schema-config[@uib-tooltip='Configure Order table']//div[@class='panel-body']//ul/li")).size();
        for (int item = 1; item <= 20; item++) {
            itemName = web.findElement(By.xpath("//schema-config[@uib-tooltip='Configure Order table']//div[@class='panel-body']//ul/li[" + item + "]//label")).getText();
            if (itemName.contains(itemFromList.trim())) {
                if("unhide".equalsIgnoreCase(visibility)){
                    if( !web.isElementVisible(By.xpath("//schema-config[@uib-tooltip='Configure Order table']//div[@class='panel-body']//ul/li[" + item + "]//input[contains(@class,\"ng-not-empty\")]")))
                        web.findElement(By.xpath("//schema-config[@uib-tooltip='Configure Order table']//div[@class='panel-body']//ul/li[" + item + "]")).click();
                    break;
                }
                if("hide".equalsIgnoreCase(visibility)){
                    if( web.isElementVisible(By.xpath("//schema-config[@uib-tooltip='Configure Order table']//div[@class='panel-body']//ul/li[" + item + "]//input[contains(@class,\"ng-not-empty\")]")))
                        web.findElement(By.xpath("//schema-config[@uib-tooltip='Configure Order table']//div[@class='panel-body']//ul/li[" + item + "]")).click();
                    break;
                }
               break;
            }
        }
    }

    public void hideItemsForOrderItemTable(String visibility,String itemFromList)
    {
        String itemName=null;
        int itemCount = web.findElements(By.xpath("//schema-config[@uib-tooltip='Configure Order Item table']//div[@class='panel-body']//ul/li")).size();
        for (int item = 1; item <= 20; item++) {
            itemName = web.findElement(By.xpath("//schema-config[@uib-tooltip='Configure Order Item table']//div[@class='panel-body']//ul/li[" + item + "]//label")).getText();
            if (itemName.contains(itemFromList.trim())) {
                if("unhide".equalsIgnoreCase(visibility)){
                    if( !web.isElementVisible(By.xpath("//schema-config[@uib-tooltip='Configure Order Item table']//div[@class='panel-body']//ul/li[" + item + "]//input[contains(@class,\"ng-not-empty\")]")))
                    web.findElement(By.xpath("//schema-config[@uib-tooltip='Configure Order Item table']//div[@class='panel-body']//ul/li[" + item + "]")).click();
                    break;
                }
                if("hide".equalsIgnoreCase(visibility)){
                        if(web.isElementVisible(By.xpath("//schema-config[@uib-tooltip='Configure Order Item table']//div[@class='panel-body']//ul/li[" + item + "]//input[contains(@class,\"ng-not-empty\")]")))
                           web.findElement(By.xpath("//schema-config[@uib-tooltip='Configure Order Item table']//div[@class='panel-body']//ul/li[" + item + "]")).click();
                    break;
                }

            }
        }
    }


    public List<String> verifyItemsForOrderTable()
    {
        String ItemList=null;
        List<String> orderTableItems = new ArrayList<>();
        int cnt = web.findElements(By.xpath("//table[@class=\"table-body no-border\"]/thead/tr/th")).size();
        for (int item = 4; item <= cnt; item++) {
            ItemList = web.findElement(By.xpath("//table[@class=\"table-body no-border\"]/thead/tr/th[" + item + "]")).getText();
            orderTableItems.add(ItemList);
        }
        return orderTableItems;
    }

    public List<String> verifyItemsForOrderItemTable()
    {
        String ItemList=null;
        List<String> OrederItemTable = new ArrayList<>();
        int cnt = web.findElements(By.xpath("//table[@ng-class=\"{'no-border': $tvClocksListCtrl.tab.internalTabType === 'TvClock' || $tvClocksListCtrl.tab.internalTabType === 'Clock'}\"]/thead/tr/th")).size();
        for (int item = 4; item <= cnt; item++) {
            ItemList = web.findElement(By.xpath("//table[@ng-class=\"{'no-border': $tvClocksListCtrl.tab.internalTabType === 'TvClock' || $tvClocksListCtrl.tab.internalTabType === 'Clock'}\"]/thead/tr/th[" + item + "]")).getText();
            OrederItemTable.add(ItemList);
        }
        return OrederItemTable;
    }

    public String getAddNewTabTitle(){
        WebElement Star= web.findElement(By.xpath("//button[@class='btn btn-default btn-xs ng-show']"));
        return Star.getAttribute("uib-tooltip");
    }

    public List<String> getAllTab(){
        List<String> tabNames=new ArrayList<String>();
        List<WebElement> elem=web.findElements(By.xpath("//a[@class='nav-link']/span"));
        for(WebElement el:elem)
            tabNames.add(el.getText());
        return tabNames;
    }

    public String getConfigureOrderTitle(String title){
        int position=title.equals(CONFIGURE_ITEM)?1:0;
        if(position==0)
            return web.findElement(By.xpath("//button[@class='btn btn-default btn-md download-button']")).getAttribute("uib-tooltip");
        else
            return web.findElement(By.xpath("//div[@class='schema-config-block']/schema-config")).getAttribute("uib-tooltip");

    }

    public WebElement getSLA(){
        return web.findElement(By.cssSelector("[ng-switch-when=\"orderServiceLevel\"] span"));

    }

    public String getReorderTabTitle(){
        return web.findElement(By.id("reorderTabButton")).getAttribute("uib-tooltip");
    }

    public String getAllTabTitle(){
        return web.findElement(By.xpath("addTabButton")).getAttribute("uib-tooltip");
    }

    public void editTab(){
        web.findElement(editTabSelector).click();
        web.findElement(By.cssSelector("[ng-click='$tabOptionsCtrl.editTab()']")).click();
    }

    public boolean verifyPresenceOfDestination(String destination) {
        String getdestinationList = "";
        boolean flag = false;
        int rowCount = web.findElements(By.xpath("//table[@class='table-body tv-destinations']/tbody/tr[@ng-repeat='destination in clock.getDestinations()']")).size();
        for (int row = 1; row <= rowCount; row++) {
            getdestinationList = web.findElement(By.xpath("//table[@class='table-body tv-destinations']/tbody/tr[" + row + "]/td[2]")).getText();
            if (getdestinationList.equalsIgnoreCase(destination.trim())) {
                flag = true;
            }
        }
        return flag;
    }




    public String verifyDestinationDetailsAtClockLevel(String destination,String key) {
        String getFieldValue="";
        int rowCount = web.findElements(By.xpath("//table[@class='table-body tv-destinations']/tbody/tr[@ng-repeat='destination in clock.getDestinations()']")).size();
        for (int row = 1; row <= rowCount; row++) {
            int tdCount = web.findElements(By.xpath("//table[@class='table-body tv-destinations']/tbody/tr[" + row + "]/td")).size();
            for (int td = 1; td <= tdCount; td++) {
                String getDestination = web.findElement(By.xpath("//table[@class='table-body tv-destinations']/tbody/tr[" + row + "]/td[" + td +"]")).getText();
                if (getDestination.equalsIgnoreCase(destination)) {
                    List <WebElement> list= web.findElements(By.xpath("//table[@class='table-body tv-destinations']/thead/tr/td"));
                    List <String> columnTitles = new ArrayList<String>();
                    for (WebElement webElement : list) {
                        columnTitles.add(webElement.getText().trim());
                    }
                    for (int i=0; i<columnTitles.size();i++){
                        List<WebElement> cells = web.findElements(By.xpath("//table[@class='table-body tv-destinations']/tbody/tr[" + row + "]/td"));;
                        if(key.equalsIgnoreCase(columnTitles.get(i))) {
                            switch (columnTitles.get(i)) {
                                case "DESTINATION":
                                    getFieldValue = cells.get(i).getText();
                                    break;
                                case "BROADCASTER APPROVAL STATUS":
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

}
