package com.adstream.automate.babylon.sut.pages.ordering.elements.forms;

import com.adstream.automate.babylon.sut.pages.ordering.OrderItemPage;
import com.adstream.automate.babylon.sut.pages.ordering.elements.popup.DeleteDestinationPopUp;
import com.adstream.automate.babylon.sut.pages.ordering.elements.popup.DeleteServicePopUp;
import com.adstream.automate.page.controls.Button;
import com.adstream.automate.page.controls.Checkbox;
import com.adstream.automate.page.controls.DojoCombo;
import com.adstream.automate.page.controls.Edit;
import org.openqa.selenium.By;
import org.openqa.selenium.NoSuchElementException;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.ui.ExpectedCondition;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/*
 * Created by demidovskiy-r on 24.01.14.
 */
public class AdditionalServiceForm extends AbstractForm {
    public static final String ROOT_NODE = "#servicesBlock";
    private static String DUBBING_SERVICE_NODE = "dubbingFields";
    private static String PRODUCTION_SERVICE_NODE = "productionFields";
    private Button dubbingServicesBtn;
    private Button productionServicesBtn;
    private Button addDestinationBtn;
    private Button addServiceGroupBtn;
    private Button editDestinationsBtn;
    private Button cancelDestinationBtn;

    public AdditionalServiceForm(OrderItemPage parent) {
        super(parent);
        cancelDestinationBtn = new Button(parent, generateFormElementLocator("[data-role='cancelBDGroup']"));
        dubbingServicesBtn = new Button(parent, generateFormElementLocator("[value='nonBroadcastDestinations']"));
        productionServicesBtn = new Button(parent, generateFormElementLocator("[value='productionServices']"));
        addDestinationBtn = new Button(parent, generateFormElementLocator("[data-role='addDestinationLink']"));
        addServiceGroupBtn = new Button(parent, getDriver().isElementVisible(getNonBroadcastDestinationGroupFormLocator())
                                                ? generateAddServiceGroupBtnLocator(DUBBING_SERVICE_NODE)
                                                : generateAddServiceGroupBtnLocator(PRODUCTION_SERVICE_NODE));
        editDestinationsBtn = new Button(parent, generateFormElementLocator("[data-role='editDestinations'] span:last-child"));
    }

    @Override
    protected void initControls() {
    }

    @Override
    protected void initControlsForAU() {
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

    public static class NonBroadcastDestinationGroupForm extends AbstractForm {
        private WebElement group;
        private Button removeBDGroup;
        private DojoCombo type;
        private DojoCombo destination;
        private DojoCombo format;
        private DojoCombo specification;
        private DojoCombo mediaCompile;
        private Edit noCopies;
        private Edit deliveryDetails;
        private Edit notesLabels;
        private Checkbox standard;
        private Checkbox express;

        public NonBroadcastDestinationGroupForm(OrderItemPage parent, WebElement group) {
            super(parent);
            this.group = group;
        }

        @Override
        protected void initControls() {
            controls.put("Type", type = new DojoCombo(parent, group.findElement(generateServiceDictionaryControlLocator("1"))));
            controls.put("Destination", destination = new DojoCombo(parent, group.findElement(generateServiceDictionaryControlLocator("2"))));
            controls.put("Format", format = new DojoCombo(parent, group.findElement(generateServiceDictionaryControlLocator("3"))));
            controls.put("Specification", specification = new DojoCombo(parent, group.findElement(generateServiceDictionaryControlLocator("4"))));
            controls.put("Media Compile", mediaCompile = new DojoCombo(parent, group.findElement(generateServiceDictionaryControlLocator("6"))));
            controls.put("No copies", noCopies = new Edit(parent, group.findElement(By.name("noOfCopies"))));
            controls.put("Delivery Details", deliveryDetails = new Edit(parent, group.findElement(By.name("deliveryDetails"))));
            controls.put("Notes & Labels", notesLabels = new Edit(parent, group.findElement(By.name("notesAndLabels"))));
            controls.put("Standard", standard = new Checkbox(parent, group.findElement(By.cssSelector("[data-id='2']"))));
            controls.put("Express", express = new Checkbox(parent, group.findElement(By.cssSelector("[data-id='3']"))));
        }


        @Override
        protected void initControlsForAU() {
            controls.put("Type", type = new DojoCombo(parent, group.findElement(generateServiceDictionaryControlLocator("1"))));
            controls.put("Destination", destination = new DojoCombo(parent, group.findElement(generateServiceDictionaryControlLocator("2"))));
            controls.put("Format", format = new DojoCombo(parent, group.findElement(generateServiceDictionaryControlLocator("3"))));
            controls.put("Specification", specification = new DojoCombo(parent, group.findElement(generateServiceDictionaryControlLocator("4"))));
            controls.put("Media Compile", mediaCompile = new DojoCombo(parent, group.findElement(generateServiceDictionaryControlLocator("6"))));
            controls.put("No copies", noCopies = new Edit(parent, group.findElement(By.name("noOfCopies"))));
            controls.put("Delivery Details", deliveryDetails = new Edit(parent, group.findElement(By.name("deliveryDetails"))));
            controls.put("Notes & Labels", notesLabels = new Edit(parent, group.findElement(By.name("notesAndLabels"))));
        }


        @Override
        protected void loadForm() {
            getDriver().waitUntilElementAppearVisible(getNonBroadcastDestinationGroupFormLocator());
        }

        @Override
        protected void unloadForm() {
            getDriver().waitUntilElementDisappear(getNonBroadcastDestinationGroupFormLocator());
        }

        @Override
        protected String getRootNode() {
            return ROOT_NODE;
        }

        public DeleteDestinationPopUp getDeleteDestinationPopUp() {
            if (!getDriver().isElementVisible(By.xpath(DeleteDestinationPopUp.TITLE_NODE)))
                clickTrashBtn();
            return new DeleteDestinationPopUp((OrderItemPage)parent, DeleteDestinationPopUp.TITLE);
        }

        public List<String> getAvailableDestinations() {
            getControls();
            return destination.getValues();
        }

        public List<String> getAvailableFormats() {
            getControls();
            return format.getValues();
        }

        public List<String> getAvailableTypes() {
            getControls();
            return type.getValues();
        }

        public List<String> getAvailableTypesForAU() {
            getControlsForAU();
            return type.getValues();
        }

        public List<String> getAvailableFormatsForAU() {
            getControlsForAU();
            return format.getValues();
        }

        private void clickTrashBtn() {
            if (removeBDGroup == null)
                removeBDGroup = new Button(parent, group.findElement(generateRemoveServiceGroupBtnLocator(DUBBING_SERVICE_NODE)));
            removeBDGroup.click();
        }

        private By generateServiceDictionaryControlLocator(String partialLocator) {
            return By.cssSelector(".schema_field_wrapper > div:nth-child(" + partialLocator + ") .dijitComboBox");
        }
    }

    public static class ProductionServiceGroupForm extends AbstractForm {
        private WebElement group;
        private Button removeProductionServiceGroup;
        private DojoCombo type;
        private Edit notes;

        public ProductionServiceGroupForm(OrderItemPage parent, WebElement group) {
            super(parent);
            this.group = group;
        }

        @Override
        protected void initControls() {
            controls.put("Type", type = new DojoCombo(parent, group.findElement(By.cssSelector("[id*='loadProductionDictionary'].dijitComboBox"))));
            controls.put("Notes", notes = new Edit(parent, group.findElement(By.name("notes"))));
        }

        @Override
        protected void initControlsForAU() {
            controls.put("Type", type = new DojoCombo(parent, group.findElement(By.cssSelector("[id*='loadProductionDictionary'].dijitComboBox"))));
            controls.put("Notes", notes = new Edit(parent, group.findElement(By.name("notes"))));
        }

        @Override
        protected void loadForm() {
            getDriver().waitUntilElementAppearVisible(getProductionServiceGroupFormLocator());
        }

        @Override
        protected void unloadForm() {
            getDriver().waitUntilElementDisappear(getProductionServiceGroupFormLocator());
        }

        @Override
        protected String getRootNode() {
            return ROOT_NODE;
        }

        public DeleteServicePopUp getDeleteServicePopUp() {
            if (!getDriver().isElementVisible(By.xpath(DeleteServicePopUp.TITLE_NODE)))
                clickTrashBtn();
            return new DeleteServicePopUp((OrderItemPage)parent, DeleteServicePopUp.TITLE);
        }


        private void clickTrashBtn() {
            if (removeProductionServiceGroup == null)
                removeProductionServiceGroup = new Button(parent, group.findElement(generateRemoveServiceGroupBtnLocator(PRODUCTION_SERVICE_NODE)));
            removeProductionServiceGroup.click();
        }

        public List<String> getAvailableTypes() {
            getControls();
            return type.getValues();
        }
    }

    public boolean isServiceSwitcherButtonVisible(String serviceType) {
        return isServiceButtonVisible(AdditionalService.findByType(serviceType));
    }

    public boolean isServiceSwitcherButtonSelected(String serviceType) {
        return isServiceButtonSelected(AdditionalService.findByType(serviceType));
    }

    public AdditionalServiceForm switchOnDubbingService() {
        return switchService(AdditionalService.DUBBING);
    }

    public AdditionalServiceForm switchOnProductionService() {
        return switchService(AdditionalService.PRODUCTION);
    }

    public DestinationForm getDestinationForm(AdditionalDestinationAction action) {
        if (!getDriver().isElementVisible(By.cssSelector(DestinationForm.ROOT_NODE)))
            switch (action) {
                case ADD: clickAddDestinationsBtn(); break;
                case EDIT: clickEditDestinationsBtn(); break;
                default: throw new IllegalArgumentException("Unknown action: " + action);
            }
        return new DestinationForm((OrderItemPage)parent);
    }

    public AddPhysicalDeliveryDestinationForm getAddPhysicalDeliveryDestinationForm(AdditionalDestinationAction action) {
        if (!getDriver().isElementVisible(By.cssSelector(DestinationForm.ROOT_NODE)))
            switch (action) {
                case ADD: clickAddDestinationsBtn(); break;
                case EDIT: clickEditDestinationsBtn(); break;
                default: throw new IllegalArgumentException("Unknown action: " + action);
            }
        return new AddPhysicalDeliveryDestinationForm((OrderItemPage)parent);
    }

    public AddFTPDeliveryDestinationForm getAddFTPDeliveryDestinationForm(AdditionalDestinationAction action) {
        if (!getDriver().isElementVisible(By.cssSelector(DestinationForm.ROOT_NODE)))
            switch (action) {
                case ADD: clickAddDestinationsBtn(); break;
                case EDIT: clickEditDestinationsBtn(); break;
                default: throw new IllegalArgumentException("Unknown action: " + action);
            }
        return new AddFTPDeliveryDestinationForm((OrderItemPage)parent);
    }

    public AddNVergeDeliveryDestinationForm getAddNVergeDeliveryDestinationForm(AdditionalDestinationAction action) {
        if (!getDriver().isElementVisible(By.cssSelector(DestinationForm.ROOT_NODE)))
            switch (action) {
                case ADD: clickAddDestinationsBtn(); break;
                case EDIT: clickEditDestinationsBtn(); break;
                default: throw new IllegalArgumentException("Unknown action: " + action);
            }
        return new AddNVergeDeliveryDestinationForm((OrderItemPage)parent);
    }

    public void addBDGroup() {
        addServiceGroup(getCountNonBDGroups(), getNonBroadcastDestinationGroupFormLocator());
    }

    public void addProductionServiceGroup() {
        addServiceGroup(getCountProductionServiceGroups(), getProductionServiceGroupFormLocator());
    }

    public void clickAddServiceGroupButton() {
        addServiceGroupBtn.click();
    }

    public void clickCancelAdditionalServiceButton(){cancelDestinationBtn.click();}

    public void clickOkButtonAfterCancelationAdditiobalService(){
        getDriver().findElement(By.cssSelector("[data-id='ok']")).click();
    }

    public int getCountNonBDGroups() {
        return getDriver().findElements(getNonBroadcastDestinationGroupFormLocator()).size();
    }

    public int getCountProductionServiceGroups() {
        return getDriver().findElements(getProductionServiceGroupFormLocator()).size();
    }

    public Map<Integer, NonBroadcastDestinationGroupForm> getNonBroadcastDestinationGroups() {
        if (!getDriver().isElementVisible(getNonBroadcastDestinationGroupFormLocator()))
            throw new NoSuchElementException("There is no any non broadcast destination group on Additional Services section!");
        List<WebElement> nonBDGroups = getDriver().findElements(getNonBroadcastDestinationGroupFormLocator());
        Map<Integer, NonBroadcastDestinationGroupForm> nonBroadcastDestinationGroupForms = new HashMap<>();
        for (int i = 0; i < nonBDGroups.size(); i++)
            nonBroadcastDestinationGroupForms.put(i, new NonBroadcastDestinationGroupForm((OrderItemPage)parent, nonBDGroups.get(i)));
        return nonBroadcastDestinationGroupForms;
    }

    public Map<Integer, ProductionServiceGroupForm> getProductionServiceGroups() {
        if (!getDriver().isElementVisible(getProductionServiceGroupFormLocator()))
            throw new NoSuchElementException("There is no any production service group on Additional Services section!");
        List<WebElement> productionServiceGroups = getDriver().findElements(getProductionServiceGroupFormLocator());
        Map<Integer, ProductionServiceGroupForm> productionServiceGroupForms = new HashMap<>();
        for (int i = 0; i < productionServiceGroups.size(); i++)
            productionServiceGroupForms.put(i, new ProductionServiceGroupForm((OrderItemPage)parent, productionServiceGroups.get(i)));
        return productionServiceGroupForms;
    }

    public static enum AdditionalDestinationAction {
        ADD("add"),
        EDIT("edit");

        private String action;

        private AdditionalDestinationAction(String action) {
            this.action = action;
        }

        @Override
        public String toString() {
            return action;
        }

        public static AdditionalDestinationAction findByAction(String action) {
            for (AdditionalDestinationAction additionalDestinationAction: values())
                if (additionalDestinationAction.toString().equalsIgnoreCase(action))
                    return additionalDestinationAction;
            throw new IllegalArgumentException("Unknown action: " + action);
        }
    }

    private enum AdditionalService {
        DUBBING("Dubbing"),
        PRODUCTION("Production");

        private String type;

        private AdditionalService(String type) {
            this.type = type;
        }

        @Override
        public String toString() {
            return type;
        }

        public static AdditionalService findByType(String type) {
            for (AdditionalService service: values())
                if (service.toString().equals(type))
                    return service;
            throw new IllegalArgumentException("Unknown additional service type: " + type);
        }
    }

    private AdditionalServiceForm switchService(AdditionalService service) {
        switch (service) {
            case DUBBING: if (!isServiceVisible(service)) dubbingServicesBtn.click(); break;
            case PRODUCTION: if (!isServiceVisible(service)) productionServicesBtn.click(); break;
            default: throw new IllegalArgumentException("Unknown additional service: " + service.toString());
        }
        return new AdditionalServiceForm((OrderItemPage)parent);
    }

    private boolean isServiceVisible(AdditionalService service) {
        switch (service) {
            case DUBBING: return getDriver().isElementVisible(getNonBroadcastDestinationGroupFormLocator());
            case PRODUCTION: return getDriver().isElementVisible(getProductionServiceGroupFormLocator());
            default: throw new IllegalArgumentException("Unknown additional service: " + service.toString());
        }
    }

    private boolean isServiceButtonVisible(AdditionalService service) {
        switch (service) {
            case DUBBING: return dubbingServicesBtn.isVisible();
            case PRODUCTION: return productionServicesBtn.isVisible();
            default: throw new IllegalArgumentException("Unknown additional service: " + service.toString());
        }
    }

    private boolean isServiceButtonSelected(AdditionalService service) {
        switch (service) {
            case DUBBING: return dubbingServicesBtn.isSelected();
            case PRODUCTION: return productionServicesBtn.isSelected();
            default: throw new IllegalArgumentException("Unknown additional service: " + service.toString());
        }
    }

    private void addServiceGroup(int countServiceGroup, By groupFormLocator) {
        clickAddServiceGroupButton();
        waitUntilServiceGroupWillBeAdded(countServiceGroup, groupFormLocator);
    }

    private void waitUntilServiceGroupWillBeAdded(final int countServiceGroup, final By locator) {
        getDriver().waitUntil(new ExpectedCondition<Boolean>() {
            public Boolean apply(WebDriver webDriver) {
                return webDriver.findElements(locator).size() == (countServiceGroup + 1);
            }
        });
    }

    private void clickAddDestinationsBtn() {
        addDestinationBtn.click();
    }

    private void clickEditDestinationsBtn(){
        editDestinationsBtn.click();
    }

    private static By getNonBroadcastDestinationGroupFormLocator() {
        return By.cssSelector(generateServiceRootNode(DUBBING_SERVICE_NODE));
    }

    private static By getProductionServiceGroupFormLocator() {
        return By.cssSelector(generateServiceRootNode(PRODUCTION_SERVICE_NODE));
    }

    private By generateAddServiceGroupBtnLocator(String partialServiceNode) {
        return generateFormElementLocator("[data-dojo-type='ordering.form.services." + partialServiceNode + "'] [data-role='addBDGroup']");
    }

    private static By generateRemoveServiceGroupBtnLocator(String partialServiceNode) {
        return By.cssSelector(generateServiceRootNode(partialServiceNode)+ " [data-role='removeBDGroup']");
    }

    private static String generateServiceRootNode(String partialServiceNode) {
        return ROOT_NODE + " [data-dojo-type='ordering.form.services." + partialServiceNode + "']";
    }

    private By  getFormLocator() {
        return By.cssSelector(getRootNode());
    }
}