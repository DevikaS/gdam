package com.adstream.automate.babylon.sut.pages;

import com.adstream.automate.babylon.sut.pages.NewLibrary.NewLibraryAssetUsageRightsPage;
import com.adstream.automate.babylon.sut.pages.NewLibrary.pages.*;
import com.adstream.automate.babylon.sut.pages.NewLibrary.pages.CollectionPage;
import com.adstream.automate.babylon.sut.pages.NewLibrary.pages.LibraryAssetsInfoPage;
import com.adstream.automate.babylon.sut.pages.adbank.BaseAdBankPage;
import com.adstream.automate.babylon.sut.pages.adbank.addressbook.AdbankAddressbookAddUsersPopUp;
import com.adstream.automate.babylon.sut.pages.adbank.addressbook.AdbankAddressbookPage;
import com.adstream.automate.babylon.sut.pages.adbank.dashboard.AdbankDashboardPage;
import com.adstream.automate.babylon.sut.pages.adbank.myprofile.MyAccountSettingPage;
import com.adstream.automate.babylon.sut.pages.adbank.myprofile.MyNotificationsSettingPage;
import com.adstream.automate.babylon.sut.pages.adbank.myprofile.MyProfilePage;
import com.adstream.automate.babylon.sut.pages.adbank.notifications.AdBankNotificationsPage;
import com.adstream.automate.babylon.sut.pages.adbank.projects.*;
import com.adstream.automate.babylon.sut.pages.adbank.projects.approvals.*;
import com.adstream.automate.babylon.sut.pages.adbank.projects.elements.*;
import com.adstream.automate.babylon.sut.pages.adcost.*;
import com.adstream.automate.babylon.sut.pages.admin.AdbankBillingPage;
import com.adstream.automate.babylon.sut.pages.admin.BaseAdminPage;
import com.adstream.automate.babylon.sut.pages.admin.agency.*;
import com.adstream.automate.babylon.sut.pages.admin.agency.agencySearch.GlobalAdminSearchAgencyPage;
import com.adstream.automate.babylon.sut.pages.admin.approvals.ApprovalTemplatePage;
import com.adstream.automate.babylon.sut.pages.admin.approvals.ApprovalTemplatesPage;
import com.adstream.automate.babylon.sut.pages.admin.branding.AdminLoginPage;
import com.adstream.automate.babylon.sut.pages.admin.branding.AdminSystemBrandingPage;
import com.adstream.automate.babylon.sut.pages.admin.branding.GlobalAdminSystemBrandingPage;
import com.adstream.automate.babylon.sut.pages.admin.categories.CategoriesPage;
import com.adstream.automate.babylon.sut.pages.admin.holidays.HolidaysPage;
import com.adstream.automate.babylon.sut.pages.admin.mailTemplates.MailTemplatesNotificationSettingsPage;
import com.adstream.automate.babylon.sut.pages.admin.metadata.GlobalCommonOrderingMetadataPage;
import com.adstream.automate.babylon.sut.pages.admin.metadata.GlobalCommonTrafficMetadataPage;
import com.adstream.automate.babylon.sut.pages.admin.metadata.GlobalMetadataPage;
import com.adstream.automate.babylon.sut.pages.admin.metadata.MetadataPage;
import com.adstream.automate.babylon.sut.pages.admin.passwords.GlobalPasswordsPage;
import com.adstream.automate.babylon.sut.pages.admin.people.*;
import com.adstream.automate.babylon.sut.pages.admin.people.search.GlobalAdminSearchUsersPage;
import com.adstream.automate.babylon.sut.pages.admin.relatedFiles.RelatedFilesManagementPage;
import com.adstream.automate.babylon.sut.pages.admin.roles.GlobalAdminRolesPage;
import com.adstream.automate.babylon.sut.pages.admin.roles.RolesDefPage;
import com.adstream.automate.babylon.sut.pages.admin.roles.RolesPage;
import com.adstream.automate.babylon.sut.pages.admin.roles.elements.CreateNewRolePopUpWindow;
import com.adstream.automate.babylon.sut.pages.admin.tnc.TermsAndConditionsPage;
import com.adstream.automate.babylon.sut.pages.admin.views.ViewAssetManagementPage;
import com.adstream.automate.babylon.sut.pages.admin.views.ViewAssetManagementSettingsPage;
import com.adstream.automate.babylon.sut.pages.admin.views.ViewAssetPage;
import com.adstream.automate.babylon.sut.pages.admin.views.ViewVideoAssetManagementPage;
import com.adstream.automate.babylon.sut.pages.admin.watermarking.WaterMarkingManagementPage;
import com.adstream.automate.babylon.sut.pages.asset.preview.AssetPreviewInfoPage;
import com.adstream.automate.babylon.sut.pages.asset.preview.AssetPreviewPage;
import com.adstream.automate.babylon.sut.pages.asset.preview.NewAssetPreviewPage;
import com.adstream.automate.babylon.sut.pages.file.preview.AnnotationsPage;
import com.adstream.automate.babylon.sut.pages.file.preview.FilePreviewCommentsPage;
import com.adstream.automate.babylon.sut.pages.file.preview.FilePreviewInfoPage;
import com.adstream.automate.babylon.sut.pages.file.preview.FilePreviewPage;
import com.adstream.automate.babylon.sut.pages.library.AdbankAddFileToLibraryPage;
import com.adstream.automate.babylon.sut.pages.library.LibrarySearchResultPage;
import com.adstream.automate.babylon.sut.pages.library.collections.AdbankLibraryPage;
import com.adstream.automate.babylon.sut.pages.library.elements.AdbankLibraryRelatedAssetsPage;
import com.adstream.automate.babylon.sut.pages.library.elements.AdbankLibraryRelatedProjectsPage;
import com.adstream.automate.babylon.sut.pages.library.elements.AdbankLibraryAssetAttachmentsPage;
import com.adstream.automate.babylon.sut.pages.library.elements.AdbankLibraryAssetsInfoPage;
import com.adstream.automate.babylon.sut.pages.library.elements.AdbankLibraryAssetsUsageRightsPage;
import com.adstream.automate.babylon.sut.pages.library.elements.AdbankLibraryAssetsDestinationPage;
import com.adstream.automate.babylon.sut.pages.library.elements.AdbankLibraryPresentationsAssetsPage;
import com.adstream.automate.babylon.sut.pages.library.elements.AdbankLibraryAssetsActivityPage;
import com.adstream.automate.babylon.sut.pages.library.elements.AdbankLibraryPresentationsActivityPage;
import com.adstream.automate.babylon.sut.pages.library.elements.AdbankLibraryAllPresentationsPage;
import com.adstream.automate.babylon.sut.pages.library.elements.AdbankLibraryPresentationsSettingsPage;
import com.adstream.automate.babylon.sut.pages.library.elements.AdbankLibraryPresentationsLayoutPage;
import com.adstream.automate.babylon.sut.pages.library.elements.AdbankLibraryPresentationsBrandingPage;
import com.adstream.automate.babylon.sut.pages.library.elements.AdbankLibraryTrashPage;
import com.adstream.automate.babylon.sut.pages.library.elements.AdbankLibraryTrashAssetsInfoPage;
import com.adstream.automate.babylon.sut.pages.library.elements.PLUploaderPage;
import com.adstream.automate.babylon.sut.pages.library.elements.AdbankLibraryAssetFramesPage;
import com.adstream.automate.babylon.sut.pages.library.inbox.AdbankSharedCollectionsPage;
import com.adstream.automate.babylon.sut.pages.library.presentations.AdbankLibraryPresentationsPage;
import com.adstream.automate.babylon.sut.pages.library.presentations.AdbankPresentationPreviewPage;
import com.adstream.automate.babylon.sut.pages.library.presentations.AdbankPresentationViewPage;
import com.adstream.automate.babylon.sut.pages.login.ElizabethArdenLoginPage;
import com.adstream.automate.babylon.sut.pages.login.LoginPage;
import com.adstream.automate.babylon.sut.pages.mediamanager.*;
import com.adstream.automate.babylon.sut.pages.oneDelivery.*;
import com.adstream.automate.babylon.sut.pages.ordering.*;
import com.adstream.automate.babylon.sut.pages.publicpage.PublicFileViewPage;
import com.adstream.automate.babylon.sut.pages.refreshpassword.RefreshPasswordwithoutResetPage;
import com.adstream.automate.babylon.sut.pages.refreshpassword.ResetPasswordPage;
import com.adstream.automate.babylon.sut.pages.registration.RegistrationPage;
import com.adstream.automate.babylon.sut.pages.registration.RegistrationWindow;
import com.adstream.automate.babylon.sut.pages.traffic.*;
import com.adstream.automate.babylon.sut.pages.traffic.element.ApprovePopUp;
import com.adstream.automate.babylon.sut.pages.traffic.element.MasterArrivedPopup;
import com.adstream.automate.babylon.sut.pages.traffic.element.ReassignOrdersInTraffic;
import com.adstream.automate.babylon.sut.pages.traffic.element.TrafficNewTabPopUp;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.page.PageFactory;

/**
 * Created by IntelliJ IDEA.
 * User: savitskiy-a
 * Date: 24.01.12
 * Time: 13:16
 */
public class PageCreator extends PageFactory {
    public PageCreator(ExtendedWebDriver webDriver) {
        super(webDriver);
    }

    public LoginPage getLoginPage() {
        return getPage(LoginPage.class);
    }
    public ElizabethArdenLoginPage getElizabethArdenLoginPage() {
        return getPage(ElizabethArdenLoginPage.class);
    }

    public RegistrationPage getRegistrationPage() {
        return getPage(RegistrationPage.class);
    }

    public ResetPasswordPage getRefreshPasswordPage() {
        return getPage(ResetPasswordPage.class);
    }

    public RefreshPasswordwithoutResetPage getRefreshPasswordwithoutResetPage() {
        return getPage(RefreshPasswordwithoutResetPage.class);
    }

    public BasePage getBasePage() {
        return getPage(BasePage.class);
    }

    public BaseAdminPage getBaseAdminPage() {
        return getPage(BaseAdminPage.class);
    }

    public BaseAdBankPage getBaseAdBankPage() {
        return getPage(BaseAdBankPage.class);
    }

    public UsersPage getUsersPage() {
        return getPage(UsersPage.class);
    }

    public AgencyProjectTeamPage getAgencyProjectTeamPage() {
        return getPage(AgencyProjectTeamPage.class);
    }

    public UsersGroupPage getUsersGroupPage() {
        return getPage(UsersGroupPage.class);
    }

    public CreateUserPage getCreateUserPage() {
        return getPage(CreateUserPage.class);
    }

    public EditUserPage getEditUserPage() {
        return getPage(EditUserPage.class);
    }
    public ProfileUserSettingPage getProfileUserPage() {
        return getPage(ProfileUserSettingPage.class);
    }

    public AccountSettingPage getAccountSettingPage() {
        return getPage(AccountSettingPage.class);
    }

    public MyNotificationsSettingPage getMyNotificationSettingPage() {
        return getPage(MyNotificationsSettingPage.class);
    }

    public MailTemplatesNotificationSettingsPage getMailTemplatesNotificationSettingPage() {
        return getPage(MailTemplatesNotificationSettingsPage.class);
    }
    public UserProjectsPage getUserProjectsPage() {
        return getPage(UserProjectsPage.class);
    }

    public UserLibraryPage getUserLibraryPage() {
        return getPage(UserLibraryPage.class);
    }

    public UserDeliveryPage getUserDeliveryPage() {
        return getPage(UserDeliveryPage.class);
    }

    public UserApplicationsPage getUserApplicationsPage() {
        return getPage(UserApplicationsPage.class);
    }

    public NotificationsSettingPage getNotificationSettingPage() {
        return getPage(NotificationsSettingPage.class);
    }

    public NotificationsSettingPageForGA getNotificationSettingPageForGA() {
        return getPage(NotificationsSettingPageForGA.class);
    }

    public RolesPage getRolesPage() {
        return getPage(RolesPage.class);
    }

    public RolesDefPage getRolesDefPage() {
        return getPage(RolesDefPage.class);
    }

    public TermsAndConditionsPage getTermsAndConditionsPage() {
        return getPage(TermsAndConditionsPage.class);
    }

    public GlobalAdminRolesPage getGlobalRolesPage() {
        return getPage(GlobalAdminRolesPage.class);
    }

    public AgencyOverviewPage getAgencyOverviewPage() {
        return getPage(AgencyOverviewPage.class);
    }

    public AgencyMarketPage getAgencyMarketPage() {
        return getPage(AgencyMarketPage.class);
    }


    public SuperHubMembersPage getSuperHubMembersPage() {
        return getPage(SuperHubMembersPage.class);
    }


    public HubMembersPage getHubMembersPage() {
        return getPage(HubMembersPage.class);
    }

    public AgencyCreateMarketPage getAgencyCreateMarketPage() {
        return getPage(AgencyCreateMarketPage.class);
    }

    public AgencyGlobalAccessRulesPage getAgencyGlobalAccessRulesPage() {
        return getPage(AgencyGlobalAccessRulesPage.class);
    }

    public AgencyEditMarketPage getAgencyEditMarketPage() {
        return getPage(AgencyEditMarketPage.class);
    }

    public DestinationPage getDestinationPage() {
        return getPage(DestinationPage.class);
    }

    public AgencyPartnersPage getAgencyPartnersPage() {
        return getPage(AgencyPartnersPage.class);
    }

    public AgencySecurityPage getAgencySecurityPage() {
        return getPage(AgencySecurityPage.class);
    }

    public AgencyMetadataMappingPage getAgencyMetadataMappingPage() {
        return getPage(AgencyMetadataMappingPage.class);
    }

    public AgencyMetadataMappingCreatePage getAgencyMetadataMappingCreatePage() {
        return getPage(AgencyMetadataMappingCreatePage.class);
    }

    public AgencyMetadataMappingEditPage getAgencyMetadataMappingEditPage() {
        return getPage(AgencyMetadataMappingEditPage.class);
    }

    public MetadataPage getMetadataPage() {
        return getPage(MetadataPage.class);
    }

    public GlobalMetadataPage getGlobalMetadataPage() {
        return getPage(GlobalMetadataPage.class);
    }

    public GlobalCommonOrderingMetadataPage getGlobalCommonOrderingMetadataPage() {
        return getPage(GlobalCommonOrderingMetadataPage.class);
    }

    public GlobalCommonTrafficMetadataPage getGlobalCommonTrafficMetadataPage() {
        return getPage(GlobalCommonTrafficMetadataPage.class);
    }

   public ViewVideoAssetManagementPage getViewVideoAssetManagementPage() {
        return getPage(ViewVideoAssetManagementPage.class);
    }

    // NGN-16212 - QAA: Global Admin can Search for BU - By Geethanjali- code Starts
    public ViewAssetManagementPage getViewAssetManagementPage() {

        return getPage(ViewAssetManagementPage.class);
    }

    public ViewAssetPage getViewAssetPage() {

        return getPage(ViewAssetPage.class);
    }

    public RelatedFilesManagementPage getRelatedManagementPage() {
        return getPage(RelatedFilesManagementPage.class);
    }

    public WaterMarkingManagementPage getWaterMarkingManagementPage() {
        return getPage(WaterMarkingManagementPage.class);
    }

    public ViewAssetManagementSettingsPage getViewAssetManagementSettingsPage() {
        return getPage(ViewAssetManagementSettingsPage.class);
    }

    // NGN-16212 - QAA: Global Admin can Search for BU - By Geethanjali- code Ends

    public MyProfilePage getMyProfilePage() {
        return getPage(MyProfilePage.class);
    }

    public MyAccountSettingPage getMyAccountSettingPage() {
        return getPage(MyAccountSettingPage.class);
    }

    public AdBankNotificationsPage getNotificationsPage() {
        return getPage(AdBankNotificationsPage.class);
    }

    public AdbankDashboardPage getDashboardPage() {
        return getPage(AdbankDashboardPage.class);
    }
    public AdbankProjectsCreatePage getCreateProjectPage() {
        return getPage(AdbankProjectsCreatePage.class);
    }

    public AdbankWorkRequestCreatePage getWorkRequestCreatePage() {
        return getPage(AdbankWorkRequestCreatePage.class);
    }

    public AdbankProjectFromTemplateCreatePage getCreateProjectFromTemplatePage() {
        return getPage(AdbankProjectFromTemplateCreatePage.class);
    }

    public AdbankTemplateFromProjectCreatePage getCreateTemplateFromProjectPage() {
        return getPage(AdbankTemplateFromProjectCreatePage.class);
    }
    public AdbankProjectsListPage getProjectListPage() {
        webDriver.sleep(5000);
        return getPage(AdbankProjectsListPage.class);
    }

    public AdbankProjectsListPage getProjectListPage_withOutDelay() {
        return getPage(AdbankProjectsListPage.class);
    }

    public GlobalPasswordsPage getGlobalPasswordsPage() { return getPage(GlobalPasswordsPage.class); }

    // NGN-16208 - QAA: Global Admin can Search for BU - By Geethanjali- code starts
    public GlobalAdminSearchAgencyPage getGlobalAdminSearchAgencyPage() {
        return getPage(GlobalAdminSearchAgencyPage.class);

    }
    // NGN-16208 - QAA: Global Admin can Search for BU - By Geethanjali- code Ends
    public HolidaysPage getHolidaysPage() { return getPage(HolidaysPage.class); }

    public GlobalAdminSearchUsersPage getGlobalAdminSearchUsersPage() {
        return getPage(GlobalAdminSearchUsersPage.class);
    }

    public AdbankWorkRequestOverviewPage getWorkRequestOverviewPage() {
        return getPage(AdbankWorkRequestOverviewPage.class);
    }

    public AdbankWorkRequestTeamsPage getWorkRequestTeamsPage() {
        return getPage(AdbankWorkRequestTeamsPage.class);
    }

    public AdbankWorkRequestTemplateCreatePage getWorkRequestTemplateCreatePage() {
        return getPage(AdbankWorkRequestTemplateCreatePage.class);
    }

    public AdbankWorkRequestTemplateOverviewPage getWorkRequestTemplateOverviewPage() {
        return getPage(AdbankWorkRequestTemplateOverviewPage.class);
    }

    public AdbankWorkRequestTemplateFilesPage getWorkRequestTemplateFilesPage() {
        return getPage(AdbankWorkRequestTemplateFilesPage.class);
    }
    public AdbankWorkRequestFilesPage getWorkRequestFilesPage() {
        return getPage(AdbankWorkRequestFilesPage.class);
    }

    public AdbankProjectOverviewPage getProjectOverviewPage() {
        return getPage(AdbankProjectOverviewPage.class);
    }

    public AdbankProjectFilesPage getProjectFilesPage() {
        return getPage(AdbankProjectFilesPage.class);
    }

    public AdbankProjectFileInfoPage getProjectFileInfoPage() {
        return getPage(AdbankProjectFileInfoPage.class);
    }

    public AnnotationsPage getAnnotationsPage() {
        return getPage(AnnotationsPage.class);
    }

    public AdbankFileCommentsPage getProjectFileCommentsPage() {
        return getPage(AdbankFileCommentsPage.class);
    }

    public AdbankFileUsageRightsPage getProjectFileUsageRightsPage() {
        return getPage(AdbankFileUsageRightsPage.class);
    }

    public AdbankFileAttachmentsPage getProjectFileAttachmentsPage() { return getPage(AdbankFileAttachmentsPage.class); }

    public AdbankFileFramesPage getProjectFileFramesPage() { return getPage(AdbankFileFramesPage.class); }

    public AdbankLibraryAssetFramesPage getLibraryAssetsFramesPage() { return getPage(AdbankLibraryAssetFramesPage.class); }

    public AdbankProjectFileRelatedFilesPage getAdbankProjectFileRelatedFilesPage() { return getPage(AdbankProjectFileRelatedFilesPage.class); }

    public AdbankLibraryRelatedAssetsPage getAdbankLibraryRelatedAssetsPage() { return getPage(AdbankLibraryRelatedAssetsPage.class); }

    public AdbankLibraryRelatedProjectsPage getAdbankLibraryRelatedProjectsPage() {
        return getPage(AdbankLibraryRelatedProjectsPage.class);
    }

    public AdbankLibraryAssetAttachmentsPage getAdbankLibraryAssetAttachmentsPage() { return getPage(AdbankLibraryAssetAttachmentsPage.class); }

    public AdbankFileApprovalsPage getProjectFileApprovalsPage() {
        return getPage(AdbankFileApprovalsPage.class);
    }

    public AdbankTemplateFileInfoPage getTemplateFileInfoPage() {
        return getPage(AdbankTemplateFileInfoPage.class);
    }

    public AdbankProjectFileActivityPage getProjectFileActivityPage() {
        return getPage(AdbankProjectFileActivityPage.class);
    }

    public AdbankLibraryAssetsInfoPage getLibraryAssetsInfoPage() {
        return getPage(AdbankLibraryAssetsInfoPage.class);
    }

    public AdbankLibraryAssetsUsageRightsPage getLibraryAssetsUsageRightsPage() {
        return getPage(AdbankLibraryAssetsUsageRightsPage.class);
    }

    public AdbankLibraryAssetsDestinationPage getAdbankLibraryAssetsDestinationPage() {
        return getPage(AdbankLibraryAssetsDestinationPage.class);
    }

    public AdbankProjectFilesUploadPage getProjectFilesUploadPage() {
        return getPage(AdbankProjectFilesUploadPage.class);
    }

    public AdbankProjectTrashPage getProjectTrashPage() {
        return getPage(AdbankProjectTrashPage.class);
    }

    public AdbankProjectTeamsPage getProjectTeamsPage() {
        return getPage(AdbankProjectTeamsPage.class);
    }

    public AdbankProjectApprovalsReceivedPage getProjectApprovalsReceivedPage() {
        return getPage(AdbankProjectApprovalsReceivedPage.class);
    }

    public AdbankProjectApprovalsSubmittedPage getProjectApprovalsSubmittedPage() {
        return getPage(AdbankProjectApprovalsSubmittedPage.class);
    }

    public AdbankProjectApprovalsNotStartedPage getProjectApprovalsNotStartedPage() {
        return getPage(AdbankProjectApprovalsNotStartedPage.class);
    }

    public AdbankProjectsApprovalsReceivedPage getProjectsApprovalsReceivedPage() {
        return getPage(AdbankProjectsApprovalsReceivedPage.class);
    }

    public AdbankProjectApprovalsPreviewFilePage getAdbankProjectApprovalsPreviewFilePage() {
        return getPage(AdbankProjectApprovalsPreviewFilePage.class);
    }

    public AdbankProjectsApprovalsSubmittedPage getProjectsApprovalsSubmittedPage() {
        return getPage(AdbankProjectsApprovalsSubmittedPage.class);
    }

    public AdbankProjectsApprovalsNotStartedPage getProjectsApprovalsNotStartedPage() {
        return getPage(AdbankProjectsApprovalsNotStartedPage.class);
    }

    public ApprovalTemplatesPage getApprovalTemplatesPage() {
        return getPage(ApprovalTemplatesPage.class);
    }

    public ApprovalTemplatePage getApprovalTemplatePage() {
        return getPage(ApprovalTemplatePage.class);
    }

    public AdBankTemplateTeamsPage getTemplateTeamsPage() {
        return getPage(AdBankTemplateTeamsPage.class);
    }

    public AdbankProjectSettingsPage getProjectSettingsPage() {
        return getPage(AdbankProjectSettingsPage.class);
    }

    public AdbankTemplatesListPage getTemplateListPage() {
        return getPage(AdbankTemplatesListPage.class);
    }

    public AdbankProjectFilesPage getAdbankProjectFilesPage() { return getPage(AdbankProjectFilesPage.class); }

    public AdbankWorkRequestTemplatesListPage getWorkRequestTemplatesListPage() {
        return getPage(AdbankWorkRequestTemplatesListPage.class);
    }

    public AdbankWorkRequestListPage getWorkRequestListPage() {
        return getPage(AdbankWorkRequestListPage.class);
    }

    public AdbankTemplateListWithSizePage getTemplateListWithSizePage() {
        return getPage(AdbankTemplateListWithSizePage.class);
    }

    public AdbankTemplatesCreatePage getTemplateCreatePage() {
        return getPage(AdbankTemplatesCreatePage.class);
    }
    //TODO get rid NGN-6679 - no more overview page in template
    public AdbankTemplateOverviewPage getTemplateOverviewPage() {
        return getPage(AdbankTemplateOverviewPage.class);
    }

    public AdbankTemplateFilesPage getTemplateFilesPage() {
        return getPage(AdbankTemplateFilesPage.class);
    }

    public AdbankTemplateTrashPage getTemplateTrashPage() {
        return getPage(AdbankTemplateTrashPage.class);
    }

    public AdbankTemplateFilesWithFoldersPage getTemplateFilesWithFoldersPage() {
        return getPage(AdbankTemplateFilesWithFoldersPage.class);
    }

    public AdbankTemplateFilesUploadPage getTemplateFilesUploadPage() {
        return getPage(AdbankTemplateFilesUploadPage.class);
    }

    public CreateNewRolePopUpWindow getCreateNewRolePopUpWindow() {
        return getPage(CreateNewRolePopUpWindow.class);
    }
    public AdbankAddressbookPage getAdbankAddressbookPage() {
        return getPage(AdbankAddressbookPage.class);
    }

    public TrafficNewTabPopUp getTrafficNewPopUpWindow(){
        return getPage(TrafficNewTabPopUp.class);
    }

    public MasterArrivedPopup getMasterArrivedPopUpWindow(){
        return getPage(MasterArrivedPopup.class);
    }

    public ReassignOrdersInTraffic getReassignOrdersPopUpWindow(){
        return getPage(ReassignOrdersInTraffic.class);
    }

    public ApprovePopUp getApprovePopUpPage(){
        return getPage(ApprovePopUp.class);
    }

    public AdbankAddressbookAddUsersPopUp getAdbankAddressbookAddUsersPopUp() {
        return getPage(AdbankAddressbookAddUsersPopUp.class);
    }

    public AdbankAddFileToLibraryPage getAdbankAddFileToLibraryPage() {
        return getPage(AdbankAddFileToLibraryPage.class);
    }

    public CategoriesPage getCategoriesPage() {
        return getPage(CategoriesPage.class);
    }

    public AdbankProjectSearchResultPage getProjectSearchResultPage() {
        return getPage(AdbankProjectSearchResultPage.class);
    }

    public AdbankTemplateSearchResultPage getTemplateSearchResultPage() {
        return getPage(AdbankTemplateSearchResultPage.class);
    }

    public AdbankFilesAndFoldersSearchResultPage getFilesAndFoldersSearchResultPage() {
        return getPage(AdbankFilesAndFoldersSearchResultPage.class);
    }

    public AdbankLibraryPresentationsPage getLibraryPresentationsPage() {
        return getPage(AdbankLibraryPresentationsPage.class);
    }

    public AdbankLibraryPresentationsAssetsPage getLibraryPresentationsAssetsPage() {
        return getPage(AdbankLibraryPresentationsAssetsPage.class);
    }

    public AdbankLibraryAssetsActivityPage getAdbankLibraryAssetsActivityPage() {
        return getPage(AdbankLibraryAssetsActivityPage.class);
    }

    //!--QA-345-Warning Message when adding to Library existing asset by Geethanjali.K code change Starts
    public AdbankFilesPage getAdbankFilesPage() {
        return getPage(AdbankFilesPage.class);
    }
    //!--QA-345-Warning Message when adding to Library existing asset by Geethanjali.K code change Ends
    public AdbankLibraryPresentationsActivityPage getLibraryPresentationsActivityPage() {
        return getPage(AdbankLibraryPresentationsActivityPage.class);
    }

    public AdbankLibraryAllPresentationsPage getLibraryAllPresentationsPage() {
        return getPage(AdbankLibraryAllPresentationsPage.class);
    }

    public AdbankLibraryPresentationsSettingsPage getLibraryPresentationsSettingsPage() {
        return getPage(AdbankLibraryPresentationsSettingsPage.class);
    }

    public AdbankLibraryPresentationsLayoutPage getLibraryPresentationsLayoutPage() {
        return getPage(AdbankLibraryPresentationsLayoutPage.class);
    }

    public AdbankLibraryPresentationsBrandingPage getLibraryPresentationsBrandingPage() {
        return getPage(AdbankLibraryPresentationsBrandingPage.class);
    }

    public AdbankPresentationViewPage getPresentationViewPage() {
        return getPage(AdbankPresentationViewPage.class);
    }

    public AdbankPresentationPreviewPage getPresentationPreviewPage() {
        return getPage(AdbankPresentationPreviewPage.class);
    }

    public AdbankLibraryPage getLibraryPage() {
        return getPage(AdbankLibraryPage.class);
    }

    public AdbankSharedCollectionsPage getSharedCollectionsPage() {
        return getPage(AdbankSharedCollectionsPage.class);
    }

    public NewAdbankLibrarySharedCollectionsPage getNewAdbankLibrarySharedCollectionsPage() {
        return getPage(NewAdbankLibrarySharedCollectionsPage.class);
    }

    public AdbankLibraryTrashPage getLibraryTrashPage() {
        return getPage(AdbankLibraryTrashPage.class);
    }

    public NewLibraryTrashPage getNewLibraryTrashPage() {
        return getPage(NewLibraryTrashPage.class);
    }

    public NewLibraryGlobalSearchPage getNewLibraryGlobalSearchPage() {
        return getPage(NewLibraryGlobalSearchPage.class);
    }

    public NewLibraryGlobalSearchResultsPage getNewLibraryGlobalSearchResultsPage() {
        return getPage(NewLibraryGlobalSearchResultsPage.class);
    }

    public AdbankLibraryTrashAssetsInfoPage getLibraryTrashAssetsInfoPage() {
        return getPage(AdbankLibraryTrashAssetsInfoPage.class);
    }

    public PLUploaderPage getPLUploaderPage() {
        return getPage(PLUploaderPage.class);
    }

    public AdBankTeamsPage getAdBankTeamsPage(){
        return getPage(AdBankTeamsPage.class);
    }

    public AdminSystemBrandingPage getAdminSystemBrandingPage() {
        return getPage(AdminSystemBrandingPage.class);
    }

    public GlobalAdminSystemBrandingPage getGlobalAdminSystemBrandingPage() {
        return getPage(GlobalAdminSystemBrandingPage.class);
    }

    public AdminLoginPage getAdminLoginPage() {
        return getPage(AdminLoginPage.class);
    }

    public AdbankBillingPage getBillingPage() {
        return getPage(AdbankBillingPage.class);
    }

    public AdbankFileVersionHistoryPage getProjectFileVersionHistoryPage() {
        return getPage(AdbankFileVersionHistoryPage.class);
    }

    public LibrarySearchResultPage getLibrarySearchResultPage() {
        return getPage(LibrarySearchResultPage.class);
    }

    public RegistrationWindow getRegistrationWindow() {
        return getPage(RegistrationWindow.class);
    }

    public PublicFileViewPage getPublicFileViewPage() {
        return getPage(PublicFileViewPage.class);
    }

    public FilePreviewPage getFilePreviewPage() {
        return getPage(FilePreviewPage.class);
    }

    public AssetPreviewPage getAssetPreviewPage() {
        return getPage(AssetPreviewPage.class);
    }

    public FilePreviewInfoPage getFilePreviewInfoPage() {
        return getPage(FilePreviewInfoPage.class);
    }

    public AssetPreviewInfoPage getAssetPreviewInfoPage() {
        return getPage(AssetPreviewInfoPage.class);
    }

    public FilePreviewCommentsPage getFilePreviewCommentsPage() {
        return getPage(FilePreviewCommentsPage.class);
    }

    /*
        ORDERING PAGES
     */

    public DeliverySettingPage getDeliverySettingPage() {
        return getPage(DeliverySettingPage.class);
    }

    public MyDeliverySettingPage getMyDeliverySettingPage() {
        return getPage(MyDeliverySettingPage.class);
    }

    public BaseOrderingPage getBaseOrderingPage() {
         return getPage(BaseOrderingPage.class);
    }

    public OrderingPage getOrderingPage() {
        return getPage(OrderingPage.class);
    }

    public OrderItemPage getOrderItemPage() {
        return getPage(OrderItemPage.class);
    }

    public OrderProceedPage getOrderProceedPage() {
        return getPage(OrderProceedPage.class);
    }

    public ViewBillingPage getViewBillingPage() {
        return getPage(ViewBillingPage.class);
    }
    public ViewDestinationDetailsPage getOrderViewDestinationDetailsPage() {
        return getPage(ViewDestinationDetailsPage.class);
    }

    public OrderSummaryPage getOrderSummaryPage() { return getPage(OrderSummaryPage.class); }

    // NGN-16233
    public OrderEditSummaryPage getOrderEditSummaryPage() { return getPage(OrderEditSummaryPage.class); }

    public ViewMediaDetailsPage getViewMediaDetailsPage() {
        return getPage(ViewMediaDetailsPage.class);
    }

    public ViewMediaContentDetailsPage getViewMediaContentDetailsPage() {
        return getPage(ViewMediaContentDetailsPage.class);
    }

    public ViewDraftDeliveryReportPage getViewDraftDeliveryReportPage() {
        return getPage(ViewDraftDeliveryReportPage.class);
    }

    public FailedOrderPage getFailedOrderPage() {
        return getPage(FailedOrderPage.class);
    }

    public TrafficOrdersListPage getTrafficOrderListPage(){ return getPage(TrafficOrdersListPage.class);}

    public TrafficOrderItemsListPage getTrafficOrderItemsListPage(){
        return getPage(TrafficOrderItemsListPage.class);
    }

    public TrafficOrderSummaryPage getTrafficOrderSummaryPage(){
        return getPage(TrafficOrderSummaryPage.class);
    }

    public TrafficOrderEditPage getTrafficOrderEditPage(){
        return getPage(TrafficOrderEditPage.class);
    }

    public TrafficOrderItemPage getTrafficOrderItemPage(){
        return getPage(TrafficOrderItemPage.class);
    }

    public TrafficClockDetailsPage getTrafficClockDetailsPage(){
        return getPage(TrafficClockDetailsPage.class);
    }

    public TrafficOrderPage getTrafficOrderPage(){
        return getPage(TrafficOrderPage.class);
    }

    public CollectionDetailsPage getCollectionDetailsPage(){
        return getPage(CollectionDetailsPage.class);
    }

    public GlobalAdminCreateUserPage getGlobalAdminCreateUserPage() {
        return getPage(GlobalAdminCreateUserPage.class);
    }

    public GlobalAdminUsersPage getGlobalAdminUsersPage() {
        return getPage(GlobalAdminUsersPage.class);
    }

    // AdCost
    public AdCostsOverviewPage getAdCostsOverviewPage(){ return getPage(AdCostsOverviewPage.class); }

    public AdCostsAdminUserAccessPage getAdCostsAdminUserAccessPage(){ return getPage(AdCostsAdminUserAccessPage.class); }

    public AdCostsAdminUserOverridePage getAdCostsAdminUserOverridePage(){ return getPage(AdCostsAdminUserOverridePage.class); }

    public AdCostsVendorPage getAdCostsVendorPage(){ return getPage(AdCostsVendorPage.class); }

    public AdCostsDetailsPage getAdCostsCostDetailsPage(){ return getPage(AdCostsDetailsPage.class); }

    public AdCostsProductionDetailsPage getAdCostsProductionDetailsPage(){ return getPage(AdCostsProductionDetailsPage.class); }

    public AdCostsProductionDetailsPage.AdCostsTravelCostFormPage getAdCostsTravelCostFormPage(){ return getPage(AdCostsProductionDetailsPage.AdCostsTravelCostFormPage.class); }

    public AdCostsExpectedAssetsPage getAdCostsExpectedAssetsPage(){ return getPage(AdCostsExpectedAssetsPage.class); }

    public AdCostsItemsPage getAdCostsItemsPage(){ return getPage(AdCostsItemsPage.class); }

    public AdCostsSupportingDocumentsPage getAdCostsSupportingDocumentsPage(){ return getPage(AdCostsSupportingDocumentsPage.class); }

    public AdCostsApprovalsPage getAdCostsApprovalsPage(){ return getPage(AdCostsApprovalsPage.class); }

    public AdCostsUsageBuyoutDetailsPage getAdCostsUsageBuyoutDetailsPage(){ return getPage(AdCostsUsageBuyoutDetailsPage.class); }

    public AdCostsNegotiatedTermsPage getAdCostsNegotiatedTermsPage(){ return getPage(AdCostsNegotiatedTermsPage.class); }

    public AdCostsReviewPage getAdCostsReviewPage(){ return getPage(AdCostsReviewPage.class); }

    public AdCostsAssociatedAssetsPage getAdCostsAssociatedAssetsPage(){ return getPage(AdCostsAssociatedAssetsPage.class); }

    public AdCostsCurrencyPage getAdCostsCurrencyPage(){ return getPage(AdCostsCurrencyPage.class); }

    public AdCostsDictionaryPage getAdCostsDictionaryPage(){ return getPage(AdCostsDictionaryPage.class); }

    public CollectionDataPage getCollectionDataPage(){
        return getPage(CollectionDataPage.class);
    }


    public CollectionPage getCollectionPage(){
        return getPage(CollectionPage.class);
    }

    public NewAdbankLibraryAssetsPage getNewAdbankLibraryAssetsPage(){
        return getPage(NewAdbankLibraryAssetsPage.class);
    }

    public LibraryAsset getLibraryPageNEWLIB(String collectionName){
        if (collectionName.equalsIgnoreCase("Everything") || collectionName.equalsIgnoreCase("")) {
            return getPage(NewAdbankLibraryPage.class);
        }
        return getPage(CollectionDetailsPage.class);

    }

    public LibraryAsset getLibraryFilterPage(String collectionName){
        if (collectionName.equalsIgnoreCase("Everything") || collectionName.equalsIgnoreCase("")) {
            return getPage(NewAdbankLibraryPage.class);
        }
        return getPage(CollectionFilterPage.class);

    }

    public LibraryAssetsInfoPage getLibraryAssetsInfoPageNEWLIB(){
        return getPage(LibraryAssetsInfoPage.class);
    }

    public NewAdbankLibraryPage getNewAdbankLibraryPage(){
        return getPage(NewAdbankLibraryPage.class);
    }

    public CollectionFilterPage getCollectionFilterPage(){
        return getPage(CollectionFilterPage.class);
    }

    public NewAdbankLibraryAssetAttachmentsPage getNewAdbankLibraryAssetAttachmentsPage() { return getPage(NewAdbankLibraryAssetAttachmentsPage.class); }

    public NewAdbankLibraryAssetRelatedProjectsPage getNewAdbankLibraryAssetRelatedProjectsPage() { return getPage(NewAdbankLibraryAssetRelatedProjectsPage.class); }

    public NewAdbankLibraryAssetsDestinationPage getNewAdbankLibraryAssetsDestinationPage() {
        return getPage(NewAdbankLibraryAssetsDestinationPage.class);
    }

    public NewAssetPreviewPage getNewAssetPreviewPage() {
        return getPage(NewAssetPreviewPage.class);
    }

    public LibMultiEditAssetMetadataPage getLibMultiEditAssetMetadataPage(){
        return getPage(LibMultiEditAssetMetadataPage.class);
    }

    public LibSingleEditAssetMetadataPage getSingleLibEditAssetMetadataPage(){
        return getPage(LibSingleEditAssetMetadataPage.class);
    }

    public NewAdbankLibraryAssetsActivityPage geNewAdbankLibraryAssetsActivityPage() {
        return getPage(NewAdbankLibraryAssetsActivityPage.class);
    }
    public NewLibraryAssetUsageRightsPage getNewLibraryAssetUsageRightsPage() {
        return getPage(NewLibraryAssetUsageRightsPage.class);
    }

    /** Media Manager **/
    public MediaManagerLoginPage getMediaMLoginPage() {
        return getPage(MediaManagerLoginPage.class);
    }

    public MediaManagerFileInfoPage getMediaManagerFileInfoPage() {
        return getPage(MediaManagerFileInfoPage.class);
    }

    public MediaManagerLoginPage getMMLoginPage() {
        return getPage(MediaManagerLoginPage.class);
    }

    public MediaManagerUploadPage getMediaUploadPage() {
        return getPage(MediaManagerUploadPage.class);
    }

    public MediaCheckerEditPage getMediaCheckerEditPage() {
        return getPage(MediaCheckerEditPage.class);
    }

    public MediaMangerBasePage getMMBasePage() {
        return getPage(MediaMangerBasePage.class);
    }

    public MediaManagerQCReportPage getMediaManagerQCReportPage() {
        return getPage(MediaManagerQCReportPage.class);
    }

    public MediaManagerUploadPage getMMUploadPage() {
        return getPage(MediaManagerUploadPage.class);
    }

    public MediaManagerHistoryPage getMMHistoryPage() {
        return getPage(MediaManagerHistoryPage.class);
    }

    public MediaCheckerHistoryPage getMCHistoryPage() {
        return getPage(MediaCheckerHistoryPage.class);
    }

    public MediaCheckerPage getMediaCheckerPage() {
        return getPage(MediaCheckerPage.class);
    }

    public MediaCheckerAssetInfoPage getMediaCheckerAssetInfoPage() {
        return getPage(MediaCheckerAssetInfoPage.class);
    }

    public MediaCheckerAssetEditPage getMediaCheckerAssetEditPage() {
        return getPage(MediaCheckerAssetEditPage.class);
    }

    /** One Delivery **/
    public OneDeliveryBasePage getOneDeliveryBasePage() {
        return getPage(OneDeliveryBasePage.class);
    }

    public OneDeliveryNewOrderPage getOneDeliveryNewOrderPage() {
        return getPage(OneDeliveryNewOrderPage.class);
    }

    public OneDeliveryOrderItemPage getOneDeliveryOrderItemPage() {
        return getPage(OneDeliveryOrderItemPage.class);
    }

    public OneDeliveryOrderBillingPage getOneDeliveryOrderBillingPage() {
        return getPage(OneDeliveryOrderBillingPage.class);
    }

    public OneDeliveryOrderCompletePage getOneDeliveryOrderCompletePage() {
        return getPage(OneDeliveryOrderCompletePage.class);
    }

    public MediaCheckerMezzInfoPage getMediaCheckerMezzInfoPage() {
        return getPage(MediaCheckerMezzInfoPage.class);
    }

    public MediaCheckerMezzReportPage getMediaCheckerMezzReportPage() {
        return getPage(MediaCheckerMezzReportPage.class);
    }

    public MediaCheckerQCReportPage getMediaCheckerQCReportPage() {
        return getPage(MediaCheckerQCReportPage.class);
    }
}