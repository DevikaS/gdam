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

public class TemplateFileUsageRightsSteps extends AbstractFileViewSteps {
    @Override
    public Project getObjectByName(String objectName) {
        return getCoreApi().getTemplateByName(objectName);
    }

    @Override
    protected AdbankProjectFileRelatedFilesPage getProjectRelatedFilesPage(String projectId, String folderId, String fileId) {
        return null;
    }

    @Override
    public Project getObjectByName(String objectName, User user) {
        return getCoreApi(user).getTemplateByName(objectName);
    }

    @Override
    protected AdbankFileActivityPage getFileActivityPage(String templateId, String folderId, String fileId) {
        return getSut().getPageNavigator().getTemplateFileActivityPage(templateId, folderId, fileId);
    }

    @Override
    protected AdbankFilesInfoPage getFilesInfoPage(String templateId, String folderId, String fileId) {
        return getSut().getPageNavigator().getTemplateFileInfoPage(templateId, folderId, fileId);
    }

    @Override
    protected AdbankFileUsageRightsPage getFileUsageRightsPage(String templateId, String folderId, String fileId) {
        return getSut().getPageNavigator().getTemplateFileUsageRightsPage(templateId, folderId, fileId);
    }

    @Override
    protected AdbankFileCommentsPage getFileCommentsPage(String templateId, String folderId, String fileId) {
        return null;
    }

    @Override
    protected AdbankFileVersionHistoryPage getFileVersionHistoryPage(String templateId, String folderId, String fileId) {
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
        return null;
    }
    //QA358-Frame Grabber Changes Ends
    @Given("{I am |}on file '$fileName' usage rights page in folder '$path' template '$templateName'")
    @When("{I |}go to file '$fileName' usage rights page in folder '$path' template '$templateName'")
    public AdbankFileUsageRightsPage openFileUsageRightsPage(String fileName, String path, String templateName) {
        return super.openFileUsageRightsPage(fileName, path, templateName);
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
    @Given("{I |}added '$usageRule' usage rule with following fields on file '$fileName' and folder '$path' and template '$templateName' Usage Rights page: $data")
    @When("{I |}add '$usageRule' usage rule with following fields on file '$fileName' and folder '$path' and template '$templateName' Usage Rights page: $data")
    public void addUsageRule(String usageRule, String fileName, String path, String templateName, ExamplesTable data) {
        super.addUsageRule(templateName, path, fileName, usageRule, data);
    }

    // $usageRule =>        $data
    //
    // common =>            EntryNumber, NotifyIfExpired (true or false), DaysFromExpire, IncludeTeam (true or false)
    // General =>           StartDate, ExpirationDate | ExpiresEveryDays
    // Countries =>         Country, StartDate, ExpirationDate | ExpiresEveryDays
    // Media Types =>       Type, Comment
    // Visual Talent =>     ArtistName, Role, StartDate, ExpirationDate
    // Voice-over Artist => ArtistName, Role, StartDate, ExpirationDate | ExpiresEveryDays[, Logo, BaseFee, Agent, AgentTel, Email, Union, MoreInfo]
    // Music =>             ArtistName, TrackTitle, StartDate, ExpirationDate | ExpiresEveryDays [, Composer, TrackNumber, RecordLabel, SubLabel, PublicationPublisher, Arranger, ISRCNumber, LicenseDetails, ContactDetails]
    // Other usage =>       Comment
    @Given("{I |}edited entry of '$usageRule' usage rule with following fields on file '$fileName' and folder '$path' and template '$templateName' Usage Rights page: $data")
    @When("{I |}edit entry of '$usageRule' usage rule with following fields on file '$fileName' and folder '$path' and template '$templateName' Usage Rights page: $data")
    public void updateUsageRule(String usageRule, String fileName, String path, String templateName, ExamplesTable data) {
        super.updateUsageRule(templateName, path, fileName, usageRule, data);
    }

    @Given("{I |}removed '$entryNumber' entry of '$usageRule' usage rule on file '$fileName' and folder '$path' and template '$templateName' Usage Rights page")
    @When("{I |}remove '$entryNumber' entry of '$usageRule' usage rule on file '$fileName' and folder '$path' and template '$templateName' Usage Rights page")
    public void removeUsageRuleEntry(int entryNumber, String usageRule, String fileName, String path, String templateName) {
        super.removeUsageRuleEntry(templateName, path, fileName, usageRule, entryNumber);
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
    @Then("{I |}'$condition' see '$usageRule' usage rule with following fields on file '$fileName' and folder '$path' and template '$templateName' Usage Rights page: $data")
    public void checkThatUsageRuleFieldsPresent(String condition, String usageRule, String fileName, String path, String templateName, ExamplesTable data) {
        super.checkThatUsageRuleFieldsPresent(templateName, path, fileName, condition.equalsIgnoreCase("should"), usageRule, data);
    }

    @Then("{I |}'$condition' see Edit link next to '$usageRule' usage rule on file '$fileName' and folder '$path' and template '$templateName' Usage Rights page")
    public void checkThatEditUsageLinkPresent(String condition, String usageRule, String fileName, String path, String templateName) {
        super.checkThatEditUsageLinkPresent(templateName, path, fileName, condition.equalsIgnoreCase("should"), usageRule);
    }

    @Then("{I |}'$condition' see '$usageRule' usage rule on file '$fileName' and folder '$path' and template '$templateName' Usage Rights page")
    public void checkThatUsageRulePresent(String condition, String usageRule, String fileName, String path, String templateName) {
        super.checkThatUsageRulePresent(templateName, path, fileName, condition.equalsIgnoreCase("should"), usageRule);
    }
}