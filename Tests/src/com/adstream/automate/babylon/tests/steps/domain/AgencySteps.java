package com.adstream.automate.babylon.tests.steps.domain;

import com.adstream.automate.babylon.JsonObjects.Agency;
import com.adstream.automate.babylon.JsonObjects.ApplicationAccess;
import com.adstream.automate.babylon.JsonObjects.CustomMetadata;
import com.adstream.automate.babylon.JsonObjects.dictionary.DictionaryItem;
import com.adstream.automate.babylon.JsonObjects.dictionary.DictionaryType;
import com.adstream.automate.babylon.JsonObjects.dictionary.DictionaryValues;
import com.adstream.automate.babylon.JsonObjects.ordering.OrderingSettings;
import com.adstream.automate.babylon.JsonObjects.schema.Schema;
import com.adstream.automate.babylon.TestsContext;
import com.adstream.automate.babylon.data.CustomMetadataSchemaName;
import com.adstream.automate.babylon.data.Logo;
import com.adstream.automate.babylon.JsonObjects.ordering.enums.CustomMetadataField;
import com.adstream.automate.babylon.tests.steps.core.BaseStep;
import org.apache.commons.lang.ArrayUtils;
import org.jbehave.core.annotations.Given;
import org.jbehave.core.annotations.Then;
import org.jbehave.core.annotations.When;
import org.jbehave.core.model.ExamplesTable;
import org.joda.time.DateTime;
import scala.runtime.StringAdd;

import java.util.*;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.hasItem;
import static org.hamcrest.Matchers.hasItems;

/**
 * Created with IntelliJ IDEA.
 * User: savitskiy-a
 * Date: 30.07.12
 * Time: 22:06
 */
public class AgencySteps extends BaseStep {

    @Given("{I |}created the agency '$agencyName' with default attributes")
    public void createAgencyWithDefaultAttributesForA5(String agencyName) {
        Agency agency = getAgencyByName(agencyName);
        if (agency == null) {
            Agency newDesiredAgency = new Agency();

            newDesiredAgency.setName(wrapVariableWithTestSession(agencyName));
            newDesiredAgency.setDescription("test agency");
            newDesiredAgency.setPin("1");
            newDesiredAgency.setAgencyType("Advertiser");
            newDesiredAgency.setSubtype("agency");
            newDesiredAgency.setCountry("AF");
            newDesiredAgency.setLabels(new String[]{"QA"});
            newDesiredAgency.setTimeZone("Europe-Andorra");
            newDesiredAgency.setStorageId(getCurrentThreadStorageId());
            newDesiredAgency.setCreateAssetInA4(false);
            newDesiredAgency.setSharingSettingsEnrichDictionary(true);
            newDesiredAgency.setFullAccess();
            newDesiredAgency.setA4User(getContext().a4DefaultUser);
            newDesiredAgency.enableSAP(false);
            newDesiredAgency.setIngestLocationId(new String[]{getAgencyIdByName((getContext().ingestlocation))});

            setAgencyPwdStrength(newDesiredAgency,
                    getContext().defaultPasswordExpiationInDays, getContext().defaultMinimumPasswordLength,
                    getContext().defaultNumbersCount, getContext().defaultUpperCaseCharactersCount);

            agency = getCoreApiAdmin().createAgency(newDesiredAgency);
            getCoreApiAdmin().getAgencyByName(newDesiredAgency.getName());
            getData().addAgency(agency.getName(), agency);
        }
    }

    /**
     * Updates agency login page attributes
     *
     * @param agencyName name of agency which login page will be customized
     * @param data       attributes table
     *                   TextColor - hex color value
     *                   FooterTextColor - hex color value
     *                   ButtonColor - hex color value
     *                   LinkColor - hex color value
     *                   FooterColor - hex color value
     *                   BackgroundColor - hex color value
     *                   BackgroundAlign - only 'left' or 'full' values
     *                   FooterText - some text or empty string
     *                   Message - some text or empty string
     *                   Logo - image from Logo enum
     *                   Background - image from Logo enum
     *
     *                   all of these attributes are not required,
     *                   agency wont be updated if any one attribute is not set
     *                   Note: only first row will be applied for agency, other rows will be ignored
     *
     * @throws IllegalStateException if agency which name is specified is not found in db
     */

    @Given("{I |}updated agency '$agencyName' login page with following attributes: $data")
    public void updateAgencyLoginPage(String agencyName, ExamplesTable data) {
        Agency agency = getAgencyByName(agencyName);
        if (agency == null) throw new IllegalStateException(String.format("Cannot find agency '%s'", wrapVariableWithTestSession(agencyName)));

        Map<String, String> params = parametrizeTabularRow(data);

        if (!params.isEmpty()) {
            if (params.get("TextColor") != null && !params.get("TextColor").isEmpty())
                agency.setCmLoginTextColor(params.get("TextColor"));
            if (params.get("FooterTextColor") != null && !params.get("FooterTextColor").isEmpty())
                agency.setCmLoginFooterTextColor(params.get("FooterTextColor"));
            if (params.get("ButtonColor") != null && !params.get("ButtonColor").isEmpty())
                agency.setCmLoginButtonColor(params.get("ButtonColor"));
            if (params.get("LinkColor") != null && !params.get("LinkColor").isEmpty())
                agency.setCmLoginLinkColor(params.get("LinkColor"));
            if (params.get("FooterColor") != null && !params.get("FooterColor").isEmpty())
                agency.setCmLoginFooterColor(params.get("FooterColor"));
            if (params.get("BackgroundColor") != null && !params.get("BackgroundColor").isEmpty())
                agency.setCmLoginBackgroundColor(params.get("BackgroundColor"));
            if (params.get("FooterText") != null) agency.setCmLoginFooterText(params.get("FooterText"));
            if (params.get("Message") != null) agency.setCmLoginMessage(params.get("Message"));

            if (params.get("Logo") != null && !params.get("Logo").isEmpty()) {
                Logo logo = Logo.valueOf(params.get("Logo"));
                agency.setCmLoginLogo(logo.getBase64String(), DateTime.now(), logo.getMimeType());
            }

            if (params.get("Background") != null && !params.get("Background").isEmpty()) {
                Logo logo = Logo.valueOf(params.get("Background"));
                agency.setCmLoginBackground(logo.getBase64String(), DateTime.now(), logo.getMimeType());
            }

            agency.setCmLoginBackgroundAlign(params.get("BackgroundAlign") == null ? "full" : params.get("BackgroundAlign"));

            getCoreApiAdmin().updateAgency(agency);
        }
    }

    // | PasswordExpirationInDays | MinimumPasswordLength | NumbersCount | UppercaseCharactersCount |
    @Given("{I |}updated password rules for agency '$agencyName' with following attributes: $data")
    @When("{I |}update password rules for agency '$agencyName' with following attributes: $data")
    public void updateAgencyPasswordRules(String agencyName, ExamplesTable data) {
        Agency agency = getAgencyByName(agencyName);
        if (agency == null) throw new IllegalStateException(String.format("Cannot find agency '%s'", wrapVariableWithTestSession(agencyName)));

        Map<String, String> params = parametrizeTabularRow(data);

        if (params.get("PasswordExpirationInDays") != null && !params.get("PasswordExpirationInDays").isEmpty())
            agency.setPasswordExpirationInDays(Integer.parseInt(params.get("PasswordExpirationInDays")));
        if (params.get("MinimumPasswordLength") != null && !params.get("MinimumPasswordLength").isEmpty())
            agency.setPasswordMinTotalLengthOfPassword(Integer.parseInt(params.get("MinimumPasswordLength")));
        if (params.get("NumbersCount") != null && !params.get("NumbersCount").isEmpty())
            agency.setPasswordMinimumIncludingNumbers(Integer.parseInt(params.get("NumbersCount")));
        if (params.get("UppercaseCharactersCount") != null && !params.get("UppercaseCharactersCount").isEmpty())
            agency.setPasswordMinIncludingUppercase(Integer.parseInt(params.get("UppercaseCharactersCount")));

        getCoreApiAdmin().updateAgency(agency);
    }

    // | Name |
    @Given("{I |}created the following agency: $fields")
    public void createAgency(ExamplesTable fields) {
        for (int i = 0; i < fields.getRowCount(); i++) {
            Map<String, String> parameters = parametrizeTabularRow(fields, i);
            Agency newDesiredAgency = new Agency();  // todo agency builder
            if (parameters.get("Name") != null) {
                newDesiredAgency.setName(wrapVariableWithTestSession(parameters.get("Name")));
                //newDesiredAgency.setName(parameters.get("Name"));
            }
            newDesiredAgency.setAgencyType(parameters.get("AgencyType") != null ? parameters.get("AgencyType") : "Advertiser");
            if (parameters.get("Country") != null) {
                DictionaryValues dic = getCoreApi().getDictionary(DictionaryType.COUNTRY).getValues();
                for (DictionaryItem item : dic) {
                    if (item.getName().equals(parameters.get("Country"))) {
                        parameters.put("Country", item.getKey());
                        break;
                    }
                }
            } else {
                parameters.put("Country", "AF");
            }
            newDesiredAgency.setCountry(parameters.get("Country"));
            newDesiredAgency.setDescription(parameters.get("Description") != null ? parameters.get("Description") : "test agency");
            newDesiredAgency.setPin(parameters.get("Pin") != null ? parameters.get("Pin") : "1");
            //newDesiredAgency.setStorageId(getCurrentThreadStorageId());
            // newDesiredAgency.setStorageId(parameters.get("Storage") != null ? parameters.get("Storage") : "a5_regression_storage");
            newDesiredAgency.setStorageId(parameters.get("Storage") != null ? parameters.get("Storage") : getCurrentThreadStorageId());

            newDesiredAgency.setTimeZone(parameters.get("TimeZone") != null ? parameters.get("TimeZone") : "Europe-Andorra");
            newDesiredAgency.setSubtype(parameters.get("Subtype") != null ? parameters.get("Subtype") : "agency");
            newDesiredAgency.setAgencyType(parameters.get("AgencyType") != null ? parameters.get("AgencyType") : "Advertiser");
            if (parameters.get("EmailFrom") != null && !parameters.get("EmailFrom").isEmpty()) newDesiredAgency.setContactsMail(wrapUserEmailWithTestSession(parameters.get("EmailFrom")));
            if (parameters.get("Labels") != null) {
                String[] labels = parameters.get("Labels").split(",");
                List<String> labelsList = Arrays.asList(labels);
                List<String> actualLabelsList = new ArrayList<String>(labelsList);
                actualLabelsList.add("QA");
                String[] tempArray = new String[actualLabelsList.size()];
                labels = actualLabelsList.toArray(tempArray);
                newDesiredAgency.setLabels(labels);
            }
            else
                newDesiredAgency.setLabels(new String[]{"QA"});
            if (parameters.containsKey("Application Access")) {
                String applicationAccess = parameters.get("Application Access");
                List<ApplicationAccess> access = new ArrayList<>();
                for (String accessItem : applicationAccess.split(",")) {
                    if (accessItem.trim().isEmpty()) {
                        continue;
                    }
                    access.add(ApplicationAccess.getByValue(accessItem.trim()));
                }
                newDesiredAgency.setAccess(access.toArray(new ApplicationAccess[access.size()]));
            } else {
                newDesiredAgency.setFullAccess();
            }

            if (getContext().isOrdering) newDesiredAgency.enableSAP(true); else newDesiredAgency.enableSAP(false);

            if (parameters.containsKey("Ingest Location") && !parameters.get("Ingest Location").isEmpty())
                newDesiredAgency.setIngestLocationId(new String[]{getAgencyIdByName(parameters.get("Ingest Location"))});
            else
                newDesiredAgency.setIngestLocationId(new String[]{getAgencyIdByName((getContext().ingestlocation))});
            // ordering important agency fields
            if (parameters.containsKey("Market") && !parameters.get("Market").isEmpty()) newDesiredAgency.setMarket(new String[]{getCoreApiAdmin().getMarketKey(parameters.get("Market"))});
            if (parameters.containsKey("DestinationID") && !parameters.get("DestinationID").isEmpty()) newDesiredAgency.setDestinationId(Integer.valueOf(parameters.get("DestinationID")));
            if (parameters.containsKey("DestinationIDUnique") && !parameters.get("DestinationIDUnique").isEmpty()) {
                Random randomGenerator = new Random();
                newDesiredAgency.setDestinationId(Integer.valueOf(parameters.get("DestinationIDUnique") + Integer.valueOf(randomGenerator.nextInt(1000))));
            }
            if (getContext().isOrdering)
            {
                if (parameters.containsKey("SAP ID")) {
                    if (!parameters.get("SAP ID").isEmpty())
                        newDesiredAgency.setSapId(parameters.get("SAP ID").equals("DefaultSapID") ? OrderingSettings.SAP_ID : parameters.get("SAP ID"));
                    else if (parameters.get("SAP ID").isEmpty())
                        newDesiredAgency.setSapId("");
                }
                else  newDesiredAgency.setSapId(OrderingSettings.DUMMY_SAP_ID);//Need to add Dummy SAP id to all Bu's so that it doesnt Autogenerate BU's on SAP DB. And this Dummy SAP id needs to be valid one else A4 replication fails

                if (parameters.get("SAP Country") != null) {
                    DictionaryValues dic = getCoreApi().getDictionary(DictionaryType.COUNTRY).getValues();
                    for (DictionaryItem item : dic) {
                        if (item.getName().equals(parameters.get("SAP Country"))) {
                            parameters.put("SAP Country", item.getKey());
                            break;
                        }
                    }
                } else {
                    parameters.put("SAP Country", "GB");
                }

                if (parameters.containsKey("SAP Country") && !parameters.get("SAP Country").isEmpty()) newDesiredAgency.setSapCountry(parameters.get("SAP Country"));
                if (parameters.containsKey("A4User")) {    // mapping a4 user for ordering integration
                    String a4User = parameters.get("A4User");
                    newDesiredAgency.setA4User(a4User.equals("DefaultA4User") ? getContext().a4DefaultUser : a4User);
                }
                newDesiredAgency.setA4AgencyId(parameters.containsKey("A4 Agency Id") && !parameters.get("A4 Agency Id").isEmpty() ? parameters.get("A4 Agency Id") : getContext().a4DefaultAgencyId); // mapping a4 agency id for market sync
                newDesiredAgency.setNVergeAllowed(!(parameters.containsKey("nVerge Allowed") && !parameters.get("nVerge Allowed").isEmpty()) || parameters.get("nVerge Allowed").equals("should"));   // set true by default
                newDesiredAgency.setSpecialCharsAllowed(!(parameters.containsKey("Special Chars Allowed") && !parameters.get("Special Chars Allowed").isEmpty()) || parameters.get("Special Chars Allowed").equals("should")); // set true by default
                if (parameters.containsKey("Ingest Location") && !parameters.get("Ingest Location").isEmpty()) newDesiredAgency.setIngestLocationId(new String[]{getAgencyIdByName(parameters.get("Ingest Location"))});
                if (parameters.containsKey("Market") && !parameters.get("Market").isEmpty()) newDesiredAgency.setMarket(new String[]{getCoreApiAdmin().getMarketKey(parameters.get("Market"))});
                if (parameters.containsKey("DestinationID") && !parameters.get("DestinationID").isEmpty())
                    newDesiredAgency.setDestinationId(Integer.valueOf(parameters.get("DestinationID")));
                if (parameters.containsKey("Reminder Days") && !parameters.get("Reminder Days").isEmpty())
                    newDesiredAgency.setRemindersDays(Integer.valueOf(parameters.get("Reminder Days")));
                if (parameters.containsKey("Reminder On Deadline") && !parameters.get("Reminder On Deadline").isEmpty()) newDesiredAgency.setReminderOnDeadlineDate(parameters.get("Reminder On Deadline").equals("should"));
                if (parameters.containsKey("Reminder For Expired") && !parameters.get("Reminder For Expired").isEmpty()) newDesiredAgency.setReminderForExpired(parameters.get("Reminder For Expired").equals("should"));
            }
            // PwdStrength: if not exist took default values.
            // Otherwise took values of array (for example: [30,1,2,3] where 30 - pwd expiration in days, 1 - lower case count, 2 - numbers count, 3 - upper case count)
            if (parameters.get("PwdStrength") != null && !parameters.get("PwdStrength").isEmpty()) {
                String[] pwdStrengthParts = parameters.get("PwdStrength").split(",");
                setAgencyPwdStrength(newDesiredAgency, Integer.valueOf(pwdStrengthParts[0]), Integer.valueOf(pwdStrengthParts[1]), Integer.valueOf(pwdStrengthParts[2]), Integer.valueOf(pwdStrengthParts[3]));
            } else {
                setAgencyPwdStrength(newDesiredAgency, getContext().defaultPasswordExpiationInDays, getContext().defaultMinimumPasswordLength, getContext().defaultNumbersCount, getContext().defaultUpperCaseCharactersCount);
            }
            markA4CustomMetadataFields(parameters, newDesiredAgency);

            if (parameters.containsKey("Save In Library") && !parameters.get("Save In Library").isEmpty()) newDesiredAgency.setSaveInLibrary(parameters.get("Save In Library").equals("should"));
            if (parameters.containsKey("Allow To Save In Library") && !parameters.get("Allow To Save In Library").isEmpty()) newDesiredAgency.setAllowToSaveInLibrary(parameters.get("Allow To Save In Library").equals("should"));

            if (parameters.containsKey("Default Manage Conversion") && !parameters.get("Default Manage Conversion").isEmpty()) newDesiredAgency.setDefaultManageConversion(parameters.get("Default Manage Conversion").equals("should"));
            if (parameters.containsKey("Allow To Change Manage Conversion") && !parameters.get("Allow To Change Manage Conversion").isEmpty()) newDesiredAgency.setAllowToChangeManageConversion(parameters.get("Allow To Change Manage Conversion").equals("should"));
            if (parameters.containsKey("Allow extend dictionaries when accepting shared assets") && !parameters.get("Allow extend dictionaries when accepting shared assets").isEmpty()) newDesiredAgency.setSharingSettingsEnrichDictionary(parameters.get("Allow extend dictionaries when accepting shared assets").equals("should"));

            Agency agency = getData().getAgencyByName(parameters.get("Name"));
            if (agency == null) {
                agency = getData().getAgencyByName(newDesiredAgency.getName());
                if (agency == null) {
                    agency = getCoreApiAdmin().getAgencyByName(newDesiredAgency.getName());
                    if (agency == null)
                        agency = getCoreApiAdmin().createAgency(newDesiredAgency);
                    if (agency != null)
                        getData().addAgency(agency.getName(), agency);
                    else
                        throw new IllegalStateException("Could not create agency " + newDesiredAgency.getName());
                }
            }
        }
    }

    // | Name | Country | Labels | Escalation Enabled | Approval Type | Proxy Approver | Master Approver |
    @Given("{I |}updated the following agency: $fields")
    @When("{I |}updated the following agency: $fields")
    public void updateAgency(ExamplesTable fields) {
        for (int i = 0; i < fields.getRowCount(); i++) {

            Map<String, String> parameters = parametrizeTabularRow(fields, i);
            Agency agency = getAgencyByName(parameters.get("Name"));
            if (agency != null) {
                if (parameters.containsKey("Country")) {
                    DictionaryValues dic = getCoreApi().getDictionary(DictionaryType.COUNTRY).getValues();
                    for (DictionaryItem item : dic) {
                        if (item.getName().equals(parameters.get("Country"))) {
                            agency.setCountry(item.getKey());
                            break;
                        }
                    }
                }
                if (parameters.containsKey("A4User")) {    // mapping a4 user for ordering integration
                    String a4User = parameters.get("A4User");
                    agency.setA4User(a4User.equals("DefaultA4User") ? getContext().a4DefaultUser : a4User);
                }

                if (parameters.containsKey("House Number Suffix")) {
                    if (!parameters.get("House Number Suffix").isEmpty())
                        agency.setHouseNumberSuffix(parameters.get("House Number Suffix"));
                    else
                        agency.setHouseNumberSuffix(null);
                }

                if (parameters.containsKey("Storage") && !parameters.get("Storage").isEmpty() && parameters.get("Storage").equalsIgnoreCase("S3")) {

                    agency.setStorageId(getContext().s3StorageId);
            }
               else if (parameters.containsKey("Storage") && !parameters.get("Storage").isEmpty() && !parameters.get("Storage").equalsIgnoreCase("S3")){

                    agency.setStorageId(parameters.get("Storage"));
                }
                if (parameters.containsKey("Labels")) {
                    if (!parameters.get("Labels").isEmpty()) {
                        String[] labels = parameters.get("Labels").split(",");
                        List<String> labelsList = Arrays.asList(labels);
                        List<String> actualLabelsList = new ArrayList<String>(labelsList);
                        actualLabelsList.add("QA");
                        String[] tempArray = new String[actualLabelsList.size()];
                        labels = actualLabelsList.toArray(tempArray);
                        agency.setLabels(labels);
                     }
                    else
                        agency.setLabels(new String[]{"QA"});
                }

                if (parameters.containsKey("Email Notification URL")) {
                    if (parameters.get("Email Notification URL").equalsIgnoreCase("application_url"))
                        agency.getCmCommonContacts().put("notificationUrl", TestsContext.getInstance().applicationUrl);
                    else
                        agency.getCmCommonContacts().put("notificationUrl", parameters.get("Email Notification URL"));
                }
                if (parameters.containsKey("Custom URL")) {
                    if (parameters.get("Custom URL").equalsIgnoreCase("application_url"))
                        agency.getCmCommonContacts().put("web", TestsContext.getInstance().applicationUrl);
                    else
                        agency.getCmCommonContacts().put("web", parameters.get("Custom URL"));
                }

            if (parameters.containsKey("Save In Library") && !parameters.get("Save In Library").isEmpty()) agency.setSaveInLibrary(parameters.get("Save In Library").equals("should"));
            if (parameters.containsKey("Allow To Save In Library") && !parameters.get("Allow To Save In Library").isEmpty()) agency.setAllowToSaveInLibrary(parameters.get("Allow To Save In Library").equals("should"));
                // true|false
                if (parameters.containsKey("Escalation Enabled") && !parameters.get("Escalation Enabled").isEmpty()) {
                    agency.setCmTrafficEscalation(parameters.get("Escalation Enabled").equals("true") ? true : false);
                }

                if (parameters.containsKey("HouseNumber Unique") && !parameters.get("HouseNumber Unique").isEmpty()) {
                    agency.setNonUniqueHouseNumber(parameters.get("HouseNumber Unique").equals("true") ? true : false);
                }

                // one|two
                if (parameters.containsKey("Approval Type") && !parameters.get("Approval Type").isEmpty()) {
                    agency.setCmTrafficApprovalType(parameters.get("Approval Type"));
                }
                if (parameters.containsKey("Proxy Approver")) {
                    List proxyArray = new ArrayList<String>();
                    List tempmasterArray = new ArrayList<String>();
                if(!parameters.get("Proxy Approver").isEmpty())
                {
                        String proxy[] = parameters.get("Proxy Approver").split(",");
                        for (int j = 0; j < proxy.length; j++) {
                            String userId = getCoreApiAdmin().getUserByEmail(wrapUserEmailWithTestSession(proxy[j].trim())).getId();
                            tempmasterArray.add(userId);
                            List<List<String>> data = (java.util.List<java.util.List<String>>) (getCoreApiAdmin().getAgencyByName(agency.getName()).getCmTrafficApprovers().get("lowres"));
                            if (data != null) {
                                Iterator itr = data.iterator();
                                while (itr.hasNext()) {
                                    String existingApprover = String.valueOf(itr.next());
                                    if (!proxyArray.contains(existingApprover))
                                        proxyArray.add(existingApprover);
                                }
                                if (!data.isEmpty()) {
                                    if (!data.contains(tempmasterArray.get(j)))
                                        proxyArray.add(userId);
                                } else
                                    proxyArray.add(userId);
                            } else
                                proxyArray.add(userId);
                        }
                    }
                    if (!proxyArray.isEmpty())
                        agency.setCmTrafficApproverLowresUsernew(proxyArray);
                    else
                        agency.setCmTrafficApproverLowresUsernew(proxyArray);
                }
            if (parameters.containsKey("Master Approver") )
            {
                    List masterArray = new ArrayList<String>();
                    List tempmasterArray = new ArrayList<String>();
                if(!parameters.get("Master Approver").isEmpty())
                {
                        String master[] = parameters.get("Master Approver").split(",");
                    for (int j = 0; j < master.length; j++)
                    {   String userId = getCoreApiAdmin().getUserByEmail(wrapUserEmailWithTestSession(master[j].trim())).getId();
                            tempmasterArray.add(userId);
                            List<List<String>> data = (java.util.List<java.util.List<String>>) (getCoreApiAdmin().getAgencyByName(agency.getName()).getCmTrafficApprovers().get("master"));
                            if (data != null) {
                                Iterator itr = data.iterator();
                                while (itr.hasNext()) {
                                    String existingApprover = String.valueOf(itr.next());
                                    if (!masterArray.contains(existingApprover))
                                        masterArray.add(existingApprover);
                                }
                                if (!data.isEmpty()) {
                                    if (!data.contains(tempmasterArray.get(j)))
                                        masterArray.add(userId);
                                } else
                                    masterArray.add(userId);
                        }
                        else
                                masterArray.add(userId);

                        }
                    }
                if(!masterArray.isEmpty())
                {
                        agency.setCmTrafficApproverMasterUsernew(masterArray);
                    } else agency.setCmTrafficApproverMasterUsernew(masterArray);
                }
                getCoreApiAdmin().updateAgency(agency);

        }
       else
                log.info("Agenccy does not exist");
        }
    }


    // | Name | Country | Labels |
    @Given("{I |}updated the following agency over core: $fields")
    @When("{I |}update the following agency over core: $fields")
    public void updateAgencyOverCore(ExamplesTable fields) {
        for (int i = 0; i < fields.getRowCount(); i++) {
            Map<String, String> parameters = parametrizeTabularRow(fields, i);
            Agency agency = getAgencyByName(parameters.get("Name"));
            if (parameters.containsKey("Country")) {
                DictionaryValues dic = getCoreApi().getDictionary(DictionaryType.COUNTRY).getValues();
                for (DictionaryItem item : dic) {
                    if (item.getName().equals(parameters.get("Country"))) {
                        agency.setCountry(item.getKey());
                        break;
                    }
                }
            }
            if (parameters.containsKey("A4User")) {    // mapping a4 user for ordering integration
                String a4User = parameters.get("A4User");
                agency.setA4User(a4User.equals("DefaultA4User") ? getContext().a4DefaultUser : a4User);
            }
            if (parameters.containsKey("Labels")) agency.setLabels(parameters.get("Labels").isEmpty() ? null : parameters.get("Labels").split(","));
            if (parameters.containsKey("Save In Library") && !parameters.get("Save In Library").isEmpty()) agency.setSaveInLibrary(parameters.get("Save In Library").equals("should"));
            if (parameters.containsKey("Allow To Save In Library") && !parameters.get("Allow To Save In Library").isEmpty()) agency.setAllowToSaveInLibrary(parameters.get("Allow To Save In Library").equals("should"));

            if (parameters.containsKey("Enable Library Module") && !parameters.get("Enable Library Module").isEmpty()) agency.setStreamlinedlibraryAccess(parameters.get("Enable Library Module").equals("should"));
            if (parameters.containsKey("Enable Projects Module") && !parameters.get("Enable Projects Module").isEmpty()) agency.setFoldersAccess(parameters.get("Enable Projects Module").equals("should"));
            if (parameters.containsKey("Enable Work Requests Feature") && !parameters.get("Enable Work Requests Feature").isEmpty()) agency.setWorkRequestsAccess(parameters.get("Enable Work Requests Feature").equals("should"));
            if (parameters.containsKey("Enable Delivery Module") && !parameters.get("Enable Delivery Module").isEmpty()) agency.setDeliveryAccess(parameters.get("Enable Delivery Module").equals("should"));
            if (parameters.containsKey("Enable Approvals Feature") && !parameters.get("Enable Approvals Feature").isEmpty()) agency.setApprovalsAccess(parameters.get("Enable Approvals Feature").equals("should"));
            if (parameters.containsKey("Enable Annotations Feature") && !parameters.get("Enable Annotations Feature").isEmpty()) agency.setAnnotationsAccess(parameters.get("Enable Annotations Feature").equals("should"));
            if (parameters.containsKey("Enable Presentations Feature") && !parameters.get("Enable Presentations Feature").isEmpty()) agency.setPresentationsAccess(parameters.get("Enable Presentations Feature").equals("should"));
            //QA-QA-358-Automating--Framegrabber code starts
            if (parameters.containsKey("Enable Frame Grabber Module") && !parameters.get("Enable Frame Grabber Module").isEmpty()) agency.setFrameGrabbersAccess(parameters.get("Enable Frame Grabber Module").equals("should"));
            //QA-QA-358-Automating--Framegrabber code Ends
            if (parameters.containsKey("Storage") && !parameters.get("Storage").isEmpty() && parameters.get("Storage").equalsIgnoreCase("S3") && parameters.get("Storage").equalsIgnoreCase("AdbankManualStorage_Id")) {
                agency.setStorageId(getContext().s3StorageId);
            }

            if (parameters.containsKey("Enables Adcost Module") && !parameters.get("Enables Adcost Module").isEmpty()) agency.setAdcostAccess(parameters.get("Enables Adcost Module").equals("should"));

            getCoreApi().updateAgency(agency);
        }
    }

    @Given("turned project filters '$onOff' for metadata fields '$fields' for agency '$agency'")
    public void updateAgencyProjectFilters(String onOff, String fields, Agency agency) {
        boolean enabled = onOff.equalsIgnoreCase("on");
        String[] fieldsArr = fields.split(",");
        for (int i = 0; i < fieldsArr.length; i++) {
            String field = fieldsArr[i].trim();
            if (field.matches("(?i)(Advertiser|Brand|Sub Brand|Product)")) {
                field = "_cm.common." + field.toLowerCase().replace(" ", "_");
            }
            fieldsArr[i] = field;
        }
        agency.setCmProjectFiltersEnabled(enabled);
        agency.setCmProjectFilterFields(fieldsArr);
        getCoreApiAdmin().updateAgency(agency);
    }

    /**
     * used for marking any custom metadata fields
     * schemaName: common, project, audio, digital, document, image, print, video
     * | Mark as Advertiser | Mark as Product | Mark as Campaign | (possible values: any name of custom metadata field)
     */
    @Given("{I |}updated agency '$agencyName' by following marked as fields of schema '$schemaName': $fields")
    public void updateAgencyByMarkedAsFields(String agencyName, String schemaName, ExamplesTable fields) {
        Map<String, String> parameters = parametrizeTabularRow(fields);
        Agency agency = getAgencyByName(agencyName);
        String sName = CustomMetadataSchemaName.findByName(schemaName);
        Schema schema = new MetadataSteps().getSchemaByName(sName, agency.getId());
        if (parameters.containsKey("Mark as Advertiser") && !parameters.get("Mark as Advertiser").isEmpty()) {
            String dictionaryId = schema.getCMFieldIdFromSectionByDescription(sName, parameters.get("Mark as Advertiser"));
            agency.setA4AdvertiserField(CustomMetadataField.generatePath(sName, dictionaryId));
        }
        if (parameters.containsKey("Mark as Product") && !parameters.get("Mark as Product").isEmpty()) {
            String dictionaryId = schema.getCMFieldIdFromSectionByDescription(sName, parameters.get("Mark as Product"));
            agency.setA4ProductField(CustomMetadataField.generatePath(sName, dictionaryId));
        }
        if (parameters.containsKey("Mark as Campaign") && !parameters.get("Mark as Campaign").isEmpty()) {
            String dictionaryId = schema.getCMFieldIdFromSectionByDescription(sName, parameters.get("Mark as Campaign"));
            agency.setA4CampaignField(CustomMetadataField.generatePath(sName, dictionaryId));
        }
        if (parameters.containsKey("Mark as Sector") && !parameters.get("Mark as Sector").isEmpty()) {
            String dictionaryId = schema.getCMFieldIdFromSectionByDescription(sName, parameters.get("Mark as Sector"));
            agency.setA4SectorField(CustomMetadataField.generatePath(sName, dictionaryId));
        }
        if (parameters.containsKey("Mark as Brand") && !parameters.get("Mark as Brand").isEmpty()) {
            String dictionaryId = null;
            if (parameters.get("Mark as Brand").contains("Brand_CostModule")) {
                String brand = "Brand_";
                CustomMetadata data = schema.getCmSectionProperties("common");
                String s = data.toString();
                String randomNumber = s.split(brand)[1].split("=")[0];
                String brandName = brand.concat(randomNumber);
                dictionaryId = brandName;
            } else
                dictionaryId = schema.getCMFieldIdFromSectionByDescription(sName, parameters.get("Mark as Brand"));

            agency.setA4BrandField(CustomMetadataField.generatePath(sName, dictionaryId));
        }
        getCoreApiAdmin().updateAgency(agency);
    }

    @Given("{I |}added agenc{y|ies} '$partnerAgencyNames' as a partner{s|} to agency '$agencyName'")
    public void addPartnerAgency(String partnerAgencyNames, String agencyName) {
        Agency agency = getAgencyByName(agencyName);
        List<String> partners = getCoreApiAdmin().getPartnerAgenciesId(agency.getId());
        for (String partnerAgencyName : partnerAgencyNames.split(",")) {
            Agency partnerAgency = getAgencyByName(partnerAgencyName);
            if (!partners.contains(partnerAgency.getId())) {
                getCoreApiAdmin().addPartnerAgency(agency.getId(), partnerAgency.getId(), false, false);
            }
        }
    }

    // | Can Bill | Can View |
    @Given("{I |}added agenc{y|ies} '$partnerAgencyNames' as a partner{s|} for agency '$agencyName' with following fields: $fieldsTable")
    public void addPartnerAgenciesWithParameters(String partnerAgencyNames, String agencyName, ExamplesTable fieldsTable) {
        Map<String, String> row = parametrizeTabularRow(fieldsTable);
        Agency agency = getAgencyByName(agencyName);
        List<String> partners = getCoreApi().getPartnerAgenciesId(agency.getId());
        for (String partnerAgencyName : partnerAgencyNames.split(",")) {
            Agency partnerAgency = getAgencyByName(partnerAgencyName);
            if (!partners.contains(partnerAgency.getId()))
                getCoreApi().addPartnerAgency(agency.getId(), partnerAgency.getId(),
                        row.containsKey("Can Bill") && row.get("Can Bill").equals("should"), row.containsKey("Can View") && row.get("Can View").equals("should"));
        }
    }

    @When("{I |}remove agenc{y|ies} '$partnerAgencyNames' from partners of agency '$agencyName'")
    public void removePartnerAgencies(String partnerAgencyNames, String agencyName) {
        Agency agency = getAgencyByName(agencyName);
        List<String> partners = getCoreApi().getPartnerAgenciesId(agency.getId());
        for (String partnerAgencyName : partnerAgencyNames.split(",")) {
            Agency partnerAgency = getAgencyByName(partnerAgencyName);
            if (partners.contains(partnerAgency.getId()))
                getCoreApi().removePartnerAgency(agency.getId(), partnerAgency.getId());
        }
    }

    // | Labels |
    @Then("{I |}should see for agency '$agencyName' following data: $fields")
    public void checkAgencyData(String agencyName, ExamplesTable fields) {
        Map<String, String> row = parametrizeTabularRow(fields);
        Agency agency = getAgencyByName(agencyName);
        if (row.containsKey("Labels"))
            assertThat("Check labels: ", Arrays.asList(agency.getLabels()), hasItem(row.get("Labels")));
    }

    private void setAgencyPwdStrength(Agency agency, Integer passwordExpirationInDays, Integer minTotalLength,
                                      Integer numbersCount, Integer upperCaseCharacterCount) {
        agency.setPasswordExpirationInDays(passwordExpirationInDays);
        agency.setPasswordMinTotalLengthOfPassword(minTotalLength);
        agency.setPasswordMinimumIncludingNumbers(numbersCount);
        agency.setPasswordMinIncludingUppercase(upperCaseCharacterCount);
    }

    /**
     * used for marking default advertiser structure
     * | Mark as Advertiser |   (possible values: Advertiser,Brand,Sub Brand,Product)
     * | Mark as Product |      (possible values: Advertiser,Brand,Sub Brand,Product)
     * | Mark as Campaign |     (possible values: Advertiser,Brand,Sub Brand,Product)
     * if Mark as Advertiser, Mark as Product, Mark as Campaign are absent, value will be set for default element
     */
    private void markA4CustomMetadataFields(Map<String, String> parameters, Agency agency) {
        if (parameters.get("Mark as Advertiser") != null) {
            if (!parameters.get("Mark as Advertiser").isEmpty())
                agency.setA4AdvertiserField(CustomMetadataField.findByName(parameters.get("Mark as Advertiser")).getPath());
        }
        else
            agency.setA4AdvertiserField(CustomMetadataField.ADVERTISER.getPath());
        if (parameters.get("Mark as Product") != null) {
            if (!parameters.get("Mark as Product").isEmpty())
                agency.setA4ProductField(CustomMetadataField.findByName(parameters.get("Mark as Product")).getPath());
        }
        else
            agency.setA4ProductField(CustomMetadataField.PRODUCT.getPath());
        if (parameters.get("Mark as Campaign") != null) {
            if (!parameters.get("Mark as Campaign").isEmpty())
                agency.setA4CampaignField(CustomMetadataField.findByName(parameters.get("Mark as Campaign")).getPath());
        }
        else
            agency.setA4CampaignField(CustomMetadataField.CAMPAIGN.getPath());
    }

    private String getCurrentThreadStorageId() {
        int storageIndex = (int) (Thread.currentThread().getId() % TestsContext.getInstance().storageId.length);
        return TestsContext.getInstance().storageId[storageIndex];
    }


    @Given("{I |}add hub members via API: $fields")
    public void addHumMembers(ExamplesTable fields) {
        for (int i = 0; i < fields.getRowCount(); i++) {
            Map<String, String> parameters = parametrizeTabularRow(fields, i);
            Agency agency = getAgencyByName(parameters.get("Name"));
            List<String> hubMembers = new ArrayList<>();
            if (agency != null) {
                if (parameters.containsKey("Hub Members")) {
                    if (!parameters.get("Hub Members").isEmpty()) {
                        for(String ag:parameters.get("Hub Members").split(",")) {
                            hubMembers.add(getAgencyIdByName(ag.trim()));
                         }
                        agency.setHubMembers(hubMembers.toArray(new String[hubMembers.size()]));
                    }
                }
                if (parameters.containsKey("Grouping Type")) {
                    if (!parameters.get("Grouping Type").isEmpty()) {
                         agency.setGroupingType(parameters.get("Grouping Type"));
                    }
                }
            }
            getCoreApiAdmin().updateAgency(agency);
        }
    }
}