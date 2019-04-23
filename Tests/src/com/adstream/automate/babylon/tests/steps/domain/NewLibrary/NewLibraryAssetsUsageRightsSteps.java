

package com.adstream.automate.babylon.tests.steps.domain.NewLibrary;
import com.adstream.automate.babylon.JsonObjects.Content;
import com.adstream.automate.babylon.sut.data.UsageRule;
//import com.adstream.automate.babylon.sut.pages.NewLibrary.elements.LibAddUsageRightsPopup;
import com.adstream.automate.babylon.sut.pages.NewLibrary.NewLibraryAssetUsageRightsPage;
import com.adstream.automate.babylon.sut.pages.NewLibrary.elements.LibAddUsageRightsPopup;
import com.adstream.automate.babylon.sut.pages.NewLibrary.elements.LibEditUsageRightsPopup;
import com.adstream.automate.babylon.sut.pages.NewLibrary.elements.LibRemoveUsageRightsPopup;
import com.adstream.automate.babylon.sut.pages.NewLibrary.pages.LibraryAsset;
import com.adstream.automate.babylon.sut.pages.adbank.projects.elements.AddUsageRightsPopUp;
import com.adstream.automate.babylon.sut.pages.library.elements.AdbankLibraryAssetsUsageRightsPage;
import com.adstream.automate.utils.Common;
import com.adstream.automate.utils.DateTimeUtils;
import org.jbehave.core.annotations.Given;
import org.jbehave.core.annotations.Then;
import org.jbehave.core.annotations.When;
import org.jbehave.core.model.ExamplesTable;
import org.joda.time.format.DateTimeFormat;
import org.joda.time.format.DateTimeFormatter;

import java.util.*;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.*;

/**
 * Created by Janaki.Kamat on 26/06/2018.
 */
public class NewLibraryAssetsUsageRightsSteps extends NewLibraryAssetsViewSteps {

    @Given("{I am |}on asset '$assetName' usage rights page in Library for collection '$categoriesName'NEWLIB")
    @When("{I |}go to asset '$assetName' usage rights page in Library for collection '$categoriesName'NEWLIB")
    public NewLibraryAssetUsageRightsPage openNewLibraryUsageRightPage(String assetName, String categoriesName) {
        String collectionId = getCategoryId(wrapCollectionName(categoriesName));
        Content asset = getAsset(collectionId, wrapVariableWithTestSession(assetName));
        if (asset == null) {
            asset = getAsset(collectionId, assetName);
            if (asset == null)
                throw new NullPointerException("There is no any assets in library with following name: " + assetName);
        }

        return getSut().getPageNavigator().getNewLibraryUsageRightPage(asset.getId());
    }

    @Given("{I |}added Usage Right '$usageRule' with following fields on opened asset Usage Rights pageNEWLIB: $data")
    @When("{I |}add Usage Right '$usageRule' with following fields on opened asset Usage Rights pageNEWLIB: $data")
    public void addUsageRightOnOpenedAssetUsageRightsPage(String usageRule, ExamplesTable data) {
        NewLibraryAssetUsageRightsPage newLibraryAssetUsageRightsPage = getSut().getPageCreator().getNewLibraryAssetUsageRightsPage();
        if (!UsageRule.contains(usageRule))
            throw new IllegalArgumentException(String.format("Unknown usage rule name '%s'", usageRule));
        LibAddUsageRightsPopup libAddUsageRightsPopup = newLibraryAssetUsageRightsPage.clickAddUsageRights();
        libAddUsageRightsPopup.selectType(usageRule);
        for (Map<String, String> row : parametrizeTableRows(data)) {

            if (row.get("StartDate") != null && !row.get("StartDate").isEmpty()) {
                row.put("StartDate", DateTimeUtils.formatDate(parseDateTime(row.get("StartDate")), getContext().userDateTimeFormat));
            }
            if (row.get("ExpirationDate") != null && !row.get("ExpirationDate").isEmpty()) {
                row.put("ExpirationDate", DateTimeUtils.formatDate(parseDateTime(row.get("ExpirationDate")), getContext().userDateTimeFormat));

            }
            switch (usageRule) {
                case UsageRule.GENERAL:
                    libAddUsageRightsPopup.fillGeneralFields(row);
                    break;
                case UsageRule.COUNTRIES:
                    libAddUsageRightsPopup.fillCountriesFields(row);
                    break;
                case UsageRule.MEDIA_TYPES:
                    libAddUsageRightsPopup.fillMediaTypesFields(row);
                    break;
                case UsageRule.VISUAL_TALENT:
                    libAddUsageRightsPopup.fillVisualTalentFields(row);
                    break;
                case UsageRule.MUSIC:
                    if (row.get("Physical release date") != null && !row.get("Physical release date").isEmpty())
                        row.put("Physical release date", DateTimeUtils.formatDate(parseDateTime(row.get("Physical release date")), getContext().userDateTimeFormat));

                    if (row.get("Album release date") != null && !row.get("Album release date").isEmpty())
                        row.put("Album release date", DateTimeUtils.formatDate(parseDateTime(row.get("Album release date")), getContext().userDateTimeFormat));

                    if (row.get("Digital release date") != null && !row.get("Digital release date").isEmpty())
                        row.put("Digital release date", DateTimeUtils.formatDate(parseDateTime(row.get("Digital release date")), getContext().userDateTimeFormat));

                    libAddUsageRightsPopup.fillMusicFields(row);
                    break;
                case UsageRule.OTHER_USAGE:
                    libAddUsageRightsPopup.fillOtherUsageRightsFields(row);
                    break;
                case UsageRule.VOICE_OVER_ARTIST:
                    libAddUsageRightsPopup.fillVoiceOverArtistFields(row);
                    break;
                default:
                    throw new IllegalArgumentException(String.format("%s is a incorrect option for Usage Rights", usageRule));
            }
            if (row.get("NotifyIfExpired") != null && row.get("NotifyIfExpired").equals("true")) {
                libAddUsageRightsPopup.checkNotify();
                libAddUsageRightsPopup.enterDaysBeforeExpireToNotify(row.get("DaysFromExpire"));
            }
            Common.sleep(4000);
            if (row.get("ClickSave") == null || row.get("ClickSave").toLowerCase().equals("true")) {
                libAddUsageRightsPopup.save();
            }


        }
    }

    @Given("{I |}added batch Usage Right '$usageRule' with following fields on opened asset Usage Rights page from collection '$collectionName'NEWLIB: $data")
    @When("{I |}add batch Usage Right '$usageRule' with following fields on opened asset Usage Rights page from collection '$collectionName'NEWLIB: $data")
    public void addBatchUsageRightOnOpenedAssetUsageRightsPage(String usageRule, String collectionName, ExamplesTable data) {
        LibraryAsset page = getSut().getPageCreator().getLibraryPageNEWLIB(wrapCollectionName(collectionName));

        if (!UsageRule.contains(usageRule))
            throw new IllegalArgumentException(String.format("Unknown usage rule name '%s'", usageRule));
        LibAddUsageRightsPopup libAddUsageRightsPopup = new LibAddUsageRightsPopup(page);
        libAddUsageRightsPopup.selectType(usageRule);
        for (Map<String, String> row : parametrizeTableRows(data)) {

            if (row.get("StartDate") != null && !row.get("StartDate").isEmpty()) {
                row.put("StartDate", DateTimeUtils.formatDate(parseDateTime(row.get("StartDate")), getContext().userDateTimeFormat));
            }
            if (row.get("ExpirationDate") != null && !row.get("ExpirationDate").isEmpty()) {
                row.put("ExpirationDate", DateTimeUtils.formatDate(parseDateTime(row.get("ExpirationDate")), getContext().userDateTimeFormat));

            }
            switch (usageRule) {
                case UsageRule.GENERAL:
                    libAddUsageRightsPopup.fillGeneralFields(row);
                    break;
                case UsageRule.COUNTRIES:
                    libAddUsageRightsPopup.fillCountriesFields(row);
                    break;
                case UsageRule.MEDIA_TYPES:
                    libAddUsageRightsPopup.fillMediaTypesFields(row);
                    break;
                case UsageRule.VISUAL_TALENT:
                    libAddUsageRightsPopup.fillVisualTalentFields(row);
                    break;
                case UsageRule.MUSIC:
                    if (row.get("Physical release date") != null && !row.get("Physical release date").isEmpty())
                        row.put("Physical release date", DateTimeUtils.formatDate(parseDateTime(row.get("Physical release date")), getContext().userDateTimeFormat));

                    if (row.get("Album release date") != null && !row.get("Album release date").isEmpty())
                        row.put("Album release date", DateTimeUtils.formatDate(parseDateTime(row.get("Album release date")), getContext().userDateTimeFormat));

                    if (row.get("Digital release date") != null && !row.get("Digital release date").isEmpty())
                        row.put("Digital release date", DateTimeUtils.formatDate(parseDateTime(row.get("Digital release date")), getContext().userDateTimeFormat));

                    libAddUsageRightsPopup.fillMusicFields(row);
                    break;
                case UsageRule.OTHER_USAGE:
                    libAddUsageRightsPopup.fillOtherUsageRightsFields(row);
                    break;
                case UsageRule.VOICE_OVER_ARTIST:
                    libAddUsageRightsPopup.fillVoiceOverArtistFields(row);
                    break;
                default:
                    throw new IllegalArgumentException(String.format("%s is a incorrect option for Usage Rights", usageRule));
            }
            Common.sleep(2000);
            libAddUsageRightsPopup.save();

        }
    }


    @Given("{I |}added Usage Right '$usageRule' for asset '$assetName' for collection '$categoryName' with following fieldsNEWLIB: $data")
    @When("{I |}add Usage Right '$usageRule' for asset '$assetName' for collection '$categoryName' with following fieldsNEWLIB: $data")
    public void addUsageRight(String usageRule, String assetName, String categoryName, ExamplesTable data) {
        openNewLibraryUsageRightPage(assetName, categoryName);
        addUsageRightOnOpenedAssetUsageRightsPage(usageRule, data);
    }

    @Then("{I |}'$condition' see following data for usage type '$usageRule' on {asset|qc asset} '$assetName' usage rights page for collection '$categoryName'NEWLIB: $data")
    public void checkDataForUsageRightPresentedNewLib(String condition, String usageRule, String assetName, String categoryName, ExamplesTable data) {
        openNewLibraryUsageRightPage(assetName, categoryName);
        checkDataForUsageRightPresentedOnOpenedAssetUsageRightsPage(condition, usageRule, data);
    }


    @Then("{I |}'$condition' see notification settings fields area for usage rule '$usageRule' on Usage Information popupNEWLIB")
    public void checkNotificationFieldsAreaVisibilityNewLib(String condition, String usageRule) {
        if (!UsageRule.contains(usageRule))
            throw new IllegalArgumentException(String.format("Unknown usage rule name '%s'", usageRule));
        NewLibraryAssetUsageRightsPage newLibraryAssetUsageRightsPage = getSut().getPageCreator().getNewLibraryAssetUsageRightsPage();

        LibAddUsageRightsPopup libAddUsageRightsPopup = newLibraryAssetUsageRightsPage.clickAddUsageRights();
        libAddUsageRightsPopup.selectType(usageRule);

        boolean expectedState = condition.equalsIgnoreCase("should");
        assertThat(libAddUsageRightsPopup.isNotificationExist(), is(expectedState));
    }


    @Then("{I |}'$condition' see filled following fields for usage type '$usageRule' on opened asset Usage Rights pop pageNEWLIB: $data")
    public void checkThatFollowingFieldsAreFilledOnEditUsageRightPopUpPageNewLib(String condition, String usageRule, ExamplesTable data) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        NewLibraryAssetUsageRightsPage newLibraryAssetUsageRightsPage = getSut().getPageCreator().getNewLibraryAssetUsageRightsPage();

        LibAddUsageRightsPopup libAddUsageRightsPopup = new LibAddUsageRightsPopup(newLibraryAssetUsageRightsPage);

        Map<String, String> actualRules = new HashMap<>();
        for (Map<String, String> expectedRule : parametrizeTableRows(data)) {
            switch (usageRule) {
                case UsageRule.VISUAL_TALENT:
                    actualRules = libAddUsageRightsPopup.getVisualTalentFieldsList();
                    break;
                case UsageRule.VOICE_OVER_ARTIST:
                    actualRules = libAddUsageRightsPopup.getVoiceOverArtistFieldsList();
                    break;
            }
            assertThat(actualRules, shouldState ? equalTo(expectedRule) : not(equalTo(expectedRule)));
        }
    }

    @Then("{I |}'$condition' see '$artist' artist details in Artist Name drop down field on opened asset Usage Rights pop pageNEWLIB")
    public void checkThatArtistDetailsIsAvailableInArtistNameDropDownFieldNewLib(String condition, String artist) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        NewLibraryAssetUsageRightsPage newLibraryAssetUsageRightsPage = getSut().getPageCreator().getNewLibraryAssetUsageRightsPage();

        LibAddUsageRightsPopup libAddUsageRightsPopup = new LibAddUsageRightsPopup(newLibraryAssetUsageRightsPage);

        List<String> list = libAddUsageRightsPopup.getValuesFromArtistField(artist);
        assertThat(list, shouldState ? hasItem(artist) : not(hasItem(artist)));
    }

    @Then("{I |}'$condition' see following data for usage type '$usageRule' on opened asset Usage Rights pageNEWLIB: $data")
    public void checkDataForUsageRightPresentedOnOpenedAssetUsageRightsPage(String condition, String usageRule, ExamplesTable data) {
        Common.sleep(2000);
        if (!UsageRule.contains(usageRule))
            throw new IllegalArgumentException(String.format("Unknown usage rule name '%s'", usageRule));
        boolean shouldState = condition.equalsIgnoreCase("should");
        NewLibraryAssetUsageRightsPage page = getSut().getPageCreator().getNewLibraryAssetUsageRightsPage();
        DateTimeFormatter dateFormatter = DateTimeFormat.forPattern(getData().getCurrentUser().getDateTimeFormatter().getDateFormat());
        List<Map<String, String>> actualRules = new ArrayList<>();

        for (Map<String, String> expectedRule : parametrizeTableRows(data)) {
            String startDate = expectedRule.get("StartDate");
            String expireDate = expectedRule.get("ExpirationDate");

            if (startDate != null)
                expectedRule.put("StartDate", startDate.isEmpty() ? "" : parseDateTime(startDate).toString(DateTimeFormat.forPattern("MMM d, YYYY")));

            if (expireDate != null) {
                expectedRule.put("ExpirationDate", expireDate.isEmpty() ? "" : parseDateTime(expireDate).toString(DateTimeFormat.forPattern("MMM d, YYYY")));
            }

            switch (usageRule) {
                case UsageRule.GENERAL:
                    actualRules = page.getGeneralFieldsList();
                    break;
                case UsageRule.COUNTRIES:
                    actualRules = page.getCountries();
                    break;
                case UsageRule.MEDIA_TYPES:
                    actualRules = page.getMediaTypes();
                    break;
                case UsageRule.MUSIC:
                    actualRules = page.getMusicFieldsList();
                    break;
                case UsageRule.OTHER_USAGE:
                    actualRules = page.getOtherUsageList();
                    break;
                case UsageRule.VISUAL_TALENT:
                    actualRules = page.getVisualTalentList();
                    break;
                case UsageRule.VOICE_OVER_ARTIST:
                    actualRules = page.getVoiceOverArtistFieldsList();
                    break;

            }

            assertThat(actualRules, shouldState ? hasItem(expectedRule) : not(hasItem(expectedRule)));
        }
    }


    @Given("{I |}edited entry of '$usageRule' usage rule with following fields on opened asset Usage Rights pageNEWLIB: $data")
    @When("{I |}edit entry of '$usageRule' usage rule with following fields on opened asset Usage Rights pageNEWLIB: $data")
    public void updateUsageRightOnOpenedAssetUsageRightsPage(String usageRule, ExamplesTable data) {
        if (!UsageRule.contains(usageRule))
            throw new IllegalArgumentException(String.format("Unknown usage rule name '%s'", usageRule));
        NewLibraryAssetUsageRightsPage page = getSut().getPageCreator().getNewLibraryAssetUsageRightsPage();
        for (Map<String, String> row : parametrizeTableRows(data)) {
            if (row.get("EntryNumber") == null) throw new IllegalArgumentException("EntryNumber value must be given");
            int entryNumber = Integer.parseInt(row.get("EntryNumber"));
            LibEditUsageRightsPopup libEditUsageRightsPopup = page.clickEditUsageRights(usageRule, entryNumber);
            Common.sleep(1000);
            if (row.get("StartDate") != null && !row.get("StartDate").isEmpty()) {
                row.put("StartDate", DateTimeUtils.formatDate(parseDateTime(row.get("StartDate")), getContext().userDateTimeFormat));
            }
            if (row.get("ExpirationDate") != null && !row.get("ExpirationDate").isEmpty()) {
                row.put("ExpirationDate", DateTimeUtils.formatDate(parseDateTime(row.get("ExpirationDate")), getContext().userDateTimeFormat));

            }
            switch (usageRule) {
                case UsageRule.GENERAL:
                    libEditUsageRightsPopup.fillGeneralFields(row);
                    break;
                case UsageRule.COUNTRIES:
                    libEditUsageRightsPopup.fillCountriesFields(row);
                    break;
                case UsageRule.MEDIA_TYPES:
                    libEditUsageRightsPopup.fillMediaTypesFields(row);
                    break;
                case UsageRule.VISUAL_TALENT:
                    libEditUsageRightsPopup.fillVisualTalentFields(row);
                    break;
                case UsageRule.MUSIC:
                    if (row.get("Physical release date") != null && !row.get("Physical release date").isEmpty())
                        row.put("Physical release date", DateTimeUtils.formatDate(parseDateTime(row.get("Physical release date")), getContext().userDateTimeFormat));

                    if (row.get("Album release date") != null && !row.get("Album release date").isEmpty())
                        row.put("Album release date", DateTimeUtils.formatDate(parseDateTime(row.get("Album release date")), getContext().userDateTimeFormat));

                    if (row.get("Digital release date") != null && !row.get("Digital release date").isEmpty())
                        row.put("Digital release date", DateTimeUtils.formatDate(parseDateTime(row.get("Digital release date")), getContext().userDateTimeFormat));

                    libEditUsageRightsPopup.fillMusicFields(row);
                    break;
                case UsageRule.OTHER_USAGE:
                    libEditUsageRightsPopup.fillOtherUsageRightsFields(row);
                    break;
                case UsageRule.VOICE_OVER_ARTIST:
                    libEditUsageRightsPopup.fillVoiceOverArtistFields(row);
                    break;
                default:
                    throw new IllegalArgumentException(String.format("%s is a incorrect option for Usage Rights", usageRule));
            }
            Common.sleep(2000);
            libEditUsageRightsPopup.save();

        }
    }


    @Given("{I |}deleted entry of '$usageRule' usage rule with following fields on opened asset Usage Rights pageNEWLIB: $data")
    @When("{I |}delete entry of '$usageRule' usage rule with following fields on opened asset Usage Rights pageNEWLIB: $data")
    public void deleteUsageRightOnOpenedAssetUsageRightsPage(String usageRule, ExamplesTable data) {
        if (!UsageRule.contains(usageRule))
            throw new IllegalArgumentException(String.format("Unknown usage rule name '%s'", usageRule));
        NewLibraryAssetUsageRightsPage page = getSut().getPageCreator().getNewLibraryAssetUsageRightsPage();
        for (Map<String, String> row : parametrizeTableRows(data)) {
            if (row.get("EntryNumber") == null) throw new IllegalArgumentException("EntryNumber value must be given");
            int entryNumber = Integer.parseInt(row.get("EntryNumber"));
            LibRemoveUsageRightsPopup libEditUsageRightsPopup = page.clickRemoveUsageRights(usageRule, entryNumber);
            Common.sleep(1000);
            libEditUsageRightsPopup.clickRemove();
            Common.sleep(1000);
        }
    }


    @Then("{I |}'$should' see remove button for '$usageRule' usage rights option: $data")
    public void checkRemoveUsageRightsOption(String should, String usageRule, ExamplesTable data) {
        if (!UsageRule.contains(usageRule))
            throw new IllegalArgumentException(String.format("Unknown usage rule name '%s'", usageRule));
        NewLibraryAssetUsageRightsPage page = getSut().getPageCreator().getNewLibraryAssetUsageRightsPage();
        for (Map<String, String> row : parametrizeTableRows(data)) {
            if (row.get("EntryNumber") == null) throw new IllegalArgumentException("EntryNumber value must be given");
            int entryNumber = Integer.parseInt(row.get("EntryNumber"));
            assertThat(page.checkRemoveOption(usageRule, entryNumber), equalTo(should.equalsIgnoreCase("should")));
        }
    }

    @Then("{I |}'$should' see add button for usage rights option")
    public void checkAddUsageRightsOption(String should) {
        NewLibraryAssetUsageRightsPage page = getSut().getPageCreator().getNewLibraryAssetUsageRightsPage();
        assertThat(page.checkAddOption(), equalTo(should.equalsIgnoreCase("should")));
    }

    @Then("{I |}'$condition' see Edit link next to '$usageRule' usage type on opened asset usage rights pageNEWLIB")
    public void checkThatEditLinkPresentedOnOpenedUsageRightPageNewLib(String condition, String usageRule) {
        boolean expectedState = condition.equalsIgnoreCase("should");
        NewLibraryAssetUsageRightsPage page = getSut().getPageCreator().getNewLibraryAssetUsageRightsPage();

        boolean actualState = page.isEditLinkPresent(usageRule);
        assertThat(actualState, is(expectedState));
    }


    @Then("{I |}'$condition' see save button disabled on opened edit usage rights popupNEWLIB")
    public void checkStateOfSaveButton(String condition) {
        boolean expectedState = condition.equalsIgnoreCase("should");
        NewLibraryAssetUsageRightsPage newLibraryAssetUsageRightsPage = getSut().getPageCreator().getNewLibraryAssetUsageRightsPage();
        LibAddUsageRightsPopup libAddUsageRightsPopup = new LibAddUsageRightsPopup(newLibraryAssetUsageRightsPage);
        boolean actualState = libAddUsageRightsPopup.isSaveDisabled();
        assertThat(actualState, is(expectedState));
    }

    @Then("{I |}'$condition' see '$message' on usage rights page for '$assetName' for collection '$categoryName' with following fields")
    public void checkMessage(String condition, String message, String assetName, String categoryName) {
        NewLibraryAssetUsageRightsPage newLibraryAssetUsageRightsPage = openNewLibraryUsageRightPage(assetName, categoryName);
        assertThat(newLibraryAssetUsageRightsPage.checkMessage(message), equalTo(condition.equalsIgnoreCase("should")));
    }

    @Then("{I |}'$condition' be on the asset usage rights pageNEWLIB")
    public void checkThatOpenedPageIsAssetUsageRightsNewLib(String condition) {
        boolean expectedState = condition.equalsIgnoreCase("should");
        boolean actualState;

        try {
            getSut().getPageCreator().getNewLibraryAssetUsageRightsPage();
            actualState = true;
        } catch (Exception e) {
            actualState = false;
        }

        assertThat(actualState, is(expectedState));
    }


    @Then("{I |}'$condition' see usage expired text '$text' on opened asset usage rights pageNEWLIB")
    public void checkUsageExpiredLabelPresentOnPage(String condition,String text) {
        boolean expectedState = condition.equalsIgnoreCase("should");
        boolean actualState=getSut().getPageCreator().getNewLibraryAssetUsageRightsPage().getUsageIndicator(text);
        assertThat(actualState, is(expectedState));
    }


    @Then("{I |}should see following count '$count' of edit forms for '$usageType' on opened usage rights pageNEWLIB")
    public void checkNumbOfEditFormsNewLib(int count, String usageType) {
        int isCountOfEditFormsCorrect = getSut().getPageCreator().getNewLibraryAssetUsageRightsPage().countOfUsageRights(usageType);
        assertThat("Wrong number of edit forms: ", isCountOfEditFormsCorrect == count);
    }
}