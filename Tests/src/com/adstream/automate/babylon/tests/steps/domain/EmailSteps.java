package com.adstream.automate.babylon.tests.steps.domain;

import com.adstream.automate.babylon.JsonObjects.Agency;
import com.adstream.automate.babylon.JsonObjects.BaseObject;
import com.adstream.automate.babylon.JsonObjects.Reel;
import com.adstream.automate.babylon.JsonObjects.User;
import com.adstream.automate.babylon.JsonObjects.adcost.Costs;
import com.adstream.automate.babylon.JsonObjects.ordering.Order;
import com.adstream.automate.babylon.JsonObjects.ordering.enums.AccountType;
import com.adstream.automate.babylon.JsonObjects.ordering.enums.ReminderOfMediaUploadRequest;
import com.adstream.automate.babylon.TestsContext;
import com.adstream.automate.babylon.data.EmailBody;
import com.adstream.automate.babylon.sut.pages.ordering.elements.ServiceLevelType;
import com.adstream.automate.babylon.sut.pages.ordering.elements.dictionaries.SubtitlesRequired;
import com.adstream.automate.babylon.tests.steps.domain.adcost.AdCostsDetailsSteps;
import com.adstream.automate.babylon.tests.steps.domain.adcost.AdCostsHelperSteps;
import com.adstream.automate.utils.Common;
import com.adstream.automate.utils.DateTimeUtils;
import com.adstream.automate.utils.EmailMessage;
import org.apache.commons.lang.text.StrBuilder;
import org.jbehave.core.annotations.Given;
import org.jbehave.core.annotations.Then;
import org.jbehave.core.annotations.When;
import org.jbehave.core.model.ExamplesTable;
import org.joda.time.DateTime;
import org.joda.time.DateTimeZone;
import org.joda.time.format.DateTimeFormat;

import java.net.MalformedURLException;
import java.net.URL;
import java.text.DateFormat;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.*;

/**
 * Created with IntelliJ IDEA.
 * User: demidovskiy-r
 * Date: 15.11.12
 * Time: 13:25
 */
public class EmailSteps extends BabylonSteps {
    public static enum Headers {
        TO("to");

        private String header;

        private Headers(String header) {
            this.header = header;
        }

        public String toString() {
            return header;
        }
    }

    @Given("{I |}opened link from letter with subject '$subject' for presentation")
    @When("{I |}open link from letter with subject '$subject' for presentation")
    public void openLinkForPresentation(String subject) {
        subject = wrapVariableWithTestSession(subject);
        EmailMessage message = getLastEmailBySubject(subject);
        if (message == null) {
            throw new RuntimeException(String.format("Could not find letter with subject '%s'", subject));
        }
        String emailsBody = message.getBody().getHtml();
        int start = emailsBody.indexOf("href='") + "href='".length();
        int end = emailsBody.indexOf("'", start);
        String link = emailsBody.substring(start, end);
        getSut().getWebDriver().get(link);
    }

    @When("{I |}open link from letter with subject '$subject' for presentation without message deleting")
    public void openLinkForPresentationWithOutMessageDeleting(String subject) {
        String emailsBody = getLastEmailBySubjectWithoutDeleting(wrapVariableWithTestSession(subject)).getBody().getHtml();
        int start = emailsBody.indexOf("href='") + "href='".length();
        int end = emailsBody.indexOf("'", start);
        String link = emailsBody.substring(start, end);
        getSut().getWebDriver().get(link);
    }

    @When("{I |}open link from email when user '$userTo' received email with next subject '$subject'")
    @Then("{I |}opened link from email where user '$userTo' received email with next subject '$subject'")
    public void openLinkFromEmail(String userTo, String subject) {
        Common.sleep(2000);
        String userToEmail = wrapUserEmailWithTestSession(userTo);
 //       if(getContext().applicationUrl.toString().equalsIgnoreCase("https://a5.adstream.com")) subject = "You are invited to the Adstream Platform";
        EmailMessage emailMessage = getLastEmailMessageByHeaderAndSubject(Headers.TO, userToEmail, subject);
        assertThat("There is no last unread email with following subject: " + subject, emailMessage, notNullValue());
        String href = getLinkFromEmailMessage(emailMessage.getBody().getHtml());
        getSut().getWebDriver().get(href);
        Common.sleep(2000);
        getSut().getWebDriver().navigate().refresh();
    }


    @When("{I |} should see navigating url as '$navigatingUrl' when user '$userTo' received email with next subject '$subject'")
    @Then("{I |} should see navigating url as '$navigatingUrl' when user '$userTo' received email with next subject '$subject'")
    public void navigatingLinkFromEmail(String navigatingUrl,String userTo,String subject) {
        if(navigatingUrl.equalsIgnoreCase("hostIp")){
            navigatingUrl = TestsContext.getInstance().applicationUrl.toString();
        }
        String userToEmail = wrapUserEmailWithTestSession(userTo);
        EmailMessage emailMessage = getLastEmailMessageByHeaderAndSubject(Headers.TO, userToEmail, subject);
        String href = getLinkFromEmailMessageWithoutReplacingProtocol(emailMessage.getBody().getHtml());
        assertThat("Check email message : ", href, containsString(navigatingUrl));
    }



    @When("{I |}open link from invitation email to user '$userTo'")
    @Then("{I |}opened link from invitation email to user '$userTo'")
    public void openLinkFromEmailforEnv(String userTo) {
        Common.sleep(2000);String subject;
        String userToEmail = wrapUserEmailWithTestSession(userTo);
        subject = "You are invited to the Adstream Platform";
        EmailMessage emailMessage = getLastEmailMessageByHeaderAndSubject(Headers.TO, userToEmail, subject);
        assertThat("There is no last unread email with following subject: " + subject, emailMessage, notNullValue());
        String href = getLinkFromEmailMessage(emailMessage.getBody().getHtml());
        getSut().getWebDriver().get(href);
    }


    @Then("{I |}should see an email sent to user '$userTo' for project publish and notification with message as '$partOfMessage' with interval")
    public void openLinkFromEmailPublishDate1(String userTo,String partOfMessage) {

        Common.sleep(2000);
        String userToEmail = wrapUserEmailWithTestSession(userTo);
        EmailMessage emailMessage = getLastEmailMessageByHeader(Headers.TO, userToEmail);
        String message = parseEmailMessage(emailMessage);
        int i =1;
        do {
            if (message.length() == 0 ) {
                Common.sleep(60000);
            }
            emailMessage = getLastEmailMessageByHeader(Headers.TO, userToEmail);
            message = parseEmailMessage(emailMessage);
            i++;
        } while (message.length() == 0 && i<=6);
        assertThat("Check email message : ", message, containsString(partOfMessage));
    }

    @When("{I |}login with details from email when user '$userTo' received with next subject '$subject'")
    public void openLinkFromEmailAndLogin(String userTo, String subject) {
        Common.sleep(2000);
        String userToEmail = wrapUserEmailWithTestSession(userTo);
        EmailMessage emailMessage = getLastEmailMessageByHeaderAndSubjectWithoutDelete(Headers.TO, userToEmail, subject);
        assertThat("There is no last unread email with following subject: " + subject, emailMessage, notNullValue());

        String href = getLinkFromEmailMessage(emailMessage.getBody().getHtml());
        getSut().getWebDriver().get(href);

        Matcher m = Pattern.compile("New password has been created for you: (\\w+)").matcher(emailMessage.getBody().getHtml());
        if (!m.find()) throw new IllegalStateException("Email does not contain password");
        getSut().getPageCreator().getLoginPage().login(userToEmail, m.group(1));
    }

    @When("I check header term work email '$userName'")
    public void checkHeaderTermWorkEmail(String userName) {
        String userTo = wrapUserEmailWithTestSession(userName);
        getLastEmailMessageByHeader(Headers.TO, userTo);
    }

    @Then("I '$condition' see email with field to contains email '$userName'")
    public void checkThatEmailWithWishedHeaderIsExist(String condition, String userName) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        String userTo = wrapUserEmailWithTestSession(userName);
        EmailMessage emailMessage = getLastEmailMessageByHeader(Headers.TO, userTo);
        assertThat(emailMessage, shouldState ? notNullValue() : nullValue());
    }

    @Then("{I |}'$condition' see email with subject '$subject' sent to '$userName'")
    public void checkThatEmailWithWishedSubjectAndUserToExist(String condition, String subject, String userName) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        String userTo = wrapUserEmailWithTestSession(userName);
        EmailMessage emailMessage = getLastEmailMessageByHeaderAndSubject(Headers.TO, userTo, subject);
        assertThat(emailMessage, shouldState ? notNullValue() : nullValue());
    }

    @Then("I '$condition' see only one email with subject '$subject' sent to '$userName'")
    public void checkThatOnlyOneEmailWithWishedSubjectAndUserToExist(String condition, String subject, String userName) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        String userTo = wrapUserEmailWithTestSession(userName);
        List<EmailMessage> emailMessage = getEmailsMessageByHeaderAndSubject(Headers.TO, userTo, subject);
        assertThat(emailMessage,hasSize(1));
    }

    @Then("I '$condition' see email about expiration for file '$fileName' from folder '$folderName' in project '$projetName' sent to '$userName'")
    public void checkThatEmailWithWishedSubjectAndUserToExist(
            String condition, String fileName, String folderName, String projectName, String userName){
        boolean shouldState = condition.equalsIgnoreCase("should");
        String userTo = wrapUserEmailWithTestSession(userName);
        String subject = "Usage Rights about to expire on "
                + wrapPathWithTestSession(projectName) + wrapPathWithTestSession(folderName) + "/" + fileName;
        EmailMessage emailMessage = getLastEmailMessageByHeaderAndSubject(Headers.TO, userTo, subject);
        assertThat(emailMessage, shouldState ? notNullValue() : nullValue());
    }

    @Then("I '$condition' see email with subject '$subject' sent to user '$userName' and body contains '$bodyText'")
    public void checkThatEmailWithSubjectBodyContentAndUserExist(
            String condition, String subject, String userName, String bodyText){
        boolean shouldState = condition.equalsIgnoreCase("should");
        String userTo = wrapUserEmailWithTestSession(userName);
        EmailMessage emailMessage = getLastEmailMessageByHeaderSubjectAndBody(Headers.TO, userTo, subject, bodyText, shouldState);
        assertThat(emailMessage, shouldState ? notNullValue() : nullValue());
    }

    @Then("I '$condition' see email with subject '$subject' sent to user '$userName' with below details:")
    public void checkThatEmailWithSubjectBodyContentAndUserExists(
            String condition, String subject, String userName, String bodyText){
        boolean shouldState = condition.equalsIgnoreCase("should");
        String userTo = wrapUserEmailWithTestSession(userName);
        EmailMessage emailMessage = getLastEmailMessageByHeaderSubjectAndBody(Headers.TO, userTo, subject, bodyText, shouldState);
        assertThat(emailMessage, shouldState ? notNullValue() : nullValue());
    }

    // | ProjectName | FolderName |
    @Then("I should see that email with field to '$userEmail' contains following message '$partOfMessage'")
    public void checkEmailsAttribites(String userEmail, String partOfMessage) {
        Common.sleep(2000);
        String userTo = wrapUserEmailWithTestSession(userEmail);
        EmailMessage emailMessage = getLastEmailMessageByHeader(Headers.TO, userTo);
        String message = parseEmailMessage(emailMessage);

        assertThat("Check email message : ", message, containsString(partOfMessage));
    }

    @Then("I tested email by header and subject user '$userEmail' and subject '$subject'")
    public void checkEmailByHeaderAndSubject(String userEmail, String subject) {
        String userTo = wrapUserEmailWithTestSession(userEmail);
        getLastEmailMessageByHeaderAndSubject(Headers.TO, userTo, subject);
    }

    @Then("{I |}should see shared public link from '$presentationName' in user email '$usermail' with subject '$subject'")
    public void checkPresentationLink(String presentationName, String userEmail, String subject) {
        userEmail = wrapUserEmailWithTestSession(userEmail);
        String presentationId = getCoreApi(getData().getCurrentUser()).getReelByName(wrapVariableWithTestSession(presentationName)).getId();
        String publicLinkToken = getCoreApi(getData().getCurrentUser()).getPresentationPublicToken(presentationId);
        EmailMessage emailMessage;

        if (!subject.isEmpty()) {
            emailMessage = getLastEmailMessageByHeaderAndSubject(Headers.TO, userEmail, subject);
        } else {
            emailMessage = getLastEmailMessageByHeader(Headers.TO, userEmail);
        }
        assertThat(emailMessage.getBody().getHtml(), containsString(String.format("/presentation/%s", publicLinkToken)));
    }


    @Then("{I |}'$condition' see cost email notification for '$notificationType' with field to '$userEmail' and subject '$subject' contains following attributes: $attributeTable")
    public void checkEmailNotificationTypeInCostModule(String condition, String notificationType, String userEmail, String subject, ExamplesTable attributeTable) {
        EmailBody emailBody = new EmailBody(notificationType);
        String userTo = wrapUserEmailWithTestSession(userEmail);

        boolean shouldState = condition.equalsIgnoreCase("should");
        EmailMessage emailMessage;

        for (Map<String, String> row : parametrizeTableRows(attributeTable)) {
            if(!userEmail.equalsIgnoreCase("adcostssupport@adstream.com"))
                emailBody.setUserFullName(getUserDetails(userEmail).getFullName());
            if (row.get("EmailLanguage") == null) {
                User user = getCoreApiAdmin().getUserByEmail(wrapUserEmailWithTestSession(userEmail));
                emailBody.setLanguage(user == null ? "en-us" : user.getLanguage());
            } else {
                emailBody.setLanguage(row.get("EmailLanguage"));
            }
            String costTitleWrap = wrapVariableWithTestSession(row.get("Cost Title"));
            AdCostsHelperSteps adCostsHelperSteps = new AdCostsHelperSteps();
            Costs costs = adCostsHelperSteps.getCostDetails(costTitleWrap);
            String costId = costs.getId();
            String costStageId = adCostsHelperSteps.getCostStageId(costId);
            String costRevisionId = adCostsHelperSteps.getCostRevisionId(costId, costStageId);
            String costNumber = costs.getCostNumber();
            emailBody.setAdcostURLCostId(costId);
            emailBody.setAdcostRevisionId(costRevisionId);
            emailBody.setAdcostCostTitle(costTitleWrap);
            emailBody.setAdcostCostID(costNumber);
            if(row.containsKey("Cost Owner")) {
                User user2 = getData().getUserByType(row.get("Cost Owner"));
                if (user2 != null)
                    emailBody.setAdcostCostOwner(user2.getFullName());
                else {
                    User details = getUserDetails(row.get("Cost Owner"));
                    emailBody.setAdcostCostOwner(details.getFullName());
                }
            }
            if(row.containsKey("P&G Admin"))
                emailBody.setAdcostPnGadmin(getUserFullDetails(row.get("P&G Admin")));
            else
                emailBody.setAdcostPnGadmin(getUserFullDetails("GovernanceManager"));
            if (row.containsKey("Comments")) {
                if (row.get("Comments").equalsIgnoreCase("MockedAMQComment"))
                    emailBody.setCommentText(new AdCostsHelperSteps().getMockedAMQComment());
                else emailBody.setCommentText(row.get("Comments"));
            }
            if(row.containsKey("Message"))
                emailBody.setCommentText(row.get("Message"));
            if(row.containsKey("Cost URL"))
                emailBody.setAdcostURL(row.get("Cost URL"));
            if(row.containsKey("Content Type"))
                emailBody.setAdcostContentType(row.get("Content Type"));
            if(row.containsKey("Production Type"))
                emailBody.setAdcostProductionType(row.get("Production Type"));
            if(row.containsKey("Cost Type"))
                emailBody.setAdcostCostType(row.get("Cost Type"));
            if(row.containsKey("Usage/Buyout/Contract Type"))
                emailBody.setAdcostUsageBuyoutContractType(row.get("Usage/Buyout/Contract Type"));
            emailBody.setAdcostStage(row.get("Stage"));
            emailBody.setAdcostStatus(row.get("Status"));
            emailBody.setAdcostAgencyProducer(row.get("Agency Producer"));
            if(row.containsKey("Old Cost Owner")) {
                User user1 = getData().getUserByType(row.get("Old Cost Owner"));
                if (user1 != null)
                    emailBody.setadcostOldCostOwner(user1.getFullName());
                else {
                    User details = getUserDetails(row.get("Old Cost Owner"));
                    emailBody.setadcostOldCostOwner(details.getFullName());
                }
            }
            if(row.containsKey("Stage"))
                emailBody.setAdcostStage(row.get("Stage"));
            if(row.containsKey("Status"))
                emailBody.setAdcostStatus(row.get("Status"));
            if(row.containsKey("Agency Producer"))
                emailBody.setAdcostAgencyProducer(row.get("Agency Producer"));
            if(row.containsKey("Agency Owner")) {
                User user = getData().getUserByType(row.get("Agency Owner"));
            if(user!=null)
                emailBody.setAdcostAgencyOwner(user.getFullName().concat(" - ").concat(user.getEmail()));
            else {
                User details = getUserDetails(row.get("Agency Owner"));
                emailBody.setAdcostAgencyOwner(details.getFullName().concat(" - ").concat(details.getEmail()));
            } }
            if(row.containsKey("Agency Name")) {
                Agency agency = getAgencyByName(row.get("Agency Name"));
                emailBody.setAdcostAgencyName(agency.getName());
                emailBody.setAdcostAgencyLocation(row.get("Agency Location"));
                emailBody.setAdcostAgencyTracking(wrapVariableWithTestSession(row.get("Agency Tracking #")));
            }
            if(row.containsKey("Project Name")) {
                String projectName = new AdCostsDetailsSteps().getProjectByNameAsGlobalAdmin(row.get("Project Name"));
                emailBody.setAdcostProjectName(projectName);
                emailBody.setAdcostProjectID(new AdCostsDetailsSteps().getProjectNumber(projectName));
            }
            if(row.containsKey("Budget Region"))
                emailBody.setAdcostBudgetRegion(row.get("Budget Region"));
            if(row.containsKey("Technical Approver"))
                emailBody.setAdcostTechnicalApprover(getUserFullName(row.get("Technical Approver")));
            if(row.containsKey("Brand"))
                emailBody.setAdcostBrand(row.get("Brand"));
            if (row.containsKey("Timestamp")) {
                DateTime d = new DateTime();
                switch (row.get("Timestamp")) {
                    case "Today":
                        emailBody.setAdcostTimestamp(d.toString("MM/dd/yyyy"));
                        break;
                }
            }
            if(row.containsKey("OEApprovedForFM"))
                emailBody.setAdcostOEApprovedForFM(row.get("OEApprovedForFM"));
            String approverRole = null;
            switch (emailBody.getEmailType()) {
                case COST_SUBMITTED:
                    subject = String.format("Cost %s has been submitted for %s approval",costNumber,emailBody.getAdcostStage());
                    break;
                case COST_APPROVERADDED:
                    if(row.containsKey("Cost Approver")) {
                        String costApprover = row.get("Cost Approver");
                        approverRole = new AdCostsHelperSteps().getUserRoleInCostModule(wrapUserEmailWithTestSession(costApprover));
                        List<String> temp = new ArrayList<>();
                        if (row.containsKey("Cost Approver Type"))
                            for (String costType : row.get("Cost Approver Type").split(";"))
                                temp.add(costType);
                        emailBody.setAdcostCostApproverType(temp.get(0));
                        if (temp.size() > 1 && temp.get(1).equalsIgnoreCase("Cyclone"))
                            subject = String.format("%s has been added as an approver for %s cost %s", getApproverFormat_Cyclone(costApprover, approverRole), emailBody.getAdcostStage(), costNumber);
                        else
                            subject = String.format("%s has been added as an approver for %s cost %s", getApproverFormat_NonCyclone(costApprover, approverRole), emailBody.getAdcostStage(), costNumber);
                    } else throw new IllegalArgumentException("Cost Approver missing: check if 'Cost Approver' passed at step level.");
                    break;
                case COST_APPROVED_IN_COSTMODULE:
                    if(row.containsKey("Cost Approver")) {
                        String costApprover = row.get("Cost Approver");
                        approverRole = new AdCostsHelperSteps().getUserRoleInCostModule(wrapUserEmailWithTestSession(costApprover));
                        emailBody.setAdcostCostApprover(getApproverFormatForBody(costApprover,approverRole));
                        subject = String.format("%s has provided their approval for %s cost %s",getApproverFormat_NonCyclone(costApprover,approverRole),emailBody.getAdcostStage(),costNumber);
                    } else throw new IllegalArgumentException("Cost Approver missing: check if 'Cost Approver' passed at step level.");
                    break;
                case COST_APPROVED_IN_COUPA:
                    if(row.containsKey("Cost Approver")) {
                        if(row.get("Cost Approver").equalsIgnoreCase("IoNumberOwner"))
                            approverRole = new AdCostsHelperSteps().getIoNumberOwner().concat(" - Brand Management Approver");
                        // else Todo:
                        emailBody.setAdcostCostApprover(approverRole);
                        subject = String.format("%s for Cost (%s) has been Approved", emailBody.getAdcostStage(), costNumber);
                    } else throw new IllegalArgumentException("Cost Approver missing: check if 'Cost Approver' passed at step level.");
                    break;
                case COST_APPROVED:
                    subject = String.format("%s stage for %s has been Approved",emailBody.getAdcostStage(),costNumber);
                    break;
                case COST_PENDING_APPROVAL:
                    if(!row.containsKey("Pending Approval"))
                        throw new IllegalArgumentException("Pending Approval missing: check if 'Pending Apporver' passed at step level.");
                    emailBody.setAdcostPendingApproval(row.get("Pending Approval"));
                    subject = String.format("Cost %s is pending %s",costNumber,emailBody.getAdcostPendingApproval());
                    break;
                case COST_RECALLED_COSTOWNERS:
                    if(row.containsKey("Cost Owner"))
                    {
//                        emailBody.setAdcostCostOwner(getUserFullDetails(row.get("Cost Owner")));
                        subject = String.format("%s for Cost (%s) has been %s", emailBody.getAdcostStage(), costNumber,emailBody.getAdcostStatus());
                    } else throw new IllegalArgumentException("Cost Owner missing: check if 'Cost Owner' passed at step level.");
                    break;
                case COST_RECALLED_COSTAPPROVERS:
                    if(row.containsKey("Cost Owner"))
                    {
//                        emailBody.setAdcostCostOwner(getUserFullDetails(row.get("Cost Owner")));
                        subject = String.format("%s for Cost (%s) has been %s", emailBody.getAdcostStage(), costNumber,emailBody.getAdcostStatus());
                    } else throw new IllegalArgumentException("Cost Owner missing: check if 'Cost Owner' passed at step level.");
                    break;
                case COST_REQUEST_CHANGES:
                    if(row.containsKey("Cost Approver")) {
                        if(row.get("Cost Approver").equalsIgnoreCase("Coupa"))
                            emailBody.setAdcostCostApprover("Platform Adstream");
                        else emailBody.setAdcostCostApprover(getUserFullDetails(row.get("Cost Approver")));
                        subject = String.format("%s for Cost (%s) has been %s (Changes requested)",emailBody.getAdcostStage(),costNumber,emailBody.getAdcostStatus());
                    } else throw new IllegalArgumentException("Cost Approver missing: check if 'Cost Approver' passed at step level.");
                    break;
                case COST_REQUEST_CHANGES_INSURANCEUSER:
                    if(row.containsKey("Cost Approver")) {
                        if(row.get("Cost Approver").equalsIgnoreCase("Coupa"))
                            emailBody.setAdcostCostApprover("Platform Adstream");
                        else emailBody.setAdcostCostApprover(getUserFullDetails(row.get("Cost Approver")));
                        subject = String.format("%s for Cost (%s) has been %s (Changes requested)",emailBody.getAdcostStage(),costNumber,emailBody.getAdcostStatus());
                    } else throw new IllegalArgumentException("Cost Approver missing: check if 'Cost Approver' passed at step level.");
                    break;
                case COST_REQUEST_CHANGES_FINANCEUSER:
                    if(row.containsKey("Cost Approver")) {
                        if(row.get("Cost Approver").equalsIgnoreCase("Coupa"))
                            emailBody.setAdcostCostApprover("Platform Adstream");
                        else emailBody.setAdcostCostApprover(getUserFullDetails(row.get("Cost Approver")));
                        subject = String.format("%s for Cost (%s) has been %s (Changes requested)",emailBody.getAdcostStage(),costNumber,emailBody.getAdcostStatus());
                    } else throw new IllegalArgumentException("Cost Approver missing: check if 'Cost Approver' passed at step level.");
                    break;
                case COST_CANCELLED:
                    subject = String.format("%s Cost %s has been Cancelled",emailBody.getAdcostStage(),costNumber);
                    break;
                case COST_REOPEN_REQUEST:
                    subject = String.format("Request for %s Cost (%s) to be re-opened",emailBody.getAdcostStage(),costNumber);
                    break;
                case COST_REOPEN_SUCCESS:
                    subject = String.format("Success, %s cost (%s) has been re-opened", emailBody.getAdcostStage(), costNumber);
                    break;
                case COST_REOPEN_REJECT:
                    subject = String.format("Request to re-open %s cost (%s) has been returned",emailBody.getAdcostStage(),costNumber);
                    break;
                case COST_APPROVAL_REASSIGNED:
                    if(row.containsKey("Cost Approver")) {
                        String costApprover = row.get("Cost Approver");
                        approverRole = new AdCostsHelperSteps().getUserRoleInCostModule(wrapUserEmailWithTestSession(costApprover));
                        List<String> temp = new ArrayList<>();
                        if (row.containsKey("Cost Approver Type"))
                            for (String costType : row.get("Cost Approver Type").split(";"))
                                temp.add(costType);
                        emailBody.setAdcostCostApproverType(temp.get(0));
                        if (temp.size() > 1 && temp.get(1).equalsIgnoreCase("Cyclone"))
                            subject = String.format("%s has been added as an approver for %s cost %s", getApproverFormat_Cyclone(costApprover, approverRole), emailBody.getAdcostStage(), costNumber);
                        else
                            subject = String.format("%s has been added as an approver for %s cost %s", getApproverFormat_NonCyclone(costApprover, approverRole), emailBody.getAdcostStage(), costNumber);
                    } else throw new IllegalArgumentException("Cost Approver missing: check if 'Cost Approver' passed at step level.");
                    break;
                 case COST_OWNER_CHANGED:
                       subject = String.format("Cost owner for Cost (%s) has been changed",costNumber);
                       break;
                case COST_TECHNICAL_ISSUE:
                    subject = String.format("Technical issue with Cost %s",costNumber);
                    break;
                case COST_TECHNICAL_ISSUE_VENDOR_DETAILS:
                    subject = String.format("Technical issue with Cost %s",costNumber);
                    break;
                case COST_PENDING_REOPEN:
                    subject = String.format("%s stage for Cost (%s) is Pending Reopen",emailBody.getAdcostStage(),costNumber);
                    break;
                case COST_APPROVERADDED_FMUSER:
                    if(row.containsKey("Cost Approver")) {
                        String costApprover = row.get("Cost Approver");
                        approverRole = new AdCostsHelperSteps().getUserRoleInCostModule(wrapUserEmailWithTestSession(costApprover));
                        List<String> temp = new ArrayList<>();
                        if (row.containsKey("Cost Approver Type"))
                            for (String costType : row.get("Cost Approver Type").split(";"))
                                temp.add(costType);
                        emailBody.setAdcostCostApproverType(temp.get(0));
                        if (temp.size() > 1 && temp.get(1).equalsIgnoreCase("Cyclone"))
                            subject = String.format("%s has been added as an approver for %s cost %s", getApproverFormat_FMUser(costApprover, approverRole), emailBody.getAdcostStage(), costNumber);
                        else
                            subject = String.format("%s has been added as an approver for %s cost %s", getApproverFormat_FMUser(costApprover, approverRole), emailBody.getAdcostStage(), costNumber);
                    } else throw new IllegalArgumentException("Cost Approver missing: check if 'Cost Approver' passed at step level.");
                    break;
            }

            emailBody.setSubject(subject);

            if (!subject.isEmpty()) {
                emailMessage = getLastEmailMessageByHeaderAndSubject(Headers.TO, userTo, subject);
            } else {
                emailMessage = getLastEmailMessageByHeader(Headers.TO, userTo);
            }

            if (!shouldState) {
                assertThat(emailMessage, nullValue());
                return;
            } else if (emailMessage == null) {
                throw new IllegalStateException("User has not got any email on address " + userTo + " with subject " + subject);
            }

            if (row.get("EmailFrom") != null && !row.get("EmailFrom").isEmpty()) {
                String expectedEmail = row.get("EmailFrom");
                String actualEmail = emailMessage.getHeader().getFrom();
                assertThat(actualEmail, equalToIgnoringCase(expectedEmail));
            }
            if (row.get("EmailCC") != null && !row.get("EmailCC").isEmpty())
                assertThat("Check recipient_cc: ", emailMessage.getHeader().getRecipient_cc(), equalTo(prepareEmailCC(row.get("EmailCC"))));

            String message = parseEmailMessage(emailMessage);
            assertThat(emailMessage.getHeader().getSubject().trim(), containsString(emailBody.generateSubject()));

            List<String> checkStrTemp = emailBody.generateBodyForCostModule();

            for (String checkStr : checkStrTemp ) {
                assertThat(message, containsString(checkStr));
            }

            for (String checkStr: emailBody.generateLinks()) {
                assertThat(emailMessage.getBody().getHtml(), containsString(checkStr));
            }
        }
    }


    // | UserName | Agency | ProjectName | Message |
    @Then("{I |}'$condition' see email notification for '$notificationType' with field to '$userEmail' and subject '$subject' contains following attributes: $attributeTable")
    public void checkEmailForSpecialNotificationType(String condition, String notificationType, String userEmail, String subject, ExamplesTable attributeTable) {
        EmailBody emailBody = new EmailBody(notificationType);
        String userTo = wrapUserEmailWithTestSession(userEmail);
        boolean shouldState = condition.equalsIgnoreCase("should");
        EmailMessage emailMessage;

        for (Map<String, String> row : parametrizeTableRows(attributeTable)) {
            String userName = getUserFullName(row.get("UserName"));
            emailBody.setUserFullName(userName);

            if (row.get("EmailLanguage") == null) {
                User user = getCoreApiAdmin().getUserByEmail(wrapUserEmailWithTestSession(userEmail));
                emailBody.setLanguage(user == null ? "en-us" : user.getLanguage());
            } else {
                emailBody.setLanguage(row.get("EmailLanguage"));
            }

            if (row.get("Agency") != null && !row.get("Agency").isEmpty()) emailBody.setAgency(getAgencyName(row.get("Agency")));
            String clockNumber = prepareClockNumber(row.get("Clock Number"));

            switch (emailBody.getEmailType()) {
                case PROJECT_OWNER_ADDED:
                case PROJECT_OWNER_REMOVED:
                case PROJECT_TEAM_ADDED:
                    emailBody.setProjectName(wrapVariableWithTestSession(row.get("ProjectName")));
                    emailBody.setProjectId(getCoreApi().getProjectByName(wrapVariableWithTestSession(row.get("ProjectName"))).getId());
                    subject = userName + " " + subject;
                    break;
                case COMMENT_WRITTEN:
                    emailBody.setProjectName(wrapVariableWithTestSession(row.get("ProjectName")));
                    emailBody.setFolderName(wrapVariableWithTestSession(row.get("FolderName")));
                    String projectId= getCoreApi().getProjectByName(wrapVariableWithTestSession(row.get("ProjectName"))).getId();
                    emailBody.setProjectId(projectId);
                    emailBody.setFileName(row.get("FileName"));
                    emailBody.setCommentText(row.get("Comment"));
                    break;
                case SECURE_COMMENT_WRITTEN:
                    emailBody.setProjectName(wrapVariableWithTestSession(row.get("ProjectName")));
                    emailBody.setFileName(row.get("FileName"));
                    emailBody.setCommentText(row.get("Comment"));
                    break;
                case FILE_DOWNLOADED:
                case FILE_DELETED:
                case FILE_PLAYED:
                case FILE_MOVED_TO_LIBRARY:
                case FILE_UPLOADED_TO_PROJECTS:
                    emailBody.setProjectName(wrapVariableWithTestSession(row.get("ProjectName")));
                    emailBody.setFolderName(wrapVariableWithTestSession(row.get("FolderName")));
                    projectId = getCoreApi().getProjectByName(wrapVariableWithTestSession(row.get("ProjectName"))).getId();
                    emailBody.setProjectId(projectId);
                    emailBody.setFileName(row.get("FileName"));
                    break;
                case ASSET_SHARING:
                case FILE_SHARING:
                    emailBody.setMessage(row.get("Message"));
                    emailBody.setFileName(row.get("FileName"));
                    break;
                case FILE_SHARING_WITH_USER:
                    emailBody.setMessage(row.get("Message"));
                    emailBody.setFileName(row.get("FileName"));
                    break;
                case ASSET_SHARING_WITH_USER:
                    emailBody.setOtherUserFullName(getUserFullName(wrapUserEmailWithTestSession(row.get("UserName1"))));
                    emailBody.setMessage(row.get("Message"));
                    emailBody.setFileName(row.get("FileName"));
                    break;
                case ASSET_SHARING_WITH_EASY_USER:
                    emailBody.setMessage(row.get("Message"));
                    break;
                case CATEGORY_SHARING:
                    emailBody.setOtherUserFullName(getCoreApiAdmin().getUserByEmail(wrapUserEmailWithTestSession(row.get("UserName1"))).getFullName());
                    emailBody.setCategoryName(wrapVariableWithTestSession(row.get("CategoryName")));
                    emailBody.setUserEmail(wrapUserEmailWithTestSession(row.get("UserName")));
                    break;
                case FOLDER_SHARING_FOR_USER:
                    emailBody.setProjectName(wrapVariableWithTestSession(row.get("ProjectName")));
                    emailBody.setFolderName(wrapVariableWithTestSession(row.get("FolderName")));
                    projectId= getCoreApi().getProjectByName(wrapVariableWithTestSession(row.get("ProjectName"))).getId();
                    emailBody.setProjectId(projectId);
                    emailBody.setOtherUserFullName((getUserFullName(wrapUserEmailWithTestSession(userEmail))));
                    if (row.get("UserName1")!=null)
                        emailBody.setOtherUserFullName(getUserFullName(wrapUserEmailWithTestSession(row.get("UserName1"))));
                    break;
                case FOLDER_SHARING_FOR_EASY_USER:
                    emailBody.setProjectName(wrapVariableWithTestSession(row.get("ProjectName")));
                    break;
                case PRESENTATION_SHARING_FOR_USER:
                case PRESENTATION_FILE_DOWNLOADED:
                case PRESENTATION_VIEWED:
                    emailBody.setPresentationName(wrapVariableWithTestSession(row.get("PresentationName")));
                    emailBody.setMessage(row.get("Message"));
                    emailBody.setOtherUserFullName(getUserFullName(wrapUserEmailWithTestSession(userEmail)));
                    break;
                case PRESENTATION_SHARING_FOR_OTHER_USER:
                    emailBody.setPresentationName(wrapVariableWithTestSession(row.get("PresentationName")));
                    emailBody.setMessage(row.get("Message"));
                    emailBody.setOtherUserFullName(getUserFullName(wrapUserEmailWithTestSession(row.get("UserName1"))));
                    break;
                case PREVIEW_TRANSCODE_FAILED:
                    emailBody.setFileName(row.get("FileName"));
                    break;
                case USER_INVITATION:
                case USER_PASSWORD:
                    break;
                case APPROVAL_FEEDBACK_GIVEN:
                    emailBody.setApprovalAction(row.get("ApprovalAction"));
                    emailBody.setFileName(row.get("FileName"));
                    emailBody.setApprovalMessage(row.get("ApprovalMessage"));
                    break;
                case APPROVAL_REQUEST:
                    DateTime requiredDate = row.containsKey("RequiredDate") ? parseDateTime(row.get("RequiredDate"), "dd/MM/YYYY") : new DateTime();
                    String senderEmail = wrapUserEmailWithTestSession(row.get("UserEmail"));
                    emailBody.setUserEmail(wrapUserEmailWithTestSession(row.get("UserEmail")));
                    emailBody.setProjectName(wrapVariableWithTestSession(row.get("ProjectName")));
                    emailBody.setFileName(row.get("FileName"));
                    if(row.get("ApprovalMessage")!=null)
                    emailBody.setApprovalMessage(row.get("ApprovalMessage"));
                    emailBody.setApprovalRequiredDate(formatDateForApproval(senderEmail, userTo, requiredDate));
                    emailBody.setApprovalRequestedDate(formatDateForApproval(senderEmail, userTo, new DateTime()));
                    break;
                case APPROVAL_COMPLETED:
                case APPROVED_BY_USER:
                    emailBody.setApprovalStageName(wrapVariableWithTestSession(row.get("ApprovalStage")));
                    emailBody.setFileName(row.get("FileName"));
                    break;
                case APPROVAL_REQUIRED_REMINDER:
                    requiredDate = row.containsKey("RequiredDate") ? parseDateTime(row.get("RequiredDate"), "dd/MM/YYYY") : new DateTime();
                    emailBody.setProjectName(wrapVariableWithTestSession(row.get("ProjectName")));
                    emailBody.setFileName(row.get("FileName"));
                    emailBody.setApprovalMessage(row.get("ApprovalMessage"));
                    emailBody.setApprovalRequiredDate(formatDateForApproval(userTo, userTo, requiredDate));
                    emailBody.setApprovalRequestedDate(formatDateForApproval(userTo, userTo, new DateTime()));
                    break;
                case PLEASE_IGNORE_UPLOAD_REQUEST:
                    emailBody.setSubject(subject);
                    emailBody.setAccountType(AccountType.findByName(row.get("Account Type")));
                    emailBody.setUserEmail(wrapUserEmailWithTestSession(row.get("UserEmail")));
                    emailBody.setClockNumber(clockNumber);
                    break;
                case MEDIA_TRANSFER_REQUEST:
                    if (shouldState) {
                        emailBody.setSubject(subject);
                        emailBody.setAccountType(AccountType.findByName(row.get("Account Type")));
                        emailBody.setUserEmail(wrapUserEmailWithTestSession(row.get("UserEmail")));
                        emailBody.setDeadlineDate(DateTimeUtils.formatDate(DateTimeUtils.parseDate(row.get("Deadline Date"), getContext().userDateTimeFormat), "EEEE dd MMMM yyyy", Locale.UK));
                        emailBody.setUploadDate(DateTimeUtils.formatDate(DateTimeUtils.parseDate(row.get("Deadline Date"), getContext().userDateTimeFormat), "MMM dd yyyy hh:mma", Locale.UK));
                        emailBody.setClockNumber(clockNumber);
                        emailBody.setAdvertiser(wrapVariableWithTestSession(row.get("Advertiser")));
                        emailBody.setProduct(wrapVariableWithTestSession(row.get("Product")));
                        emailBody.setTitle(wrapVariableWithTestSession(row.get("Title")));
                        emailBody.setDuration(row.get("Duration"));
                        emailBody.setFormat(row.get("Format"));
                        emailBody.setMessage(row.get("Message"));
                        if (row.containsKey("First Air Date")) emailBody.setFirstAirDate(DateTimeUtils.formatDate(DateTimeUtils.parseDate(row.get("First Air Date"), getContext().userDateTimeFormat), "MMM dd yyyy", Locale.UK));
                        if (row.containsKey("Destinations")) emailBody.setDestination(row.get("Destinations"));
                    }
                    break;
                case NVERGE_UPLOAD_REQUEST:
                    if (shouldState) {
                        emailBody.setSubject(subject);
                        emailBody.setAccountType(AccountType.findByName(row.get("Account Type")));
                        emailBody.setUserEmail(wrapUserEmailWithTestSession(row.get("UserEmail")));
                        emailBody.setDeadlineDate(DateTimeUtils.formatDate(DateTimeUtils.parseDate(row.get("Deadline Date"), getContext().userDateTimeFormat), "EEEE dd MMMM yyyy", Locale.UK));
                        emailBody.setClockNumber(clockNumber);
                        emailBody.setAdvertiser(wrapVariableWithTestSession(row.get("Advertiser")));
                        emailBody.setBrand(wrapVariableWithTestSession(row.get("Brand")));
                        emailBody.setSubBrand(wrapVariableWithTestSession(row.get("Sub Brand")));
                        emailBody.setProduct(wrapVariableWithTestSession(row.get("Product")));
                        emailBody.setTitle(wrapVariableWithTestSession(row.get("Title")));
                        emailBody.setFirstAirDate(DateTimeUtils.formatDate(DateTimeUtils.parseDate(row.get("First Air Date"), getContext().userDateTimeFormat), "dd MMMM yyyy", Locale.UK));
                        emailBody.setDuration(row.get("Duration"));
                        emailBody.setMessage(row.get("Message"));
                        emailBody.setDestination(row.get("Destination"));
                    }
                    break;
                case REMINDER_OF_MEDIA_UPLOAD_REQUEST:
                    if (shouldState) {
                        emailBody.setSubject(subject);
                        emailBody.setAccountType(AccountType.findByName(row.get("Account Type")));
                        emailBody.setReminderOfMediaUploadRequest(ReminderOfMediaUploadRequest.findByType(row.get("Reminder Of Media Upload Request Type")));
                        emailBody.setClockNumber(clockNumber);
                        emailBody.setCountry(row.get("Country"));
                        emailBody.setAdvertiser(wrapVariableWithTestSession(row.get("Advertiser")));
                        emailBody.setProduct(wrapVariableWithTestSession(row.get("Product")));
                        emailBody.setTitle(wrapVariableWithTestSession(row.get("Title")));
                        emailBody.setDuration(row.get("Duration"));
                        emailBody.setFormat(row.get("Format"));
                        emailBody.setMessage(row.get("Message"));
                        emailBody.setUploadDate(DateTimeUtils.formatDate(DateTimeUtils.parseDate(row.get("Deadline Date"), getContext().userDateTimeFormat), "MMM dd yyyy hh:mma", Locale.UK));
                        if (row.containsKey("First Air Date")) emailBody.setFirstAirDate(DateTimeUtils.formatDate(DateTimeUtils.parseDate(row.get("First Air Date"), getContext().userDateTimeFormat), "MMM dd yyyy hh:mma", Locale.UK));
                        if (row.containsKey("Type of Copy")) emailBody.setTypeOfCopy(row.get("Type of Copy"));
                        if (row.containsKey("Destinations")) emailBody.setDestination(row.get("Destinations"));
                    }
                    break;
                case SUBTITLES_REQUIRED: {
                    String orderReference = String.valueOf(getCoreApi().getOrderByItemClockNumber(clockNumber).getOrderReference());
                    String advertiser = wrapVariableWithTestSession(row.get("Advertiser"));
                    String product = wrapVariableWithTestSession(row.get("Product"));
                    subject = String.format("%s : %s %s %s %s", orderReference, advertiser, product, prepareSubtitlesRequiredEmailSubject(subject), "requires subtitling");
                    userTo = SubtitlesRequired.findByName(row.get("Subtitles Required")).getEmailTo();
                    if (shouldState){
                        emailBody.setSubject(subject);
                        emailBody.setUserFullName(getUserFullName(row.get("UserEmail")));
                        emailBody.setOrderReference(orderReference);
                        emailBody.setClockNumber(clockNumber);
                        emailBody.setAdvertiser(advertiser);
                        emailBody.setProduct(product);
                        emailBody.setTitle(wrapVariableWithTestSession(row.get("Title")));
                        emailBody.setSubtitlesRequired(SubtitlesRequired.findByName(row.get("Subtitles Required")).toString());
                        emailBody.setServiceLevel(ServiceLevelType.findByName(row.get("Service Level")).toString());
                        emailBody.setMessage(row.get("Message"));
                    }
                }
                break;
                case GENERICS_UPLOAD: {
                    String orderReference = String.valueOf(getCoreApi().getOrderByItemClockNumber(clockNumber).getOrderReference());
                    AccountType accountType = AccountType.findByName(row.get("Account Type"));
                    subject = accountType.equals(AccountType.BEAM_AMV)
                            ? String.format("%s %s%s %s", subject, getAgencyName(row.get("Agency")), ", clock number:", clockNumber)
                            : String.format("%s %s%s %s", subject, getAgencyName(row.get("Agency")), ",", clockNumber);
                    if (shouldState) {
                        if (row.containsKey("EmailFrom")) row.put("EmailFrom", wrapUserEmailWithTestSession(row.get("EmailFrom")));
                        emailBody.setSubject(subject);
                        emailBody.setAccountType(accountType);
                        emailBody.setOrderReference(orderReference);
                        emailBody.setClockNumber(clockNumber);
                    }
                }
                break;
                case ORDER_CONFIRMATION: {
                    Order order = getCoreApi().getOrderByItemClockNumber(clockNumber);
                    String orderReference = String.valueOf(order.getOrderReference());
                    AccountType accountType = AccountType.findByName(row.get("Account Type"));
//                    subject = accountType.equals(AccountType.BEAM)
//                              ? String.format("%s %s", "Confirmation - Order", prepareBeamOrderEmailSubject(subject, orderReference, row.get("Country")))
//                              : String.format("%s %s", subject, orderReference);
                    subject = String.format("%s %s", subject, orderReference);
                    if (shouldState) {
                        emailBody.setSubject(subject);
                        emailBody.setAccountType(accountType);
                        emailBody.setOrderReference(orderReference);
                        emailBody.setJobNumber(wrapVariableWithTestSession(row.get("Job Number")));
                        emailBody.setPoNumber(wrapVariableWithTestSession(row.get("PO Number")));
                        if (accountType.equals(AccountType.BEAM)) {
                            DateTime localOrderDateTimeSubmitted = order.getSubmitted().toDateTime(DateTimeZone.forTimeZone(TimeZone.getDefault()));
                            subject = String.format("%s-%s", subject, row.get("Country"));
                            emailBody.setClockNumber(clockNumber);
                            emailBody.setOrderItemsCount(row.get("Order Items Count"));
                            emailBody.setDateOrderSubmitted(DateTimeUtils.formatDate(localOrderDateTimeSubmitted, getCurrentUserDateFormat()));
                            emailBody.setCommercialNumber(row.get("Commercial Number"));
                            emailBody.setCountry(row.get("Country"));
                            manageAdvertiserStructureOfEmailBody(row, emailBody);
                            emailBody.setTitle(row.get("Title").contains(".") ? row.get("Title") : wrapVariableWithTestSession(row.get("Title"))); // original assets title contains dot and wrapping is not needed there
                            emailBody.setDuration(row.get("Duration"));
                            emailBody.setFormat(row.get("Format"));
                            emailBody.setDeliveryMethod(!row.containsKey("Delivery Method") ? "" : row.get("Delivery Method"));
                            emailBody.setDateArrivedCommercials(!row.containsKey("Deadline Date") || row.get("Deadline Date").isEmpty() ? ""
                                    : DateTimeUtils.formatDate(DateTimeUtils.parseDate(row.get("Deadline Date"), getContext().userDateTimeFormat), getCurrentUserDateFormat()));
                            emailBody.setTimeArrivedCommercials(!row.containsKey("Time Arrived") || row.get("Time Arrived").isEmpty() ? "" : row.get("Time Arrived"));
                            emailBody.setMasterHeldAt(!row.containsKey("Master Held At") || row.get("Master Held At").isEmpty() ? "" : wrapUserEmailWithTestSession(row.get("Master Held At")));
                            emailBody.setFirstAirDate(row.get("First Air Date").isEmpty() ? ""
                                    : DateTimeUtils.formatDate(DateTimeUtils.parseDate(row.get("First Air Date"), getContext().userDateTimeFormat), getCurrentUserDateFormat()));
                            emailBody.setArchive(row.get("Archive"));
                            emailBody.setMessage(row.get("Note"));
                            emailBody.setAttachments(!row.containsKey("Attachments") ? "" : row.get("Attachments"));
                            if (row.containsKey("Subtitles Required") && !row.get("Subtitles Required").isEmpty()) emailBody.setSubtitlesRequired(row.get("Subtitles Required"));
                            if (row.containsKey("Delivery Points")) emailBody.setDeliveryPoints(row.get("Delivery Points"));
                            if (row.containsKey("Suisa")) emailBody.setSuisa(wrapVariableWithTestSession(row.get("Suisa")));
                            if (row.containsKey("Language Metadata")) emailBody.setLanguageMetadata(row.get("Language Metadata"));
                            emailBody.setDestinationGroup(row.get("Destination Group"));
                            emailBody.setDestination(row.get("Destination"));
                            emailBody.setServiceLevel(prepareServiceLevelOfEmailBody(row.get("Service Level")));
                            emailBody.setAdditionalInstruction(!row.containsKey("Additional Instruction") ? "" : row.get("Additional Instruction"));
                            if (row.containsKey("Additional Service Type")) emailBody.setAdditionalServiceType(row.get("Additional Service Type"));
                            if (row.containsKey("Additional Service Destination")) emailBody.setAdditionalServiceDestination(wrapVariableWithTestSession(row.get("Additional Service Destination")));
                            if (row.containsKey("Notes & Labels")) emailBody.setNotesAndLabels(row.get("Notes & Labels"));
                            if (row.containsKey("Additional Service Format")) emailBody.setAdditionalServiceFormat(row.get("Additional Service Format"));
                            if (row.containsKey("No copies")) emailBody.setNoCopies(row.get("No copies"));
                            if (row.containsKey("Media Compile")) emailBody.setMediaCompile(row.get("Media Compile"));
                            if (row.containsKey("Additional Service Level")) emailBody.setAdditionalServiceLevel(row.get("Additional Service Level"));
                            if (row.containsKey("Additional Production Service Type")) emailBody.setProductionServiceType(row.get("Additional Production Service Type"));
                            if (row.containsKey("Additional Production Service Note")) emailBody.setProductionServiceNote(row.get("Additional Production Service Note"));
                        }
                    }
                }
                break;
                case TRANSFER_ORDER: {
                    Order order = getCoreApi().getOrderByItemClockNumber(clockNumber);
                    AccountType accountType = AccountType.findByName(row.get("Account Type"));
                    subject = accountType.equals(AccountType.BEAM)
                              ? String.format("%s %s %s", "Draft Order", prepareBeamOrderEmailSubject(subject, String.valueOf(order.getOrderReference()), row.get("Market")), "has been transferred to you")
                              : subject;
                    if (shouldState) {
                        emailBody.setSubject(subject);
                        emailBody.setAccountType(accountType);
                        emailBody.setUserFullName(getUserFullName(row.get("UserEmail")));
                        emailBody.setOrderReference(String.valueOf(order.getOrderReference()));
                        emailBody.setMessage(row.get("Message"));
                    }
                }
                break;
                case FAILED_ORDER_CONFIRMATION: {
                    String orderReference = String.valueOf(getCoreApi().getOrderByItemClockNumber(clockNumber).getOrderReference());
                    subject = String.format("%s %s", subject, orderReference);
                    userTo = "support@adstream.com";
                    if (shouldState) {
                        emailBody.setOrderReference(orderReference);
                        emailBody.setMessage(row.get("Message"));
                    }
                }
                break;
                case ORDER_DELIVERY_REPORT: {
                    String orderReference = String.valueOf(getCoreApi().getOrderByItemClockNumber(clockNumber).getOrderReference());
                    subject = subject.replace("Refnumber",orderReference);
                    if (shouldState) {
                        emailBody.setSubject(subject);
                        emailBody.setOrderReference(orderReference);
                        emailBody.setMessage(row.get("Message"));

                    }
                }
                break;
                case ORDER_INGESTION_COMPLETE_REPORT: {
                    String orderReference = String.valueOf(getCoreApi().getOrderByItemClockNumber(clockNumber).getOrderReference());
                    subject = subject.replace("Refnumber",orderReference);
                    if (shouldState) {
                        emailBody.setSubject(subject);
                        emailBody.setOrderReference(orderReference);
                        emailBody.setMessage(row.get("Message"));
                        emailBody.setJobNumber(wrapVariableWithTestSession(row.get("Job Number")));
                        emailBody.setPoNumber(wrapVariableWithTestSession(row.get("PO Number")));
                    }
                }
                break;
                case ADSTREAM_UPLOAD_REQUEST_FOR:
                    if (shouldState) {
                        emailBody.setSubject(subject+" "+wrapVariableWithTestSession(row.get("Advertiser"))+", "+wrapVariableWithTestSession(row.get("Product")));
                        emailBody.setAccountType(AccountType.findByName(row.get("Account Type")));
                        emailBody.setUserEmail(wrapUserEmailWithTestSession(row.get("UserEmail")));
                        emailBody.setDeadlineDate(DateTimeUtils.formatDate(DateTimeUtils.parseDate(row.get("Deadline Date"), getContext().userDateTimeFormat), "EEEE dd MMMM yyyy", Locale.UK));
                        emailBody.setUploadDate(DateTimeUtils.formatDate(DateTimeUtils.parseDate(row.get("Deadline Date"), getContext().userDateTimeFormat), "MMM dd yyyy hh:mma", Locale.UK));
                        emailBody.setClockNumber(clockNumber);
                        emailBody.setAdvertiser(wrapVariableWithTestSession(row.get("Advertiser")));
                        emailBody.setProduct(wrapVariableWithTestSession(row.get("Product")));
                        emailBody.setTitle(wrapVariableWithTestSession(row.get("Title")));
                        emailBody.setDuration(row.get("Duration"));
                        emailBody.setFormat(row.get("Format"));
                        emailBody.setMessage(row.get("Message"));
                        if (row.containsKey("First Air Date")) emailBody.setFirstAirDate(DateTimeUtils.formatDate(DateTimeUtils.parseDate(row.get("First Air Date"), getContext().userDateTimeFormat), "MMM dd yyyy", Locale.UK));
                        if (row.containsKey("Destinations")) emailBody.setDestination(row.get("Destinations"));
                    }
                    break;
                case TRAFFIC_PREVIEW_FILE_HAS_BEEN_APPROVED:
                    if (shouldState) {
                        subject = subject.replace("clockNumber",clockNumber);
                        emailBody.setSubject(subject);
                        emailBody.setMessage(row.get("Comment"));
                        emailBody.setClockNumber(wrapVariableWithTestSession(row.get("Clock Number")));
                        emailBody.setAdvertiser(wrapVariableWithTestSession(row.get("Advertiser")));
                        emailBody.setProduct(wrapVariableWithTestSession(row.get("Product")));
                        emailBody.setTitle(wrapVariableWithTestSession(row.get("Title")));
                        emailBody.setDuration(row.get("Duration"));
                        emailBody.setDestination(row.get("Destinations"));
                    }
                    break;
                case TRAFFIC_HAS_BEEN_RELEASED_FOR_DELIVERY:
                    if (shouldState) {
                        subject = subject.replace("clockNumber",clockNumber);
                        emailBody.setSubject(subject);
                        emailBody.setMessage(row.get("Comment"));
                        emailBody.setClockNumber(wrapVariableWithTestSession(row.get("Clock Number")));
                        emailBody.setAdvertiser(wrapVariableWithTestSession(row.get("Advertiser")));
                        emailBody.setProduct(wrapVariableWithTestSession(row.get("Product")));
                        emailBody.setTitle(wrapVariableWithTestSession(row.get("Title")));
                        emailBody.setDuration(row.get("Duration"));
                        emailBody.setDestination(row.get("Destinations"));
                    }
                    break;
                case TRAFFIC_HAS_BEEN_REJECTED:
                    if (shouldState) {
                        subject = subject.replace("clockNumber",clockNumber);
                        emailBody.setSubject(subject);
                        emailBody.setMessage(row.get("Comment"));
                        emailBody.setClockNumber(wrapVariableWithTestSession(row.get("Clock Number")));
                        emailBody.setAdvertiser(wrapVariableWithTestSession(row.get("Advertiser")));
                        emailBody.setProduct(wrapVariableWithTestSession(row.get("Product")));
                        emailBody.setTitle(wrapVariableWithTestSession(row.get("Title")));
                        emailBody.setDuration(row.get("Duration"));
                        emailBody.setDestination(row.get("Destinations"));
                    }
                    break;
                case TRAFFIC_MASTER_ESCALATION_HAS_BEEN_SUBMITTED:
                    if (shouldState) {
                        subject = subject.replace("clockNumber",clockNumber);
                        emailBody.setSubject(subject);
                        if (row.containsKey("Approval By")){
                            emailBody.setUserEmail(wrapUserEmailWithTestSession(row.get("Approval By")));}
                        emailBody.setMessage(row.get("Comment"));
                        emailBody.setClockNumber(wrapVariableWithTestSession(row.get("Clock Number")));
                        emailBody.setAdvertiser(wrapVariableWithTestSession(row.get("Advertiser")));
                        emailBody.setProduct(wrapVariableWithTestSession(row.get("Product")));
                        emailBody.setTitle(wrapVariableWithTestSession(row.get("Title")));
                        emailBody.setDuration(row.get("Duration"));
                        emailBody.setDestination(row.get("Destinations"));
                    }
                    break;
                case TRAFFIC_PREVIEW_FILE_HAS_BEEN_REJECTED:
                    if (shouldState) {
                        subject = subject.replace("clockNumber",clockNumber);
                        emailBody.setSubject(subject);
                        emailBody.setMessage(row.get("Comment"));
                        emailBody.setClockNumber(wrapVariableWithTestSession(row.get("Clock Number")));
                        emailBody.setAdvertiser(wrapVariableWithTestSession(row.get("Advertiser")));
                        emailBody.setProduct(wrapVariableWithTestSession(row.get("Product")));
                        emailBody.setTitle(wrapVariableWithTestSession(row.get("Title")));
                        emailBody.setDuration(row.get("Duration"));
                        emailBody.setDestination(row.get("Destinations"));
                    }
                    break;
                case TRAFFIC_PREVIEW_FILE_HAS_BEEN_RESTORED:
                    if (shouldState) {
                        subject = subject.replace("clockNumber",clockNumber);
                        emailBody.setSubject(subject);
                        emailBody.setMessage(row.get("Comment"));
                        emailBody.setClockNumber(wrapVariableWithTestSession(row.get("Clock Number")));
                        emailBody.setAdvertiser(wrapVariableWithTestSession(row.get("Advertiser")));
                        emailBody.setProduct(wrapVariableWithTestSession(row.get("Product")));
                        emailBody.setTitle(wrapVariableWithTestSession(row.get("Title")));
                        emailBody.setDuration(row.get("Duration"));
                        emailBody.setDestination(row.get("Destinations"));
                    }
                    break;
                case TRAFFIC_PREVIEW_FILE_HAS_BEEN_ESCALATED:
                    if (shouldState) {
                        subject = subject.replace("clockNumber",clockNumber);
                        emailBody.setSubject(subject);
                        emailBody.setUserEmail(wrapUserEmailWithTestSession(row.get("Approval By")));
                        emailBody.setMessage(row.get("Comment"));
                        emailBody.setClockNumber(wrapVariableWithTestSession(row.get("Clock Number")));
                        emailBody.setAdvertiser(wrapVariableWithTestSession(row.get("Advertiser")));
                        emailBody.setProduct(wrapVariableWithTestSession(row.get("Product")));
                        emailBody.setTitle(wrapVariableWithTestSession(row.get("Title")));
                        emailBody.setDuration(row.get("Duration"));
                        emailBody.setDestination(row.get("Destinations"));
                    }
                    break;
                case SENT_TO_ADPRO:
                    if (shouldState) {
                        subject = subject.replace("clockNumber",clockNumber.concat(".mov"));
                        emailBody.setSubject(subject);
                        emailBody.setUserEmail(userEmail);
                        emailBody.setLoggedInUser(getCoreApi().getLoggedUserEmail());
                        emailBody.setClockNumber(clockNumber);
                        emailBody.setMarket(row.get("Market"));
                        }
                    break;
                case FILE_MATCH_ACTIVITY:
                    if (shouldState) {
                        emailBody.setSubject(subject);
                        emailBody.setAgency(getCoreApi().getCurrentAgency().getName());
                        emailBody.setFileName(row.get("FileName"));
                    }
                    break;
            }

            if (!subject.isEmpty()) {
                emailMessage = getLastEmailMessageByHeaderAndSubject(Headers.TO, userTo, subject);
            } else {
                emailMessage = getLastEmailMessageByHeader(Headers.TO, userTo);
            }

            if (!shouldState) {
                assertThat(emailMessage, nullValue());
                return;
            } else if (emailMessage == null) {
                throw new IllegalStateException("User has not got any email on address " + userTo + " with subject " + subject);
            }

            if (row.get("EmailFrom") != null && !row.get("EmailFrom").isEmpty()) {
                String expectedEmail = row.get("EmailFrom");
                String actualEmail = emailMessage.getHeader().getFrom();
                assertThat(actualEmail, equalToIgnoringCase(expectedEmail));
            }
            if (row.get("EmailCC") != null && !row.get("EmailCC").isEmpty())
                assertThat("Check recipient_cc: ", emailMessage.getHeader().getRecipient_cc(), equalTo(prepareEmailCC(row.get("EmailCC"))));

            String message = parseEmailMessage(emailMessage);
            assertThat(emailMessage.getHeader().getSubject().trim(), containsString(emailBody.generateSubject()));


            List<String> checkStrTemp = emailBody.generateBody();

            for (String checkStr : checkStrTemp ) {
                assertThat(message, containsString(checkStr));
            }
//            int n = checkStrTemp.size();
//           int i =0;
//            do {
//                assertThat(message, containsString(checkStrTemp.get(i)));
//                i++;
//            } while(i<checkStrTemp.size());
            for (String checkStr: emailBody.generateLinks()) {
                assertThat(emailMessage.getBody().getHtml(), containsString(checkStr));
            }
        }
    }

    // Raja: 09-Nov-2015
    // | UserName | Agency | ProjectName | Message |
    @Then("{I |}'$condition' see email notifications for '$notificationType' with field to '$userEmail' and subject '$subject' contains following attributes: $attributeTable")
    public void checkEmailsForSpecialNotificationType(String condition, String notificationType, String userEmail, String subject, ExamplesTable attributeTable) {
        EmailBody emailBody = new EmailBody(notificationType);
        String userTo = wrapUserEmailWithTestSession(userEmail);
        boolean shouldState = condition.equalsIgnoreCase("should");
        EmailMessage emailMessage;

        for (Map<String, String> row : parametrizeTableRows(attributeTable)) {
            String userName = getUserFullName(row.get("UserName"));
            emailBody.setUserFullName(userName);

            if (row.get("EmailLanguage") == null) {
                User user = getCoreApiAdmin().getUserByEmail(wrapUserEmailWithTestSession(userEmail));
                emailBody.setLanguage(user == null ? "en-us" : user.getLanguage());
            } else {
                emailBody.setLanguage(row.get("EmailLanguage"));
            }

            if (row.get("Agency") != null && !row.get("Agency").isEmpty()) emailBody.setAgency(getAgencyName(row.get("Agency")));
            String clockNumber = prepareClockNumber(row.get("Clock Number"));

            switch (emailBody.getEmailType()) {
                case MEDIA_TRANSFER_REQUEST:
                    if (shouldState) {
                        emailBody.setSubject(subject);
                        emailBody.setAccountType(AccountType.findByName(row.get("Account Type")));
                        emailBody.setUserEmail(wrapUserEmailWithTestSession(row.get("UserEmail")));
                        emailBody.setDeadlineDate(DateTimeUtils.formatDate(DateTimeUtils.parseDate(row.get("Deadline Date"), getContext().userDateTimeFormat), row.get("SupplyVia").equalsIgnoreCase("FTP")?"M/dd/yyyy HH:mm:ss":"EEEE dd MMMM yyyy", Locale.UK));
                        emailBody.setUploadDate(DateTimeUtils.formatDate(DateTimeUtils.parseDate(row.get("Deadline Date"), getContext().userDateTimeFormat), "MMM dd yyyy hh:mma", Locale.UK));
                        emailBody.setClockNumber(clockNumber);
                        emailBody.setAdvertiser(wrapVariableWithTestSession(row.get("Advertiser")));
                        emailBody.setProduct(wrapVariableWithTestSession(row.get("Product")));
                        emailBody.setTitle(wrapVariableWithTestSession(row.get("Title")));
                        emailBody.setDuration(row.get("Duration"));
                        emailBody.setFormat(row.get("Format"));
                        emailBody.setMessage(row.get("Message"));
                        if (row.containsKey("First Air Date")) emailBody.setFirstAirDate(DateTimeUtils.formatDate(DateTimeUtils.parseDate(row.get("First Air Date"), getContext().userDateTimeFormat), "MMM dd yyyy", Locale.UK));
                        if (row.containsKey("Destinations")) emailBody.setDestination(row.get("Destinations"));
                    }
                    break;
                case ORDER_CONFIRMATION: {
                    Order order = getCoreApi().getOrderByItemClockNumber(clockNumber);
                    String orderReference = String.valueOf(order.getOrderReference());
                    AccountType accountType = AccountType.findByName(row.get("Account Type"));
//                    subject = accountType.equals(AccountType.BEAM)
//                              ? String.format("%s %s", "Confirmation - Order", prepareBeamOrderEmailSubject(subject, orderReference, row.get("Country")))
//                              : String.format("%s %s", subject, orderReference);
                    subject = String.format("%s %s", subject, orderReference);
                    if (shouldState) {
                        emailBody.setSubject(subject);
                        emailBody.setAccountType(accountType);
                        emailBody.setOrderReference(orderReference);
                        emailBody.setJobNumber(wrapVariableWithTestSession(row.get("Job Number")));
                        emailBody.setPoNumber(wrapVariableWithTestSession(row.get("PO Number")));
                        if (accountType.equals(AccountType.BEAM)) {
                            subject = String.format("%s %s-%s-%s-%s-%s-%s", subject, orderReference, row.get("Country"),wrapVariableWithTestSession(row.get("Advertiser")),wrapVariableWithTestSession(row.get("Brand")),wrapVariableWithTestSession(row.get("Sub Brand")),wrapVariableWithTestSession(row.get("Product")));
                            DateTime localOrderDateTimeSubmitted = order.getSubmitted().toDateTime(DateTimeZone.forTimeZone(TimeZone.getDefault()));
                            emailBody.setClockNumber(clockNumber);
                            emailBody.setOrderItemsCount(row.get("Order Items Count"));
                            emailBody.setDateOrderSubmitted(DateTimeUtils.formatDate(localOrderDateTimeSubmitted, getCurrentUserDateFormat()));
                            emailBody.setCommercialNumber(row.get("Commercial Number"));
                            emailBody.setCountry(row.get("Country"));
                            manageAdvertiserStructureOfEmailBody(row, emailBody);
                            emailBody.setTitle(row.get("Title").contains(".") ? row.get("Title") : wrapVariableWithTestSession(row.get("Title"))); // original assets title contains dot and wrapping is not needed there
                            emailBody.setDuration(row.get("Duration"));
                            emailBody.setFormat(row.get("Format"));
                            emailBody.setDeliveryMethod(!row.containsKey("Delivery Method") ? "" : row.get("Delivery Method"));
                            emailBody.setDateArrivedCommercials(!row.containsKey("Deadline Date") || row.get("Deadline Date").isEmpty() ? ""
                                    : DateTimeUtils.formatDate(DateTimeUtils.parseDate(row.get("Deadline Date"), getContext().userDateTimeFormat), getCurrentUserDateFormat()));
                            emailBody.setTimeArrivedCommercials(!row.containsKey("Time Arrived") || row.get("Time Arrived").isEmpty() ? "" : row.get("Time Arrived"));
                            emailBody.setMasterHeldAt(!row.containsKey("Master Held At") || row.get("Master Held At").isEmpty() ? "" : wrapUserEmailWithTestSession(row.get("Master Held At")));
                            emailBody.setFirstAirDate(row.get("First Air Date").isEmpty() ? ""
                                    : DateTimeUtils.formatDate(DateTimeUtils.parseDate(row.get("First Air Date"), getContext().userDateTimeFormat), getCurrentUserDateFormat()));
                            emailBody.setArchive(row.get("Archive"));
                            emailBody.setMessage(row.get("Note"));
                            emailBody.setAttachments(!row.containsKey("Attachments") ? "" : row.get("Attachments"));
                            if (row.containsKey("Subtitles Required") && !row.get("Subtitles Required").isEmpty()) emailBody.setSubtitlesRequired(row.get("Subtitles Required"));
                            if (row.containsKey("Delivery Points")) emailBody.setDeliveryPoints(row.get("Delivery Points"));
                            if (row.containsKey("Suisa")) emailBody.setSuisa(wrapVariableWithTestSession(row.get("Suisa")));
                            if (row.containsKey("Language Metadata")) emailBody.setLanguageMetadata(row.get("Language Metadata"));
                            emailBody.setDestinationGroup(row.get("Destination Group"));
                            emailBody.setDestination(row.get("Destination"));
                            emailBody.setServiceLevel(prepareServiceLevelOfEmailBody(row.get("Service Level")));
                            emailBody.setAdditionalInstruction(!row.containsKey("Additional Instruction") ? "" : row.get("Additional Instruction"));
                            if (row.containsKey("Additional Service Type")) emailBody.setAdditionalServiceType(row.get("Additional Service Type"));
                            if (row.containsKey("Additional Service Destination")) emailBody.setAdditionalServiceDestination(wrapVariableWithTestSession(row.get("Additional Service Destination")));
                            if (row.containsKey("Notes & Labels")) emailBody.setNotesAndLabels(row.get("Notes & Labels"));
                            if (row.containsKey("Additional Service Format")) emailBody.setAdditionalServiceFormat(row.get("Additional Service Format"));
                            if (row.containsKey("No copies")) emailBody.setNoCopies(row.get("No copies"));
                            if (row.containsKey("Media Compile")) emailBody.setMediaCompile(row.get("Media Compile"));
                            if (row.containsKey("Additional Service Level")) emailBody.setAdditionalServiceLevel(row.get("Additional Service Level"));
                            if (row.containsKey("Additional Production Service Type")) emailBody.setProductionServiceType(row.get("Additional Production Service Type"));
                            if (row.containsKey("Additional Production Service Note")) emailBody.setProductionServiceNote(row.get("Additional Production Service Note"));
                        }
                    }
                }
                break;
            }

            if (!subject.isEmpty()) {
                emailMessage = getLastEmailMessageByHeaderAndSubject(Headers.TO, userTo, subject);
            } else {
                emailMessage = getLastEmailMessageByHeader(Headers.TO, userTo);
            }

            if (!shouldState) {
                assertThat(emailMessage, nullValue());
                return;
            } else if (emailMessage == null) {
                throw new IllegalStateException("User has not got any email on address " + userTo + " with subject " + subject);
            }

            if (row.get("EmailFrom") != null && !row.get("EmailFrom").isEmpty()) {
                String expectedEmail = row.get("EmailFrom");
                String actualEmail = emailMessage.getHeader().getFrom();
                assertThat(actualEmail, equalToIgnoringCase(expectedEmail));
            }
            if (row.get("EmailCC") != null && !row.get("EmailCC").isEmpty())
                assertThat("Check recipient_cc: ", emailMessage.getHeader().getRecipient_cc(), equalTo(prepareEmailCC(row.get("EmailCC"))));

            String message_old = parseEmailMessage(emailMessage);
            String message=null;
            try { message = new String(message_old.getBytes("ISO-8859-1"), "UTF-8"); }
            catch (Exception e) {
                throw new UnknownFormatConversionException("Unable to convert the message to readable format "+message_old);
            }
            assertThat(emailMessage.getHeader().getSubject().trim(), containsString(emailBody.generateSubject()));

            for (String checkStr : emailBody.generateBody()) {
                assertThat(message, containsString(checkStr));
            }

            for (String checkStr: emailBody.generateLinks()) {
                assertThat(emailMessage.getBody().getHtml(), containsString(checkStr));
            }
        }
    }

    // Raja: 10-Nov-2015
    // | UserName | Agency | ProjectName | Message |
    @Then("{I |}'$condition' see emails notification for '$notificationType' with field to '$userEmail' and subject '$subject' contains following attributes: $attributeTable")
    public void checkEmailsForSpecialNotificationType_new(String condition, String notificationType, String userEmail, String subject, ExamplesTable attributeTable) {
        EmailBody emailBody = new EmailBody(notificationType);
        String userTo = wrapUserEmailWithTestSession(userEmail);
        boolean shouldState = condition.equalsIgnoreCase("should");
        EmailMessage emailMessage;

        for (Map<String, String> row : parametrizeTableRows(attributeTable)) {
            String userName = getUserFullName(row.get("UserName"));
            emailBody.setUserFullName(userName);

            if (row.get("EmailLanguage") == null) {
                User user = getCoreApiAdmin().getUserByEmail(wrapUserEmailWithTestSession(userEmail));
                emailBody.setLanguage(user == null ? "en-us" : user.getLanguage());
            } else {
                emailBody.setLanguage(row.get("EmailLanguage"));
            }

            if (row.get("Agency") != null && !row.get("Agency").isEmpty()) emailBody.setAgency(getAgencyName(row.get("Agency")));
            String clockNumber = prepareClockNumber(row.get("Clock Number"));

            switch (emailBody.getEmailType()) {
                case MEDIA_TRANSFER_REQUEST:
                    if (shouldState) {
                        emailBody.setSubject(subject);
                        emailBody.setAccountType(AccountType.findByName(row.get("Account Type")));
                        emailBody.setUserEmail(wrapUserEmailWithTestSession(row.get("UserEmail")));
                        emailBody.setDeadlineDate(DateTimeUtils.formatDate(DateTimeUtils.parseDate(row.get("Deadline Date"), getContext().userDateTimeFormat), "EEEE dd MMMM yyyy", Locale.UK));
                        emailBody.setUploadDate(DateTimeUtils.formatDate(DateTimeUtils.parseDate(row.get("Deadline Date"), getContext().userDateTimeFormat), "MMM dd yyyy hh:mma", Locale.UK));
                        emailBody.setClockNumber(clockNumber);
                        emailBody.setAdvertiser(wrapVariableWithTestSession(row.get("Advertiser")));
                        emailBody.setProduct(wrapVariableWithTestSession(row.get("Product")));
                        emailBody.setTitle(wrapVariableWithTestSession(row.get("Title")));
                        emailBody.setDuration(row.get("Duration"));
                        emailBody.setFormat(row.get("Format"));
                        emailBody.setMessage(row.get("Message"));
                        if (row.containsKey("First Air Date")) emailBody.setFirstAirDate(DateTimeUtils.formatDate(DateTimeUtils.parseDate(row.get("First Air Date"), getContext().userDateTimeFormat), "MMM dd yyyy", Locale.UK));
                        if (row.containsKey("Destinations")) emailBody.setDestination(row.get("Destinations"));
                    }
                    break;
            }

            if (!subject.isEmpty()) {
                emailMessage = getLastEmailMessageByHeaderAndSubject(Headers.TO, userTo, subject);
            } else {
                emailMessage = getLastEmailMessageByHeader(Headers.TO, userTo);
            }

            if (!shouldState) {
                assertThat(emailMessage, nullValue());
                return;
            } else if (emailMessage == null) {
                throw new IllegalStateException("User has not got any email on address " + userTo + " with subject " + subject);
            }

            if (row.get("EmailFrom") != null && !row.get("EmailFrom").isEmpty()) {
                String expectedEmail = row.get("EmailFrom");
                String actualEmail = emailMessage.getHeader().getFrom();
                assertThat(actualEmail, equalToIgnoringCase(expectedEmail));
            }
            if (row.get("EmailCC") != null && !row.get("EmailCC").isEmpty())
                assertThat("Check recipient_cc: ", emailMessage.getHeader().getRecipient_cc(), equalTo(prepareEmailCC(row.get("EmailCC"))));

            String message_old = parseEmailMessage(emailMessage);
            String message=null;
            try { message = new String(message_old.getBytes("ISO-8859-1"), "UTF-8"); }
            catch (Exception e) {
                throw new UnknownFormatConversionException("Unable to convert the message to readable format "+message_old);
            }
            assertThat(emailMessage.getHeader().getSubject().trim(), containsString(emailBody.generateSubject()));

            for (String checkStr : emailBody.generateBody_new()) {
                assertThat(message, containsString(checkStr));
            }

            for (String checkStr: emailBody.generateLinks()) {
                assertThat(emailMessage.getBody().getHtml(), containsString(checkStr));
            }
        }
    }

    @When("{I |}open link from reset passwords email and type generated password when user '$userTo' received email with next subject '$subject'")
    public void typeReceivedPassword(String userTo, String subject) {
        EmailMessage emailMessage = getLastEmailMessageByHeaderAndSubject(Headers.TO, wrapUserEmailWithTestSession(userTo), subject);
        assertThat("There is no last unread email with following subject: " + subject, emailMessage, notNullValue());
        String href = getLinkFromEmailMessage(emailMessage.getBody().getHtml());
        String textMessage = parseEmailMessage(emailMessage);
        String password = getPasswordFromEmailMessage(textMessage);
        getSut().getWebDriver().get(href);
        new LoginSteps().fillLoginPageFieldsThenLogin(userTo, password);
    }

    @When("{I |}open link from email with subject '$subject' that was send to user '$userTo' and type automatically generated password")
    public void typeGeneratedPassword(String subject, String userTo) {
        EmailMessage emailMessage = getLastEmailMessageByHeaderAndSubjectWithoutDelete(Headers.TO, wrapUserEmailWithTestSession(userTo), subject);
        assertThat("There is no last unread email with following subject: " + subject, emailMessage, notNullValue());
        assertThat("Check recipient to : ", emailMessage.getHeader().getRecipient_to(), equalTo(wrapUserEmailWithTestSession(userTo)));
        String href = getLinkFromEmailMessage(emailMessage.getBody().getHtml());
        String textMessage = parseEmailMessage(emailMessage);
        String password = getPasswordFromEmailMessage(textMessage);
        getSut().getWebDriver().get(href);
        new LoginSteps().loginToSystem(userTo, password);
    }

    @When("{I |}open link from email with shared {project|presentation} '$objectName' which user '$emailTo' received")
    public void openSharedProjectFromEmail(String objectName, String emailTo) {
        objectName = wrapVariableWithTestSession(objectName);
        emailTo = wrapUserEmailWithTestSession(emailTo);
        EmailMessage emailMessage = getLastEmailMessageByHeaderAndSubject(Headers.TO, emailTo, objectName);
        assertThat("Email message should be found", emailMessage, notNullValue());
        //String objectLink = parseLinkToObjectFromHtml(emailMessage.getBody().getHtml());
        String objectLink = getLinkFromEmailMessage(emailMessage.getBody().getHtml());
        if (objectLink == null) {
            throw new IllegalStateException("There are no link found");
        } else {
            getSut().getWebDriver().get(objectLink);
            Common.sleep(1000);
        }
    }

    @When("{I |}open link from email with subject '$subject' which user '$emailTo' received")
    public void openSharedObjectLinkFromEmail(String subject, String emailTo) {
        EmailMessage emailMessage = getLastEmailMessageByHeaderAndSubject(Headers.TO, wrapUserEmailWithTestSession(emailTo), subject);
        assertThat("Email message should be found", emailMessage, notNullValue());
        String link = getLinkFromEmailMessage(emailMessage.getBody().getHtml());
        assertThat("There are no link found", link, notNullValue());
        getSut().getWebDriver().get(link);
    }

    @Then("the user '$userTo' should receive Login details email and email '$should' contain password '$password'")
    public void checkLoginDetailsEmailPassword(String userTo, String should, String password) {
        Common.sleep(2000);
        String subject = "Your new Adbank login details";
        String userToEmail = wrapUserEmailWithTestSession(userTo);
        EmailMessage emailMessage = getLastEmailMessageByHeaderAndSubject(Headers.TO, userToEmail, subject);
        assertThat("There is no last unread email with following subject: " + subject, emailMessage, notNullValue());

        String message = parseEmailMessage(emailMessage);
        String passwordFromEmail = getPasswordFromEmailMessage(message);
        boolean shouldState = should.equalsIgnoreCase("should");
        assertThat("check password from email:",
                passwordFromEmail, shouldState ? equalTo(password) : not(equalTo(password)));
    }


    @Then("the user '$userTo' should received reset password's email with next subject '$subject'")
    public void checkReceivingResetPasswordsEmail(String userTo, String subject) {
        Common.sleep(2000);
        String userToEmail = wrapUserEmailWithTestSession(userTo);
        EmailMessage emailMessage = getLastEmailMessageByHeaderAndSubject(Headers.TO, userToEmail, subject);
        assertThat("User received an email", emailMessage, not(equalTo(null)));
    }

    @Then("the user '$userTo' should receiving reset password's email with next subject '$subject' and contains following action '$action'")
    public void checkResetPasswordsEmail(String userTo, String subject, String action) {
        Common.sleep(2000);
        EmailBody emailBody = new EmailBody(action);
        emailBody.getEmailType();
        EmailMessage emailMessage = getLastEmailMessageByHeaderAndSubject(Headers.TO, wrapUserEmailWithTestSession(userTo), subject);
        assertThat("There is no last unread email with following subject: " + subject, emailMessage, notNullValue());
        assertThat(emailMessage.getHeader().getSubject(), equalTo(emailBody.generateSubject()));

        String message = parseEmailMessage(emailMessage);

        for (String checkStr : emailBody.generateBody()) {
            assertThat(message, containsString(checkStr));
        }
    }

    @Then("I should see email with body appropriate to shared presentation '$presentationName' to user '$userName' from agency '$agency' with message '$message'")
    public void checkEmailForSharedPresentation(String presentationName, String userName, String agency, String message) {
        EmailMessage emailMessage = getLastEmailBySubject(wrapVariableWithTestSession(presentationName));
        String agencyName = getData().getAgencyByName(agency).getName();
        String fullUserName = getCoreApi().getUserByEmail(wrapUserEmailWithTestSession(userName)).getFullName();
        assertThat(emailMessage, notNullValue());
        String emailText = parseNotFormattedTextFromHtml(emailMessage.getBody().getHtml());
        assertThat(emailText, containsString("Dear ".concat(fullUserName)));
        assertThat(emailText, containsString("admin agency from organisation ".concat(agencyName).concat(" has shared")));
        assertThat(emailText, containsString(wrapVariableWithTestSession(presentationName)));
        assertThat(emailText, containsString(message));
    }

    @Then("{I |}'$condition' see {any other|some} mails with subject '$subject' to user '$userName'")
    public void checkEmailPresent(String condition, String subject, String userName) {
        Common.sleep(10000);
        boolean shouldState = condition.equalsIgnoreCase("should");
        EmailMessage emailMessage = getLastEmailMessageByHeaderAndSubject(Headers.TO, wrapUserEmailWithTestSession(userName), subject);

        assertThat(emailMessage, shouldState ? notNullValue() : nullValue());
    }

    @Then("I should see email with body appropriate to shared presentation '$presentationName' to easyshare user from agency '$agency' with message '$message'")
    public void checkEmailForSharedPresentation(String presentationName, String agency, String message) {
        EmailMessage emailMessage = getLastEmailBySubject(wrapVariableWithTestSession(presentationName));
        String agencyName = getData().getAgencyByName(agency).getName();
        assertThat(emailMessage, notNullValue());
        String emailText = parseNotFormattedTextFromHtml(emailMessage.getBody().getHtml());
        assertThat(emailText, containsString("admin agency from organisation ".concat(agencyName).concat(" has shared")));
        assertThat(emailText, containsString(wrapVariableWithTestSession(presentationName)));
        assertThat(emailText, containsString(message));
    }

    @Then("{I |}'$condition' see user '$emailTo' received the email from user '$emailFrom' with shared presentation '$presentationName' and message '$message'")
    public void checkEmailAboutSharingPresentation(String condition, String emailTo, String emailFrom, String presentationName, String message) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        User sender = getCoreApiAdmin().getUserByEmail(wrapUserEmailWithTestSession(emailFrom));
        Reel presentation = getCoreApiAdmin().getReelByName(wrapVariableWithTestSession(presentationName));
        EmailMessage emailMessage = getLastEmailMessageByHeaderAndSubject(Headers.TO, wrapUserEmailWithTestSession(emailTo), presentation.getName());

        if (shouldState) {
            assertThat(emailMessage, notNullValue());
            assertThat(parseLinkToObjectFromHtml(emailMessage.getBody().getHtml(), presentation), notNullValue());

            String expectedMessage = String.format("User %s from organisation %s has shared Presentation %s with you %s",
                    sender.getFullName(),
                    sender.getAgency().getName(),
                    presentation.getName(),
                    message);

            assertThat(parseNotFormattedTextFromHtml(emailMessage.getBody().getHtml()), containsString(expectedMessage));
        } else {
            assertThat(emailMessage, nullValue());
        }
    }

    @Then("{I |}'$condition' see user '$emailTo' has the email about sharing '$presentationName' presentation by '$senderEmail' to '$recipientEmail'")
    public void checkEmailAboutSharingPresentationByAnotherUser(String condition, String emailTo, String presentationName, String senderEmail, String recipientEmail) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        User recipient = getCoreApiAdmin().getUserByEmail(wrapUserEmailWithTestSession(emailTo));
        Reel presentation = getCoreApiAdmin().getReelByName(wrapVariableWithTestSession(presentationName));

        EmailMessage emailMessage = getLastEmailMessageByHeaderAndSubject(Headers.TO, recipient.getEmail(), presentation.getName());

        if (shouldState) {
            assertThat(emailMessage, notNullValue());
            assertThat(parseLinkToObjectFromHtml(emailMessage.getBody().getHtml(), presentation), notNullValue());

            User reelSender = getCoreApiAdmin().getUserByEmail(wrapUserEmailWithTestSession(senderEmail));
            User reelRecipient = getCoreApiAdmin().getUserByEmail(wrapUserEmailWithTestSession(recipientEmail));
            String reelRecipientName = wrapUserEmailWithTestSession(recipientEmail);

            if (reelRecipient != null && reelRecipient.getFullName() != null && reelRecipient.getAgency() != null && reelRecipient.getAgency().getName() != null)
                reelRecipientName = String.format("%s from %s", reelRecipient.getFullName(), reelRecipient.getAgency().getName());

            String expectedMessage = String.format("Dear %s, User %s from organisation %s has shared Presentation %s with %s",
                    recipient.getFullName(),
                    reelSender.getFullName(),
                    reelSender.getAgency().getName(),
                    presentation.getName(),
                    reelRecipientName);

            assertThat(parseNotFormattedTextFromHtml(emailMessage.getBody().getHtml()), containsString(expectedMessage));
        } else {
            assertThat(emailMessage, nullValue());
        }
    }

    @Then("{I |}'$condition' see that user '$emailTo' has received the email that '$presentationName' presentation has been downloaded by '$emailDownloaded' user")
    public void checkEmailAboutPresentationDownloading(String condition, String emailTo, String presentationName, String emailDownloaded) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        User recipient = getCoreApiAdmin().getUserByEmail(wrapUserEmailWithTestSession(emailTo));
        Reel presentation = getCoreApiAdmin().getReelByName(wrapVariableWithTestSession(presentationName));
        EmailMessage emailMessage = getLastEmailMessageByHeaderAndSubject(Headers.TO, recipient.getEmail(), presentation.getName());

        if (shouldState) {
            assertThat(emailMessage, notNullValue());

            String expectedMessage = String.format("Dear %s, %s has downloaded your presentation %s",
                    recipient.getFullName(),
                    wrapUserEmailWithTestSession(emailDownloaded),
                    presentation.getName());

            assertThat(parseNotFormattedTextFromHtml(emailMessage.getBody().getHtml()), containsString(expectedMessage));
        } else {
            assertThat(emailMessage, nullValue());
        }
    }

    @Then("{I |}'$condition' see that user '$emailTo' has received the email that '$presentationName' presentation has been viewed by '$viewerEmail' user")
    public void checkEmailAboutPresentationViewing(String condition, String emailTo, String presentationName, String viewerEmail) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        User recipient = getCoreApiAdmin().getUserByEmail(wrapUserEmailWithTestSession(emailTo));
        Reel presentation = getCoreApiAdmin().getReelByName(wrapVariableWithTestSession(presentationName));
        EmailMessage emailMessage = getLastEmailMessageByHeaderAndSubject(Headers.TO, recipient.getEmail(), presentation.getName());

        if (shouldState) {
            assertThat(emailMessage, notNullValue());

            User viewer = getCoreApiAdmin().getUserByEmail(wrapUserEmailWithTestSession(viewerEmail));
            String viewerName = wrapUserEmailWithTestSession(viewerEmail);

            if (viewer != null && viewer.getFullName() != null && viewer.getAgency() != null && viewer.getAgency().getName() != null)
                viewerName = String.format("%s from organisation %s", viewer.getFullName(), viewer.getAgency().getName());

            String expectedMessage = String.format("Presentation - %s has been viewed by user %s", presentation.getName(), viewerName);

            assertThat(parseNotFormattedTextFromHtml(emailMessage.getBody().getHtml()), containsString(expectedMessage));
        } else {
            assertThat(emailMessage, nullValue());
        }
    }

    @Then("I '$condition' see email where body contains email '$userName'")
    public void checkEmailWhereBodyContainsEmail(String condition, String userName) {
        String userTo = wrapUserEmailWithTestSession(userName);
        boolean shouldState = condition.equalsIgnoreCase("should");
        EmailMessage emailMessage = getLastEmailMessageByBody(userTo);
        assertThat(emailMessage, shouldState ? notNullValue() : nullValue());

    }

    @Then("{I |} '$condition' see that user '$userTo' received email for category update '$categoryName' with interval")
    public void checkThatUserReceivedEmailForCategoryUpdate(String condition, String userTo, String categoryName) {
        boolean shouldState  = condition.equals("should");
        Common.sleep(30000);
        String userToEmail = wrapUserEmailWithTestSession(userTo);
       categoryName = wrapVariableWithTestSession(categoryName);
        EmailMessage emailMessage;
        String message = "";
        try {
            emailMessage = getLastEmailMessageByHeader(Headers.TO, userToEmail);
            message = parseEmailMessage(emailMessage);
        }
        catch(NullPointerException e) {
            Common.sleep(120000);
            emailMessage = getLastEmailMessageByHeader(Headers.TO, userToEmail);
        }
        if(shouldState) {
            message = parseEmailMessage(emailMessage);
             assertThat("Email not received with this subject", message, containsString("New assets in Collection "+categoryName
            ));
        }
        if (!shouldState) {
            assertThat(emailMessage, nullValue());
        }
    }

    // | AgencyName |
    @Then("I should see email with body appropriate to invited in the new version of Adbank to user '$userName' with body according to: $attributeTable")
    public void checkEmailForInvitedInTheNewVersionOfAdbank(String userName, ExamplesTable attributeTable) {
        Common.sleep(5000);
        String userToEmail = wrapUserEmailWithTestSession(userName);
        EmailMessage emailMessage = getLastEmailBySubject("You have been invited to the new version of Adbank");
        assertThat(emailMessage, notNullValue());
        assertThat("Check recipient to : ", emailMessage.getHeader().getRecipient_to(), equalTo(userToEmail));
        String formattedText = parseEmailMessage(emailMessage);
        for (int i = 0 ; i < attributeTable.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(attributeTable, i);
            assertThat(formattedText, containsString("Dear Sir or Madam,"));
            assertThat(formattedText, containsString(String.format("You have been invited to the new version of %s Adbank.", getData().getAgencyByName(row.get("AgencyName")).getName())));
            assertThat(formattedText, containsString(String.format("Click the link to log in: %s/login", TestsContext.getInstance().applicationUrl)));
            assertThat(formattedText, containsString("Use your Adbank 4 login and password to access the system."));
        }
    }

    @Then("{I |}'$condition' see that user '$email' has received email with presentation name in subject '$presentationName'")
    public void checkThatRecipientReceivedEmail(String condition, String email, String presentationName) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        String recipientEmail = wrapUserEmailWithTestSession(email);
        String subjectSubstring = wrapVariableWithTestSession(presentationName);
        EmailMessage emailMessage = getLastEmailMessageByHeaderAndSubject(Headers.TO, recipientEmail, subjectSubstring);

        assertThat(emailMessage, shouldState ? notNullValue() : nullValue());
    }

    @Then("{I |}'$condition' see that user '$userTo' received email with subject '$subject' and password generated according to agency '$agency' password rules")
    public void checkThatUserPasswordCorrespondedToAgencyPasswordRules(String condition, String userTo, String subject, Agency agency) {
        String expectedString = "You have requested to reset your Adbank password";
        String userToEmail = wrapUserEmailWithTestSession(userTo);
        EmailMessage emailMessage = getLastEmailMessageByHeaderAndSubject(Headers.TO, userToEmail, subject);
        assertThat(emailMessage.getBody().getHtml(),containsString(expectedString));
    }

    @Then("{I |} '$condition' see that user '$userTo' received email for asset '$assetName' and usage right '$usageRight' for Usage Expiry rights for days '$days' with interval")
    public void checkThatUserReceivedEmailForUsageRightsExpiry(String condition, String userTo, String assetName, String usageRight, String days) {
        boolean shouldState  = condition.equals("should");
        Common.sleep(30000);
        String userToEmail = wrapUserEmailWithTestSession(userTo);
        EmailMessage emailMessage;
        String message = "";
        try {
            emailMessage = getLastEmailMessageByHeader(Headers.TO, userToEmail);
            message = parseEmailMessage(emailMessage);
        }
        catch(NullPointerException e) {
            Common.sleep(120000);
            emailMessage = getLastEmailMessageByHeader(Headers.TO, userToEmail);
        }
        if(shouldState) {
            message = parseEmailMessage(emailMessage);
           // assertThat("Incorrect Email subject", message, containsString("Usage rights on "+assetName+" are about to expire in "+days+" days:"));
            assertThat("Incorrect Email subject", message, containsString("Usage rights are about to expire on "+assetName));

            assertThat("Usage right type not as expected", message, containsString(usageRight));
        }
        else if (!shouldState && emailMessage == null) {
            assertThat("Email has been received", emailMessage, nullValue());
        }
        else {
            message = parseEmailMessage(emailMessage);
            assertThat("Usage right type not as expected", message, not(containsString(usageRight)));
        }
    }

    private String parseNotFormattedTextFromHtml(String html) {
        return html.replaceAll("([#\\.\\w\\d\\s]+\\{[^\\}]*\\}|<[^>]+>)", "").replaceAll("\\s+", " ");
    }

    private String parseLinkToObjectFromHtml(String html, BaseObject object) {
        String linkRegExp = String.format("href.*?['\\\"](.+?%s.*?)['\\\"].*?%s", object.getId(), object.getName());
        Matcher matcher = Pattern.compile(linkRegExp, Pattern.CASE_INSENSITIVE).matcher(html);
        return matcher.find() ? matcher.group(1).replace("&amp;", "&").replace("%2F", "/").replace("%23", "#") : null;
    }

    public String getLinkFromEmailMessage(String emailMessage) {
        Pattern p = Pattern.compile("href=(['\"])(.+?)\\1");
        Matcher m = p.matcher(emailMessage);
        String href = null;
        if (m.find()) {
            href = m.group(2);
        }
        if (href != null && !href.isEmpty()) {
            if (href.contains("&amp;")) href = href.replace("&amp;", "&");
            if (href.contains("%2F"))   href = href.replace("%2F",   "/");
        } else {
            throw new NullPointerException("There is no any link in email message!");
        }
        try {
            // due to NGN-14162. sometimes mail service cut dot in hostname.
            // replace potentially broken hostname with value from config
            URL url = new URL(href);
            return href.replace(url.getProtocol(), getContext().applicationUrl.getProtocol())
                       .replace(url.getHost(), getContext().applicationUrl.getHost());
        } catch (MalformedURLException e) {
            e.printStackTrace();
            return href;
        }
    }

    public String getLinkFromEmailMessageWithoutReplacingProtocol(String emailMessage) {
        Pattern p = Pattern.compile("href=(['\"])(.+?)\\1");
        Matcher m = p.matcher(emailMessage);
        String href = null;
        if (m.find()) {
            href = m.group(2);
        }
        if (href != null && !href.isEmpty()) {
            if (href.contains("&amp;")) href = href.replace("&amp;", "&");
            if (href.contains("%2F"))   href = href.replace("%2F",   "/");
        } else {
            throw new NullPointerException("There is no any link in email message!");
        }
        try {
            // due to NGN-14162. sometimes mail service cut dot in hostname.
            // replace potentially broken hostname with value from config
            URL url = new URL(href);
            return href;
        } catch (MalformedURLException e) {
            e.printStackTrace();
            return href;
        }
    }

    public String getPasswordFromEmailMessage(String emailMessage) {
        Pattern p = Pattern.compile("created for you: *([^\r\n ]+)");
        Matcher m = p.matcher(emailMessage);
        String password = null;
        if (m.find()) {
            password = m.group(1);
        }
        if (password != null && !password.isEmpty()) {
            return password;
        }
        throw new NullPointerException("There is no password in email message!");
    }

    protected EmailMessage getLastEmailBySubject(String subject) {
        Long start = System.currentTimeMillis();
        EmailMessage emailMessage;
        do {
            emailMessage = getMailClient().getLastUnreadMailBySubject(subject);
            if (emailMessage == null)
                Common.sleep(10000);
        } while (emailMessage == null && System.currentTimeMillis() - start < 120000);
        return emailMessage;
    }

    protected EmailMessage getLastEmailBySubjectWithoutDeleting(String subject) {
        Long start = System.currentTimeMillis();
        EmailMessage emailMessage;
        do {
            emailMessage = getMailClient().getLastUnreadMailBySubjectWithoutDeleting(subject);
            if (emailMessage == null)
                Common.sleep(10000);
        } while (emailMessage == null && System.currentTimeMillis() - start < 120000);
        return emailMessage;
    }

    private EmailMessage getLastEmailMessageByBody(String body) {
        return getMailClient().getLastUnreadMailByBody(body);
    }

    private EmailMessage getLastEmailMessageByHeader(Headers header, String headerValue) {
        return getMailClient().getLastUnreadMailByHeader(header.toString(), headerValue);
    }

    private EmailMessage getLastEmailMessageByHeaderSubjectAndBody(
            Headers header, String headerValue, String subject, String body,boolean condition){
        return getLastEmailMessageByHeaderSubjectAndBody(header, headerValue, subject, body, condition ? getDefaultTimeout() : 15000);
    }

    public List<EmailMessage> getEmailsMessageByHeaderAndSubject(Headers header, String headerValue, String subject) {
        return getEmailsMessageByHeaderAndSubject(header, headerValue, subject, getDefaultTimeout(), true);
    }

    public List<EmailMessage> getEmailsMessageByHeaderAndSubjectWithoutDelete(Headers header, String headerValue, String subject) {
        return getEmailsMessageByHeaderAndSubject(header, headerValue, subject, getDefaultTimeout(), false);
    }

    public EmailMessage getLastEmailMessageByHeaderAndSubject(Headers header, String headerValue, String subject) {
        return getLastEmailMessageByHeaderAndSubject(header, headerValue, subject, getDefaultTimeout(), true);
    }

    public EmailMessage getLastEmailMessageByHeaderAndSubjectWithoutDelete(Headers header, String headerValue, String subject) {
        return getLastEmailMessageByHeaderAndSubject(header, headerValue, subject, getDefaultTimeout(), false);
    }

    private EmailMessage getLastEmailMessageByHeaderAndSubject(Headers header, String headerValue, String subject, long timeout, boolean willDeleted) {
        EmailMessage message;
        long start = System.currentTimeMillis();
        do {
            message = willDeleted ? getMailClient().getLastUnreadMailByHeaderAndSubject(header.toString(), headerValue, subject)
                                  : getMailClient().getLastUnreadMailBySubjectWithoutDeleting(header.toString(), headerValue, subject);
            if (message == null && timeout > 0) {
                Common.sleep(5000);
            }
        } while (message == null && System.currentTimeMillis() - start < timeout);
        return message;
    }

    private List<EmailMessage> getEmailsMessageByHeaderAndSubject(Headers header, String headerValue, String subject, long timeout, boolean willDeleted) {
        List<EmailMessage> message;
        long start = System.currentTimeMillis();
        do {
            message = willDeleted ? getMailClient().getUnreadMailsByHeaderAndSubject(header.toString(), headerValue, subject)
                    : getMailClient().getUnreadMailsBySubjectWithoutDeleting(header.toString(), headerValue, subject);
            if ((message == null || message.size() == 0) && timeout > 0) {
                Common.sleep(5000);
            }
        } while ((message == null || message.size() == 0) && System.currentTimeMillis() - start < timeout);
        return message;
    }

    private EmailMessage getLastEmailMessageByHeaderSubjectAndBody(Headers header, String headerValue, String subject, String body, long timeout) {
        EmailMessage message;
        long start = System.currentTimeMillis();
        do {
            message = getMailClient().getLastUnreadMailByHeaderSubjectAndBody(header.toString(), headerValue, subject, body);
            if (message == null && timeout > 0) {
                Common.sleep(5000);
            }
        } while (message == null && System.currentTimeMillis() - start < timeout);
        return message;
    }

    public String parseEmailMessage(EmailMessage emailMessage) {
        return emailMessage.getBody().getHtml()
                .replace("\r\n", " ")
                .replaceAll("<style>.+</style>", "")
                .replace("<br>", "\r\n")
                .replaceAll("\r\n(\r\n)+", "\r\n")
                .replaceAll("<[^>]+>", "")
                .replace("\t", " ")
                .replaceAll("  +", " ")
                .replaceAll("&nbsp;", " ")
                .replaceAll("&amp;", "&")
                .replaceAll("&#10003;", "✓")
                .trim();
    }

    public String getUserFullName(String userName) {
        String userFullName;

        if (userName == null || userName.isEmpty()) {
            userFullName = getData().getCurrentUser().getFullName();
        } else {
            User user = getCoreApiAdmin().getUserByEmail(wrapUserEmailWithTestSession(userName));

            if (user == null || user.getFullName() == null) {
                userFullName = wrapUserEmailWithTestSession(userName);
            } else {
                userFullName = user.getFullName();
            }
        }

        return userFullName;
    }

    public User getUserDetails(String userName){
        String email = wrapUserEmailWithTestSession(userName);
        return getCoreApiAdmin().getUserByEmail(email);
    }

    private long getDefaultTimeout() {
        if (getContext().isOrdering) {
            return 300000;
        } else if (getContext().useFakeEmailService) {
            return 30000;
        } else {
            return 120000;
        }
    }

    private String getAgencyName(String agencyName) {
        if (agencyName == null || agencyName.isEmpty()) return null;
        if (getData().getAgencyByName(agencyName) != null ) {
            agencyName = getData().getAgencyByName(agencyName).getName();
        } else {
            agencyName = getData().getAgencyByName(wrapVariableWithTestSession(agencyName)).getName();
        }
        return agencyName;
    }

    private String prepareClockNumber(String clockNumber) {
        return clockNumber != null && !clockNumber.isEmpty() ? wrapVariableWithTestSession(clockNumber) : "";
    }

    private String prepareEmailCC(String emailCC) {
        String[] emailCCParts = emailCC.split(",");
        StrBuilder sb = new StrBuilder();
        for (int i = 0; i < emailCCParts.length; i++) {
            sb.append(wrapUserEmailWithTestSession(emailCCParts[i]));
            if (i != emailCCParts.length - 1) sb.append(",");
        }
        return sb.toString();
    }

    // given subject with advertiser hierarchy list separated by hyphen
    private String prepareBeamOrderEmailSubject(String subject, String orderReference, String market) {
        StrBuilder sb = new StrBuilder(String.format("%s%s%s%s", orderReference, "-", market, "-"));
        String[] subjectParts = subject.split("-");
        for (int i = 0; i < subjectParts.length; i++) {
            sb.append(subjectParts[i].equalsIgnoreCase("various") ? subjectParts[i] : wrapVariableWithTestSession(subjectParts[i]));
            if (i != subjectParts.length - 1) sb.append("-");
        }
        return sb.toString();
    }

    // given subject with clock numbers list separated by comma
    private String prepareSubtitlesRequiredEmailSubject(String subject) {
        StrBuilder sb = new StrBuilder();
        String[] subjectParts = subject.split(",");
        for (int i = 0; i < subjectParts.length; i++) {
            sb.append(wrapVariableWithTestSession(subjectParts[i]));
            if (i != subjectParts.length - 1) sb.append(", ");
        }
        return sb.toString();
    }

    private String prepareServiceLevelOfEmailBody(String serviceLevel) {
        StrBuilder sb = new StrBuilder();
        String[] serviceLevelParts = serviceLevel.split(",");
        for (int i = 0; i < serviceLevelParts.length; i++) {
            sb.append(ServiceLevelType.findByName(serviceLevelParts[i]).toString());
            if (i != serviceLevelParts.length - 1) sb.append(" ");
        }
        return sb.toString();
    }

    // advertiser structure may has some custom labels
    private void manageAdvertiserStructureOfEmailBody(Map<String, String> row, EmailBody emailBody) {
        for (String key: row.keySet()) {
            if (key.startsWith("Advertiser")) {
                emailBody.setAdvertiserDescription(key);
                emailBody.setAdvertiser(wrapVariableWithTestSession(row.get(key)));
            }
            if (key.startsWith("Brand")) {
                emailBody.setBrandDescription(key);
                emailBody.setBrand(wrapVariableWithTestSession(row.get(key)));
            }
            if (key.startsWith("Sub Brand")) {
                emailBody.setSubBrandDescription(key);
                emailBody.setSubBrand(wrapVariableWithTestSession(row.get(key)));
            }
            if (key.startsWith("Product")) {
                emailBody.setProductDescription(key);
                emailBody.setProduct(wrapVariableWithTestSession(row.get(key)));
            }
            if (key.startsWith("Campaign")) {
                emailBody.setCampaignDescription(key);
                emailBody.setCampaign(wrapVariableWithTestSession(row.get(key)));
            }
        }
    }

    private String formatDateForApproval(String senderEmail, String receiverEmail, DateTime dateTime) {
        User user = getCoreApi().getUserByEmail(receiverEmail);
        if (user==null || !user.isRegistered()) {
            user = getCoreApi().getUserByEmail(senderEmail);
        }
        return DateTimeFormat.forPattern(user.getDateTimeFormatter().getApprovalEmailDateFormat())
                .withLocale(user.getDateTimeFormatter().getLocale())
                .print(dateTime);
    }

    private String getApproverFormat_Cyclone(String userEmail, String approverRole){
        User userDetails = getUserDetails(userEmail);
        switch (approverRole){
            case "Integrated Production Manager":
                return String.format("%s (IPM)",userDetails.getFullName());
            case "Cost Consultant":
                return String.format("%s (CC)",userDetails.getFullName());
            case "Brand Management Approver":
                return String.format("%s (Brand)",userDetails.getFullName());
        }
        return null;
    }

    private String getApproverFormat_NonCyclone(String userEmail, String approverRole){
        User userDetails = getUserDetails(userEmail);
        switch (approverRole){
            case "Integrated Production Manager":
                return String.format("%s (IPM)",userDetails.getFullName());
            case "Cost Consultant":
                return String.format("%s (CC)",userDetails.getFullName());
            case "Brand Management Approver":
                return String.format("%s (Brand Management Approver)",userDetails.getFullName());
        }
        return null;
    }

    private String getApproverFormatForBody(String userEmail, String approverRole){
        User userDetails = getUserDetails(userEmail);
        switch (approverRole){
            case "Integrated Production Manager":
                return String.format("%s - IPM",userDetails.getFullName());
            case "Cost Consultant":
                return String.format("%s - CC",userDetails.getFullName());
            case "Brand Management Approver":
                return String.format("%s - Brand Management Approver",userDetails.getFullName());
        }
        return null;
    }

    private String getApproverFormat_FMUser(String userEmail, String approverRole){
        User userDetails = getUserDetails(userEmail);
        switch (approverRole){
            case "Integrated Production Manager":
                return ("(IPM)");
            case "Cost Consultant":
                return ("(CC)");
            case "Brand Management Approver":
                return ("(Brand)");
        }
        return null;
    }

    private String getUserFullDetails(String user){
        User costOwner= getData().getUserByType(user);
        if(user!=null)
            return costOwner.getFullName();
        else {
            return getUserDetails(user).getFullName();
        }
    }
}