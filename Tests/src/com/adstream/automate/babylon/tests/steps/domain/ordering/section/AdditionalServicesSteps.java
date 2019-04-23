package com.adstream.automate.babylon.tests.steps.domain.ordering.section;

import com.adstream.automate.babylon.JsonObjects.CustomMetadata;
import com.adstream.automate.babylon.JsonObjects.ordering.*;
import com.adstream.automate.babylon.JsonObjects.ordering.enums.UploadRequestType;
import com.adstream.automate.babylon.sut.pages.ordering.elements.ServiceLevelType;
import com.adstream.automate.babylon.sut.pages.ordering.elements.dictionaries.Format;
import com.adstream.automate.babylon.sut.pages.ordering.elements.forms.AddPhysicalDeliveryDestinationForm;
import com.adstream.automate.babylon.sut.pages.ordering.elements.forms.AdditionalServiceForm;
import com.adstream.automate.babylon.sut.pages.ordering.elements.forms.DestinationForm;
import com.adstream.automate.babylon.tests.steps.domain.ordering.DraftOrderSteps;
import com.adstream.automate.utils.Common;
import org.jbehave.core.annotations.Given;
import org.jbehave.core.annotations.Then;
import org.jbehave.core.annotations.When;
import org.jbehave.core.model.ExamplesTable;
import java.util.*;
import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.*;

/*
 * Created by demidovskiy-r on 30.05.2014.
 */
public class AdditionalServicesSteps extends DraftOrderSteps {

    private AdditionalServiceForm getAdditionalServiceForm() {
        return getOrderItemPage().getAdditionalServiceForm();
    }

    private AdditionalServiceForm getProductionAdditionalServiceForm() {
        return getAdditionalServiceForm().switchOnProductionService();
    }

    private Map<String, String> preparePhysicalDeliveryDestinationFields(ExamplesTable fieldsTable){
        Map<String, String> row = parametrizeTabularRow(fieldsTable);
        if (row.containsKey("Destination Name")) row.put("Destination Name", wrapVariableWithTestSession(row.get("Destination Name")));
        if (row.containsKey("Contact Name")) row.put("Contact Name", wrapVariableWithTestSession(row.get("Contact Name")));
        if (row.containsKey("Contact Details")) row.put("Contact Details", wrapVariableWithTestSession(row.get("Contact Details")));
        if (row.containsKey("Street Address")) row.put("Street Address", wrapVariableWithTestSession(row.get("Street Address")));
        if (row.containsKey("City")) row.put("City", wrapVariableWithTestSession(row.get("City")));
        if (row.containsKey("Post Code")) row.put("Post Code", wrapVariableWithTestSession(row.get("Post Code")));
        if (row.containsKey("Country")) row.put("Country", wrapVariableWithTestSession(row.get("Country")));
        return row;
    }

    private String prepareAdditionalDestination(String destination) {
        return destination.contains("email") ? wrapUserEmailWithTestSession(destination) : wrapVariableWithTestSession(destination);
    }

    private Map<String, String> prepareAdditionalServicesSectionFields(ExamplesTable fieldsTable, int destinationNumber) {
        Map<String, String> row = parametrizeTabularRow(fieldsTable, destinationNumber);
        if (row.containsKey("Destination")) row.put("Destination", prepareAdditionalDestination(row.get("Destination")));
        if (row.containsKey("Standard")) row.put("Standard", String.valueOf(row.get("Standard").equals("should")));
        if (row.containsKey("Express")) row.put("Express", String.valueOf(row.get("Express").equals("should")));
        return row;
    }

    private String prepareDeliveryDetailsOfAdditionalServices(String deliveryDetailsValue) {
        String[] detailsParts = deliveryDetailsValue.split(" ");
        StringBuilder sb = new StringBuilder();
        for (String part : detailsParts)
            sb.append(part.contains("email") ? wrapUserEmailWithTestSession(part) : wrapVariableWithTestSession(part)).append("\n");
        return sb.toString();
    }

    private List<NonBroadcastDestinationItem> prepareNonBDItems(ExamplesTable fieldsTable) {
        List<NonBroadcastDestinationItem> nonBDItems = new ArrayList<>(fieldsTable.getRowCount());
        for (int i = 0; i < fieldsTable.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(fieldsTable, i);
            CustomMetadata cmNonBDItem = new CustomMetadata();
            if (row.containsKey("Type") && !row.get("Type").isEmpty()) cmNonBDItem.put("method", new String[]{row.get("Type")});
            if (row.containsKey("Destination") && !row.get("Destination").isEmpty()) cmNonBDItem.put("destination", prepareAdditionalDestination(row.get("Destination")));
            if (row.containsKey("Format") && !row.get("Format").isEmpty()) cmNonBDItem.put("format", new String[]{row.get("Format")});
            if (row.containsKey("Specification") && !row.get("Specification").isEmpty()) cmNonBDItem.put("specification", new String[]{Format.findByName(row.get("Specification"))});
            if (row.containsKey("Media Compile") && !row.get("Media Compile").isEmpty()) cmNonBDItem.put("mediaCompile", new String[]{row.get("Media Compile")});
            if (row.containsKey("No copies") && !row.get("No copies").isEmpty()) cmNonBDItem.put("noOfCopies", row.get("No copies"));
            if (row.containsKey("Delivery Details") && !row.get("Delivery Details").isEmpty()) cmNonBDItem.put("deliveryDetails", prepareDeliveryDetailsOfAdditionalServices(row.get("Delivery Details")));
            if (row.containsKey("Notes & Labels") && !row.get("Notes & Labels").isEmpty()) cmNonBDItem.put("notesAndLabels", row.get("Notes & Labels"));
            if (row.containsKey("Standard") && row.get("Standard").equals("should")) {
                CustomMetadata cmServiceLvl = new CustomMetadata();
                cmServiceLvl.put("id", new String[]{ServiceLevelType.findByName("Standard").getKey()});
                cmNonBDItem.put("serviceLevel", new ServiceLevel(cmServiceLvl));
            }
            if (row.containsKey("Express") && row.get("Express").equals("should")) {
                CustomMetadata cmServiceLvl = new CustomMetadata();
                cmServiceLvl.put("id", new String[]{ServiceLevelType.findByName("Express").getKey()});
                cmNonBDItem.put("serviceLevel", new ServiceLevel(cmServiceLvl));
            }
            NonBroadcastDestinationItem nonBDItem = new NonBroadcastDestinationItem(cmNonBDItem);
            nonBDItems.add(nonBDItem);
        }
        return nonBDItems;
    }

    private List<ProductionServiceItem> prepareProductionServiceItems(ExamplesTable fieldsTable) {
        List<ProductionServiceItem> productionServiceItems = new ArrayList<>(fieldsTable.getRowCount());
        for (int i = 0; i < fieldsTable.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(fieldsTable, i);
            CustomMetadata cmProductionServiceItem = new CustomMetadata();
            if (row.containsKey("Type") && !row.get("Type").isEmpty()) cmProductionServiceItem.put("serviceType", new String[]{row.get("Type")});
            if (row.containsKey("Notes") & !row.get("Notes").isEmpty()) cmProductionServiceItem.put("notes", row.get("Notes"));
            ProductionServiceItem productionServiceItem = new ProductionServiceItem(cmProductionServiceItem);
            productionServiceItems.add(productionServiceItem);
        }
        return productionServiceItems;
    }

    // | Type | Destination Name | Contact Name | Contact Details | Street Address | City | Post Code | Country |
    // | Type | FTP Destination Name | Contact Details | FTP Host Name | FTP User Name | FTP Password | FTP Path |
    // | Type | Email |
    @Given("{I |}create additional destinations with following fields: $fieldsTable")
    @When("{I |}created additional destinations with following fields: $fieldsTable")
    public void createAdditionalDestinations(ExamplesTable fieldsTable) {
        Map<UploadRequestType, List<AdditionalDestination>> additionalDestinations = new HashMap<>();
        List<AdditionalDestination> physicalDestinations = new ArrayList<>();
        List<AdditionalDestination> ftpDestinations = new ArrayList<>();
        List<AdditionalDestination> nVergeDestinations = new ArrayList<>();
        List<AdditionalDestination> genericsDestinations = new ArrayList<>();
        for (int i = 0; i < fieldsTable.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(fieldsTable, i);
            UploadRequestType uploadRequestType = UploadRequestType.findByName(row.get("Type"));
            AdditionalDestination additionalDestination = new AdditionalDestination();
            if (row.containsKey("Market")){
                additionalDestination.setMarketId(getCoreApi().getMarketKey(row.get("Market")));
            }else{
                additionalDestination.setMarketId(getCoreApi().getMarketKey("United Kingdom"));
            }
            if (uploadRequestType.equals(UploadRequestType.PHYSICAL)) {
                additionalDestination.setName(wrapVariableWithTestSession(row.get("Destination Name")));
                if (row.containsKey("Contact Name")) additionalDestination.setContactName(wrapVariableWithTestSession(row.get("Contact Name")));
                if (row.containsKey("Contact Details")) additionalDestination.setContactDetails(wrapVariableWithTestSession(row.get("Contact Details")));
                if (row.containsKey("Street Address")) additionalDestination.setStreetAddress(wrapVariableWithTestSession(row.get("Street Address")));
                if (row.containsKey("City")) additionalDestination.setCity(wrapVariableWithTestSession(row.get("City")));
                if (row.containsKey("Post Code")) additionalDestination.setPostCode(wrapVariableWithTestSession(row.get("Post Code")));
                if (row.containsKey("Country")) additionalDestination.setCountry(wrapVariableWithTestSession(row.get("Country")));
                physicalDestinations.add(additionalDestination);
                additionalDestinations.put(UploadRequestType.PHYSICAL, physicalDestinations);
            } else if (uploadRequestType.equals(UploadRequestType.FTP)) {
                additionalDestination.setName(wrapVariableWithTestSession(row.get("FTP Destination Name")));
                if (row.containsKey("Contact Details")) additionalDestination.setContactDetails(wrapVariableWithTestSession(row.get("Contact Details")));
                if (row.containsKey("FTP Host Name")) additionalDestination.setHostName(wrapVariableWithTestSession(row.get("FTP Host Name")));
                if (row.containsKey("FTP User Name")) additionalDestination.setUserName(wrapVariableWithTestSession(row.get("FTP User Name")));
                if (row.containsKey("FTP Password")) additionalDestination.setPass(wrapPathWithTestSession(row.get("FTP Password")));
                if (row.containsKey("FTP Path")) additionalDestination.setPath(wrapVariableWithTestSession(row.get("FTP Path")));
                ftpDestinations.add(additionalDestination);
                additionalDestinations.put(UploadRequestType.FTP, ftpDestinations);
            } else if (uploadRequestType.equals(UploadRequestType.NVERGE)) {
                additionalDestination.setName(wrapUserEmailWithTestSession(row.get("Email")));
                nVergeDestinations.add(additionalDestination);
                additionalDestinations.put(UploadRequestType.NVERGE, nVergeDestinations);
            } else if (uploadRequestType.equals(UploadRequestType.GENERICS)) {
                additionalDestination.setName(wrapUserEmailWithTestSession(row.get("Email")));
                genericsDestinations.add(additionalDestination);
                additionalDestinations.put(UploadRequestType.GENERICS, genericsDestinations);
            }
        }
        getCoreApi().addAdditionalDestinations(additionalDestinations);
    }

    // | Type | Destination | Format | Specification | Media Compile | No copies | Delivery Details | Notes & Labels | Standard | Express |
    @Given("{I |}create for '$orderType' order with item {clock number|isrc code} '$clockNumber' additional services with following fields: $fieldsTable")
    @When("{I |}created for '$orderType' order with item {clock number|isrc code} '$clockNumber' additional services with following fields: $fieldsTable")
    public void createDubbingAdditionalServices(String orderType, String clockNumber, ExamplesTable fieldsTable) {
        clockNumber = wrapVariableWithTestSession(clockNumber);
        Order order = getOrderByItemClockNumber(clockNumber);
        OrderItem orderItem = getOrderItemByClockNumber(order.getId(), clockNumber);
        List<NonBroadcastDestinationItem> nonBDItems = prepareNonBDItems(fieldsTable);
        orderItem.setNonBroadcastDestinationItems(nonBDItems.toArray(new NonBroadcastDestinationItem[nonBDItems.size()]));
        getCoreApi().updateOrderItem(order.getId(), orderItem.getId(), getItemTypeByOrderType(orderType), orderItem);
    }

    // | Type | Notes |
    @Given("{I |}create for '$orderType' order with item clock number '$clockNumber' production additional services with following fields: $fieldsTable")
    @When("{I |}create for '$orderType' order with item clock number '$clockNumber' production additional services with following fields: $fieldsTable")
    public void createProductionAdditionalServices(String orderType, String clockNumber, ExamplesTable fieldsTable) {
        clockNumber = wrapVariableWithTestSession(clockNumber);
        Order order = getOrderByItemClockNumber(clockNumber);
        OrderItem orderItem = getOrderItemByClockNumber(order.getId(), clockNumber);
        List<ProductionServiceItem> productionServiceItems = prepareProductionServiceItems(fieldsTable);
        orderItem.setProductionServiceItems(productionServiceItems.toArray(new ProductionServiceItem[productionServiceItems.size()]));
        getCoreApi().updateOrderItem(order.getId(), orderItem.getId(), getItemTypeByOrderType(orderType), orderItem);
    }

    // | Destination Name | Contact Name | Contact Details | Street Address | City | Post Code | Country |
    // action: Add, Edit
    @When("{I |}fill following fields for '$action' Physical Delivery Destination form of Additional Services section on order item page: $fieldsTable")
    public void fillPhysicalDeliveryDestinationForm(String action, ExamplesTable fieldsTable) {
        Map<String, String> row = preparePhysicalDeliveryDestinationFields(fieldsTable);
        getAdditionalServiceForm().getAddPhysicalDeliveryDestinationForm(AdditionalServiceForm.AdditionalDestinationAction.findByAction(action)).fill(row);
    }

    @When("{I |}click Cancel this service button from Additional Services section on order item page")
    public void clickCancelServiceButton(){
        getAdditionalServiceForm().clickCancelAdditionalServiceButton();
        getAdditionalServiceForm().clickOkButtonAfterCancelationAdditiobalService();
    }

    // | FTP Destination Name | Contact Details | FTP Host Name | FTP User Name | FTP Password | FTP Path |
    // action: Add, Edit
    @When("{I |}fill following fields for '$action' FTP Delivery Destination form of Additional Services section on order item page: $fieldsTable")
    public void fillFTPDeliveryDestinationForm(String action, ExamplesTable fieldsTable) {
        Map<String, String> row = parametrizeTabularRow(fieldsTable);
        if (row.containsKey("FTP Destination Name")) row.put("FTP Destination Name", wrapVariableWithTestSession(row.get("FTP Destination Name")));
        if (row.containsKey("Contact Details")) row.put("Contact Details", wrapVariableWithTestSession(row.get("Contact Details")));
        if (row.containsKey("FTP Host Name")) row.put("FTP Host Name", wrapVariableWithTestSession(row.get("FTP Host Name")));
        if (row.containsKey("FTP User Name")) row.put("FTP User Name", wrapVariableWithTestSession(row.get("FTP User Name")));
        if (row.containsKey("FTP Password")) row.put("FTP Password", wrapVariableWithTestSession(row.get("FTP Password")));
        if (row.containsKey("FTP Path")) row.put("FTP Path", wrapVariableWithTestSession(row.get("FTP Path")));
        getAdditionalServiceForm().getAddFTPDeliveryDestinationForm(AdditionalServiceForm.AdditionalDestinationAction.findByAction(action)).fill(row);
    }

    // | Email |
    @When("{I |}fill following fields for '$action' nVerge Delivery Destination form of Additional Services section on order item page: $fieldsTable")
    public void fillNVergeDeliveryDestinationForm(String action, ExamplesTable fieldsTable) {
        Map<String, String> row = parametrizeTabularRow(fieldsTable);
        if (row.containsKey("Email")) row.put("Email", wrapUserEmailWithTestSession(row.get("Email")));
        getAdditionalServiceForm().getAddNVergeDeliveryDestinationForm(AdditionalServiceForm.AdditionalDestinationAction.findByAction(action)).fill(row);
    }

    // | Type | Destination | Format | Specification | Media Compile | No copies | Delivery Details | Notes & Labels | Standard | Express |
    @When("{I |}fill following fields for Additional Services section on order item page: $fieldsTable")
    public void fillNonBroadcastDestinationForm(ExamplesTable fieldsTable) {
        AdditionalServiceForm form = getAdditionalServiceForm();
        for (int i = 0; i < fieldsTable.getRowCount() - 1; i++)
            form.addBDGroup();
        Map<Integer, AdditionalServiceForm.NonBroadcastDestinationGroupForm> nonBDGroups = form.getNonBroadcastDestinationGroups();
        for (int i = 0; i < fieldsTable.getRowCount(); i++) {
            Map<String, String> row = prepareAdditionalServicesSectionFields(fieldsTable, i);
            nonBDGroups.get(i).fill(row);
        }
    }

    // | Type | Destination | Format | Specification | Media Compile | No copies | Delivery Details | Notes & Labels | Standard | Express |
    @When("{I |}fill following fields for Additional Services section on order item page with delay: $fieldsTable")
    public void fillNonBroadcastDestinationFormwithDelay(ExamplesTable fieldsTable) {
        AdditionalServiceForm form = getAdditionalServiceForm();
        for (int i = 0; i < fieldsTable.getRowCount() - 1; i++)
            form.addBDGroup();
        Map<Integer, AdditionalServiceForm.NonBroadcastDestinationGroupForm> nonBDGroups = form.getNonBroadcastDestinationGroups();
        for (int i = 0; i < fieldsTable.getRowCount(); i++) {
            Map<String, String> row = prepareAdditionalServicesSectionFields(fieldsTable, i);
            nonBDGroups.get(i).fill(row);
            Common.sleep(2000);
        }
    }

    // | Type | Notes |
    @When("{I |}fill following fields for Production Services of Additional Services section on order item page: $fieldsTable")
    public void fillProductionServicesForm(ExamplesTable fieldsTable) {
        AdditionalServiceForm form = getProductionAdditionalServiceForm();
        for (int i = 0; i < fieldsTable.getRowCount() - 1; i++)
            form.addProductionServiceGroup();
        Map<Integer, AdditionalServiceForm.ProductionServiceGroupForm> productionServiceGroups = form.getProductionServiceGroups();
        for (int i = 0; i < fieldsTable.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(fieldsTable, i);
            productionServiceGroups.get(i).fill(row);
        }
    }

    // action: Add, Edit
    @When("{I |}go to '$action' Destinations form of Additional Services section on order item page")
    public void goToEditDestinationsForm(String action) {
        getAdditionalServiceForm().getDestinationForm(AdditionalServiceForm.AdditionalDestinationAction.findByAction(action));
    }

    @When("{I |}delete destination on Edit Destinations form of Additional Services section on order item page")
    public void deleteNonBDDestination() {
        getAdditionalServiceForm().getDestinationForm(AdditionalServiceForm.AdditionalDestinationAction.EDIT).getDeleteDestinationPopUp().clickOkBtn();
    }

    // action: cancel, close
    @When("{I |}'$action' Edit Destination form of Additional Services section on order item page")
    public void actionWithEditDestinationForm(String action) {
        DestinationForm form = getAdditionalServiceForm().getDestinationForm(AdditionalServiceForm.AdditionalDestinationAction.EDIT);
        switch (action) {
            case "cancel": form.cancel(); break;
            case "close": form.close(); break;
            default: throw new IllegalArgumentException("Unknown action: " + action);
        }
    }

    @When("{I |}click add destination link for Non Broadcast Destination group of Additional Services section on order item page")
    public void clickAddDestinationLink() {
        getAdditionalServiceForm().getDestinationForm(AdditionalServiceForm.AdditionalDestinationAction.ADD);
    }

    @When("{I |}add delivery destination for Additional Services section on order item page during '$action' destination")
    public void addAdditionalDeliveryDestination(String action) {
        getAdditionalServiceForm().getDestinationForm(AdditionalServiceForm.AdditionalDestinationAction.findByAction(action)).add();
    }

    // count: starts from 1
    @When("{I |}add '$count' new Non Broadcast Destination group{s|} for Additional Services section on order item page")
    public void addNonBDGroups(int count) {
        for (int i = 0; i < count; i++)
            getAdditionalServiceForm().addBDGroup();
    }

    @When("{I |}add new Non Broadcast Destination group for Additional Services section on order item page")
    public void addNonBDGroup() {
        getAdditionalServiceForm().clickAddServiceGroupButton();
    }

    // count: starts from 1
    @When("{I |}add '$count' new Production Services group{s|} for Additional Services section on order item page")
    public void addProductionServiceGroups(int count) {
        for (int i = 0; i < count; i++)
            getProductionAdditionalServiceForm().addProductionServiceGroup();
    }

    // nonBDGroupKey : starts from 1
    @When("{I |}delete '$nonBDGroupKey' Non Broadcast Destination group of Additional Services section on order item page")
    public void deleteNonBDGroup(int nonBDGroupKey) {
        Map<Integer, AdditionalServiceForm.NonBroadcastDestinationGroupForm> nonBDGroups = getAdditionalServiceForm().getNonBroadcastDestinationGroups();
        nonBDGroups.get(nonBDGroupKey - 1).getDeleteDestinationPopUp().clickOkBtn();
    }

    // productionServiceGroupKey : starts from 1
    @When("{I |}delete '$productionServiceGroupKey' Production Service group of Additional Services section on order item page")
    public void deleteProductionServiceGroup(int productionServiceGroupKey) {
        Map<Integer, AdditionalServiceForm.ProductionServiceGroupForm> productionServiceGroups = getProductionAdditionalServiceForm().getProductionServiceGroups();
        productionServiceGroups.get(productionServiceGroupKey - 1).getDeleteServicePopUp().clickOkBtn();
    }

    // serviceType: Dubbing, Production
    @Then("{I |}'$shouldState' see '$serviceType' services switcher for order item on Additional Services section")
    public void checkServiceSwitcherButtonVisibility(String shouldState, String serviceType) {
        assertThat("Check visibility of switcher button for service: " + serviceType, getAdditionalServiceForm().isServiceSwitcherButtonVisible(serviceType),
                is(shouldState.equals("should")));
    }

    // serviceType: Dubbing, Production
    @Then("{I |}'$shouldState' see that '$serviceType' services switcher is selected for order item on Additional Services section")
    public void checkServiceSwitcherButtonState(String shouldState, String serviceType) {
        assertThat("Check state of switcher button for service: " + serviceType, getAdditionalServiceForm().isServiceSwitcherButtonSelected(serviceType),
                is(shouldState.equals("should")));
    }

    // | Destination Name | Contact Name | Contact Details | Street Address | City | Post Code | Country |
    @Then("{I |}should see following data for Add Physical Delivery Destination form of Additional Services section on order item page: $fieldsTable")
    public void checkPhysicalDeliveryDestinationData(ExamplesTable fieldsTable) {
        Map<String, String> row = preparePhysicalDeliveryDestinationFields(fieldsTable);
        AddPhysicalDeliveryDestinationForm form = getAdditionalServiceForm().getAddPhysicalDeliveryDestinationForm(AdditionalServiceForm.AdditionalDestinationAction.ADD);
        for (Map.Entry<String, String> entry : row.entrySet())
            assertThat("Check field: " + entry.getKey(), form.getFieldValue(entry.getKey()), equalTo(entry.getValue()));
    }

    // state: inactive, active
    @Then("{I |}should see '$state' Add button for Add delivery destination form of Additional Services section on order item page")
    public void checkAddDeliveryDestinationBtnState(String state) {
        assertThat("Check Add button state: ", getAdditionalServiceForm().getDestinationForm(AdditionalServiceForm.AdditionalDestinationAction.ADD).isAddButtonActive(),
                                               is(state.equals("active")));
    }

    // formTitle: Add Physical delivery destination, Add FTP delivery destination, Add nVerge delivery destination, Add Generics delivery destination
    @Then("{I |}should see '$title' form on Additional Services section of order item page")
    public void checkVisibilityDestinationsForm(String title) {
        assertThat("Check visibility form: " ,getAdditionalServiceForm().getDestinationForm(AdditionalServiceForm.AdditionalDestinationAction.ADD).getFormTitle(), equalTo(title));
    }

    // | Type | Destination | Format | Specification | Media Compile | No copies | Delivery Details | Notes & Labels | Standard | Express |
    @Then("{I |}should see following data for order item on Additional Services section: $fieldsTable")
    public void checkDubbingServicesOrderItemData(ExamplesTable fieldsTable) {
        Map<Integer, AdditionalServiceForm.NonBroadcastDestinationGroupForm> nonBDGroups = getAdditionalServiceForm().getNonBroadcastDestinationGroups();
        for (int i = 0; i < fieldsTable.getRowCount(); i++) {
            Map<String, String> row = prepareAdditionalServicesSectionFields(fieldsTable, i);
            AdditionalServiceForm.NonBroadcastDestinationGroupForm form = nonBDGroups.get(i);
            if (row.containsKey("Delivery Details") && !row.get("Delivery Details").isEmpty()) row.put("Delivery Details", prepareDeliveryDetailsOfAdditionalServices(row.get("Delivery Details")));
            for (Map.Entry<String, String> entry : row.entrySet())
                assertThat("Check field: " + entry.getKey(), form.getFieldValue(entry.getKey()), equalTo(entry.getValue()));
        }
    }

    // | Type | Notes |
    @Then("{I |}should see following data for Production Services of Additional Services section on order item page: $fieldsTable")
    public void checkProductionServicesOrderItemData(ExamplesTable fieldsTable) {
        Map<Integer, AdditionalServiceForm.ProductionServiceGroupForm> productionServiceGroups = getProductionAdditionalServiceForm().getProductionServiceGroups();
        for (int i = 0; i < fieldsTable.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(fieldsTable, i);
            AdditionalServiceForm.ProductionServiceGroupForm form = productionServiceGroups.get(i);
            for (Map.Entry<String, String> entry : row.entrySet())
                assertThat("Check field: " + entry.getKey(), form.getFieldValue(entry.getKey()), equalTo(entry.getValue()));
        }
    }

    @Then("{I |}should see '$count' Non Broadcast Destination groups for Additional Services section on order item page")
    public void checkNonBDGroupCount(int count) {
        assertThat("Check Non Broadcast Destination group count: ", getAdditionalServiceForm().getCountNonBDGroups(), equalTo(count));
    }

    @Then("{I |}should see '$count' Production Services groups for Additional Services section on order item page")
    public void checkProductionServicesGroupsCount(int count) {
        assertThat("Check Production Services group count: ", getProductionAdditionalServiceForm().getCountProductionServiceGroups(), equalTo(count));
    }

    @Then("{I |}'$shouldState' see validation error for following fields '$fieldNamesList' of Additional Services section on order item page")
    public void checkAdditionalServicesSectionFieldsValidation(String shouldState, String fieldNameList) {
        Map<Integer, AdditionalServiceForm.NonBroadcastDestinationGroupForm> nonBDGroups = getAdditionalServiceForm().getNonBroadcastDestinationGroups();
        for (Map.Entry<Integer, AdditionalServiceForm.NonBroadcastDestinationGroupForm> entry : nonBDGroups.entrySet())
            for (String fieldName : fieldNameList.split(","))
                assertThat("Check visibility validation error for field: " + fieldName, entry.getValue().isValidationFieldErrorVisible(fieldName),
                                                                                        is(shouldState.equals("should")));
    }

    @Then("{I |}'$shouldState' see available following destinations '$destinationsList' in Destination field of Additional Services section on order item page")
    public void checkAvailabilityDestinations(String shouldState, String destinationsList) {
        Map<Integer, AdditionalServiceForm.NonBroadcastDestinationGroupForm> nonBDGroups = getAdditionalServiceForm().getNonBroadcastDestinationGroups();
        for (Map.Entry<Integer, AdditionalServiceForm.NonBroadcastDestinationGroupForm> entry : nonBDGroups.entrySet()) {
            List<String> availableDestinations = entry.getValue().getAvailableDestinations();
            for (String destination: destinationsList.split(","))
                assertThat("Check availability destination: " + destination, availableDestinations, shouldState.equals("should")
                                                                             ? hasItem(wrapVariableWithTestSession(destination))
                                                                             : not(hasItem(wrapVariableWithTestSession(destination))));
        }
    }

    @Then("{I |}should see following destinations '$destinationsList' in Destination field of Additional Services section on order item page")
    public void checkExistenceDestinations(String destinationsList) {
        Map<Integer, AdditionalServiceForm.NonBroadcastDestinationGroupForm> nonBDGroups = getAdditionalServiceForm().getNonBroadcastDestinationGroups();
        List<String> destinations = new ArrayList<>();
        for (String destination: destinationsList.split(","))
            destinations.add(wrapVariableWithTestSession(destination));
        for (Map.Entry<Integer, AdditionalServiceForm.NonBroadcastDestinationGroupForm> entry : nonBDGroups.entrySet())
            assertThat("Check existence destinations: ", entry.getValue().getAvailableDestinations(), equalTo(destinations));
    }

    @Then("{I |}should see available following formats '$formatsList' in Format field of Additional Services section on order item page")
    public void checkAvailabilityFormats(String formatsList) {
        Map<Integer, AdditionalServiceForm.NonBroadcastDestinationGroupForm> nonBDGroups = getAdditionalServiceForm().getNonBroadcastDestinationGroups();
        for (Map.Entry<Integer, AdditionalServiceForm.NonBroadcastDestinationGroupForm> entry : nonBDGroups.entrySet()) {
            List<String> availableFormats = entry.getValue().getAvailableFormats();
            for (String format: formatsList.split(","))
                assertThat("Check availability format: " + format, availableFormats, hasItem(format));
        }
    }

    @Then("{I |}should see available following types '$typeList' in Type field of Additional Services section on order item page")
    public void checkAvailabilityAdditionalServicesType(String typeList) {
        Map<Integer, AdditionalServiceForm.NonBroadcastDestinationGroupForm> nonBDGroups = getAdditionalServiceForm().getNonBroadcastDestinationGroups();
        for (Map.Entry<Integer, AdditionalServiceForm.NonBroadcastDestinationGroupForm> entry : nonBDGroups.entrySet()) {
            List<String> availableTypes = entry.getValue().getAvailableTypes();
            for (String type: typeList.split(","))
                assertThat("Check availability type: " + type, availableTypes, hasItem(type));
        }
    }

    @Then("{I |}should see available following types '$typeList' in Type field of Production Services section on order item page")
    public void checkAvailabilityProductionServicesType(String typeList) {
        Map<Integer, AdditionalServiceForm.ProductionServiceGroupForm> productionServiceGroups = getProductionAdditionalServiceForm().getProductionServiceGroups();
        for (Map.Entry<Integer, AdditionalServiceForm.ProductionServiceGroupForm> entry : productionServiceGroups.entrySet()) {
            List<String> availableTypes = entry.getValue().getAvailableTypes();
            for (String type: typeList.split(","))
                assertThat("Check availability type: " + type, availableTypes, hasItem(type));
        }
    }


    // state: enabled, disabled
    // fields: Type,Destination,Format,Specification,Media Compile,No copies,Delivery Details,Notes & Labels,Standard,Express
    @Then("{I |}should see '$state' following fields '$fields' for order item on Additional Services section")
    public void checkAdditionalServicesSectionFieldsState(String state, String fields) {
        Map<Integer, AdditionalServiceForm.NonBroadcastDestinationGroupForm> nonBDGroups = getAdditionalServiceForm().getNonBroadcastDestinationGroups();
        for (Map.Entry<Integer, AdditionalServiceForm.NonBroadcastDestinationGroupForm> entry : nonBDGroups.entrySet())
            for (String fieldName : fields.split(","))
                assertThat("Check Additional Services section field: " + fieldName, entry.getValue().isFieldEnabled(fieldName), is(state.equals("enabled")));
    }

    @Then("{I |}should see available following types '$typeList' in Type field of Additional Services section on order item page for AU market")
    public void checkAvailabilityAdditionalServicesTypeForAU(String typeList) {
        Map<Integer, AdditionalServiceForm.NonBroadcastDestinationGroupForm> nonBDGroups = getAdditionalServiceForm().getNonBroadcastDestinationGroups();
        for (Map.Entry<Integer, AdditionalServiceForm.NonBroadcastDestinationGroupForm> entry : nonBDGroups.entrySet()) {
            List<String> availableTypes = entry.getValue().getAvailableTypesForAU();
            for (String type: typeList.split(","))
                assertThat("Check availability type: " + type, availableTypes, hasItem(type));
        }
    }

    @Then("{I |}should see available following formats '$formatsList' in Format field of Additional Services section on order item page for AU market")
    public void checkAvailabilityFormatsForAU(String formatsList) {
        Map<Integer, AdditionalServiceForm.NonBroadcastDestinationGroupForm> nonBDGroups = getAdditionalServiceForm().getNonBroadcastDestinationGroups();
        for (Map.Entry<Integer, AdditionalServiceForm.NonBroadcastDestinationGroupForm> entry : nonBDGroups.entrySet()) {
            List<String> availableFormats = entry.getValue().getAvailableFormatsForAU();
            for (String format: formatsList.split(","))
                assertThat("Check availability format: " + format, availableFormats, hasItem(format));
        }
    }

    // | Type | Destination | Format | Specification | Media Compile | No copies | Delivery Details | Notes & Labels |
    @When("{I |}fill following fields for Additional Services section on order item page for AU market: $fieldsTable")
    public void fillNonBroadcastDestinationFormForAU(ExamplesTable fieldsTable) {
        AdditionalServiceForm form = getAdditionalServiceForm();
        for (int i = 0; i < fieldsTable.getRowCount() - 1; i++)
            form.addBDGroup();
        Map<Integer, AdditionalServiceForm.NonBroadcastDestinationGroupForm> nonBDGroups = form.getNonBroadcastDestinationGroups();
        for (int i = 0; i < fieldsTable.getRowCount(); i++) {
            Map<String, String> row = prepareAdditionalServicesSectionFields(fieldsTable, i);
            nonBDGroups.get(i).fillForAU(row);
        }
    }
}