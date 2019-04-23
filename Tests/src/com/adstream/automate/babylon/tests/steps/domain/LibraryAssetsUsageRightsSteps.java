package com.adstream.automate.babylon.tests.steps.domain;

import com.adstream.automate.babylon.JsonObjects.Content;
import com.adstream.automate.babylon.sut.data.UsageRule;
import com.adstream.automate.babylon.sut.pages.adbank.projects.elements.AddUsageRightsPopUp;
import com.adstream.automate.babylon.sut.pages.library.elements.AdbankBatchUsageRightEditPopUp;
import com.adstream.automate.babylon.sut.pages.library.elements.AdbankLibraryAssetsUsageRightsPage;
import com.adstream.automate.utils.Common;
import org.jbehave.core.annotations.Given;
import org.jbehave.core.annotations.Then;
import org.jbehave.core.annotations.When;
import org.jbehave.core.model.ExamplesTable;
import org.joda.time.format.DateTimeFormat;
import org.joda.time.format.DateTimeFormatter;

import java.util.*;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.*;
public class LibraryAssetsUsageRightsSteps extends LibraryAssetsViewSteps {

    @Given("{I am |}on asset '$assetName' usage rights page in Library for collection '$categoriesName'")
    @When("{I |}go to asset '$assetName' usage rights page in Library for collection '$categoriesName'")
    public AdbankLibraryAssetsUsageRightsPage openAssetUsageRightsPage(String assetName, String categoryName) {
        String collectionId = getCategoryId(wrapCollectionName(categoryName));
        Content asset = getAsset(collectionId, assetName);
        if (asset == null)
            asset = getAsset(collectionId, wrapVariableWithTestSession(assetName));
        return getSut().getPageNavigator().getLibraryAssetsUsageRightsPage(collectionId, asset.getId());
    }



    @Given("{I am |}on uploaded by user '$userName' asset '$assetName' usage rights page in Library for collection '$categoriesName'")
    @When("{I |}go to uploaded by user '$userName' asset '$assetName' usage rights page in Library for collection '$categoriesName'")
    public AdbankLibraryAssetsUsageRightsPage openUserAssetUsageRightsPage(String userName, String assetName, String categoryName) {
        Common.sleep(1000);
        String userId = getCoreApiAdmin().getUserByEmail(wrapUserEmailWithTestSession(userName)).getId();
        String collectionId = getCategoryId(wrapCollectionName(categoryName));
        Content asset = getLastUploadedUserAsset(collectionId, userId, assetName);
        if (asset == null)
            asset = getLastUploadedUserAsset(collectionId, userId, wrapVariableWithTestSession(assetName));
        return getSut().getPageNavigator().getLibraryAssetsUsageRightsPage(collectionId, asset.getId());
    }

    @Given("{I |}added Usage Right '$usageRule' for asset '$assetName' for collection '$categoryName' with following fields: $data")
    @When("{I |}add Usage Right '$usageRule' for asset '$assetName' for collection '$categoryName' with following fields: $data")
    public void addUsageRight(String usageRule, String assetName, String categoryName, ExamplesTable data) {
        openAssetUsageRightsPage(assetName, categoryName);
        addUsageRightOnOpenedAssetUsageRightsPage(usageRule, data);
    }

    @Given("{I |}opened Usage Right pop up of '$usageRule' for asset '$assetName' for collection '$categoryName'")
    @When("{I |}open Usage Right pop up of '$usageRule' for asset '$assetName' for collection '$categoryName'")
    public void openUsageRightPop(String usageRule, String assetName, String categoryName) {
        openAssetUsageRightsPage(assetName, categoryName);
        AdbankLibraryAssetsUsageRightsPage page = getSut().getPageCreator().getLibraryAssetsUsageRightsPage();
        page.selectUsageType(usageRule);
        AddUsageRightsPopUp popup = page.clickAddUsageType();
    }

    // $usageRule =>        $data
    //
    // common =>            NotifyIfExpired (true or false), DaysFromExpire, IncludeTeam (true or false)
    // General =>           StartDate, ExpirationDate | ExpiresEveryDays
    // Countries =>         Country, StartDate, ExpirationDate | ExpiresEveryDays
    // Media Types =>       Type, Comment
    // Visual Talent =>     ArtistName, Role, StartDate, ExpirationDate | ExpiresEveryDays[, Logo, BaseFee, Agent, AgentTel, Email, Union, MoreInfo]
    // Voice-over Artist => ArtistName, Role, StartDate, ExpirationDate | ExpiresEveryDays[, Logo, BaseFee, Agent, AgentTel, Email, Union, MoreInfo]
    // Music =>             ArtistName, TrackTitle, StartDate, ExpirationDate | ExpiresEveryDays [, Composer, TrackNumber, RecordLabel, SubLabel, PublicationPublisher, Arranger, ISRCNumber, LicenseDetails, ContactDetails]
    // Other usage =>       Comment
    @Given("{I |}added Usage Right '$usageRule' with following fields on opened asset Usage Rights page: $data")
    @When("{I |}add Usage Right '$usageRule' with following fields on opened asset Usage Rights page: $data")
    public void addUsageRightOnOpenedAssetUsageRightsPage(String usageRule, ExamplesTable data) {
        if (!UsageRule.contains(usageRule))
            throw new IllegalArgumentException(String.format("Unknown usage rule name '%s'", usageRule));
        AdbankLibraryAssetsUsageRightsPage page = getSut().getPageCreator().getLibraryAssetsUsageRightsPage();

        DateTimeFormatter dateTimeFormatter = DateTimeFormat.forPattern(getData().getCurrentUser().getDateTimeFormatter().getDateFormat());
        for (Map<String, String> row : parametrizeTableRows(data)) {
            page.selectUsageType(usageRule);
            AddUsageRightsPopUp popup = page.clickAddUsageType();

            if (row.get("StartDate") != null && !row.get("StartDate").isEmpty())
                row.put("StartDate", parseDateTime(row.get("StartDate")).toString(dateTimeFormatter));

            if (row.get("ExpirationDate") != null && !row.get("ExpirationDate").isEmpty())
                row.put("ExpirationDate", parseDateTime(row.get("ExpirationDate")).toString(dateTimeFormatter));

            switch (usageRule) {
                case UsageRule.GENERAL:
                    popup.fillGeneralFields(row);
                    break;
                case UsageRule.COUNTRIES:
                    popup.fillCountriesFields(row);
                    break;
                case UsageRule.MEDIA_TYPES:
                    popup.fillMediaTypesFields(row);
                    break;
                case UsageRule.VISUAL_TALENT:
                    popup.fillVisualTalentFields(row);
                    break;
                case UsageRule.VOICE_OVER_ARTIST:
                    popup.fillVoiceOverArtistFields(row);
                    break;
                case UsageRule.MUSIC:
                    popup.fillMusicFields(row);
                    break;
                case UsageRule.OTHER_USAGE:
                    popup.fillOtherUsageFields(row);
                    break;
            }

            if (row.get("NotifyIfExpired") != null && row.get("NotifyIfExpired").equals("true")) {
                popup.checkNotifyIfExpiredCheckbox(usageRule);
                popup.fillDaysFromExpireField(usageRule, row.get("DaysFromExpire"));

                if (row.get("IncludeTeam") != null && row.get("IncludeTeam").equals("true")) {
                    popup.checkIncludeTeamCheckbox(usageRule);
                }
            }
            if(row.get("ClickSave")==null||row.get("ClickSave").toLowerCase().equals("true")){
                popup.action.click();
                Common.sleep(2000);
            }


        }
    }

    // $usageRule =>        $data
    //
    // common =>            NotifyIfExpired (true or false), DaysFromExpire, IncludeTeam (true or false)
    // General =>           StartDate, ExpirationDate | ExpiresEveryDays
    // Countries =>         Country, StartDate, ExpirationDate | ExpiresEveryDays
    // Media Types =>       Type, Comment
    // Visual Talent =>     ArtistName, Role, StartDate, ExpirationDate
    // Voice-over Artist => ArtistName, Role, StartDate, ExpirationDate | ExpiresEveryDays[, Logo, BaseFee, Agent, AgentTel, Email, Union, MoreInfo]
    // Music =>             ArtistName, TrackTitle, StartDate, ExpirationDate | ExpiresEveryDays [, Composer, TrackNumber, RecordLabel, SubLabel, PublicationPublisher, Arranger, ISRCNumber, LicenseDetails, ContactDetails]
    // Other usage =>       Comment
    @Given("{I |}edited entry of '$usageRule' usage rule for asset '$assetName' for collection '$categoryName' with following fields: $data")
    @When("{I |}edit entry of '$usageRule' usage rule for asset '$assetName' for collection '$categoryName' with following fields: $data")
    public void updateUsageRight(String usageRule, String assetName, String categoryName, ExamplesTable data) {
        openAssetUsageRightsPage(assetName, categoryName);
        updateUsageRightOnOpenedAssetUsageRightsPage(usageRule, data);
    }

    @Given("{I |}edited entry of '$usageRule' usage rule with following fields on opened asset Usage Rights page: $data")
    @When("{I |}edit entry of '$usageRule' usage rule with following fields on opened asset Usage Rights page: $data")
    public void updateUsageRightOnOpenedAssetUsageRightsPage(String usageRule, ExamplesTable data) {
        if (!UsageRule.contains(usageRule)) throw new IllegalArgumentException(String.format("Unknown usage rule name '%s'", usageRule));
        AdbankLibraryAssetsUsageRightsPage page = getSut().getPageCreator().getLibraryAssetsUsageRightsPage();
        DateTimeFormatter dateTimeFormatter = DateTimeFormat.forPattern(getData().getCurrentUser().getDateTimeFormatter().getDateFormat());

        for (Map<String, String> row : parametrizeTableRows(data)) {
            if (row.get("EntryNumber") == null) throw new IllegalArgumentException("EntryNumber value must be given");
            int entryNumber = Integer.parseInt(row.get("EntryNumber"));
            page.clickEditUsageLink(usageRule);

            if (row.get("StartDate") != null && !row.get("StartDate").isEmpty())
                row.put("StartDate", parseDateTime(row.get("StartDate")).toString(dateTimeFormatter));

            if (row.get("ExpirationDate") != null && !row.get("ExpirationDate").isEmpty())
                row.put("ExpirationDate", parseDateTime(row.get("ExpirationDate")).toString(dateTimeFormatter));

            switch (usageRule) {
                case UsageRule.GENERAL:
                    page.fillGeneralFields(entryNumber, row);
                    break;
                case UsageRule.COUNTRIES:
                    page.fillCountriesFields(entryNumber, row);
                    break;
                case UsageRule.MEDIA_TYPES:
                    page.fillMediaTypesFields(entryNumber, row);
                    break;
                case UsageRule.VISUAL_TALENT:
                    page.fillVisualTalentFields(entryNumber, row);
                    break;
                case UsageRule.VOICE_OVER_ARTIST:
                    page.fillVoiceOverArtistFields(entryNumber, row);
                    break;
                case UsageRule.MUSIC:
                    page.fillMusicFields(entryNumber, row);
                    break;
                case UsageRule.OTHER_USAGE:
                    page.fillOtherUsageFields(entryNumber, row);
                    break;
            }

            page.clickSaveButton(usageRule);
        }
    }

    @Given("{I |}removed '$entryNumber' entry of '$usageRule' usage rule for asset '$assetName' for collection '$categoryName'")
    @When("{I |}remove '$entryNumber' entry of '$usageRule' usage rule for asset '$assetName' for collection '$categoryName'")
    public void removeUsageRuleEntry(int entryNumber, String usageRule, String assetName, String categoryName) {
        openAssetUsageRightsPage(assetName, categoryName);
        removeUsageRuleEntryOnOpenedAssetUsageRightsPage(entryNumber, usageRule);
    }

    @Given("{I |}removed '$entryNumber' entry of '$usageRule' usage rule on opened asset Usage Rights page")
    @When("{I |}remove '$entryNumber' entry of '$usageRule' usage rule on opened asset Usage Rights page")
    public void removeUsageRuleEntryOnOpenedAssetUsageRightsPage(int entryNumber, String usageRule) {
        if (!UsageRule.contains(usageRule))
            throw new IllegalArgumentException(String.format("Unknown usage rule name '%s'", usageRule));
        AdbankLibraryAssetsUsageRightsPage page = getSut().getPageCreator().getLibraryAssetsUsageRightsPage();
        page.clickEditUsageLink(usageRule);
        page.removeUsageRuleEntry(usageRule, entryNumber);
        page.clickSaveButton(usageRule);
    }

    @When("{I |}click edit link for usage '$usage' on opened Usage Right Page")
    public void clickByEditLink(String usage) {
        getSut().getPageCreator().getLibraryAssetsUsageRightsPage().clickEditLinkForUsageRule(usage);
    }

    @Then("{I |}should see following count '$count' of edit forms for '$usageType' on opened usage rights page")
    public void checkNumbOfEditForms(int count, String usage) {
        int isCountOfEditFormsCorrect = getSut().getPageCreator().getLibraryAssetsUsageRightsPage().isCountofEditFormsAreCorrect(usage);
        assertThat("Wrong number of edit forms: ", isCountOfEditFormsCorrect == count);
    }

    @Then("{I |}'$condition' see Edit link next to '$usageRule' usage type on asset '$assetName' usage rights page for collection '$categoryName'")
    public void checkThatEditLinkPresentedForUsageRight(String condition, String usageRule, String assetName, String categoryName) {
        openAssetUsageRightsPage(assetName, categoryName);
        checkThatEditLinkPresentedOnOpenedUsageRightPage(condition, usageRule);
    }

    @Then("{I |}'$condition' see filled following fields for usage type '$usageRule' on opened asset Usage Rights pop page: $data")
    public void checkThatFollowingFieldsAreFilledOnEditUsageRightPopUpPage(String condition,String usageRule,ExamplesTable data){
        boolean shouldState = condition.equalsIgnoreCase("should");
        AddUsageRightsPopUp popup = new AddUsageRightsPopUp(getSut().getPageCreator().getBasePage());
        Map<String, String> actualRules = new HashMap<>();
        for (Map<String, String> expectedRule : parametrizeTableRows(data)) {
            switch (usageRule) {
                case UsageRule.VISUAL_TALENT:
                    actualRules = popup.getVisualTalentFieldsList();
                    break;
                case UsageRule.VOICE_OVER_ARTIST:
                    actualRules = popup.getVoiceOverArtistFieldsList();
                    break;
            }
            assertThat(actualRules, shouldState ? equalTo(expectedRule) : not(equalTo(expectedRule)));
        }
    }

    @Then("{I |}'$condition' see '$artist' artist details in Artist Name drop down field on opened asset Usage Rights pop page")
    public void checkThatArtistDetailsIsAvailableInArtistNameDropDownField(String condition,String artist){
        boolean shouldState = condition.equalsIgnoreCase("should");
        AddUsageRightsPopUp popup = new AddUsageRightsPopUp(getSut().getPageCreator().getBasePage());
        List <String> list = popup.getValuesFromArtistField();
        assertThat(list,shouldState ? hasItem(artist) : not(hasItem(artist)));
    }

    @Then("{I |}'$condition' see Edit link next to '$usageRule' usage type on opened asset usage rights page")
    public void checkThatEditLinkPresentedOnOpenedUsageRightPage(String condition, String usageRule) {
        boolean expectedState = condition.equalsIgnoreCase("should");
        boolean actualState = getSut().getPageCreator().getLibraryAssetsUsageRightsPage().isEditLinkPresentForUsageType(usageRule);
        assertThat(actualState, is(expectedState));
    }

    // $usageRule =>        $data
    //
    // General =>           StartDate, ExpirationDate | ExpiresEveryDays
    // Countries =>         Country, StartDate, ExpirationDate | ExpiresEveryDays
    // Media Types =>       Type, Comment
    // Visual Talent =>     ArtistName, Role, StartDate, ExpirationDate[, Logo]
    // Voice-over Artist => ArtistName, Role, StartDate, ExpirationDate | ExpiresEveryDays[, Logo, BaseFee, Agent, AgentTel, Email, Union, MoreInfo]
    // Music =>             ArtistName, TrackTitle, StartDate, ExpirationDate | ExpiresEveryDays [, Composer, TrackNumber, RecordLabel, SubLabel, PublicationPublisher, Arranger, ISRCNumber, LicenseDetails, ContactDetails]
    // Other usage =>       Comment
    @Then("{I |}'$condition' see following data for usage type '$usageRule' on {asset|qc asset} '$assetName' usage rights page for collection '$categoryName': $data")
    public void checkDataForUsageRightPresented(String condition, String usageRule, String assetName, String categoryName, ExamplesTable data) {
        openAssetUsageRightsPage(assetName, categoryName);
        checkDataForUsageRightPresentedOnOpenedAssetUsageRightsPage(condition, usageRule, data);
    }

    @Then("{I |}'$condition' see following data for usage type '$usageRule' on opened asset Usage Rights page: $data")
    public void checkDataForUsageRightPresentedOnOpenedAssetUsageRightsPage(String condition, String usageRule, ExamplesTable data) {
        if (!UsageRule.contains(usageRule))
            throw new IllegalArgumentException(String.format("Unknown usage rule name '%s'", usageRule));
        boolean shouldState = condition.equalsIgnoreCase("should");
        AdbankLibraryAssetsUsageRightsPage page = getSut().getPageCreator().getLibraryAssetsUsageRightsPage();
        DateTimeFormatter dateFormatter = DateTimeFormat.forPattern(getData().getCurrentUser().getDateTimeFormatter().getDateFormat());
        List<Map<String, String>> actualRules = new ArrayList<>();

        for (Map<String, String> expectedRule : parametrizeTableRows(data)) {
            String startDate = expectedRule.get("StartDate");
            String expireDate = expectedRule.get("ExpirationDate");

            if (startDate != null)
                expectedRule.put("StartDate", startDate.isEmpty() ? "" : parseDateTime(startDate).toString(dateFormatter));

            if (expireDate != null) {
                expectedRule.put("ExpirationDate", expireDate.isEmpty() ? "" : parseDateTime(expireDate).toString(dateFormatter));
            }

            switch (usageRule) {
                case UsageRule.GENERAL:
                    actualRules = page.getGeneralFieldsList();
                    break;
                case UsageRule.COUNTRIES:
                    actualRules = page.getCountriesFieldsList();
                    break;
                case UsageRule.MEDIA_TYPES:
                    actualRules = page.getMediaTypesFieldsList();
                    break;
                case UsageRule.VISUAL_TALENT:
                    actualRules = page.getVisualTalentFieldsList();
                    break;
                case UsageRule.VOICE_OVER_ARTIST:
                    actualRules = page.getVoiceOverArtistFieldsList();
                    break;
                case UsageRule.MUSIC:
                    actualRules = page.getMusicFieldsList();
                    break;
                case UsageRule.OTHER_USAGE:
                    actualRules = page.getOtherUsageFieldsList();
                    break;
            }

            for (Map<String, String> actualRule : actualRules) {
                for (String key : new HashSet<>(actualRule.keySet())) {
                    if (actualRule.get(key).isEmpty() && !expectedRule.containsKey(key)) {
                        actualRule.remove(key);
                    }
                }
            }

            assertThat(actualRules, shouldState ? hasItem(expectedRule) : not(hasItem(expectedRule)));
        }
    }

    @Then("{I |}'$condition' see fields '$fieldNames' are marked as red on opened Usage Information popup")
    public void checkUsageRightFieldsAreMarkedAsRed(String condition, String fieldNames) {
        boolean expectedState = condition.equalsIgnoreCase("should");
        AddUsageRightsPopUp popup = new AddUsageRightsPopUp(getSut().getPageCreator().getBasePage());

        for (String fieldName : fieldNames.split(",")) {
            boolean actualState = false;

            switch (fieldName) {
                case "StartDate":
                    actualState = popup.isStartDateFieldRed();
                    break;
                case "ExpirationDate":
                    actualState = popup.isExpirationDateFieldRed();
                    break;
                case "ExpiresEveryDays":
                    actualState = popup.isExpiresEveryDaysFieldRed();
                    break;
                case "Country":
                    actualState = popup.isCountryFieldRed();
                    break;
                case "ArtistName":
                    actualState = popup.isArtistNameFieldRed();
                    break;
                case "Artist":
                    actualState = popup.isArtistFieldRed();
                    break;
                case "Role":
                    actualState = popup.isRoleFieldRed();
                    break;
                case "TrackTitle":
                    actualState = popup.isTrackTitleFieldRed();
                    break;
            }

            assertThat("Is field '" + fieldName + "' marked red", actualState, is(expectedState));
        }
    }

    @Then("{I |}'$condition' see notification settings fields area for usage rule '$usageRule' on Usage Information popup on opened asset usage rights page")
    public void checkNotificationFieldsAreaVisibility(String condition, String usageRule) {
        if (!UsageRule.contains(usageRule))
            throw new IllegalArgumentException(String.format("Unknown usage rule name '%s'", usageRule));

        AdbankLibraryAssetsUsageRightsPage page = getSut().getPageCreator().getLibraryAssetsUsageRightsPage();
        page.selectUsageType(usageRule);

        boolean expectedState = condition.equalsIgnoreCase("should");
        boolean actualState = page.clickAddUsageType().isUsageRightsNotificationSettingsAreaVisible();

        assertThat(actualState, is(expectedState));
    }

    @Then("{I |}'$condition' see usage expired label on opened asset usage rights page")
    public void checkUsageExpiredLabelPresentOnPage(String condition) {
        boolean expectedState = condition.equalsIgnoreCase("should");
        boolean actualState = getSut().getPageCreator().getLibraryAssetsUsageRightsPage().isUsageExpiredLabelAvailable();

        assertThat(actualState, is(expectedState));
    }

    @Then("{I |}'$condition' be on the asset usage rights page")
    public void checkThatOpenedPageIsAssetUsageRights(String condition) {
        boolean expectedState = condition.equalsIgnoreCase("should");
        boolean actualState;

        try {
            getSut().getPageCreator().getLibraryAssetsUsageRightsPage();
            actualState = true;
        } catch (Exception e) {
            actualState = false;
        }

        assertThat(actualState, is(expectedState));
    }
}