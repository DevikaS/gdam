package com.adstream.automate.babylon.tests.steps.domain.ordering.section;

import com.adstream.automate.babylon.JsonObjects.ordering.Order;
import com.adstream.automate.babylon.JsonObjects.ordering.OrderItem;
import com.adstream.automate.babylon.JsonObjects.usagerights.Expiration;
import com.adstream.automate.babylon.JsonObjects.usagerights.GeneralUsageRight;
import com.adstream.automate.babylon.JsonObjects.usagerights.UsageRight;
import com.adstream.automate.babylon.sut.data.UsageRule;
import com.adstream.automate.babylon.sut.pages.ordering.elements.forms.UsageRightSelectorForm;
import com.adstream.automate.babylon.tests.steps.domain.ordering.DraftOrderSteps;
import org.jbehave.core.annotations.Given;
import org.jbehave.core.annotations.Then;
import org.jbehave.core.annotations.When;
import org.jbehave.core.model.ExamplesTable;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.concurrent.TimeUnit;
import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.equalTo;
import static org.hamcrest.Matchers.hasItem;
import static org.hamcrest.Matchers.not;

/*
 * Created by demidovskiy-r on 30.05.2014.
 */
public class UsageRightSteps extends DraftOrderSteps {

    private List<UsageRight> prepareUsageRights(String usageRightType, Map<String, String> row){
        List<UsageRight> usageRights = new ArrayList<>();
        if (usageRightType.equals(UsageRule.GENERAL)) {
            GeneralUsageRight generalUsageRight = new GeneralUsageRight();
            Expiration expiration = new Expiration();
            expiration.setUseAirDate(row.containsKey("Use Air Date") && row.get("Use Air Date").equals("should"));
            expiration.setStartDate(parseDate(row.get("Start Date")).getMillis());
            if (row.containsKey("Expire Date")) {
                expiration.setExpireDate(parseDate(row.get("Expire Date")).getMillis());
                expiration.setExpireType("date");
            } else {
                expiration.setExpireInDays(new Long(TimeUnit.MILLISECONDS.convert(Integer.parseInt(row.get("Expire In Days")), TimeUnit.DAYS)).intValue());
                expiration.setExpireType("period");
            }
            generalUsageRight.setExpiration(expiration);
            generalUsageRight.setGeneral(new Object());
            usageRights.add(generalUsageRight);
        }
        else
            throw new IllegalArgumentException("Unknown usage right type: " + usageRightType);
        return usageRights;
    }

    // General: | Start Date | Expire Date | Use Air Date |
    // Countries : | Country | Start Date | Expire Date |
    @When("{I |}fill following fields for usage right '$usageType' on order item page: $fieldsTable")
    public void fillUsageRightsForm(String usageType, ExamplesTable fieldsTable) {
        if (!UsageRule.contains(usageType)) throw new IllegalArgumentException("Unknown usage right type: " + usageType);
        Map<String, String> row = parametrizeTabularRow(fieldsTable);
        getOrderItemPage().getAddUsageRightForm(usageType).fill(row);
    }

    @When("{I |}save usage information for '$usageType' usage right on order item page")
    public void saveUsageRightsForm(String usageType){
        getOrderItemPage().getAddUsageRightForm(usageType).save();
    }

    // General: | Start Date | Expire Date | Use Air Date |
    @Given("{I |}add usage right '$usageRight' for order contains item with {clock number|isrc code} '$clockNumber' with following fields: $fieldsTable")
    @When("{I |}added usage right '$usageRight' for order contains item with {clock number|isrc code} '$clockNumber' with following fields: $fieldsTable")
    public void addUsageRightsToOrderItem(String usageRight, String clockNumber, ExamplesTable fieldsTable) {
        Order order = getOrderByItemClockNumber(wrapVariableWithTestSession(clockNumber));
        OrderItem orderItem = getOrderItemByClockNumber(order.getId(), wrapVariableWithTestSession(clockNumber));
        getCoreApi().addUsageRights(orderItem.getId(), prepareUsageRights(usageRight, parametrizeTabularRow(fieldsTable)));
    }

    // | General | Start Date | Expire Date |
    // | Country | Start Date | Expire Date |
    // | Artist | Track Title | Start Date | Expire Date |
    @Then("{I |}should see following fields for usage right '$usageType' on order item page: $fieldsTable")
    public void checkUsageRights(String usageType, ExamplesTable fieldsTable) {
        Map<String, String> row = parametrizeTabularRow(fieldsTable);
        if (!UsageRule.contains(usageType)) throw new IllegalArgumentException("Unknown usage right type: " + usageType);
        UsageRightSelectorForm.UsageRight usageRight = getOrderItemPage().getUsageRightSelectorForm().getAddedUsageRightByUsageType(usageType);
        if (row.containsKey("Start Date")) assertThat("Start Date: ", usageRight.getStartDate(), equalTo(row.get("Start Date").isEmpty() ? "" : convertDateToDefaultUserLocale(row.get("Start Date"))));
        if (row.containsKey("Expire Date")) assertThat("Expire Date: ", usageRight.getExpireDate(), equalTo(row.get("Expire Date").isEmpty() ? "" : convertDateToDefaultUserLocale(row.get("Expire Date"))));
        if (row.containsKey("Country")) assertThat("Country: ", usageRight.getCountry(), equalTo(row.get("Country")));
        if (row.containsKey("Artist")) assertThat("Artist: ", usageRight.getArtist(), equalTo(row.get("Artist")));
        if (row.containsKey("Track Title")) assertThat("Track Title: ", usageRight.getTrackTitle(), equalTo(row.get("Track Title")));
    }

    @Then("{I |}'$shouldState' see following usage rights '$usageRightsList' on order item page")
    public void checkUsageRightsVisibility(String shouldState, String usageRightsList){
        List<String> visibleUsageRightTypes = getOrderItemPage().getUsageRightSelectorForm().getVisibleUsageRightTypes();
        for (String usageRight: usageRightsList.split(","))
            assertThat("Check usage right visibility: " + usageRight, visibleUsageRightTypes, shouldState.equals("should") ? hasItem(usageRight) : not(hasItem(usageRight)));
    }
}