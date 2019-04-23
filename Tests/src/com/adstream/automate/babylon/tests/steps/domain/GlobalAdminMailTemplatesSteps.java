package com.adstream.automate.babylon.tests.steps.domain;


import com.adstream.automate.babylon.JsonObjects.Agency;
import com.adstream.automate.babylon.sut.pages.admin.mailTemplates.MailTemplatesNotificationSettingsPage;
import com.adstream.automate.babylon.tests.steps.core.BaseStep;
import com.adstream.automate.utils.Common;
import org.jbehave.core.annotations.Given;
import org.jbehave.core.annotations.Then;
import org.jbehave.core.annotations.When;
import org.jbehave.core.model.ExamplesTable;
import org.junit.Assert;

import java.util.List;
import java.util.Map;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.is;

public class GlobalAdminMailTemplatesSteps extends BaseStep {

    @Given("{I am |}on {the|} Mail templates notification settings page")
    @When("{I go |}to the Mail templates notification settings page")
    public MailTemplatesNotificationSettingsPage onNotifcationSettingsPage() {
        return getSut().getPageNavigator().getMailTemplateNotificationSettingPage();
    }

    @Given("{I |}selected advertiser '$agency' on mail templates notification settings page")
    @When("{I |}select advertiser '$agency' on mail templates notification settings page")
    public void selectAdvertiser(Agency agency) {
        getSut().getPageCreator().getMailTemplatesNotificationSettingPage().selectAdvertiser(agency.getName());
    }


    @Given("{I |}searched advertiser '$agency' on mail templates notification settings page")
    @When("{I |}search advertiser '$agency' on mail templates notification settings page")
    public void searchAdvertiser(Agency agency) {
        getSut().getPageCreator().getMailTemplatesNotificationSettingPage().searchAdvertiser(agency.getName());
    }

    @When("{I |}search and select advertiser '$agency' on mail templates notification settings page")
    public void searchAndSelectAdvertiser(Agency agency) {
        MailTemplatesNotificationSettingsPage mailTemplate = getSut().getPageCreator().getMailTemplatesNotificationSettingPage();
        mailTemplate.searchAdvertiser(agency.getName());
        mailTemplate.selectAdvertiser(agency.getName());
    }


    @Then("{I |}'$condition' be able to see all notification settings dropdown with a value selected")
    public void checkNotificationStatus(String condition) {
        MailTemplatesNotificationSettingsPage mailTemplate = getSut().getPageCreator().getMailTemplatesNotificationSettingPage();
        List<String> notifications =  mailTemplate.getAllNotifications();
        for(String notification: notifications) {
            boolean expectedState = condition.equalsIgnoreCase("should");
            boolean actualState = !mailTemplate.getNotificationStatus(notification).isEmpty();
            assertThat("Notification-" + notification + "has no default value selected", actualState, is(expectedState));
            }
        }


    @Given("{I am|} on Mail Templates tab")
    @When("{I am|} on Mail Templates tab")
    public MailTemplatesNotificationSettingsPage.MailTemplatesTab navigateToMailTempaltesTab(){
        MailTemplatesNotificationSettingsPage page = getSut().getPageNavigator().getMailTemplateNotificationSettingPage();
        return page.selectMailTemapltesTab();
    }

    @Given("{I |}edited mail template with following details:$data")
    @When("{I |}edit mail template with following details:$data")
    public void editMailTempalte(ExamplesTable data){
        MailTemplatesNotificationSettingsPage.MailTemplatesTab page = navigateToMailTempaltesTab();
        Map<String, String> row = parametrizeTabularRow(data);

        if(row.containsKey("Business Unit"))
            page.selectValueInDropDownByFieldName("businessUnit", "Business Unit", wrapAgencyName(row.get("Business Unit")));
        if(row.containsKey("Activity"))
            page.selectValueInDropDownByFieldName("activityName", "Activity", row.get("Activity"));
        if(row.containsKey("Preferred Language"))
            page.selectValueInDropDownByFieldName("languageCode", "Preferred Language", row.get("Preferred Language"));
        Common.sleep(2000);
        if(row.containsKey("Default Notification Type"))
            page.selectDefaultNotificationType("Default Notification Type", row.get("Default Notification Type"));
        page.selectButtonByName(row.get("Button Name"));
    }
    }

