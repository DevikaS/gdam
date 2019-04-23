package com.adstream.automate.babylon.sut.pages.ordering;

import com.adstream.automate.babylon.sut.pages.ordering.elements.lists.DestinationDeliveredList;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import org.openqa.selenium.By;
import org.openqa.selenium.NoSuchElementException;
import org.openqa.selenium.WebElement;
import java.util.ArrayList;
import java.util.List;
import static com.thoughtworks.selenium.SeleneseTestBase.assertTrue;

/**
 * Created with IntelliJ IDEA.
 * User: demidovskiy-r
 * Date: 02.12.13
 * Time: 16:01
 */
public class ViewMediaDetailsPage extends BaseOrderingPage<ViewMediaDetailsPage> {
    private final String ROOT_NODE = "[data-role='assetPreviewContainer'] .b-summary";

    public ViewMediaDetailsPage(ExtendedWebDriver web) {
        super(web);
    }

    public void load() {
        super.load();
        web.waitUntilElementAppearVisible(getViewMediaDetailsPageLocator());
    }

    public void isLoaded() throws Error {
        super.isLoaded();
        assertTrue(web.isElementVisible(getViewMediaDetailsPageLocator()));
    }

    public static class MediaInformation {
        private ExtendedWebDriver web;
        private String clockNumber;
        private String advertiser;
        private String brand;
        private String subBrand;
        private String product;
        private String title;
        private String duration;
        private String firstAirDate;
        private String additionalDetails;
        private List<String> otherMetadataValues = new ArrayList<>();
        private String videoFormat;
        private String aspectRatio;
        private String videoStandard;

        public MediaInformation(ExtendedWebDriver web, WebElement mediaInformation) {
            this.web = web;
            List<WebElement> generalInformationCells = mediaInformation.findElements(generateInformationSection(".pvs"));
            List<WebElement> specificationInformationCells = mediaInformation.findElements(generateInformationSection(".pbs"));
            initGeneralInfoCells(generalInformationCells);
            videoFormat = specificationInformationCells.get(0).findElement(getInformationCellLocator()).getText();
            aspectRatio = specificationInformationCells.get(1).findElement(getInformationCellLocator()).getText();
            videoStandard = specificationInformationCells.get(2).findElement(getInformationCellLocator()).getText();
        }

        public String getClockNumber() {
            return clockNumber;
        }

        public String getAdvertiser() {
            return advertiser;
        }

        public String getBrand() {
            return brand;
        }

        public String getSubBrand() {
            return subBrand;
        }

        public String getProduct() {
            return product;
        }

        public List<String> getOtherMetadataValues() {
            return otherMetadataValues;
        }

        public String getTitle() {
            return title;
        }

        public String getDuration() {
            return duration;
        }

        public String getFirstAirDate() {
            return firstAirDate;
        }

        public String getAdditionalDetails() {
            return additionalDetails;
        }

        public String getVideoFormat() {
            return videoFormat;
        }

        public String getAspectRatio() {
            return aspectRatio;
        }

        public String getVideoStandard() {
            return videoStandard;
        }

        private boolean isAdvertiserHierarchyVisible() {
            return web.isElementVisible(By.className("capitalize"));
        }

        private void initGeneralInfoCells(List<WebElement> generalInformationCells) {
            clockNumber = generalInformationCells.get(0).findElement(getInformationCellLocator()).getText();
            if (isAdvertiserHierarchyVisible() && generalInformationCells.size() < 10) {  // common case with added just default advertiser hierarchy (Advertiser is marked as Advertiser, Product is marked as Product, Campaign is marked as Campaign)
                advertiser = generalInformationCells.get(1).findElement(getInformationCellLocator()).getText();
                brand = generalInformationCells.get(2).findElement(getInformationCellLocator()).getText();
                subBrand = generalInformationCells.get(3).findElement(getInformationCellLocator()).getText();
                product = generalInformationCells.get(4).findElement(getInformationCellLocator()).getText();
                title = generalInformationCells.get(5).findElement(getInformationCellLocator()).getText();
                duration = generalInformationCells.get(6).findElement(getInformationCellLocator()).getText();
                firstAirDate = generalInformationCells.get(7).findElement(getInformationCellLocator()).getText();
                additionalDetails = generalInformationCells.get(8).findElement(getInformationCellLocator()).getText();
            } else if (isAdvertiserHierarchyVisible() && generalInformationCells.size() >= 10) { // case when some other metadata, which have been marked as Product, Advertiser, etc , are added
                int defaultGeneralInfoCellsCount = 9; // true, in case just default advertiser hierarchy (Advertiser is marked as Advertiser, Product is marked as Product, Campaign is marked as Campaign)
                int otherMetadataCount = generalInformationCells.size() - defaultGeneralInfoCellsCount;
                advertiser = generalInformationCells.get(1).findElement(getInformationCellLocator()).getText();
                brand = generalInformationCells.get(2).findElement(getInformationCellLocator()).getText();
                subBrand = generalInformationCells.get(3).findElement(getInformationCellLocator()).getText();
                product = generalInformationCells.get(4).findElement(getInformationCellLocator()).getText();

                //shifting rest elements on the page due to new added metadata
                for (int i = 1; i <= otherMetadataCount; i++)
                    otherMetadataValues.add(generalInformationCells.get(4 + i).findElement(getInformationCellLocator()).getText());
                title = generalInformationCells.get(5 + otherMetadataCount).findElement(getInformationCellLocator()).getText();
                duration = generalInformationCells.get(6 + otherMetadataCount).findElement(getInformationCellLocator()).getText();
                firstAirDate = generalInformationCells.get(7 + otherMetadataCount).findElement(getInformationCellLocator()).getText();
                additionalDetails = generalInformationCells.get(8 + otherMetadataCount).findElement(getInformationCellLocator()).getText();
            } else {   // case when noone element is marked
                advertiser = "";
                brand = "";
                subBrand = "";
                product = "";
                title = generalInformationCells.get(1).findElement(getInformationCellLocator()).getText();
                duration = generalInformationCells.get(2).findElement(getInformationCellLocator()).getText();
                firstAirDate = generalInformationCells.get(3).findElement(getInformationCellLocator()).getText();
                additionalDetails = generalInformationCells.get(4).findElement(getInformationCellLocator()).getText();
            }
        }

        private By getInformationCellLocator() {
            return By.cssSelector("span:last-child");
        }

        private By generateInformationSection(String partialLocator) {
            return By.cssSelector(partialLocator + " .pbxs");
        }
    }

    public MediaInformation getMediaInformation() {
        if (!web.isElementVisible(getMediaInformationSectionLocator()))
            throw new NoSuchElementException("There is no a media information section on View Media Details page!");
        WebElement mediaInformation = web.findElement(getMediaInformationSectionLocator());
        return new MediaInformation(web, mediaInformation);
    }

    public DestinationDeliveredList getDestinationDeliveredList() {
        if (!web.isElementVisible(getDestinationDeliveredListLocator()))
            return null; // due to QC & Ingest Only items
        return new DestinationDeliveredList(web);
    }

    private By getMediaInformationSectionLocator() {
        return By.className("size1of3");
    }

    private By getDestinationDeliveredListLocator() {
        return By.cssSelector(ROOT_NODE + " .itemsList .row:not([class*='selected'])");
    }

    private By getViewMediaDetailsPageLocator() {
        return By.cssSelector(ROOT_NODE);
    }
}