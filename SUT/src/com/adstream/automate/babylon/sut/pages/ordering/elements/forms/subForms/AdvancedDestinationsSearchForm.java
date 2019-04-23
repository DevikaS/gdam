package com.adstream.automate.babylon.sut.pages.ordering.elements.forms.subForms;

import com.adstream.automate.babylon.sut.pages.ordering.OrderItemPage;
import com.adstream.automate.babylon.sut.pages.ordering.elements.forms.BroadcastDestinationForm;
import com.adstream.automate.babylon.sut.pages.ordering.elements.popup.MultipleSearchResultsPopUp;
import com.adstream.automate.page.controls.*;
import org.openqa.selenium.By;
import org.openqa.selenium.NoSuchElementException;
import org.openqa.selenium.WebElement;
import java.util.List;
import java.util.Map;

/*
 * Created by demidovskiy-r on 14.05.14.
 */
public class AdvancedDestinationsSearchForm extends BroadcastDestinationForm {
    public static final String SUB_ROOT_NODE = ROOT_NODE + " [data-role='container']";
    private DojoCombo searchMarket;
    private DojoCombo searchDestinationType;
    private DojoTextBox searchSysCode;
    private DojoCombo searchDeliveryType;
    private Edit multipleSysCodes;
    private Edit uploadFile;
    private Button searchBtn;
    private Button resetBtn;
    private List<WebElement> dojoComboList;

    public AdvancedDestinationsSearchForm(OrderItemPage parent) {
        super(parent);
        searchBtn = new Button(parent, generateFormElementLocator("[data-role='searchBtn']"));
        resetBtn = new Button(parent, generateFormElementLocator("[data-role='resetBtn']"));
        dojoComboList = getDriver().findElements(generateFormElementLocator("div[id*='Autocomplete']"));
    }

    @Override
    protected void initControls() {
        controls.put("Market", searchMarket = new DojoCombo(parent, dojoComboList.get(0)));
        controls.put("Destination Type", searchDestinationType = new DojoCombo(parent, dojoComboList.get(1)));
        controls.put("Syscode", searchSysCode = new DojoTextBox(parent, generateFormElementLocator("div[id*='TextBox']")));
        controls.put("Delivery Type", searchDeliveryType = new DojoCombo(parent, dojoComboList.get(2)));
        controls.put("Syscodes", multipleSysCodes = new Edit(parent, generateFormElementLocator("[name='stations']")));
        controls.put("File", uploadFile = new Edit(parent, generateFormElementLocator("[name='file']")));
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
        return SUB_ROOT_NODE;
    }

    public void uploadFile(Map<String, String> fields, boolean isCorrectFile) {
        for (Map.Entry<String, String> field : fields.entrySet()) {
            String fieldName = field.getKey();
            String fieldValue = field.getValue();
            if (getControls().containsKey(fieldName)) {
                getControls().get(fieldName).getWebElement().sendKeys(fieldValue);
                if (isCorrectFile) getDriver().waitUntilElementAppearVisible(By.xpath(MultipleSearchResultsPopUp.TITLE_NODE));
            } else
                throw new IllegalArgumentException("Unknown field name: " + fieldName);
        }
    }

    public BroadcastDestinationForm search() {
        clickSearchBtn();
        return new BroadcastDestinationForm((OrderItemPage)parent);
    }

    public BroadcastDestinationForm multipleSearch() {
        initMultipleSearchResultsPopUp().apply();
        return new BroadcastDestinationForm((OrderItemPage)parent);
    }

    public BroadcastDestinationForm multipleSearchByUploadedSysCodes() {
        getMultipleSearchResultsPopUp().apply();
        return new BroadcastDestinationForm((OrderItemPage)parent);
    }

    public BroadcastDestinationForm reset() {
        resetBtn.click();
        return new BroadcastDestinationForm((OrderItemPage)parent);
    }

    public MultipleSearchResultsPopUp getMultipleSearchResultsPopUp() {
        if (!getDriver().isElementVisible(By.xpath(MultipleSearchResultsPopUp.TITLE_NODE)))
            throw new NoSuchElementException("There is no " + MultipleSearchResultsPopUp.TITLE + " popup on the page!");
        return new MultipleSearchResultsPopUp((OrderItemPage)parent, MultipleSearchResultsPopUp.TITLE);
    }

    public boolean isValidationFileTypeErrorVisible() {
        return !getDriver().findElement(getValidationFileTypeErrorLocator()).getAttribute("class").contains("none");
    }

    private MultipleSearchResultsPopUp initMultipleSearchResultsPopUp() {
        if (!getDriver().isElementVisible(By.xpath(MultipleSearchResultsPopUp.TITLE_NODE)))
            clickSearchBtn();
        return new MultipleSearchResultsPopUp((OrderItemPage)parent, MultipleSearchResultsPopUp.TITLE);
    }

    private void clickSearchBtn() {
        searchBtn.click();
    }

    private By getValidationFileTypeErrorLocator() {
        return generateFormElementLocator("[data-dojo-type='ordering.form.destinations.UploadBtn'] .error");
    }

    private By getFormLocator() {
        return By.cssSelector(getRootNode());
    }
}