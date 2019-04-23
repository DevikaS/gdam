package com.adstream.automate.babylon.sut.pages.ordering.elements.forms;

import com.adstream.automate.babylon.sut.pages.ordering.OrderItemPage;
import com.adstream.automate.babylon.sut.pages.ordering.elements.forms.subForms.AssetContainer;
import com.adstream.automate.babylon.sut.pages.ordering.elements.forms.subForms.SupplyMediaForm;
import com.adstream.automate.page.controls.Button;
import org.openqa.selenium.By;
import org.openqa.selenium.NoSuchElementException;

/**
 * Created with IntelliJ IDEA.
 * User: demidovskiy-r
 * Date: 17.09.13
 * Time: 14:49
 */
public class AddMediaToOrderForm extends AbstractForm {
    public static final String ROOT_NODE = "#mediaBlock";
    private Button newMaster;
    private Button retrieveFromLibrary;
    private Button retrieveFromProject;
    protected OrderItemPage parent;

    public AddMediaToOrderForm(OrderItemPage parent) {
        super(parent);
        this.parent = parent;
        newMaster = new Button(parent, getNewMasterBtnLocator());
        retrieveFromLibrary = new Button(parent, getRetrieveFromLibraryBtnLocator());
        retrieveFromProject = new Button(parent, getRetrieveFromProjectBtnLocator());
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

    public static enum MediaContent {
        LIBRARY("Library"),
        PROJECTS("Projects");

        private String name;

        private MediaContent(String name) {
            this.name = name;
        }


        @Override
        public String toString() {
            return name;
        }

        public static MediaContent findByName(String name) {
            for (MediaContent mediaContent: values())
                if (mediaContent.toString().equalsIgnoreCase(name))
                    return mediaContent;
            throw new IllegalArgumentException("Unknown media content: " + name);
        }
    }

    public AssetContainer getAssetContainer() {
        if (!getDriver().isElementVisible(By.cssSelector(generateMediaContentLocator(MediaContent.LIBRARY.toString()) + "," + generateMediaContentLocator(MediaContent.PROJECTS.toString()))))
             throw new NoSuchElementException("Media content container is not present on order item page!");
        return new AssetContainer(parent);
    }

    public AssetContainer retrieveFromLibrary() {
        if (!getDriver().isElementVisible(By.cssSelector(generateMediaContentLocator(MediaContent.LIBRARY.toString()))))
            clickRetrieveFromLibrary();
        return new AssetContainer(parent);
    }

    public AssetContainer retrieveFromProject() {
        if (!getDriver().isElementVisible(By.cssSelector(generateMediaContentLocator(MediaContent.PROJECTS.toString()))))
            clickRetrieveFromProject();
        return new AssetContainer(parent);
    }

    public SupplyMediaForm getSupplyMediaForm() {
        if (!getDriver().isElementVisible(getSupplyMediaFormLocator()))
            throw new NoSuchElementException("Supply media container is not present on order item page!");
        return new SupplyMediaForm(parent);
    }

    public SupplyMediaForm newMaster() {
        if (!getDriver().isElementVisible(getSupplyMediaFormLocator()))
            clickNewMaster();
        return new SupplyMediaForm(parent);
    }

    public boolean isNewMasterBtnActive() {
        return !newMaster.getAttribute("class").contains("inactiveButton");
    }

    public boolean isNewMasterBtnEnabled() {
        return newMaster.isEnabled();
    }

    public boolean isRetrieveFromLibraryBtnEnabled() {
        return retrieveFromLibrary.isEnabled();
    }

    public boolean isRetrieveFromProjectBtnEnabled() {
        return retrieveFromProject.isEnabled();
    }

    public boolean isRetrieveMediaFromButtonVisible(String buttonName) {
        switch (buttonName) {
            case "New Master": return isNewMasterBtnVisible();
            case "Retrieve from Projects": return isRetrieveFromProjectsBtnVisible();
            case "Retrieve from Library": return isRetrieveFromLibraryBtnVisible();
            default: throw new IllegalArgumentException("Unknown button: " + buttonName);
        }
    }

    private boolean isNewMasterBtnVisible() {
        return newMaster.isVisible();
    }

    private boolean isRetrieveFromLibraryBtnVisible() {
        return retrieveFromLibrary.isVisible();
    }

    private boolean isRetrieveFromProjectsBtnVisible() {
        return retrieveFromProject.isVisible();
    }

    private void clickNewMaster() {
        newMaster.click();
        getDriver().sleep(1000);
    }

    private void clickRetrieveFromLibrary() {
        retrieveFromLibrary.click();
        getDriver().sleep(6000);
    }

    private void clickRetrieveFromProject() {
        retrieveFromProject.click();
        getDriver().sleep(1000);
    }

    public void typeInSearch(String value) {
        getDriver().findElement(getSearchFieldLocator()).sendKeys(value);
    }

    protected String generateMediaContentLocator(String partialLocator) {
        return AssetContainer.ROOT_NODE + " [data-dojo-type='ordering.form.assets."+ partialLocator + "']";
    }

    protected By getSupplyMediaFormLocator() {
        return By.cssSelector(SupplyMediaForm.ROOT_NODE + " [data-dojo-type='ordering.form.supplyMedia']");
    }

    private By getNewMasterBtnLocator() {
        return generateAddMediaFormButtonLocator("supply_media");
    }

    private By getRetrieveFromLibraryBtnLocator() {
        return generateAddMediaFormButtonLocator("library_assets");
    }

    private By getRetrieveFromProjectBtnLocator() {
        return generateAddMediaFormButtonLocator("project_assets");
    }

    private By getSearchFieldLocator() {
        return By.cssSelector("[placeholder='Search']");
    }

    private By generateAddMediaFormButtonLocator(String partialLocator) {
        return By.cssSelector("[data-template='ordering.form." + partialLocator + "']");
    }

    private By getFormLocator() {
        return By.cssSelector(getRootNode());
    }
}