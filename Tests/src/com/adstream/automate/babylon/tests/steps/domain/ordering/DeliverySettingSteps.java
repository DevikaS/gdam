package com.adstream.automate.babylon.tests.steps.domain.ordering;

import com.adstream.automate.babylon.JsonObjects.User;
import com.adstream.automate.babylon.sut.pages.ordering.DeliverySettingPage;
import com.adstream.automate.babylon.sut.pages.ordering.MyDeliverySettingPage;
import com.adstream.automate.babylon.sut.pages.ordering.elements.forms.DeliverySettingForm;
import com.adstream.automate.babylon.tests.steps.core.BaseStep;
import org.jbehave.core.annotations.Given;
import org.jbehave.core.annotations.Then;
import org.jbehave.core.annotations.When;
import org.jbehave.core.model.ExamplesTable;
import java.util.List;
import java.util.Map;
import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.*;

/**
 * Created with IntelliJ IDEA.
 * User: demidovskiy-r
 * Date: 25.11.13
 * Time: 14:19
 */
public class DeliverySettingSteps extends BaseStep {

    private DeliverySettingPage openDeliverySettingPage(String userId){
        return getSut().getPageNavigator().getDeliverySettingPage(userId);
    }

    private DeliverySettingPage getDeliverySettingPage() {
        return getSut().getPageCreator().getDeliverySettingPage();
    }

    private MyDeliverySettingPage openMyDeliverySettingPage() {
        return getSut().getPageNavigator().getMyDeliverySettingPage();
    }

    private MyDeliverySettingPage getMyDeliverySettingPage() {
        return getSut().getPageCreator().getMyDeliverySettingPage();
    }

    private String getUserId(String userEmail) {
        User user = getCoreApi().getUserByEmail(wrapUserEmailWithTestSession(userEmail));
        if (user == null)
            throw new NullPointerException("There are no any users with email: " + wrapUserEmailWithTestSession(userEmail));
        return user.getId();
    }

    private Map<String, String> prepareDeliverySettingFormData(ExamplesTable fieldsTable) {
        Map<String, String> row = parametrizeTabularRow(fieldsTable);
        if (row.containsKey("Always Notify When Passed QC")) row.put("Always Notify When Passed QC", String.valueOf(row.get("Always Notify When Passed QC").equals("should")));
        if (row.containsKey("Always Notify When Delivered")) row.put("Always Notify When Delivered", String.valueOf(row.get("Always Notify When Delivered").equals("should")));
        if (row.containsKey("Always Hold For Approval")) row.put("Always Hold For Approval", String.valueOf(row.get("Always Hold For Approval").equals("should")));
        if (row.containsKey("Except QCed Masters")) row.put("Except QCed Masters", String.valueOf(row.get("Except QCed Masters").equals("should")));
        if (row.containsKey("Always Adbank")) row.put("Always Adbank", String.valueOf(row.get("Always Adbank").equals("should")));
        if (row.containsKey("Default Transfer User")) row.put("Default Transfer User", wrapUserEmailWithTestSession(row.get("Default Transfer User")));
        if (row.containsKey("Default Email Notifications")) {
            String[] users = row.get("Default Email Notifications").split(",");
            StringBuilder sb = new StringBuilder();
            for (int i = 0; i < users.length; i++) {
                sb.append(wrapUserEmailWithTestSession(users[i]));
                if (i != users.length - 1) sb.append(",");
            }
            row.put("Default Email Notifications", sb.toString());
        }
        return row;
    }

    @Given("I am on Delivery Setting page of user '$userEmail'")
    @When("{I |}go to Delivery Setting page of user '$userEmail'")
    public DeliverySettingPage openDeliverySettingPageOfUser(String userEmail) {
        return openDeliverySettingPage(getUserId(userEmail));
    }

    @Given("I am on own Delivery Setting page")
    public MyDeliverySettingPage openOwnDeliverySettingPage() {
        return openMyDeliverySettingPage();
    }

    // | Default Market | Expanded Multiple Markets | Default Transfer User | Default Email Notifications | Closed Captions Required | Always Notify When Passed QC | Always Notify When Delivered | Always Hold For Approval | Except QCed Masters | Always Adbank | Add Media Deadline Default |
    @Given("{I |}filled following fields for Delivery Setting form on user delivery setting page: $fieldsTable")
    @When("{I |}fill following fields for Delivery Setting form on user delivery setting page: $fieldsTable")
    public void fillDeliverySettingForm(ExamplesTable fieldsTable) {
        Map<String, String> row = prepareDeliverySettingFormData(fieldsTable);
        getMyDeliverySettingPage().getDeliverySettingForm().fill(row);
    }

    @Given("{I |}saved own Delivery Setting")
    @When("{I |}save own Delivery Setting")
    public void saveOwnDeliverySetting() {
        getMyDeliverySettingPage().save();
    }

    // | Default Market | Expanded Multiple Markets | Default Transfer User | Default Email Notifications | Closed Captions Required | Always Notify When Passed QC | Always Notify When Delivered | Always Hold For Approval | Except QCed Masters | Always Adbank | Add Media Deadline Default |
    @Then("{I |}should see following data for Delivery Setting form on user delivery setting page: $fieldsTable")
    public void checkDeliverySettingForm(ExamplesTable fieldsTable) {
        Map<String, String> row = prepareDeliverySettingFormData(fieldsTable);
        DeliverySettingForm form = getMyDeliverySettingPage().getDeliverySettingForm();
        for (Map.Entry<String, String> entry : row.entrySet())
            assertThat("Check field: " + entry.getKey(), form.getFieldValue(entry.getKey()), equalTo(entry.getValue()));
    }

    @Then("{I |}'$shouldState' see available following closed captions '$closedCaptionsList' in Closed Captions Required field on user delivery setting page")
    public void checkAvailabilityClosedCaptions(String shouldState, String closedCaptionsList) {
        List<String> closedCaptions = getMyDeliverySettingPage().getDeliverySettingForm().getAvailableClosedCaptions();
        for (String closedCaption: closedCaptionsList.split(","))
            assertThat("Check availability closed caption: " + closedCaption, closedCaptions, shouldState.equals("should")
                                                                                              ? hasItem(closedCaption)
                                                                                              : not(hasItem(closedCaption)));
    }

    // | Default Email Notifications |
    @Then("{I |}'$shouldState' see validation error for following fields '$fieldNamesList' for Delivery Setting form on user delivery setting page")
    public void checkDeliverySettingFormValidation(String shouldState, String fieldNamesList) {
        DeliverySettingForm form = getMyDeliverySettingPage().getDeliverySettingForm();
        for (String fieldName: fieldNamesList.split(","))
            assertThat("Check visibility validation for field: " + fieldName, form.isValidationFieldErrorVisible(fieldName), is(shouldState.equals("should")));
    }

    // state: enabled, disabled
    // Except QCed Masters
    @Then("{I |}should see '$state' following fields '$fields' for Delivery Setting form on user delivery setting page")
    public void deliverySettingsFormFieldsState(String state, String fields) {
        DeliverySettingForm form = getMyDeliverySettingPage().getDeliverySettingForm();
        for (String fieldName: fields.split(","))
            assertThat("Check Delivery Setting form field: " + fieldName, form.isFieldEnabled(fieldName), is(state.equals("enabled")));
    }

    @Then("{I |}should see auto complete default email notifications count '$emailsCount' for Delivery Setting form on user delivery setting page")
    public void checkAutoCompleteDefaultEmailNotificationsCount(int emailsCount) {
        assertThat("Check auto complete default email notifications count: ", getMyDeliverySettingPage().getDeliverySettingForm().getCountAutoCompleteDefaultEmailNotifications(), equalTo(emailsCount));
    }
}