package com.adstream.automate.babylon.tests.steps.domain;

import com.adstream.automate.babylon.sut.pages.PageNavigator;
import com.adstream.automate.babylon.sut.pages.admin.views.ViewAssetManagementPage;
import com.adstream.automate.babylon.sut.pages.admin.views.ViewAssetManagementSettingsPage;
import com.adstream.automate.babylon.sut.pages.admin.views.ViewVideoAssetManagementPage;
import com.adstream.automate.babylon.tests.steps.core.BaseStep;
import org.jbehave.core.annotations.Given;
import org.jbehave.core.annotations.Then;
import org.jbehave.core.annotations.When;
import org.jbehave.core.model.ExamplesTable;

import java.util.Map;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.*;
import static org.hamcrest.Matchers.equalToIgnoringCase;

/*
 * Created by demidovskiy-r on 17.06.2015.
 */
public class ViewAssetManagementSteps extends BaseStep {

  private ViewVideoAssetManagementPage getViewVideoAssetManagementPage() {
        return getSut().getPageCreator().getViewVideoAssetManagementPage();
    }

    private ViewVideoAssetManagementPage openViewVideoAssetManagementPage() {
        return getSut().getPageNavigator().getViewVideoAssetManagementPage();
    }

    @Given("{I am |}on View Video Asset Management page")
    @When("{I |}go to View Video Asset Management page")
    public ViewVideoAssetManagementPage goToViewAssetManagementPage() {
        return openViewVideoAssetManagementPage();
    }

    // NGN-16212 - QAA: Global Admin can Search for BU - By Geethanjali- code Starts

    private ViewAssetManagementPage getViewAssetManagementPage() {
        return getSut().getPageCreator().getViewAssetManagementPage();
    }

    private ViewAssetManagementPage openViewAssetManagementPage() {
        return getSut().getPageNavigator().getViewAssetManagementPage();
    }

    private ViewAssetManagementSettingsPage getViewAssetManagementSettingsPage() {
        return getSut().getPageCreator().getViewAssetManagementSettingsPage();
    }

    private ViewAssetManagementSettingsPage openViewAssetManagementSettingsPage() {
        return getSut().getPageNavigator().getViewAssetManagementSettingsPage();

    }

  @Given("{I am |}on View  Asset Management page")
    @When("{I |}go to View  Asset Management page")
    public ViewAssetManagementPage goToViewAssetManagementPageAgencyAdmin() {
        return openViewAssetManagementPage();
    }

    @Given("{I am |}on View  Asset Management Settings page")
    @When("{I |}go to View  Asset Management Settings page")
    public ViewAssetManagementSettingsPage goToViewAssetManagementSettingsPage() {
        return openViewAssetManagementSettingsPage();
    }

    @When("{I |}set maximum number of fields '$maxNumber'")
    public void setMaxNumberOfFields(String maxNumber)
    {
        openViewAssetManagementSettingsPage().setMaxNumberOfFields(maxNumber);
        openViewAssetManagementSettingsPage().clickSaveButton();
    }

    @Given("{I am |}on the '$pageName' asset view page")
    @When("{I |}go to the '$pageName' asset view page")
    public void openAssetViewPage(String pageName) {
        PageNavigator pageFactory = getSut().getPageNavigator();
        getSut().getWebDriver().navigate().refresh();

        if (pageName.equalsIgnoreCase("Print")) {
            pageFactory.getPrintAssetViewPage();
        }
        else if(pageName.equalsIgnoreCase("Video")) {
            pageFactory.getVideoAssetViewPage();
        }
        else if(pageName.equalsIgnoreCase("Audio")) {
            pageFactory.getAudioAssetViewPage();
        }
        else if(pageName.equalsIgnoreCase("Image")) {
            pageFactory.getImageAssetViewPage();
        }

    }

    @Given("{I |}filled following fields with orders on View Asset Management  page: $data")
    @When("{I |}fill  following fields with orders  on View Asset Management  page:  $data")
    public void fillViewAssetManagementPage(ExamplesTable data) {
        for (Map<String,String> field : parametrizeTableRows(data)) {
            String name = field.get("FieldName");
            String value = field.get("FieldValue");
                if (name.equalsIgnoreCase("Advertiser")) {
                    openViewAssetManagementPage().fillAdvertiserTextBox(value);
                } else if (name.equalsIgnoreCase("Brand")) {
                    openViewAssetManagementPage().fillBrandTextBox(value);
                } else if (name.equalsIgnoreCase("Title")) {
                    openViewAssetManagementPage().fillTitleTextBox(value);
                }
            }
        openViewAssetManagementPage().clickSaveButton();
      //  getSut().getPageCreator().getViewAssetPage().clickSaveButton();
        }

    @Given("{I |}filled following fields with orders on View Asset page: $data")
    @When("{I |}fill  following fields with orders  on View Asset page:  $data")
    public void fillViewAssetPage(ExamplesTable data) {
        for (Map<String,String> field : parametrizeTableRows(data)) {
            String name = field.get("FieldName");
            String value = field.get("FieldValue");
            getSut().getPageCreator().getViewAssetPage().fillInFields(name,value);
        }
        getSut().getPageCreator().getViewAssetPage().clickSaveButton();
    }

    @Then("{I |}'$condition' see following fields on View Asset Management  page: $data")
    public void checkFieldsOnViewMgmtPage(String condition, ExamplesTable data) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        for (Map<String,String> field : parametrizeTableRows(data)) {
            String name = field.get("FieldName");
            String expectedvalue = field.get("FieldValue");
            String actualValue = null;
            if (name.equalsIgnoreCase("Advertiser")) {
                actualValue = openViewAssetManagementPage().getAdvertiserValue();
            } else if (name.equalsIgnoreCase("Brand")) {
                actualValue = openViewAssetManagementPage().getBrandValue();
            } else if (name.equalsIgnoreCase("Title")) {
                actualValue = openViewAssetManagementPage().getTitleValue();
            }
            assertThat(actualValue, shouldState ? equalToIgnoringCase(expectedvalue) : not(equalToIgnoringCase(expectedvalue)));
        }
    }
    // NGN-16212 - QAA: Global Admin can Search for BU - By Geethanjali- code Ends

}