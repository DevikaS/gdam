package com.adstream.automate.babylon.sut.pages.library.elements;

import com.adstream.automate.babylon.sut.pages.library.presentations.AdbankLibraryPresentationsPage;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.page.controls.DojoCombo;
import org.openqa.selenium.By;
import org.openqa.selenium.TimeoutException;
import org.openqa.selenium.WebElement;

import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;


/**
 * Created with IntelliJ IDEA.
 * User: solomin-y
 * Date: 02.11.12
 * Time: 15:26
 */
public class AdbankLibraryAllPresentationsPage extends AdbankLibraryPresentationsPage {

    public DojoCombo fromDateBox = new DojoCombo(this,By.cssSelector(".from-date"));
    public DojoCombo toDateBox = new DojoCombo(this,By.cssSelector(".to-date"));

    public AdbankLibraryAllPresentationsPage(ExtendedWebDriver web) {
        super(web);
    }

    public void clickPresentationRow(String presentationName) {
        web.click(By.xpath(String.format("//div[@data-type='tableRow' and descendant::a[normalize-space(text())='%s']]", presentationName)));
    }

    public void setFromDate(String startDate) {
        WebElement reelList = web.findElement(By.className("reels_list"));
        fromDateBox.selectByVisibleText(startDate);
        try {
            web.waitUntilElementChanged(reelList);
        } catch (TimeoutException te) {/**/}
    }

    public void setToDate(String endDate) {
        WebElement reelList = web.findElement(By.className("reels_list"));
        toDateBox.selectByVisibleText(endDate);
        try {
            web.waitUntilElementChanged(reelList);
        } catch (TimeoutException te) {/**/}
    }

    public void clickSortField(String fieldName) {
        web.click(By.cssSelector(String.format("[fieldname='%s']", convertSortFieldName(fieldName))));
    }

    public String getClassOfSortField(String fieldName) {
        WebElement webElement = getSortFieldByFieldName(fieldName);
        return webElement.getAttribute("class")==null?"":webElement.getAttribute("class");
    }

    public WebElement getSortFieldByFieldName(String fieldName) {
        return web.findElement(By.cssSelector(String.format("[fieldname='%s']", convertSortFieldName(fieldName))));
    }

    public int getCountOfTotalPresenations() {
        return Integer.parseInt(web.findElement(By.cssSelector("[data-id='total-count']")).getText());
    }

    public List<String> getActualPresentationFieldList(String fieldName) {
        String columnClass = getColumnClass(convertSortFieldName(fieldName));
        return web.findElementsToStrings(By.cssSelector("[data-type='tableRow'] ." + columnClass));
    }

    public String getPresentationLogoFileIdByName(String presentationName) {
        String xpath = String.format("//a[normalize-space()='%s']/ancestor::div[contains(@class, 'row')]//img", presentationName);
        WebElement logo = web.findElement(By.xpath(xpath));
        String regexp = "([\\d\\w]{24})$";
        Matcher mather = Pattern.compile(regexp, Pattern.CASE_INSENSITIVE).matcher(logo.getAttribute("SRC"));
        return mather.find() ? mather.group(1) : "";
    }

    public boolean isPresentationLogoDefault(String presentationName) {
        return web.isElementVisible(By.xpath(String.format(
                "//a[normalize-space()='%s']/ancestor::div[contains(@class, 'row')]//*[contains(@class, 'reel-empty-icon')]",
                presentationName)));
    }

    private String convertSortFieldName(String fieldName) {
        switch (fieldName.toLowerCase()) {
            case "created":
                return "_created";
            case "modified":
                return "_modified";
            case "duration":
                return "assets.duration";
            default:
                return "_cm.common.name";
        }
    }
}
