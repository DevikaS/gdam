package com.adstream.automate.babylon.sut.pages.adcost;

import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import org.openqa.selenium.By;
import org.openqa.selenium.Keys;

import java.util.List;

/**
 * Created by Raja.Gone on 12/01/2018.
 */
public class AdCostsAssociatedAssetsPage  extends BaseAdCostPage<AdCostsApprovalsPage> {
    private String approvalsPageFormat = "//associated-asset";
    By approvalsPageLocator = By.xpath(approvalsPageFormat);
    By searchAdIdLocator = By.xpath("//input[@placeholder='Link the Ad-ID of an expected asset']");

    public AdCostsAssociatedAssetsPage(ExtendedWebDriver web) {
        super(web);
        closeWakeMePopUp();
    }

    public void waitUntilApprovalsPageVisible() {
        web.waitUntilElementAppear(approvalsPageLocator);
    }

    public void searchAdId(String adId) {
        web.findElement(searchAdIdLocator).sendKeys(adId + Keys.SPACE);
        web.findElement(By.cssSelector(".select2-result-label.ui-select-choices-row-inner")).click();
    }

    public void clickAdd(){
        web.findElement(By.xpath("//span[.='+ Add']")).click();
    }

    public LinkedExpectedAssets getLinkedExpectedAssetsSection() {
        return new LinkedExpectedAssets();
    }

    public class LinkedExpectedAssets {
        private String parentLocator = "//associated-assets-list";
        private String tableHeaderLocator = parentLocator + "//div[contains(@class,'table-item header')]";
        private String tableRowLocator = parentLocator + "//div[contains(@class,'table-item item')]";
        private String adID;
        private String assetName;
        private String initiative;
        private String associatedCost;

        public String getAdID() {
            return adID;
        }

        public void setAdID(String adID) {
            this.adID = adID;
        }

        public String getAssetName() {
            return assetName;
        }

        public void setAssetName(String assetName) {
            this.assetName = assetName;
        }

        public String getInitiative() {
            return initiative;
        }

        public void setInitiative(String initiative) {
            this.initiative = initiative;
        }

        public String getAssociatedCost() {
            return associatedCost;
        }

        public void setAssociatedCost(String associatedCost) {
            this.associatedCost = associatedCost;
        }

        public void loadData(int rowCounter) {
            rowCounter++;
            List<String> headerLocator = web.findElementsToStrings(By.xpath(tableHeaderLocator.concat("/div")));
            for (int counter = 1; counter < headerLocator.size(); counter++) {
                String columnHeader = web.findElement(By.xpath(tableHeaderLocator + "/div[" + counter + "]")).getText().trim();
                String rowValue = web.findElement(By.xpath(tableRowLocator + "[" + rowCounter + "]/div[" + counter + "]")).getText().trim();
                switch (columnHeader) {
                    case "Ad-ID":
                        setAdID(rowValue);
                        break;
                    case "Asset name":
                        setAssetName(rowValue);
                        break;
                    case "Initiative":
                        setInitiative(rowValue);
                        break;
                    case "Associated Cost":
                        setAssociatedCost(rowValue);
                        break;
                    default:
                        throw new IllegalArgumentException("Unknown headerName: " + rowValue);
                }
            }
        }

        public Boolean selectAssociatedCost(String costNumber,String assetName) {
            int totalRows = web.findElements(By.xpath(tableRowLocator)).size();
            for (int rowCounter = 1; rowCounter <= totalRows; rowCounter++) {
                if (web.findElement(By.xpath(tableRowLocator + "[" + rowCounter + "]/div[4]")).getText().equals(costNumber) &&
                        web.findElement(By.xpath(tableRowLocator + "[" + rowCounter + "]/div[2]")).getText().equals(assetName)    ) {
                    web.findElement(By.xpath(tableRowLocator + "[" + rowCounter + "]/div[4]")).click();
                    return true;
                }
            }
            return false;
        }

        public String isCostDetailsPageLoaded(String expectedURL){
            String currentURL = null;
            for (String winHandle : web.getWindowHandles()) {
                web.switchTo().window(winHandle);
                currentURL = web.getCurrentUrl();
                if (currentURL.equals(expectedURL)) {
                    web.isElementVisible(By.xpath("//cost-details-editable"));
                    web.close();
                }
            }
            for (String winHandle : web.getWindowHandles()) {
                web.switchTo().window(winHandle);
            }
            return currentURL;
        }

        public int getLinkedAssetsCount(){
            return web.findElements(By.xpath(tableRowLocator)).size();
        }

        public void deleteAssociatedCost(String costNumber,String assetName) {
            int totalRows = web.findElements(By.xpath(tableRowLocator)).size();
            for (int rowCounter = 1; rowCounter <= totalRows; rowCounter++) {
                if (web.findElement(By.xpath(tableRowLocator + "[" + rowCounter + "]/div[4]")).getText().equals(costNumber) &&
                        web.findElement(By.xpath(tableRowLocator + "[" + rowCounter + "]/div[2]")).getText().equals(assetName)    ) {
                    web.click(By.xpath(tableRowLocator + "[" + rowCounter + "]//button[@aria-label='Cost menu']"));
                    web.clickThroughJavascript(By.xpath("//div[contains(@id,'menu_container')][@aria-hidden='false']//span[contains(text(),'Delete Link')]"));
                    break;
                }
            }
        }

        public String getErrorMessage(){
            return web.findElement(By.xpath("//div[@class='error ng-scope']")).getText().trim();
        }
    }
}