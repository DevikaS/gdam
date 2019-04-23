package com.adstream.automate.babylon.tests.steps.domain.ordering.section;

import com.adstream.automate.babylon.JsonObjects.Content;
import com.adstream.automate.babylon.JsonObjects.Project;
import com.adstream.automate.babylon.JsonObjects.ordering.Order;
import com.adstream.automate.babylon.JsonObjects.ordering.OrderItem;
import com.adstream.automate.babylon.JsonObjects.ordering.enums.UploadRequestType;
import com.adstream.automate.babylon.sut.pages.ordering.ViewMediaContentDetailsPage;
import com.adstream.automate.babylon.sut.pages.ordering.elements.Data;
import com.adstream.automate.babylon.sut.pages.ordering.elements.StepsOrderType;
import com.adstream.automate.babylon.sut.pages.ordering.elements.forms.SchemaField;
import com.adstream.automate.babylon.sut.pages.ordering.elements.forms.AddMediaToOrderForm;
import com.adstream.automate.babylon.sut.pages.ordering.elements.forms.subForms.AssetContainer;
import com.adstream.automate.babylon.sut.pages.ordering.elements.forms.subForms.SupplyMediaForm;
import com.adstream.automate.babylon.tests.steps.domain.ordering.DraftOrderSteps;
import com.adstream.automate.utils.Common;
import org.jbehave.core.annotations.Given;
import org.jbehave.core.annotations.Then;
import org.jbehave.core.annotations.When;
import org.jbehave.core.model.ExamplesTable;
import java.io.File;
import java.util.Map;
import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.equalTo;
import static org.hamcrest.Matchers.equalToIgnoringWhiteSpace;
import static org.hamcrest.Matchers.is;

/*
 * Created by demidovskiy-r on 30.05.2014.
 */
public class AddMediaSteps extends DraftOrderSteps {
    
    private AddMediaToOrderForm getAddMediaToOrderForm() {
        return getOrderItemPage().getAddMediaToOrderForm();
    }

    private SupplyMediaForm getSupplyMediaForm() {
        return getAddMediaToOrderForm().newMaster();
    }

    private ViewMediaContentDetailsPage openViewMediaContentDetailsPage(String contentId, String orderId, String orderItemId) {
        return getSut().getPageNavigator().getViewMediaContentDetailsPage(contentId, orderId, orderItemId);
    }

    private ViewMediaContentDetailsPage getViewMediaContentDetailsPage() {
        return getSut().getPageCreator().getViewMediaContentDetailsPage();
    }

    private String prepareMediaContent(String contents) {
        StringBuilder wrappedContents = new StringBuilder();
        String[] assetsArray = contents.split(",");
        for (int i = 0; i < assetsArray.length; i++) {
            wrappedContents.append(wrapVariableByCriteria(assetsArray[i]));
            if (i != assetsArray.length - 1) wrappedContents.append(",");
        }
        return wrappedContents.toString();
    }

    private Map<String, String> prepareNewMasterData(ExamplesTable fieldsTable) {
        Map<String, String> row = parametrizeTabularRow(fieldsTable);
        if (row.containsKey("Assignee")) row.put("Assignee", prepareAssignees(row.get("Assignee")));
        if (row.containsKey("Post House")) row.put("Post House", wrapUserEmailWithTestSession(row.get("Post House")));
        if (row.containsKey("Already Supplied")) row.put("Already Supplied", String.valueOf(row.get("Already Supplied").equals("should")));
        if (row.containsKey("Deadline Date")) row.put("Deadline Date", !row.get("Deadline Date").isEmpty() ? formatDateToDefaultStoriesFormat(row.get("Deadline Date")) : "");
        return row;
    }

    private OrderItem buildNewMasterOfAddMediaSection(OrderItem orderItem, Map<String, String> row) {
        orderItem.setUploadRequestAssignees(convertAssigneesToArray(row.get("Assignee")));
        orderItem.setUploadRequestAlreadySupplied(row.containsKey("Already Supplied") && row.get("Already Supplied").equals("should"));
        if (row.containsKey("Post House")) orderItem.setUploadRequestPostHouse(wrapUserEmailWithTestSession(row.get("Post House")));
        if (row.containsKey("Supply Via")) orderItem.setUploadRequestUploadType(new String[]{UploadRequestType.findByName(row.get("Supply Via")).toString()});
        if (row.containsKey("Message")) orderItem.setUploadRequestMessage(row.get("Message"));
        if (row.containsKey("Deadline Date")) {
            String deadlineDate = row.get("Deadline Date").contains("/") ? row.get("Deadline Date") : prepareDateToStoriesFormat(row.get("Deadline Date"));
            orderItem.setUploadRequestDeadlineDate(parseDateWithUTCZone(deadlineDate));
        }
        if (row.containsKey("Days Before First Air Date")) orderItem.setUploadRequestDaysBeforeFirstAirDate(Integer.valueOf(row.get("Days Before First Air Date")));
        if (row.containsKey("Arrival Time")) orderItem.setUploadRequestArrivalTime(row.get("Arrival Time"));
        return orderItem;
    }

    // the same may be doing by opening asset in Retrieve from Library or Projects in UI
    @Given("I am on View Media Details page of {asset|qc asset} '$assetName' of collection '$collectionName' from order contains item with following clock number '$clockNumber'")
    @When("{I |}go to View Media Details page of {asset|qc asset} '$assetName' of collection '$collectionName' from order contains item with following clock number '$clockNumber'")
    public ViewMediaContentDetailsPage toViewMediaAssetsDetailsPage(String assetName, String collectionName, String clockNumber) {
        clockNumber = wrapVariableWithTestSession(clockNumber);
        Order order = getOrderByItemClockNumber(clockNumber);
        OrderItem orderItem = getOrderItemByClockNumber(order.getId(), clockNumber);
        Content asset = getAsset(getCategoryId(wrapCollectionName(collectionName)), wrapVariableByCriteria(assetName));
        return openViewMediaContentDetailsPage(asset.getId(), order.getId(), orderItem.getId());
    }

    @Given("{I |}add to '$orderType' order item with {clock number|isrc code} '$clockNumber' following {asset|qc asset} '$assetName' of collection '$collectionName'")
    @When("{I |}added to '$orderType' order item with {clock number|isrc code} '$clockNumber' following {asset|qc asset} '$assetName' of collection '$collectionName'")
    public void addAssetToOrderItem(String orderType, String clockNumber, String assetName, String collectionName) {
        Order order = getOrderByItemClockNumber(wrapVariableWithTestSession(clockNumber));
        OrderItem orderItem = getOrderItemByClockNumber(order.getId(), wrapVariableWithTestSession(clockNumber));
        Content asset = getAsset(getCategoryId(wrapCollectionName(collectionName)), wrapVariableByCriteria(assetName));
        getCoreApi().addMediaToOrderItem(order.getId(), orderItem.getId(), asset.getId(), getItemTypeByOrderType(orderType));
        Common.sleep(1000);
    }

    @Given("{I |}add to '$orderType' order item with title '$title' following {asset|qc asset} '$assetName' of collection '$collectionName'")
    @When("{I |}add to '$orderType' order item with title '$title' following {asset|qc asset} '$assetName' of collection '$collectionName'")
    public void addAssetToItem(String orderType, String title, String assetName, String collectionName) {
        Order order = getOrderByItemTitle(wrapVariableByCriteria(title));
        OrderItem orderItem = getOrderItemByTitle(order.getId(), wrapVariableByCriteria(title));
        Content asset = getAsset(getCategoryId(wrapCollectionName(collectionName)), wrapVariableByCriteria(assetName));
        getCoreApi().addMediaToOrderItem(order.getId(), orderItem.getId(), asset.getId(), getItemTypeByOrderType(orderType));
        Common.sleep(1000);
    }

    @Given("{I |}add to '$orderType' order item with {isrc code|clock number} '$clockNumber' following file '$fileName' from folder '$path' of project '$projectName'")
    @When("{I |}added to '$orderType' order item with {isrc code|clock number} '$clockNumber' following file '$fileName' from folder '$path' of project '$projectName'")
    public void addFileToOrderItem(String orderType, String clockNumber, String fileName, String path, String projectName) {
        Order order = getOrderByItemClockNumber(wrapVariableWithTestSession(clockNumber));
        OrderItem orderItem = getOrderItemByClockNumber(order.getId(), wrapVariableWithTestSession(clockNumber));
        Project project = getCoreApi().getProjectByName(wrapVariableWithTestSession(projectName));
        Content folder = getCoreApi().createFolderRecursive(wrapPathWithTestSession(normalizePath(path)), project.getId(), project.getId());
        Content file = getCoreApi().getFileByName(folder.getId(), new File(getFilePath(fileName)).getName());
        getCoreApi().addMediaToOrderItem(order.getId(), orderItem.getId(), file.getId(), getItemTypeByOrderType(orderType));
    }

    @When("{I |}open New Master for order item on Add media form")
    public void openNewMaster() {
        getSupplyMediaForm();
    }

    @When("{I |}supply via '$uploadRequestType' for New Master of order item on Add media form")
    public void supplyVia(String uploadRequestType) {
        getSupplyMediaForm().supplyVia(UploadRequestType.findByName(uploadRequestType));
    }

    // | Assignee | Post House | Already Supplied | Message | Deadline Date | Days Before First Air Date | Arrival Time |
    @When("{I |}fill following fields for New Master of order item that supply via '$uploadRequestType' on Add media form: $fieldsTable")
    public void fillSupplyMediaForm(String uploadRequestType, ExamplesTable fieldsTable) {
        Map<String, String> row = prepareNewMasterData(fieldsTable);
        SupplyMediaForm form = getSupplyMediaForm();
        if (!uploadRequestType.isEmpty()) form.supplyVia(UploadRequestType.findByName(uploadRequestType));
        form.fill(row);
    }

    // | Search Groups | Group Name |
    @When("{I |}fill following fields for Select Group popup of New Master on Add media form: $fieldsTable")
    public void fillSelectGroupForm(ExamplesTable fieldsTable) {
        Map<String, String> row = parametrizeTabularRow(fieldsTable);
        if (row.containsKey("Search Groups")) row.put("Search Groups", wrapVariableWithTestSession(row.get("Search Groups")));
        if (row.containsKey("Group Name")) row.put("Group Name", String.valueOf(row.get("Group Name").equals("should")));
        getSupplyMediaForm().getSelectNotificationGroup(row.get("Search Groups")).fill(row);
    }

    @When("{I |}accept selection of specified notification group '$groupName' on Select Group popup of New Master on Add media form")
    public void acceptSelectionOfNotificationGroup(String groupName) {
        getSupplyMediaForm().getSelectNotificationGroup(wrapVariableWithTestSession(groupName)).select();
    }

    // | Supply Via | Assignee | Post House | Already Supplied | Message | Deadline Date | Days Before First Air Date |
    @Given("{I |}add for '$orderType' order to item with {clock number|isrc code} '$clockNumber' a New Master with following fields: $fieldsTable")
    @When("{I |}added for '$orderType' order to item with {clock number|isrc code} '$clockNumber' a New Master with following fields: $fieldsTable")
    public void addNewMasterToOrderItem(String orderType, String clockNumber, ExamplesTable fieldsTable) {
        Map<String, String> row = parametrizeTabularRow(fieldsTable);
        clockNumber = wrapVariableWithTestSession(clockNumber);
        Order order = getOrderByItemClockNumber(clockNumber);
        OrderItem orderItem = buildNewMasterOfAddMediaSection(getOrderItemByClockNumber(order.getId(), clockNumber), row);
        getCoreApi().updateOrderItem(order.getId(), orderItem.getId(), getItemTypeByOrderType(orderType), orderItem);
    }

    @When("{I |}retrieve assets from library for order item at Add media to your order form")
    public void retrieveAssetsFromLibrary() {
        getAddMediaToOrderForm().retrieveFromLibrary();
    }

    @When("{I |}retrieve files from projects for order item at Add media to your order form")
    public void retrieveFilesFromProjects() {
        getAddMediaToOrderForm().retrieveFromProject();
    }

    @When("{I |}open project '$projectName' at Add media to your order form for retrieving folders and files")
    public void openRetrievedProject(String projectName) {
        AssetContainer assetContainer  = getAddMediaToOrderForm().retrieveFromProject();
        assetContainer.openProjectFolder(wrapVariableWithTestSession(projectName), "");
    }

    @When("{I |}open project '$projectName' folder '$path' at Add media to your order form for retrieving files")
    public void openRetrievedProjectsFolder(String projectName, String path) {
        AssetContainer assetContainer  = getAddMediaToOrderForm().retrieveFromProject();
        assetContainer.openProjectFolder(wrapVariableWithTestSession(projectName), normalizePath(wrapPathWithTestSession(path)));
    }

    // mediaContent: Library, Projects
    @When("{I |}scroll to page '$pageNumber' in '$mediaContent' content for Add media to your order form")
    public void scrollToMediaPageContent(int pageNumber, String mediaContent) {
        AddMediaToOrderForm form = getAddMediaToOrderForm();
        switch (AddMediaToOrderForm.MediaContent.findByName(mediaContent)) {
            case LIBRARY: form.retrieveFromLibrary().scrollToPage(pageNumber); break;
            case PROJECTS: form.retrieveFromProject().scrollToPage(pageNumber); break;
            default: throw new IllegalArgumentException("Unknown media content: " + mediaContent);
        }
    }

    @When("{I |}fill Search field by value '$value' for Add media to your order form on order item page")
    public void fillSearchMediaContent(String value) {
        AssetContainer assetContainer = getAddMediaToOrderForm().getAssetContainer();
        assetContainer.search(value);
    }

    @When("{I |}select following {assets|qc assets} '$assets' for order item at Add media to your order form")
    public void selectAssets(String assets) {
        getAddMediaToOrderForm().getAssetContainer().selectContent(prepareMediaContent(assets));
    }

    // assets: asset1,asset2,asset3....assetN
    @When("{I |}add to order for order item at Add media to your order form following {assets|qc assets} '$assets'")
    public void addAssetsToOrder(String assets) {
        AssetContainer assetContainer = getAddMediaToOrderForm().retrieveFromLibrary();
        assetContainer.addMediaContentToOrder(prepareMediaContent(assets));
    }

    // files: file1,file2,file3...fileN
    @When("{I |}add to order for order item at Add media to your order form following files '$files' from folder '$path' of project '$projectName'")
    public void addFilesToOrder(String files, String path, String projectName) {
        AssetContainer assetContainer  = getAddMediaToOrderForm().retrieveFromProject();
        assetContainer.addProjectsContentToOrder(wrapVariableWithTestSession(projectName), normalizePath(wrapPathWithTestSession(path)), prepareMediaContent(files));
    }

    @When("{I |}click Add To Order button at Add media to your order form on order item page")
    public void addToOrderBtnClick() {
        getAddMediaToOrderForm().getAssetContainer().clickAddToOrderButton();
    }

    // fieldNames: Assignee, Message, Deadline Date
    @Then("{I |}'$shouldState' see validation error for following fields '$fieldNamesList' of New Master for order item on Add media form")
    public void checkNewMasterFieldsValidation(String shouldState, String fieldNamesList) {
        SupplyMediaForm form = getSupplyMediaForm();
        for (String fieldName: fieldNamesList.split(","))
            assertThat("Check visibility validation for field: " + fieldName, form.isValidationFieldErrorVisible(fieldName), is(shouldState.equals("should")));
    }

    /**
     * | Assignee | Post House | Comments | Deadline Date | Days Before First Air Date | Arrival Time |
     */
    @Then("{I |}should see following data on New Master form for order item that supply via '$uploadRequestType': $fieldsTable")
    public void checkNewMasterDataBeforeAdded(String uploadRequestType, ExamplesTable fieldsTable) {
        Map<String, String> row = prepareNewMasterData(fieldsTable);

        SupplyMediaForm form = getSupplyMediaForm();
        if (!uploadRequestType.isEmpty()) form.supplyVia(UploadRequestType.findByName(uploadRequestType));
        for (Map.Entry<String, String> entry : row.entrySet())
            assertThat("Check field: " + entry.getKey(), form.getFieldValue(entry.getKey()).replaceAll("\\s+",""), equalTo(entry.getValue().replaceAll("\\s+","")));

    }

    //state: active, inactive or enabled, disabled
    @Then("{I |}should see '$state' New master button for order item on Add media form")
    public void checkNewMasterBtnState(String state) {
        AddMediaToOrderForm form = getAddMediaToOrderForm();
        if (state.equals("active") || state.equals("inactive"))
            assertThat("Check New Master button state: ", form.isNewMasterBtnActive(), is(state.equals("active")));
        else if (state.equals("enabled") || state.equals("disabled"))
            assertThat("Check New Master button state: ", form.isNewMasterBtnEnabled(), is(state.equals("enabled")));
        else
            throw new IllegalArgumentException("Unknown state: " + state);
    }

    @Then("{I |}should see auto complete emails count '$emailsCount' under Assignee for New Master on Add media form")
    public void checkAutoCompleteEmailsCount(int emailsCount) {
        assertThat("Check auto complete emails count: ", getSupplyMediaForm().getCountAutoCompleteEmails(), equalTo(emailsCount));
    }

    //state: enabled, disabled
    @Then("{I |}should see '$state' Retrieve from Library button for order item at Add media to your order form")
    public void checkRetrieveFromLibraryBtnState(String state) {
        assertThat("Check Retrieve from Library button state: ", getAddMediaToOrderForm().isRetrieveFromLibraryBtnEnabled(), is(state.equals("enabled")));
    }

    //state: enabled, disabled
    @Then("{I |}should see '$state' Retrieve from Project button for order item at Add media to your order form")
    public void checkRetrieveFromProjectBtnState(String state) {
        assertThat("Check Retrieve from Project button state: ", getAddMediaToOrderForm().isRetrieveFromProjectBtnEnabled(), is(state.equals("enabled")));
    }

    // buttonName: New Master, Retrieve from Projects, Retrieve from Library
    @Then("{I |}'$shouldState' see '$buttonName' button for order item at Add media to your order form")
    public void checkRetrieveFromProjectButtonVisible(String shouldState, String buttonName) {
        assertThat("Check is " + buttonName + " button visible: ", getAddMediaToOrderForm().isRetrieveMediaFromButtonVisible(buttonName), is(shouldState.equals("should")));
    }

    // | Name |
    @Then("{I |}'$shouldState' see for order item at Add media to your order form following assets over pages: $fieldsTable")
    public void checkVisibilityAssetsRetrievedFromLibraryOverPages(String shouldState, ExamplesTable fieldsTable) {
        AssetContainer assetContainer = getAddMediaToOrderForm().retrieveFromLibrary();
        for (int i = 0; i < fieldsTable.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(fieldsTable, i);
            if (row.get("Name") != null)
                assertThat("Check visibility asset: " + row.get("Name"), assetContainer.isContentVisibleOverPages(row.get("Name")), is(shouldState.equals("should")));
        }
    }

    // | Name |
    @Then("{I |}'$shouldState' see for order item at Add media to your order form following assets: $fieldsTable")
    public void checkVisibilityAssetsRetrievedFromLibrary(String shouldState, ExamplesTable fieldsTable) {
        AssetContainer assetContainer = getAddMediaToOrderForm().retrieveFromLibrary();
        for (int i = 0; i < fieldsTable.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(fieldsTable, i);
            if (row.get("Name") != null)
                assertThat("Check visibility asset: " + row.get("Name"), assetContainer.isContentVisible(row.get("Name")), is(shouldState.equals("should")));
        }
    }

    // mediaContent: Library, Projects
    @Then("{I |}should see following '$mediaContent' content counter notification '$countNotification' for order item at Add media to your order form")
    public void checkMediaCounterNotification(String mediaContent, String countNotification) {
        AddMediaToOrderForm form = getAddMediaToOrderForm();
        switch (AddMediaToOrderForm.MediaContent.findByName(mediaContent)) {
            case LIBRARY: assertThat("Check assets notification counter: ", form.retrieveFromLibrary().getMediaCounters(), equalTo(countNotification)); break;
            case PROJECTS: assertThat("Check folders/files notification counter: ", form.retrieveFromProject().getMediaCounters(), equalTo(countNotification)); break;
            default: throw new IllegalArgumentException("Unknown media content: " + mediaContent);
        }
    }

    @Then("{I |}'$shouldState' see mandatory validation for following fields '$fieldNamesList' of New Master for order item on Add media form")
    public void checkNewMasterFieldsMandatoryValidation(String shouldState, String fieldNamesList) {
        SupplyMediaForm form = getSupplyMediaForm();
        for (String fieldName: fieldNamesList.split(","))
            assertThat("Check mandatory validation for field: " + fieldName, form.isValidationFieldErrorVisible(fieldName), is(shouldState.equals("should")));
    }

    // | Name |
    @Then("{I |}'$shouldState' see for order item at Add media to your order form following files over pages retrieved from project '$projectName' folder '$path': $fieldsTable")
    public void checkVisibilityFilesRetrievedFromProjectOverPages(String shouldState, String projectName, String path, ExamplesTable fieldsTable) {
        AssetContainer assetContainer  = getAddMediaToOrderForm().retrieveFromProject();
        assetContainer.openProjectFolder(wrapVariableWithTestSession(projectName), normalizePath(wrapPathWithTestSession(path)));
        for (int i = 0; i < fieldsTable.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(fieldsTable, i);
            if (row.get("Name") != null)
                assertThat("Check visibility file: " + row.get("Name"), assetContainer.isContentVisibleOverPages(row.get("Name")), is(shouldState.equals("should")));
        }
    }

    // | Name |
    @Then("{I |}'$shouldState' see for order item at Add media to your order form following files retrieved from project '$projectName' folder '$path': $fieldsTable")
    public void checkVisibilityFilesRetrievedFromProject(String shouldState, String projectName, String path, ExamplesTable fieldsTable) {
        AssetContainer assetContainer  = getAddMediaToOrderForm().retrieveFromProject();
        assetContainer.openProjectFolder(wrapVariableWithTestSession(projectName), normalizePath(wrapPathWithTestSession(path)));
        for (int i = 0; i < fieldsTable.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(fieldsTable, i);
            if (row.get("Name") != null)
                assertThat("Check visibility file: " + row.get("Name"), assetContainer.isContentVisible(row.get("Name")), is(shouldState.equals("should")));
        }
    }

    // | Name |
    @Then("{I |}'$shouldState' see for order item at Add media to your order form following files retrieved from project: $fieldsTable")
    public void checkVisibilityFilesRetrievedFromProject(String shouldState, ExamplesTable fieldsTable) {
        AssetContainer assetContainer  = getAddMediaToOrderForm().retrieveFromProject();
        for (int i = 0; i < fieldsTable.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(fieldsTable, i);
            if (row.get("Name") != null)
                assertThat("Check visibility file: " + row.get("Name"), assetContainer.isContentVisible(row.get("Name")), is(shouldState.equals("should")));
        }
    }

    // | Name |
    @Then("{I |}'$shouldState' see for order item at Add media to your order form following {projects|folders}: $fieldsTable")
    public void checkVisibilityProjectsFolders(String shouldState, ExamplesTable fieldsTable) {
        AssetContainer assetContainer  = getAddMediaToOrderForm().retrieveFromProject();
        for (int i = 0; i < fieldsTable.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(fieldsTable, i);
            if (row.get("Name") != null) {
                for (String name: row.get("Name").split(", "))
                    assertThat("Check visibility project(or folder): " + wrapVariableWithTestSession(name), assetContainer.isContentVisible(wrapVariableWithTestSession(name)), is(shouldState.equals("should")));
            }
        }
    }

    @Then("{I |}should see following navigation path '$path' in projects folder at Add media to your order form")
    public void checkProjectsNavigationPath(String path) {
        AssetContainer assetContainer = getAddMediaToOrderForm().getAssetContainer();
        String[] pathParts = path.split(">");
        StringBuilder sb = new StringBuilder();
        sb.append(pathParts[0]).append(" > ");
        for (int  i = 1; i < pathParts.length; i++) {
            sb.append(wrapPathWithTestSession(pathParts[i]));
            if (i != pathParts.length - 1) sb.append(" > ");
        }
        assertThat("Check project navigation path:", assetContainer.getProjectsNavigationPath(), equalTo(sb.toString()));
    }

    // | Title | Advertiser | Product | Clock Number | Format | Aspect Ratio | Clock Number Label |
    @Then("{I |}should see for '$orderType' order item at Add media to your order form following files metadata: $fieldsTable")
    public void checkContentMetadata(String orderType, ExamplesTable fieldsTable) {
        AssetContainer assetContainer = getAddMediaToOrderForm().getAssetContainer();
        for (int i = 0; i < fieldsTable.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(fieldsTable, i);
            String title = wrapVariableByCriteria(row.get("Title"));
            AssetContainer.Metadata metadata = assetContainer.getMetadataByContentName(title, StepsOrderType.findByType(orderType));
            assertThat("Title: ", metadata.getTitle(), equalTo(title));
            if (Data.containsField(SchemaField.ADVERTISER, row, false)) assertThat("Advertiser: ", metadata.getAdvertiser(), equalTo(prepareAdvertiser(Data.getField(SchemaField.ADVERTISER, row))));
            if (Data.containsField(SchemaField.PRODUCT, row, false)) assertThat("Product: ", metadata.getProduct(), equalTo(wrapVariableWithTestSession(Data.getField(SchemaField.PRODUCT, row))));
            if (Data.containsField(SchemaField.CAMPAIGN, row, false)) assertThat("Campaign: ", metadata.getCampaign(), equalTo(wrapVariableWithTestSession(Data.getField(SchemaField.CAMPAIGN, row))));
            if (Data.containsField(SchemaField.CLOCK_NUMBER, row, false)) assertThat("Clock Number: ", metadata.getClockNumber(), equalTo(wrapVariableWithTestSession(Data.getField(SchemaField.CLOCK_NUMBER, row))));
            if (row.containsKey("Format")) assertThat("Format: ", metadata.getFormat(), equalTo(row.get("Format")));
            if (row.containsKey("Aspect Ratio")) assertThat("Aspect Ratio: ", metadata.getAspectRatio(), equalTo(row.get("Aspect Ratio")));
            if (row.containsKey("Clock Number Label")) assertThat("Clock Number Label: ", metadata.getClockNumberLabel(), equalTo(row.get("Clock Number Label")));
        }
    }
}