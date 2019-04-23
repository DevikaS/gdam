package com.adstream.automate.babylon;

import com.adstream.automate.babylon.JsonObjects.*;
import com.adstream.automate.babylon.JsonObjects.activity.Activity;
import com.adstream.automate.babylon.JsonObjects.activity.ActivityQuery;
import com.adstream.automate.babylon.JsonObjects.activity.ActivityType;
import com.adstream.automate.babylon.JsonObjects.adcost.*;
import com.adstream.automate.babylon.JsonObjects.approval.Approval;
import com.adstream.automate.babylon.JsonObjects.approval.ApprovalStage;
import com.adstream.automate.babylon.JsonObjects.dictionary.Dictionary;
import com.adstream.automate.babylon.JsonObjects.dictionary.DictionaryType;
import com.adstream.automate.babylon.JsonObjects.dictionary.DictionaryValues;
import com.adstream.automate.babylon.JsonObjects.gdn.*;
import com.adstream.automate.babylon.JsonObjects.mediamanager.AQAReport;
import com.adstream.automate.babylon.JsonObjects.mediamanager.PAPIApplication;
import com.adstream.automate.babylon.JsonObjects.ordering.*;
import com.adstream.automate.babylon.JsonObjects.ordering.enums.OrderReportType;
import com.adstream.automate.babylon.JsonObjects.ordering.enums.UploadRequestType;
import com.adstream.automate.babylon.JsonObjects.schema.AssetElementCommonSchema;
import com.adstream.automate.babylon.JsonObjects.schema.AssetElementProjectCommonSchema;
import com.adstream.automate.babylon.JsonObjects.schema.AssetSchema;
import com.adstream.automate.babylon.JsonObjects.schema.ProjectSchema;
import com.adstream.automate.babylon.JsonObjects.usagerights.BaseUsageRight;
import com.adstream.automate.babylon.JsonObjects.usagerights.UsageRight;
import com.adstream.automate.babylon.core.BabylonCoreMonoService;
import com.adstream.automate.babylon.core.BatchTaskApi;
import com.adstream.automate.babylon.middleware.BabylonMiddlewareService;
import com.adstream.automate.utils.Common;
import com.adstream.automate.utils.Gen;
import com.adstream.automate.utils.IO;
import com.adstream.gdn.api.client.serialization.Job;
import com.adstream.gdn.api.client.serialization.JobResponse;
import com.adstream.gdn.api.client.serialization.RegisterJob;
import com.adstream.gdn.api.client.serialization.RegisterJobResponse;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import com.google.gson.*;
import org.apache.commons.codec.binary.Base64;
import org.apache.commons.lang.ArrayUtils;
import org.apache.http.Header;
import org.apache.http.HttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.client.methods.HttpPut;
import org.apache.http.entity.ContentType;
import org.apache.http.entity.FileEntity;
import org.apache.http.entity.StringEntity;
import org.apache.http.entity.mime.MultipartEntityBuilder;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;
import org.apache.log4j.Logger;
import org.joda.time.DateTime;

import javax.imageio.ImageIO;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.List;
import java.util.concurrent.atomic.AtomicInteger;

/**
 * User: ruslan.semerenko
 * Date: 02.04.12 13:28
 */
public class BabylonServiceWrapper {
    private static AtomicInteger uploadedFilesCount = new AtomicInteger(0);
    private Logger log = Logger.getLogger(this.getClass());
    private boolean loggedIn;
    private String loggedUserEmail;
    private BabylonService service;
    private BabylonMonoService monoService;
    private PaperPusherService paperPusherService;

    public static int getUploadedFilesCount() {
        return uploadedFilesCount.get();
    }

    public BabylonServiceWrapper(BabylonService service, PaperPusherService paperPusherService) {
        this.service = service;
        this.paperPusherService = paperPusherService;
        if (service instanceof BabylonMiddlewareService) {
            monoService = (BabylonMiddlewareService) service;
        } else if (service instanceof BabylonMessageSender) {
            BabylonMessageSender msgSender = (BabylonMessageSender) service;
            monoService = new BabylonCoreMonoService(msgSender.getBaseUrl());
        }
    }

    public BabylonService getWrappedService() {
        return service;
    }

    public String getVersion() {
        return service.getVersion();
    }

    public String getNewLibraryMiddleTierVersion() {
        return service.getNewLibraryMiddleTierVersion();
    }

    public String getNewLibraryWebappVersion() {
        return service.getNewLibraryWebappVersion();
    }
    public String getAdcostVersion() {
        return service.getAdcostVersion();
    }

    public String getBranch() {
        return service.getBranch();
    }

    public boolean logIn(String email, String password) {
        loggedIn = service.auth(email, password) != null;
        loggedUserEmail = loggedIn ? email : null;
        return isLoggedIn();
    }

    public boolean logInToAdcost(User user) {
        loggedIn = service.adcostAuth(user.getId())!= null;
        loggedUserEmail = loggedIn ? user.getUserEmail() : null;
        return isLoggedIn();
    }

    public void impersonate(String email, String comment) {
        checkLoggedIn();
        loggedIn = service.impersonate(email, comment) != null;
        loggedUserEmail = loggedIn ? email : null;
    }

    public boolean logInSSO(String email, String password) {
        try {
            loggedIn = service.authSSO(email, password) != null;
        } catch (Exception e) {
            loggedIn = false;
            e.printStackTrace();
        }
        loggedUserEmail = loggedIn ? email : null;
        return isLoggedIn();
    }

    public AssetElementCommonSchema getAssetElementCommonSchema(String agencyId) {
        checkLoggedIn();
        return service.getAssetElementCommonSchema(agencyId);
    }

    public AssetElementCommonSchema updateAssetElementCommonSchema(String agencyId, AssetElementCommonSchema schema) {
        checkLoggedIn();
        return service.updateAssetElementCommonSchema(agencyId, schema);
    }

    public AssetSchema getAssetSchema(String agencyId) {
        checkLoggedIn();
        return service.getAssetSchema(agencyId);
    }

    public AssetSchema updateAssetSchema(String agencyId, AssetSchema schema) {
        checkLoggedIn();
        return service.updateAssetSchema(agencyId, schema);
    }

    public ProjectSchema getProjectSchema(String agencyId) {
        checkLoggedIn();
        return service.getProjectSchema(agencyId);
    }

    public ProjectSchema updateProjectSchema(String agencyId, ProjectSchema schema) {
        checkLoggedIn();
        return service.updateProjectSchema(agencyId, schema);
    }

    public AssetElementProjectCommonSchema getAssetElementProjectCommonSchema(String agencyId) {
        checkLoggedIn();
        return service.getAssetElementProjectCommonSchema(agencyId);
    }

    public AssetElementProjectCommonSchema updateAssetElementProjectCommonSchema(String agencyId, AssetElementProjectCommonSchema schema) {
        checkLoggedIn();
        return service.updateAssetElementProjectCommonSchema(agencyId, schema);
    }

    public void uploadBrandingLogo(String agencyId, String color, File logo) {
        try {
            checkLoggedIn();

            Agency agency = getAgencyById(agencyId);
            agency.setBrandingColor(color);

            if (logo != null) {
                BufferedImage image = ImageIO.read(logo);
                BufferedImage resizedImage = image;

                int width = image.getWidth();
                int height = image.getHeight();
                int max = Math.max(width, height);
                if (max > 170) {
                    double factor = max / 170.0;
                    width = (int) Math.round(width / factor);
                    height = (int) Math.round(height / factor);

                    int type = image.getType() == 0 ? BufferedImage.TYPE_INT_ARGB : image.getType();
                    resizedImage = new BufferedImage(width, height, type);
                    Graphics2D graphics = resizedImage.createGraphics();
                    graphics.setComposite(AlphaComposite.Src);

                    graphics.setRenderingHint(RenderingHints.KEY_INTERPOLATION, RenderingHints.VALUE_INTERPOLATION_BILINEAR);
                    graphics.setRenderingHint(RenderingHints.KEY_RENDERING, RenderingHints.VALUE_RENDER_QUALITY);
                    graphics.setRenderingHint(RenderingHints.KEY_ANTIALIASING, RenderingHints.VALUE_ANTIALIAS_ON);

                    graphics.drawImage(image, 0, 0, width, height, null);
                    graphics.dispose();
                }

                ByteArrayOutputStream stream = new ByteArrayOutputStream();
                ImageIO.write(resizedImage, "png", stream);
                byte[] bytes = stream.toByteArray();
                agency.setBrandingLogo("data:image/png;base64," + Base64.encodeBase64String(bytes));
            }

            getWrappedService().updateAgency(agency);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public User getUser(String id) {
        checkLoggedIn();
        return service.getUser(id);
    }

    public User getCurrentUser() {
        checkLoggedIn();
        return service.getCurrentUser();
    }

    public User getUserByEmail(String email) {
        checkLoggedIn();
        return getUserByEmail(email, 10000);
    }

    public User getUserByEmail(String email, long timeout) {
        checkLoggedIn();
        LuceneSearchingParams query = new LuceneSearchingParams();
        query.setQuery("_cm.common.email.untouched:" + email);
        long start = System.currentTimeMillis();
        do {
            SearchResult<User> result = service.findUsers(query);
            if (result != null && result.getResult().size() > 0)
                return result.getResult().get(0);
            if (timeout > 0)
                Common.sleep(1000);
        } while (System.currentTimeMillis() - start < timeout);
        return null;
    }

    public SearchResult<User> getUsersWithRoleFromAgency(String roleId, String agencyId) {
        checkLoggedIn();
        return service.getAclSubjects(roleId, agencyId);
    }

    public SearchResult<User> findUsers(LuceneSearchingParams query) {
        checkLoggedIn();
        return service.findUsers(query);
    }

    public User createGlobalAdminUser(String groupId, User user){
        checkLoggedIn();
        User usr = service.createGlobalAdminUser(groupId, user);
        Common.sleep(2000);
        service.getGlobalAdminUsers();
        return usr;
    }

    public User editGlobalAdminUser(String groupId, User user){
        checkLoggedIn();
        User usr = service.editGlobalAdminUser(groupId, user);
        Common.sleep(2000);
        service.getGlobalAdminUsers();
        return usr;
    }

    public List<String> getGlobalAdminUsers(){
        checkLoggedIn();
        return service.getGlobalAdminUsers();
    }

    public User createUser(User user) {
        checkLoggedIn();
        return service.createUser(user.getAgency().getId(), user);
    }

    public User updateUser(String userId, User newUser) {
        checkLoggedIn();
        String[] roles = new String[newUser.getRoles().length];
        for (int i = 0; i < roles.length; i++)
            roles[i] = newUser.getRoles()[i].getId();
        service.setUserRole(newUser.getAgency().getId(), userId, roles);
        return service.updateUser(userId, newUser);
    }

    public void allowUserToViewPublicTemplates(String agencyId, String userId, boolean allow) {
        checkLoggedIn();
        service.allowUserToViewPublicTemplates(agencyId, userId, allow);
    }

    public void deleteUser(String userId, String reassignDataToUserId) {
        checkLoggedIn();
        service.deleteUser(userId, reassignDataToUserId);
    }

    public BaseObject addUsersToLibraryTeam(String teamName, List<User> users) {
        BaseObject libraryTeam = getLibraryTeamByName(teamName, 0);
        if (libraryTeam == null) {
            libraryTeam = createLibraryTeam(service.getCurrentAgency().getId(), teamName);
            getLibraryTeamByName(teamName);
        }
        for (User user : users) {
            service.addChild(libraryTeam.getId(), user);
        }
        return libraryTeam;
    }

    public void addUsersToLibraryTeamById(String teamId, List<String> usersIds) {
        checkLoggedIn();
        for (String userId : usersIds) service.addChild(teamId, userId);
    }

    public BaseObject createLibraryTeam(String agencyId, String teamName) {
        checkLoggedIn();
        return service.createGroup(agencyId, teamName, "user_group");
    }

    public List<UserGroup> getLibraryTeams(String agencyId) {
        checkLoggedIn();
        SearchResult<UserGroup> result = service.getChildren(agencyId, "user_group");
        return result.getResult();
    }

    public List<User> getLibraryTeamUsers(String libraryTeamId) {
        checkLoggedIn();
        SearchResult<User> result = service.getChildren(libraryTeamId, "user");
        return result.getResult();
    }

    public UserGroup getLibraryTeamByName(String teamName) {
        return getLibraryTeamByName(teamName, 10000);
    }

    public UserGroup getLibraryTeamByName(String teamName, long timeout) {
        checkLoggedIn();
        long deadline = System.currentTimeMillis() + timeout;
        do {
            for (UserGroup group : getLibraryTeams(getCurrentAgency().getId())) {
                if (group.getName().equals(teamName)) {
                    return group;
                }
            }
            if (timeout > 0) {
                Common.sleep(1000);
            }
        } while (System.currentTimeMillis() < deadline);
        return null;
    }

    public Agency createAgency(Agency agency) {
        checkLoggedIn();
        return service.createAgency(agency);
    }

    public Agency updateAgency(Agency agency) {
        checkLoggedIn();
        return service.updateAgency(agency);
    }

    public void addPartnerAgency(String agencyId, String partnerAgencyId, boolean canBill, boolean canView) {
        service.addPartnerAgency(agencyId, partnerAgencyId, canBill, canView);
    }

    public List<String> getPartnerAgenciesId(String agencyId) {
        List<String> agenciesId = new ArrayList<>();
        for (Agency agency : service.getPartnerAgencies(agencyId)) {
            agenciesId.add(agency.getId());
        }
        return agenciesId;
    }

    public void removePartnerAgency(String agencyId, String partnerAgencyId) {
        checkLoggedIn();
        service.removePartnerAgency(agencyId, partnerAgencyId);
    }

    public AssetFilter createAssetFilterCategory(String name, String query) {
        checkLoggedIn();
        return service.createAssetFilter(name, "asset_filter_category", query);
    }

    public AssetFilter createAssetFilterCategoryForClient(String name, String query,String userId) {
        checkLoggedIn();
        return service.createAssetFilterForClient(name, "asset_filter_category", query, userId);
    }

    public AssetFilter updateAssetFilter(String assetFilterId, String name, String query) {
        checkLoggedIn();
        return service.updateAssetFilter(assetFilterId, name, query);
    }

    public AssetFilter createAssetFilterCollection(String name, String query) {
        checkLoggedIn();
        return service.createAssetFilter(name, "asset_filter_collection", query);
    }

    public AssetFilters getAssetFilters() {
        checkLoggedIn();
        return service.getAssetFilters();
    }

    public AssetFilters getAssetFiltersForClient(String userId) {
        checkLoggedIn();
        return service.getAssetFiltersForClient(userId);
    }

    public AssetFilters getAssetFiltersCategory() {
        checkLoggedIn();
        return service.getAssetFilters("asset_filter_category");
    }

    public AssetFilters getAssetFiltersCollection() {
        checkLoggedIn();
        return service.getAssetFilters("asset_filter_collection");
    }

    public void shareAssetFilter(String assetFilterId, String subjectId, String roleId) {
        checkLoggedIn();
        service.shareAssetFilter(assetFilterId, subjectId, roleId);
    }

    public void addAssetToProjectFolder(String assetId, String parentId) {
        checkLoggedIn();
        service.addAssetToProjectFolder(assetId, parentId);
    }

    public void shareAssetFilterToAgency(String assetFilterId, String agencyId) {
        checkLoggedIn();
        service.shareAssetFilterToAgency(assetFilterId, agencyId);
    }

    public boolean isAssetFilterSharedToUser(String assetFilterId, String userId) {
        checkLoggedIn();
        for (BaseObject user : service.getAssetFilterSubjects(assetFilterId).getResult()) {
            if (user.getId().equals(userId)) {
                return true;
            }
        }
        return false;
    }

    public boolean isAssetFilterSharedToAgency(String assetFilterId, String agencyId) {
        checkLoggedIn();
        for (Agency agency : service.getAssetFilterAgencies(assetFilterId).getResult()) {
            if (agency.getId().equals(agencyId)) {
                return true;
            }
        }
        return false;
    }

    public AssetFilter getAssetsFilterByName(String name, String subType) {
        checkLoggedIn();
        return getAssetsFilterByName(name, subType, 10000);
    }

    public AssetFilter getAssetsFilterByName(String name, String subType, long timeout) {
        long start = System.currentTimeMillis();
        do {
            AssetFilters assetFilters = getAssetFilters();
            for (AssetFilter aF : assetFilters.getFilters()) {
                if (subType.isEmpty()) {
                    if (aF.getName().equals(name)) {
                        return aF;
                    }
                } else {
                    if (aF.getName().equals(name) && aF.getSubtype().equals(subType)) {
                        return aF;
                    }
                }
            }
            if (timeout > 0) {
                Common.sleep(1000);
            }
        } while (System.currentTimeMillis() - start < timeout);
        return null;
    }

    public AssetFilter getAssetsFilterByNameForClient(String name, String subType,String userId) {
        checkLoggedIn();
        return getAssetsFilterByNameForClient(name, subType, 10000,userId);
    }
    public AssetFilter getAssetsFilterByNameForClient(String name, String subType, long timeout,String userId) {
        long start = System.currentTimeMillis();
        do {
            AssetFilters assetFilters = getAssetFiltersForClient(userId);
            for (AssetFilter aF : assetFilters.getFilters()) {
                if (subType.isEmpty()) {
                    if (aF.getName().equals(name)) {
                        return aF;
                    }
                } else {
                    if (aF.getName().equals(name) && aF.getSubtype().equals(subType)) {
                        return aF;
                    }
                }
            }
            if (timeout > 0) {
                Common.sleep(1000);
            }
        } while (System.currentTimeMillis() - start < timeout);
        return null;
    }

    public Content getAssetByName(String collectionId, String assetName) {
        LuceneSearchingParams query = new LuceneSearchingParams()
                .setQuery(String.format("_cm.common.name:\"%s\"", assetName))
                .setResultsOnPage(1)
                .setSortingField("_created")
                .setSortingOrder("desc");
        SearchResult<Content> result = findAssets(collectionId, query);
        if (result.getResult().size() > 0)
            return result.getResult().get(0);
        return null;
    }

    public Content getAssetByNameForClient(String collectionId, String assetName,String userId) {
        LuceneSearchingParams query = new LuceneSearchingParams()
                .setQuery(String.format("_cm.common.name:\"%s\"", assetName))
                .setResultsOnPage(1)
                .setSortingField("_created")
                .setSortingOrder("desc");
        SearchResult<Content> result = findAssetsForClient(collectionId, query,userId);
        if (result.getResult().size() > 0)
            return result.getResult().get(0);
        return null;
    }

    public Content getLastUploadedUserAssetById(String collectionId, String userId, String assetId) {
        LuceneSearchingParams query = new LuceneSearchingParams()
                .setQuery(String.format("_cm.common.name:\"%s\" AND createdBy._id:%s", assetId, userId));
        query.setSortingField("_created");
        query.setSortingOrder(LuceneSearchingParams.ORDER_DESCENDING);
        SearchResult<Content> assets = findAssets(collectionId, query);

        if (assets.getResult().size() > 0)
            for (Content result : assets.getResult())
                if (result.getName().equals(assetId))
                    return result;

        return null;
    }

    public List<Content> getAllAssetByName(String collectionId, String assetId) {
        LuceneSearchingParams query = new LuceneSearchingParams()
                .setQuery(String.format("_cm.common.name:\"%s\"", assetId));
        List<Content> result = service.findAssets(collectionId, query).getResult();
        Collections.sort(result, new Comparator<Content>() {
            @Override
            public int compare(Content o1, Content o2) {
                return o1.getCreated().compareTo(o2.getCreated());
            }
        });
        return result;
    }

    public List<Content> getAllAssetByName(String collectionId) {
        List<Content> result = service.findAssets(collectionId).getResult();
        Collections.sort(result, new Comparator<Content>() {
            @Override
            public int compare(Content o1, Content o2) {
                return o1.getCreated().compareTo(o2.getCreated());
            }
        });
        return result;
    }

    public boolean isAssetExist(String collectionId, String assetId) {
        SearchResult<Content> assets = service.findAssets(collectionId, new LuceneSearchingParams());
        for (Content asset : assets.getResult()) {
            if (asset.getName().equals(assetId)) {
                return true;
            }
        }
        return false;
    }

    public int getAssetCountForCollection(String collectionId) {
        SearchResult<Content> assets = service.findAssets(collectionId, new LuceneSearchingParams());
        if (assets == null)
            return 0;
        while (assets.hasMore()) {
            LuceneSearchingParams query = new LuceneSearchingParams();
            query.setPageNumber(2);
            assets = service.findAssets(collectionId, query);
            System.out.println();
        }
        return assets.getResult().size();
    }

    public Agency getCurrentAgency() {
        checkLoggedIn();
        return service.getCurrentAgency();
    }

    public Agency getAgencyByName(String agencyName) {
        checkLoggedIn();
        LuceneSearchingParams query = new LuceneSearchingParams();
        query.setQuery(String.format("_cm.common.name:\"%s\"", agencyName));
        List<Agency> agencies = service.findAgencies(query).getResult();
        if (agencies.size() > 0) {
            return agencies.get(0);
        }
        return null;
    }

    public Agency getAgencyById(String agencyId) {
        checkLoggedIn();
        return service.getAgency(agencyId);
    }

    public List<Agency> getAgencies() {
        checkLoggedIn();
        return service.getAgencies();
    }

    public byte[] getLogo(String objectType, String objectId) {
        checkLoggedIn();
        return service.getLogo(objectType, objectId);
    }

    public Project getProject(String projectId) {
        checkLoggedIn();
        return service.getProject(projectId);
    }

    public SearchResult<Project> findProjects(LuceneSearchingParams query) {
        checkLoggedIn();
        return service.findProjects(query);
    }

    public SearchResult<Contact> getContacts(ContactSearchingParams query) {
        checkLoggedIn();
        return service.getContacts(query);
    }

    public List<String> getTeamTemplates(ContactSearchingParams query) {
        checkLoggedIn();
        return service.getTeamTemplates(query);
    }

    public SearchResult<Project> findTemplates(LuceneSearchingParams query) {
        checkLoggedIn();
        return service.findTemplates(query);
    }

    public Project getProjectByName(String projectName) {
        checkLoggedIn();
        return getProjectByName(projectName, 10000);
    }

    public String generateCustomCode(String agencyId, String customCodeFieldName){
        checkLoggedIn();
        return service.generateCustomCode(agencyId, customCodeFieldName);
    }

    public Project getProjectByName(String projectName, long timeout) {
        checkLoggedIn();
        LuceneSearchingParams query = new LuceneSearchingParams();
        query.setQuery(String.format("_cm.common.name.untouched:\"%s\"", projectName));
        long start = System.currentTimeMillis();
        do {
            SearchResult<Project> result = service.findProjects(query);
            if (result.getResult().size() > 0)
                return service.getProject(result.getResult().get(0).getId());
            if (timeout > 0)
                Common.sleep(1000);
        } while (System.currentTimeMillis() - start < timeout);
        return null;
    }

    public Project getWorkRequestByName(String projectName) {
        checkLoggedIn();
        return getWorkRequestByName(projectName, 10000);
    }

    public Project getWorkRequestByName(String projectName, long timeout) {
        checkLoggedIn();
        LuceneSearchingParams query = new LuceneSearchingParams();
        query.setQuery(String.format("_cm.common.name:\"%s\" AND _subtype:\"adkit\"", projectName));
        long start = System.currentTimeMillis();
        do {
            SearchResult<Project> result = service.findProjects(query);
            if (result.getResult().size() > 0)
                return service.getProject(result.getResult().get(0).getId());
            if (timeout > 0)
                Common.sleep(1000);
        } while (System.currentTimeMillis() - start < timeout);
        return null;
    }

    public int getProjectsCount() {
        return getProjectsCount(10000);
    }

    public int getProjectsCount(long timeout) {
        checkLoggedIn();
        long start = System.currentTimeMillis();
        do {
            SearchResult<Project> result = service.findProjects(new LuceneSearchingParams());
            if (result != null)
                return result.getResult().size();
            if (timeout > 0)
                Common.sleep(1000);
        } while (System.currentTimeMillis() - start < timeout);
        return 0;
    }

    public Project getWorkRequestTemplateByName(String projectName) {
        checkLoggedIn();
        return getWorkRequestTemplateByName(projectName, 10000);
    }

    public Project getWorkRequestTemplateByName(String projectName, long timeout) {
        checkLoggedIn();
        LuceneSearchingParams query = new LuceneSearchingParams();
        query.setQuery(String.format("_cm.common.name:\"%s\" AND _subtype:\"adkit_template\"", projectName));
        long start = System.currentTimeMillis();
        do {
            SearchResult<Project> result = service.findTemplates(query);
            if (result.getResult().size() > 0)
                return service.getProject(result.getResult().get(0).getId());
            if (timeout > 0)
                Common.sleep(1000);
        } while (System.currentTimeMillis() - start < timeout);
        return null;
    }


    public Project getTemplateByName(String templateName) {
        checkLoggedIn();
        return getTemplateByName(templateName, 10000);
    }

    public Project getTemplateByName(String templateName, long timeout) {
        checkLoggedIn();
        LuceneSearchingParams query = new LuceneSearchingParams();
        query.setQuery(String.format("_cm.common.name.untouched:\"%s\" AND _subtype:\"project_template\"", templateName));
        long start = System.currentTimeMillis();
        do {
            SearchResult<Project> result = service.findTemplates(query);
            if (result.getResult().size() > 0)
                return service.getProject(result.getResult().get(0).getId());
            if (timeout > 0)
                Common.sleep(1000);
        } while (System.currentTimeMillis() - start < timeout);
        return null;
    }

    public int getTemplatesCount() {
        return getTemplatesCount(10000);
    }

    public int getTemplatesCount(long timeout) {
        checkLoggedIn();
        long start = System.currentTimeMillis();
        do {
            SearchResult<Project> result = service.findTemplates(new LuceneSearchingParams());
            if (result != null)
                return result.getResult().size();
            if (timeout > 0)
                Common.sleep(1000);
        } while (System.currentTimeMillis() - start < timeout);
        return 0;
    }

    private String[] addCurrentUserAsProjectAdmin(String[] originalAdmins) {
        String currentUserEmail = service.getCurrentUser().getEmail();
        return (String[]) ArrayUtils.addAll(originalAdmins, new String[]{currentUserEmail});
    }

    public Project createProject(Project project) {
        checkLoggedIn();
        project.setAdministrators(addCurrentUserAsProjectAdmin(project.getAdministrators()));

        if (!project.getLogo().isEmpty()) {
            project.setLogo(new String(Base64.encodeBase64(IO.readFile(new File(project.getLogo())))));
        } else {
            project.setLogo(null);
        }
        Project apiProject;
        String agencyId = project.getAgency() == null ? null : project.getAgency().getId();
        if (agencyId != null && !agencyId.equals(getCurrentAgency().getId())) {
            // create project in another agency
            apiProject = service.createProject(agencyId, project);
        } else {
            apiProject = service.createProject(project);
        }
        if (apiProject == null) {
            // Already exist
            return getProjectByName(project.getName());
        }
        if (project.getAdministrators().length > 0) {
            Role role = getRoleByName("project.admin",false);
            TeamPermission[] permissions = new TeamPermission[project.getAdministrators().length];
            for (int i = 0; i < project.getAdministrators().length; i++) {
                String userIdOrEmail;
                if(getUserByEmail(project.getAdministrators()[i])!=null) {
                    userIdOrEmail = getUserByEmail(project.getAdministrators()[i]).getId();
                }else {
                    userIdOrEmail = project.getAdministrators()[i];
                }
                //String email = project.getAdministrators()[i];
                permissions[i] = new TeamPermission(apiProject.getId(), userIdOrEmail, role.getId(), true, null);
            }
            addUserToProjectTeam(permissions);
        }
        return apiProject;
    }


    public void createXMPMapping(String agencyId, List<XMPMapping> xmpMapping) {
        service.createXMPMapping(agencyId, xmpMapping);
    }

    public Project updateProject(String projectId, Project newProject) {
        checkLoggedIn();
        return service.updateProject(projectId, newProject);
    }

    public void deleteProject(String projectId) {
        checkLoggedIn();
        service.deleteProject(projectId);
    }

    public Content getProjectRootFolder(String projectId) {
        if (service instanceof BabylonMiddlewareService) {
            Project project = getProject(projectId);
            List<Content> result = ((BabylonMiddlewareService)service).getProjectFolders(projectId, projectId);
            for (Content folder : result) {
                if (folder.getName().equals(project.getName())) {
                    return folder;
                }
            }
        } else {
            SearchResult<Content> result = findContent(projectId, new LuceneSearchingParams().setQuery("_parents.$id:" + projectId));
            if (result.getResult().size() > 0) {
                return result.getResult().get(0);
            }
        }
        return null;
    }

    public Content getFolderByName(String projectId, String parentId, String folderName) {
        Content result = getFolderByName(projectId, parentId, folderName, 10000);
        if (result == null)
            result = getFolderByName(projectId, parentId, folderName.replaceAll("/", ""), 10000);
        return result;
    }

    public Content getFolderByName(String projectId, String parentId, String folderName, long timeout) {
        LuceneSearchingParams query = new LuceneSearchingParams();
        if(projectId==parentId){
            query.setQuery(String.format("_cm.common.name.untouched:\"%s\"", folderName));
        }else{
            query.setQuery(String.format("_cm.common.name.untouched:\"%s\" AND _parents.$id:%s", folderName, parentId));
        }
        long start = System.currentTimeMillis();
        do {
            SearchResult<Content> result;
            if (service instanceof BabylonMiddlewareService) {
                List<Content> folders = ((BabylonMiddlewareService) service).getProjectFolders(projectId, parentId);
                List<Content> matchedFodlers = new ArrayList<>();
                for (Content folder : folders) {
                    if (folder.getName() != null && folder.getName().equals(folderName)) {
                        matchedFodlers.add(folder);
                    }
                }
                result = new SearchResult<>();
                result.setResult(matchedFodlers);
            } else {
                result = service.findContent(projectId, query);
            }

            if (result.getResult().size() > 0) {
                return result.getResult().get(0);
            }

            if (timeout > 0) {
                Common.sleep(1000);
            }
        } while (System.currentTimeMillis() - start < timeout);
        return null;
    }

    public Content createFolder(String parentId, String folderName) {
        checkLoggedIn();
        Content folder = new Content();
        folder.setName(folderName);
        folder.setSubtype("folder");
        return service.createContent(parentId, folder);
    }

    public Content createContent(String folderId, String fileName, String tmpPath) {
        checkLoggedIn();
        Content content = new Content();
        content.setSubtype("element");
        content.setName(fileName);
        content.setTmpPath(tmpPath);
        content.setPath(fileName);
        return service.createContent(folderId, content);
    }

    public GDNFileRegister registerGDNContent(String parentId, GDNFileWrapper gdnFileWrapper) {
        checkLoggedIn();
        return service.registerGDNContent(parentId, Arrays.asList(gdnFileWrapper));
    }

    public Content createContentGDN(String folderId, String fileName, String gdnFileId) {
        checkLoggedIn();
        Content content = new Content();
        content.setSubtype("element");
        content.setName(fileName);
        return service.createContentGDN(folderId, content, gdnFileId);
    }

    public Content createClientContentGDN(String folderId, String fileName, String gdnFileId,String userId) {
        checkLoggedIn();
        Content content = new Content();
        content.setSubtype("element");
        content.setName(fileName);
        return service.createClientContentGDN(folderId, content, gdnFileId, userId);
    }

    public Content multipartFolderUploadComplete(String folderId,String fileName, String storageId, String gdnFileId, String[] etag,String uploadId) {
        checkLoggedIn();
        Content content = new Content();
        MultiPartUploadCompleteData multiPartUploadCompleteData = new MultiPartUploadCompleteData();
        multiPartUploadCompleteData.setUploadId(uploadId);
        multiPartUploadCompleteData.setStorageId(storageId);
        multiPartUploadCompleteData.seteTags(etag);
        content.setSubtype("element");
        content.setName(fileName);
        content.setMultiPartUploadCompleteData(multiPartUploadCompleteData);
        return service.createContentGDN(folderId, content, gdnFileId);
    }

    public Content createRevision(String elementId, String fileName, String tmpPath) {
        checkLoggedIn();
        Content content = new Content();
        content.setSubtype("element");
        content.setName(fileName);
        content.setTmpPath(tmpPath);
        content.setPath(fileName);
        return service.createRevision(elementId, content);
    }

    public Content createClientRevision(String elementId, String fileName, String tmpPath,String userId) {
        checkLoggedIn();
        Content content = new Content();
        content.setSubtype("element");
        content.setName(fileName);
        content.setTmpPath(tmpPath);
        content.setPath(fileName);
        return service.createClientRevision(elementId, content, userId);
    }

    public Content createAttachedFile(Content originalFile, String attachedFileId, String attachedFileName, long attachedFileSize) {
        checkLoggedIn();
        AttachedFile attachedFile = new AttachedFile();
        attachedFile.setId(attachedFileId);
        attachedFile.setName(attachedFileName);
        attachedFile.setSize(attachedFileSize);
        attachedFile.setUploadedTimestamp(System.currentTimeMillis());
        attachedFile.setUploaderName(getCurrentUser().getFullName());
        return service.createAttachedFile(originalFile, attachedFile);
    }

    public GDNFileRegister registerGDNAsset(GDNFileWrapper gdnFileWrapper) {
        checkLoggedIn();
        return service.registerGDNAssets(Arrays.asList(gdnFileWrapper));
    }

    public JobResponse gdnIngestRegister(Job job) {
        return service.gdnIngestRegister(job);
    }

    public IngestDoc getIngestID(String assetID) {
        return service.getIngestID(assetID);
    }

    public void setRevision(IngestDoc ingestdoc, String ingestID, long size, String fileId, String assetId) {
        service.setRevision(ingestdoc,ingestID,size,fileId,assetId);
    }

    public void multipartIngestComplete(String gdnFileId,MultiPartUploadCompleteData multiPartUploadCompleteData) {
        service.multipartIngestComplete(gdnFileId, multiPartUploadCompleteData);
    }

    public Content createAssetGDN(String fileName, String gdnFileId) {
        return createAssetGDN(fileName, gdnFileId, "");
    }

    public Content createAssetGDN(String fileName, String gdnFileId, String agencyId) {
        checkLoggedIn();
        Content content = new Content();
        //content.setId(fileName);
        content.setName(fileName);
        return service.createAssetGDN(content, gdnFileId, agencyId);
    }

    public Content multipartAssetUploadComplete(String fileName, String storageId, String gdnFileId, String agencyId, String[] etag,String uploadId) {
        checkLoggedIn();
        Content content = new Content();
        MultiPartUploadCompleteData multiPartUploadCompleteData = new MultiPartUploadCompleteData();
        multiPartUploadCompleteData.setUploadId(uploadId);
        multiPartUploadCompleteData.setStorageId(storageId);
        multiPartUploadCompleteData.seteTags(etag);
        content.setName(fileName);
        content.setMultiPartUploadCompleteData(multiPartUploadCompleteData);
        return service.createAssetGDN(content, gdnFileId, agencyId);
    }

    public AmazonContent createfilePart(String gdnFileId,String storageId) {
        checkLoggedIn();
        return service.createfilePart(gdnFileId, storageId);
    }

    public void shareFile(List<String> fileIds, List<String> usersIds, DateTime expirationDate, String message, boolean downloadProxy, boolean downloadOriginal) {
        shareFileOrAsset("element", fileIds, usersIds, expirationDate, message, downloadProxy, downloadOriginal);
    }

    public void shareAsset(List<String> assetIds, List<String> usersIds, DateTime expirationDate, String message, boolean downloadProxy, boolean downloadOriginal) {
        shareFileOrAsset("asset", assetIds, usersIds, expirationDate, message, downloadProxy, downloadOriginal);
    }

    private void shareFileOrAsset(String documentType, List<String> documentIds, List<String> usersIds, DateTime expirationDate, String message, boolean downloadProxy, boolean downloadOriginal) {
        Long expiration = expirationDate == null ? null : expirationDate.getMillis();
        service.shareFileOrAsset(documentType, documentIds, usersIds, expiration, message, true, true, downloadProxy, downloadOriginal);
    }

    public Content moveFileIntoLibrary(Content content) {
        checkLoggedIn();
        return service.moveFileIntoLibrary(content);
    }

    public Content getContent(String contentId) {
        checkLoggedIn();
        return service.getContent(contentId);
    }

    public Content updateContent(Content content) {
        checkLoggedIn();
        return service.updateContent(content.getId(), content);
    }

    public Content updateAsset(Content asset) {
        checkLoggedIn();
        return service.updateAsset(asset);
    }

    public Content patchAsset(String assetId, String campaign) {
        checkLoggedIn();
        return service.patchAsset(assetId,campaign);
    }

    public void deleteAsset(String assetId) {
        checkLoggedIn();
        service.deleteAsset(assetId);
    }

    public SearchResult<Content> findContent(String projectId, LuceneSearchingParams query) {
        checkLoggedIn();
        return service.findContent(projectId, query);
    }

    public SearchResult<Content> findContentAllProjects(LuceneSearchingParams query) {
        checkLoggedIn();
        return service.findContentAllProjects(query);
    }

    public List<Content> searchContentByFolderName(String folderName, LuceneSearchingParams query) {
        SearchResult<Content> searchResult = findContentAllProjects(query);
        List<Content> listOfContent = new ArrayList<>();
        for (Content content : searchResult.getResult()) {
            if (content.getSubtype().equals("folder") && content.getName().equals(folderName)) {
                listOfContent.add(content);
            }

        }
        return listOfContent;
    }

    public SearchResult<Content> findFoldersContent(String folderId, LuceneSearchingParams query) {
        checkLoggedIn();
        return service.findFoldersContent(folderId, query);
    }

    public SearchResult<Content> findClientFoldersContent(String folderId,String userId, LuceneSearchingParams query) {
        checkLoggedIn();
        return service.findClientFoldersContent(folderId, userId, query);
    }

    public Content getAsset(String assetId) {
        checkLoggedIn();
        return service.getAsset(assetId);
    }

    public int getAssetsFromPageCount(int page, int size) {
        checkLoggedIn();
        LuceneSearchingParams query = new LuceneSearchingParams()
                .setQuery("agency._id=" + getCurrentAgency().getId())
                .setPageNumber(page)
                .setResultsOnPage(size);
        return service.findAssets(query).getResult().size();
    }

    public SearchResult<Content> findAssets(LuceneSearchingParams query) {
        checkLoggedIn();
        return service.findAssets(query);
    }

    public SearchResult<Content> findAssets(String parentId, LuceneSearchingParams query) {
        checkLoggedIn();
        return service.findAssets(parentId, query);
    }


    public SearchResult<Content> findAssetsForClient(String parentId, LuceneSearchingParams query,String userId) {
        checkLoggedIn();
        return service.findAssetsForClient(parentId, query,userId);
    }

    public SearchResult<Content> findAssets(String parentId) {
        checkLoggedIn();
        return service.findAssets(parentId);
    }

    public BatchTaskApi batchTaskApi(){
        checkLoggedIn();
        return service.batchTaskApi();
    }

    public boolean checkThatAssetExist(String parentId, LuceneSearchingParams query, String id) {
        SearchResult<Content> assets = findAssets(parentId, query);
        for (Content asset : assets.getResult()) {
            if (asset.getId().equals(id)) return true;
        }
        return false;
    }

    public void copyContent(String contentId, String toFolderId) {
        checkLoggedIn();
        service.copyContent(new String[]{contentId}, toFolderId);
    }

    public void moveContent(String contentId, String toFolderId) {
        checkLoggedIn();
        service.moveContent(new String[]{contentId}, toFolderId);
    }

    public void deleteContent(String contentId) {
        checkLoggedIn();
        service.deleteContent(contentId);
    }

    public SearchResult<Content> findTrashBinFiles(String projectId) {
        checkLoggedIn();
        return service.findTrashBinFiles(projectId);
    }

    public SearchResult<Content> findTrashBinFolders(String projectId) {
        checkLoggedIn();
        return service.findTrashBinFolders(projectId);
    }

    public SearchResult<Content> findTrashBinFoldersContent(String folderId, LuceneSearchingParams query) {
        checkLoggedIn();
        return service.findTrashBinFoldersContent(folderId, query);
    }

    public void addRelationBetweenFiles(String agencyId, String asType, String childFileId, String parentFileId) {
        service.addRelationBetweenFiles(agencyId, asType, childFileId, parentFileId);
    }

    public Content getFileByName(String folderId, String fileName) {
        checkLoggedIn();
        SearchResult<Content> result = findFoldersContent(folderId, new LuceneSearchingParams());
        for (Content content : result.getResult()) {
            if (content.getName().equals(fileName))
                return getContent(content.getId());
        }
        return null;
    }

    public Content createFolderRecursive(String path, String projectId, String parentId) {
        if (parentId.equals(projectId)&&getProjectRootFolder(projectId)!=null) {
            parentId = getProjectRootFolder(projectId).getId();
        }
        if (path.startsWith("/")) {
            path = path.substring(1);
        }
        String[] parts = path.split("/", 2);
        String folderName = parts[0];
        Content folder = getFolderByName(projectId, parentId, folderName, 0);
        if (folder == null) {
            folder = createFolder(parentId, folderName);
            getFolderByName(projectId, parentId, folderName); //delay wait while folder indexed
        }
        if (parts.length == 2) {
            folder = createFolderRecursive(parts[1], projectId, folder.getId());
        }
        return folder;
    }

    public Content getFolderByPath(String projectId, String path) {
        if (path.startsWith("/")) {
            path = path.substring(1);
        }
        Content desiredFolder = getProjectRootFolder(projectId);
        String parentFolderId = desiredFolder.getId();
        while (!path.isEmpty()) {
            String[] pathParts = path.split("/", 2);
            String folderName = pathParts[0];
            path = pathParts.length > 1 ? pathParts[1] : "";
            desiredFolder = getFolderByName(projectId, parentFolderId, folderName, 0);
            if (desiredFolder != null) {
                parentFolderId = desiredFolder.getId();
            } else {
                return null;
                // throw new RuntimeException("Could not find folder " + folderName + " in parent " + parentFolderId);
            }
        }
        return desiredFolder;
    }

    public Content getFolderByPathInTrash(String projectId, String path) {
        if (path.startsWith("/")) {
            path = path.substring(1);
        }
        List<Content> folders = findTrashBinFolders(projectId).getResult();
        Content desiredFolder = null;
        while (!path.isEmpty()) {
            String[] pathParts = path.split("/", 2);
            String folderName = pathParts[0];
            path = pathParts.length > 1 ? pathParts[1] : "";
            Content currentFolder = null;
            for (Content folder : folders) {
                if (folder.getName().equals(folderName)) {
                    currentFolder = folder;
                    folders = folder.getSubFoldersInTrash();
                    break;
                }
            }
            if (currentFolder != null) {
                desiredFolder = currentFolder;
            } else {
                throw new RuntimeException("Could not find trash folder " + folderName);
            }
        }
        return desiredFolder;
    }

    public SearchResult<User> getTeamUsers(String projectId, boolean children) {
        checkLoggedIn();
        return service.getTeamUsers(projectId, children);
    }

    public SearchResult<User> addUserToProjectTeam(TeamPermission[] permissions) {
        checkLoggedIn();
        return service.addUserToProjectTeam(permissions);
    }

    public String copyFolder(List folderIds, String newParentId, boolean updateMetadata) {
        return service.copyFolder(folderIds, newParentId, updateMetadata);
    }

    public String moveFolder(List folderIds, String newParentId, boolean updateMetadata) {
        return service.moveFolder(folderIds, newParentId, updateMetadata);
    }

    public Content uploadRevision(File file, String elementId) {
        GDNFileWrapper gdnFileWrapper = new GDNFileWrapper(file);
        GDNFileRegister fileRegister = registerGDNContent(elementId, gdnFileWrapper);
        String postURI = fileRegister.getFiles()[0].getFileUri();
        String gdnFileId = fileRegister.getFiles()[0].getFileId();

        String storageSubType = getStorageSubType();

        if (storageSubType.equalsIgnoreCase("s3") && (postURI.contains("X-Amz-Signature"))){
            prepareFileToUploadToS3GDN(gdnFileWrapper, postURI, null);
        }
        else if(postURI.contains("X-Amz-Signature")){
            prepareFileToUploadToS3GDN(gdnFileWrapper, postURI, null);
        }
        else{
            prepareFileToUploadToGDN(gdnFileWrapper, postURI, null);
        }
        return createRevision(elementId, file.getName(), gdnFileId);
    }

    public Content uploadClientRevision(File file, String elementId,String userId) {
        GDNFileWrapper gdnFileWrapper = new GDNFileWrapper(file);
        GDNFileRegister fileRegister = registerGDNContent(elementId, gdnFileWrapper);
        String postURI = fileRegister.getFiles()[0].getFileUri();
        String gdnFileId = fileRegister.getFiles()[0].getFileId();

        if (postURI.contains("X-Amz-Signature")){
            prepareFileToUploadToS3GDN(gdnFileWrapper, postURI, null);
        }
        //  prepareFileToUploadToGDN(gdnFileWrapper, postURI, null);
        return createClientRevision(elementId, file.getName(), gdnFileId, userId);
    }


    public void uploadAttachedFile(File file, Content originalFile, String referenceId, String reference) {
        GDNFileWrapper gdnFileWrapper = new GDNFileWrapper(file);
        GDNFileRegister fileRegister = registerDocuments(gdnFileWrapper, referenceId, reference);
        String attachedFileId = fileRegister.getFiles()[0].getAttachedFileId();
        String postURI = fileRegister.getFiles()[0].getFileUri();
        String gdnFileId = fileRegister.getFiles()[0].getFileId();
        String storageSubType = getStorageSubType();

        if (storageSubType.equalsIgnoreCase("s3")) {
            prepareFileToUploadToS3GDN(gdnFileWrapper, postURI, null);
        }else{
            prepareFileToUploadToGDN(gdnFileWrapper, postURI, null);
        }
        uploadDocumentsCompleteTest(attachedFileId, gdnFileId);
    }


    public void uploadAttachedFile_WorkRequest(String folderId,String agencyId,File file){
        GDNFileWrapper gdnFileWrapper = new GDNFileWrapper(file);
        GDNFileRegister fileRegister = service.registerGDNAssets(Arrays.asList(gdnFileWrapper));
        String attachedFileId = fileRegister.getFiles()[0].getAttachedFileId();
        String gdnFileId = fileRegister.getFiles()[0].getFileId();
        String storageSubType = getStorageSubType();
        String postURI = service.uploadDocument_WorkRequest(gdnFileWrapper);
        if (storageSubType.equalsIgnoreCase("s3")) {
            prepareFileToUploadToS3GDN(gdnFileWrapper, postURI, null);
        }else{
            prepareFileToUploadToGDN(gdnFileWrapper, postURI, null);
        }
        UploadComplete_WorkRequest(folderId,gdnFileId,file.getName());
    }

    public Content uploadFileNverge(File file, String folderId) {
        HashMap<String, String> uploadResult = prepareFileToUpload(file, null);
        return createContent(folderId, file.getName(), uploadResult.get("tmpPath"));
    }

    public void uploadFileToProjectViaSendplus(File file, String folderId, String emailID, String passWord) throws IOException {
        prepareFileForUploadToProject(file, null, emailID, passWord, folderId);
    }

    public void uploadFileRevisionToProjectViaSendplus(File file, String fileId, String emailID, String passWord) throws IOException {
        prepareFileRevisionUploadToProject(file, null, emailID, passWord, fileId);
    }

    public void uploadFileAttachmentToProjectViaSendplus(File file, String fileId, String emailID, String passWord) throws IOException {
        prepareFileAttachmentUploadToProject(file,emailID, passWord, fileId);
    }

    public void downloadFilesFromProjectAndFolderViaSendplus(String emailID, String passWord, String elementID, String fileID) throws IOException {
        preparedownloadFromFolderAndProjectViaSendplus(emailID, passWord, elementID, fileID);
    }

    public void uploadFileToLibraryViaSendplus(File file, String emailID, String passWord) throws IOException {
        prepareFileForUploadToLibrary(file, null, emailID, passWord);
    }

    public void uploadAttachToAssetViaSendplus(File file, String emailID, String passWord,String assetId) throws IOException {
        prepareAssetAttachViaSendplus(file, null, emailID, passWord, assetId);
    }

    public Content uploadFile(File file, String folderId) {
        return uploadFile(file, folderId, null);
    }

    public Content uploadClientFile(File file, String folderId,String userId) {
        return uploadClientFile(file, folderId, null, userId);
    }

    public Content uploadClientFile(File file, String folderId, UploadListener uploadListener,String userId ) {
        GDNFileWrapper gdnFileWrapper = new GDNFileWrapper(file);
        GDNFileRegister fileRegister = registerGDNContent(folderId, gdnFileWrapper);
        String postURI = fileRegister.getFiles()[0].getFileUri();
        String gdnFileId = fileRegister.getFiles()[0].getFileId();
        // HashMap<String, String> uploadResult = prepareFileToUploadToGDN(gdnFileWrapper, postURI, uploadListener);
        // Content content = createClientContentGDN(folderId, file.getName(), gdnFileId, userId);
        HashMap<String, String> uploadResult = null;
        Content content = null;
        if (postURI.contains("X-Amz-Signature")){
            uploadResult = prepareFileToUploadToS3GDN(gdnFileWrapper, postURI, uploadListener);
            content = createClientContentGDN(folderId, file.getName(), gdnFileId, userId);
        }
        if (uploadListener != null)
            uploadListener.uploadComplete(uploadResult.get("targetFileName"), content.getId());
        return content;
    }

    public Content uploadFile(File file, String folderId, UploadListener uploadListener) {
        GDNFileWrapper gdnFileWrapper = new GDNFileWrapper(file);
        GDNFileRegister fileRegister = registerGDNContent(folderId, gdnFileWrapper);
        String postURI = fileRegister.getFiles()[0].getFileUri();
        String gdnFileId = fileRegister.getFiles()[0].getFileId();
        String storageSubType = getStorageSubType();
        Agency agencyName = getCurrentAgency();
        String storageId = agencyName.getStorageId();
        HashMap<String, String> uploadResult = null;
        Content content = null;
        if (storageSubType.equalsIgnoreCase("s3") &&  postURI.contains("X-Amz-Signature")){
            AmazonContent amazonContent = createfilePart(gdnFileId,storageId);
            uploadResult = prepareFileToUploadToS3GDN(gdnFileWrapper, amazonContent.getUrl(), uploadListener);
            content = multipartFolderUploadComplete(folderId, file.getName(), storageId, gdnFileId, new String[]{uploadResult.get("eTag")}, amazonContent.getUploadId());
        }
        else if( postURI.contains("X-Amz-Signature")){ // This is for sharing files to other storages except s3
            uploadResult = prepareFileToUploadToS3GDN(gdnFileWrapper, postURI, uploadListener);
            //content = multipartFolderUploadComplete(folderId, file.getName(), storageId, gdnFileId, new String[]{uploadResult.get("eTag")}, amazonContent.getUploadId());
            content = createContentGDN(folderId, file.getName(), gdnFileId);
        }
        else{
            uploadResult = prepareFileToUploadToGDN(gdnFileWrapper, postURI, uploadListener);
            content = createContentGDN(folderId, file.getName(), gdnFileId);
        }
        if (uploadListener != null)
            uploadListener.uploadComplete(uploadResult.get("targetFileName"), content.getId());
        return content;
    }

    public Content uploadAsset(File file) {
        return uploadAsset(file, null);
    }

    public Content uploadAsset(File file, UploadListener uploadListener) {
        return uploadAsset(file, uploadListener, "");
    }

    public Content uploadAsset(File  file, UploadListener uploadListener, String agencyId) {
        GDNFileWrapper gdnFileWrapper = new GDNFileWrapper(file, agencyId);
        GDNFileRegister fileRegister = registerGDNAsset(gdnFileWrapper);
        String postURI = fileRegister.getFiles()[0].getFileUri();
        String gdnFileId = fileRegister.getFiles()[0].getFileId();
        String storageSubType = null;
        Agency agencyName;
        String storageId = null;

        if(agencyId.equals("")) {
            agencyName = getCurrentAgency();
            storageId = agencyName.getStorageId();
            storageSubType = getStorageSubType();

        }else if((!agencyId.equals(""))){
            agencyName = getAgencyById(agencyId);
            storageId = agencyName.getStorageId();
            List<FileStorage> storages  = service.getGdnStorages().getResult();
            for (FileStorage storage : storages) {
                if (storage.getFileStorageId().equals(storageId)) {
                    storageSubType= storage.getFileStorageSubType();

                }
            }
        }
        HashMap<String, String> uploadResult ;
        Content content;
        if (storageSubType.equalsIgnoreCase("s3")){
            AmazonContent amazonContent = createfilePart(gdnFileId,storageId);
            uploadResult = prepareFileToUploadToS3GDN(gdnFileWrapper, amazonContent.getUrl(), uploadListener);
            content = multipartAssetUploadComplete(file.getName(), storageId, gdnFileId, agencyId, new String[]{uploadResult.get("eTag")}, amazonContent.getUploadId());
        }
        else {
            uploadResult = prepareFileToUploadToGDN(gdnFileWrapper, postURI, uploadListener);
            content = createAssetGDN(file.getName(), gdnFileId, agencyId);
        }
        if (uploadListener != null)
            uploadListener.uploadComplete(uploadResult.get("targetFileName"), content.getId());
        return content;
    }
    //GDN-3492, GDN-3115
    public String IngestAssetA5(String storageID, File  file, String assetID, String agencyID, UploadListener uploadListener) {
        GDNFileWrapper gdnFileWrapper = new GDNFileWrapper(file);
        RegisterJob job = GDNIngestRegisterJob.getRegisterJobA5(storageID, file, assetID, agencyID);
        RegisterJobResponse response = (RegisterJobResponse) gdnIngestRegister(job);
        String postURI =  response.FileUri().get();
        String storageSubType = getStorageSubType();
        IngestDoc ingestdoc = getIngestID(assetID);
        if (storageSubType.equalsIgnoreCase("s3")){
            AmazonContent amazonContent = createfilePart(response.FileID().get(), storageID);
            HashMap<String, String> uploadResult = prepareFileToUploadToS3GDN(gdnFileWrapper, amazonContent.getUrl(), uploadListener);
            MultiPartUploadCompleteData multiPartUploadCompleteData = new MultiPartUploadCompleteData();
            multiPartUploadCompleteData.setUploadId(amazonContent.getUploadId());
            multiPartUploadCompleteData.setStorageId(storageID);
            multiPartUploadCompleteData.seteTags(new String[]{uploadResult.get("eTag")});
            Random rand = new Random();
            int  n = rand.nextInt(10) + 1;
            if((n % 2 == 0)){
                ingestdoc.setMultiPartUploadCompleteData(multiPartUploadCompleteData);
            }
            else{
                multipartIngestComplete(response.FileID().get(), multiPartUploadCompleteData);
            }
        }
        else {
            HashMap<String, String>  uploadResult = prepareFileToUploadToGDN(gdnFileWrapper, postURI, uploadListener);
        }
        setRevision(ingestdoc, ingestdoc.get_id(), file.length(), response.FileID().get(), assetID);
        return response.FileID().get();
    }

    public HashMap<String, String> prepareFileToUpload(File file, UploadListener uploadListener) {
        if (!file.exists())
            throw new IllegalArgumentException(String.format("File %s does not exist", file.toString()));

        checkLoggedIn();
        HashMap<String, String> result = new HashMap<>();
        StringBuilder tmpPath = new StringBuilder();
        tmpPath.append("/").append(new SimpleDateFormat("yyyyMMdd").format(new Date()));
        tmpPath.append("/").append(service.getCurrentUser().getId());
        tmpPath.append("/").append(System.currentTimeMillis());

        String postUri = getCurrentAgencyStorage().getUploadUrl() + tmpPath.toString();

        long fileLength = file.length();
        String fileName = file.getName();
        String fileExtension = fileName.contains(".") ? fileName.substring(fileName.lastIndexOf(".")) : "";
        String targetFileName = UUID.randomUUID().toString() + fileExtension;

        String lastModified = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSSZ").format(new Date(file.lastModified()));

        CloseableHttpClient client = HttpClients.createDefault();
        final int chunkLength = 10485760;
        int bytesToSend;
        int chunksCount = (int) (fileLength / chunkLength) + 1;
        int fileId = Gen.getInt(10000000, 99999999);
        long totalTime = 0;
        for (int i = 0; i < chunksCount; i++) {
            int bytesUploaded = i * chunkLength;
            bytesToSend = i < chunksCount - 1 ? chunkLength : (int) (fileLength - bytesUploaded);
            byte[] bytes = IO.readFile(file, bytesUploaded, bytesToSend);
            HttpPost request = new HttpPost(postUri);

            MultipartEntityBuilder entityBuilder = MultipartEntityBuilder.create();
            entityBuilder.addTextBody("partitionIndex", "" + i);
            entityBuilder.addTextBody("targetFileName", targetFileName);
            entityBuilder.addTextBody("fileId", "" + fileId);
            entityBuilder.addTextBody("partitionLength", "" + chunkLength);
            entityBuilder.addTextBody("lastModified", lastModified);
            entityBuilder.addTextBody("fileLength", "" + fileLength);
            entityBuilder.addTextBody("fileName", fileName);
            entityBuilder.addTextBody("partitionCount", "" + chunksCount);
            entityBuilder.addBinaryBody("file", bytes, ContentType.APPLICATION_OCTET_STREAM, fileName);

            // todo hardcode! will be changed after sso implementation
            request.setHeader("Authorization", "Basic YWxleEB1bml0LnR2LnVhOjE=");
            request.setEntity(entityBuilder.build());
            try {
                long start = System.currentTimeMillis();
                HttpResponse response = client.execute(request);
                if (response.getStatusLine().getStatusCode() != 200) {
                    System.out.println("File upload request: " + request.getURI());
                    System.out.println("File upload response: " + response.getStatusLine().getStatusCode());
                    System.out.println(EntityUtils.toString(response.getEntity()));
                    throw new IllegalStateException("File not uploaded");
                } else {
                    long time = System.currentTimeMillis() - start;
                    EntityUtils.consume(response.getEntity());
                    totalTime += time;
                    if (uploadListener != null)
                        uploadListener.chunkUploadComplete(bytesUploaded + bytesToSend, fileLength, bytesToSend, time, totalTime, targetFileName);
                }
            } catch (IOException e) {
                throw new IllegalStateException("File not uploaded", e);
            }
        }
        result.put("tmpPath", tmpPath.append("/").append(targetFileName).toString());
        result.put("targetFileName", targetFileName);
        uploadedFilesCount.incrementAndGet();
        return result;
    }


    public void prepareFileForUploadToProject(File file, UploadListener uploadListener, String emailID, String passWord,String folderId) throws IOException {
        File upload_filename = file;
        String cookie = service.loginToSendplusMiddleTier(emailID, passWord);
        HashMap<String, String> upload_data = service.createFileIDForSendplusUploadToProjects(cookie, folderId);
        if (upload_data.get("isS3").equalsIgnoreCase("false")) {
            service.uploadFileToAdbankStorageViaSendplusMiddleTier(upload_data.get("upload_url"), upload_filename);
            service.displayFileInProjectsViaSendplusMiddleTier(cookie, upload_data.get("upload_id"), folderId);
        }
        else {
            String eTag = service.uploadFileToS3AdbankStorageViaSendplusMiddleTier(upload_data.get("upload_url"), upload_filename);
            service.displayS3FileInProjectsViaSendplusMiddleTier(cookie, upload_data.get("upload_id"), folderId, eTag);

        }
    }
    public void preparedownloadFromFolderAndProjectViaSendplus(String emailID, String passWord, String elementID, String fileID) throws IOException {
        String cookie = service.loginToSendplusMiddleTier(emailID, passWord);
        service.downloadFolderAndProjectViaUsingSendplusMiddletier(cookie, elementID, fileID);
    }

    public void prepareFileForUploadToLibrary(File file, UploadListener uploadListener, String emailID, String passWord) throws IOException {
        File upload_filename = file;
        String cookie = service.loginToSendplusMiddleTier(emailID, passWord);
        HashMap<String, String>  upload_data= service.createFileIDForSendplusUploadToLibrary(cookie);
        if (upload_data.get("isS3").equalsIgnoreCase("false")) {
            service.uploadFileToAdbankStorageViaSendplusMiddleTier(upload_data.get("upload_url"), upload_filename);
            service.displayFileInLibraryViaSendplusMiddleTier(cookie, upload_data.get("upload_id")); }
        else
        {
            String eTag = service.uploadFileToS3AdbankStorageViaSendplusMiddleTier(upload_data.get("upload_url"), upload_filename);
            service.displayS3FileInLibraryViaSendplusMiddleTier(cookie, upload_data.get("upload_id"), eTag);

        }
    }

    public void prepareFileRevisionUploadToProject(File file, UploadListener uploadListener, String emailID, String passWord,String fileId) throws IOException {
        File upload_filename = file;
        String cookie = service.loginToSendplusMiddleTier(emailID, passWord);
        HashMap<String, String> upload_data = service.uploadFileRevisionViaSendplus(cookie, fileId, upload_filename.getName(), (int) upload_filename.length());
        if (upload_data.get("isS3").equalsIgnoreCase("false")) {
            service.uploadFileToAdbankStorageViaSendplusMiddleTier(upload_data.get("upload_url"), upload_filename);
            service.displayFileInProjectsViaSendplusMiddleTier(cookie, upload_data.get("upload_id"), fileId);
        }
        else {
            String eTag = service.uploadFileToS3AdbankStorageViaSendplusMiddleTier(upload_data.get("upload_url"), upload_filename);
            service.displayS3FileInProjectsViaSendplusMiddleTier(cookie, upload_data.get("upload_id"), fileId, eTag);

        }
    }

    public void prepareFileAttachmentUploadToProject(File file, String emailID, String passWord,String fileId) throws IOException {
        File upload_filename = file;
        String cookie = service.loginToSendplusMiddleTier(emailID, passWord);
        HashMap<String, String> upload_data = service.uploadFileAttachmentViaSendplus(cookie, fileId,upload_filename.getName(), (int) upload_filename.length());
        if (upload_data.get("isS3").equalsIgnoreCase("false")) {
            service.uploadFileToAdbankStorageViaSendplusMiddleTier(upload_data.get("upload_url"), upload_filename);
            service.displayFileInProjectsViaSendplusMiddleTier(cookie, upload_data.get("upload_id"), fileId);
        }
        else {
            String eTag = service.uploadFileToS3AdbankStorageViaSendplusMiddleTier(upload_data.get("upload_url"), upload_filename);
            service.displayS3FileInProjectsViaSendplusMiddleTier(cookie, upload_data.get("upload_id"), fileId, eTag);

        }
    }


    public void prepareAssetAttachViaSendplus(File file, UploadListener uploadListener, String emailID, String passWord, String assetId) throws IOException
    {
        File upload_filename = file;
        String cookie = service.loginToSendplusMiddleTier(emailID, passWord);
        HashMap<String, String>  upload_data= service.assetAttachmentViaSendplus(cookie,assetId,upload_filename.getName(),(int) upload_filename.length());
        if (upload_data.get("isS3").equalsIgnoreCase("false")) {
            service.uploadFileToAdbankStorageViaSendplusMiddleTier(upload_data.get("upload_url"), upload_filename);
            service.displayFileInLibraryViaSendplusMiddleTier(cookie, upload_data.get("upload_id")); }
        else
        {
            String eTag = service.uploadFileToS3AdbankStorageViaSendplusMiddleTier(upload_data.get("upload_url"), upload_filename);
            service.displayS3FileInLibraryViaSendplusMiddleTier(cookie, upload_data.get("upload_id"), eTag);

        }
    }


    public String getStorageSubType(){
        String storageSubType = null;
        Agency agencyName = getCurrentAgency();
        String storageId = agencyName.getStorageId();
        List<FileStorage> storages  = service.getGdnStorages().getResult();
        for (FileStorage storage : storages) {
            if (storage.getFileStorageId().equals(storageId)) {
                storageSubType= storage.getFileStorageSubType();

            }
        }
        return storageSubType;
    }

    // emulate JumpLoader ( Adgate support both: JumpLoader and PlupLoader)
    public HashMap<String, String> prepareFileToUploadToGDN(GDNFileWrapper fileWrapper, String postURI, UploadListener uploadListener) {

        File file = fileWrapper.getFile();
        if (!file.exists())
            throw new IllegalArgumentException(String.format("File %s does not exist", file.toString()));

        checkLoggedIn();
        HashMap<String, String> result = new HashMap<>();

        long fileLength = file.length();
        String fileName = file.getName();
        String fileExtension = fileName.contains(".") ? fileName.substring(fileName.lastIndexOf(".")) : "";
        String targetFileName = fileWrapper.getExternalId() + fileExtension;
        String lastModified = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSSZ").format(new Date(file.lastModified()));
        CloseableHttpClient client = HttpClients.createDefault();
        final int chunkLength = 10485760;
        int bytesToSend;
        int chunksCount = (int) (fileLength / chunkLength) + 1;
        int fileId = Gen.getInt(10000000, 99999999);
        long totalTime = 0;
        for (int i = 0; i < chunksCount; i++) {
            int bytesUploaded = i * chunkLength;
            bytesToSend = i < chunksCount - 1 ? chunkLength : (int) (fileLength - bytesUploaded);
            byte[] bytes = IO.readFile(file, bytesUploaded, bytesToSend);
            HttpPost request = new HttpPost(postURI);
            MultipartEntityBuilder entityBuilder = MultipartEntityBuilder.create();
            entityBuilder.addTextBody("partitionIndex", "" + i);
            entityBuilder.addTextBody("targetFileName", targetFileName);
            entityBuilder.addTextBody("fileId", "" + fileId);
            entityBuilder.addTextBody("partitionLength", "" + chunkLength);
            entityBuilder.addTextBody("lastModified", lastModified);
            entityBuilder.addTextBody("fileLength", "" + fileLength);
            entityBuilder.addTextBody("fileName", fileName);
            entityBuilder.addTextBody("partitionCount", "" + chunksCount);
            entityBuilder.addBinaryBody("file", bytes, ContentType.APPLICATION_OCTET_STREAM, fileName);
            request.setHeader("Authorization", "Basic YWxleEB1bml0LnR2LnVhOjE=");
            request.setEntity(entityBuilder.build());
            try {
                long start = System.currentTimeMillis();
                HttpResponse response = client.execute(request);
                if (response.getStatusLine().getStatusCode() != 200) {
                    System.out.println("File upload request: " + request.getURI());
                    System.out.println("File upload response: " + response.getStatusLine().getStatusCode());
                    System.out.println(EntityUtils.toString(response.getEntity()));
                    throw new IllegalStateException("File not uploaded");
                } else {
                    long time = System.currentTimeMillis() - start;
                    EntityUtils.consume(response.getEntity());
                    totalTime += time;
                    if (uploadListener != null)
                        uploadListener.chunkUploadComplete(bytesUploaded + bytesToSend, fileLength, bytesToSend, time, totalTime, targetFileName);
                }
            } catch (IOException e) {
                throw new IllegalStateException("File not uploaded", e);
            }
        }
        result.put("targetFileName", targetFileName);
        uploadedFilesCount.incrementAndGet();
        return result;
    }

    public HashMap<String, String> prepareFileToUploadToS3GDN(GDNFileWrapper fileWrapper, String postURI, UploadListener uploadListener) {

        File file = fileWrapper.getFile();

        File filepath = new File(String.valueOf(file));
        if (!file.exists())
            throw new IllegalArgumentException(String.format("File %s does not exist", file.toString()));

        checkLoggedIn();
        HashMap<String, String> result = new HashMap<>();
        String fileName = file.getName();
        String fileExtension = fileName.contains(".") ? fileName.substring(fileName.lastIndexOf(".")) : "";
        String targetFileName = fileWrapper.getExternalId() + fileExtension;
        CloseableHttpClient client = HttpClients.createDefault();
        HttpPut request = new HttpPut(postURI);
        FileEntity reqEntity = new FileEntity(filepath, "binary/octet-stream");
        request.setEntity(reqEntity);
        reqEntity.setContentType("binary/octet-stream");
        String eTag = null;
        try {
            HttpResponse response = client.execute(request);
            Header[] headers = response.getAllHeaders();
            for (Header header : headers) {
                if(header.getName().equalsIgnoreCase("ETag")) {
                    String etagvalue = header.getValue();
                    eTag = etagvalue.substring(1,etagvalue.length()-1);
                    break;
                }
            }
            if (response.getStatusLine().getStatusCode() != 200) {
                System.out.println("File upload request: " + request.getURI());
                System.out.println("File upload response: " + response.getStatusLine().getStatusCode());
                System.out.println(EntityUtils.toString(response.getEntity()));
                throw new IllegalStateException("File not uploaded");}
        } catch (IOException e){
            throw new IllegalStateException("File not uploaded", e);
        }
        result.put("eTag",eTag);
        result.put("targetFileName", targetFileName);
        uploadedFilesCount.incrementAndGet();
        return result;
    }

    public SearchResult<Role> findRoles(LuceneSearchingParams query) {
        checkLoggedIn();
        return service.findRoles(query);
    }

    public boolean isDefaultRole(String roleName) {
        return getDefaultRolesMap(false).containsKey(roleName);
    }

    public Role getRoleByName(String roleName, boolean isRealDb) {
        return getRoleByName(roleName, 10000, isRealDb);
    }

    public Role getRoleByName(String roleName, long timeout, boolean isRealDB) {
        if (getDefaultRolesMap(isRealDB).get(roleName) != null) {
            return service.getRole(getDefaultRolesMap(isRealDB).get(roleName));
        }
        LuceneSearchingParams query = new LuceneSearchingParams();
        query.setQuery(String.format("_cm.common.name:\"%s\"", roleName));
        long start = System.currentTimeMillis();
        do {
            SearchResult<Role> result = findRoles(query);
            if (result.getResult().size() > 0)
                return result.getResult().get(0);
            if (timeout > 0)
                Common.sleep(1000);
        } while (System.currentTimeMillis() - start < timeout);
        return null;
    }

    public Role createRole(String roleName, String roleGroup, String agencyId) {
        return createRole(roleName, roleGroup, new String[0], agencyId);
    }

    public Role createRole(String roleName, String roleGroup, String[] allow, String agencyId) {
        checkLoggedIn();
        Role role = new Role();
        role.setName(roleName);
        role.setAllow(allow);
        role.setGroup(roleGroup);
        return service.createRole(agencyId, role);
    }

    public Role updateRole(String roleName, String roleId, String agencyId, String[] allow) {
        checkLoggedIn();
        Role role = new Role();
        role.setName(roleName);
        role.setId(roleId);
        role.setAllow(allow);

        Agency agency = new Agency();
        agency.setId(agencyId);

        role.setAgency(agency);
        return service.updateRole(role);
    }

    public AgencyProjectTeam createAgencyTeam(AgencyProjectTeam agencyProjectTeam) {
        checkLoggedIn();
        return service.createAgencyTeam(agencyProjectTeam);
    }

    public void addObjectToAgencyProjectTeam(String agencyTeamId, String objectId) {
        checkLoggedIn();
        service.addObjectToAgencyProjectTeam(agencyTeamId, objectId);
    }

    public AgencyProjectTeam getAgencyProjectTeamByName(String teamName) {
        checkLoggedIn();
        return getAgencyProjectTeamByName(teamName, 10000);
    }

    public AgencyProjectTeam getAgencyProjectTeamByName(String teamName, long timeout) {
        checkLoggedIn();
        long start = System.currentTimeMillis();
        do {
            LuceneSearchingParams query = new LuceneSearchingParams();
            query.setQuery("name=" + teamName);
            SearchResult<AgencyProjectTeam> agencyProjectTeams = service.findAgencyProjectTeams(query);

            for (AgencyProjectTeam agencyProjectTeam : agencyProjectTeams.getResult())
                if (agencyProjectTeam.getName().equals(teamName))
                    return agencyProjectTeam;

            if (timeout > 0) {
                Common.sleep(1000);
            }
        } while (System.currentTimeMillis() - start < timeout);
        return null;
    }

    public List<FileStorage> getFileStorages() {
        SearchResult<FileStorage> result = service.getGdnStorages();
        if (result == null)
            throw new IllegalStateException("Fortress isn't respond. Could not retrieve storages list.");
        return result.getResult();
    }

    public FileStorage getRandomFileStorage() {
        List<FileStorage> storages = getFileStorages();
        return storages.get(Gen.getInt(storages.size()));
    }

    public FileStorage getFileStorageById(String storageId) {
        List<FileStorage> storages = getFileStorages();
        for (FileStorage storage : storages) {
            if (storage.getFileStorageId().equals(storageId)) return storage;
        }
        return null;
    }

    public FileStorage getCurrentAgencyStorage() {
        return service.getGdnStorageForAgency(getCurrentAgency().getId());
    }

    public GlobalSearchResult globalSearch(LuceneSearchingParams query) {
        checkLoggedIn();
        return service.globalSearch(query);
    }

    public boolean isLoggedIn() {
        return loggedIn;
    }

    public String getLoggedUserEmail() {
        return loggedUserEmail;
    }

    public Dictionary getDictionary(DictionaryType type) {
        checkLoggedIn();
        return service.getDictionary(type);
    }

    public Dictionary getAgencyDictionaryByName(String agencyId, String dictionaryName) {
        checkLoggedIn();
        return service.getAgencyDictionaryByName(agencyId, dictionaryName);
    }

    public void createAgencyDictionary(String agencyId, String dictionaryName, List<CustomMetadata> values) {
        checkLoggedIn();
        service.createAgencyDictionary(agencyId, dictionaryName, values);
    }

    public void updateAgencyDictionaryValues(String agencyId, String dictionaryName, List<CustomMetadata> values) {
        checkLoggedIn();
        service.updateAgencyDictionaryValues(agencyId, dictionaryName, values);
    }

    public void updateAgencyDictionary(String agencyId, String dictionaryName, DictionaryValues values) {
        checkLoggedIn();
        service.updateAgencyDictionary(agencyId, dictionaryName, values);
    }

    public void checkLoggedIn() {
        if (!isLoggedIn()) {
            throw new IllegalStateException("Log in before using other methods.");
        }
    }

    public Contact addIntoAddressBook(String email) {
        checkLoggedIn();
        return service.addContact(email);
    }



    public void addNotificationSetting(String userId,String notificationSetting,String settingState) {
        checkLoggedIn();
        service.addNotificationSetting(userId,notificationSetting,settingState);
    }

    public User inviteUser(String email) {
        checkLoggedIn();
        return service.inviteUser(email);
    }

    public void addExistingUserToAgency(String userId, String agencyId, String roleId) {
        checkLoggedIn();
        service.addExistingUserToAgency(userId, agencyId, roleId);
    }

    public Contact addUserToTeamTemplate(String email, String... groupName) {
        checkLoggedIn();
        Contact contact = getContactByEmail(email);
        if (contact == null) {
            throw new IllegalArgumentException("Could not find contact " + email);
        }
        Set<String> groups = new HashSet<>();
        groups.addAll(Arrays.asList(groupName));
        if (contact.getGroups() != null) {
            groups.addAll(contact.getGroups());
        }
        return service.addContactToGroup(email, groups.toArray(new String[groups.size()]));
    }

    public Contact getContactByEmail(String email) {
        return service.getContact(email);
    }

    public boolean isContactExistByEmail(String email) {
        Contact contact = getContactByEmail(email);
        if (contact!=null){
            return contact.getEmail().equals(email);
        }else{
            return getContactByEmail(email) != null;
        }
    }

    public void deleteContact(String contactId) {
        checkLoggedIn();
        service.deleteContact(contactId);
    }

    public SearchResult<Activity> findActivities(ActivityType type, ActivityQuery query) {
        checkLoggedIn();
        return paperPusherService.findActivities(type, query, null);
    }

    public Activity getLastActivity(ActivityType type, ActivityQuery query) {
        List<Activity> activities = findActivities(type, query).getResult();
        if (activities.size() > 0)
            return activities.get(activities.size() - 1);
        return null;
    }

    public int getNotificationsCount(boolean isHasReadNotifications) {
        checkLoggedIn();
        return service.getNotificationsCount(isHasReadNotifications);
    }

    public SearchResult<Notification> getNotifications(boolean isHasReadNotifications, LuceneSearchingParams query) {
        checkLoggedIn();
        return service.findNotifications(isHasReadNotifications, query);
    }

    public SearchResult<Comment> findComments(String fileId, int objRevision) {
        checkLoggedIn();
        return service.findComments(fileId, objRevision);
    }

    public SearchResult<Reel> findReels(LuceneSearchingParams query) {
        checkLoggedIn();
        return service.findReels(query);
    }

    public List<Reel> getAgencyReels(String agencyId, String sortingField, String sortingOrder) {
        return getAgencyReels(agencyId, sortingField, sortingOrder, 10000);
    }

    public List<Reel> getAgencyReels(String agencyId, String sortingField, String sortingOrder, long timeout) {
        LuceneSearchingParams query = new LuceneSearchingParams();
        query.setQuery(String.format("agency._id:\"%s\"", agencyId));
        query.setSortingField(sortingField);
        query.setSortingOrder(sortingOrder);

        return getReels(query, timeout);
    }

    public Reel getReelByName(String name) {
        return getReelByName(name, 10000);
    }

    public String getPresentationPublicToken(String presentationId) {
        return service.createPublicShare("presentation", presentationId, null, null, null).getToken();
    }

    public void sharePresentationToUsers(String presentationId, List<String> userIds, String personalMessage) {
        service.sharePresentationToUsers(presentationId, userIds, personalMessage);
    }

    public Reel getReelByName(String name, long timeout) {
        LuceneSearchingParams query = new LuceneSearchingParams();
        query.setQuery(String.format("_cm.common.name:\"%s\"", name));

        List<Reel> reels = getReels(query, timeout);
        // reel from search result doesn't contain assets
        return (reels == null || reels.size() == 0) ? null : getReel(reels.get(0).getId());
    }

    public List<Reel> getReels(LuceneSearchingParams query, long timeout) {
        long start = System.currentTimeMillis();
        do {
            SearchResult<Reel> result = findReels(query);
            if (result.getResult().size() > 0)
                return result.getResult();
            if (timeout > 0)
                Common.sleep(1000);
        } while (System.currentTimeMillis() - start < timeout);
        return null;
    }

    public String getFirstCommentIdByText(String fileId, int objRevision, String commentText) {
        SearchResult<Comment> resultComment = findComments(fileId, objRevision);
        for (Comment comment : resultComment.getResult()) {
            if (comment.getText().equals(commentText)) return comment.getId();
        }
        return null;
    }

    public List<String> getAllCommentsIdByText(String fileId, int revisionNum, String commentText) {
        List<String> result = new ArrayList<>();
        SearchResult<Comment> resultComment = findComments(fileId, revisionNum);
        for (Comment comment : resultComment.getResult()) {
            if (comment.getText().equals(commentText)) result.add(comment.getId());
        }
        return result;
    }

    public Reel createReel(Reel reel) {
        checkLoggedIn();
        return service.createReel(reel);
    }

    public Reel getReel(String reelId) {
        checkLoggedIn();
        return service.getReel(reelId, true);
    }

    public void addUsageRights(String objectId, List<UsageRight> listUR) {
        checkLoggedIn();
        service.addUsageRights(objectId, listUR);
    }

    public BaseUsageRight getUsageRight(String assetId) {
        checkLoggedIn();
        return service.getUsageRight(assetId);
    }

    public String getDownloadUrl(String fileId, String a4FileId, String saveAsFileName) {
        checkLoggedIn();
        return service.getDownloadUrl(fileId, a4FileId, saveAsFileName);
    }

    private Map<String, String> getDefaultRolesMap(boolean isRealDB) {
        Map<String, String> globalRoles = new HashMap<>();

        globalRoles.put("global.administrators", "4ef31ce1766ec96769b399c1");
        globalRoles.put("agency.admin", "4f6acc74dff0676e018e6dcc");
        globalRoles.put("agency.user", "4f6acc74dff0676e018e6dcf");
        globalRoles.put("guest.user", "4fba0ec37fec91f70b5a0917");
        globalRoles.put("project.admin", "4f719aed0f915e82984dc84e");
        globalRoles.put("Project.Admin", "4f719aed0f915e82984dc84e");
        globalRoles.put("project.user", "506f0ff7e4b088f04d9d794a");
        globalRoles.put("Project User", "506f0ff7e4b088f04d9d794a");
        globalRoles.put("Project.User", "506f0ff7e4b088f04d9d794a");
        globalRoles.put("Project..User", "506f0ff7e4b088f04d9d794a");
        globalRoles.put("project.observer", "509a93c29e02c7ba9d977f28");
        globalRoles.put("Project Observer", "509a93c29e02c7ba9d977f28");
        globalRoles.put("Project.Observer", "509a93c29e02c7ba9d977f28");
        globalRoles.put("project.contributor", "509a93c29e02c7ba9d977f25");
        globalRoles.put("Project Contributor", "509a93c29e02c7ba9d977f25");
        globalRoles.put("Project.Contributor", "509a93c29e02c7ba9d977f25");
        globalRoles.put("approver", "5059aa1ffbc55596d01a3da4");
        globalRoles.put("library.admin", "512cef304caf8dda81c0fc8d");
        globalRoles.put("library.user", "512cef324caf8dda81c0fc8f");
        globalRoles.put("Library User", "512cef324caf8dda81c0fc8f");
        globalRoles.put("agency.list", "4f62d03c454adbaef94258cf");
        globalRoles.put("agency.enums.read", "4f71ac9a0f915e82984dc8de");
        globalRoles.put("agency.enums.write", "4f71ac9b0f915e82984dc8e4");
        globalRoles.put("agency.default.roles", "4f7045390f915e82984dc716");
        globalRoles.put("agency.reel.create.role", "50254292fbc5101ae5785db1");
        globalRoles.put("agency.asset.share.role", "50254292fbc5101ae5785db2");
        globalRoles.put("agency.reel.read.role", "50253ce2fbc58f931c54d2d3");
        globalRoles.put("agency.category.read_write.role", "501638c2db016b1bf9952aba");
        globalRoles.put("agency.category.read.role", "50056001db016b1bf995257e");
        globalRoles.put("agency.project.read.role", "505c9504e4b04e7fe746c6ed");
        globalRoles.put("WB.Project.User", "56d4f73fe4b06c27fa0d85d2");
        globalRoles.put("WB Project User", "56d4f73fe4b06c27fa0d85d2");
        if(TestsContext.getInstance().isRealDb){
            globalRoles.put("traffic.traffic.manager","54c3469a5c07431ca711e09e");
            globalRoles.put("broadcast.traffic.manager","54c3469a5c07431ca711e09b");
        }else{
            globalRoles.put("traffic.traffic.manager","54f70addb910957144802b36");
            globalRoles.put("broadcast.traffic.manager","54f70addb910957144802b34");
            globalRoles.put("broadcast.traffic.admin","54f70addb910957144802b33");
            globalRoles.put("broadcast.traffic.user","54f70addb910957144802b35");
        }
        globalRoles.put("easyshare.view", "52303a47fb49916fdf3aac51");
        globalRoles.put("easyshare.downloadMaster", "52303a47fb49916fdf3aac52");
        globalRoles.put("easyshare.downloadProxy", "52303a47fb49916fdf3aac53");

        return globalRoles;
    }

    public SchemasMap getSchemasMap(String agencyIdOne, String agencyIdTwo) {
        return service.findSchemasMap("asset", agencyIdOne, "asset", agencyIdTwo);
    }

    public int getInboxCacheStatus() {
        return service.getInboxCacheStatus();
    }

    public Integer createInboxCache() {
        return service.createInboxCache();
    }

    public Boolean createInboxCache(String collectionId) {
        return service.createInboxCache(collectionId);
    }

    public List<InboxCategory> getInboxCategories(String agencyId) {
        checkLoggedIn();
        return service.getInboxCategories(agencyId).getResult();
    }

    public InboxCategory getInboxCategoryByName(String agencyId, String categoryName) {
        for (InboxCategory category : getInboxCategories(agencyId)) {
            if (category.getCategoryName().equals(categoryName)) {
                return category;
            }
        }
        return null;
    }

    public SearchResult<Content> findAssetsInSharedCollection(String collectionId, LuceneSearchingParams query) {
        return service.findAssetsInSharedCollection(collectionId, query);
    }

    public Approval getApproval(Content file) {
        checkLoggedIn();
        return monoService.getApproval(file.getId(), file.getLastRevision().getMaster().getFileID());
    }

    public void createApprovalStage(Content file, ApprovalStage stage) {
        checkLoggedIn();
        monoService.createApprovalStage(file.getId(), file.getLastRevision().getMaster().getFileID(), stage);
    }

    // Migration A4 -> A5
    public String executeMigrationA4toA5(MigrationA4toA5 migrationA4toA5) {
        return service.executeMigrationA4toA5(migrationA4toA5);
    }

    /*
        ORDERING
    */

    private final long sleepTimeout = 5000;    // 5 sec

    // if market is not specified, got by default first market from markets list
    // orderType: tv_order, tv_order_music, tv_order_print
    public Order createOrder(String orderType) {
        checkLoggedIn();
        Order order = new Order();
        order.setSubtype(orderType);
        return service.createOrder(order);
    }

    // orderType: tv_order, tv_order_music, tv_order_print
    public Order createOrder(String market, String orderType) {
        checkLoggedIn();
        Order order = new Order();
        order.setSubtype(orderType);
        order.setTVMarketId(new String[]{getMarketKey(market)});
        return service.createOrder(order);
    }

    // orderType: tv_order, tv_order_music, tv_order_print
    //when we pass marketid beforehand the orderiod geenarterd are from Db counters(100000001) and not in sync with UI order id's(5030xxxx)
    //So creating orders initially with default destination ie.. marketid = 1 and then updating it to expeected marketid is the workaorund
    public Order createOrdernew(String market, String orderType) {
        checkLoggedIn();
        Order order = new Order();
        order.setSubtype(orderType);
        //order.setTVMarketId(new String[]{getMarketKey(market)});
        Order Temporder =  service.createOrder(order);
        Temporder.setTVMarketId(new String[]{getMarketKey(market)});
        return service.updateOrder(Temporder);
    }

    public Order updateOrder(Order order) {
        checkLoggedIn();
        return service.updateOrder(order);
    }

    public Order getOrder(String orderId, boolean withOrderItems) {
        checkLoggedIn();
        return service.getOrderById(orderId, withOrderItems);
    }

    public Integer getOrderFromTraffic(String orderId) throws IOException {
        checkLoggedIn();
        return service.getOrderFromTrafficById(orderId);
    }

    public Integer getOrderFromTraffic(String orderId,String qcAssetId) throws IOException {
        checkLoggedIn();
        return service.getOrderFromTrafficById(orderId, qcAssetId);
    }

    public String getOrderItemStatusFromTraffic(String orderId, String qcAssetId) throws IOException {
        checkLoggedIn();
        return service.getOrderItemStatusFromTraffic(orderId, qcAssetId);
    }

    public String getOrderStatusFromTraffic(String orderId, String qcAssetId) throws IOException {
        checkLoggedIn();
        return service.getOrderStatusFromTraffic(orderId, qcAssetId);
    }

    public Order completeOrder(Order order, QcView qcView) {
        checkLoggedIn();
        return service.completeOrder(order, qcView);
    }

    // used for resend to complete failed orders
    public Order forceCompleteOrder(Order order) {
        checkLoggedIn();
        return service.forceCompleteOrder(order);
    }

    public void moveOrderToBU(String orderId, String agencyId) {
        checkLoggedIn();
        service.moveOrderToBU(orderId, agencyId);
    }

    public SearchResult<Order> findOrders(LuceneSearchingParams query) {
        checkLoggedIn();
        return service.findOrders(query);
    }

    public List<Order> getOrders(LuceneSearchingParams query, long timeout) {
        long start = System.currentTimeMillis();
        do {
            SearchResult<Order> result = findOrders(query);
            if (result.getResult().size() > 0)
                return result.getResult();
            if (timeout > 0)
                Common.sleep(1000);
        } while (System.currentTimeMillis() - start < timeout);
        return null;
    }

    // orderStatus: ["in_progress", "completing", "failed"], ["draft"], ["waiting_for_approval"], ["completed"]
    public List<Order> getOrdersFromOrdersNotReplicatedToA4Queue(long timeout) {
        long start = System.currentTimeMillis();
        do {
            SearchResult<Order> result = findOrders(getLuceneSearchingTermsQueryForOrderingAdminQueue("status","failed"));
            if (result.getResult().size() > 0)
                return result.getResult();
            if (timeout > 0)
                Common.sleep(1000);
        } while (System.currentTimeMillis() - start < timeout);
        return null;
    }

    public List<OrderCompletionQueue> getOrdersInOrderCompletionQueue(long timeout){
        long start = System.currentTimeMillis();
        do {
            SearchResult<OrderCompletionQueue> result = getOrdersFromOrderCompletionQueue();
            if (result.getResult().size() > 0)
                return result.getResult();
            if (timeout > 0)
                Common.sleep(1000);
        } while (System.currentTimeMillis() - start < timeout);
        return null;
    }

    public SearchResult<OrderCompletionQueue> getOrdersFromOrderCompletionQueue() {
        checkLoggedIn();
        return service.getOrdersFromOrderCompletionQueue();
    }


    public List<String> getOrdersFromOrderCompletionQueue_id() {
        checkLoggedIn();
        return service.getOrdersFromOrderCompletionQueue_id();
    }

    public void deleteOrdersFromOrdersNotReplicatedToA4Queue(List<String> orderIds){
        checkLoggedIn();
        service.deleteOrdersFromOrdersNotReplicatedToA4Queue(orderIds);
    }

    public void deleteOrdersFromCompletionQueue(String id){
        checkLoggedIn();
        service.deleteOrdersFromCompletionQueue(id);
    }

    public Order getLastCreatedOrder(String orderStatus) {
        List<Order> orders = getOrders(getLuceneSearchingTermsQuery("status", prepareTermsValue(orderStatus)), sleepTimeout);
        return getFirstObject(orders);
    }

    public Order getOrderByMarket(String market) {
        List<Order> orders = getOrders(getLuceneSearchingTermsQuery("market", prepareTermsValue(market)), sleepTimeout);
        return getFirstObject(orders);
    }

    public Order getOrderByOrderReference(String orderReference) {
        List<Order> orders = getOrders(getLuceneSearchingTermsQuery("orderReference", prepareTermsValue(orderReference)), sleepTimeout);
        return getFirstObject(orders);
    }

    public Order getOrderByMarketAndItemClockNumber(String market, String clockNumber) {
        List<Order> orders = getOrders(getLuceneSearchingNestedQuery("clockNumber", clockNumber), sleepTimeout);
        for (Order order : orders)
            if (order.getTvMarket().equals(market))
                return order;
        return null;
    }

    public Order getOrderByItemClockNumber(String clockNumber) {
        List<Order> orders = getOrders(getLuceneSearchingNestedQuery("clockNumber", clockNumber), sleepTimeout);
        return getFirstObject(orders);
    }

    public Order getOrderByItemTitle(String title) {
        List<Order> orders = getOrders(getLuceneSearchingNestedQuery("title", title), sleepTimeout);
        return getFirstObject(orders);
    }

    // orderStatus: ["in_progress", "completing", "failed"], ["draft"], ["waiting_for_approval"], ["completed"]
    // orderType: tv_order, tv_order_music, tv_order_print
    public int getOrderCounters(String orderStatus, String orderType) {
        checkLoggedIn();
        SearchResult<OrderCounter> result = service.getOrderCounters(orderType);
        for (OrderCounter orderCounter : result.getResult()) {
            if (orderCounter.getStatus().equals(orderStatus))
                return orderCounter.getCount();
        }
        throw new IllegalArgumentException("Unknown order status:" + orderStatus);
    }

    public void deleteOrder(String orderId) {
        checkLoggedIn();
        service.deleteOrder(orderId);
    }

    public void deleteOrders(String[] ordersIds) {
        checkLoggedIn();
        service.deleteOrders(ordersIds);
    }

    public OrderItem createOrderItem(String orderId, String orderItemType, OrderItem orderItem) {
        checkLoggedIn();
        return service.createOrderItem(orderId, orderItemType, orderItem);
    }

    // orderItemType: tv_order_item, tv_order_item_music, tv_order_item_print
    public OrderItem updateOrderItem(String orderId, String orderItemId, String orderItemType, OrderItem orderItem) {
        checkLoggedIn();
        return service.updateOrderItem(orderId, orderItemId, orderItemType, orderItem);
    }

    // orderItemType: tv_order_item, tv_order_item_music, tv_order_item_print
    public List<OrderItem> findOrderItems(String orderItemType, LuceneSearchingParams query) {
        checkLoggedIn();
        SearchResult<OrderItem> result = service.findOrderItems(orderItemType, query);
        return result.getResult();
    }

    // orderItemType: tv_order_item, tv_order_item_music, tv_order_item_print
    // approvalValue: on_hold, approved
    public OrderItem holdForApprovalOrderItem(String orderId, String orderItemId, String orderItemType, String approvalValue) {
        checkLoggedIn();
        return service.holdForApprovalOrderItem(orderId, orderItemId, orderItemType, approvalValue);
    }

    // orderItemType: tv_order_item, tv_order_item_music, tv_order_item_print
    public void deleteOrderItemApprovalStatus(String orderId, String orderItemId, String orderItemType) {
        checkLoggedIn();
        service.deleteOrderItemApprovalStatus(orderId, orderItemId, orderItemType);
    }

    // orderItemType: tv_order_item, tv_order_item_music, tv_order_item_print
    public OrderItem addMediaToOrderItem(String orderId, String orderItemId, String elementId, String orderItemType) {
        checkLoggedIn();
        return service.addMediaToOrderItem(orderId, orderItemId, elementId, orderItemType);
    }

    // orderItemType: tv_order_item, tv_order_item_music, tv_order_item_print
    public List<OrderItem> createOrderItemsAssociatedWithMedia(String orderId, String orderItemType, String[] assetElementIds) {
        checkLoggedIn();
        return service.createOrderItemsAssociatedWithMedia(orderId, orderItemType, assetElementIds);
    }

    // orderItemType: tv_order_item, tv_order_item_music, tv_order_item_print
    public void removeMediaFromOrderItem(String orderId, String orderItemId, String elementId, String orderItemType) {
        checkLoggedIn();
        service.removeMediaFromOrderItem(orderId, orderItemId, elementId, orderItemType);
    }

    public OrderItem getOrderItemByClockNumber(String orderId, String clockNumber) {
        Order order = getOrder(orderId);
        for (OrderItem orderItem : order.getDeliverables().getOrderItems()) {
            if (orderItem.getClockNumber() == null) continue;
            if (orderItem.getClockNumber().equals(clockNumber))
                return orderItem;
        }
        return null;
    }

    public OrderItem getOrderItemByTitle(String orderId, String title) {
        Order order = getOrder(orderId);
        for (OrderItem orderItem : order.getDeliverables().getOrderItems())
            if (orderItem.getTitle().equals(title))
                return orderItem;
        return null;
    }

    public List<OrderItem> getOrderItemsByClockNumber(String orderId, String clockNumber) {
        Order order = getOrder(orderId);
        List<OrderItem> orderItems = new ArrayList<>();
        for (OrderItem orderItem : order.getDeliverables().getOrderItems()) {
            if (orderItem.getClockNumber() == null) continue;
            if (orderItem.getClockNumber().equals(clockNumber))
                orderItems.add(orderItem);
        }
        return orderItems;
    }

    public List<OrderItem> getOrderItemsByTitle(String orderId, String title) {
        Order order = getOrder(orderId);
        List<OrderItem> orderItems = new ArrayList<>();
        for (OrderItem orderItem : order.getDeliverables().getOrderItems()) {
            if (orderItem.getTitle() == null) continue;
            if (orderItem.getTitle().equals(title))
                orderItems.add(orderItem);
        }
        return orderItems;
    }

    // orderItemType: tv_order_item, tv_order_item_music, tv_order_item_print
    public void deleteOrderItem(String orderId, String orderItemId, String orderItemType) {
        checkLoggedIn();
        service.deleteOrderItem(orderId, orderItemId, orderItemType);
    }

    public void deleteOrderItems(String[] orderItemsIds) {
        checkLoggedIn();
        service.deleteOrderItems(orderItemsIds);
    }

    public SearchResult<Deliveries> findDeliveriesBySpecificClock(String clockNumber, LuceneSearchingParams query) {
        checkLoggedIn();
        return service.findDeliveries(clockNumber, query);
    }

    public List<Deliveries> getDeliveriesBySpecificClock(String clockNumber, LuceneSearchingParams query) {
        return findDeliveriesBySpecificClock(clockNumber, query).getResult();
    }

    // generate delivery report on a4 side
    public DeliveryReport getDeliveryReport(String orderId) {
        checkLoggedIn();
        return service.getDeliveryReport(orderId);
    }

    // get delivery report url on a5 side
    public String getDeliveryReportUrl(String orderId) {
        checkLoggedIn();
        return service.getDeliveryReportUrl(orderId);
    }

    public String getBeamConfirmationReportUrl(String orderId) {
        checkLoggedIn();
        return service.getBeamConfirmationReportUrl(orderId);
    }

    public String getDraftOrderReportUrl(String orderId) {
        checkLoggedIn();
        return service.getDraftOrderReportUrl(orderId);
    }

    public String getBillingOrderReportUrl(String orderId) {
        checkLoggedIn();
        return service.getBillingOrderReportUrl(orderId);
    }

    public String getDeliveryOrderReport(String orderId, String deliveryReportType, List<QcOrderItem> qcOrderItems) {
        checkLoggedIn();
        return service.getDeliveryOrderReport(orderId, deliveryReportType, qcOrderItems);
    }

    public String getOrderItemDeliveryStatusfromA4(String orderReference){
        return service.getDeliveryStatusFromA4(orderReference);
    }


    public String getOrderItemBroadcasterStatusfromTraffic(String orderReference,String qcAssetId) throws IOException {
        return service.getBroadcasterStatusFromTraffic(orderReference, qcAssetId);
    }

    public String getOrderItemBroadcasterStatusfromTrafficForDestination(String orderReference,String qcAssetId,String destination) throws IOException {
        return service.getBroadcasterStatusFromTrafficForDestination(orderReference, qcAssetId, destination);
    }

    public String getOrderItemA5ViewStatusfromTraffic(String orderReference,String qcAssetId) throws IOException {
        return service.getA5ViewStatusFromTraffic(orderReference, qcAssetId);
    }

    public String getDeliveryStatusfromTraffic(String orderReference, String destinationName) throws IOException {
        return service.getDeliveryStatusFromTraffic(orderReference, destinationName);
    }

    public String getDeliveryStatusfromTraffic(String orderReference,String qcAssetId, String destinationName) throws IOException {
        return service.getDeliveryStatusFromTraffic(orderReference,qcAssetId, destinationName);
    }

    public int getHttpStatusCodeWhileGetOrderReport(OrderReportType orderReportType, String orderId) {
        HttpGet get = new HttpGet(Common.urlDecode(getReportURL(orderReportType, orderId)));
        CloseableHttpClient client = HttpClients.createDefault();
        try {
            HttpResponse response = client.execute(get);
            return response.getStatusLine().getStatusCode();
        } catch (IOException e) {
            throw new IllegalStateException(orderReportType + " report is not opening at this moment!", e);
        }
    }

    public int getHttpStatusCodeWhileGenerateBilling(OrderReportType orderReportType, String orderId) {
        long start= System.currentTimeMillis();

        HttpGet get = new HttpGet(Common.urlDecode(getReportURL(orderReportType, orderId)));
        CloseableHttpClient client = HttpClients.createDefault();
        try {
            HttpResponse response = client.execute(get);
            return response.getStatusLine().getStatusCode();
        } catch (IOException e) {
            throw new IllegalStateException(orderReportType + " report is not opening at this moment!", e);
        }
    }


    public List<Market> getMarkets() {
        checkLoggedIn();
        return service.getTvMarkets().getValues();
    }

    public Market getMarketByName(String name) {
        for (Market market : getMarkets())
            if (market.getName().equals(name))
                return market;
        throw new IllegalArgumentException("There is no following market: " + name);
    }

    public String getMarketKey(String market) {
        return getMarketByName(market).getKey();
    }

    public List<Destination> getDestinationsByMarket(String market) {
        checkLoggedIn();
        return service.getDestinationsByMarket(getMarketKey(market), new LuceneSearchingParams()).getValues();
    }

    public List<Destination> getDestinationsByMarket(String market, String destinationName) {
        checkLoggedIn();
        return service.getDestinationsByMarket(getMarketKey(market), getLuceneSearchingDestinationsQuery(destinationName)).getValues();
    }

    public Destination getDestinationByName(List<Destination> destinations, String name) {
        for (Destination destination : destinations)
            if (destination.getName().equals(name))
                return destination;
        throw new NullPointerException("There is no following destination: " + name);
    }

    public Destination getDestinationByName(String market, String name) {
        for (Destination destination : getDestinationsByMarket(market, name))
            if (destination.getName().equals(name))
                return destination;
        throw new NullPointerException("There is no following destination: " + name + " for market: " + market);
    }

    public ServiceLevel getDestinationServiceLevelByName(Destination destination, String serviceLevelName) {
        if (destination == null) throw new NullPointerException("Destination is not exist!");
        for (ServiceLevel serviceLevel : destination.getServiceLevelValues())
            if (serviceLevel.getName().equals(serviceLevelName))
                return serviceLevel;
        throw new NullPointerException("There is no service level with name: " + serviceLevelName + " for destination: " + destination.getName());
    }

    public List<Destination> getDestinationsBySubGroupName(List<Destination> destinationsPerMarket, String subGroupName) {
        List<Destination> destinations = new ArrayList<>();
        for (Destination destination : destinationsPerMarket)
            if (destination.getSubGroup().equals(subGroupName))
                destinations.add(destination);
        return destinations;
    }

    public void addAdditionalDestinations(Map<UploadRequestType, List<AdditionalDestination>> additionalDestinations) {
        checkLoggedIn();
        service.addAdditionalDestinations(additionalDestinations);
    }

    public OrderItem uploadDocumentToOrderItem(File file, String orderId, String orderItemId, String orderItemType, OrderItem orderItem) {
        GDNFileWrapper gdnFileWrapper = new GDNFileWrapper(file);
        GDNFileRegister fileRegister = registerDocuments(gdnFileWrapper, orderItemId, "order");
        String attachedFileId = fileRegister.getFiles()[0].getAttachedFileId();
        String postURI = fileRegister.getFiles()[0].getFileUri();
        String gdnFileId = fileRegister.getFiles()[0].getFileId();
        String storageSubType = getStorageSubType();

        if (storageSubType.equalsIgnoreCase("s3")) {
            prepareFileToUploadToS3GDN(gdnFileWrapper, postURI, null);
        }else{
            prepareFileToUploadToGDN(gdnFileWrapper, postURI, null);
        }
        uploadDocumentsCompleteTest(attachedFileId,gdnFileId);
        Common.sleep(20000); //wait is added for the upload completion

        CustomMetadata doc = new CustomMetadata();
        doc.put("fileId", gdnFileId);
        doc.put("size", gdnFileWrapper.getSize());
        doc.put("fileName", gdnFileWrapper.getName());
        doc.put("uploaderName", getCurrentUser().getFullName());
        doc.put("uploadedTimestamp", new DateTime().getMillis());
        Document document = new Document(doc);

        orderItem.setUploadedFiles(new Document[]{document});
        return updateOrderItem(orderId, orderItemId, orderItemType, orderItem);
    }

    public QcView getQcView(String orderId) {
        checkLoggedIn();
        return service.getQcView(orderId);
    }

    public List<BeamTvClock> getBeamTvClocks(String date) {
        checkLoggedIn();
        return service.getBeamTvClocks(date);
    }

    public BeamTvClock getBeamTvClockByClockNumber(String clockNumber, String date) {
        for (BeamTvClock beamTvClock : getBeamTvClocks(date))
            if (beamTvClock.getClocknumber().equals(clockNumber))
                return beamTvClock;
        throw new NullPointerException("There is no any Beam TV Clock with following clock number: " + clockNumber + " for date filter begins from: " + date);
    }

    public void assignOrders(String[] ordersIds, String userEmail, String message) {
        checkLoggedIn();
        service.assignOrders(ordersIds, userEmail, message);
    }

    public List<Transfer> getAssigns(String orderId) {
        checkLoggedIn();
        return service.getAssigns(orderId);
    }

    public void enableBilling() {
        checkLoggedIn();
        service.enableBilling();
    }

    public void disableBilling() {
        checkLoggedIn();
        service.disableBilling();
    }

    public String getBillingStatus() {
        checkLoggedIn();
        return service.getBillingStatus();
    }

    public Bookmark createBookmark(String name, String market, boolean isShared) {
        checkLoggedIn();
        return service.createBookmark(name, Integer.valueOf(getMarketKey(market)), isShared);
    }

    public Bookmark updateBookmark(Bookmark bookmark) {
        checkLoggedIn();
        return service.updateBookmark(bookmark);
    }

    public Bookmark getBookmarkById(String bookmarkId) {
        checkLoggedIn();
        return service.getBookmarkById(bookmarkId);
    }

    public List<Bookmark> getBookmarks() {
        checkLoggedIn();
        return service.findBookmarks().getResult();
    }

    public Bookmark getBookmarkByName(String name) {
        for (Bookmark bookmark : getBookmarks())
            if (bookmark.getName().equals(name))
                return bookmark;
        throw new NullPointerException("There is no bookmark with following name: " + name);
    }

    public List<Bookmark> getBookmarksByMarket(String market) {
        int marketId = Integer.valueOf(getMarketKey(market));
        List<Bookmark> bookmarks = new ArrayList<>();
        for (Bookmark bookmark : getBookmarks())
            if (bookmark.getMarketId() == marketId)
                bookmarks.add(bookmark);
        return bookmarks;
    }

    public void deleteBookmark(String bookmarkId) {
        checkLoggedIn();
        service.deleteBookmark(bookmarkId);
    }

    public void authenticationToARPPSystem(String userName, String password) {
        checkLoggedIn();
        service.authenticateToARPP(userName, password);
        service.findFieldsFromARPP("", userName, password);
        //service.updateUserSessionByARPPUserCredentials(Base64.encodeBase64String(userName.getBytes()), Base64.encodeBase64String(password.getBytes()));
    }

    private Order getOrder(String orderId) {
        Order order = getOrder(orderId, true);
        if (order == null)
            throw new IllegalArgumentException("There is no order with following id: " + orderId);
        return order;
    }

    private GDNFileRegister registerDocuments(GDNFileWrapper gdnFileWrapper, String referenceId, String reference){
        checkLoggedIn();
        return service.registerDocuments(Arrays.asList(gdnFileWrapper), referenceId, reference);
    }

    private void uploadDocumentsComplete(String gdnFileId) {
        checkLoggedIn();
        service.uploadDocumentsComplete(gdnFileId);
    }


    private void uploadDocumentsCompleteTest(String attachedFileId, String gdnFileId) {
        checkLoggedIn();
        service.uploadDocumentsCompleteTest(attachedFileId, gdnFileId);
    }


    private LuceneSearchingParams getLuceneSearchingDestinationsQuery(String filter) {
        return new LuceneSearchingParams()
                .setSortingField("name")
                .setSortingOrder("asc")
                .setPageNumber(1)
                .setResultsOnPage(1000)
                .setQuery("{\"or\":[{\"prefix\":{\"name\":\"" + filter + "\"}},{\"prefix\":{\"subGroup\":\"" + filter + "\"}}]}");
    }

    public LuceneSearchingParams getLuceneSearchingTermsQueryForOrderingAdminQueue(String field, String value) {
        return new LuceneSearchingParams()
                .setPageNumber(1)
                .setResultsOnPage(100000)
                .setSortingField("submitted")
                .setSortingOrder("asc")
                .setQuery("{\"terms\":{\"" + field + "\":[\"" + value + "\"]}}");
    }

    private LuceneSearchingParams getLuceneSearchingTermsQuery(String field, String value) {
        return new LuceneSearchingParams()
                .setResultsOnPage(10)
                .setSortingField("_created")
                .setSortingOrder("desc")
                .setQuery("{\"terms\":{\"" + field + "\":" + value + "}}");
    }

    private LuceneSearchingParams getLuceneSearchingNestedQuery(String field, String value) {
        return new LuceneSearchingParams()
                .setResultsOnPage(10)
                .setSortingField("_created")
                .setSortingOrder("desc")
                .setQuery("{\"nested\":{\"deliverables.items\":{\"prefix\":{\"deliverables.items._cm.common." + field + "\":\"" + value + "\"}}}}");
    }

    private String prepareTermsValue(String value) {
        StringBuilder sb = new StringBuilder("[");
        String[] values = value.split(",");
        for (int i = 0; i < values.length; i++) {
            sb.append("\"").append(values[i]).append("\"");
            if (i != values.length - 1) sb.append(",");
            if (i == values.length - 1) sb.append("]");
        }
        return sb.toString();
    }

    private String getReportURL(OrderReportType orderReportType, String orderId) {
        switch (orderReportType) {
            case DELIVERY: return getDeliveryReportUrl(orderId);
            case CONFIRMATION: return getBeamConfirmationReportUrl(orderId);
            case DRAFT: return getDraftOrderReportUrl(orderId);
            case BILLING: return getBillingOrderReportUrl(orderId);
            default: throw new IllegalArgumentException("Unknown order report type: " + orderReportType);
        }
    }

    private <T extends BaseObject> T getFirstObject(List<T> objects) {
        if (objects == null || objects.size() == 0)
            return null;
        return objects.get(0);
    }

    public String getMasterReceivedDateTraffic(String orderId, String qcAssetId) throws IOException {
        checkLoggedIn();
        return service.getMasterReceivedDateTraffic(orderId, qcAssetId);
    }


    public List<Order> getOrderByItemList(String clockNumber) {
        List<Order> orders = getOrders(getLuceneSearchingNestedQuery("clockNumber", clockNumber), sleepTimeout);
        return orders;
    }
    public GDNFileRegister registerGDNFile(String agencyId,GDNFileWrapper file) {
        checkLoggedIn();
        return service.registerGDNFiles(agencyId, file);
    }

    public void uploadAttachedFile_Watermarking(File file,String agencyId,String fileName) {
        GDNFileWrapper gdnFileWrapper = new GDNFileWrapper(file);
        GDNFileRegister fileRegister = registerGDNFile(agencyId,gdnFileWrapper);
        String postURI = fileRegister.getFiles()[0].getFileUri();
        String gdnFileId = fileRegister.getFiles()[0].getFileId();
        String storageSubType = getStorageSubType();

        if (storageSubType.equalsIgnoreCase("s3")) {
            prepareFileToUploadToS3GDN(gdnFileWrapper, postURI, null);
        }else{
            prepareFileToUploadToGDN(gdnFileWrapper, postURI, null);
        }
        uploadDocumentsCompleteTest_WaterMarking(agencyId,gdnFileId,fileName);
    }


    private void uploadDocumentsCompleteTest_WaterMarking(String agencyId, String gdnFileId,String fileName) {
        checkLoggedIn();
        service.uploadDocumentsCompleteTest_WaterMarking(agencyId, gdnFileId,fileName);
    }

    public IngestDoc getIngestId(String assetId) throws UnsupportedEncodingException {
        return service.getIngestId(assetId);
    }

    public String setIngestId(IngestDoc ingestdoc, String ingestID, long size, String fileId, String assetId){
        return service.setIngestId(ingestdoc,ingestID,size,fileId,assetId);
    }
    public IngestDoc setCommentA5(String orderRef, String userId) throws UnsupportedEncodingException{
        return service.setCommentA5(orderRef,userId);

    }

    public String setAssetStatus(String assetId, String userId, String status) throws UnsupportedEncodingException{
        return service.setAssetStatus(assetId,userId,status);
    }
    public String redeliverAssetbyExtId(String extId, String userId) throws UnsupportedEncodingException{
        return service.redeliverAssetbyExtId(extId,userId);
    }
    public String redeliverAssetbyDeliveryId(String deliveryId, String userId) throws UnsupportedEncodingException{
        return service.redeliverAssetbyDeliveryId(deliveryId,userId);
    }
    public String orderdeliverbyOrderId(String orderId, String userId) throws UnsupportedEncodingException{
        return service.orderdeliverbyOrderId(orderId,userId);
    }
    public String cancelDeliverybyDeliveryId(String deliveryId, String userId) throws UnsupportedEncodingException{
        return service.cancelDeliverybyDeliveryId(deliveryId,userId);
    }
    public String cancelDeliverybyExtId(String extId, String userId) throws UnsupportedEncodingException{
        return service.cancelDeliverybyExtId(extId, userId);
    }
    public List<GDNDeliveryDoc> getDeliveryDoc(String clockNumber, String userId) throws UnsupportedEncodingException{
        return service.getDeliveryDoc(clockNumber, userId);
    }
    public String setDuration(String assetId, String orderinguserId, String trafficuserId) throws UnsupportedEncodingException{
        return service.setDuration(assetId, orderinguserId, trafficuserId);
    }
    public String setMasterArrived(String orderId,String itemId, String orderinguserId, String trafficuserId, Map<String, String> row) throws UnsupportedEncodingException{
        return service.setMasterArrived(orderId,itemId,orderinguserId,trafficuserId,row);
    }
    public String removeMasterArrived(String orderId,String itemId, String orderinguserId, String trafficuserId) throws UnsupportedEncodingException{
        return service.removeMasterArrived(orderId, itemId, orderinguserId, trafficuserId);
    }
    public String retranscodeAsset(String assetId, String orderinguserId, String trafficuserId) throws UnsupportedEncodingException{
        return service.retranscodeAsset(assetId, orderinguserId, trafficuserId);
    }
    public String refreshDestinations() throws UnsupportedEncodingException{
        return service.refreshDestinations();
    }
    public String setHouseNumber(String userId,String deliveryId,String houseNumber) throws UnsupportedEncodingException{
        return service.setHouseNumber(userId, deliveryId, houseNumber);
    }
    public String deleteIngestRepo(String assetId){
        return service.deleteIngestRepo(assetId);
    }
    public String addIngestRepo(String assetId) {
        return service.addIngestRepo(assetId);
    }


    // Adcost
    public HttpResponse uploadSupportingDocumentsInAdCostRegisterUpload(SupportingDocsWrapper supportingDocsWrapper){
        checkLoggedIn();
        return service.uploadAdcostSupportingDocsRegisterUpload(Arrays.asList(supportingDocsWrapper));
    }

    public void uploadAdcostSupportingDocsCompleteUpload(SupportingDocsWrapper supportingDocsWrapper, String request){
        checkLoggedIn();
        service.uploadAdcostSupportingDocsCompleteUpload(Arrays.asList(supportingDocsWrapper),request);
    }

    public void uploadSupportingDocumentsInAdCost(SupportingDocsWrapper supportingDocsWrapper){
        checkLoggedIn();
        service.uploadAdcostSupportingDocs(Arrays.asList(supportingDocsWrapper));
    }

    public void uploadAdditionalSupportingDocumentsInAdCostCompleteUpload(SupportingDocsWrapper supportingDocsWrapper,String request){
        checkLoggedIn();
        service.uploadAdditionalSupportingDocumentsInAdCostCompleteUpload(Arrays.asList(supportingDocsWrapper),request);
    }

    public void uploadAdditionalSupportingDocumentsInAdCost(SupportingDocsWrapper supportingDocsWrapper){
        checkLoggedIn();
        service.uploadAdcostAdditionalSupportingDocs(Arrays.asList(supportingDocsWrapper));
    }

    public void uploadBudgetFormsInAdCost(BudgetFormsWrapper budgetFormsWrapper){
        checkLoggedIn();
        service.uploadBudgetForms(Arrays.asList(budgetFormsWrapper));
    }

    public String uploadBudgetFormInCostLineItem(BudgetFormsWrapper budgetFormsWrapper, boolean checkBadRequest){
        checkLoggedIn();
        return service.uploadBudgetFormInCostLineItem(Arrays.asList(budgetFormsWrapper), checkBadRequest);
    }

    public CostStage getCostStage(String costId){
        checkLoggedIn();
        return service.getCostStage(costId);
    }

    public CostStageRevision getCostStageRevision(String costId,String costStageId){
        checkLoggedIn();
        return service.getCostStageRevision(costId,costStageId);
    }

    public SupportingDocuments[] getSupportingDocuments(String costId, String costStageId, String costStageRevisionId){
        checkLoggedIn();
        return service.getSupportingDocuments(costId,costStageId,costStageRevisionId);
    }

    public HttpResponse downloadSupportingDocuments(String costId, String costStageId, String costStageRevisionId,String supportingDocumentId,String formName){
        checkLoggedIn();
        return service.downloadSupportingDocuments(costId,costStageId,costStageRevisionId,supportingDocumentId,formName);
    }

    public BudgetFormTemplates[] getBudgetFormsTemplates(){
        checkLoggedIn();
        return service.getBudgetFormTemplates();
    }

    public String downloadBudgetForms(String budgetFormtemplateId){
        checkLoggedIn();
        return service.downloadBudgetForms(budgetFormtemplateId);
    }

    public String downloadAssociatedAssets(String costId, String revisionId){
        checkLoggedIn();
        return service.downloadAssociatedAssets(costId,revisionId);
    }

    public String checkDownloadProjectTotals(String projectId){
        checkLoggedIn();
        return service.checkDownloadProjectTotals(projectId);
    }

    public String downloadExpectedAssets(String costId,  String stageId, String revisionId){
        checkLoggedIn();
        return service.downloadExpectedAssets(costId, stageId, revisionId);
    }

    public CostsCount getCosts(){
        checkLoggedIn();
        return service.getCosts(); }

    public CostTemplates[] getCostTemplates() {
        checkLoggedIn();
        return service.getCostTemplates();}

    public AdcostDictionaries[] getAdcostDictionaries(){
        checkLoggedIn();
        return service.getAdcostDictionaries();}

    public AdcostCurrency[] getAdcostCurrnecy(){
        checkLoggedIn();
        return service.getAdcostCurrnecy();}

    public Costs createCostDetails(CostDetails costDetails){
        checkLoggedIn();
        return service.createCostDetails(costDetails);}

    public ExchangeRates[] getExchangeRates(String costId){
        checkLoggedIn();
        return service.getExchangeRates(costId);}

    public AdcostDictionaries[] getTravellerRole(){
        checkLoggedIn();
        return service.getTravellerRole();}

    public AdcostDictionaries[] getShootCity(){
        checkLoggedIn();
        return service.getShootCity();}

    public TravelRegions[] getTravelRegions(){
        checkLoggedIn();
        return service.getTravelRegions();}

    public PerDiems[] getTravelPerDiems(){
        checkLoggedIn();
        return service.getTravelPerDiems();}

    public TravelCountry[] getTravelCountry(){
        checkLoggedIn();
        return service.getTravelCountry();}

    public TravelDetails createTravelCostDetails(TravelDetails travelDetails){
        checkLoggedIn();
        return service.createTravelCostDetails(travelDetails);}

    public void deleteTravelCostDetails(TravelDetails travelDetails){
        checkLoggedIn();
        service.deleteTravelCostDetails(travelDetails);}

    public TravelDetails[] getTravelCostDetails(TravelDetails travelDetails){
        checkLoggedIn();
        return service.getTravelCostDetails(travelDetails);}

    public AdcostDictionaries[] getDirectorName(){
        checkLoggedIn();
        return service.getDirectorName();}

    public AdcostDictionaries[] getPhotographerName(){
        checkLoggedIn();
        return service.getPhotographerName();}

    public SmoOrganisations[] getSmoOrganisations(String budgetRegionId){
        checkLoggedIn();
        return service.getSmoOrganisations(budgetRegionId);}

    public BudgetRegions[] getBudgetRegions(){
        checkLoggedIn();
        return service.getBudgetRegions();}

    public VendorsCount getVendors(String searchText){
        checkLoggedIn();
        return service.getVendors(searchText);}

    public Vendors[] getVendorListPerProductionCategory(String productionCategory){
        checkLoggedIn();
        return service.getVendorListPerProductionCategory(productionCategory);}

    public Vendors[] getVendorListforNonProductionCost(String productionCategory){
        checkLoggedIn();
        return service.getVendorListforNonProductionCost(productionCategory);}

    public Vendors createVendors(Vendors vendors){
        checkLoggedIn();
        return service.createVendors(vendors);
    }

    public void updateVendors(Vendors vendors){
        checkLoggedIn();
        service.updateVendors(vendors);
    }

    public void createProductionDetails(String costId, BaseProductionDetails details){
        checkLoggedIn();
        service.createProductionDetails(costId,details);}

    public AdcostDictionaries[] getInitiatives(){
        checkLoggedIn();
        return service.getInitiatives();}

    public AdcostDictionaries[] getAdcostDictionaryByName(String name) {
        checkLoggedIn();
        return service.getAdcostDictionaryByName(name); }

    public void createEntryInAdcostDictionary(com.adstream.automate.babylon.JsonObjects.adcost.ContentType request){
        checkLoggedIn();
        service.createEntryInAdcostDictionary(request);
    }

    public AdcostDictionaries[] getAdcostDictionaryByNameGDAMway(String name) {
        checkLoggedIn();
        return service.getAdcostDictionaryByNameGDAMway(name); }

    public void createEntryInAdcostDictionaryGDAMway(com.adstream.automate.babylon.JsonObjects.adcost.ContentType request){
        checkLoggedIn();
        service.createEntryInAdcostDictionaryGDAMway(request);
    }

    public AdId generateAdId(AdId adId){
        checkLoggedIn();
        return service.generateAdId(adId); }

    public void createExpectedAssets(ExpectedAssets assets){
        checkLoggedIn();
        service.createExpectedAssets(assets); }

    public void createCostLineItemData(CostLineItems lineItems){
        checkLoggedIn();
        service.createCostLineItemData(lineItems);}

    public void createIoNumber(String objectId, String name, Data data){
        checkLoggedIn();
        service.createIoNumber(objectId, name, data);}

    public CustomData getIoNumber(String objectId, String name){
        checkLoggedIn();
        return service.getIoNumber(objectId, name);}

    public CostLineItemDataResponse[] getCostLineItemDetails(String costId,String costStageId,String revisionId){
        checkLoggedIn();
        return service.getCostLineItemDetails(costId,costStageId,revisionId);};

    public Approvals[] getApproversListForCost(String costId, String costStageId, String revisionId){
        checkLoggedIn();
        return service.getApproversListForCost(costId,costStageId,revisionId);}

    public ApprovalMembers[] getApproverDetails(String id){
        checkLoggedIn();
        return service.getApproverDetails(id);}

    public void addApprovers(String costId, String costStageId, String revisionId, List<Approvals> approvals){
        checkLoggedIn();
        service.addApprovers(costId,costStageId,revisionId, approvals);}

    public void submitCostForApproval(String costId, String action, String comments){
        checkLoggedIn();
        service.submitCostForApproval(costId,action,comments);}

    public void createUsageBuyOutDetails(UpdateCostForm details, String costId){
        checkLoggedIn();
        service.createUsageBuyOutDetails(details,costId);}

    public void createNegotiatedTerms(UpdateCostForm details, String costId){
        checkLoggedIn();
        service.createNegotiatedTerms(details,costId);}

    public ProjectSearch[] getProjectNumber(String gdamProjectId){
        checkLoggedIn();
        return service.getProjectNumber(gdamProjectId);}

    public CostUser searchUserByAgencyID(String email)
    {return service.searchUserByAgencyID(email);};

    public String getUserRoleInCostModule(String email)
    {return service.getUserRoleInCostModule(email);};

    public UserRoles[] getBusinessRoles(){return service.getBusinessRoles();};

    public Agencies[] getAgencyIdInCostModule(){return service.getAgencyIdInCostModule();};

    public void grantUserAccessInCostModule(String userId,String businessRoleId,String approvalLimit,String accessType,String typeId,String labelName,String notificationBudgetRegionId){
        service.grantUserAccessInCostModule(userId,businessRoleId,approvalLimit,accessType,typeId,labelName,notificationBudgetRegionId);};

    public String getCostsAsString(String costTitle){
        checkLoggedIn();
        return service.getCostsAsString(costTitle);
    }

    public ValueReportingDetails getValueReportingdetails(String costId, String costRevisionId){
        checkLoggedIn();
        return service.getValueReportingdetails(costId, costRevisionId);
    }

    public ValueReportingDetails editValueReportingdetails(String costId, String costRevisionId, ValueReportingDetails reportingDetails){
        checkLoggedIn();
        return service.editValueReportingdetails(costId, costRevisionId,reportingDetails);
    }

    public ExpectedAssets[] getExpectedAssets(String costId, String costStageId, String revisionId){
        checkLoggedIn();
        return service.getExpectedAssets(costId, costStageId, revisionId);}

    public Vendors createVendorsGDAMway(Vendors vendors){
        checkLoggedIn();
        return service.createVendorsGDAMway(vendors);
    }

    public VendorsCount getVendorsGDAMway(String searchText){
        checkLoggedIn();
        return service.getVendorsGDAMway(searchText);}


    public String checkAdCostHeartBeat(){
        return service.checkAdCostHeartBeat();
    }

    public Vendors getVendorDetails(String id){
        checkLoggedIn();
        return service.getVendorDetails(id);}

    public CostOwners[] getCostOwnersforCostId(String costId){
        checkLoggedIn();
        return service.getCostOwnersforCostId(costId); }


    /** NEWLIB **/
    public AssetFilter createAssetFilterNEWLIB(String name, String query,String assetId) {
        checkLoggedIn();
        return service.createAssetFilterNEWLIB(name, "asset_filter_collection", query,assetId);
    }

    /** NEWLIB **/
    public AssetFilter addAssetToCollection(String name, String query,String collectionId,String assetId) {
        checkLoggedIn();
        return service.addAssetToCollection(name, "asset_filter_collection", query,collectionId,assetId);
    }

    public void addAssetToReel(String reelId,String assetId)
    {
        checkLoggedIn();
        service.addAssetToReel(reelId,assetId);
    }

    /** NEWLIB **/
    public void acceptAssetsFromCollection(String collectionId,String[] assetIds) {
        checkLoggedIn();
        service.acceptAssetsFromCollection(collectionId,assetIds);
    }

    public  String createAssetPublicShare(String assetId,long expirationDate, List<String> users){
        return service.createPublicShare("asset", assetId, expirationDate,  Arrays.copyOf(users.toArray(), users.size(), String[].class), null).getToken();
    }

    public Boolean checkAssetDownloaded_newlibrary(String assetName,String assetId,String assetType){
        return service.checkAssetDownloaded_newlibrary(assetName,assetId,assetType);
    }

    public Boolean checkAssetDownloadedSendplus(String assetName,String assetId,String assetType){
        return service.checkAssetDownloadedSendplus(assetId,assetType);
    }

    public Boolean checkStoryBoardDownload(String assetId,String[] fieldIds){
        return service.checkStoryBoardDownload(assetId,fieldIds);
    }

    public BaseObject UploadComplete_WorkRequest(String projectFolderId,String brieffileId,String fileName){
        return service.UploadComplete_WorkRequest(getProjectRootFolder(projectFolderId).getId(),brieffileId,fileName);
    }



    /** MEDIA MANAGER **/
    public PAPIApplication generatePAPIKeySecret(String email, String id){
        return service.generatePAPIKeySecret(email, id);

    }

    public PAPIApplication[] listApplications(String email){
        return service.listApplications(email);

    }
    public AQAReport getQCReportData(String id) {
        String currentUserEmail = service.getCurrentUser().getEmail();
        return service.getQCReportDataView(id,currentUserEmail);
    }

    public String getAdditionalServiceStatusFromTraffic(String orderReference,String qcAssetId,String destination,String serviceType) throws IOException {
        return service.getAdditionalServiceStatusFromTraffic(orderReference, qcAssetId, destination,serviceType);
    }

    public String getOrderItemA5ViewStatusfromTraffic(String orderReference,String qcAssetId,String destination) throws IOException {
        System.out.println(service.getA5ViewStatusFromTraffic(orderReference, qcAssetId,destination));
        return service.getA5ViewStatusFromTraffic(orderReference, qcAssetId,destination);
    }

    public String getOrderItemA5ViewStatusfromTrafficForClones(String orderId,String destination) throws IOException {
        return service.getOrderItemA5ViewStatusfromTrafficForClones(orderId, destination);
    }


}