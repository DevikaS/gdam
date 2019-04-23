package com.adstream.automate.babylon.sut.pages.ordering;

import com.adstream.automate.babylon.JsonObjects.Localization;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.page.controls.Button;
import org.openqa.selenium.By;
import org.openqa.selenium.NoSuchElementException;
import org.openqa.selenium.WebElement;

import java.util.*;

import static com.thoughtworks.selenium.SeleneseTestBase.assertTrue;
/**
 *
 * Created by Saritha.Dhanala on 31/10/2016.
 */
public class ViewDestinationDetailsPage extends BaseOrderingPage {
    private Button saveAsPDF;
    private Button saveAsCSV;

    private String deliveryOrder = "#report>div>div>div>div>div";

    //Order Details
    private String orderNumber = "#report>div>div>div>div>table>tbody>tr:nth-child(1)>td:nth-child(2)";
    private String numberOfCommercials = "#report>div>div>div>div>table>tbody>tr:nth-child(1)>td:nth-child(4)";
    private String jobNumber = "#report>div>div>div>div>table>tbody>tr:nth-child(2)>td:nth-child(2)";
    private String poNumber = "#report>div>div>div>div>table>tbody>tr:nth-child(3)>td:nth-child(2)";

    //Commercial 1
    private String country = "#report>div>div>div>table>tbody>tr:nth-child(2)>td:nth-child(2)";
    private String deliveryMethoToAdstream = "#report>div>div>div>table>tbody>tr:nth-child(2)>td:nth-child(4)";
    private String clockNumber = "#report>div>div>div>table>tbody>tr:nth-child(3)>td:nth-child(2)";;
    private String dateCommercialsArrival = "#report>div>div>div>table>tbody>tr:nth-child(3)>td:nth-child(4)";
    private String advertiser = "#report>div>div>div>table>tbody>tr:nth-child(4)>td:nth-child(2)";
    private String firstAirDate = "#report>div>div>div>table>tbody>tr:nth-child(4)>td:nth-child(4)";
    private String brand = "#report>div>div>div>table>tbody>tr:nth-child(5)>td:nth-child(2)";
    private String archive = "#report>div>div>div>table>tbody>tr:nth-child(5)>td:nth-child(4)";
    private String subBrand = "#report>div>div>div>table>tbody>tr:nth-child(6)>td:nth-child(2)";
    private String note = "#report>div>div>div>table>tbody>tr:nth-child(6)>td:nth-child(4)";
    private String product = "#report>div>div>div>table>tbody>tr:nth-child(7)>td:nth-child(2)";
    private String attachments = "#report>div>div>div>table>tbody>tr:nth-child(7)>td:nth-child(4)";
    private String title = "#report>div>div>div>table>tbody>tr:nth-child(8)>td:nth-child(2)";
    private String subtitlesRequired = "#report>div>div>div>table>tbody>tr:nth-child(8)>td:nth-child(4)";
    private String duration = "#report>div>div>div>table>tbody>tr:nth-child(9)>td:nth-child(2)";
    private String deliveryPoints = "#report>div>div>div>table>tbody>tr:nth-child(9)>td:nth-child(4)";
    private String format = "#report>div>div>div>table>tbody>tr:nth-child(10)>td:nth-child(2)";


    //Broadcaster
    private String destinationGroup = "//*[@id='report']/div/div[2]/div[4]/table/tbody/tr[2]/td[2]";
    private String destination = "//*[@id='report']/div/div[2]/div[4]/table/tbody/tr[3]/td[2]";
    private String serviceLevel = "//*[@id='report']/div/div[2]/div[4]/table/tbody/tr[1]/th[3]";

    //Production_Services
    private String productionServiceType = "//*[@id='report']/div/div[2]/div[5]/table/tbody/tr[2]/td[1]";
    private String productionServiceNote = "//*[@id='report']/div/div[2]/div[5]/table/tbody/tr[2]/td[2]";


    public ViewDestinationDetailsPage(ExtendedWebDriver web) {
        super(web);
        saveAsPDF = new Button(this, generateButtonLocatorByType("pdf"));
        saveAsCSV = new Button(this, generateButtonLocatorByType("csv"));

    }

    //Switched to the popup
    public void load() {
        web.sleep(1000);
        Set<String> windowId = web.getWindowHandles();
        Iterator<String> itererator = windowId.iterator();

        String mainWindowID = itererator.next();
        String  newAdwinID = itererator.next();

        web.switchTo().window(newAdwinID);

        web.waitUntilElementAppearVisible(getViewDestinationDetailsPageLocator());
    }

    public void isLoaded() throws Error {
        assertTrue(web.isElementVisible(getViewDestinationDetailsPageLocator()));
    }

    public boolean isSaveAsPDFBtnVisible() {
        return saveAsPDF.isVisible();
    }

    public boolean isSaveAsCSVBtnVisible() {
        return saveAsCSV.isVisible();
    }

    public void clickSaveAsPDFButton(){
        saveAsPDF.click();

    }

    public String getClockNumber() {
        return web.findElement(By.cssSelector(clockNumber)).getText();
    }

    public String getDeliveryOrder() {
        return web.findElement(By.cssSelector(deliveryOrder)).getText();
    }

    public String getOrderNumber() {
        return web.findElement(By.cssSelector(orderNumber)).getText();
    }

    public String getNumberOfCommercials() {
        return web.findElement(By.cssSelector(numberOfCommercials)).getText();
    }

    public String getJobNumber() {
        return web.findElement(By.cssSelector(jobNumber)).getText();
    }

    public String getPoNumber() {
        return web.findElement(By.cssSelector(poNumber)).getText();
    }

    public String getCountry() {
        return web.findElement(By.cssSelector(country)).getText();
    }

    public String getDeliveryMethod() {
        return web.findElement(By.cssSelector(deliveryMethoToAdstream)).getText();
    }

    public String getAdvertiser() {
        return web.findElement(By.cssSelector(advertiser)).getText();
    }

    public String getFirstAirDate() {
        return web.findElement(By.cssSelector(firstAirDate)).getText();
    }

    public String getBrand() {
        return web.findElement(By.cssSelector(brand)).getText();
    }

    public String getDateCommercialsArrival() {
        return web.findElement(By.cssSelector(dateCommercialsArrival)).getText();
    }

    public String getArchive(){ return web.findElement(By.cssSelector(archive)).getText(); }

    public String getSubBrand() {
        return web.findElement(By.cssSelector(subBrand)).getText();
    }

    public String getNote() {
        return web.findElement(By.cssSelector(note)).getText(); }

    public String getProduct() {
        return web.findElement(By.cssSelector(product)).getText(); }

    public String getAttachments() {
        return web.findElement(By.cssSelector(attachments)).getText(); }

    public String getTitle() {
        return web.findElement(By.cssSelector(title)).getText(); }

    public String getSubtitlesRequired() {
        return web.findElement(By.cssSelector(subtitlesRequired)).getText();
    }

    public String getDuration() {
        return web.findElement(By.cssSelector(duration)).getText();
    }

    public String getDeliveryPoints() {
        return web.findElement(By.cssSelector(deliveryPoints)).getText(); }


    public String getFormat() {
        return web.findElement(By.cssSelector(format)).getText(); }

    public String getDestinationGroup() {
        return web.findElement(By.xpath(destinationGroup)).getText();
    }

    public String getDestination() {
        return web.findElement(By.xpath(destination)).getText();
    }

    public String getServiceLevel() {
        return web.findElement(By.xpath(serviceLevel)).getText();
    }

    public String getProductionServiceType() {
        return web.findElement(By.xpath(productionServiceType)).getText();
    }

    public String getProductionServiceNote() {
        return web.findElement(By.xpath(productionServiceNote)).getText();
    }

    private By generateButtonLocatorByType(String type) {
        return By.cssSelector(".button[type='" + type + "']");
    }

    private By getViewDestinationDetailsPageLocator() {
        return By.id("report");
    }

    public Map<String, String> getViewDestinationDetailsValues(){
        Map<String, String> actualValues = new HashMap<String, String>();
        actualValues.put("Clock Number", getClockNumber());
        actualValues.put("Job Number", getJobNumber());
        actualValues.put("PO Number", getPoNumber());
        actualValues.put("Commercial Number", getNumberOfCommercials());
        actualValues.put("Country", getCountry());
        actualValues.put("Advertiser", getAdvertiser());
        actualValues.put("Brand", getBrand());
        actualValues.put("Sub Brand", getSubBrand());
        actualValues.put("Product", getProduct());
        actualValues.put("Title", getTitle());
        actualValues.put("Duration", getDuration());
        actualValues.put("Format", getFormat());
        actualValues.put("Delivery Method", getDeliveryMethod());
        actualValues.put("First Air Date", getFirstAirDate());
        actualValues.put("Archive", getArchive());
        actualValues.put("Note", getNote());
        actualValues.put("Attachments", getAttachments());
        actualValues.put("Subtitles Required", getSubtitlesRequired());
        actualValues.put("Delivery Points", getDeliveryPoints());
        actualValues.put("Destination Group", getDestinationGroup());
        actualValues.put("Destination", getDestination());
        actualValues.put("Service Level", getServiceLevel());
        actualValues.put("Additional Production Service Type", getProductionServiceType());
        actualValues.put("Additional Production Service Note", getProductionServiceNote());

        return actualValues;

    }
}
