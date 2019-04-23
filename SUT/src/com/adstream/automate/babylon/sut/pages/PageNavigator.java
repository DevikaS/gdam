package com.adstream.automate.babylon.sut.pages;

import com.adstream.automate.babylon.JsonObjects.Agency;
import com.adstream.automate.babylon.TestsContext;
import com.adstream.automate.babylon.sut.pages.NewLibrary.NewLibraryAssetUsageRightsPage;
import com.adstream.automate.babylon.sut.pages.NewLibrary.pages.*;
import com.adstream.automate.babylon.sut.pages.NewLibrary.pages.CollectionDetailsPage;
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
import com.adstream.automate.babylon.sut.pages.adbank.projects.elements.AdbankFileAttachmentsPage;
import com.adstream.automate.babylon.sut.pages.adbank.projects.elements.AdbankFileFramesPage;
import com.adstream.automate.babylon.sut.pages.adbank.projects.elements.AdbankFileUsageRightsPage;
import com.adstream.automate.babylon.sut.pages.adbank.projects.elements.AdbankProjectFileRelatedFilesPage;
import com.adstream.automate.babylon.sut.pages.adcost.*;
import com.adstream.automate.babylon.sut.pages.admin.AdbankBillingPage;
import com.adstream.automate.babylon.sut.pages.admin.agency.*;
import com.adstream.automate.babylon.sut.pages.admin.agency.agencySearch.GlobalAdminSearchAgencyPage;
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
import com.adstream.automate.babylon.sut.pages.admin.tnc.TermsAndConditionsPage;
import com.adstream.automate.babylon.sut.pages.admin.views.ViewAssetManagementPage;
import com.adstream.automate.babylon.sut.pages.admin.views.ViewAssetManagementSettingsPage;
import com.adstream.automate.babylon.sut.pages.admin.views.ViewAssetPage;
import com.adstream.automate.babylon.sut.pages.admin.views.ViewVideoAssetManagementPage;
import com.adstream.automate.babylon.sut.pages.admin.watermarking.WaterMarkingManagementPage;
import com.adstream.automate.babylon.sut.pages.library.LibrarySearchResultPage;
import com.adstream.automate.babylon.sut.pages.library.collections.AdbankLibraryPage;


import com.adstream.automate.babylon.sut.pages.library.elements.AdbankLibraryTrashPage;
import com.adstream.automate.babylon.sut.pages.library.elements.AdbankLibraryAllPresentationsPage;
import com.adstream.automate.babylon.sut.pages.library.elements.AdbankLibraryPresentationsAssetsPage;
import com.adstream.automate.babylon.sut.pages.library.elements.AdbankLibraryPresentationsActivityPage;
import com.adstream.automate.babylon.sut.pages.library.elements.AdbankLibraryPresentationsSettingsPage;
import com.adstream.automate.babylon.sut.pages.library.elements.AdbankLibraryPresentationsLayoutPage;
import com.adstream.automate.babylon.sut.pages.library.elements.AdbankLibraryPresentationsBrandingPage;
import com.adstream.automate.babylon.sut.pages.library.elements.AdbankLibraryAssetsInfoPage;
import com.adstream.automate.babylon.sut.pages.library.elements.AdbankLibraryRelatedAssetsPage;
import com.adstream.automate.babylon.sut.pages.library.elements.AdbankLibraryRelatedProjectsPage;
import com.adstream.automate.babylon.sut.pages.library.elements.AdbankLibraryAssetAttachmentsPage;


import com.adstream.automate.babylon.sut.pages.library.elements.AdbankLibraryAssetFramesPage;
import com.adstream.automate.babylon.sut.pages.library.elements.AdbankLibraryAssetsActivityPage;
import com.adstream.automate.babylon.sut.pages.library.elements.AdbankLibraryAssetsUsageRightsPage;
import com.adstream.automate.babylon.sut.pages.library.elements.AdbankLibraryAssetsDestinationPage;
import com.adstream.automate.babylon.sut.pages.library.elements.PLUploaderPage;


import com.adstream.automate.babylon.sut.pages.library.inbox.AdbankSharedCollectionsPage;
import com.adstream.automate.babylon.sut.pages.library.presentations.AdbankPresentationPreviewPage;
import com.adstream.automate.babylon.sut.pages.library.presentations.AdbankPresentationViewPage;
import com.adstream.automate.babylon.sut.pages.login.LoginPage;
import com.adstream.automate.babylon.sut.pages.login.LogoutPage;
import com.adstream.automate.babylon.sut.pages.mediamanager.*;
import com.adstream.automate.babylon.sut.pages.oneDelivery.*;
import com.adstream.automate.babylon.sut.pages.ordering.*;
import com.adstream.automate.babylon.sut.pages.traffic.*;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.utils.Common;
import org.apache.log4j.Logger;
import org.openqa.selenium.*;

import java.net.URL;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by IntelliJ IDEA.
 * User: savitskiy-a
 * Date: 24.01.12
 * Time: 13:16
 */
public class PageNavigator extends PageCreator {
    private final Map<Class, String> pageLinksMap = new HashMap<>();
    private final static Logger log = Logger.getLogger(PageNavigator.class);

    public PageNavigator(ExtendedWebDriver webDriver, URL baseUrl) {
        super(webDriver);
        initPageLinksMap(baseUrl);
    }

    private void initPageLinksMap(URL baseUrl) {
        pageLinksMap.put(null, baseUrl.toString());
        pageLinksMap.put(LoginPage.class, baseUrl + "/login");
        pageLinksMap.put(LogoutPage.class, baseUrl + "/logout");
        pageLinksMap.put(UsersPage.class, baseUrl + "/admin#/people%s");
        pageLinksMap.put(UserProjectsPage.class, baseUrl + "/admin#/people/users/%s");
        pageLinksMap.put(UserLibraryPage.class, baseUrl + "/admin#/people/users/%s/library");
        pageLinksMap.put(UserDeliveryPage.class, baseUrl + "/admin#/people/users/%s/delivery");
        pageLinksMap.put(UserApplicationsPage.class, baseUrl + "/admin#/people/users/%s/applications");
        pageLinksMap.put(UsersGroupPage.class, baseUrl + "/admin#/people/teams/%s");
        pageLinksMap.put(CreateUserPage.class, baseUrl + "/admin#/people/users:create");
        pageLinksMap.put(EditUserPage.class, baseUrl + "/admin#/people/users/%s:edit");
        pageLinksMap.put(ProfileUserSettingPage.class, baseUrl + "/units#/units/%s/users/%s/edit");
        pageLinksMap.put(GlobalAdminCreateUserPage.class, baseUrl + "/units#/units/%s/users/create");
        pageLinksMap.put(GlobalAdminUsersPage.class, baseUrl + "/units#/units/%s/users");
        pageLinksMap.put(AccountSettingPage.class, baseUrl + "/admin#/people/users/%s/password:edit");
        pageLinksMap.put(MyNotificationsSettingPage.class, baseUrl + "/projects#myprofile/notifications");
        pageLinksMap.put(NotificationsSettingPage.class, baseUrl + "/admin#/people/users/%s/notifications:edit");
        pageLinksMap.put(NotificationsSettingPageForGA.class, baseUrl + "/units#/units/%s/users/%s/notifications/edit");
        pageLinksMap.put(RolesPage.class, baseUrl + "/admin#/roles/%s%s");
        pageLinksMap.put(RolesDefPage.class, baseUrl + "/admin#/roles");
        pageLinksMap.put(RelatedFilesManagementPage.class, baseUrl + "/admin#/related");
        pageLinksMap.put(WaterMarkingManagementPage.class, baseUrl + "/admin#/watermarking");
        pageLinksMap.put(TermsAndConditionsPage.class, baseUrl + "/admin#/tnc");
        pageLinksMap.put(AgencyOverviewPage.class, baseUrl + "/units#/units/%s/overview");
        pageLinksMap.put(AgencyMarketPage.class, baseUrl + "/units#/units/%s/markets");
        pageLinksMap.put(AgencyCreateMarketPage.class, baseUrl + "/units#/units/%s/markets/create");
        pageLinksMap.put(AgencyEditMarketPage.class, baseUrl + "/units#/units/%s/markets/%s/edit");
        pageLinksMap.put(SuperHubMembersPage.class, baseUrl + "/units#/units/%s/superhub");
        pageLinksMap.put(HubMembersPage.class, baseUrl + "/units#/units/%s/hub");
        pageLinksMap.put(AgencyGlobalAccessRulesPage.class, baseUrl + "/units#/units/%s/accessRules/4ef31ce1766ec96769b399c0");
        pageLinksMap.put(DestinationPage.class, baseUrl + "/destinations#/");
        pageLinksMap.put(AgencyPartnersPage.class, baseUrl + "/units#/units/%s/partners");
        pageLinksMap.put(AgencySecurityPage.class, baseUrl + "/units#/units/%s/security");
        pageLinksMap.put(AgencyMetadataMappingPage.class, baseUrl + "/units#/units/%s/mapping");
        pageLinksMap.put(AgencyMetadataMappingCreatePage.class, baseUrl + "/units#/units/%s/create?targetAgencyId=%s");
        pageLinksMap.put(AgencyMetadataMappingEditPage.class, baseUrl + "/units#/units/%s/mapping/edit/%s");
        pageLinksMap.put(MetadataPage.class, baseUrl + "/admin#/metadata%s");
        pageLinksMap.put(ViewAssetManagementPage.class, baseUrl + "/admin#/views/asset/audio");
        pageLinksMap.put(ViewAssetManagementSettingsPage.class, baseUrl + "/admin#/views/settings");
        pageLinksMap.put(ViewAssetPage.class, baseUrl + "/admin#/views%s");
        pageLinksMap.put(ApprovalTemplatesPage.class, baseUrl + "/admin#/approvals");
        pageLinksMap.put(BaseAdBankPage.class, baseUrl + "/projects");
        pageLinksMap.put(MyProfilePage.class, baseUrl + "/projects#myprofile");
        pageLinksMap.put(MyAccountSettingPage.class, baseUrl + "/projects#myprofile/password");
        pageLinksMap.put(AdbankDashboardPage.class, baseUrl + "/projects#home");
        pageLinksMap.put(AdbankWorkRequestOverviewPage.class, baseUrl + "/projects#/projects/projects/%s/overview");
        pageLinksMap.put(AdbankWorkRequestTeamsPage.class, baseUrl + "/projects#/projects/projects/%s/team%s");
        pageLinksMap.put(AdbankWorkRequestFilesPage.class, baseUrl + "/projects#/projects/projects/%s%s/files");
        pageLinksMap.put(AdbankWorkRequestFileInfoPage.class, baseUrl + "/projects#/projects/projects/%s%s/%s/info");
        pageLinksMap.put(AdbankWorkRequestFileActivityPage.class, baseUrl + "/projects#/projects/projects/%s%s/%s/activity");
        pageLinksMap.put(AdbankWorkRequestTemplateOverviewPage.class, baseUrl + "/projects#/projects/templates/%s/overview");
        pageLinksMap.put(AdbankWorkRequestTemplateFilesPage.class, baseUrl + "/projects#/projects/templates/%s%s/files");
        pageLinksMap.put(AdbankProjectsListPage.class, baseUrl + "/projects#/projects");
        pageLinksMap.put(AdbankProjectApprovalsReceivedPage.class, baseUrl + "/projects#/projects/projects/%s/approvals/received");
        pageLinksMap.put(AdbankProjectApprovalsSubmittedPage.class, baseUrl + "/projects#/projects/projects/%s/approvals/submitted");
        pageLinksMap.put(AdbankProjectApprovalsNotStartedPage.class, baseUrl + "/projects#/projects/projects/%s/approvals/notstarted");
        pageLinksMap.put(AdbankProjectsApprovalsReceivedPage.class, baseUrl + "/projects#/projects/approvals/received");
        pageLinksMap.put(AdbankProjectsApprovalsSubmittedPage.class, baseUrl + "/projects#/projects/approvals/submitted");
        pageLinksMap.put(AdbankProjectsApprovalsNotStartedPage.class, baseUrl + "/projects#/projects/approvals/notstarted");
        pageLinksMap.put(AdbankProjectApprovalsPreviewFilePage.class, baseUrl + "projects#approvals/filePreview/%s/approvals");
        pageLinksMap.put(AdbankProjectOverviewPage.class, baseUrl + "/projects#/projects/projects/%s/overview");
        pageLinksMap.put(AdbankProjectFilesPage.class, baseUrl + "/projects#/projects/projects/%s%s/files");
        pageLinksMap.put(AdbankProjectTrashPage.class, baseUrl + "/projects#/projects/projects/%s/trash%s");
        pageLinksMap.put(AdbankProjectFilesUploadPage.class, baseUrl + "/projects#/projects/projects/%s/folders/%s/upload");
        pageLinksMap.put(AdbankProjectTeamsPage.class, baseUrl + "/projects#/projects/projects/%s/team%s");
        pageLinksMap.put(AdbankTemplateOverviewPage.class, baseUrl + "/projects#/projects/templates/%s/overview");
        pageLinksMap.put(AdbankTemplatesListPage.class, baseUrl + "/projects#/projects/templates");
        pageLinksMap.put(AdbankWorkRequestTemplatesListPage.class, baseUrl + "/projects#/projects/adkits_templates");
        pageLinksMap.put(AdbankWorkRequestListPage.class, baseUrl + "/projects#/projects/adkits");
        pageLinksMap.put(AdbankTemplateListWithSizePage.class, baseUrl + "/projects#/projects/templates?page=1&size=%s");
        pageLinksMap.put(AdbankTemplateFilesPage.class, baseUrl + "/projects#/projects/templates/%s/files");
        pageLinksMap.put(AdbankTemplateTrashPage.class, baseUrl + "/projects#/projects/templates/%s/trash%s");
        pageLinksMap.put(AdbankTemplateFilesWithFoldersPage.class, baseUrl + "/projects#/projects/templates/%s%s/files");
        pageLinksMap.put(AdbankTemplateFilesUploadPage.class, baseUrl + "/projects#/projects/templates/%s/folders/%s/upload");
        pageLinksMap.put(AdbankAddressbookPage.class, baseUrl + "/projects#addressbook");
        pageLinksMap.put(TrafficOrdersListPage.class, baseUrl + "/traffic/");
        pageLinksMap.put(TrafficOrderPage.class, baseUrl + "/traffic/#/details/order/%s");
        pageLinksMap.put(AdbankAddressbookAddUsersPopUp.class, baseUrl + "/projects#addressbook/add");
        pageLinksMap.put(AdbankProjectFileInfoPage.class, baseUrl + "/projects#/projects/projects/%s%s/%s/info");
        pageLinksMap.put(AdbankFileCommentsPage.class, baseUrl + "/projects#/projects/projects/%s%s/%s/comments");
        pageLinksMap.put(AdbankFileVersionHistoryPage.class, baseUrl + "/projects#/projects/projects/%s%s/%s/history");
        pageLinksMap.put(AdbankFileUsageRightsPage.class, baseUrl + "/projects#/projects/%s%s/%s/rights");
        pageLinksMap.put(AdbankFileAttachmentsPage.class, baseUrl + "/projects#/projects/%s%s/%s/attachments");
        pageLinksMap.put(AdbankFileFramesPage.class, baseUrl + "/projects#/projects/%s%s/%s/frames");
        pageLinksMap.put(AdbankProjectFileRelatedFilesPage.class, baseUrl + "/projects#/projects/%s%s/%s/related");
        pageLinksMap.put(AdbankFileApprovalsPage.class, baseUrl + "/projects#/projects/projects/%s%s/%s/approvals");
        pageLinksMap.put(AdbankProjectSearchResultPage.class, baseUrl + "/projects#/projects/search");
        pageLinksMap.put(AdbankTemplateFileInfoPage.class, baseUrl + "/projects#/projects/templates/%s%s/%s/info");
        pageLinksMap.put(AdbankProjectFileActivityPage.class, baseUrl + "/projects#/projects/projects/%s%s/%s/activity");
        pageLinksMap.put(AdbankTemplateFileActivityPage.class, baseUrl + "/projects#/projects/templates/%s%s/%s/activity");
        pageLinksMap.put(AdBankTemplateTeamsPage.class, baseUrl + "/projects#/projects/templates/%s/team%s");
        pageLinksMap.put(AdBankNotificationsPage.class, baseUrl + "/projects#notifications");
        pageLinksMap.put(AdbankLibraryPage.class, baseUrl + "/library#collections%s");
        pageLinksMap.put(AdbankSharedCollectionsPage.class, baseUrl + "/library#inbox%s");
        pageLinksMap.put(AdbankLibraryTrashPage.class, baseUrl + "/library#trash");
        pageLinksMap.put(CategoriesPage.class, baseUrl + "/admin#/categories%s");
        pageLinksMap.put(AdbankLibraryAllPresentationsPage.class, baseUrl + "/presentations#presentations%s");
        pageLinksMap.put(AdbankLibraryPresentationsAssetsPage.class, baseUrl + "/presentations#presentations%s");
        pageLinksMap.put(AdbankLibraryPresentationsActivityPage.class, baseUrl + "/presentations#presentations%s");
        pageLinksMap.put(AdbankLibraryPresentationsSettingsPage.class, baseUrl + "/presentations#presentations%s");
        pageLinksMap.put(AdbankLibraryPresentationsLayoutPage.class, baseUrl + "/presentations#presentations%s");
        pageLinksMap.put(AdbankLibraryPresentationsBrandingPage.class, baseUrl + "/presentations#presentations%s");
        pageLinksMap.put(AdbankPresentationViewPage.class, baseUrl + "/presentation/%s/#preview");
        pageLinksMap.put(AdbankPresentationPreviewPage.class, baseUrl + "/presentation#preview/%s");
        pageLinksMap.put(AdbankLibraryAssetsInfoPage.class, baseUrl + "/library#collections%s/%s/info");
        pageLinksMap.put(AdbankLibraryRelatedAssetsPage.class, baseUrl + "/library#collections%s/%s/related");
        pageLinksMap.put(AdbankLibraryRelatedProjectsPage.class, baseUrl + "/library#collections%s/%s/relatedProjects");
        pageLinksMap.put(AdbankLibraryAssetAttachmentsPage.class, baseUrl + "/library#collections%s/%s/attachments");
        pageLinksMap.put(AdbankLibraryAssetFramesPage.class, baseUrl + "/library#collections%s/%s/frames");
        pageLinksMap.put(AdbankLibraryAssetsActivityPage.class, baseUrl + "/library#collections%s/%s/activity");
        pageLinksMap.put(AdbankLibraryAssetsUsageRightsPage.class, baseUrl + "/library#collections%s/%s/rights");
        pageLinksMap.put(AdbankLibraryAssetsDestinationPage.class, baseUrl + "/library#collections%s/%s/destinations");
        pageLinksMap.put(AdminSystemBrandingPage.class, baseUrl + "/admin#/branding/systembranding");
        pageLinksMap.put(GlobalAdminSystemBrandingPage.class, baseUrl + "/units#/units/%s/branding");
        pageLinksMap.put(AdminLoginPage.class, baseUrl + "/admin#/branding/loginpage");
        pageLinksMap.put(AdbankBillingPage.class, baseUrl + "/billing#info");
        pageLinksMap.put(LibrarySearchResultPage.class, baseUrl + "/library#collections/all/assets%s");
        pageLinksMap.put(PLUploaderPage.class, baseUrl + "/uploader");
      //..  pageLinksMap.put(GlobalAdminRolesPage.class, baseUrl + "/roles#roles/%s%s");
        pageLinksMap.put(MailTemplatesNotificationSettingsPage.class, baseUrl + "/mailTemplates#/defaultNotificationSettings");
        pageLinksMap.put(GlobalAdminRolesPage.class, baseUrl + "/roles#/roles?buId=%s%s");
        pageLinksMap.put(GlobalMetadataPage.class, baseUrl + "/metadata#/metadata%s");
        pageLinksMap.put(GlobalPasswordsPage.class, baseUrl + "/passwords#/passwords");
        pageLinksMap.put(GlobalAdminSearchUsersPage.class, baseUrl + "/search#/users");
        pageLinksMap.put(GlobalAdminSearchAgencyPage.class, baseUrl + "/units#/units");
        pageLinksMap.put(DeliverySettingPage.class, baseUrl + "/admin#/people/users/%s/delivery:edit");
        pageLinksMap.put(MyDeliverySettingPage.class, baseUrl + "/projects#myprofile/delivery");
        pageLinksMap.put(OrderingPage.class, baseUrl + "/ordering#orders?status=%s&type=%s");
        pageLinksMap.put(OrderItemPage.class, baseUrl + "/ordering#orders/%s/items/%s");
        pageLinksMap.put(TrafficOrderEditPage.class, baseUrl + "/ordering#orders/%s/items/%s?createdBy=%s");
        pageLinksMap.put(OrderProceedPage.class, baseUrl + "/ordering#orders/%s/proceed");
        pageLinksMap.put(OrderSummaryPage.class, baseUrl + "/ordering#orders/%s/summary/");
        pageLinksMap.put(ViewMediaDetailsPage.class, baseUrl + "/ordering#assets/%s/info?clockNumber=%s&orderId=%s&backUrl=/orders/%s/summary");
        pageLinksMap.put(ViewMediaContentDetailsPage.class, baseUrl + "/ordering#assets/%s/info?orderId=%s&backUrl=orders/%s/items/%s");
        pageLinksMap.put(ViewDraftDeliveryReportPage.class, baseUrl + "/viewDeliveryReport?viewDetails=true&order=%s&report=%s");
        pageLinksMap.put(FailedOrderPage.class, baseUrl + "/ordering#admin");
        pageLinksMap.put(HolidaysPage.class, baseUrl + "/holidays#");
        pageLinksMap.put(OrderEditSummaryPage.class, baseUrl + "/ordering#orders/%s/confirm/invoice");
        pageLinksMap.put(BaseOrderingPage.class, baseUrl+"/ordering#orders");
        pageLinksMap.put(TrafficOrderPage.class,baseUrl+"/traffic/#/details/order/%s");
        pageLinksMap.put(TrafficOrderItemPage.class,baseUrl+"/traffic/#/details/order-item/%s?qcAssetId=%s");
        pageLinksMap.put(AdCostsOverviewPage.class, baseUrl+"/costs/#/costs?sort=Newest&page=1&perpage=10");
        pageLinksMap.put(AdCostsAdminUserAccessPage.class, baseUrl+"/costs/#/costs/admin/user-access/list");
        pageLinksMap.put(AdCostsAdminUserOverridePage.class, baseUrl+"/costs/#/costs/admin/useroverride");
        pageLinksMap.put(AdCostsDetailsPage.class, baseUrl+"/costs/#/costs/items/forms/cost-details?%s");
        pageLinksMap.put(AdCostsProductionDetailsPage.class, baseUrl+"/costs/#/costs/items/forms/production-details?%s");
        pageLinksMap.put(AdCostsExpectedAssetsPage.class, baseUrl+"/costs/#/costs/items/forms/expected-assets?%s");
        pageLinksMap.put(AdCostsItemsPage.class, baseUrl+"/costs/#/costs/items/forms/costs?%s");
        pageLinksMap.put(AdCostsSupportingDocumentsPage.class, baseUrl+"/costs/#/costs/items/forms/supporting-documents?%s");
        pageLinksMap.put(AdCostsApprovalsPage.class, baseUrl+"/costs/#/costs/items/forms/approvals?%s");
        pageLinksMap.put(AdCostsUsageBuyoutDetailsPage.class, baseUrl+"/costs/#/costs/items/forms/usage-buyout-details?%s");
        pageLinksMap.put(AdCostsNegotiatedTermsPage.class, baseUrl+"/costs/#/costs/negotiated-terms/%s");
        pageLinksMap.put(AdCostsReviewPage.class, baseUrl+"/costs/#/costs/items/review?costId=%s&revisionId=%s");
        pageLinksMap.put(AdCostsVendorPage.class, baseUrl+"/costs/#/costs/admin/vendors");
        pageLinksMap.put(AdCostsAssociatedAssetsPage.class, baseUrl+"/costs/#/costs/items/forms/associated-assets?costId=%s&revisionId=%s");
        pageLinksMap.put(AdCostsCurrencyPage.class, baseUrl+"/costs/#/costs/admin/currency");
        pageLinksMap.put(AdCostsDictionaryPage.class, baseUrl+"/costs/#/costs/admin/dictionaries");
        pageLinksMap.put(TrafficClockDetailsPage.class,baseUrl+"/traffic/#/details/clock/%s");
        /** NEW-LIB **/
        pageLinksMap.put(CollectionDetailsPage.class, baseUrl + "/streamlined-library-beta/#/collections/%s/details");
        pageLinksMap.put(NewAdbankLibraryPage.class, baseUrl + "/streamlined-library-beta/#/assets");
        pageLinksMap.put(CollectionFilterPage.class, baseUrl + "/streamlined-library-beta/#/collections/%s/filters");
        pageLinksMap.put(CollectionPage.class, baseUrl + "/streamlined-library-beta/#/collections");
        pageLinksMap.put(CollectionDataPage.class, baseUrl + "/streamlined-library-beta/#/collections/%s");
        pageLinksMap.put(LibraryAssetsInfoPage.class, baseUrl + "/streamlined-library-beta#collections/%s/assets/%s/info");
        pageLinksMap.put(NewAdbankLibraryAssetAttachmentsPage.class,baseUrl +"/streamlined-library-beta#collections%s%s/attachments");
        pageLinksMap.put(NewAdbankLibraryAssetsActivityPage.class, baseUrl + "/streamlined-library-beta#collections%s%s/activities");
        pageLinksMap.put(NewAdbankLibraryAssetRelatedProjectsPage.class,baseUrl +"/streamlined-library-beta/#%s%s/related-projects");
        pageLinksMap.put(NewAdbankLibraryAssetsDestinationPage.class, baseUrl + "/streamlined-library-beta#collections%s%s/deliveries");
        pageLinksMap.put(NewLibraryAssetUsageRightsPage.class, baseUrl + "/streamlined-library-beta/#%s%s/usage-rights");
        pageLinksMap.put(NewAdbankLibrarySharedCollectionsPage.class, baseUrl + "/streamlined-library-beta/#/collections/inbox/%s");
        pageLinksMap.put(NewLibraryTrashPage.class, baseUrl + "/streamlined-library-beta/#/collections/trash");
        pageLinksMap.put(NewLibraryGlobalSearchPage.class, baseUrl + "/streamlined-library-beta/#/search");
        pageLinksMap.put(NewLibraryGlobalSearchResultsPage.class, baseUrl + "/streamlined-library-beta/#/search/results");
        /**MEDIA MANGAGER **/
        pageLinksMap.put(MediaManagerLoginPage.class, TestsContext.getInstance().mediamanager_application_url + "");
        pageLinksMap.put(MediaManagerUploadPage.class, TestsContext.getInstance().mediamanager_application_url + "/files/uploads");
        pageLinksMap.put(MediaManagerOnholdPage.class, TestsContext.getInstance().mediamanager_application_url + "/files/onhold");
        pageLinksMap.put(MediaManagerHistoryPage.class, TestsContext.getInstance().mediamanager_application_url + "/files/history");
        pageLinksMap.put(MediaCheckerPage.class, TestsContext.getInstance().mediachecker_application_url + "/assets");
        pageLinksMap.put(MediaCheckerHistoryPage.class, TestsContext.getInstance().mediachecker_application_url + "/history");
        pageLinksMap.put(MediaCheckerPage.class, TestsContext.getInstance().mediachecker_application_url + "");
        pageLinksMap.put(NewAdbankLibraryAssetsPage.class, baseUrl + "//streamlined-library-beta/#/assets");


        /**ONE Delivery-Beta**/
        pageLinksMap.put(OneDeliveryBasePage.class, baseUrl + "/delivery/orders/inprogress");
        pageLinksMap.put(OneDeliveryNewOrderPage.class, baseUrl + "/delivery/orders/new");
        pageLinksMap.put(OneDeliveryOrderItemPage.class, baseUrl + "/delivery/orders/%s/items/%s");
        pageLinksMap.put(OneDeliveryOrderBillingPage.class, baseUrl + "/delivery/orders/%s/billing");
        pageLinksMap.put(OneDeliveryOrderCompletePage.class, baseUrl + "/delivery/orders/%s/complete");
    }

    public BaseAdBankPage getBaseAdBankPage() {
        navigateTo(BaseAdBankPage.class);
        return getPage(BaseAdBankPage.class);
    }

    public LoginPage getLoginPage() {
        /*
        try {
            // Workaround for google chrome. Sometimes doesn't open logout page.
            // can trow exception and fail page loading
            webDriver.getJavascriptExecutor().executeScript("window.stop()");
        } catch (Exception e){
            log.error(e);
        }
        */
        navigateTo(LogoutPage.class);
        Common.sleep(2000);
        navigateTo(LogoutPage.class);
        getPage(LogoutPage.class);
        navigateTo(LoginPage.class);
        Common.sleep(2000);
        return super.getLoginPage();
    }

    public UsersPage getUsersPage() {
        Common.sleep(2000);
        navigateTo(UsersPage.class, "/people");
        Common.sleep(2000);
        return super.getUsersPage();
    }



    public UsersPage getUsersPage(String pageNumber) {
        navigateTo(UsersPage.class, String.format("/people?page=%s", pageNumber));
        return super.getUsersPage();
    }

    public UsersPage getUsersPageForUser(String userId) {
        navigateTo(UsersPage.class, String.format("/users/%s", userId));
        return super.getUsersPage();
    }

    public UsersGroupPage getUsersGroupPage(String groupId) {
        navigateTo(UsersGroupPage.class, groupId);
        return super.getUsersGroupPage();
    }

    public CreateUserPage getCreateUserPage() {
        navigateTo(CreateUserPage.class);
        return super.getCreateUserPage();
    }

    public EditUserPage getEditUserPage(String userId) {
        navigateTo(EditUserPage.class, userId);
        return super.getEditUserPage();
    }

    public ProfileUserSettingPage getProfileUserSettingPage(String agencyId, String userId) {
        navigateTo(ProfileUserSettingPage.class, agencyId, userId);
        return super.getProfileUserPage();
    }

    public AccountSettingPage getAccountSettingPage(String userId) {
        navigateTo(AccountSettingPage.class, userId);
        return super.getAccountSettingPage();
    }

    public MyNotificationsSettingPage getMyNotificationSettingPage() {
        navigateTo(MyNotificationsSettingPage.class);
        return super.getMyNotificationSettingPage();
    }

    public NotificationsSettingPage getNotificationsSettingPage(String userId) {
        navigateTo(NotificationsSettingPage.class, userId);
        return super.getNotificationSettingPage();
    }

    public NotificationsSettingPageForGA getNotificationsSettingPageForGA(String userId,Agency agency) {
        navigateTo(NotificationsSettingPageForGA.class, agency.getId(),userId);
        return super.getNotificationSettingPageForGA();
    }
    public UserProjectsPage getUserProjectsPage(String userId) {
        navigateTo(UserProjectsPage.class, userId);
        return super.getUserProjectsPage();
    }

    public UserLibraryPage getUserLibraryPage(String userId) {
        navigateTo(UserLibraryPage.class, userId);
        return super.getUserLibraryPage();
    }

    public UserDeliveryPage getUserDeliveryPage(String userId) {
        navigateTo(UserDeliveryPage.class, userId);
        return super.getUserDeliveryPage();
    }

    public UserApplicationsPage getUserApplicationsPage(String userId) {
        navigateTo(UserApplicationsPage.class, userId);
        return super.getUserApplicationsPage();
    }

    public RolesPage getRolesPage(String roleId, String parentId) {
        if (!parentId.isEmpty()) {
            parentId = "?parentid=" + parentId;
        }
        navigateTo(RolesPage.class, roleId, parentId);
        return super.getRolesPage();
    }

    public RolesDefPage getRolesDefPage() {
        navigateTo(RolesDefPage.class);
        return super.getRolesDefPage();
    }

    public TermsAndConditionsPage getTermsAndConditionsPage() {
        navigateTo(TermsAndConditionsPage.class);
        return super.getTermsAndConditionsPage();
    }

    public GlobalAdminRolesPage getGlobalRolesPage() {
        return getGlobalRolesPage("", "");
    }

    public GlobalAdminRolesPage getGlobalRolesPage(String roleId, String parentId) {
      //..  if (!parentId.isEmpty()) parentId = "?parentid=" + parentId;
        if ((!parentId.isEmpty()) && (!roleId.isEmpty()) ) parentId = parentId+"&roleId="; // NGN-14650
        else if (parentId.isEmpty() && (!roleId.isEmpty())) parentId = "all&roleId="; // NGN-14650
        else parentId = "all"; // NGN-14650
        // NGN-14650  navigateTo(GlobalAdminRolesPage.class, roleId, parentId);
       // webDriver.get(String.format(pageLinksMap.get(GlobalAdminRolesPage.class), parentId, roleId));

        //This is a stupid hack in place coz of an issue with geckodriver not being able to navigate to a URL if its already on same url and the url contains fragments. Though it says fixed it doesnt work
        //https://github.com/mozilla/geckodriver/issues/189 ; https://github.com/mozilla/geckodriver/issues/150;
        // https://bugzilla.mozilla.org/show_bug.cgi?id=1280300;https://bugzilla.mozilla.org/show_bug.cgi?id=1337464
        if (!(webDriver.getCurrentUrl()).equalsIgnoreCase(String.format(pageLinksMap.get(GlobalAdminRolesPage.class), parentId, roleId))){
            webDriver.get(String.format(pageLinksMap.get(GlobalAdminRolesPage.class), parentId, roleId));
        }
        Common.sleep(5000);
        return super.getGlobalRolesPage();
    }

    public void getGlobalRolesPageForSpecificrole(String roleId, String parentId) {
        if ((!parentId.isEmpty()) && (!roleId.isEmpty()) ) {
            parentId = parentId + "&roleId="; // NGN-14650
        }else if (parentId.isEmpty() && (!roleId.isEmpty())) {
            parentId = "all&roleId="; // NGN-14650
        } else {
            parentId = "all"; // NGN-14650
        }
        webDriver.get(String.format(pageLinksMap.get(GlobalAdminRolesPage.class), parentId, roleId));
        Common.sleep(5000);
    }

    public GlobalAdminRolesPage getGlobalRolesPage(String parentId) {
//        parentId="/roles#/roles?buId="+parentId;
        webDriver.get(String.format(pageLinksMap.get(GlobalAdminRolesPage.class), parentId, ""));
        webDriver.navigate().refresh();
        Common.sleep(5000);
        return super.getGlobalRolesPage();
    }


    public AgencyMarketPage getAgencyMarketPage(String agencyId) {
        navigateTo(AgencyMarketPage.class, agencyId);
        return super.getAgencyMarketPage();
    }


    public SuperHubMembersPage getSuperHubMembersPage(String agencyId) {
        navigateTo(SuperHubMembersPage.class, agencyId);
        return super.getSuperHubMembersPage();
    }

    public HubMembersPage getHubMembersPage(String agencyId) {
        navigateTo(HubMembersPage.class, agencyId);
        return super.getHubMembersPage();
    }

    public AgencyCreateMarketPage getAgencyCreateMarketPage(String agencyId) {
        navigateTo(AgencyCreateMarketPage.class, agencyId);
        return super.getAgencyCreateMarketPage();
    }

    public AgencyEditMarketPage getAgencyEditMarketPage(String agencyId) {
        navigateTo(AgencyEditMarketPage.class, agencyId);
        return super.getAgencyEditMarketPage();
    }

    public AgencyGlobalAccessRulesPage getAgencyGlobalAccessRulesPage(String agencyId) {
        navigateTo(AgencyGlobalAccessRulesPage.class, agencyId);
        return super.getAgencyGlobalAccessRulesPage();
    }

    public DestinationPage getDestinationPage(String agencyId) {
        navigateTo(DestinationPage.class, agencyId);
        return super.getDestinationPage();
    }

    public AgencyOverviewPage getAgencyOverviewPage(String agencyId) {
        navigateTo(AgencyOverviewPage.class, agencyId);
        webDriver.navigate().refresh();
        return super.getAgencyOverviewPage();
    }

    public AgencyPartnersPage getAgencyPartnersPage(String agencyId) {
        navigateTo(AgencyPartnersPage.class, agencyId);
        return super.getAgencyPartnersPage();
    }

    public AgencySecurityPage getAgencySecurityPage(String agencyId) {
        navigateTo(AgencySecurityPage.class, agencyId);
        return super.getAgencySecurityPage();
    }

    public AgencyMetadataMappingPage getAgencyMetadataMappingPage(String agencyId) {
        navigateTo(AgencyMetadataMappingPage.class, agencyId);
        return super.getAgencyMetadataMappingPage();
    }

    public AgencyMetadataMappingCreatePage getAgencyMetadataMappingCreatePage(String agencyId, String targetAgencyId) {
        navigateTo(AgencyMetadataMappingCreatePage.class, agencyId, targetAgencyId);
        return super.getAgencyMetadataMappingCreatePage();
    }

    public AgencyMetadataMappingEditPage getAgencyMetadataMappingEditPage(String agencyId, String schemasMapId) {
        navigateTo(AgencyMetadataMappingEditPage.class, agencyId, schemasMapId);
        return super.getAgencyMetadataMappingEditPage();
    }

    public MetadataPage getMetadataPage() {
        return getMetadataPage(null);
    }

    public MetadataPage getCommonEditableMetadataPage() {
        return getMetadataPage("/editable");
    }

    public MetadataPage getCommonCustomMetadataPage() {
        return getMetadataPage("/custom");

    }

    public MetadataPage getProjectMetadataPage() {
        return getMetadataPage("/project");
    }

    public MetadataPage getAudioAssetMetadataPage() {
        return getMetadataPage("/asset/audio");
    }

    public MetadataPage getWorkRequestMetadataPage() { return getMetadataPage("/adkit"); }

    public MetadataPage getDigitalAssetMetadataPage() {
        return getMetadataPage("/asset/digital");
    }

    public MetadataPage getDocumentAssetMetadataPage() {
        return getMetadataPage("/asset/document");
    }

    public MetadataPage getImageAssetMetadataPage() {
        return getMetadataPage("/asset/image");
    }

    public MetadataPage getPrintAssetMetadataPage() {
        return getMetadataPage("/asset/print");
    }

    public MetadataPage getVideoAssetMetadataPage() {
        return getMetadataPage("/asset/video");
    }

    private MetadataPage getMetadataPage(String path) {
        path = path == null || path.isEmpty() ? "/custom" : path;
        navigateTo(MetadataPage.class, path);
        return super.getMetadataPage();
    }

    public ViewAssetPage getPrintAssetViewPage() {
        return getViewAssetPage("/asset/print");
    }

    public ViewAssetPage getVideoAssetViewPage() {
        return getViewAssetPage("/asset/video");
    }

    public ViewAssetPage getAudioAssetViewPage() {
        return getViewAssetPage("/asset/audio");
    }

    public ViewAssetPage getImageAssetViewPage() {
        return getViewAssetPage("/asset/image");
    }

    private ViewAssetPage getViewAssetPage(String path)
    {
        path = path == null || path.isEmpty() ? "/asset/audio" : path;
        navigateTo(ViewAssetPage.class, path);
        return super.getViewAssetPage();
    }

    public GlobalMetadataPage getGlobalMetadataPage() {
        return getGlobalMetadataPage(null, null);
    }

    public GlobalMetadataPage getGlobalCommonEditableMetadataPage(String agencyId) {
        return getGlobalMetadataPage("/editable", agencyId);
    }

    public GlobalMetadataPage getGlobalCommonCustomMetadataPage(String agencyId) {
        return getGlobalMetadataPage("/custom", agencyId);
    }

    public GlobalMetadataPage getGlobalProjectMetadataPage(String agencyId) {
        return getGlobalMetadataPage("/project", agencyId);
    }

    public GlobalMetadataPage getGlobalWorkRequestMetadataPage(String agencyId) {
        return getGlobalMetadataPage("/adkit", agencyId);
    }

    public GlobalMetadataPage getGlobalAudioAssetMetadataPage(String agencyId) {
        return getGlobalMetadataPage("/asset/audio", agencyId);
    }

    public GlobalMetadataPage getGlobalDigitalAssetMetadataPage(String agencyId) {
        return getGlobalMetadataPage("/asset/digital", agencyId);
    }

    public GlobalMetadataPage getGlobalDocumentAssetMetadataPage(String agencyId) {
        return getGlobalMetadataPage("/asset/document", agencyId);
    }

    public GlobalMetadataPage getGlobalImageAssetMetadataPage(String agencyId) {
        return getGlobalMetadataPage("/asset/image", agencyId);
    }

    public GlobalMetadataPage getGlobalPrintAssetMetadataPage(String agencyId) {
        return getGlobalMetadataPage("/asset/print", agencyId);
    }

    public GlobalMetadataPage getGlobalVideoAssetMetadataPage(String agencyId) {
        return getGlobalMetadataPage("/asset/video", agencyId);
    }

    public GlobalCommonOrderingMetadataPage getGlobalCommonOrderingMetadataPage(String agencyId, String marketId) {
        marketId = marketId.isEmpty() ? "" : "marketId=" + marketId;
        getGlobalMetadataPageWithParameters("/ordering", agencyId, marketId);
        return super.getGlobalCommonOrderingMetadataPage();
    }

    public GlobalCommonTrafficMetadataPage getGlobalCommonTrafficMetadataPage(String agencyId, String marketId) {
        marketId = marketId.isEmpty() ? "" : "marketId=" + marketId;
        getGlobalMetadataPageWithParameters("/traffic", agencyId, marketId);
        return super.getGlobalCommonTrafficMetadataPage();
    }

    private GlobalMetadataPage getGlobalMetadataPageWithParameters(String path, String agencyId, String parameters) {
        path += "?agencyId=" + agencyId;
        path += parameters.isEmpty() ? "" : "&" + parameters;

        navigateTo(GlobalMetadataPage.class, path);
        return super.getGlobalMetadataPage();
    }

    private GlobalMetadataPage getGlobalMetadataPage(String path, String agencyId) {
        path = path == null || path.isEmpty() ? "custom" : path;
        path += agencyId == null || agencyId.isEmpty() ? "" : "?agencyId=" + agencyId;

        navigateTo(GlobalMetadataPage.class, path);
        return super.getGlobalMetadataPage();
    }

    public ViewVideoAssetManagementPage getViewVideoAssetManagementPage() {
        navigateToViewAssetManagementPage("video");
        return super.getViewVideoAssetManagementPage();
    }

    // NGN-16212 - QAA: Global Admin can Search for BU - By Geethanjali- code Starts
    public ViewAssetManagementPage getViewAssetManagementPage() {
        navigateToViewAssetManagementPage("");
        return super.getViewAssetManagementPage();
    }
    public RelatedFilesManagementPage getRelatedFilesManagementPage() {
        navigateTo(RelatedFilesManagementPage.class);
        return super.getRelatedManagementPage();
    }

    public ViewAssetManagementSettingsPage getViewAssetManagementSettingsPage() {
        navigateTo(ViewAssetManagementSettingsPage.class);
        return super.getViewAssetManagementSettingsPage();
    }

    public WaterMarkingManagementPage getWaterMarkingManagementPage() {
        navigateTo(WaterMarkingManagementPage.class);
        return super.getWaterMarkingManagementPage();
    }


    // NGN-16212 - QAA: Global Admin can Search for BU - By Geethanjali- code Ends

    private void navigateToViewAssetManagementPage(String path) {
        path = path.isEmpty() ? "audio" : path;
        navigateTo(ViewAssetManagementPage.class, path);
    }

    public MyProfilePage getMyProfilePage() {
        navigateTo(MyProfilePage.class);
        return super.getMyProfilePage();
    }

    public MyAccountSettingPage getMyAccountSettingPage() {
        navigateTo(MyAccountSettingPage.class);
        return super.getMyAccountSettingPage();
    }

    public AdBankNotificationsPage getNotificationsPage() {
        navigateTo(AdBankNotificationsPage.class);
        return super.getNotificationsPage();
    }

    public AdbankDashboardPage getDashboardPage() {
        navigateTo(AdbankDashboardPage.class);
        return super.getDashboardPage();
    }

    public AdbankProjectsListPage getProjectListPage() {
        navigateTo(AdbankProjectsListPage.class);
        Common.sleep(3000);
        return super.getProjectListPage();
    }

    public AdbankProjectsListPage getProjectListPage_withOutDelay() {
        navigateTo(AdbankProjectsListPage.class);
        return super.getProjectListPage_withOutDelay();
    }

    public GlobalPasswordsPage getGlobalPasswordsPage() {
        navigateTo(GlobalPasswordsPage.class);
        return super.getGlobalPasswordsPage();
    }

    public MailTemplatesNotificationSettingsPage getMailTemplateNotificationSettingPage() {
        navigateTo(MailTemplatesNotificationSettingsPage.class);
        return super.getMailTemplatesNotificationSettingPage();
    }

    public GlobalAdminSearchUsersPage getGlobalAdminSearchUsersPage() {
        navigateTo(GlobalAdminSearchUsersPage.class);
        return super.getGlobalAdminSearchUsersPage();
    }

    // NGN-16208 - QAA: Global Admin can Search for BU - By Geethanjali- code starts
    public GlobalAdminSearchAgencyPage getGlobalAdminSearchAgencyPage() {
        navigateTo(GlobalAdminSearchAgencyPage.class);
        return super.getGlobalAdminSearchAgencyPage();
    }
    // NGN-16208 - QAA: Global Admin can Search for BU - By Geethanjali- code Ends

    public AdbankWorkRequestOverviewPage getWorkRequestOverviewPage(String workRequestId) {
        navigateTo(AdbankWorkRequestOverviewPage.class, workRequestId);
        return super.getWorkRequestOverviewPage();
    }

    public AdbankWorkRequestTeamsPage getWorkRequestTeamsPage(String workRequestId) {
        navigateTo(AdbankWorkRequestTeamsPage.class, workRequestId, "");
        return super.getWorkRequestTeamsPage();
    }

    public AdbankWorkRequestFilesPage getWorkRequestFilesPage(String workRequestId, String folderId) {
        if (folderId != null && !folderId.isEmpty()) folderId = "/folders/" + folderId;
        else folderId = "";
        navigateTo(AdbankWorkRequestFilesPage.class, workRequestId, folderId);
        return super.getWorkRequestFilesPage();
    }

    public AdbankWorkRequestFileInfoPage getWorkRequestFileInfoPage(String workRequestId, String folderId, String fileId) {
        return getFileInfoTabPage(AdbankWorkRequestFileInfoPage.class, workRequestId, folderId, fileId);
    }

    public AdbankWorkRequestFileActivityPage getWorkRequestFileActivityPage(String workRequestId, String folderId, String fileId) {
        return getFileInfoTabPage(AdbankWorkRequestFileActivityPage.class, workRequestId, folderId, fileId);
    }

    public AdbankFileCommentsPage getWorkRequestFileCommentsPage(String projectId, String folderId, String fileId) {
        return getFileInfoTabPage(AdbankFileCommentsPage.class, projectId, folderId, fileId);
    }

    public AdbankFileUsageRightsPage getWorkRequestFileUsageRightsPage(String projectId, String folderId, String fileId) {
        return getFileInfoTabPage(AdbankFileUsageRightsPage.class, "projects/" + projectId, folderId, fileId);
    }

    public AdbankFileVersionHistoryPage getWorkRequestFileVersionHistoryPage(String projectId, String folderId, String fileId) {
        return getFileInfoTabPage(AdbankFileVersionHistoryPage.class, projectId, folderId, fileId);
    }

    public AdbankFileApprovalsPage getWorkRequestFileApprovalsPage(String projectId, String folderId, String fileId) {
        return getFileInfoTabPage(AdbankFileApprovalsPage.class, projectId, folderId, fileId);
    }

    public AdbankWorkRequestTemplateOverviewPage getWorkRequestTemplateOverviewPage(String workRequestId) {
        navigateTo(AdbankWorkRequestTemplateOverviewPage.class, workRequestId);
        return super.getWorkRequestTemplateOverviewPage();
    }

    public AdbankFileAttachmentsPage getWorkRequestFileAttachmentsPage(String projectId, String folderId, String fileId) {
        return getFileInfoTabPage(AdbankFileAttachmentsPage.class, "projects/" + projectId, folderId, fileId);
    }

   //QA358-Frame Grabber Code changes Starts
    public AdbankFileFramesPage getWorkRequestFileFramesPage(String projectId, String folderId, String fileId) {
        return getFileInfoTabPage(AdbankFileFramesPage.class, "projects/" + projectId, folderId, fileId);
    }
    //QA358-Frame Grabber Code changes Ends

    public AdbankProjectFileRelatedFilesPage getWorkRequestRelativeFilesPage(String projectId, String folderId, String fileId) {
        return getFileInfoTabPage(AdbankProjectFileRelatedFilesPage.class, "projects/" + projectId, folderId, fileId);
    }

    public AdbankWorkRequestTemplateFilesPage getWorkRequestTemplateFilesPage(String workRequestTemplateId, String folderId) {
        if (folderId != null && !folderId.isEmpty()) folderId = "/folders/" + folderId;
        else folderId = "";
        navigateTo(AdbankWorkRequestTemplateFilesPage.class, workRequestTemplateId, folderId);
        webDriver.sleep(1000);
        if(!webDriver.isElementPresent(By.cssSelector("[data-dojo-type='adbank.projects.sidebar']"))) {
            webDriver.navigate().back();
            webDriver.sleep(1000);
            webDriver.navigate().forward();
            webDriver.sleep(1000);
        }
        return super.getWorkRequestTemplateFilesPage();
    }


    public AdbankProjectOverviewPage getProjectOverviewPage(String projectId) {
        navigateTo(AdbankProjectOverviewPage.class, projectId);
        return super.getProjectOverviewPage();
    }

    public AdbankProjectFilesPage getProjectFilesPage(String projectId, String folderId) {
        if (folderId != null && !folderId.isEmpty()) folderId = "/folders/" + folderId;
        else folderId = "";
        navigateTo(AdbankProjectFilesPage.class, projectId, folderId);
        return super.getProjectFilesPage();
    }

    public AdbankProjectFileInfoPage getProjectFileInfoPage(String projectId, String folderId, String fileId) {
        return getFileInfoTabPage(AdbankProjectFileInfoPage.class, projectId, folderId, fileId);
    }

    public AdbankFileCommentsPage getProjectFileCommentsPage(String projectId, String folderId, String fileId) {
        return getFileInfoTabPage(AdbankFileCommentsPage.class, projectId, folderId, fileId);
    }

    public AdbankFileVersionHistoryPage getProjectFileVersionHistoryPage(String projectId, String folderId, String fileId) {
        return getFileInfoTabPage(AdbankFileVersionHistoryPage.class, projectId, folderId, fileId);
    }

    public AdbankFileApprovalsPage getProjectFileApprovalsPage(String projectId, String folderId, String fileId) {
        return getFileInfoTabPage(AdbankFileApprovalsPage.class, projectId, folderId, fileId);
    }

    public AdbankFileUsageRightsPage getProjectFileUsageRightsPage(String projectId, String folderId, String fileId) {
        return getFileInfoTabPage(AdbankFileUsageRightsPage.class, "projects/" + projectId, folderId, fileId);
    }

    public AdbankFileAttachmentsPage getProjectFileAttachmentsPage(String projectId, String folderId, String fileId) {
        return getFileInfoTabPage(AdbankFileAttachmentsPage.class, "projects/" + projectId, folderId, fileId);
    }
    //QA358- Frame Grabber Code changes Starts
    public AdbankFileFramesPage getProjectFileFramesPage(String projectId, String folderId, String fileId) {
        return getFileInfoTabPage(AdbankFileFramesPage.class, "projects/" + projectId, folderId, fileId);
    }

    public AdbankLibraryAssetFramesPage getLibraryAssetsFramesPage(String collectionId, String assetId) {
        return getAssetInfoTabPage(AdbankLibraryAssetFramesPage.class, collectionId, assetId);
    }
    //QA358- Frame Grabber Code changes Ends

    public AdbankProjectFileRelatedFilesPage getProjectRelativeFilesPage(String projectId, String folderId, String fileId) {
        return getFileInfoTabPage(AdbankProjectFileRelatedFilesPage.class, "projects/" + projectId, folderId, fileId);
    }

    public AdbankFileUsageRightsPage getTemplateFileUsageRightsPage(String templateId, String folderId, String fileId) {
        return getFileInfoTabPage(AdbankFileUsageRightsPage.class, "templates/" + templateId, folderId, fileId);
    }

    public AdbankTemplateFileInfoPage getTemplateFileInfoPage(String templateId, String folderId, String fileId) {
        return getFileInfoTabPage(AdbankTemplateFileInfoPage.class, templateId, folderId, fileId);
    }

    public AdbankProjectFileActivityPage getProjectFileActivityPage(String projectId, String folderId, String fileId) {
        return getFileInfoTabPage(AdbankProjectFileActivityPage.class, projectId, folderId, fileId);
    }

    public AdbankTemplateFileActivityPage getTemplateFileActivityPage(String templateId, String folderId, String fileId) {
        return getFileInfoTabPage(AdbankTemplateFileActivityPage.class, templateId, folderId, fileId);
    }

    private <T> T getFileInfoTabPage(Class<T> clazz, String objectId, String folderId, String fileId) {
        if (folderId != null && !folderId.isEmpty()) {
            folderId = "/folders/" + folderId;
        } else {
            folderId = "";
        }
        if (fileId != null && !fileId.isEmpty()) {
            fileId = "files/" + fileId;
        } else {
            fileId = "";
        }
        navigateTo(clazz, objectId, folderId, fileId);
 //       webDriver.navigate().refresh(); Lazyloading--
        return getPage(clazz);
    }

    public AdbankLibraryAssetsInfoPage getLibraryAssetsInfoPage(String collectionId, String assetId) {
        return getAssetInfoTabPage(AdbankLibraryAssetsInfoPage.class, collectionId, assetId);
    }

    public AdbankLibraryAssetsActivityPage getLibraryAssetsActivityPage(String collectionId, String assetId) {
        return getAssetInfoTabPage(AdbankLibraryAssetsActivityPage.class, collectionId, assetId);
    }

    public AdbankLibraryRelatedAssetsPage getAdbankLibraryRelatedAssetsPage(String collectionId, String assetId) {
        return getAssetInfoTabPage(AdbankLibraryRelatedAssetsPage.class, collectionId, assetId);
    }

    public AdbankLibraryRelatedProjectsPage getAdbankLibraryRelatedProjectsPage(String collectionId, String assetId) {
        return getAssetInfoTabPage(AdbankLibraryRelatedProjectsPage.class, collectionId, assetId);
    }

    public AdbankLibraryAssetAttachmentsPage getAdbankLibraryAssetAttachmentsPage(String collectionId, String assetId) {
        return getAssetInfoTabPage(AdbankLibraryAssetAttachmentsPage.class, collectionId, assetId);
    }

    public AdbankLibraryAssetsUsageRightsPage getLibraryAssetsUsageRightsPage(String collectionId, String assetId) {
        return getAssetInfoTabPage(AdbankLibraryAssetsUsageRightsPage.class, collectionId, assetId);
    }

    public AdbankLibraryAssetsDestinationPage getAdbankLibraryAssetsDestinationPage(String collectionId, String assetId) {
        return getAssetInfoTabPage(AdbankLibraryAssetsDestinationPage.class, collectionId, assetId);
    }

    private <T> T getAssetInfoTabPage(Class<T> clazz, String collectionId, String assetId) {
        if (collectionId != null && !collectionId.isEmpty()) {
            collectionId = "/" + collectionId;
        } else {
            collectionId = "";
        }
        if (assetId != null && !assetId.isEmpty()) {
            assetId = "assets/" + assetId;
        }
        navigateTo(clazz, collectionId, assetId);
        Common.sleep(3000);
        return getPage(clazz);
    }

    public AdbankTemplateOverviewPage getTemplateOverviewPage(String id) {
        navigateTo(AdbankTemplateOverviewPage.class, id);
        return super.getTemplateOverviewPage();
    }

    public AdbankProjectFilesUploadPage getProjectFilesUploadPage(String projectId, String folderId) {
        navigateTo(AdbankProjectFilesUploadPage.class, projectId, folderId);
        return super.getProjectFilesUploadPage();
    }

    public AdbankProjectTrashPage getProjectTrashPage(String projectId, String folderId) {
        if (folderId != null && !folderId.isEmpty())
        {folderId = "/" + folderId + "/files";}
        navigateTo(AdbankProjectTrashPage.class, projectId, folderId);
        return super.getProjectTrashPage();
    }

    public AdbankProjectTeamsPage getProjectTeamsPage(String projectId) {
        navigateTo(AdbankProjectTeamsPage.class, projectId, "");
        return super.getProjectTeamsPage();
    }

    public AdbankProjectTeamsPage getProjectAgencyTeamsPage(String projectId, String agencyTeamId) {
        navigateTo(AdbankProjectTeamsPage.class, projectId, agencyTeamId);
        return super.getProjectTeamsPage();
    }

    public AdBankTemplateTeamsPage getTemplateAgencyTeamsPage(String templateId, String agencyTeamId) {
        navigateTo(AdbankProjectTeamsPage.class, templateId, agencyTeamId);
        return super.getTemplateTeamsPage();
    }

    public AdbankProjectApprovalsReceivedPage getProjectApprovalsReceivedPage(String projectId) {
        navigateTo(AdbankProjectApprovalsReceivedPage.class, projectId);
        return super.getProjectApprovalsReceivedPage();
    }

    public AdbankProjectApprovalsSubmittedPage getProjectApprovalsSubmittedPage(String projectId) {
        navigateTo(AdbankProjectApprovalsSubmittedPage.class, projectId);
        return super.getProjectApprovalsSubmittedPage();
    }

    public AdbankProjectApprovalsNotStartedPage getProjectApprovalsNotStartedPage(String projectId) {
        navigateTo(AdbankProjectApprovalsNotStartedPage.class, projectId);
        return super.getProjectApprovalsNotStartedPage();
    }

    public AdbankProjectsApprovalsReceivedPage getProjectsApprovalsReceivedPage() {
        navigateTo(AdbankProjectsApprovalsReceivedPage.class);
        return super.getProjectsApprovalsReceivedPage();
    }

    public AdbankProjectsApprovalsSubmittedPage getProjectsApprovalsSubmittedPage() {
        navigateTo(AdbankProjectsApprovalsSubmittedPage.class);
        return super.getProjectsApprovalsSubmittedPage();
    }

    public AdbankProjectsApprovalsNotStartedPage getProjectsApprovalsNotStartedPage() {
        navigateTo(AdbankProjectsApprovalsNotStartedPage.class);
        return super.getProjectsApprovalsNotStartedPage();
    }

    public ApprovalTemplatesPage getApprovalTemplatesPage() {
        navigateTo(ApprovalTemplatesPage.class);
        return super.getApprovalTemplatesPage();
    }

    public AdbankProjectApprovalsPreviewFilePage getAdbankProjectApprovalsPreviewFilePage() {
        navigateTo(AdbankProjectApprovalsPreviewFilePage.class);
        return super.getAdbankProjectApprovalsPreviewFilePage();
    }

    public AdBankTemplateTeamsPage getTemplateTeamsPage(String templateId) {
        navigateTo(AdBankTemplateTeamsPage.class, templateId, "");
        return super.getTemplateTeamsPage();
    }

    public AdbankProjectTeamsPage getProjectTeamsPage(String projectId, String userId) {
        navigateTo(AdbankProjectTeamsPage.class, projectId, "/users/" + userId);
        return super.getProjectTeamsPage();
    }

    public AdBankTemplateTeamsPage getTemplateTeamsPage(String templateId, String userId) {
        navigateTo(AdBankTemplateTeamsPage.class, templateId, "/users/" + userId);
        return super.getTemplateTeamsPage();
    }

    public AdbankTemplatesListPage getTemplateListPage() {
        navigateTo(AdbankTemplatesListPage.class);
        return super.getTemplateListPage();
    }

    public AdbankWorkRequestTemplatesListPage getWorkRequestTemplatesListPage() {
        navigateTo(AdbankWorkRequestTemplatesListPage.class);
        return super.getWorkRequestTemplatesListPage();
    }

    public AdbankWorkRequestListPage getWorkRequestListPage() {
        navigateTo(AdbankWorkRequestListPage.class);
        return super.getWorkRequestListPage();
    }

    public AdbankTemplateListWithSizePage getTemplateListPage(String size) {
        navigateTo(AdbankTemplateListWithSizePage.class, size);
        return super.getTemplateListWithSizePage();
    }

    public AdbankTemplateFilesPage getTemplateFilesPage(String templateId) {
        navigateTo(AdbankTemplateFilesPage.class, templateId);
        return super.getTemplateFilesPage();
    }

    public AdbankTemplateFilesWithFoldersPage getTemplateFilesWithFoldersPage(String templateId, String folderId) {
        if (folderId != null && !folderId.isEmpty()) folderId = "/folders/" + folderId;
    //    else folderId = "/folders/" + templateId;
        else folderId = "";
        navigateTo(AdbankTemplateFilesWithFoldersPage.class, templateId, folderId);
        webDriver.sleep(1000);
        if(!webDriver.isElementPresent(By.cssSelector("[data-dojo-type='adbank.projects.sidebar']"))) {
            webDriver.navigate().back();
            webDriver.sleep(1000);
            webDriver.navigate().forward();
            webDriver.sleep(1000);
        }
        return super.getTemplateFilesWithFoldersPage();
    }

    public AdbankTemplateFilesUploadPage getTemplateFilesUploadPage(String templateId, String folderId) {
        navigateTo(AdbankTemplateFilesUploadPage.class, templateId, folderId);
        return super.getTemplateFilesUploadPage();
    }

    public AdbankTemplateTrashPage getTemplateTrashPage(String templateId, String folderId) {
        if (folderId != null && !folderId.isEmpty()) folderId = "/" + folderId + "/files";
        else folderId = "";
        navigateTo(AdbankTemplateTrashPage.class, templateId, folderId);
        return super.getTemplateTrashPage();
    }


    @Override
    public AdbankAddressbookPage getAdbankAddressbookPage() {
        navigateTo(AdbankAddressbookPage.class);
        return super.getAdbankAddressbookPage();
    }

    public TrafficOrdersListPage getOrdersListPage(){
        navigateTo(TrafficOrdersListPage.class);
        return super.getTrafficOrderListPage();
    }

    public TrafficOrderPage getOrderPage(){
        navigateTo(TrafficOrderPage.class);
        return super.getTrafficOrderPage();
    }


    public AdbankAddressbookAddUsersPopUp getAdbankAddressbookAddUsersPopUp() {
        navigateTo(AdbankAddressbookAddUsersPopUp.class);
        return super.getAdbankAddressbookAddUsersPopUp();
    }

    public void navigateTo() {
        //leads to default page of current interface
        //login, admin, adbank
        if (!getPageHash().isEmpty()) {
            String newLocationScript = "window.location.href=''";
            // in 5.2 changing hash on admin page doesn't work
            if (getPath().equals("/admin") || getPath().equals("/public")) {
                newLocationScript = "window.location.pathname='/adbank'";
            }
            //there can be used navigate.refresh but it is no guaranty that there is no errors
            webDriver.getJavascriptExecutor().executeScript(newLocationScript);
            long end = System.currentTimeMillis() + 60 * 1000;
            do {
                webDriver.sleep(4000);
                log.debug("loading hash " + getPageHash());
                if (end < System.currentTimeMillis())
                    throw new TimeoutException("Time out while loading page..");
            } while (getPageHash().isEmpty());
            webDriver.sleep(3000);
        }
    }

    private String getPageHash() {
        return String.valueOf(webDriver.getJavascriptExecutor().executeScript("return window.location.hash"));
    }

    private String getPath() {
        return String.valueOf(webDriver.getJavascriptExecutor().executeScript("return window.location.pathname"));
    }

    public AdbankLibraryPage getLibraryPage(String collectionId) {
        if (collectionId != null && !collectionId.isEmpty()) {
            collectionId = "/" + collectionId + "/assets";
        } else {
            collectionId = "";
        }
        navigateTo(AdbankLibraryPage.class, collectionId);
     //   webDriver.navigate().refresh();
        return getPage(AdbankLibraryPage.class);
    }

    public AdbankSharedCollectionsPage getSharedCollectionsPage(String agencyId, String categoryId) {
        String path = agencyId == null || agencyId.isEmpty() ? "" : String.format("/%s/categories/%s", agencyId, categoryId);
        navigateTo(AdbankSharedCollectionsPage.class, path);

        return getPage(AdbankSharedCollectionsPage.class);
    }

    public NewAdbankLibrarySharedCollectionsPage getNewAdbankLibrarySharedCollectionsPage(String agencyId, String categoryId) {
         navigateTo(NewAdbankLibrarySharedCollectionsPage.class, categoryId);

        return getPage(NewAdbankLibrarySharedCollectionsPage.class);
    }

    public AdbankSharedCollectionsPage getSharedCollectionsPage() {
        return getSharedCollectionsPage(null, null);
    }

    public AdbankLibraryTrashPage getLibraryTrashPage() {
        navigateTo(AdbankLibraryTrashPage.class);
        return getPage(AdbankLibraryTrashPage.class);
    }

    public NewLibraryTrashPage getNewLibraryTrashPage() {
        navigateTo(NewLibraryTrashPage.class);
        return getPage(NewLibraryTrashPage.class);
    }

    public NewLibraryGlobalSearchPage getNewLibraryGlobalSearchPage() {
        navigateTo(NewLibraryGlobalSearchPage.class);
        return getPage(NewLibraryGlobalSearchPage.class);
    }

    public NewLibraryGlobalSearchResultsPage getNewLibraryGlobalSearchResultsPage() {
        navigateTo(NewLibraryGlobalSearchResultsPage.class);
        return getPage(NewLibraryGlobalSearchResultsPage.class);
    }

    public void navigateTo(Class pageClassToProxy) {
        navigateTo(pageClassToProxy, "");
    }

    public void navigateTo(Class pageClassToProxy, String... urlParam) {
        String desiredUrl = String.format(pageLinksMap.get(pageClassToProxy), urlParam);
        if (!isItCurrentUrl(desiredUrl)) {
            webDriver.get(desiredUrl);
        }
        //try catch loop added coz unhandlert_alert_behaviour capability set to 'Accept' doesnt work with gecko and broswer behaves up when a modal dialog is shown like for example
        //Do you want to leave the page - yes/no? etc. So we just manually click accept and move on. Once Sel/FF or Gecko fix it we can remove the try catch loop below.
        if(webDriver.isAlertPresent())
        {
            try {
                Alert alert = webDriver.switchTo().alert();
                alert.accept();
            } catch (NoAlertPresentException e) {
                log.debug("No Modal Browser dialog present..Proceed Mate");
            }
        }

    }
    public boolean isItCurrentUrl(String desiredUrl) {
        //do not consider files as different urls
        String currentPage = webDriver.getCurrentUrl().split("\\?")[0].replace("#/", "#");
        String desiredPage = desiredUrl.split("\\?")[0].replace("#/", "#");
        return currentPage.equalsIgnoreCase(desiredPage);
    }

    public CategoriesPage getCategoriesPage(String categoriesId) {
        if (categoriesId != null && !categoriesId.isEmpty()) categoriesId = "/" + categoriesId;
        else categoriesId = "";
        navigateTo(CategoriesPage.class, categoriesId);
        return getCategoriesPage();
    }

    public AdbankLibraryAllPresentationsPage getLibraryAllPresentationsPage() {
        navigateTo(AdbankLibraryAllPresentationsPage.class);
        return super.getLibraryAllPresentationsPage();
    }

    public AdbankLibraryPresentationsAssetsPage getLibraryPresentationsAssetsPage(String presentationId) {
        if (presentationId != null && !presentationId.isEmpty()) presentationId = "/" + presentationId + "/assets";
        else presentationId = "";
        navigateTo(AdbankLibraryPresentationsAssetsPage.class, presentationId);
        //webDriver.navigate().refresh();
        return getLibraryPresentationsAssetsPage();
    }

    public AdbankLibraryPresentationsActivityPage getLibraryPresentationsActivityPage(String presentationId) {
        if (presentationId != null && !presentationId.isEmpty()) presentationId = "/" + presentationId + "/activity";
        else presentationId = "";
        navigateTo(AdbankLibraryPresentationsActivityPage.class, presentationId);
        webDriver.navigate().refresh();
        return getLibraryPresentationsActivityPage();
    }

    public AdbankLibraryPresentationsSettingsPage getLibraryPresentationsSettingsPage(String presentationId) {
        if (presentationId != null && !presentationId.isEmpty()) presentationId = "/" + presentationId + "/settings";
        else presentationId = "";
        navigateTo(AdbankLibraryPresentationsAssetsPage.class, presentationId);
        return getLibraryPresentationsSettingsPage();
    }

    public AdbankLibraryPresentationsLayoutPage getLibraryPresentationsLayoutPage(String presentationId) {
        if (presentationId != null && !presentationId.isEmpty()) presentationId = "/" + presentationId + "/layout";
        else presentationId = "";
        navigateTo(AdbankLibraryPresentationsLayoutPage.class, presentationId);
        return getLibraryPresentationsLayoutPage();
    }

    public AdbankLibraryPresentationsBrandingPage getLibraryPresentationsBrandingPage(String presentationId) {
        if (presentationId != null && !presentationId.isEmpty()) presentationId = "/" + presentationId + "/branding";
        else presentationId = "";
        navigateTo(AdbankLibraryPresentationsBrandingPage.class, presentationId);
        return getLibraryPresentationsBrandingPage();
    }

    public AdbankPresentationViewPage getPresentationViewPage(String publicLinkToken) {
        navigateTo(AdbankPresentationViewPage.class, publicLinkToken);
        return getPresentationViewPage();
    }

    public AdbankPresentationPreviewPage getPresentationPreviewPage(String presentationId) {
        navigateTo(AdbankPresentationPreviewPage.class, presentationId);
        return getPresentationPreviewPage();
    }

    public AdminSystemBrandingPage getAdminSystemBrandingPage() {
        navigateTo(AdminSystemBrandingPage.class);
    //    webDriver.navigate().refresh();
        return super.getAdminSystemBrandingPage();
    }
    public GlobalAdminSystemBrandingPage getGlobalAdminSystemBrandingPage(String agencyId) {
        navigateTo(GlobalAdminSystemBrandingPage.class,agencyId);
        return super.getGlobalAdminSystemBrandingPage();
    }
    public AdminLoginPage getAdminLoginPage() {
        navigateTo(AdminLoginPage.class);
        return super.getAdminLoginPage();
    }

    public AdbankBillingPage getBillingPage() {
        navigateTo(AdbankBillingPage.class);
        return super.getBillingPage();
    }

    public LibrarySearchResultPage getLibrarySearchResultPage(String params) {
        if (params != null && !params.isEmpty()) params = "?" + params;
        else params = "";
        navigateTo(LibrarySearchResultPage.class, params);
        return getLibrarySearchResultPage();
    }

    public PLUploaderPage getPLUploaderPage(String type, String folderId) {
        String params = type == null ? "" : "?type=" + type;
        if (!params.isEmpty()) params += folderId == null ? "" : "&folder=" + folderId;
        navigateTo(PLUploaderPage.class, params);
        return getPLUploaderPage();
    }

     /*
        ORDERING PAGES
     */

    public DeliverySettingPage getDeliverySettingPage(String userId) {
        navigateTo(DeliverySettingPage.class, userId);
        return super.getDeliverySettingPage();
    }

    public MyDeliverySettingPage getMyDeliverySettingPage() {
        navigateTo(MyDeliverySettingPage.class);
        return super.getMyDeliverySettingPage();
    }

    // orderStatus: ["in_progress", "completing", "failed"], ["draft"], ["waiting_for_approval"], ["completed"]
    // orderType: tv_order, tv_order_music, tv_order_print
    public OrderingPage getOrderingPage(String orderStatus, String orderType) {
        navigateTo(OrderingPage.class, orderStatus, orderType);
        return super.getOrderingPage();
    }

    public OrderItemPage getOrderItemPage(String orderId, String orderItemId){
        navigateTo(OrderItemPage.class, orderId, orderItemId);
        return super.getOrderItemPage();
    }


    public OrderItemPage getEditOrderItemPage(String orderId, String orderItemId,String userId){
        navigateTo(TrafficOrderEditPage.class, orderId, orderItemId,userId);
        return super.getOrderItemPage();
    }

    public OrderProceedPage getOrderProceedPage(String orderId) {
        navigateTo(OrderProceedPage.class, orderId);
        return super.getOrderProceedPage();
    }

    public ViewDestinationDetailsPage getOrderViewDestinationDetailsPage(String orderId) {
        navigateTo(ViewDestinationDetailsPage.class, orderId);
        return super.getOrderViewDestinationDetailsPage();
    }

    public OrderSummaryPage getOrderSummaryPage(String orderId) {
        navigateTo(OrderSummaryPage.class, orderId);
        return super.getOrderSummaryPage();
    }

    public ViewMediaDetailsPage getViewMediaDetailsPage(String contentId, String clockNumber, String orderId) {
        navigateTo(ViewMediaDetailsPage.class, contentId, clockNumber, orderId, orderId);
        return super.getViewMediaDetailsPage();
    }

    public ViewMediaContentDetailsPage getViewMediaContentDetailsPage(String contentId, String orderId, String orderItemId) {
        navigateTo(ViewMediaContentDetailsPage.class, contentId, orderId, orderId, orderItemId);
        return super.getViewMediaContentDetailsPage();
    }

    public ViewDraftDeliveryReportPage getViewDraftDeliveryReportPage(String orderId, String reportType) {
        navigateTo(ViewDraftDeliveryReportPage.class, orderId, reportType);
        return super.getViewDraftDeliveryReportPage();
    }

    public FailedOrderPage getFailedOrderPage() {
        navigateTo(FailedOrderPage.class);
        return super.getFailedOrderPage();
    }

    public HolidaysPage getHolidaysPage() {
        navigateTo(HolidaysPage.class);
        return super.getHolidaysPage();
    }

    public OrderEditSummaryPage getOrderEditSummaryPage() {
        navigateTo(OrderEditSummaryPage.class);
        return super.getOrderEditSummaryPage();
    }

    public BaseOrderingPage getBaseOrderingPage() {
        navigateTo(BaseOrderingPage.class);
        return getPage(BaseOrderingPage.class);
    }

    public TrafficOrderItemPage getOrderItemDetailsPage(String itemId, String assetId){
        navigateTo(TrafficOrderItemPage.class,itemId,assetId);
        return super.getTrafficOrderItemPage();
    }

    public TrafficOrderPage getTrafficOrderPage(String orderId){
        navigateTo(TrafficOrderPage.class,orderId);
        return super.getTrafficOrderPage();
    }

    public TrafficClockDetailsPage getClockDetailsPage(String clknumber){
        navigateTo(TrafficClockDetailsPage.class,clknumber);
        return super.getTrafficClockDetailsPage();
    }

    public GlobalAdminCreateUserPage getGlobalAdminCreateUserPage(String agencyId) {
        navigateTo(GlobalAdminCreateUserPage.class, agencyId);
        return super.getGlobalAdminCreateUserPage();
    }

    public GlobalAdminUsersPage getGlobalAdminUsersPage(String agencyId) {
        navigateTo(GlobalAdminUsersPage.class, agencyId);
        return super.getGlobalAdminUsersPage();
    }

    // Adcost
    public AdCostsOverviewPage getAdCostOverviewPage() {
        navigateTo(AdCostsOverviewPage.class);
        return super.getAdCostsOverviewPage();
    }

    public AdCostsAdminUserAccessPage getAdCostAdminUserAccessPage() {
        navigateTo(AdCostsAdminUserAccessPage.class);
        return super.getAdCostsAdminUserAccessPage();
    }


    public AdCostsAdminUserOverridePage getAdCostsAdminUserOverridePage(){
        navigateTo(AdCostsAdminUserOverridePage.class);
        return super.getAdCostsAdminUserOverridePage();
    }

    public AdCostsVendorPage getAdCostsVendorPage(){
        navigateTo(AdCostsVendorPage.class);
        return super.getAdCostsVendorPage();
    }

    public AdCostsDetailsPage getAdCostsDetailsPage(String costPage){
        navigateTo(AdCostsDetailsPage.class,costPage);
        return super.getAdCostsCostDetailsPage();
    }

    public AdCostsProductionDetailsPage getAdCostsProductionDetailsPage(String costPage){
        navigateTo(AdCostsProductionDetailsPage.class,costPage);
        return super.getAdCostsProductionDetailsPage();
    }

    public AdCostsExpectedAssetsPage getAdCostsExpectedAssetsPage(String costPage){
        navigateTo(AdCostsExpectedAssetsPage.class,costPage);
        return super.getAdCostsExpectedAssetsPage();
    }

    public AdCostsItemsPage getAdCostsItemsPage(String costPage){
        navigateTo(AdCostsItemsPage.class,costPage);
        return super.getAdCostsItemsPage();
    }

    public AdCostsSupportingDocumentsPage getAdCostsSupportingDocumentsPage(String costPage){
        navigateTo(AdCostsSupportingDocumentsPage.class,costPage);
        return super.getAdCostsSupportingDocumentsPage();
    }

    public AdCostsApprovalsPage getAdCostsApprovalsPage(String costPage){
        navigateTo(AdCostsApprovalsPage.class,costPage);
        return super.getAdCostsApprovalsPage();
    }

//    public AdCostsUsageBuyoutDetailsPage getAdCostsUsageBuyoutDetailsPage(){
//        navigateTo(AdCostsUsageBuyoutDetailsPage.class);
//        return super.getAdCostsUsageBuyoutDetailsPage();
//    }

    public AdCostsNegotiatedTermsPage getAdCostsNegotiatedTermsPage(){
        navigateTo(AdCostsNegotiatedTermsPage.class);
        return super.getAdCostsNegotiatedTermsPage();
    }

    public AdCostsReviewPage getAdCostsReviewPage(String costId, String revisionsId){
        navigateTo(AdCostsReviewPage.class,costId,revisionsId);
        return super.getAdCostsReviewPage();
    }

    public AdCostsAssociatedAssetsPage getAdCostsAssociatedAssets(String costId,String revisionId){
        navigateTo(AdCostsAssociatedAssetsPage.class,costId,revisionId);
        return super.getAdCostsAssociatedAssetsPage();
    }

    public AdCostsCurrencyPage getAdCostsCurrencyPage(){
        navigateTo(AdCostsCurrencyPage.class);
        return super.getAdCostsCurrencyPage();
    }

    public AdCostsDictionaryPage getAdCostsDictionaryPage(){
        navigateTo(AdCostsDictionaryPage.class);
        return super.getAdCostsDictionaryPage();
    }

    public AdCostsUsageBuyoutDetailsPage getAdCostsUsageBuyoutDetailsPage(String costPage){
        navigateTo(AdCostsUsageBuyoutDetailsPage.class,costPage);
        return super.getAdCostsUsageBuyoutDetailsPage();
    }

    public LibraryAsset getLibraryPageNEWLIB(String collectionName, String collectionId) {
        if (collectionId != null && !collectionId.isEmpty()) {
            collectionId = collectionId;
        } else {
            collectionId = "";
        }
        if (collectionName.equalsIgnoreCase("Everything") || collectionName.equalsIgnoreCase("")) {
            navigateTo(NewAdbankLibraryPage.class, collectionId);
            return getPage(NewAdbankLibraryPage.class);
        }
        navigateTo(CollectionDetailsPage.class,collectionId);
        Common.sleep(2000);
        return getPage(CollectionDetailsPage.class);

    }


    public CollectionDetailsPage getCollectionDetailsPage(String collectionId) {
        if (collectionId != null && !collectionId.isEmpty()) {
            collectionId =  collectionId;
        } else {
            collectionId = "";
        }
        navigateTo(CollectionDetailsPage.class, collectionId);
        return getPage(CollectionDetailsPage.class);
    }

    public CollectionPage getCollectionPage(){
        navigateTo(CollectionPage.class);
        return getPage(CollectionPage.class);
    }

    public NewAdbankLibraryAssetsPage getNewAdbankLibraryAssetsPage(){
        navigateTo(NewAdbankLibraryAssetsPage.class);
        return getPage(NewAdbankLibraryAssetsPage.class);
    }

    public LibraryAssetsInfoPage getLibraryAssetsInfoPageNEWLIB(String collectionId, String assetId) {
        navigateTo(LibraryAssetsInfoPage.class, collectionId, assetId);
        return getPage(LibraryAssetsInfoPage.class);
    }

    public LibraryAssetsInfoPage getLibraryAssetsInfoPage_InboxNEWLIB(String collectionId, String assetId) {
        String desiredUrl = String.format(TestsContext.getInstance().applicationUrl + "/streamlined-library-beta#collections/inbox/%s/assets/%s/info", collectionId, assetId);
        if (!isItCurrentUrl(desiredUrl)) {
            webDriver.get(desiredUrl);
        }
         if(webDriver.isAlertPresent())
        {
            try {
                Alert alert = webDriver.switchTo().alert();
                alert.accept();
            } catch (NoAlertPresentException e) {
                log.debug("No Modal Browser dialog present..Proceed Mate");
            }
        }
        return getPage(LibraryAssetsInfoPage.class);
    }




    public LibraryAsset getCollectionFilterPage(String collectionName, String collectionId) {
        if (collectionId != null && !collectionId.isEmpty()) {
            collectionId = collectionId;
        } else {
            collectionId = "";
        }
        navigateTo(CollectionFilterPage.class,collectionId);
        Common.sleep(2000);
        return getPage(CollectionFilterPage.class);

    }

    public CollectionDataPage getCollectionDataPage(String collectionId) {
        if (collectionId != null && !collectionId.isEmpty()) {
            collectionId =  collectionId;
        } else {
            collectionId = "";
        }
        navigateTo(CollectionDataPage.class, collectionId);
        return getPage(CollectionDataPage.class);
    }

    private <T> T getNewAssetInfoPage(Class<T> clazz, String collectionId, String assetId) {
       if (collectionId != null && !collectionId.isEmpty()) {
            collectionId = "/" + collectionId;
        } else {
            collectionId = "";
        }
        if (assetId != null && !assetId.isEmpty()) {
            assetId = "/assets/" + assetId ;
        }
        navigateTo(clazz, collectionId, assetId);
        Common.sleep(3000);
        return getPage(clazz);
    }

    public NewAdbankLibraryAssetAttachmentsPage getNewAdbankLibraryAssetAttachmentsPage(String collectionId, String assetId) {
        return getNewAssetInfoPage(NewAdbankLibraryAssetAttachmentsPage.class, collectionId, assetId);
    }

    public NewAdbankLibraryAssetRelatedProjectsPage getNewAdbankLibraryAssetRelatedProjectsPage(String assetId) {
        return getNewAssetInfoPage(NewAdbankLibraryAssetRelatedProjectsPage.class, "", assetId);
    }


    public NewAdbankLibraryAssetsActivityPage getNewAdbankLibraryAssetsActivityPage(String collectionId, String assetId) {
        return getNewAssetInfoPage(NewAdbankLibraryAssetsActivityPage.class, collectionId, assetId);
    }

    public NewAdbankLibraryAssetsDestinationPage getNewAdbankLibraryAssetsDestinationPage(String collectionId, String assetId) {
        return getNewAssetInfoPage(NewAdbankLibraryAssetsDestinationPage.class, collectionId, assetId);
    }

    public NewLibraryAssetUsageRightsPage getNewLibraryUsageRightPage(String assetId) {
        return getNewAssetInfoPage(NewLibraryAssetUsageRightsPage.class,"",assetId);
    }

   public NewLibraryAssetUsageRightsPage getNewLibraryUsageRightPage(String  collectionId, String assetId) {
        return getNewAssetInfoPage(NewLibraryAssetUsageRightsPage.class, collectionId, assetId);
    }
    //MediaManager
    public MediaManagerLoginPage getMMLoginPage() {
        navigateTo(MediaManagerLoginPage.class);
        return super.getMediaMLoginPage();
    }

    public MediaManagerUploadPage getMMUploadPage() {
        navigateTo(MediaManagerUploadPage.class);
        return super.getMediaUploadPage();
    }

    public MediaCheckerPage getMediaCheckerPage() {
        navigateTo(MediaCheckerPage.class);
        return super.getMediaCheckerPage();
    }

    public MediaManagerHistoryPage getMediaManagerHistoryPage() {
        navigateTo(MediaManagerHistoryPage.class);
        return super.getMMHistoryPage();
    }

    public MediaCheckerHistoryPage getMediaCheckerHistoryPage() {
        navigateTo(MediaCheckerHistoryPage.class);
        return super.getMCHistoryPage();
    }

    /** One Delivery **/
    public OneDeliveryBasePage getOneDeliveryBasePage() {
        navigateTo(OneDeliveryBasePage.class);
        return super.getOneDeliveryBasePage();
    }

    public OneDeliveryNewOrderPage getOneDeliveryNewOrderPage() {
        navigateTo(OneDeliveryNewOrderPage.class);
        return super.getOneDeliveryNewOrderPage();
    }

    public OneDeliveryOrderItemPage getOneDeliveryOrderItemPage(String orderId,String itemId) {
        navigateTo(OneDeliveryOrderItemPage.class,orderId,itemId);
        return super.getOneDeliveryOrderItemPage();
    }

    public OneDeliveryOrderBillingPage getOneDeliveryOrderBillingPage() {
        navigateTo(OneDeliveryOrderBillingPage.class);
        return super.getOneDeliveryOrderBillingPage();
    }

    public OneDeliveryOrderCompletePage getOneDeliveryOrderCompletePage() {
        navigateTo(OneDeliveryOrderCompletePage.class);
        return super.getOneDeliveryOrderCompletePage();
    }
}