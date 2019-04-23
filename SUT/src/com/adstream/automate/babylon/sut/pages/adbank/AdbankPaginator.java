package com.adstream.automate.babylon.sut.pages.adbank;

import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.page.controls.DojoSelect;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;

import java.util.ArrayList;
import java.util.List;

/**
 * User: ruslan.semerenko
 * Date: 22.05.12 16:53
 */
//todo cut off table functionality
public class AdbankPaginator extends BaseAdBankPage<AdbankPaginator> {
    public AdbankPaginator(ExtendedWebDriver web) {
        super(web);
    }

    public String getObjectLink(String objectName) {
        for (WebElement element : getObjectsLinks()) {
            if (element.getText().trim().equals(objectName)) return element.getAttribute("href");
        }
        return null;
    }

    public boolean isObjectExistInList(String objectName) {
        return getObjectLink(objectName) != null;
    }

    public List<String> getObjectsId() {
        List<WebElement> links = getObjectsLinks();
        List<String> objectsId = new ArrayList<>(links.size());
        for (WebElement link : links) {
            String href = link.getAttribute("href");
            objectsId.add(href.substring(href.lastIndexOf("/") + 1));
        }
        return objectsId;
    }

    public void selectObjectsCountOnPage(final String value) {
        DojoSelect itemPerPageBox = new DojoSelect(this, By.cssSelector(".item_perpage"));
        if (!itemPerPageBox.getSelectedLabel().equals(value)) {
            WebElement container = web.findElement(By.className("itemsList"));
            itemPerPageBox.selectByValue(value);
            web.waitUntilElementChanged(container);
        } else {
            web.navigate().refresh();
        }
    }

    public String getItemPerPageSelectedValue() {
        return new DojoSelect(this, By.cssSelector(".item_perpage")).getSelectedLabel().trim();
    }

    public List<String> getItemPerPageAvailableValues() {
        return new DojoSelect(this, By.cssSelector(".item_perpage")).getLabels();
    }

    public List<String> getViewFilterValues() {
        return new DojoSelect(this, getViewFilterLocator()).getLabels();
    }

    public void selectMediaTypeFilterValue(String value) {
        DojoSelect mediaTypeFilter = new DojoSelect(this, getMediaTypeFilterLocator());
        if (!mediaTypeFilter.getSelectedLabel().equals(value)) {
            mediaTypeFilter.selectByVisibleText(value);
        }
    }

    public void selectViewFilterValue(String value) {
        DojoSelect viewFilter = new DojoSelect(this, getViewFilterLocator());
        if (!viewFilter.getSelectedLabel().equals(value)) {
            viewFilter.selectByVisibleText(value);
        }
    }

    public String getSelectedMediaType() {
        DojoSelect select = new DojoSelect(this, getMediaTypeFilterLocator());
        return select.getSelectedLabel();
    }



    public void selectObject(int index) {
        getObjectsRows().get(index).click();
    }

    public void selectAllObjects() {
        web.click(By.name("selectAll"));
    }

    public String getObjectsSelectedCounter() {
        return web.findElement(By.cssSelector("[data-id='selected-items']")).getText();
    }

    public int getObjectsCount() {
        return getObjectsLinks().size();
    }

    public boolean isObjectSelected(int index) {
        return getObjectsRows().get(index).getAttribute("class").contains("selected");
    }

    public String getObjectsCounter() {
        return web.findElement(By.cssSelector("[data-id='counter']")).getText();
    }

    protected List<WebElement> getObjectsLinks() {
        By linksLocator = By.cssSelector(".project_link");
        return web.findElements(linksLocator);
    }

    protected List<WebElement> getObjectsRows() {
        return web.findElements(By.cssSelector(".row"));
    }

    public void selectObjectByName(String name) {
//        By locator = getLogoImageLocator(name);
        By locator = getLogoContainer(name);  // There isn't image sometimes
        if (web.isElementPresent(locator)) {
            web.click(locator);
        }
    }

    public byte[] getLogo(String name) {
        String src = web.findElement(getLogoImageLocator(name)).getAttribute("src");
        return getDataByUrl(src);
    }

    public boolean isDeleteButtonVisible() {
        By locator = By.cssSelector(".button.mls.remove");
        return web.isElementPresent(locator) && web.isElementVisible(locator);
    }

    public void selectBusinessUnit(String businessUnit) {
        DojoSelect buSelect = new DojoSelect(this, By.xpath("//div[div/span[text()='Business Unit']]//table"));
        if (!buSelect.getSelectedLabel().equals(businessUnit)) {
            WebElement container = web.findElement(By.className("itemsList"));
            buSelect.selectByVisibleText(businessUnit);
            web.waitUntilElementChanged(container);
        }
    }

    private By getMediaTypeFilterLocator() {
        return By.xpath("//div[span[text()='Media Type:']]/following-sibling::div/table");
    }



    private By getViewFilterLocator() {
        return By.xpath("//div[span[text()='View']]/following-sibling::div/table");
    }

    private By getLogoImageLocator(String projectName) {
        return By.xpath(String.format(
                "//div[@data-type='tableRow' and descendant::a[normalize-space()='%s']]//*[contains(@class,'preview_block')]//img", projectName));
    }

    private By getLogoContainer(String projectName) {
        return By.xpath(String.format(
                "//div[@data-type='tableRow' and descendant::a[normalize-space()='%s']]//*[contains(@class,'preview_block')]", projectName));
    }
}