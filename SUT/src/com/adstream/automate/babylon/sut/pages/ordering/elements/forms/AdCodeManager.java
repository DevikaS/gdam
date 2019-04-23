package com.adstream.automate.babylon.sut.pages.ordering.elements.forms;

import com.adstream.automate.babylon.sut.pages.admin.metadata.MetadataPage;
import com.adstream.automate.babylon.sut.pages.ordering.elements.forms.subForms.AdCodeContainer;
import com.adstream.automate.babylon.sut.pages.ordering.elements.popup.DeleteAdCodePopUp;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.page.controls.Button;
import com.adstream.automate.page.controls.Checkbox;
import com.adstream.automate.page.controls.Span;
import com.adstream.automate.utils.Common;
import org.openqa.selenium.By;
import org.openqa.selenium.NoSuchElementException;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.ui.ExpectedCondition;
import java.util.ArrayList;
import java.util.List;

/*
 * Created by demidovskiy-r on 19.06.2014.
 */
public class AdCodeManager extends AbstractForm {
    public static final String ROOT_NODE = "[data-dojo-type='admin.metadata.AdCodeManager']";
    private Checkbox allowedSpecChars;
    private Button createNew;

    public AdCodeManager(MetadataPage parent) {
        super(parent);
        allowedSpecChars = new Checkbox(parent, generateElementLocatorByDataRole("allowedSpecChars"));
        createNew = new Button(parent, generateElementLocatorByDataRole("createAdCode"));
    }

    @Override
    protected void initControls() {
    }

    @Override
    protected void loadForm() {
        getDriver().waitUntilElementAppearVisible(getFormLocator());
    }

    @Override
    protected void unloadForm() {
        getDriver().waitUntilElementDisappear(getFormLocator());
    }

    @Override
    protected String getRootNode() {
        return ROOT_NODE;
    }

    public void allowSpecChars(boolean isAllowed) {
        allowedSpecChars.setSelected(isAllowed);
    }

    public boolean isSpecialCharactersAllowed() {
        return allowedSpecChars.isSelected();
    }

    public AdCodeContainer newAdCodeContainer() {
        if (!getDriver().isElementVisible(By.cssSelector(AdCodeContainer.CONTAINER_NODE)))
            clickCreateNew();
        return new AdCodeContainer((MetadataPage)parent);
    }

    public AdCodeContainer getAdCodeContainer() {
        if (!getDriver().isElementVisible(By.cssSelector(AdCodeContainer.CONTAINER_NODE)))
            throw new NoSuchElementException("There is no AdCode container form on the page!");
        return new AdCodeContainer((MetadataPage)parent);
    }

    public AdCode getAdCodeByName(String name) {
        for (AdCode adCode : getAdCodes())
            if (adCode.getName().equals(name))
                return adCode;
        return null;
    }

    public List<String> getVisibleAdCodeNames() {
        List<String> adCodeNames = new ArrayList<>();
        List<AdCode> adCodes = getAdCodes();
        if (adCodes == null) return adCodeNames;
        for (AdCode adCode : adCodes)
            adCodeNames.add(adCode.getName());
        return adCodeNames;
    }

    public static class AdCode {
        private ExtendedWebDriver web;
        private MetadataPage parent;
        private String name;
        private Checkbox active;
        private Span edit;
        private Span remove;

        public AdCode(ExtendedWebDriver web, MetadataPage parent, WebElement row) {
            this.web = web;
            this.parent = parent;
            name = row.findElement(generateElementLocatorByDataRole("adCodeRowName")).getText();
            active = new Checkbox(parent, row.findElement(generateElementLocatorByDataRole("toggleAdCodeActiveStatus")));
            edit = new Span(parent, row.findElement(generateElementLocatorByDataRole("editAdCode")));
            remove = new Span(parent, row.findElement(generateElementLocatorByDataRole("removeAdCode")));
        }

        public String getName() {
            return name;
        }

        public void selectActive(boolean selected) {
            active.setSelected(selected);
        }

        public void uncheckSequentialNumber()
        {
            web.findElement(By.xpath("//input[@data-target='sequenceCharacters']")).click();
        }

        public void checkSequentialNumber()
        {
            web.findElement(By.xpath("//input[@data-target='sequenceCharacters']")).click();
        }

        public boolean verifySequentialState()
        {
            boolean stateOfSequential = web.findElement(By.xpath("//input[@data-target='sequenceCharacters']")).isSelected();
            return stateOfSequential;
        }

        public boolean isActive() {
            return active.isSelected();
        }

        public AdCodeContainer edit() {
            if (!web.isElementVisible(By.cssSelector(AdCodeContainer.CONTAINER_NODE))) {
                clickEditBtn();
                waitUntilAdCodeNameAppears(getName());
            }
            return new AdCodeContainer(parent);
        }

        public DeleteAdCodePopUp getDeleteAdCodePopUp() {
            if (!web.isElementVisible(By.xpath(DeleteAdCodePopUp.TITLE_NODE)))
                clickRemoveBtn();
            return new DeleteAdCodePopUp(parent, DeleteAdCodePopUp.TITLE);
        }

        private void clickEditBtn() {
            edit.click();
        }

        private void clickRemoveBtn() {
            remove.click();
        }

        private void waitUntilAdCodeNameAppears(final String name) {
            web.waitUntil(new ExpectedCondition<Boolean>() {
                public Boolean apply(WebDriver webDriver) {
                    return webDriver.findElement(getCustomCodeNameLocator()).getAttribute("value").equals(name);
                }
            });
        }

        private By generateElementLocatorByDataRole(String partialLocator) {
            return By.cssSelector("[data-role='" + partialLocator + "']");
        }

        private By getCustomCodeNameLocator() {
            return By.cssSelector(AdCodeContainer.CONTAINER_NODE + " [data-role='adCodeName']");
        }
    }

    private List<AdCode> getAdCodes() {
        if (!getDriver().isElementPresent(getAdCodeRowLocator())) return null;
        List<WebElement> rows = getDriver().findElements(getAdCodeRowLocator());
        List<AdCode> adCodes = new ArrayList<>();
        for (WebElement row: rows)
            adCodes.add(new AdCode(getDriver(), (MetadataPage)parent, row));
        return adCodes;
    }



    private void clickCreateNew() {
        createNew.click();
    }

    private By getAdCodeRowLocator() {
        return generateElementLocatorByDataRole("adCodeRow");
    }

    private By getFormLocator() {
        return By.cssSelector(getRootNode());
    }

    protected By generateElementLocatorByDataRole(String partialLocator) {
        return By.cssSelector(getRootNode() + " [data-role='" + partialLocator + "']");
    }

    protected By generateElementLocator(String partialLocator) {
        return By.cssSelector(getRootNode() + " " + partialLocator);
    }
}