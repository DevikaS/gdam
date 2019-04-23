package com.adstream.automate.babylon.tests.steps.domain;

import com.adstream.automate.babylon.JsonObjects.User;
import com.adstream.automate.babylon.sut.pages.admin.approvals.ApprovalTemplatePage;
import com.adstream.automate.babylon.sut.pages.admin.approvals.ApprovalTemplatesPage;
import com.adstream.automate.babylon.sut.pages.admin.approvals.elements.ApprovalTemplatePopup;
import com.adstream.automate.babylon.sut.pages.admin.approvals.elements.RemovingPopup;
import com.adstream.automate.babylon.sut.pages.admin.approvals.elements.StagePopup;
import com.adstream.automate.babylon.sut.pages.admin.relatedFiles.RelatedFilesManagementPage;
import com.adstream.automate.babylon.tests.steps.core.BaseStep;
import com.adstream.automate.utils.Common;
import org.jbehave.core.annotations.Given;
import org.jbehave.core.annotations.Then;
import org.jbehave.core.annotations.When;
import org.jbehave.core.model.ExamplesTable;
import org.joda.time.DateTime;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.*;

/**
 * Created with IntelliJ IDEA.
 * User: Geethanjali.K
 * Date: 11.02.16
        */
public class RelatedFilesManagementSteps extends BaseStep {

    @Given("{I am |}on the Related Files Management page")
    @When("{I |}go to the Related Files Management  page")
    public RelatedFilesManagementPage openRelatedFilesPage() {
        return getSut().getPageNavigator().getRelatedFilesManagementPage();
    }



    @Then("{I |}'$condition' see Relation Type '$relatedfilesNames' on the Related Files Management page")
    public void checkThatTemplatePresentsInList(String condition, String relatedfilesNames) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        List<String> actualrelatedFilesList = openRelatedFilesPage().getRelatedTypesList();
        List<String> relatedFilesList = new ArrayList<>() ;
        for (String expectedrelatedFileName : relatedfilesNames.split(",")) {
            relatedFilesList.add(expectedrelatedFileName);
            assertThat(actualrelatedFilesList, shouldState ? hasItem(expectedrelatedFileName) : not(hasItem(expectedrelatedFileName)));
        }
        if(shouldState) {
            assertThat(actualrelatedFilesList.size(), equalTo(relatedFilesList.size()));
        }
    }

    @Given("{I |}filled following fields with orders on the Related Files Management page: $data")
    @When("{I |}fill  following fields with orders  on the Related Files Management page:  $data")
    public void fillTnCEntry(ExamplesTable data) {
        for (Map<String, String> field : parametrizeTableRows(data)) {
            String RelationRole1 = field.get("RelationRole1");
            String RelationRole2 = field.get("RelationRole2");
            openRelatedFilesPage().fillRelationRole1Box(RelationRole1);
            openRelatedFilesPage().fillRelationRole2Box(RelationRole2);

    }
        openRelatedFilesPage().clickCreateRelationsTypeButton();
    }
}
