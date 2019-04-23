package com.adstream.automate.babylon;

import com.adstream.automate.babylon.JsonObjects.*;
import com.adstream.automate.babylon.JsonObjects.Agency;
import com.adstream.automate.babylon.JsonObjects.Reel;
import com.adstream.automate.babylon.JsonObjects.User;
import com.adstream.automate.babylon.JsonObjects.adcost.*;
import com.adstream.automate.babylon.JsonObjects.adcost.ContentType;
import com.adstream.automate.babylon.JsonObjects.dictionary.Dictionary;
import com.adstream.automate.babylon.JsonObjects.dictionary.DictionaryType;
import com.adstream.automate.babylon.JsonObjects.dictionary.DictionaryValues;
import com.adstream.automate.babylon.JsonObjects.gdn.GDNDeliveryDoc;
import com.adstream.automate.babylon.JsonObjects.gdn.GDNFileRegister;
import com.adstream.automate.babylon.JsonObjects.gdn.GDNFileWrapper;
import com.adstream.automate.babylon.JsonObjects.gdn.IngestDoc;
import com.adstream.automate.babylon.JsonObjects.mediamanager.AQAReport;
import com.adstream.automate.babylon.JsonObjects.mediamanager.PAPIApplication;
import com.adstream.automate.babylon.JsonObjects.ordering.*;
import com.adstream.automate.babylon.JsonObjects.ordering.billing.Bill;
import com.adstream.automate.babylon.JsonObjects.ordering.billing.BillingView;
import com.adstream.automate.babylon.JsonObjects.ordering.billing.Payment;
import com.adstream.automate.babylon.JsonObjects.ordering.billing.Price;
import com.adstream.automate.babylon.JsonObjects.ordering.enums.UploadRequestType;
import com.adstream.automate.babylon.JsonObjects.projectsaccessrure.ProjectsAccessRule;
import com.adstream.automate.babylon.JsonObjects.schema.AssetElementCommonSchema;
import com.adstream.automate.babylon.JsonObjects.schema.AssetElementProjectCommonSchema;
import com.adstream.automate.babylon.JsonObjects.schema.AssetSchema;
import com.adstream.automate.babylon.JsonObjects.schema.ProjectSchema;
import com.adstream.automate.babylon.JsonObjects.usagerights.BaseUsageRight;
import com.adstream.automate.babylon.JsonObjects.usagerights.UsageRight;
import com.adstream.automate.babylon.core.BatchTaskApi;
import com.adstream.gdn.api.client.serialization.Job;
import com.adstream.gdn.api.client.serialization.JobResponse;
import org.apache.http.HttpResponse;
import org.joda.time.DateTime;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * User: ruslan.semerenko
 * Date: 02.04.12 13:34
 */
public interface BabylonService {
    // Admin /gdam/admin/admin.html
    public BaseObject getObjectIdentity(String objectId);
    public String getVersion();

    public String getAdcostVersion();

    //    public String getBuildVersion();
    public String getBranch();
    public void rebuildIndex();
    public void rebuildIndex(String[] indexType, String[] agencyId, Integer batchSize);

    // Dictionaries /gdam/dictionary/dictionary.html
    public Dictionary getDictionary(DictionaryType type);
    public Dictionary getAgencyDictionaryByName(String agencyId, String dictionaryName);
    public Dictionary createAgencyDictionary(String agencyId, String dictionaryName, List<CustomMetadata> values);
    public Dictionary updateAgencyDictionaryValues(String agencyId, String dictionaryName, List<CustomMetadata> values);
    public Dictionary updateAgencyDictionary(String agencyId, String dictionaryName, DictionaryValues values);

    // Users /gdam/user/user.html
    public String auth(String email, String password);
    public String adcostAuth(String email);
    public String impersonate(String email, String comment);
    public String authSSO(String email, String password);
    public String loginToSendplusMiddleTier(String emailID, String passWord) throws IOException;
    public HashMap<String, String> createFileIDForSendplusUploadToProjects(String cookie, String folderId) throws IOException;
    public void uploadFileToAdbankStorageViaSendplusMiddleTier(String uploadURL, File file) throws IOException;
    public void displayFileInProjectsViaSendplusMiddleTier(String cookie, String uploadID,String folderId) throws IOException;
    public HashMap<String, String> createFileIDForSendplusUploadToLibrary(String cookie) throws IOException;
    public void displayFileInLibraryViaSendplusMiddleTier(String cookie, String uploadID) throws IOException;
    public void downloadFolderAndProjectViaUsingSendplusMiddletier(String cookie, String elementID, String fileID) throws IOException;
    public void logoutSSO();
    public void displayS3FileInProjectsViaSendplusMiddleTier(String cookie, String uploadID,String folderId,String eTag) throws IOException;
    public void displayS3FileInLibraryViaSendplusMiddleTier(String cookie, String uploadID,String eTag) throws IOException;
    public String uploadFileToS3AdbankStorageViaSendplusMiddleTier(String uploadURL, File file) throws IOException;
    public User getUser(String userId);
    public User getCurrentUser();
    public HashMap<String, String> assetAttachmentViaSendplus(String cookie,String assetId,String fname,int fsize) throws IOException;
    public SearchResult<User> findUsers(LuceneSearchingParams query);
    public SearchResult<User> findUsers(LuceneSearchingParams query, With with);
    public User createGlobalAdminUser(String groupId, User user);
    public User editGlobalAdminUser(String groupId, User user);
    public List<String> getGlobalAdminUsers();
    public User createUser(String groupId, User user);
    public User updateUser(String userId, User newUser);
    public void deleteUser(String userId, String reassignDataToUserId);
    public User inviteUser(String email);
    public void addExistingUserToAgency(String userId, String agencyId, String roleId);
    public HashMap<String, String> uploadFileRevisionViaSendplus(String cookie,String fileId,String fname,int fsize) throws IOException;
    public HashMap<String, String> uploadFileAttachmentViaSendplus(String cookie,String fileId,String fname,int fsize) throws IOException;
    public String getElasticSearchRebuildTime();

    // Schema /gdam/schema/schema.html
    public AssetSchema getAssetSchema(String agencyId);
    public AssetSchema updateAssetSchema(String agencyId, AssetSchema schema);
    public AssetElementCommonSchema getAssetElementCommonSchema(String agencyId);
    public AssetElementCommonSchema updateAssetElementCommonSchema(String agencyId, AssetElementCommonSchema schema);
    public ProjectSchema getProjectSchema(String agencyId);
    public ProjectTermsAndConditions getProjectTermsAndConditions(String projectId);
    public ProjectSchema updateProjectSchema(String agencyId, ProjectSchema schema);
    public AssetElementProjectCommonSchema getAssetElementProjectCommonSchema(String agencyId);
    public AssetElementProjectCommonSchema updateAssetElementProjectCommonSchema(String agencyId, AssetElementProjectCommonSchema schema);

    // Groups /gdam/group/group.html
    public BaseObject getHead();
    public BaseObject getGroup(String groupId);
    public <T> SearchResult<T> getChildren(String groupId, String type);
    public void addChild(String parentId, BaseObject child);
    public void addChild(String parentId, String childId);
    public void removeChild(String groupId, String childId);
    public void removeChildren(String groupId, String... childrenId);
    public BaseObject createGroup(String parentId, String name, String subtype);
    public BaseObject updateGroup(String groupId, String newName);
    public void deleteGroup(String groupId);

    // Logo /gdam/logo/logo.html
    public byte[] getLogo(String objectType, String objectId);

    // Agencies /gdam/agency/agency.html
    public Agency createAgency(Agency agency);
    public Agency updateAgency(Agency agency);
    public Agency getCurrentAgency();
    public List<Agency> getAgencies();
    public Agency getAgency(String agencyId);
    public SearchResult<Agency> findAgencies(LuceneSearchingParams query);
    public List<Agency> getAgenciesSimple();
    public SearchResult<Agency> findAgenciesSimple(LuceneSearchingParams query);
    public List<Agency> getPartnerAgencies(String agencyId);
    public Agency addPartnerAgency(String agencyId, String partnerAgencyId, boolean canBill, boolean canView);
    public void removePartnerAgency(String agencyId, String partnerAgencyId);
    public void setUserRole(String agencyId, String userId, String[] rolesId);

    // Assets /gdam/asset/asset.html
    // parentId: assetFilterId or folderId
    public Content getAsset(String assetId);
    public SearchResult<Content> findAssets(LuceneSearchingParams query);
    public SearchResult<Content> findAssets(String parentId);
    public SearchResult<Content> findAssets(String parentId, LuceneSearchingParams query);
    public SearchResult<Content> findAssets(String parentId, LuceneSearchingParams query, With with);
    public SearchResult<Content> findAssetsForClient(String parentId, LuceneSearchingParams query, With with,String userId);
    public SearchResult<Content> findAssetsForClient(String parentId, LuceneSearchingParams query,String userId);
    public Content moveFileIntoLibrary(Content content);
    public Content updateAsset(Content content);
    public Content patchAsset(String assetId, String campaign);
    public GDNFileRegister registerGDNAssets(List<GDNFileWrapper> files);
    public JobResponse gdnIngestRegister(Job job);
    public IngestDoc getIngestID(String assetId);
    public void setRevision(IngestDoc ingestdoc, String ingestID, long size, String fileId, String assetId);
    public Content createAssetGDN(Content content, String gdnFileId);
    public Content createAssetGDN(Content content, String gdnFileId, String agencyId);
    public AmazonContent createfilePart(String gdnFileId,String storageId);
    public void multipartIngestComplete(String gdnFileId,MultiPartUploadCompleteData multiPartUploadCompleteData);
    public void deleteAsset(String assetId);

    public BatchTaskApi batchTaskApi();

    // Asset Filter /gdam/asset/asset_filter.html
    public AssetFilters getAssetFilters();
    public AssetFilters getAssetFiltersForClient(String userId);
    // subtype: asset_filter_category, asset_filter_collection
    public AssetFilters getAssetFilters(String subtype);
    public AssetFilters getAssetFiltersForClient(String subtype,String userId);
    public BaseObject getAssetFilterRootFolder();
    // subtype: asset_filter_category, asset_filter_collection
    public AssetFilter createAssetFilter(String name, String subtype, String query);
    public AssetFilter createAssetFilterForClient(String name, String subtype, String query,String userId);
    // subjectId: userId or agencyId
    public void shareAssetFilter(String assetFilterId, String subjectId, String roleId);
    public void shareAssetFilter(String assetFilterId, String subjectId, String roleId, Boolean write, Long expiration);
    public void shareAssetFilterToAgency(String assetFilterId, String agencyId);
    public void unshareAssetFilter(String assetFilterId, String... subjectId);
    public AssetFilter updateAssetFilter(String assetFilterId, String name, String query);
    public void deleteAssetFilter(String assetFilterId);
    public SearchResult<Agency> getAssetFilterAgencies(String assetFilterId);
    public SearchResult<BaseObject> getAssetFilterSubjects(String assetFilterId);
    public AssetFilter addAssetsToNewCollection(List<String> assetIds, String collectionName);
    public AssetFilter addAssetsToExistingCollection(List<String> assetIds, AssetFilter collection);
    // parentId: agencyId or folderId
    public AssetFilterFolder createAssetFilterFolder(String parentId, String name);
    public AssetFilterFolder updateAssetFilterFolder(String folderId, String name);
    public void deleteAssetFilterFolder(String folderId);
    public void copyAssetFilterToFolder(String assetFilterId, String folderId);
    public void moveAssetFilterToFolder(String assetFilterId, String fromFolderId, String toFolderId);
    public void deleteAssetFilterFromFolder(String folderId, String assetFilterId);
    // parentId: folderId or projectId
    public void addAssetToProjectFolder(String assetId, String parentId);

    public void addRelationBetweenFiles(String agencyId, String asType, String childFileId, String parentFileId);

    // creating xmp mapping
    public void createXMPMapping(String agencyId, List<XMPMapping> xmpMapping);

    public String moveFolder(List folderIds, String newParentId, boolean updateMetadata);
    public String copyFolder(List folderIds, String newParentId, boolean updateMetadata);

    public String updateAssetsBulkMetadata(List<String> assetsId, String agencyId, String advertiserValue);
    public String updateAssetsButchMetadata(List<ContentBatchUpdate> content);
    public String getProcessStatus(String processId, int depth);
    public String getBatchProcessStatus(String processId);

    // Projects /gdam/project/project.html
    public Project getProject(String projectId);
    public Project publishProject(String projectId, boolean publish, Boolean noEmail);
    public Project getProject(String projectId, With with);
    public SearchResult<Project> findProjects(LuceneSearchingParams query);
    public SearchResult<Project> findTemplates(LuceneSearchingParams query);
    public String createTemplateFromProject(String projectId, String name, String[] mediaType, DateTime campaignStart, DateTime campaignEnd, boolean withFolders, boolean withTeam);
    public String createProjectFromTemplate(String projectId, String name, String[] mediaType, DateTime campaignStart, DateTime campaignEnd, boolean withFolders, boolean withTeam, boolean isPublished);
    public Project createProject(Project project);
    public Project createProject(String agencyId, Project project);
    public Project updateProject(String projectId, Project newProject);
    public void deleteProject(String projectId);
    public void restoreProject(String projectId);
    public Content getContent(String contentId);
    public SearchResult<Content> findContent(String folderId, LuceneSearchingParams query);
    public SearchResult<Content> findContentAllProjects(LuceneSearchingParams query);
    public SearchResult<Content> findFoldersContent(String folderId, LuceneSearchingParams query);
    public SearchResult<Content> findClientFoldersContent(String folderId,String userId, LuceneSearchingParams query);
    public Content createContent(String parentId, Content content);
    public GDNFileRegister registerGDNContent(String parentId, List<GDNFileWrapper> gdnFiles);
    public Content createContentGDN(String parentId, Content content, String gdnFileId);
    public Content createClientContentGDN(String parentId, Content content, String gdnFileId,String userId);
    public Content createRevision(String elementId, Content content);
    public Content createClientRevision(String elementId, Content content, String userId);
    public Content createAttachedFile(Content originalFile, AttachedFile attachedFile);
    public int getFilesCount(String projectId, String folderId);
    public Content updateContent(String contentId, Content newContent);
    public String moveContent(String[] contentId, String toFolderId);
    public void copyContent(String[] contentId, String toFolderId);
    public void deleteContent(String contentId);
    public SearchResult<Content> findTrashBinFiles(String projectId);
    public SearchResult<Content> findTrashBinFolders(String projectId);
    public SearchResult<Content> findTrashBinFoldersContent(String folderId, LuceneSearchingParams query);
    public SearchResult<User> getTeamUsers(String projectId, boolean children);
    public SearchResult<User> addUserToProjectTeam(TeamPermission[] permissions);
    public SearchResult<User> addUserToProjectTeam(String projectId, TeamPermission[] permissions);
    public void removeUserFromProjectTeam(String projectId, String userId);
    public void allowUserToViewPublicTemplates(String agencyId, String userId, boolean allow);
    public String batchUpdateElementsMetadata(String agencyId, String projectId, CustomMetadata metadata);

    // Roles /gdam/role/role.html
    public Role getRole(String roleId);
    public SearchResult<Role> findRoles(LuceneSearchingParams query);
    public Role createRole(String agencyId, Role role);
    public Role updateRole(Role role);
    public void deleteRole(String roleId);
    public void createAcl(String roleId, Acl acl);
    public SearchResult<User> getAclSubjects(String roleId, String objectId);
    public void deleteAcl(String roleId, String objectId, String subjectId);
    public void hideRole(String roleId, boolean hide);

    // FS /gdam/fs/fs.html
    public SearchResult<FileStorage> getGdnStorages();
    public FileStorage getGdnStorageForAgency(String agencyId);
    public FileStorage getGdnStorageForFolder(String folderId);
    public String getDownloadUrl(String fileId, String a4FileId, String saveAsFileName);
    public Map<String, String> getDownloadInfo(String fileId, String a4FileId, String saveAsFileName);

    // Global Search /gdam/search/global.html
    public GlobalSearchResult globalSearch(LuceneSearchingParams query);

    // Contact /gdam/contact/contact.html
    public SearchResult<Contact> getContacts(ContactSearchingParams query);
    public List<String> getTeamTemplates(ContactSearchingParams query);
    public Contact addContact(String email);
    public void addNotificationSetting(String userId,String notificationSetting,String settingState);
    public Contact addContactToGroup(String email, String... groupName);
    public Contact getContact(String email);
    public void deleteContact(String contactId);

    // Activity gdam/activity/activity.html
    public int getNotificationsCount(boolean isHasReadNotification);
    public SearchResult<Notification> findNotifications(boolean isHasReadNotification, LuceneSearchingParams query);

    // Comments
    public Comment createComment(String text, String objectId, String objectType, long objectRevision, String answerTo);
    public SearchResult<Comment> findComments(String fileId, int objRevision);

    // Reels gdam/reel/reel.html
    public SearchResult<Reel> findReels(LuceneSearchingParams query);
    public boolean sharePresentationToUsers(String presentationId, List<String> userIds, String personalMessage);
    public Reel createReel(Reel reel);
    public Reel getReel(String reelId, boolean withPermissions);
    public Reel updateReel(Reel reel);
    public void deleteReel(String reelId);
    // Agency project team
    public AgencyProjectTeam createAgencyTeam(AgencyProjectTeam agencyProjectTeam);
    public void addObjectToAgencyProjectTeam(String agencyTeamId, String objectId);
    public SearchResult<AgencyProjectTeam> findAgencyProjectTeams(LuceneSearchingParams query);
    public void deleteAgencyProjectTeam(String teamId);

    // Usage rights
    public void addUsageRights(String objectId, List<UsageRight> listUR);
    public BaseUsageRight getUsageRight (String objectId);
    public void deleteUsageRight(String objectId);

    // Easysharing
    public void shareFileOrAsset(String documentType, List<String> assetIds, List<String> userIds, Long expiration, String message, boolean createActivity, boolean allowView, boolean allowDownloadProxy, boolean allowDownloadMaster);

    // Public Sharing
    // documentType: asset, fsobject, presentation
    public PublicShare createPublicShare(String documentType, String documentId, Long expiration, String[] users, String[] roles);

    // Inbox
    public Integer getInboxCacheStatus();
    public Integer createInboxCache();
    public Boolean createInboxCache(String collectionId);
    public SearchResult<Content> findAssetsInSharedCollection(String collectionId, LuceneSearchingParams query);
    public SearchResult<InboxCategory> getInboxCategories(String agencyId);

    // SchemasMap
    public SchemasMap findSchemasMap(String groupOne, String agencyIdOne, String groupTwo, String agencyIdTwo);

    // Projects access rules
    public CustomMetadata enableProjectsAccessRulesForAgency(String agencyId, int interval);
    public ProjectsAccessRule createProjectsAccessRule(ProjectsAccessRule projectsAccessRule);
    public ProjectsAccessRule getProjectsAccessRule(String agencyId, String userId);
    public ProjectsAccessRule getProjectsAccessRule(String projectsAccessRuleId);
    public ProjectsAccessRule updateProjectsAccessRule(ProjectsAccessRule projectsAccessRule);
    public ProjectsAccessRule deleteProjectsAccessRule(String projectsAccessRuleId);

    // Migration A4 -> A5
    public String executeMigrationA4toA5(MigrationA4toA5 migrationA4toA5);

    // Ordering
    public Order createOrder(Order order);
    public Order updateOrder(Order order);
    public Order getOrderById(String orderId, boolean withOrderItems);
    public String getDeliveryStatusFromA4(String orderRefference);
    public Integer getOrderFromTrafficById(String orderId) throws IOException;
    public Integer getOrderFromTrafficById(String orderId,String qcAssetId) throws IOException;
    public String getOrderStatusFromTraffic(String orderId, String qcAssetId) throws IOException;
    public String getOrderItemStatusFromTraffic(String orderId, String qcAssetId) throws IOException;
    public String getA5ViewStatusFromTraffic(String orderId,String qcAssetId) throws IOException;
    public String getBroadcasterStatusFromTraffic(String orderId,String qcAssetId) throws IOException;
    public String getAdditionalServiceStatusFromTraffic(String orderReference, String qcAssetId, String destination,String serviceType)throws IOException;
    public String getBroadcasterStatusFromTrafficForDestination(String orderId,String qcAssetId,String destination) throws IOException;
    public String getDeliveryStatusFromTraffic(String orderId,String detinationName) throws IOException;
    public String getDeliveryStatusFromTraffic(String orderId,String qcAssetId,String detinationName) throws IOException;
    public Order completeOrder(Order order, QcView qcView);
    public Order forceCompleteOrder(Order order);
    public void moveOrderToBU(String orderId, String agencyId);
    public List<BeamTvClock> getBeamTvClocks(String date);
    public SearchResult<Order> findOrders(LuceneSearchingParams query);
    public SearchResult<OrderCounter> getOrderCounters(String orderType);
    public void deleteOrder(String orderId);
    public void deleteOrders(String[] ordersIds);
    public OrderItem createOrderItem(String orderId, String orderItemType, OrderItem orderItem);
    public OrderItem updateOrderItem(String orderId, String orderItemId, String orderItemType, OrderItem orderItem);
    public SearchResult<OrderItem> findOrderItems(String orderItemType, LuceneSearchingParams query);
    public OrderItem holdForApprovalOrderItem(String orderId, String orderItemId, String orderItemType, String approvalValue);
    public void deleteOrderItemApprovalStatus(String orderId, String orderItemId, String orderItemType);
    public OrderItem addMediaToOrderItem(String orderId, String orderItemId, String elementId, String orderItemType);
    public List<OrderItem> createOrderItemsAssociatedWithMedia(String orderId, String orderItemType, String[] assetElementIds);
    public void removeMediaFromOrderItem(String orderId, String orderItemId, String elementId, String orderItemType);
    public void deleteOrderItem(String orderId, String orderItemId, String orderItemType);
    public void deleteOrderItems(String[] orderItemsIds);
    public void deleteOrdersFromOrdersNotReplicatedToA4Queue(List<String> orderIds);
    public SearchResult<OrderCompletionQueue> getOrdersFromOrderCompletionQueue();
    public List<String> getOrdersFromOrderCompletionQueue_id();
    public void deleteOrdersFromCompletionQueue(String id);
    public SearchResult<Deliveries> findDeliveries(String clockNumber, LuceneSearchingParams query);
    public DeliveryReport getDeliveryReport(String orderId);
    public String getDeliveryReportUrl(String orderId);
    public String getBeamConfirmationReportUrl(String orderId);
    public String getDraftOrderReportUrl(String orderId);
    public String getBillingOrderReportUrl(String orderId);
    public String getDeliveryOrderReport(String orderId, String deliveryReportType, List<QcOrderItem> qcOrderItems);
    public BaseSearchResult<Market> getTvMarkets();
    public SearchDestinationPerMarketResult getDestinationsByMarket(String market, LuceneSearchingParams query);
    public void addAdditionalDestinations(Map<UploadRequestType, List<AdditionalDestination>> additionalDestinations);
    public GDNFileRegister registerDocuments(List<GDNFileWrapper> gdnDocuments, String referenceId, String reference);
    public void uploadDocumentsComplete(String gdnFileId);
    public void uploadDocumentsCompleteTest(String attachedFileId, String gdnFileId);
    public QcView getQcView(String orderId);
    public void assignOrders(String[] ordersIds, String userEmail, String message);
    public List<Transfer> getAssigns(String orderId);
    public String enableBilling();
    public String disableBilling();
    public String getBillingStatus();
    public Bookmark createBookmark(String name, int marketId, boolean isShared);
    public Bookmark updateBookmark(Bookmark bookmark);
    public Bookmark getBookmarkById(String bookmarkId);
    public SearchResult<Bookmark> findBookmarks();
    public void deleteBookmark(String bookmarkId);
    public void authenticateToARPP(String userName, String password);
    public void updateUserSessionByARPPUserCredentials(String userNameHash, String passwordHash);
    public void findFieldsFromARPP(String criteria, String userName, String password);
    public Price[] getPrices(BillingView billingView, String endPointUrl);
    public Payment[] billOrder(List<Bill> bills, String endPointUrl);
    public String getMasterReceivedDateTraffic(String orderId,String qcAssetId) throws IOException;
    public IngestDoc getIngestId(String assetId) throws UnsupportedEncodingException;
    public String setIngestId(IngestDoc ingestdoc, String ingestID, long size, String fileId, String assetId);
    public IngestDoc setCommentA5(String orderRef, String userId) throws UnsupportedEncodingException;
    public String setAssetStatus(String assetId, String userId, String status) throws UnsupportedEncodingException;
    public String redeliverAssetbyExtId(String extId, String userId) throws UnsupportedEncodingException;
    public String redeliverAssetbyDeliveryId(String deliveryId, String userId) throws UnsupportedEncodingException;
    public String orderdeliverbyOrderId(String orderId, String userId) throws UnsupportedEncodingException;
    public String cancelDeliverybyDeliveryId(String deliveryId, String userId) throws UnsupportedEncodingException;
    public String cancelDeliverybyExtId(String extId, String userId) throws UnsupportedEncodingException;
    public List<GDNDeliveryDoc> getDeliveryDoc(String clockNumber, String userId) throws UnsupportedEncodingException;
    public String refreshDestinations() throws UnsupportedEncodingException;
    public String setHouseNumber(String userId,String deliveryId,String houseNumber) throws UnsupportedEncodingException;
    public String deleteIngestRepo(String assetId);
    public String addIngestRepo(String assetId);
    public String setDuration(String assetId, String orderinguserId, String trafficuserId) throws UnsupportedEncodingException;
    public String removeMasterArrived(String orderId,String itemId, String orderinguserId, String trafficuserId) throws UnsupportedEncodingException;
    public String retranscodeAsset(String assetId, String orderinguserId, String trafficuserId) throws UnsupportedEncodingException;
    public String setMasterArrived(String orderId,String itemId, String orderinguserId, String trafficuserId, Map<String, String> row) throws UnsupportedEncodingException;
    public GDNFileRegister registerGDNFiles(String agencyId,GDNFileWrapper files);
    public void uploadDocumentsCompleteTest_WaterMarking(String agencyId, String gdnFileId,String fileName);
    public String generateCustomCode(String agencyId, String customCodeFieldName);

    // Adcost
    public HttpResponse uploadAdcostSupportingDocsRegisterUpload(List<SupportingDocsWrapper> docs);

    public void uploadAdcostSupportingDocsCompleteUpload(List<SupportingDocsWrapper> docs, String request);

    public void uploadAdcostSupportingDocs(List<SupportingDocsWrapper> docs);

    public void uploadAdditionalSupportingDocumentsInAdCostCompleteUpload(List<SupportingDocsWrapper> docs,String request);

    public void uploadAdcostAdditionalSupportingDocs(List<SupportingDocsWrapper> docs);

    public void uploadBudgetForms(List<BudgetFormsWrapper> docs);

    public String uploadBudgetFormInCostLineItem(List<BudgetFormsWrapper> docs, boolean checkBadRequest);

    public CostStage getCostStage(String costId);

    public CostStageRevision getCostStageRevision(String costId, String costStageId);

    public SupportingDocuments[] getSupportingDocuments(String costId, String costStageId, String costStageRevision);

    public HttpResponse downloadSupportingDocuments(String costId, String costStageId, String costStageRevisionId,String supportingDocumentId,String formName);

    public BudgetFormTemplates[] getBudgetFormTemplates();

    public String downloadBudgetForms(String budgetFormtemplateId);

    public String downloadAssociatedAssets(String costId, String revisionId);

    public String checkDownloadProjectTotals(String projectId);

    public String downloadExpectedAssets(String costId, String stageId, String revisionId);

    public CostsCount getCosts();

    public CostTemplates[] getCostTemplates();

    public AdcostDictionaries[] getAdcostDictionaries();

    public AdcostCurrency[] getAdcostCurrnecy();

    public Costs createCostDetails(CostDetails costDetails);

    public ExchangeRates[] getExchangeRates(String costId);

    public AdcostDictionaries[] getTravellerRole();

    public AdcostDictionaries[] getShootCity();

    public TravelRegions[] getTravelRegions();

    public PerDiems[] getTravelPerDiems();

    public TravelDetails createTravelCostDetails(TravelDetails travelDetails);

    public void deleteTravelCostDetails(TravelDetails travelDetails);

    public TravelDetails[] getTravelCostDetails(TravelDetails travelDetails);

    public TravelCountry[] getTravelCountry();

    public AdcostDictionaries[] getDirectorName();

    public AdcostDictionaries[] getPhotographerName();

    public SmoOrganisations[] getSmoOrganisations(String budgetRegionId);

    public BudgetRegions[] getBudgetRegions();

    public VendorsCount getVendors(String searchText);

    public Vendors[] getVendorListPerProductionCategory(String productionCategory);

    public Vendors[] getVendorListforNonProductionCost(String productionCategory);

    public Vendors createVendors(Vendors vendors);

    public void updateVendors(Vendors vendors);

    public void createProductionDetails(String costId, BaseProductionDetails details);

    public AdcostDictionaries[] getInitiatives();

    public AdcostDictionaries[] getAdcostDictionaryByName(String dictionaryName);

    public void createEntryInAdcostDictionary(ContentType request);

    public AdcostDictionaries[] getAdcostDictionaryByNameGDAMway(String dictionaryName);

    public void createEntryInAdcostDictionaryGDAMway(ContentType request);

    public AdId generateAdId(AdId adId);

    public void createExpectedAssets(ExpectedAssets assets);

    public void createCostLineItemData(CostLineItems lineItems);

    public void createIoNumber(String objectId, String name, Data data);

    public CustomData getIoNumber(String objectId, String name);

    public CostLineItemDataResponse[] getCostLineItemDetails(String costId,String costStageId,String revisionId);

    public Approvals[] getApproversListForCost(String costId, String costStageId, String revisionId);

    public ApprovalMembers[] getApproverDetails(String id);

    public void addApprovers(String costId, String costStageId, String revisionId, List<Approvals> approvers);

    public void submitCostForApproval(String costId, String action, String comments);

    public void createUsageBuyOutDetails(UpdateCostForm details, String costId);

    public void createNegotiatedTerms(UpdateCostForm details, String costId);

    public ProjectSearch[] getProjectNumber(String gdamProjectId);

    public CostUser searchUserByAgencyID(String email);

    public String getUserRoleInCostModule(String email);

    public UserRoles[] getBusinessRoles();

    public Agencies[] getAgencyIdInCostModule();

    public void grantUserAccessInCostModule(String userId,String businessRoleId,String approvalLimit,String accessType,String typeId,String labelName, String notificationBudgetRegionId);

    public String getCostsAsString(String costTitle);

    public ValueReportingDetails getValueReportingdetails(String costId, String costRevisionIid);

    public ValueReportingDetails editValueReportingdetails(String costId, String costRevisionIid, ValueReportingDetails reportingDetails);

    public ExpectedAssets[] getExpectedAssets(String costId, String costStageId, String revisionId);

    public VendorsCount getVendorsGDAMway(String searchText);

    public Vendors createVendorsGDAMway(Vendors vendors);

    public String checkAdCostHeartBeat();

    public Vendors getVendorDetails(String id);

    public CostOwners[] getCostOwnersforCostId(String costId);
    public AssetFilter createAssetFilterNEWLIB(String name, String subtype, String query,String assetId);
    public AssetFilter addAssetToCollection(String name, String subtype, String query,String collectionId,String assetId);
    public void addAssetToReel(String reelId,String assetId);
    public void acceptAssetsFromCollection(String collectionId,String[] assetIds);
    public Boolean checkAssetDownloaded_newlibrary(String assetName,String assetId,String assetType);
    public Boolean checkAssetDownloadedSendplus(String assetId,String assetType);
    public String uploadDocument_WorkRequest(GDNFileWrapper fileWrapper);
    public Boolean checkStoryBoardDownload(String assetId,String[] fileIds);
    public String getNewLibraryMiddleTierVersion();
    public String getNewLibraryWebappVersion();
    public BaseObject UploadComplete_WorkRequest(String projectFolderId,String brieffileId,String fileName);

    /** MEDIA MANAGER **/
    public AQAReport getQCReportDataView(String fileId, String currentUserEmail) ;

    public PAPIApplication generatePAPIKeySecret(String email, String id);

    public PAPIApplication[] listApplications(String email);

    public String getA5ViewStatusFromTraffic(String orderId,String qcAssetId,String destination) throws IOException;

    public String getOrderItemA5ViewStatusfromTrafficForClones(String orderId,String destination) throws IOException;
}