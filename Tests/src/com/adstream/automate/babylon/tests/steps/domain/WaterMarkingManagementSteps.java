package com.adstream.automate.babylon.tests.steps.domain;

import com.adstream.automate.babylon.JsonObjects.*;
import com.adstream.automate.babylon.LuceneSearchingParams;
import com.adstream.automate.babylon.data.Logo;
import com.adstream.automate.babylon.sut.data.UserDecorator;
import com.adstream.automate.babylon.sut.elements.controls.complex.PopUpWindow;
import com.adstream.automate.babylon.sut.pages.adbank.addressbook.AdbankAddressbookPage;
import com.adstream.automate.babylon.sut.pages.adbank.addressbook.InviteUserPopup;
import com.adstream.automate.babylon.sut.pages.admin.people.*;
import com.adstream.automate.babylon.sut.pages.admin.watermarking.WaterMarkingManagementPage;
import com.adstream.automate.babylon.tests.steps.core.BaseStep;
import com.adstream.automate.babylon.tests.steps.core.GenericSteps;
import com.adstream.automate.utils.Common;
import com.adstream.automate.utils.EmailMessage;
import org.jbehave.core.annotations.Alias;
import org.jbehave.core.annotations.Given;
import org.jbehave.core.annotations.Then;
import org.jbehave.core.annotations.When;
import org.jbehave.core.model.ExamplesTable;
import org.junit.Assert;
import org.openqa.selenium.Keys;

import java.io.File;
import java.util.*;

import static com.adstream.automate.hamcrest.SortingCheck.sortedAlphabetically;
import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.*;

/**
 * Created by IntelliJ IDEA.
 * User: Geethanjali.K
 * Date: 12.02.16
 * Time: 10:25
 */
public class WaterMarkingManagementSteps extends BaseStep {

    @Given("{I am |}on WaterMarking Management page")
    @When("{I |}go to WaterMarking Management page")
    public WaterMarkingManagementPage openWaterMarkingManagementPage() {
        return getSut().getPageNavigator().getWaterMarkingManagementPage();
    }


    @Given("{I |}filled following fields on the WaterMarking Management page: $data")
    @When("{I |}fill  following fields   on the WaterMarking Management page:  $data")
    public void fillWaterMarkingPageFields(ExamplesTable data) {
        for (Map<String, String> field : parametrizeTableRows(data)) {
            String WaterMarkingText = field.get("WaterMarkingText");
           String WaterMarkingTextLocation = field.get("WaterMarkingTextLocation");
            openWaterMarkingManagementPage().fillWaterMarkingTextBox(WaterMarkingText);
        }
        openWaterMarkingManagementPage().clickSaveButton();
    }

    @Given("{I |}filled following fields for watermark upload: $data")
    @When("{I |}fill following fields for watermark upload: $data")
    public void fillWatermarkUpload(ExamplesTable data)
    {
        for (Map<String, String> field : parametrizeTableRows(data)) {

            openWaterMarkingManagementPage().checkWatermarkUploadCheckbox();
            getCoreApi().uploadAttachedFile_Watermarking(new File(Logo.valueOf(field.get("Logo")).getPath()),getCoreApi().getCurrentAgency().getId(),Logo.valueOf(field.get("Logo")).getPath());
            getSut().getWebDriver().navigate().refresh();
            openWaterMarkingManagementPage().fillLogoPosition(field.get("Logo Position"));
            openWaterMarkingManagementPage().fillWaterMarkingTextBox(field.get("Watermark Text"));
            openWaterMarkingManagementPage().fillLogoOpacityLevel(field.get("Logo Opacity"));
            openWaterMarkingManagementPage().fillTextPosition(field.get("Watermark Text Position"));
            openWaterMarkingManagementPage().fillTextOpacityLevel(field.get("Watermark Text Opacity"));
        }
    }

    @Given("{I |}filled following fields for watermark download: $data")
    @When("{I |}fill following fields for watermark download: $data")
    public void fillWatermarkDownload(ExamplesTable data)
    {
        for (Map<String, String> field : parametrizeTableRows(data)) {
            openWaterMarkingManagementPage().checkWatermarkDownloadCheckbox();
            openWaterMarkingManagementPage().enterWatermarkDownloadText(field.get("Watermark Text"));
            openWaterMarkingManagementPage().fillWatermarkDownloadFontPosition(field.get("Watermark Text Font"));

        }
    }

    @When("{I |}click on save button")
    public void clickSavebutton() {
        Common.sleep(2000);
        openWaterMarkingManagementPage().clickSaveButton();

    }
    @When("{I |}upload logo '$logo' on watermarking page")
    public void uploadLogoForWatermarkUpload(String logo) {

        openWaterMarkingManagementPage().uploadLogoForWatermarkUpload(Logo.valueOf(logo).getPath());
        openWaterMarkingManagementPage().fillLogoPosition("top-right");
        openWaterMarkingManagementPage().fillWaterMarkingTextBox("hello");
        openWaterMarkingManagementPage().fillLogoOpacityLevel("10");
        openWaterMarkingManagementPage().fillTextPosition("centre");
        openWaterMarkingManagementPage().fillTextOpacityLevel("10");
        openWaterMarkingManagementPage().checkWatermarkDownloadCheckbox();
        openWaterMarkingManagementPage().checkWatermarkUploadCheckbox();
        openWaterMarkingManagementPage().enterWatermarkDownloadText("<username>");
        openWaterMarkingManagementPage().fillWatermarkDownloadFontPosition("20");
        Common.sleep(10000);
    }

    @Then("{I |}should see watermark preview on watermarking page")
    public void watermarkUploadPreview() {
        assertThat("", true, is(openWaterMarkingManagementPage().verifyWatermarkUploadPreviewForText()));
        assertThat("", true, is(openWaterMarkingManagementPage().verifyWatermarkUploadPreviewForLogo()));
    }

    @Then("{I |}'$condition' see following fields on WaterMarking Management  page: $data")
    public void checkFieldsOnWaterMarkingManagementPage(String condition, ExamplesTable data) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        for (Map<String, String> field : parametrizeTableRows(data)) {
            String expectedWaterMarkingText = field.get("WaterMarkingText");
            String expectedWaterMarkingTextLocation = field.get("WaterMarkingTextLocation");
            String actualWaterMarkingText =openWaterMarkingManagementPage().getWaterMarkingTextValue();
            assertThat(actualWaterMarkingText, shouldState ? equalToIgnoringCase(expectedWaterMarkingText) : not(equalToIgnoringCase(expectedWaterMarkingText)));

        }
    }

}