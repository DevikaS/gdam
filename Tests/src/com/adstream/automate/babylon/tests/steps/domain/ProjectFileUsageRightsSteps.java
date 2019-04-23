package com.adstream.automate.babylon.tests.steps.domain;

import com.adstream.automate.babylon.JsonObjects.Project;
import com.adstream.automate.babylon.JsonObjects.User;
import com.adstream.automate.babylon.sut.pages.adbank.projects.AdbankFileApprovalsPage;
import com.adstream.automate.babylon.sut.pages.adbank.projects.AdbankFileCommentsPage;
import com.adstream.automate.babylon.sut.pages.adbank.projects.AdbankFileVersionHistoryPage;
import com.adstream.automate.babylon.sut.pages.adbank.projects.elements.*;
import org.jbehave.core.annotations.Given;
import org.jbehave.core.annotations.Then;
import org.jbehave.core.annotations.When;
import org.jbehave.core.model.ExamplesTable;

/**
 * Created with IntelliJ IDEA.
 * User: solomin-y
 * Date: 24.10.12
 * Time: 13:50

 */
public class ProjectFileUsageRightsSteps extends AbstractFileViewSteps {
    @Override
    public Project getObjectByName(String objectName) {
        return getCoreApi().getProjectByName(objectName);
    }

    @Override
    protected AdbankProjectFileRelatedFilesPage getProjectRelatedFilesPage(String projectId, String folderId, String fileId) {
        return null;
    }

    @Override
    public Project getObjectByName(String objectName, User user) {
        return getCoreApi(user).getProjectByName(objectName);
    }

    @Override
    protected AdbankFileActivityPage getFileActivityPage(String projectId, String folderId, String fileId) {
        return getSut().getPageNavigator().getProjectFileActivityPage(projectId, folderId, fileId);
    }

    @Override
    protected AdbankFilesInfoPage getFilesInfoPage(String projectId, String folderId, String fileId) {
        return getSut().getPageNavigator().getProjectFileInfoPage(projectId, folderId, fileId);
    }

    @Override
    protected AdbankFileUsageRightsPage getFileUsageRightsPage(String projectId, String folderId, String fileId) {
        return getSut().getPageNavigator().getProjectFileUsageRightsPage(projectId, folderId, fileId);
    }

    @Override
    protected AdbankFileCommentsPage getFileCommentsPage(String projectId, String folderId, String fileId) {
        return getSut().getPageNavigator().getProjectFileCommentsPage(projectId, folderId, fileId);
    }

    @Override
    protected AdbankFileVersionHistoryPage getFileVersionHistoryPage(String projectId, String folderId, String fileId) {
        return null;
    }

    @Override
    protected AdbankFileApprovalsPage getFileApprovalsPage(String projectId, String folderId, String fileId) {
        return null;
    }

    @Override
    protected AdbankFileAttachmentsPage getFileAttachmentsPage(String projectId, String folderId, String fileId) {
        return null;
    }

    //QA358-Frame Grabber Changes Starts
    @Override
    protected AdbankFileFramesPage getFileFramesPage(String projectId, String folderId, String fileId) {
        return getSut().getPageNavigator().getProjectFileFramesPage(projectId, folderId, fileId);
    }
  //QA358-Frame Grabber Changes Ends

    @Given("{I am |}on file '$fileName' usage rights page in folder '$path' project '$projectName'")
    @When("{I |}go to file '$fileName' usage rights page in folder '$path' project '$projectName'")
    public AdbankFileUsageRightsPage openFileUsageRightsPage(String fileName, String path, String projectName) {
        return super.openFileUsageRightsPage(fileName, path, projectName);
    }

    // $usageRule =>        $data
    //
    // common =>            NotifyIfExpired (true or false), DaysFromExpire, IncludeTeam (true or false)
    // General =>           StartDate, ExpirationDate | ExpiresEveryDays
    // Countries =>         Country, StartDate, ExpirationDate | ExpiresEveryDays
    // Media Types =>       Type, Comment
    // Visual Talent =>     ArtistName, Role, StartDate, ExpirationDate
    // Voice-over Artist => ArtistName, Role, StartDate, ExpirationDate | ExpiresEveryDays[, Logo, BaseFee, Agent, AgentTel, Email, Union, MoreInfo]
    // Music =>             ArtistName, TrackTitle, StartDate, ExpirationDate | ExpiresEveryDays [, Composer, TrackNumber, RecordLabel, SubLabel, PublicationPublisher, Arranger, ISRCNumber, Duration, LicenseDetails, ContactDetails]
    // Other usage =>       Comment
    @Given("{I |}added '$usageRule' usage rule with following fields on file '$fileName' and folder '$path' and project '$projectName' Usage Rights page: $data")
    @When("{I |}add '$usageRule' usage rule with following fields on file '$fileName' and folder '$path' and project '$projectName' Usage Rights page: $data")
    public void addUsageRule(String usageRule, String fileName, String path, String projectName, ExamplesTable data) {
        super.addUsageRule(projectName, path, fileName, usageRule, data);
    }

    // $usageRule =>        $data
    //
    // common =>            NotifyIfExpired (true or false), DaysFromExpire, IncludeTeam (true or false)
    // General =>           StartDate, ExpirationDate | ExpiresEveryDays
    // Countries =>         Country, StartDate, ExpirationDate | ExpiresEveryDays
    // Media Types =>       Type, Comment
    // Visual Talent =>     ArtistName, Role, StartDate, ExpirationDate
    // Voice-over Artist => ArtistName, Role, StartDate, ExpirationDate | ExpiresEveryDays[, Logo, BaseFee, Agent, AgentTel, Email, Union, MoreInfo]
    // Music =>             ArtistName, TrackTitle, StartDate, ExpirationDate | ExpiresEveryDays [, Composer, TrackNumber, RecordLabel, SubLabel, PublicationPublisher, Arranger, ISRCNumber, Duration, LicenseDetails, ContactDetails]
    // Other usage =>       Comment
    @Given("{I |}edited entry of '$usageRule' usage rule with following fields on file '$fileName' and folder '$path' and project '$projectName' Usage Rights page: $data")
    @When("{I |}edit entry of '$usageRule' usage rule with following fields on file '$fileName' and folder '$path' and project '$projectName' Usage Rights page: $data")
    public void updateUsageRule(String usageRule, String fileName, String path, String projectName, ExamplesTable data) {
        super.updateUsageRule(projectName, path, fileName, usageRule, data);
    }

    @Given("{I |}removed '$entryNumber' entry of '$usageRule' usage rule on file '$fileName' and folder '$path' and project '$projectName' Usage Rights page")
    @When("{I |}remove '$entryNumber' entry of '$usageRule' usage rule on file '$fileName' and folder '$path' and project '$projectName' Usage Rights page")
    public void removeUsageRuleEntry(int entryNumber, String usageRule, String fileName, String path, String projectName) {
        super.removeUsageRuleEntry(projectName, path, fileName, usageRule, entryNumber);
    }

    // $usageRule =>        $data
    //
    // common =>            NotifyIfExpired (true or false), DaysFromExpire, IncludeTeam (true or false)
    // General =>           StartDate, ExpirationDate | ExpiresEveryDays
    // Countries =>         Country, StartDate, ExpirationDate | ExpiresEveryDays
    // Media Types =>       Type, Comment
    // Visual Talent =>     ArtistName, Role, StartDate, ExpirationDate
    // Voice-over Artist => ArtistName, Role, StartDate, ExpirationDate | ExpiresEveryDays[, Logo, BaseFee, Agent, AgentTel, Email, Union, MoreInfo]
    // Music =>             ArtistName, TrackTitle, StartDate, ExpirationDate | ExpiresEveryDays [, Composer, TrackNumber, RecordLabel, SubLabel, PublicationPublisher, Arranger, ISRCNumber, Duration, LicenseDetails, ContactDetails]
    // Other usage =>       Comment
    @Then("{I |}'$condition' see '$usageRule' usage rule with following fields on file '$fileName' and folder '$path' and project '$projectName' Usage Rights page: $data")
    public void checkThatUsageRuleFieldsPresent(String condition, String usageRule, String fileName, String path, String projectName, ExamplesTable data) {
        super.checkThatUsageRuleFieldsPresent(projectName, path, fileName, condition.equalsIgnoreCase("should"), usageRule, data);
    }

    @Then("{I |}'$condition' see Edit link next to '$usageRule' usage rule on file '$fileName' and folder '$path' and project '$projectName' Usage Rights page")
    public void checkThatEditUsageLinkPresent(String condition, String usageRule, String fileName, String path, String projectName) {
        super.checkThatEditUsageLinkPresent(projectName, path, fileName, condition.equalsIgnoreCase("should"), usageRule);
    }

    @Then("{I |}'$condition' see '$usageRule' usage rule on file '$fileName' and folder '$path' and project '$projectName' Usage Rights page")
    public void checkThatUsageRulePresent(String condition, String usageRule, String fileName, String path, String projectName) {
        super.checkThatUsageRulePresent(projectName, path, fileName, condition.equalsIgnoreCase("should"), usageRule);
    }
}