package com.adstream.automate.babylon.sut.pages.NewLibrary.pages;

import com.adstream.automate.babylon.sut.pages.NewLibrary.elements.LibAcceptAssetSharedCategory;
import com.adstream.automate.babylon.sut.pages.NewLibrary.elements.LibRemoveCollectionPopup;
import com.adstream.automate.babylon.sut.pages.NewLibrary.elements.LibraryWalkMePopup;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.utils.Common;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;

import java.util.ArrayList;
import java.util.List;

import static com.thoughtworks.selenium.SeleneseTestBase.assertTrue;

/**
 * Created by Janaki.Kamat on 22/05/2017.
 */
public class CollectionPage extends LibraryAsset<CollectionPage> {
    private static final By CHECK_ON_LOAD=By.cssSelector("collections-list");
    private static final By searchForCollectionLocator = By.cssSelector("input[placeholder='Search for collection']");
    private static final By clearSearchCollectionLocator = By.cssSelector("[ng-click=\"$ctrl.clearSearchText()\"]");
    private static final By sharedWithMeLocator = By.xpath("//inbox-collections-tree//ads-ui-tree-item[@id=\"shared\"]");
    private static final By sharedAgencyLocator = By.xpath("//ads-ui-tree-item[@ng-repeat=\"inbox in ::$ctrl.inboxAgencies track by inbox._id\"]");
    private static final By sharedCollectionLocator = By.xpath("//ads-ui-tree-item[@ng-repeat=\"child in $ctrl.children track by child._id\"]//div[contains(@class,\"tree-item-title\")]");
    private static final By acceptButtonLocator = By.cssSelector("ads-md-button[click=\"$ctrl.acceptAssets($event)\"] button");
    private static final By rejectButtonLocator = By.cssSelector("ads-md-button[click=\"$ctrl.rejectAssets($event)\"] button");
    private static final String parentcollectonLocator = "//div[@class=\"tree-item-title link\"]//*[@data-role=\"tree-item-group-name\"]";
    private static final String collectonLocator = "//div[@class=\"tree-item-title link\"]//*[@data-role=\"tree-item-name\"]";

    public  CollectionPage(ExtendedWebDriver web){
        super(web);
    }

    public void load() {
        web.waitUntilElementAppearVisible(CHECK_ON_LOAD);
    }

    public void isLoaded() throws Error {
        new LibraryWalkMePopup(this).clickClose();
        assertTrue(web.isElementVisible(CHECK_ON_LOAD));
    }

    public void expandCollectionsList() {
        int i, limit = 30;
        for (i = 0; i < limit && web.isElementPresent(getExpandCollectionListLocator()); i++) {
            web.click(getShowOptionsLink());
            Common.sleep(1000);
        }
        if (i >= limit && web.isElementPresent(getExpandCollectionListLocator())) {
            throw new RuntimeException("Too much collections or library page hangs.");
        }
    }

    public List<String> getListOfCollectionsNames() {
        if (web.isElementVisible(By.cssSelector("[ng-repeat=\"collection in $ctrl.collections\"]")))
            return web.findElementsToStrings(By.cssSelector("[ng-repeat=\"collection in $ctrl.collections\"] [ng-repeat=\"p in $ctrl.parents\"] + div span"));
        else if (web.isElementVisible(By.cssSelector("[ng-repeat=\"child in $ctrl.children track by child._id\"]")))
            return web.findElementsToStrings(By.cssSelector("[ng-repeat=\"child in $ctrl.children track by child._id\"] .tree-item-title span"));
        else if(web.isElementVisible(By.xpath("//ads-ui-tree-item[@name='My Collections']//span[@ng-if='!$ctrl.isToggled']"))){
            web.findElement(By.xpath("//ads-ui-tree-item[@name='My Collections']//span[@ng-if='!$ctrl.isToggled']")).click();
            Common.sleep(1000);
            return web.findElementsToStrings(By.xpath("//ads-ui-tree-item[@name='My Collections']//div[@class='tree-item-title link']/span"));
        }
        else if(web.isElementVisible(By.xpath("//div[@class='tree-item-title link']/span")))
        {
            return web.findElementsToStrings(By.xpath("//div[@class='tree-item-title link']/span"));
        }
        else
            return new ArrayList<String>();
    }



    private By getExpandCollectionListLocator() {
        return By.xpath("//*[@class=\"tree-item-title\"]/following-sibling::div[@class=\"tree-item-toggle\"]/a/span[@ng-if=\"!$ctrl.isToggled\"]");
    }

    public List<WebElement> getListOfCollections(){
        return web.findElements(By.xpath("//collection-search-item//ads-agency-icon"));
    }

    public  List<String> getMyCollections()
    {
        List<String> collect = null;
         if(web.isElementVisible(By.xpath("//ads-ui-tree-item[@name='My Collections']//span[@code='chevron-fill-down']"))) {
             web.findElement(By.xpath("//ads-ui-tree-item[@name='My Collections']//span[@code='chevron-fill-down']")).click();
         }
         Common.sleep(1000);
        collect= web.findElementsToStrings(By.xpath("//div[@class='tree-item-title link']/span"));
        return collect;
    }


    public void searchCollection(String collectionName){
        web.typeClean(searchForCollectionLocator,collectionName);
        Common.sleep(1000);
    }

    public void clickCollectionUnderMyCollection(String collectionName)
    {
        if(web.isElementVisible(By.xpath("//ads-ui-tree-item[@name='My Collections']//span[@code='chevron-fill-down']"))) {
            WebElement element = web.findElement(By.xpath("//ads-ui-tree-item[@name='My Collections']//span[@code='chevron-fill-down']"));
            web.getJavascriptExecutor().executeScript("arguments[0].click();", element);
        }
        web.waitUntilElementAppear(By.xpath("//ads-ui-tree-item[@name='" + collectionName + "']//div[@class='tree-item-title link']/span"));
        web.findElement(By.xpath("//ads-ui-tree-item[@name='" + collectionName + "']//div[@class='tree-item-title link']/span")).click();
    }

    public boolean isTrashExist()
    {
        return web.isElementVisible(By.xpath("//ads-ui-tree-item[@name='Trash']//span[contains(.,'Trash')]"));
    }

    public void clickCollectionName(String collectionName){
        List<WebElement> elements=getListOfCollections();
        for(WebElement elem:elements){
            if(elem.findElement(By.xpath("following-sibling::div[@class=\"collection-search-item-name\"]//span")).getText().equalsIgnoreCase(collectionName)) {
                elem.click();
                break;
            }
        }
    }


    public String getMessageNoSearchMatches(){
        return web.findElement(By.cssSelector("[ng-if=\"$ctrl.isInitialized && !$ctrl.collections.length\"]")).getText();
    }

    public void clearSearchCollection(){
        web.findElement(clearSearchCollectionLocator).click();
    }

    public List<String> getSubCollectionNames(String agencyName){
        if(web.isElementVisible(By.xpath("//ads-ui-tree-item[@name='" + agencyName + "']//span[@code='chevron-fill-down']")))
        {
           web.findElement(By.xpath("//ads-ui-tree-item[@name='" + agencyName + "']//span[@code='chevron-fill-down']")).click();
        }
        return web.findElementsToStrings(By.xpath("//div[@class='tree-item-title link']/span"));
    }

    public List<String> getParentCollectionNames(){
        return web.findElementsToStrings(By.xpath("//collections-tree//ads-ui-tree-item//div[contains(@class,'tree-item-title')]"));
    }

    public List<String> getCollectionUnderParentCollections(String collectionName){
        if(web.isElementVisible(By.xpath("//ads-ui-tree-item[@name='" + collectionName + "']//span[@code='chevron-fill-down']")))
        {
            WebElement ele = web.findElement(By.xpath("//ads-ui-tree-item[@name='" + collectionName + "']//span[@code='chevron-fill-down']"));
            web.getJavascriptExecutor().executeScript("arguments[0].click();", ele);
        }
        return web.findElementsToStrings(By.xpath("//div[@class='tree-item-title link']/span"));
    }

    public List<String> getCollectionUnderAgency(String agency){
        List<String> subCollections= new ArrayList<String>();
        List<WebElement> parentCollections = web.findElements(By.xpath("//div[@ng-repeat=\"agency in $ctrl.agencies track by $index\"]/*[@on-toggle=\"$ctrl.collectionsService.onAgencyToggle(id, event)\"]//*[@class=\"tree-item-title\"]"));
        for(WebElement elem:parentCollections){
            if(elem.getText().equalsIgnoreCase(agency)){
                if(web.isElementPresent(By.xpath(String.format("//div[@ng-repeat=\"agency in $ctrl.agencies track by $index\"]/*[@on-toggle=\"$ctrl.collectionsService.onAgencyToggle(id, event)\"][..//div[@class=\"tree-item-title\"]/span[contains(text(),\"%s\")]]//*[@code=\"chevron-fill-down\"]", agency))))
                    web.click(By.xpath(String.format("//div[@ng-repeat=\"agency in $ctrl.agencies track by $index\"]/*[@on-toggle=\"$ctrl.collectionsService.onAgencyToggle(id, event)\"][..//div[@class=\"tree-item-title\"]/span[contains(text(),\"%s\")]]//*[@code=\"chevron-fill-down\"]", agency)));
                Common.sleep(1000);
                for(WebElement el:elem.findElements(By.xpath("ancestor::node()[4]//div[contains(@class,\"tree-item-children\")]//div[contains(@class,\"tree-item-row\")]//div[contains(@class,\"tree-item-title\")]")))
                    subCollections.add(el.getText());
            }
        }
        return subCollections;
    }

    public List<String> getCollectionUnderParent(String parent){
        List<String> subCollections= new ArrayList<String>();
        List<WebElement> parentCollections = web.findElements(By.cssSelector(String.format("[name = \"%s\"]", parent)));
        for(WebElement elem:parentCollections){
            if(elem.findElement(By.cssSelector("[data-role=\"tree-item-group-name\"]")).getText().equalsIgnoreCase(parent)){
                if(web.isElementPresent(By.cssSelector(String.format("[name = \"%s\"] [code=\"chevron-fill-down\"]", parent))))
                    web.click(By.cssSelector(String.format("[name = \"%s\"] [code=\"chevron-fill-down\"]", parent)));
                Common.sleep(1000);
                for(WebElement el:elem.findElements(By.cssSelector("[data-role=\"tree-item-name\"]")))
                    subCollections.add(el.getText());
            }
        }

        return subCollections;
    }

    public void setAsHomeCollection(String collectionName){
        if(web.isElementVisible(By.xpath("//ads-ui-tree-item[@name='My Collections']//span[@code='chevron-fill-down']")))  {
            web.getJavascriptExecutor().executeScript("arguments[0].click();",web.findElement(By.xpath("//ads-ui-tree-item[@name='My Collections']//span[@code='chevron-fill-down']")));}
        web.findElement(By.xpath("//ads-ui-tree-item[@name='" + collectionName + "']//div[@class='tree-item-title link']/span")).click();
        Common.sleep(2000);
        web.getJavascriptExecutor().executeScript("arguments[0].click();",web.findElement(By.xpath("//ads-ui-tree-item[@name='" + collectionName + "']//span[@code='more-vertical']")));
        web.waitUntilElementAppear(By.xpath("//span[contains(text(),'Set as collection home')]"));
        web.getJavascriptExecutor().executeScript("arguments[0].click();",web.findElement(By.xpath("//span[contains(text(),'Set as collection home')]")));
        List<WebElement> homeCollections = web.findElements(By.xpath("//span[contains(text(),'Set as collection home')]"));
        for(WebElement elem:homeCollections) {
            if(elem.isDisplayed()){
                elem.click();}
        }
        web.waitUntilElementAppear(By.xpath(".//*[contains(text(),\"Collection home successfully updated\")]"));
    }

    public void removeAsHomeCollection(String collectionName){
         if(web.isElementVisible(By.xpath("//ads-ui-tree-item[@name='My Collections']//span[@code='chevron-fill-down']")))  {
            web.getJavascriptExecutor().executeScript("arguments[0].click();",web.findElement(By.xpath("//ads-ui-tree-item[@name='My Collections']//span[@code='chevron-fill-down']")));}
        web.findElement(By.xpath("//ads-ui-tree-item[@name='" + collectionName + "']//div[@class='tree-item-title link']/span")).click();
        web.waitUntilElementAppear(By.xpath("//ads-ui-tree-item[@name='" + collectionName + "']//span[@code='more-vertical']"));
        web.getJavascriptExecutor().executeScript("arguments[0].click();",web.findElement(By.xpath("//ads-ui-tree-item[@name='" + collectionName + "']//span[@code='more-vertical']")));
        web.waitUntilElementAppear(By.xpath("//span[contains(text(),\"Remove as collection home\")]"));
        web.getJavascriptExecutor().executeScript("arguments[0].click();",web.findElement(By.xpath("//span[contains(text(),\"Remove as collection home\")]")));
        List<WebElement> removeCollections = web.findElements(By.xpath("//span[contains(text(),'Remove as collection home')]"));
        for(WebElement elem:removeCollections) {
            if(elem.isDisplayed()){
                elem.click();}
        }
        web.waitUntilElementAppear(By.xpath(".//*[contains(text(),\"Collection home successfully updated\")]"));

    }


    public List<String> getPopupMenuOptions(String collectionName){
        web.getJavascriptExecutor().executeScript("arguments[0].click();", web.findElement(By.xpath(String.format("//div[@class=\"tree-item-title link\"][..//span[contains(text(), \"%s\")]]/following-sibling::div//tree-item-menu//*[@ng-click=\"$mdOpenMenu($event)\"]//button", collectionName))));
        return web.findElementsToStrings(By.xpath("//*[@class=\"_md md-open-menu-container md-whiteframe-z2 md-active md-clickable\"]//button"));
    }

    public void setAsHomeCollectionMyAssets(){
        web.waitUntilElementAppear(By.xpath("//ads-ui-tree-item[@name='My Assets']//span[@code='more-vertical']"));
        web.getJavascriptExecutor().executeScript("arguments[0].click();",web.findElement(By.xpath("//ads-ui-tree-item[@name='My Assets']//span[@code='more-vertical']")));
        web.waitUntilElementAppear(By.xpath("//span[contains(text(),'Set as collection home')]"));
        web.getJavascriptExecutor().executeScript("arguments[0].click();",web.findElement(By.xpath("//span[contains(text(),'Set as collection home')]")));
        List<WebElement> homeCollections = web.findElements(By.xpath("//span[contains(text(),'Set as collection home')]"));
        for(WebElement elem:homeCollections) {
            if(elem.isDisplayed()){
                elem.click();}
        }
    }

    public void removeAsHomeCollectionMyAssets(){
        web.waitUntilElementAppear(By.xpath("//ads-ui-tree-item[@name='My Assets']//span[@code='more-vertical']"));
        web.getJavascriptExecutor().executeScript("arguments[0].click();",web.findElement(By.xpath("//ads-ui-tree-item[@name='My Assets']//span[@code='more-vertical']")));
        web.waitUntilElementAppear(By.xpath("//span[contains(text(),'Set as collection home')]"));
        web.getJavascriptExecutor().executeScript("arguments[0].click();",web.findElement(By.xpath("//span[contains(text(),'Remove as collection home')]")));
        List<WebElement> homeCollections = web.findElements(By.xpath("//span[contains(text(),'Remove as collection home')]"));
        for(WebElement elem:homeCollections) {
            if(elem.isDisplayed()){
                elem.click();}
        }

    }

    public CollectionPage openMenuPopup(String collection){
        if(web.isElementPresent(By.xpath(String.format("//div[@class=\"tree-item-title link\"][..//span[contains(text(), \"%s\")]]/following-sibling::div//tree-item-menu//*[@ng-click=\"$mdOpenMenu($event)\"]//button",collection))))
            web.getJavascriptExecutor().executeScript("arguments[0].click();",web.findElement(By.xpath(String.format("//div[@class=\"tree-item-title link\"][..//span[contains(text(), \"%s\")]]/following-sibling::div//tree-item-menu//*[@ng-click=\"$mdOpenMenu($event)\"]//button",collection))));
        Common.sleep(2000);
        return this;
    }

    public CollectionPage openMenuPopup_SharedCategory(String collection){
        if(web.isElementPresent(By.xpath(String.format("//div[@class=\"collection-search-item-name\"][..//span[contains(text(), \"%s\")]]/following-sibling::tree-item-menu//*[@ng-click=\"$ctrl.menuClick()\"]//button",collection))))
            web.getJavascriptExecutor().executeScript("arguments[0].click();",web.findElement(By.xpath(String.format("//div[@class=\"collection-search-item-name\"][..//span[contains(text(), \"%s\")]]/following-sibling::tree-item-menu//*[@ng-click=\"$ctrl.menuClick()\"]//button",collection))));
        Common.sleep(2000);
        return this;
    }

    public LibRemoveCollectionPopup removeCollection(){
        web.waitUntilElementAppear(By.xpath("*//span[contains(text(),\"Remove collection\")]"));
        web.getJavascriptExecutor().executeScript("arguments[0].click();", web.findElement(By.xpath("//*[@class=\"_md md-open-menu-container md-whiteframe-z2 md-active md-clickable\"]//button[..//span[contains(text(),\"Remove collection\")]]")));
        return new LibRemoveCollectionPopup(this);
    }

    public void subscribeToCollection(){
        web.waitUntilElementAppear(By.xpath("*//span[contains(text(),\"Subscribe to this collection\")]"));
        web.getJavascriptExecutor().executeScript("arguments[0].click();", web.findElement(By.xpath("//button[..//span[contains(text(),\"Subscribe to this collection\")]]")));
        web.waitUntilElementAppear(By.xpath(".//*[contains(text(),\"Successfully subscribed to collection\")]"));
        Common.sleep(10000);
    }

    public void unSubscribeToCollection(){
        web.waitUntilElementAppear(By.xpath("*//span[contains(text(),\"Unsubscribe from this collection\")]"));
        web.getJavascriptExecutor().executeScript("arguments[0].click();",web.findElement(By.xpath("//*[@class=\"_md md-open-menu-container md-whiteframe-z2 md-active md-clickable\"]//button[..//span[contains(text(),\"Unsubscribe from this collection\")]]")));
        web.waitUntilElementAppear(By.xpath(".//*[contains(text(),\"Successfully unsubscribed from collection\")]"));
    }

    private void clickIconArrow(WebElement iconArrow){
        if(iconArrow.getAttribute("code").equalsIgnoreCase("chevron-fill-down"))
            iconArrow.click();
    }

    private WebElement openAgency_SharedCategory() {
        if (web.isElementPresent(sharedWithMeLocator)) {
            WebElement sharedMeElement = web.findElement(sharedWithMeLocator);
            clickIconArrow(sharedMeElement.findElement(By.xpath("//inbox-collections-tree//ads-ui-tree-item[@id=\"shared\"][..//div[@data-role=\"tree-item-children-toggle\"]]//span[contains(@class,\"icon-arrow\")]")));
            Common.sleep(2000);
            WebElement agencyElement = web.findElement(sharedWithMeLocator).findElement(sharedAgencyLocator);
            return agencyElement;
        }
        return null;
    }

    public List<String> getSharedCategory(String agencyName) {
        List<String> collectionList = new ArrayList<String>();
        if (web.isElementPresent(sharedWithMeLocator)) {
            WebElement agencyElement = openAgency_SharedCategory();
            clickIconArrow(agencyElement.findElement(By.xpath("//ads-ui-tree-item[@ng-repeat=\"inbox in ::$ctrl.inboxAgencies track by inbox._id\"][..//div[@data-role=\"tree-item-children-toggle\"]]//span[contains(@class,\"icon-arrow\")]")));
            if (agencyElement.findElement(By.cssSelector("div[class=\"tree-item-title\"]")).getText().equalsIgnoreCase(agencyName)) {
                List<WebElement> collectionElement = agencyElement.findElements(sharedCollectionLocator);
                for(WebElement elem:collectionElement)
                    collectionList.add(elem.getText());
            }

        }
        return collectionList;
    }

    public void clickSharedParentSubCollectionLink() {
        web.findElement(By.xpath("//ads-ui-tree-item[@on-toggle='$ctrl.collectionsService.onAgencyToggle(id, event)']//span[@ng-if='!$ctrl.isToggled']")).click();

    }

    public List<String> getAllSharedSubCollections(String collectionName,String agencyName) {
        List<String> actualList = new ArrayList<>();
        String[] collect = collectionName.split(",");
        if(web.isElementVisible(By.xpath("//ads-ui-tree-item[@name='" + agencyName + "']//span[@code='chevron-fill-down']")))
        {
            web.findElement(By.xpath("//ads-ui-tree-item[@name='" + agencyName + "']//span[@code='chevron-fill-down']")).click();
        }
        for(String collection:collect){
            if (web.isElementVisible(By.xpath("//ads-ui-tree-item[contains(@name,'" +collection+ "')]//span[@code='chevron-fill-down']"))) {
                web.findElement(By.xpath("//ads-ui-tree-item[contains(@name,'" +collection+ "')]//span[@code='chevron-fill-down']")).click(); }
        }
        List<WebElement> actualCollectionList = web.findElements(By.xpath("//div[@class='tree-item-title link']/span"));
        for (WebElement list : actualCollectionList) {
            actualList.add(list.getText());
        }
        return actualList;
    }

    public List<String> getAllChildItems(String agencyName,String collectionName) {
        List<String> actualList = new ArrayList<>();
        if(web.isElementVisible(By.xpath("//ads-ui-tree-item[@name='" + agencyName + "']//span[@code='chevron-fill-down']"))) {
            web.findElement(By.xpath("//ads-ui-tree-item[@name='"+agencyName+"']//span[@code='chevron-fill-down']")).click();
        }
        List<WebElement> actualCollectionList = web.findElements(By.xpath("//ads-ui-tree-item[@name='"+collectionName+"']//div[@class='tree-item-title link']/span"));
        for (WebElement list : actualCollectionList) {
            actualList.add(list.getText());
        }
        return actualList;
    }

    public List<String> getAllAgencyNames() {
        return web.findElementsToStrings(By.xpath("//div[contains(@ng-repeat,'agency in $ctrl.agencies')]/ads-ui-tree-item//div[@class='tree-item-title']/span"));
    }

    public List<String> getCollectionList() {

        return web.findElementsToStrings(By.xpath("//collections-tree//div[@class='tree-item-title link']"));
    }

    public boolean verifyCollectionList(String listName)
    {
        return web.isElementVisible(By.xpath("//ads-ui-tree-item[@name='" + listName + "']//span[@ng-if='!$ctrl.isToggled']"));
    }


    public boolean verifyAdminCollectionIcon(String collectionName)
    {
        return web.isElementVisible(By.xpath("//ads-ui-tree-item[@name='" + collectionName + "']//*[@aria-label='Admin collection']"));
    }

    public String getMyCollection_Label(){
        return web.findElement(By.cssSelector("[class=\"tree-item-title\"] [data-role=\"tree-item-group-name\"]")).getText();
    }

    public String getMyAsset_Label(){
        return web.findElement(By.xpath(collectonLocator)).getText();
    }

    public void clickLibraryAssetTab(){
        web.click(libraryAssetTabLocator);
    }

    public void clickCollectionTab(){
        web.click(collectionTabLocator);
    }

    public List<String> getBreadCrum() {
        return web.findElementsToStrings(breadCrumLocator);
    }

    public LibAcceptAssetSharedCategory sharedCategoryButton(String button){
        Common.sleep(2000);
        switch(button){
            case "accept":
                web.click(acceptButtonLocator);
                break;
            case "reject":
                web.click(rejectButtonLocator);
                break;
            default:
                throw new IllegalArgumentException(String.format("Button %s is not present on the page",button));
        }
        return new LibAcceptAssetSharedCategory(this);
    }

    public void clickSharedCollection(String collection){
        web.waitUntilElementAppear(By.xpath("//ads-ui-tree-item[@name='" + collection + "']//div[@class='tree-item-title link']"));
        web.findElement(By.xpath("//ads-ui-tree-item[@name='" + collection + "']//div[@class='tree-item-title link']")).click();
    }

    public void clickSharedCollection(String collection,String agencyName){
        WebElement agencyElement = openAgency_SharedCategory();
        Common.sleep(2000);
        clickIconArrow(agencyElement.findElement(By.xpath("//ads-ui-tree-item[@ng-repeat=\"inbox in ::$ctrl.inboxAgencies track by inbox._id\"][..//div[@data-role=\"tree-item-children-toggle\"]]//span[contains(@class,\"icon-arrow\")]")));
        Common.sleep(2000);
        List<WebElement> sharedCollection = web.findElements(sharedCollectionLocator);
        for(WebElement elem:sharedCollection) {
            if (elem.getText().equalsIgnoreCase(collection)) {
                elem.click();
                Common.sleep(1000);
            }
        }
    }

    public void clickSharedCollectionLink(String collection,String agencyName) {
        web.waitUntilElementAppear(By.xpath("//div[@data-id='Shared with me']//span[@code='chevron-fill-down']"));
        web.findElement(By.xpath("//div[@data-id='Shared with me']//span[@code='chevron-fill-down']")).click();
        web.waitUntilElementAppear(By.xpath("//div[@data-id='" + agencyName + "']//span[@code='chevron-fill-down']"));
        web.findElement(By.xpath("//div[@data-id='"+agencyName+"']//span[@code='chevron-fill-down']")).click();
        web.waitUntilElementAppear(By.xpath("//div[@data-id='" + collection + "']//span[contains(.,'" + collection + "')]"));
        web.findElement(By.xpath("//div[@data-id='" + collection + "']//span[contains(.,'" + collection + "')]")).click();
    }

    public void clickCollectionInTree(String collection){
        if(web.isElementPresent(By.xpath(String.format(collectonLocator,collection)))){
            WebElement el= web.findElement(By.xpath(String.format(collectonLocator,collection)));
            if(el.getText().equalsIgnoreCase(collection))
                el.click();
        }
    }

    public List<String> getSharedCollections(String agencyName)
    {
        if(web.isElementVisible(By.xpath("//div[@data-id='Shared with me']//span[@code='chevron-fill-down']"))) {
            web.findElement(By.xpath("//div[@data-id='Shared with me']//span[@code='chevron-fill-down']")).click();
        }
        if(web.isElementVisible(By.xpath("//div[@data-id='" + agencyName + "']//span[@code='chevron-fill-down']"))) {
            web.findElement(By.xpath("//div[@data-id='"+agencyName+"']//span[@code='chevron-fill-down']")).click();
        }
        Common.sleep(2000);
        web.waitUntilElementAppear(By.xpath("//div[@class='tree-item-title link']/span"));
        return web.findElementsToStrings(By.xpath("//div[@class='tree-item-title link']/span"));
    }

    public boolean isSharedWithMeExpandable()
    {
       return web.isElementVisible(By.xpath("//ads-ui-tree-item[@id='shared']//div[@ng-click='$ctrl.toggleChildren($event)']"));
    }

    public boolean isSharedWithMeLinkExist()
    {
        return web.isElementVisible(By.xpath("//div[@data-id='Shared with me']"));
    }

    public void clickParentInTree(String collection){
        if(web.isElementPresent(By.xpath(String.format(parentcollectonLocator,collection)))){
            WebElement el= web.findElement(By.xpath(String.format(parentcollectonLocator,collection)));
            if(el.getText().equalsIgnoreCase(collection))
                el.click();
        }
    }

    public Boolean checkVisibility(String button){
        Boolean available=false;
        switch (button){
            case "tree Icon":
                available=web.isElementVisible(collectiontreeIconLocator);
                break;
            case "Info Icon":
                available=web.isElementVisible(collectionInfoIconLocator);
                break;
            case "Filter Icon":
                available=web.isElementVisible(collectionFilterIconLocator);
                break;
            case "Upload":
                available = web.isElementVisible(uploadButtonLocator);
                break;
            case "Download":
                available = web.isElementVisible(downloadButtonLocator);
                break;
            default:
                throw new IllegalArgumentException(String.format("%s is not the expected button on the collection page",button));
        }
        return available;
    }

    public void clickAsset(String assetName){
        web.click(By.xpath(String.format("//*[contains(@class,\"assetCard__details\")]//*[contains(text(),\"%s\")]",assetName)));
    }


    public void clickAssetFilter() {
        WebElement element = web.findElement(By.xpath("//ads-md-button[@id='collections-filter-button']/button"));
        web.getJavascriptExecutor().executeScript("arguments[0].click();", element);
     }
}