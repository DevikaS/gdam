package com.adstream.automate.babylon.core;

import com.adstream.automate.babylon.*;
import com.adstream.automate.babylon.JsonObjects.*;
import com.adstream.automate.babylon.JsonObjects.NewLibrary.StoryBoardDownload;
import com.adstream.automate.babylon.JsonObjects.adcost.*;
import com.adstream.automate.babylon.JsonObjects.dictionary.Dictionary;
import com.adstream.automate.babylon.JsonObjects.dictionary.DictionaryType;
import com.adstream.automate.babylon.JsonObjects.dictionary.DictionaryValues;
import com.adstream.automate.babylon.JsonObjects.gdn.*;
import com.adstream.automate.babylon.JsonObjects.mediamanager.AQAReport;
import com.adstream.automate.babylon.JsonObjects.mediamanager.PAPIApplication;
import com.adstream.automate.babylon.JsonObjects.ordering.*;
import com.adstream.automate.babylon.JsonObjects.ordering.billing.*;
import com.adstream.automate.babylon.JsonObjects.ordering.enums.UploadRequestType;
import com.adstream.automate.babylon.JsonObjects.projectsaccessrure.ProjectsAccessRule;
import com.adstream.automate.babylon.JsonObjects.schema.AssetElementCommonSchema;
import com.adstream.automate.babylon.JsonObjects.schema.AssetElementProjectCommonSchema;
import com.adstream.automate.babylon.JsonObjects.schema.AssetSchema;
import com.adstream.automate.babylon.JsonObjects.schema.ProjectSchema;
import com.adstream.automate.babylon.JsonObjects.usagerights.*;
import com.adstream.automate.utils.Common;
import com.adstream.automate.utils.DateTimeUtils;
import com.adstream.gdn.api.client.serialization.Job;
import com.adstream.gdn.api.client.serialization.JobResponse;
import com.google.gson.*;
import com.google.gson.reflect.TypeToken;
import org.apache.http.client.methods.*;
import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.entity.mime.MultipartEntityBuilder;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;
import org.apache.http.util.EntityUtils;
import org.apache.tools.ant.taskdefs.condition.Http;
import org.w3c.dom.Document;
import org.apache.commons.lang.StringUtils;
import org.joda.time.DateTime;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;
import org.xml.sax.SAXException;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import java.io.*;
import java.lang.reflect.Type;
import com.jcraft.jsch.*;
import java.net.URL;
import java.net.URLEncoder;
import java.util.*;

import java.util.List;
/**
 * User: ruslan.semerenko
 * Date: 02.04.12 13:44
 */
public class BabylonCoreService extends BabylonMessageSender implements BabylonService {
    //private BatchTaskApi batchTaskApi;
    private String authId;
    private String adcostAuthId;

    public BabylonCoreService(URL url) {
        this(url, null);
    }

    public BabylonCoreService(URL url, String userId) {
        super(url);
        contentType = "application/json";
        authId = "id-" + userId;
    }

    public BabylonCoreService(String adcostauthId) {
        contentType = "application/json";
        adcostAuthId = "$id$=" + adcostauthId;
    }

    @Override
    public BaseObject getObjectIdentity(String objectId) {
        HttpGet get = new HttpGet(baseUrl + "admin/object/identity/" + objectId + "?$id$=" + authId);
        return sendRequest(get, BaseObject.class);
    }

  /*  @Override
    public String getVersion() {
       System.out.println("Entering BabylonCoreService.getVersion(BabylonCoreService.java:61)");
        HttpGet get = new HttpGet(baseUrl + "admin/version");
        //Type returnType = new TypeToken<Map<String, String>>() { }.getType();
        Type returnType = new TypeToken<Map<JsonObject, String>>() { }.getType();
        //Map<JsonObject,JsonObject> result= sendRequest(get,returnType);

        Map<String, String> result = sendRequest(get, returnType);
        return result.get("version");
    }

    @Override
    public String getBranch() {
        HttpGet get = new HttpGet(baseUrl + "admin/version");
        Type returnType = new TypeToken<Map<String, String>>() {
        }.getType();
        Map<String, String> result = sendRequest(get, returnType);
        return result.get("branch");
    }
*/

    class VersionBranch {
        public String version;
        public String branch;
    }

    class AdocstBuildNumber {
        public String buildNumber;
    }

    @Override
    public String getVersion() {
        HttpGet get = new HttpGet(baseUrl + "admin/version");
        VersionBranch result = sendRequest(get, VersionBranch.class);
        return result.version;
    }

    @Override
    public String getAdcostVersion(){
        HttpGet get = new HttpGet(TestsContext.getInstance().adcostCore.toString() + "/v1/admin/version");
        AdocstBuildNumber result = sendRequest(get, AdocstBuildNumber.class);
        return result.buildNumber;
    }

    @Override
    public String getBranch() {
        HttpGet get = new HttpGet(baseUrl + "admin/version");
        VersionBranch result = sendRequest(get, VersionBranch.class);
        return result.branch;
    }



    @Override
    public void rebuildIndex() {
        rebuildIndex(null, null, null);
    }

    @Override
    public void rebuildIndex(String[] indexType, String[] agencyId, Integer batchSize) {
        JsonObject request = new JsonObject();
        if (indexType != null && indexType.length > 0) {
            request.add("indexTypes", gson.toJsonTree(indexType));
        }
        if (agencyId != null && agencyId.length > 0) {
            request.add("agencyIds", gson.toJsonTree(agencyId));
        }
        if (batchSize != null) {
            request.addProperty("batchSize", batchSize);
        }

        request.addProperty("withoutRefresh", true);

        HttpPost post = createPost(baseUrl + "admin/index/rebuild?$id$=" + authId, request.toString());
        sendRequest(post);
    }

    public void denormalizeCategories(String agencyId) {
        denormalizeCategories(agencyId, null);
    }

    public void denormalizeCategories(String agencyId, String categoryId) {
        StringBuilder address = new StringBuilder(baseUrl);
        address.append("operations/denormalize_categories/").append(agencyId);
        if (categoryId != null) {
            address.append("/").append(categoryId);
        }
        sendRequest(createPost(address.toString(), ""));
    }

    @Override
    public Dictionary getDictionary(DictionaryType type) {
        StringBuilder address = new StringBuilder(baseUrl);
        address.append("dictionary/").append(type).append("?$id$=").append(authId);
        HttpGet get = new HttpGet(address.toString());
        return sendRequest(get, Dictionary.class);
    }

    @Override
    public Dictionary getAgencyDictionaryByName(String agencyId, String dictionaryName) {
        String address = String.format("%sdictionary/%s?agency=%s&$id$=%s", baseUrl, dictionaryName, agencyId, authId);
        HttpGet get = new HttpGet(address);
        return sendRequest(get, Dictionary.class);
    }

    @Override
    public Dictionary createAgencyDictionary(String agencyId, String dictionaryName, List<CustomMetadata> values) {
        String address = String.format("%sdictionary?agency=%s&$id$=%s", baseUrl, agencyId, authId);
        JsonObject createDictionaryRequest = new JsonObject();
        createDictionaryRequest.addProperty("name", dictionaryName);
        createDictionaryRequest.add("values", gson.toJsonTree(values));

        HttpPost post = createPost(address, createDictionaryRequest.toString());
        return sendRequest(post, Dictionary.class);
    }

    @Override
    public Dictionary updateAgencyDictionaryValues(String agencyId, String dictionaryName, List<CustomMetadata> values) {
        Dictionary dictionary = getAgencyDictionaryByName(agencyId, dictionaryName);
        if (dictionary == null) dictionary = createAgencyDictionary(agencyId, dictionaryName, new ArrayList<CustomMetadata>());
        String dictionaryId = dictionary.getId();
        String address = String.format("%sdictionary/%s?$id$=%s", baseUrl, dictionaryId, authId);
        JsonObject createDictionaryRequest = new JsonObject();
        createDictionaryRequest.addProperty("name", dictionaryName);
        createDictionaryRequest.add("values", gson.toJsonTree(values));

        HttpPut put = createPut(address, createDictionaryRequest.toString());
        return sendRequest(put, Dictionary.class);
    }

    @Override
    public Dictionary updateAgencyDictionary(String agencyId, String dictionaryName, DictionaryValues values) {
        Dictionary dictionary = getAgencyDictionaryByName(agencyId, dictionaryName);
        if (dictionary == null) dictionary = createAgencyDictionary(agencyId, dictionaryName, new ArrayList<CustomMetadata>());
        String dictionaryId = dictionary.getId();
        String address = String.format("%sdictionary/%s?$id$=%s", baseUrl, dictionaryId, authId);
        JsonObject createDictionaryRequest = new JsonObject();
        createDictionaryRequest.addProperty("name", dictionaryName);
        createDictionaryRequest.add("values", gson.toJsonTree(values));

        HttpPut put = createPut(address, createDictionaryRequest.toString());
        return sendRequest(put, Dictionary.class);
    }

    @Override
    public String auth(String email, String password) {
        JsonObject authRequest = new JsonObject();
        authRequest.addProperty("email", email);
        authRequest.addProperty("password", password);
        HttpPost post = createPost(baseUrl + "user/auth", authRequest.toString());
        String response = sendRequest(post);
        JsonObject responseObj = new JsonParser().parse(response).getAsJsonObject();
        authId = responseObj.getAsJsonPrimitive("$id$").getAsString();
        return authId;
    }

    public String adcostAuth(String email){
        adcostAuthId = "$id$=" + email;
        return adcostAuthId;
    }

    @Override
    public String impersonate(String email, String comment) {
        String address = baseUrl + "user/impersonate?$id$=" + authId
                + "&email=" + Common.urlEncode(email) + "&comment=" + Common.urlEncode(comment);
        String response = sendRequest(new HttpGet(address));
        JsonObject responseObj = new JsonParser().parse(response).getAsJsonObject();
        authId = responseObj.getAsJsonPrimitive("$id$").getAsString();
        return authId;
    }

    @Override
    public String authSSO(String email, String password) {
        throw new UnsupportedOperationException("Not implemented yet");
    }

    @Override
    public String loginToSendplusMiddleTier(String emailID, String passWord)throws IOException
    {
        return "";
    }

    @Override
    public HashMap<String, String> createFileIDForSendplusUploadToProjects(String cookie,String folderId) throws IOException {
        HashMap<String, String> hmap = new HashMap<String, String>();
        return hmap;
    }

    @Override
    public void downloadFolderAndProjectViaUsingSendplusMiddletier(String cookie, String elementID, String fileID) throws IOException {


    }

    @Override
    public  HashMap<String, String> createFileIDForSendplusUploadToLibrary(String cookie) throws IOException {
        HashMap<String, String> hmap = new HashMap<String, String>();
        return hmap;
    }

    @Override
    public  HashMap<String, String> assetAttachmentViaSendplus(String cookie,String assetId,String fname,int fsize) throws IOException {
        HashMap<String, String> hmap = new HashMap<String, String>();
        return hmap;
    }



    @Override
    public void uploadFileToAdbankStorageViaSendplusMiddleTier(String uploadURL,File file)throws IOException {

    }

    @Override
    public void displayFileInProjectsViaSendplusMiddleTier(String cookie, String uploadID,String folderId)throws IOException {

    }
    @Override
    public void displayFileInLibraryViaSendplusMiddleTier(String cookie, String uploadID)throws IOException {

    }

    @Override
    public String uploadFileToS3AdbankStorageViaSendplusMiddleTier(String uploadURL,File file)throws IOException {
        return "";
    }

    @Override
    public void displayS3FileInProjectsViaSendplusMiddleTier(String cookie, String uploadID,String folderId,String eTag) throws IOException {

    }

    @Override
    public void displayS3FileInLibraryViaSendplusMiddleTier(String cookie, String uploadID,String eTag)throws IOException {

    }

    @Override
    public  HashMap<String, String> uploadFileRevisionViaSendplus(String cookie,String fileId,String fname,int fsize) throws IOException {
        HashMap<String, String> hmap = new HashMap<String, String>();
        return hmap;
    }

    @Override
    public  HashMap<String, String> uploadFileAttachmentViaSendplus(String cookie,String fileId,String fname,int fsize) throws IOException {
        HashMap<String, String> hmap = new HashMap<String, String>();
        return hmap;
    }

    @Override
    public void logoutSSO() {
    }

    @Override
    public AssetSchema getAssetSchema(String agencyId) {
        String address = String.format("%sschema/asset?$id$=%s&type=agency&value=%s", baseUrl, authId, agencyId);
        HttpGet get = new HttpGet(address);
        return sendRequest(get, AssetSchema.class);
    }

    @Override
    public AssetSchema updateAssetSchema(String agencyId, AssetSchema schema) {
        String address = String.format("%sschema/asset?$id$=%s&type=agency&value=%s", baseUrl, authId, agencyId);
        HttpPut put = createPut(address, gson.toJson(schema));
        return sendRequest(put, AssetSchema.class);
    }

    @Override
    public AssetElementCommonSchema getAssetElementCommonSchema(String agencyId) {
        String address = String.format("%sschema/asset_element_common?$id$=%s&type=agency&value=%s", baseUrl, authId, agencyId);
        HttpGet get = new HttpGet(address);
        return sendRequest(get, AssetElementCommonSchema.class);
    }

    @Override
    public AssetElementCommonSchema updateAssetElementCommonSchema(String agencyId, AssetElementCommonSchema schema) {
        String address = String.format("%sschema/asset_element_common?$id$=%s&type=agency&value=%s", baseUrl, authId, agencyId);
        HttpPut put = createPut(address, gson.toJson(schema));
        return sendRequest(put, AssetElementCommonSchema.class);
    }

    @Override
    public ProjectTermsAndConditions getProjectTermsAndConditions(String projectId) {
        String address = String.format("%s/terms-and-conditions/project/%s?$id$=%s", baseUrl, projectId, authId);
        return sendRequest(new HttpGet(address), ProjectTermsAndConditions.class);
    }

    @Override
    public ProjectSchema getProjectSchema(String agencyId) {
        String address = String.format("%sschema/project?$id$=%s&type=agency&value=%s", baseUrl, authId, agencyId);
        HttpGet get = new HttpGet(address);
        return sendRequest(get, ProjectSchema.class);
    }

    @Override
    public ProjectSchema updateProjectSchema(String agencyId, ProjectSchema schema) {
        String address = String.format("%sschema/project?$id$=%s&type=agency&value=%s", baseUrl, authId, agencyId);
        HttpPut put = createPut(address, gson.toJson(schema));
        return sendRequest(put, ProjectSchema.class);
    }

    @Override
    public AssetElementProjectCommonSchema getAssetElementProjectCommonSchema(String agencyId) {
        String address = String.format("%sschema/asset_element_project_common?$id$=%s&type=agency&value=%s", baseUrl, authId, agencyId);
        HttpGet get = new HttpGet(address);
        return sendRequest(get, AssetElementProjectCommonSchema.class);
    }

    @Override
    public AssetElementProjectCommonSchema updateAssetElementProjectCommonSchema(String agencyId, AssetElementProjectCommonSchema schema) {
        String address = String.format("%sschema/asset_element_project_common?$id$=%s&type=agency&value=%s", baseUrl, authId, agencyId);
        HttpPut put = createPut(address, gson.toJson(schema));
        return sendRequest(put, AssetElementProjectCommonSchema.class);
    }

    @Override
    public User getUser(String userId) {
        HttpGet get = new HttpGet(baseUrl + "user/" + userId + "?with=permissions,roles&$id$=" + authId);
        return sendRequest(get, User.class);
    }

    @Override
    public User getCurrentUser() {
        HttpGet get = new HttpGet(baseUrl + "user/current?with=permissions,roles&$id$=" + authId);
        return sendRequest(get, User.class);
    }

    @Override
    public SearchResult<User> findUsers(LuceneSearchingParams query) {
        return findUsers(query, new With());
    }

    @Override
    public SearchResult<User> findUsers(LuceneSearchingParams query, With with) {
        StringBuilder address = new StringBuilder(baseUrl);
        address.append("user/find?$id$=").append(authId);
        address.append(query.toGetParams()).append(with.toGetParams());
        HttpGet get = new HttpGet(address.toString());
        Type type = new TypeToken<SearchResult<User>>() {
        }.getType();
        return sendRequest(get, type);
    }

    @Override
    public String getElasticSearchRebuildTime() {
        try {
            HttpGet get = new HttpGet(baseUrl + "admin/index/rebuild/duration");
            Type returnType = new TypeToken<Map<String, String>>() {
            }.getType();
            Map<String, String> response = sendRequest(get, returnType);
            if (response == null || response.get("max_in_ms") == null) return "0";
            return String.valueOf(Integer.parseInt(response.get("max_in_ms")));
        } catch (Throwable e) {
            log.error(e.getMessage(), e);
            return "0";
        }
    }

    @Override
    public User createGlobalAdminUser(String groupId, User user) {
        StringBuilder url = new StringBuilder(baseUrl)
                .append("user/into/").append(groupId)
                .append("?$id$=").append(authId);

        JsonObject json = gson.toJsonTree(user).getAsJsonObject();
        json.remove("roles");
        json.remove("agency");
        HttpPost post = createPost(url.toString(), json.toString());
        return sendRequest(post, User.class);
    }

    @Override
    public User editGlobalAdminUser(String groupId, User user) {
        StringBuilder url = new StringBuilder(baseUrl)
                .append("user/").append(user.getId())
                .append("?$id$=").append(authId);

        JsonObject json = gson.toJsonTree(user).getAsJsonObject();
        json.remove("roles");
        json.remove("agency");
        HttpPut post = createPut(url.toString(), json.toString());
        return sendRequest(post, User.class);
    }

    @Override
    public User createUser(String groupId, User user) {
        StringBuilder url = new StringBuilder(baseUrl)
                .append("user/into/").append(groupId)
                .append("?with=permissions,roles&$id$=").append(authId);
        BaseObject[] roles = user.getRoles();
        if (roles != null && roles.length > 0) {
            url.append("&roles=").append(roles[0].getId());
            for (int i = 1; i < roles.length; i++)
                url.append(",").append(roles[i].getId());
        }
        JsonObject json = gson.toJsonTree(user).getAsJsonObject();
        json.remove("roles");
        json.remove("agency");
        json.remove("customEmail");
        HttpPost post = createPost(url.toString(), json.toString());
        return sendRequest(post, User.class);
    }

    @Override
    public List<String> getGlobalAdminUsers(){
        StringBuilder url = new StringBuilder(TestsContext.getInstance().gaCoreUrl[0].toString())
                .append("/admin/refresh-users");
        HttpPost post = createPost(url.toString(), "");
        String response = sendRequest(post);
        JsonObject responseObj = new JsonParser().parse(response).getAsJsonObject();
        List<String> admins = new ArrayList<>();
        for(JsonElement element: responseObj.getAsJsonArray("admins")){
            admins.add(element.getAsString());
        }
        return admins;
    }

    @Override
    public User updateUser(String userId, User newUser) {
        if (newUser.getAgency() != null) {
            // we need agency only with 2 fields
            Agency simpleAgency = new Agency();
            simpleAgency.setId(newUser.getAgency().getId());
            simpleAgency.setName(newUser.getAgency().getName());
            newUser.setAgency(simpleAgency);
        }

        StringBuilder address = new StringBuilder(baseUrl);
        address.append("user/").append(userId).append("?with=permissions,roles&$id$=").append(authId);
        HttpPut put = createPut(address.toString(), gson.toJson(newUser));
        return sendRequest(put, User.class);
    }

    @Override
    public void deleteUser(String userId, String reassignDataToUserId) {
        StringBuilder address = new StringBuilder(baseUrl);
        address.append("user/").append(userId).append("/newowner/").append(reassignDataToUserId).append("?$id$=").append(authId);
        HttpDelete delete = new HttpDelete(address.toString());
        sendRequest(delete);
    }

    @Override
    public User inviteUser(String email) {
        JsonObject request = new JsonObject();
        request.addProperty("email", email);
        HttpPost post = createPost(baseUrl + "user/invite?$id$=" + authId, request.toString());
        return sendRequest(post, User.class);
    }

    @Override
    public void addExistingUserToAgency(String userId, String agencyId, String roleId) {
        StringBuilder address = new StringBuilder(baseUrl);
        address.append("user/").append(userId).append("/add/agency?$agencyId$=id-").append(agencyId).append("&$id$=").append(authId);

        JsonObject request = new JsonObject();
        request.addProperty("roleId", roleId);

        HttpPut put = createPut(address.toString(), request.toString());
        sendRequest(put);
    }

    @Override
    public void addNotificationSetting(String userId, String notificationSetting,String settingState) {
        StringBuilder address = new StringBuilder(TestsContext.getInstance().mailServiceApiUrl.toString());
        address.append("/api/users/").append(userId).append("/notifications?$id$=id-").append(userId).append("&$originId$=").append("id-4ef31ce1766ec96769b399c0");
        JsonObject request = new JsonObject();
        JsonArray actionSettings = new JsonArray();
        JsonObject innerObj = new JsonObject();
        innerObj.addProperty("ActionTypeName",notificationSetting);
        if(settingState.equalsIgnoreCase("on")){
            innerObj.addProperty("NotificationType","1");
        }else if(settingState.equalsIgnoreCase("off")){
            innerObj.addProperty("NotificationType","0");
        }
        actionSettings.add(innerObj);
        request.add("ActionSettings", actionSettings);
        HttpPut put = createPut(address.toString(), request.toString());
        sendRequest(put);
    }
    @Override
    public BaseObject getHead() {
        HttpGet get = new HttpGet(baseUrl + "group/head?$id$=" + authId);
        return sendRequest(get, BaseObject.class);
    }

    @Override
    public BaseObject getGroup(String groupId) {
        HttpGet get = new HttpGet(baseUrl + "group/" + groupId + "?$id$=" + authId);
        return sendRequest(get, BaseObject.class);
    }

    @Override
    public <T> SearchResult<T> getChildren(String groupId, String type) {
        HttpGet get = new HttpGet(baseUrl + "group/" + groupId + "/children?$id$=" + authId + "&type=" + type);
        Type responseType;
        if (type.equals("user")) responseType = new TypeToken<SearchResult<User>>() {
        }.getType();
        else if (type.equals("agency")) responseType = new TypeToken<SearchResult<Agency>>() {
        }.getType();
        else if (type.equals("user_group")) responseType = new TypeToken<SearchResult<UserGroup>>() {
        }.getType();
        else responseType = new TypeToken<SearchResult<BaseObject>>() {
            }.getType();
        return sendRequest(get, responseType);
    }

    @Override
    public void addChild(String parentId, BaseObject child) {
        JsonObject request = new JsonObject();
        request.addProperty("_id", child.getId());
        HttpPost post = createPost(baseUrl + "group/" + parentId + "/children?$id$=" + authId, request.toString());
        sendRequest(post);
    }

    @Override
    public void addChild(String parentId, String childId) {
        JsonObject request = new JsonObject();
        request.addProperty("_id", childId);
        HttpPost post = createPost(baseUrl + "group/" + parentId + "/children?$id$=" + authId, request.toString());
        sendRequest(post);
    }

    @Override
    public void removeChild(String groupId, String childId) {
        HttpDelete delete = new HttpDelete(baseUrl + "group/" + groupId + "/children/" + childId + "?$id$=" + authId);
        sendRequest(delete);
    }

    @Override
    public void removeChildren(String groupId, String... childrenId) {
        JsonObject request = new JsonObject();
        request.add("_id", gson.toJsonTree(childrenId));
        HttpPost post = createPost(baseUrl + "group/" + groupId + "/children/delete?$id$=" + authId, request.toString());
        sendRequest(post);
    }

    @Override
    public BaseObject createGroup(String parentId, String name, String subtype) {
        JsonObject request = new JsonObjectBuilder()
                .add("_subtype", subtype)
                .forNode("_cm.common")
                .add("name", name)
                .build();
        HttpPost post = createPost(baseUrl + "group/into/" + parentId + "?$id$=" + authId, request.toString());
        return sendRequest(post, BaseObject.class);
    }

    @Override
    public BaseObject updateGroup(String groupId, String newName) {
        JsonObject request = new JsonObject();
        request.addProperty("name", newName);
        HttpPut put = createPut(baseUrl + "group/" + groupId + "?$id$=" + authId, request.toString());
        return sendRequest(put, BaseObject.class);
    }

    @Override
    public void deleteGroup(String groupId) {
        HttpDelete delete = new HttpDelete(baseUrl + "group/" + groupId + "?$id$=" + authId);
        sendRequest(delete);
    }

    @Override
    public byte[] getLogo(String objectType, String objectId) {
        HttpGet get = new HttpGet(baseUrl + "logo/find?documentId=" + objectId + "&documentType=" + objectType);
        return sendRequestRaw(get);
    }

    @Override
    public Agency createAgency(Agency agency) {
        HttpPost post = createPost(baseUrl + "agency?$id$=" + authId, gson.toJson(agency.fixPasswordStrengthFieldsType()));
        return sendRequest(post, Agency.class);
    }

    @Override
    public Agency updateAgency(Agency agency) {
        StringBuilder address = new StringBuilder(baseUrl);
        address.append("agency/").append(agency.getId()).append("/update?$id$=").append(authId);
        HttpPost post = createPost(address.toString(), gson.toJson(agency.fixPasswordStrengthFieldsType()));
        return sendRequest(post, Agency.class);
    }

    @Override
    public Agency getCurrentAgency() {
        HttpGet get = new HttpGet(baseUrl + "agency/current?$id$=" + authId);
        return sendRequest(get, Agency.class);
    }

    @Override
    public List<Agency> getAgencies() {
        return findAgencies(new LuceneSearchingParams()).getResult();
    }

    @Override
    public Agency getAgency(String agencyId) {
        HttpGet get = new HttpGet(baseUrl + "agency/" + agencyId + "?$id$=" + authId);
        return sendRequest(get, Agency.class);
    }

    @Override
    public SearchResult<Agency> findAgencies(LuceneSearchingParams query) {
        HttpGet get = new HttpGet(baseUrl + "agency/find?$id$=" + authId + query.toGetParams());
        Type returnType = new TypeToken<SearchResult<Agency>>() {
        }.getType();
        return sendRequest(get, returnType);
    }

    @Override
    public List<Agency> getAgenciesSimple() {
        return findAgenciesSimple(new LuceneSearchingParams()).getResult();
    }

    @Override
    public SearchResult<Agency> findAgenciesSimple(LuceneSearchingParams query) {
        HttpGet get = new HttpGet(baseUrl + "agency/find/simple?$id$=" + authId + query.toGetParams());
        Type returnType = new TypeToken<SearchResult<Agency>>() {
        }.getType();
        return sendRequest(get, returnType);
    }

    @Override
    public List<Agency> getPartnerAgencies(String agencyId) {
        HttpGet get = new HttpGet(baseUrl + "agency/" + agencyId + "/partners");
        Type returnType = new TypeToken<SearchResult<Agency>>() {
        }.getType();
        SearchResult<Agency> result = sendRequest(get, returnType);
        return result.getResult();
    }

    @Override
    public Agency addPartnerAgency(String agencyId, String partnerAgencyId, boolean canBill, boolean canView) {
        JsonObject request = new JsonObject();
        request.addProperty("partner", partnerAgencyId);
        request.addProperty("canBill", canBill);
        request.addProperty("canView", canView);
        HttpPut put = createPut(baseUrl + "agency/" + agencyId + "/partners", request.toString());
        return sendRequest(put, Agency.class);
    }

    @Override
    public void removePartnerAgency(String agencyId, String partnerAgencyId) {
        HttpDelete delete = new HttpDelete(baseUrl + "agency/" + agencyId + "/partners/" + partnerAgencyId+ "?with=permissions&$id$=" +authId);
        sendRequest(delete);
    }

    @Override
    public void setUserRole(String agencyId, String userId, String[] rolesId) {
        JsonObject request = new JsonObject();
        request.add("set", gson.toJsonTree(rolesId));
        StringBuilder address = new StringBuilder(baseUrl);
        address.append("agency/").append(agencyId);
        address.append("/roles/user/").append(userId);
        address.append("?$id$=").append(authId);
        HttpPost post = createPost(address.toString(), request.toString());
        sendRequest(post);
    }

    @Override
    public Content getAsset(String assetId) {
        HttpGet get = new HttpGet(baseUrl + "asset/" + assetId + "?$id$=" + authId);
        return sendRequest(get, Content.class);
    }

    @Override
    public SearchResult<Content> findAssets(LuceneSearchingParams query) {
        StringBuilder address = new StringBuilder(baseUrl);
        address.append("asset/find?$id$=").append(authId).append(query.toGetParams());
        HttpGet get = new HttpGet(address.toString());
        Type returnType = new TypeToken<SearchResult<Content>>() {
        }.getType();
        return sendRequest(get, returnType);
    }

    @Override
    public SearchResult<Content> findAssets(String parentId, LuceneSearchingParams query) {
        return findAssets(parentId, query, null);
    }

    @Override
    public SearchResult<Content> findAssetsForClient(String parentId, LuceneSearchingParams query,String userId) {
        return findAssetsForClient(parentId, query, null, userId);
    }

    @Override
    public SearchResult<Content> findAssets(String parentId, LuceneSearchingParams query, With with) {
        StringBuilder address = new StringBuilder(baseUrl);
        address.append("asset/find/").append(parentId).append("?$id$=").append(authId);
        if (query != null) {
            address.append(query.toGetParams());
        }
        if (with != null) {
            address.append(with.toGetParams());
        }
        HttpGet get = new HttpGet(address.toString());
        Type returnType = new TypeToken<SearchResult<Content>>() {
        }.getType();
        return sendRequest(get, returnType);
    }

    @Override
    public SearchResult<Content> findAssetsForClient(String parentId, LuceneSearchingParams query, With with,String userId) {
        StringBuilder address = new StringBuilder(baseUrl);
        address.append("asset/find/").append(parentId).append("?$id$=id-").append(userId);
        if (query != null) {
            address.append(query.toGetParams());
        }
        if (with != null) {
            address.append(with.toGetParams());
        }
        HttpGet get = new HttpGet(address.toString());
        Type returnType = new TypeToken<SearchResult<Content>>() {
        }.getType();
        return sendRequest(get, returnType);
    }

    @Override
    public SearchResult<Content> findAssets(String parentId) {
        return findAssets(parentId, null, null);
    }

    @Override
    public AssetFilters getAssetFiltersForClient(String userId) {

        return getAssetFiltersForClient(null, userId);
    }
    @Override
    public AssetFilters getAssetFilters() {
        return getAssetFilters(null);
    }
    @Override
    public AssetFilters getAssetFilters(String subtype) {
        StringBuilder address = new StringBuilder(baseUrl);
        address.append("asset/filter/find?");
        if (subtype != null && !subtype.isEmpty())
            address.append("type=").append(subtype).append("&");
        address.append("$id$=").append(authId);
        HttpGet get = new HttpGet(address.toString());
        return sendRequest(get, AssetFilters.class);
    }

    @Override
    public AssetFilters getAssetFiltersForClient(String subtype,String userId) {
        StringBuilder address = new StringBuilder(baseUrl);
        address.append("asset/filter/find?");
        if (subtype != null && !subtype.isEmpty())
            address.append("type=").append(subtype).append("&");
        address.append("$id$=").append("id-"+userId);
        HttpGet get = new HttpGet(address.toString());
        return sendRequest(get, AssetFilters.class);
    }

    @Override
    public BaseObject getAssetFilterRootFolder() {
        HttpGet get = new HttpGet(baseUrl + "asset/filter/root?$id$=" + authId);
        return sendRequest(get, BaseObject.class);
    }

    @Override
    public AssetFilter createAssetFilter(String name, String subtype, String query) {
        JsonObject common = new JsonObject();
        common.addProperty("name", name);
        common.addProperty("query", query);

        JsonObject cm = new JsonObject();
        cm.add("common", common);

        JsonObject request = new JsonObject();
        request.add("_cm", cm);
        request.addProperty("_subtype", subtype);
        HttpPost post = createPost(baseUrl + "asset/filter?with=permissions&$id$=" + authId, request.toString());
        return sendRequest(post, AssetFilter.class);
    }
    @Override
    public AssetFilter createAssetFilterForClient(String name, String subtype, String query,String userId) {
        JsonObject common = new JsonObject();
        common.addProperty("name", name);
        common.addProperty("query", query);

        JsonObject cm = new JsonObject();
        cm.add("common", common);

        JsonObject request = new JsonObject();
        request.add("_cm", cm);
        request.addProperty("_subtype", subtype);
        HttpPost post = createPost(baseUrl + "asset/filter?with=permissions&$id$=id-" + userId, request.toString());
        return sendRequest(post, AssetFilter.class);
    }

    @Override
    public void shareAssetFilter(String assetFilterId, String subjectId, String roleId) {
        shareAssetFilter(assetFilterId, subjectId, roleId, null, null);
    }

    @Override
    public void shareAssetFilter(String assetFilterId, String subjectId, String roleId, Boolean write, Long expiration) {
        JsonObject request = new JsonObject();
        request.addProperty("to", subjectId);
        request.addProperty("role", roleId);
        if (write != null) {
            request.addProperty("write", write);
        }
        if (expiration != null) {
            request.addProperty("expiration", expiration);
        }
        StringBuilder address = new StringBuilder(baseUrl);
        address.append("asset/filter/").append(assetFilterId).append("/share?$id$=").append(authId);
        HttpPost post = createPost(address.toString(), request.toString());
        sendRequest(post);
    }

    @Override
    public void shareAssetFilterToAgency(String assetFilterId, String agencyId) {
        JsonObject request = new JsonObject();
        request.addProperty("agencyId", agencyId);
        StringBuilder address = new StringBuilder(baseUrl);
        address.append("asset/filter/").append(assetFilterId).append("/sharetoagency?$id$=").append(authId);
        HttpPost post = createPost(address.toString(), request.toString());
        sendRequest(post);

    }

    @Override
    public void unshareAssetFilter(String assetFilterId, String... subjectId) {
        StringBuilder address = new StringBuilder(baseUrl);
        address.append("asset/filter/").append(assetFilterId).append("/subjects/");
        for (int i = 0; i < subjectId.length; i++) {
            if (i > 0) address.append(",");
            address.append(subjectId[i]);
        }
        address.append("?$id$=").append(authId);
        HttpDelete delete = new HttpDelete(address.toString());
        sendRequest(delete);
    }

    @Override
    public AssetFilter updateAssetFilter(String assetFilterId, String name, String query) {
        JsonObject common = new JsonObject();
        common.addProperty("name", name);
        common.addProperty("query", query);

        JsonObject cm = new JsonObject();
        cm.add("common", common);

        JsonObject request = new JsonObject();
        request.add("_cm", cm);
        HttpPut put = createPut(baseUrl + "asset/filter/" + assetFilterId + "?$id$=" + authId, request.toString());
        return sendRequest(put, AssetFilter.class);
    }

    @Override
    public void deleteAssetFilter(String assetFilterId) {
        HttpDelete delete = new HttpDelete(baseUrl + "asset/filter/" + assetFilterId + "?$id$=" + authId);
        sendRequest(delete);
    }

    @Override
    public SearchResult<Agency> getAssetFilterAgencies(String assetFilterId) {
        StringBuilder address = new StringBuilder(baseUrl);
        address.append("asset/filter/").append(assetFilterId).append("/agencies").append("?$id$=").append(authId);
        HttpGet get = new HttpGet(address.toString());
        Type returnType = new TypeToken<SearchResult<Agency>>() {
        }.getType();
        return sendRequest(get, returnType);
    }

    @Override
    public SearchResult<BaseObject> getAssetFilterSubjects(String assetFilterId) {
        StringBuilder address = new StringBuilder(baseUrl);
        address.append("asset/filter/").append(assetFilterId).append("/subjects").append("?$id$=").append(authId);
        HttpGet get = new HttpGet(address.toString());
        Type returnType = new TypeToken<SearchResult<BaseObject>>() {
        }.getType();
        return sendRequest(get, returnType);
    }

    @Override
    public AssetFilterFolder createAssetFilterFolder(String parentId, String name) {
        JsonObject request = new JsonObject();
        request.addProperty("name", name);
        HttpPost post = createPost(baseUrl + "asset/filter/folder/into/" + parentId + "?$id$=" + authId, request.toString());
        return sendRequest(post, AssetFilterFolder.class);
    }

    @Override
    public AssetFilter addAssetsToNewCollection(List<String> assetIds, String collectionName) {
        AssetFilter collection = createAssetFilter(collectionName, "asset_filter_collection", "{\"and\":[]}");
        return addAssetsToExistingCollection(assetIds, collection);
    }

    @Override
    public AssetFilter addAssetsToExistingCollection(List<String> assetIds, AssetFilter collection) {
        JsonObject request = new JsonObject();
        String assets = StringUtils.join(assetIds, "&asset_id=");
        String url = baseUrl + "asset/filter/" + collection.getId() + "/add?with=permissions" + assets + "&$id$=" + authId;
        HttpPut put = createPut(url, request.toString());
        return sendRequest(put, AssetFilter.class);
    }

    @Override
    public AssetFilterFolder updateAssetFilterFolder(String folderId, String name) {
        JsonObject request = new JsonObject();
        request.addProperty("name", name);
        HttpPut put = createPut(baseUrl + "asset/filter/folder/" + folderId + "?$id$=" + authId, request.toString());
        return sendRequest(put, AssetFilterFolder.class);
    }

    @Override
    public void deleteAssetFilterFolder(String folderId) {
        HttpDelete delete = new HttpDelete(baseUrl + "asset/filter/folder/" + folderId + "?$id$=" + authId);
        sendRequest(delete);
    }

    @Override
    public void copyAssetFilterToFolder(String assetFilterId, String folderId) {
        JsonObject request = new JsonObject();
        request.addProperty("folder", folderId);
        StringBuilder address = new StringBuilder(baseUrl);
        address.append("asset/filter/").append(assetFilterId).append("/copy?$id$=").append(authId);
        HttpPost post = createPost(address.toString(), request.toString());
        sendRequest(post);
    }

    @Override
    public void moveAssetFilterToFolder(String assetFilterId, String fromFolderId, String toFolderId) {
        JsonObject request = new JsonObject();
        request.addProperty("from", fromFolderId);
        request.addProperty("to", toFolderId);
        StringBuilder address = new StringBuilder(baseUrl);
        address.append("asset/filter/").append(assetFilterId).append("/move?$id$=").append(authId);
        HttpPost post = createPost(address.toString(), request.toString());
        sendRequest(post);
    }


    /**
     * Note: Need will be to refactoring easy later
     * Here we are creating a new post query to create relations between files in project
     *
     * On today, it's query contains next parameters:
     *
     * http://localhost:8080/filerelation/files/relations?with=permissions&
     *     id=54d9e682e4b05fb5caf33cfd  - parent file id
     *
     *     Body attribues:
     *
     *         "documentId":       - destination file id
     *         "relationRoleKey":  - role id
     *         "documentType":     - document type
     *         "relationTypeId":   - permission id (for watching all relation types use GET http://host:8080/relationtype/agency/$AGENCY_ID?$id$=id-$SESSION_ID )
     *    }
     *
     * @param agencyId
     * @param childFileId
     * @param parentFileId
     */
    @Override
    public void addRelationBetweenFiles(String agencyId, String asType, String childFileId, String parentFileId) {
        HttpGet get = new HttpGet(baseUrl + "relationtype/agency/" + agencyId+ "?$id$=" +  authId);
        AgencyRelationType relationType = sendRequest(get, AgencyRelationType.class);

        // here we are using get query, for get all permissions with them id's
        // and check that, if we need parent/child or master/version and get it id.
        String roleId = (asType.matches("parent|child")) ?
                relationType.getListRoles().get(0).getRoleId() :
                relationType.getListRoles().get(1).getRoleId();

        JsonObject request = new JsonObject();
        JsonObject innerObject = new JsonObject();
        JsonArray listArray = new JsonArray();
        JsonObject relatedElements = new JsonObject();

        relatedElements.addProperty("documentId", childFileId);
        relatedElements.addProperty("relationRoleKey", relationType.getRelationRolesKeys(asType)[1]);
        relatedElements.addProperty("documentType", "element");
        listArray.add(innerObject);
        request.add("list", listArray);
        innerObject.add("related", relatedElements);
        innerObject.addProperty("relationTypeId", roleId);
        innerObject.addProperty("relationRoleKey", relationType.getRelationRolesKeys(asType)[0]);
        innerObject.addProperty("documentType", "element");

        HttpPost post = createPost(baseUrl + "filerelation/files/relations?with=permissions&id=" + parentFileId + "&$id$=" + authId, request.toString());
        sendRequest(post);
    }

    @Override
    public void deleteAssetFilterFromFolder(String folderId, String assetFilterId) {
        StringBuilder address = new StringBuilder(baseUrl);
        address.append("asset/filter/folder/").append(folderId);
        address.append("/content/").append(assetFilterId).append("?$id$=").append(authId);
        HttpDelete delete = new HttpDelete(address.toString());
        sendRequest(delete);
    }

    @Override
    public void addAssetToProjectFolder(String assetId, String parentId) {
        JsonObject request = new JsonObject();
        request.addProperty("parentId", parentId);
        HttpPut put = createPut(baseUrl + "asset/" + assetId + "/element/move?$id$=" + authId, request.toString());
        sendRequest(put);
    }

    //https://connect.adstream.com/display/ArC/Move+folder
    @Override
    public String moveFolder(List folderIds, String newParentId, boolean updateMetadata) {
        JsonObject request = new JsonObject();
        request.addProperty("newParentId", newParentId);
        request.add("fsObjects", gson.toJsonTree(folderIds));
        request.addProperty("updateMetadata", updateMetadata);
        HttpPut put = createPut(baseUrl + "project-content/move?$id$=" + authId, request.toString());
        Type returnType = new TypeToken<Map<String, String>>() {
        }.getType();
        Map<String, String> result = sendRequest(put, returnType);
        return result.get("processId");
    }

    //https://connect.adstream.com/display/ArC/Copy+folder
    @Override
    public String copyFolder(List folderIds, String newParentId, boolean updateMetadata) {
        JsonObject request = new JsonObject();
        request.addProperty("newParentId", newParentId);
        request.addProperty("updateMetadata", updateMetadata);
        request.add("fsObjects", gson.toJsonTree(folderIds));
        HttpPut put = createPut(baseUrl + "project-content/copy?$id$=" + authId, request.toString());
        Type returnType = new TypeToken<Map<String, String>>() {
        }.getType();
        Map<String, String> result = sendRequest(put, returnType);
        return result.get("processId");
    }

    @Override
    public Project getProject(String projectId) {
        return getProject(projectId, new With());
    }

    @Override
    public Project getProject(String projectId, With with) {
        HttpGet get = new HttpGet(baseUrl + "project/" + projectId + "?$id$=" + authId + with.toGetParams());
        return sendRequest(get, Project.class);
    }

    @Override
    public SearchResult<Project> findProjects(LuceneSearchingParams query) {
        HttpGet get = new HttpGet(baseUrl + "project/find?project_type=all&$id$=" + authId + query.toGetParams());
        Type returnType = new TypeToken<SearchResult<Project>>() {
        }.getType();
        return sendRequest(get, returnType);
    }

    @Override
    public SearchResult<Contact> getContacts(ContactSearchingParams query) {
        HttpGet get = new HttpGet(baseUrl + "contact?$id$=" + authId + query.toGetParams());
        Type returnType = new TypeToken<SearchResult<Contact>>() {
        }.getType();
        return sendRequest(get, returnType);
    }

    @Override
    public List<String> getTeamTemplates(ContactSearchingParams query) {
        SearchResult<Contact> contacts = getContacts(query);
        Set<String> results = new HashSet<>();
        for (Contact contact : contacts.getResult()) {
            if (contact.getGroups() != null) {
                results.addAll(contact.getGroups());
            }
        }
        return new ArrayList<>(results);
    }

    @Override
    public SearchResult<Project> findTemplates(LuceneSearchingParams query) {
        HttpGet get = new HttpGet(baseUrl + "project/template/find?project_type=all&$id$=" + authId + query.toGetParams());
        Type returnType = new TypeToken<SearchResult<Project>>() {
        }.getType();
        return sendRequest(get, returnType);
    }

    @Override
    public String createProjectFromTemplate(String projectId, String name, String[] mediaType, DateTime campaignStart, DateTime campaignEnd, boolean withFolders, boolean withTeam, boolean isPublished) {
        return cloneProject(projectId, "project", name, mediaType, campaignStart, campaignEnd, withFolders, withTeam, isPublished);
    }

    @Override
    public String createTemplateFromProject(String projectId, String name, String[] mediaType, DateTime campaignStart, DateTime campaignEnd, boolean withFolders, boolean withTeam) {
        return cloneProject(projectId, "project_template", name, mediaType, campaignStart, campaignEnd, withFolders, withTeam, false);
    }

    private String cloneProject(String projectId, String subtype, String name, String[] mediaType, DateTime campaignStart, DateTime campaignEnd, boolean withFolders, boolean withTeam, boolean isPublished) {
        Map<String, DateTime> campaignDates = new HashMap<String, DateTime>();
        campaignDates.put("start", campaignStart);
        campaignDates.put("end", campaignEnd);

        JsonObject common = new JsonObject();
        common.add("campaignDates", gson.toJsonTree(campaignDates));
        common.add("projectMediaType", gson.toJsonTree(mediaType));
        common.addProperty("name", name);
        if (!subtype.endsWith("project_template")) common.addProperty("published", isPublished);

        JsonObject cm = new JsonObject();
        cm.add("common", common);

        JsonObject query = new JsonObject();
        query.add("_cm", cm);
        query.addProperty("cloneFolders", withFolders);
        query.addProperty("cloneTeam", withTeam);
        query.addProperty("_subtype", subtype);

        HttpPost post = createPost(baseUrl + "/project/clone/" + projectId + "?with=permissions&$id$=" + authId, query.toString());
        CustomMetadata result = sendRequest(post, CustomMetadata.class);

        return result.getString("processId");
    }

    @Override
    public Project createProject(Project project) {
        HttpPost post = createPost(baseUrl + "project?$id$=" + authId, gson.toJson(project));
        return sendRequest(post, Project.class);
    }

    @Override
    public Project createProject(String agencyId, Project project) {
        StringBuilder address = new StringBuilder(baseUrl);
        address.append("project?$id$=").append(authId).append("&$agencyId$=id_").append(agencyId);
        HttpPost post = createPost(address.toString(), gson.toJson(project));
        return sendRequest(post, Project.class);
    }

    @Override
    public void createXMPMapping(String agencyId, List<XMPMapping> xmpMapping) {
        HttpPost post = createPost(baseUrl + "mapping/exif/" + agencyId + "?$id$=id-4ef31ce1766ec96769b399c0", gson.toJson(xmpMapping));
        sendRequest(post);
    }

    @Override
    public Project updateProject(String projectId, Project newProject) {
        HttpPut put = createPut(baseUrl + "project/" + projectId + "?$id$=" + authId, gson.toJson(newProject));
        return sendRequest(put, Project.class);
    }

    @Override
    public Project publishProject(String projectId, boolean publish, Boolean noEmail) {
        HttpPut put = createPut(baseUrl + "project/" + projectId + "/publish?$id$=" + authId + "&noemail=" + noEmail, "{\"published\":" + publish + "}");
        return sendRequest(put, Project.class);
    }

    @Override
    public void deleteProject(String projectId) {
        HttpDelete delete = new HttpDelete(baseUrl + "project/" + projectId + "?$id$=" + authId);
        sendRequest(delete);
    }

    @Override
    public void restoreProject(String projectId) {
        HttpPut put = createPut(baseUrl + "project/" + projectId + "/restore?$id$=" + authId, "");
        sendRequest(put);
    }

    @Override
    public Content getContent(String contentId) {
        HttpGet get = new HttpGet(baseUrl + "project/content/" + contentId + "?$id$=" + authId);
        return sendRequest(get, Content.class);
    }

    @Deprecated
    @Override
    public SearchResult<Content> findContent(String projectId, LuceneSearchingParams query) {
        StringBuilder address = new StringBuilder(baseUrl);
        address.append("project/").append(projectId);
        address.append("/content/find?$id$=").append(authId);
        address.append(query.toGetParams());
        HttpGet get = new HttpGet(address.toString());
        Type returnType = new TypeToken<SearchResult<Content>>() {
        }.getType();
        return sendRequest(get, returnType);
    }

    @Override
    public SearchResult<Content> findContentAllProjects(LuceneSearchingParams query) {
        StringBuilder address = new StringBuilder(baseUrl);
        address.append("project/content/find?$id$=").append(authId);
        address.append(query.toGetParams());
        HttpGet get = new HttpGet(address.toString());
        Type returnType = new TypeToken<SearchResult<Content>>() {
        }.getType();
        return sendRequest(get, returnType);


    }

    @Override
    public SearchResult<Content> findFoldersContent(String folderId, LuceneSearchingParams query) {
        StringBuilder address = new StringBuilder(baseUrl);
        address.append("project/content/").append(folderId);
        address.append("/find?with=permissions&$id$=").append(authId);
        address.append(query.toGetParams());
        HttpGet get = new HttpGet(address.toString());
        Type returnType = new TypeToken<SearchResult<Content>>() {
        }.getType();
        return sendRequest(get, returnType);
    }

    @Override
    public SearchResult<Content> findClientFoldersContent(String folderId, String userId,LuceneSearchingParams query) {
        StringBuilder address = new StringBuilder(baseUrl);
        address.append("project/content/").append(folderId);
        address.append("/find?with=permissions&$id$=").append("id-" + userId);
        address.append(query.toGetParams());
        HttpGet get = new HttpGet(address.toString());
        Type returnType = new TypeToken<SearchResult<Content>>() {
        }.getType();
        return sendRequest(get, returnType);
    }

    @Override
    public Content createContent(String parentId, Content content) {
        JsonObject common = new JsonObject();
        common.addProperty("name", content.getName());

        JsonObject cm = new JsonObject();
        cm.add("common", common);

        JsonObject request = new JsonObject();
        request.add("_cm", cm);
        request.addProperty("_subtype", content.getSubtype());
        if (content.getSubtype().equals("element")) {
            request.addProperty("tmp-path", content.getTmpPath());
        }

        HttpPost post = createPost(baseUrl + "project/content/" + parentId + "?$id$=" + authId, request.toString());
        return sendRequest(post, Content.class);
    }

    @Override
    public GDNFileRegister registerGDNContent(String parentId, List<GDNFileWrapper> gdnFiles) {
        JsonArray array = new JsonArray();
        for (GDNFileWrapper gdnFile : gdnFiles) {
            JsonObject regInfo = new JsonObject();
            regInfo.addProperty("externalID", gdnFile.getExternalId());
            regInfo.addProperty("fileName", gdnFile.getName());
            regInfo.addProperty("size", gdnFile.getSize());
            array.add(regInfo);
        }
        JsonObject request = new JsonObject();
        request.add("files", array);

        HttpPost post = createPost(baseUrl + "project/content/" + parentId + "/register?$id$=" + authId, request.toString());
        return sendRequest(post, GDNFileRegister.class);
    }

    @Override
    public Content createContentGDN(String parentId, Content content, String gdnFileId) {
        JsonObject request = new JsonObject();
        request.add("_cm", gson.toJsonTree(content.getCm()));
        request.addProperty("_subtype", content.getSubtype());
        if (content.getMultiPartUploadCompleteData() != null) {
            request.add("multiPartUploadCompleteData", gson.toJsonTree(content.getMultiPartUploadCompleteData()));}
        HttpPost post = createPost(baseUrl + "project/content/" + parentId + "/uplcomplete/" + gdnFileId + "?$id$=" + authId, request.toString());
        return sendRequest(post, Content.class);
    }

    @Override
    public Content createClientContentGDN(String parentId, Content content, String gdnFileId,String userId) {
        JsonObject request = new JsonObject();
        request.add("_cm", gson.toJsonTree(content.getCm()));
        request.addProperty("_subtype", content.getSubtype());

        HttpPost post = createPost(baseUrl + "project/content/" + parentId + "/uplcomplete/" + gdnFileId + "?$id$=" + "id-" + userId, request.toString());
        return sendRequest(post, Content.class);
    }


    @Override
    public Content createRevision(String elementId, Content content) {
        JsonObject request = new JsonObject();
        request.addProperty("tmp-path", content.getTmpPath());
        request.addProperty("guise", "master");

        HttpPost post = createPost(baseUrl + "project/content/element/" + elementId + "/file?$id$=" + authId, request.toString());
        return sendRequest(post, Content.class);

    }

    @Override
    public Content createClientRevision(String elementId, Content content,String userId) {
        JsonObject request = new JsonObject();
        request.addProperty("tmp-path", content.getTmpPath());
        request.addProperty("guise", "master");

        HttpPost post = createPost(baseUrl + "project/content/element/" + elementId + "/file?$id$=" + "id-" + userId, request.toString());
        return sendRequest(post, Content.class);

    }

    public Content createAttachedFile(Content originalFile, AttachedFile attachedFile) {
        JsonArray list = new JsonArray();
        list.add(new JsonObjectBuilder()
                .add("file", gson.toJsonTree(attachedFile))
                .add("subtype", "misc")
                .forNode("reference")
                .add("id", originalFile.getId())
                .add("ref", originalFile.getDocumentType())
                .build());

        JsonObject request = new JsonObjectBuilder()
                .add("list", list)
                .build();

        HttpPost post = createPost(baseUrl + "attached-files?$id$=" + authId, request.toString());
        return sendRequest(post, Content.class);
    }

    @Override
    public int getFilesCount(String projectId, String folderId) {
        StringBuilder address = new StringBuilder(baseUrl);
        address.append("project/content/").append(folderId);
        address.append("/file/count?$id$=").append(authId);
        HttpGet get = new HttpGet(address.toString());
        Type returnType = new TypeToken<Map<String, Integer>>() {
        }.getType();
        Map<String, Integer> result = sendRequest(get, returnType);
        return result.get("count");
    }

    @Override
    public Content updateAsset(Content content) {
        HttpPut put = createPut(baseUrl + "asset/" + content.getId() + "?$id$=" + authId, gson.toJson(content));
        return sendRequest(put, Content.class);
    }

    public Content patchAsset(String assetId, String campaign) {
        String jsonbody = "{\"_cm\":{\"common\":{\"Campaign\":\"" + campaign + "\"}}}";
        HttpPatch patch = createPatch(baseUrl + "asset/" + assetId + "?$id$=" + authId, jsonbody);
        return sendRequest(patch, Content.class);
    }

    @Override
    public GDNFileRegister registerGDNAssets(List<GDNFileWrapper> files) {
        JsonArray array = new JsonArray();
        for (GDNFileWrapper gdnFileWrapper : files) {
            JsonObject regInfo = new JsonObject();
            regInfo.addProperty("externalID", gdnFileWrapper.getExternalId());
            regInfo.addProperty("fileName", gdnFileWrapper.getName());
            regInfo.addProperty("size", gdnFileWrapper.getSize());
            if (gdnFileWrapper.getAgencyId()!= null && !gdnFileWrapper.getAgencyId().isEmpty())
                regInfo.addProperty("agencyId", gdnFileWrapper.getAgencyId());
            array.add(regInfo);
        }
        JsonObject request = new JsonObject();
        request.add("files", array);
        HttpPost post = createPost(baseUrl + "asset/register?$id$=" + authId, request.toString());
        return sendRequest(post, GDNFileRegister.class);
    }

    @Override
    public JobResponse gdnIngestRegister(Job job) {
        HttpPost post = createPost(baseUrl + "asset/ingest/gdn/register", GDNJobSerializer.serializeJob(job));
        String response = sendRequest(post);
        return GDNJobSerializer.deserializeJobResponse(response);
    }

    @Override
    public IngestDoc getIngestID(String assetID) {
        String temp = "{terms:{\"asset._id\":[\""+ assetID + "\"]}}";
        String encode = null;
        try {
            encode = URLEncoder.encode(temp, "UTF-8");
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        StringBuilder address = new StringBuilder(baseUrl);
        address.append("asset/ingest/find?query=").append(encode);
        HttpGet get = new HttpGet(address.toString());
        AssetIngestResult assetIngestResult = sendRequest(get, AssetIngestResult.class);
        return !assetIngestResult.getList().isEmpty() ? assetIngestResult.getList().get(0) : null;
    }

    @Override
    public void setRevision(IngestDoc ingestdoc, String ingestID, long size, String fileId, String assetId ){
        ingestdoc.getAsset().getRevision().setDuration(duration());
        ingestdoc.getAsset().getRevision().setAudioTracks(audioTracks().toArray(new java.util.HashMap[0]));
        ingestdoc.getAsset().getRevision().setFileSize(size);
        ingestdoc.getAsset().getRevision().setName(assetId + ".zip");
        ingestdoc.getAsset().getRevision().setMD5("389A2F05C0F15B408BC80BFD4E872B69");
        ingestdoc.getAsset().getRevision().setFileID(fileId);
        ingestdoc.setStatus("TVC Ingested OK");
        Gson gson = new Gson();
        String jsonInString = gson.toJson(ingestdoc);
        HttpPut put = createPut(baseUrl + "asset/ingest/" + ingestID, jsonInString);
        sendRequest(put);

    }
    public IngestDuration duration(){
        IngestDuration duration = new IngestDuration();
        duration.setAdDurationInFrames(375);
        duration.setFullDurationInFrames(500);
        duration.setFirstActiveFrame(25);
        return duration;
    }

    public List<Map<String, String>> audioTracks(){
        java.util.List<Map<String, String>> audioTracksArray = new java.util.ArrayList<>();
        Map<String, String> audioTrack1 = new java.util.HashMap<>();
        audioTrack1.put("specId", "f1:audio:track:channel:StereoLeft");
        audioTrack1.put("langId", "en");
        audioTracksArray.add(audioTrack1);
        Map<String, String> audioTrack2 = new java.util.HashMap<>();
        audioTrack2.put("specId", "f1:audio:track:channel:StereoRight");
        audioTrack2.put("langId", "en");
        audioTracksArray.add(audioTrack2);
        return audioTracksArray;
    }

    @Override
    public Content createAssetGDN(Content content, String gdnFileId) {
        return createAssetGDN(content, gdnFileId, "");
    }

    @Override
    public Content createAssetGDN(Content content, String gdnFileId, String agencyId) {
        JsonObject request = new JsonObject();
        request.add("_cm", gson.toJsonTree(content.getCm()));
        if (content.getMultiPartUploadCompleteData() != null){
        request.add("multiPartUploadCompleteData",gson.toJsonTree(content.getMultiPartUploadCompleteData()));}
        String url = baseUrl + "asset/uplcomplete/" + gdnFileId + "?$id$=" + authId;
        if (!agencyId.isEmpty())
            url+= "&$agencyId$=id-" + agencyId;
        HttpPost post = createPost(url, request.toString());
        return sendRequest(post, Content.class);

    }

    @Override
    public AmazonContent createfilePart(String gdnFileId,String storageId) {
        String request = "{\"storageId\": \""+storageId+"\",\"capabilities\": [\"http-upload\"]," +
                "\"filePartNumber\": 1 }";
        String url = baseUrl + "fs/upload/" + gdnFileId +  "/filePartUrl?$id$=" + authId;
        HttpPost post = createPost(url, request);
        return sendRequest(post, AmazonContent.class);

    }

    @Override
    public void multipartIngestComplete(String gdnFileId,MultiPartUploadCompleteData multiPartUploadCompleteData) {
        String request = "{\"storageId\": \""+multiPartUploadCompleteData.getStorageId()+"\"," +
                "\"uploadId\": \""+multiPartUploadCompleteData.getUploadId()+"\"," +
                "\"eTags\":[\""+ multiPartUploadCompleteData.geteTags()[0]+ "\"] }";
        String url = baseUrl + "fs/upload/" + gdnFileId +  "/multipartcomplete?$id$=" + authId;
        HttpPost post = createPost(url,request );
        sendRequest(post);
    }


    @Override
    public void deleteAsset(String assetId) {
        HttpDelete delete = new HttpDelete(baseUrl + "asset/" + assetId + "?$id$=" + authId);
        sendRequest(delete);
    }

    @Override
    public Content moveFileIntoLibrary(Content content) {
        JsonObject request = new JsonObject();
        request.add("_cm", gson.toJsonTree(content.getCm()));
        request.addProperty("element", content.getId());
        HttpPost post = createPost(baseUrl + "asset/easy?$id$=" + authId, request.toString());
        return sendRequest(post, Content.class);
    }

    public Content createAssetWithoutTranscoding(Content content) {
        HttpPost post = createPost(baseUrl + "asset/trascodeless?$id$=" + authId, gson.toJson(content));
        return sendRequest(post, Content.class);
    }

    @Override
    public Content updateContent(String contentId, Content newContent) {
        HttpPut put = createPut(baseUrl + "project/content/" + contentId + "?$id$=" + authId, gson.toJson(newContent));
        return sendRequest(put, Content.class);
    }

    @Override
    public String moveContent(String[] contentId, String toFolderId) {
        JsonObject request = new JsonObjectBuilder()
                .add("newParentId", toFolderId)
                .addArray("fsObjects", contentId)
                .add("updateMetadata", true)
                .build();
        HttpPut put = createPut(baseUrl + "project-content/move?$id$=" + authId, request.toString());
        String response = sendRequest(put);
        return new JsonParser().parse(response).getAsJsonObject().getAsJsonPrimitive("processId").getAsString();
    }

    @Override
    public void copyContent(String[] contentId, String toFolderId) {
        JsonObject request = new JsonObjectBuilder()
                .add("newParentId", toFolderId)
                .addArray("fsObjects", contentId)
                .add("updateMetadata", false)
                .build();
        HttpPut put = createPut(baseUrl + "project-content/copy?$id$=" + authId, request.toString());
        sendRequest(put);
    }

    @Override
    public void deleteContent(String contentId) {
        HttpDelete delete = new HttpDelete(baseUrl + "project/content/" + contentId + "?$id$=" + authId);
        sendRequest(delete);
    }

    @Override
    public SearchResult<Content> findTrashBinFiles(String projectId) {
        StringBuilder address = new StringBuilder(baseUrl);
        address.append("project/").append(projectId);
        address.append("/trash/files?$id$=").append(authId);
        HttpGet get = new HttpGet(address.toString());
        Type returnType = new TypeToken<SearchResult<Content>>() {
        }.getType();
        return sendRequest(get, returnType);
    }

    @Override
    public SearchResult<Content> findTrashBinFolders(String projectId) {
        StringBuilder address = new StringBuilder(baseUrl);
        address.append("project/").append(projectId);
        address.append("/trash/folders?$id$=").append(authId);
        HttpGet get = new HttpGet(address.toString());
        Type returnType = new TypeToken<SearchResult<Content>>() {
        }.getType();
        return sendRequest(get, returnType);
    }

    @Override
    public SearchResult<Content> findTrashBinFoldersContent(String folderId, LuceneSearchingParams query) {
        StringBuilder address = new StringBuilder(baseUrl);
        address.append("project/content/").append(folderId);
        address.append("/trash?with=permissions&$id$=").append(authId);
        address.append(query.toGetParams());
        HttpGet get = new HttpGet(address.toString());
        Type returnType = new TypeToken<SearchResult<Content>>() {
        }.getType();
        return sendRequest(get, returnType);
    }

    @Override
    public SearchResult<User> getTeamUsers(String projectId, boolean children) {
        StringBuilder address = new StringBuilder(baseUrl);
        address.append("project/").append(projectId);
        address.append("/team?children=").append(children);
        address.append("&$id$=").append(authId);
        HttpGet get = new HttpGet(address.toString());
        Type returnType = new TypeToken<SearchResult<Object>>() {
        }.getType();
        // temporary solution (dog-nail)
        SearchResult<Object> o = sendRequest(get, returnType);
        List<User> users = new ArrayList<User>();
        for (int i = 0; i < o.getResult().size(); i++) {
            Map<String, Object> mapObj = (Map<String, Object>) o.getResult().get(i);
            User user = new User();
            user.setId((String) mapObj.get("user"));
            user.setEmail((String) mapObj.get("email"));
            user.setFirstName((String) mapObj.get("firstName"));
            user.setLastName((String) mapObj.get("lastName"));
            Agency agency = new Agency();
            Map<String, Object> agencyObj = (Map<String, Object>) mapObj.get("agency");
            agency.setId((String)agencyObj.get("_id"));
            agency.setName((String)agencyObj.get("name"));
            user.setAgency(agency);
            users.add(user);
        }
        SearchResult<User> result = new SearchResult<User>();
        result.setResult(users);
        return result;
    }

    @Override
    public SearchResult<User> addUserToProjectTeam(TeamPermission[] permissions) {
        JsonObject request = new JsonObject();
        request.add("permissions", gson.toJsonTree(permissions));
        HttpPut put = createPut(baseUrl + "project/team" + "?$id$=" + authId, request.toString());
        Type returnType = new TypeToken<SearchResult<User>>() {
        }.getType();
        return sendRequest(put, returnType);
    }

    @Override
    public SearchResult<User> addUserToProjectTeam(String projectId, TeamPermission[] permissions) {
        return addUserToProjectTeam(permissions);
    }

    @Override
    public void removeUserFromProjectTeam(String projectId, String userId) {
        String address = baseUrl + "project/" + projectId + "/team?$id$=" + authId;
        JsonObject query = new JsonObjectBuilder()
                .addArray("users", new String[] {userId})
                .build();
        sendRequest(createPut(address, query.toString()));
    }

    @Override
    public void allowUserToViewPublicTemplates(String agencyId, String userId, boolean allow) {
        StringBuilder address = new StringBuilder(baseUrl);
        address.append("project/public/agency/").append(agencyId).append("/").append(allow ? "add" : "delete");
        address.append("?$id$=").append(authId);

        JsonArray users = new JsonArray();
        users.add(new JsonPrimitive(userId));

        JsonObject request = new JsonObject();
        request.add("userIds", users);

        HttpPost post = createPost(address.toString(), request.toString());
        sendRequest(post);
    }

    @Override
    public String batchUpdateElementsMetadata(String agencyId, String projectId, CustomMetadata metadata) {
        JsonObject metadataObj = new JsonObjectBuilder()
                .add("metadata", gson.toJsonTree(metadata))
                .add("agencyId", agencyId)
                .forNode("mediaSubTypes")
                .add("list", new JsonArray())
                .build();
        JsonObject query = new JsonObjectBuilder()
                .add("projectId", projectId)
                .addArray("list", metadataObj)
                .build();
        HttpPut put = createPut(baseUrl + "project/" + projectId + "/element/bulk?$id$=" + authId, query.toString());
        String response = sendRequest(put);
        return new JsonParser().parse(response).getAsJsonObject().getAsJsonPrimitive("processId").getAsString();
    }

    @Override
    public Role getRole(String roleId) {
        HttpGet get = new HttpGet(baseUrl + "role/" + roleId + "?$id$=" + authId);
        return sendRequest(get, Role.class);
    }

    @Override
    public SearchResult<Role> findRoles(LuceneSearchingParams query) {
        HttpGet get = new HttpGet(baseUrl + "role/find" + "?$id$=" + authId + query.toGetParams());
        Type returnType = new TypeToken<SearchResult<Role>>() {
        }.getType();
        return sendRequest(get, returnType);
    }

    @Override
    public Role createRole(String agencyId, Role role) {
        JsonObject common = new JsonObject();
        common.addProperty("name", role.getName());
        common.add("allow", gson.toJsonTree(role.getAllow()));
        common.add("deny", gson.toJsonTree(role.getDeny()));

        JsonObject cm = new JsonObject();
        cm.add("common", common);

        JsonObject request = new JsonObject();
        request.addProperty("group", role.getGroup());
        request.add("_cm", cm);
        HttpPost post = createPost(baseUrl + "role/" + agencyId + "?$id$=" + authId, request.toString());
        return sendRequest(post, Role.class);
    }

    @Override
    public Role updateRole(Role role) {
        HttpPut put = createPut(baseUrl + "role/" + role.getId() + "?$id$=" + authId, gson.toJson(role));
        return sendRequest(put, Role.class);
    }

    @Override
    public void deleteRole(String roleId) {
        HttpDelete delete = new HttpDelete(baseUrl + "role/" + roleId + "?$id$=" + authId);
        sendRequest(delete);
    }

    @Override
    public void createAcl(String roleId, Acl acl) {
        HttpPost post = createPost(baseUrl + "role/" + roleId + "/acl" + "?$id$=" + authId, gson.toJson(acl));
        sendRequest(post);
    }

    @Override
    public SearchResult<User> getAclSubjects(String roleId, String objectId) {
        StringBuilder address = new StringBuilder(baseUrl);
        address.append("role/").append(roleId);
        address.append("/acl/subjects?object=").append(objectId);
        address.append("&$id$=").append(authId);
        HttpGet get = new HttpGet(address.toString());
        Type returnType = new TypeToken<SearchResult<User>>() {
        }.getType();
        return sendRequest(get, returnType);
    }

    @Override
    public void deleteAcl(String roleId, String objectId, String subjectId) {
        StringBuilder address = new StringBuilder(baseUrl);
        address.append("role/").append(roleId);
        address.append("/acl/objects/").append(objectId);
        address.append("/subjects/").append(subjectId);
        address.append("?$id$=").append(authId);
        HttpDelete delete = new HttpDelete(address.toString());
        sendRequest(delete);
    }

    @Override
    public void hideRole(String roleId, boolean hide) {
        StringBuilder address = new StringBuilder(baseUrl);
        address.append("role/").append(roleId).append("/hide?hide=").append(hide).append("&$id$=").append(authId);
        HttpPut put = createPut(address.toString(), "");
        sendRequest(put);
    }

    @Override
    public SearchResult<FileStorage> getGdnStorages() {
        HttpGet get = new HttpGet(baseUrl + "fs/gdn/storages?$id$=" + authId);
        Type returnType = new TypeToken<SearchResult<FileStorage>>() {
        }.getType();
        return sendRequest(get, returnType);
    }

    @Override
    public FileStorage getGdnStorageForAgency(String agencyId) {
        HttpGet get = new HttpGet(baseUrl + "/agency/" + agencyId + "/fs?$id$=" + authId);
        return sendRequest(get, FileStorage.class);
    }

    @Override
    public FileStorage getGdnStorageForFolder(String folderId) {
        HttpGet get = new HttpGet(baseUrl + "/folder/" + folderId + "/fs?$id$=" + authId);
        return sendRequest(get, FileStorage.class);
    }

    @Override
    public String getDownloadUrl(String fileId, String externalFileId, String saveAsFileName) {
        Map<String, String> result = getDownloadInfo(fileId, externalFileId, saveAsFileName);
        return result.get("url");
    }

    @Override
    public Map<String, String> getDownloadInfo(String fileId, String externalFileId, String saveAsFileName) {
        StringBuilder address = new StringBuilder(baseUrl);
        address.append("fs/gdn/url/").append(fileId);
        address.append("/").append(externalFileId).append("?");
        address.append("saveAs=").append(Common.urlEncode(saveAsFileName));
        address.append("&$id$=").append(authId);
        HttpGet get = new HttpGet(address.toString());
        Type returnType = new TypeToken<Map<String, String>>() {
        }.getType();
        return sendRequest(get, returnType);
    }

    @Override
    public GlobalSearchResult globalSearch(LuceneSearchingParams query) {
        StringBuilder address = new StringBuilder(baseUrl);
        address.append("search").append("?$id$=").append(authId).append(query.toGetParams());
        HttpGet get = new HttpGet(address.toString());
        return sendRequest(get, GlobalSearchResult.class);
    }

    @Override
    public Contact addContact(String email) {
        JsonObject request = new JsonObject();
        request.addProperty("email", email);
        HttpPost post = createPost(baseUrl + "contact?$id$=" + authId, request.toString());
        return sendRequest(post, Contact.class);
    }

    @Override
    public Contact addContactToGroup(String email, String... groupName) {
        JsonObject request = new JsonObjectBuilder()
                .add("email", email)
                .addArray("groups", groupName)
                .build();
        HttpPost post = createPost(baseUrl + "contact?$id$=" + authId, request.toString());
        return sendRequest(post, Contact.class);
    }

    @Override
    public Contact getContact(String email) {
        HttpGet get = new HttpGet(baseUrl + "contact/find?email=" + email.replace("+", "%2B") + "&$id$=" + authId);
        Type returnType = new TypeToken<SearchResult<Contact>>() {
        }.getType();
        SearchResult<Contact> result = sendRequest(get, returnType);
        return result.getResult().size() > 0 ? result.getResult().get(0) : null;
    }

    @Override
    public void deleteContact(String contactId) {
        HttpDelete delete = new HttpDelete(baseUrl + "/contact/" + contactId + "?$id$=" + authId);
        sendRequest(delete);
    }

    @Override
    public int getNotificationsCount(boolean isHasReadNotification) {
        StringBuilder address = new StringBuilder(baseUrl);
        address.append("activity/notification/count?").append("hasRead=").append(isHasReadNotification).append("&$id$=").append(authId);
        HttpGet get = new HttpGet(address.toString());
        Type returnType = new TypeToken<Map<String, Integer>>() {
        }.getType();
        Map<String, Integer> result = sendRequest(get, returnType);
        return result.get("count");
    }

    @Override
    public SearchResult<Notification> findNotifications(boolean isHasReadNotification, LuceneSearchingParams query) {
        StringBuilder address = new StringBuilder(baseUrl);
        address.append("activity/notification?").append("hasRead=").append(isHasReadNotification).append("&$id$=").append(authId);
        address.append(query.toGetParams());
        HttpGet get = new HttpGet(address.toString());
        Type returnType = new TypeToken<SearchResult<Notification>>() {
        }.getType();
        return sendRequest(get, returnType);
    }

    @Override
    public Comment createComment(String text, String objectId, String objectType, long objectRevision, String answerTo) {
        JsonObject request = new JsonObjectBuilder()
                .add("with", "permissions")
                .add("text", text)
                .add("objRevision", objectRevision)
                .add("answerTo", answerTo)
                .add("subjects", new JsonArray())
                .forNode("objRef")
                .add("$id", objectId)
                .add("$ref", objectType)
                .build();
        HttpPost post = createPost(baseUrl + "comment?$id$=" + authId, request.toString());
        return sendRequest(post, Comment.class);
    }

    @Override
    public SearchResult<Comment> findComments(String fileId, int objRevision) {
        StringBuilder address = new StringBuilder(baseUrl);
        address.append("comment/find?$id$=").append(authId);
        address.append("&objId=").append(fileId);
        address.append("&objType=fsobject");
        address.append("&objRevision=").append(objRevision);
        HttpGet get = new HttpGet(address.toString());
        Type type = new TypeToken<SearchResult<Comment>>() {
        }.getType();
        return sendRequest(get, type);
    }

    @Override
    public SearchResult<Reel> findReels(LuceneSearchingParams query) {
        StringBuilder address = new StringBuilder(baseUrl);
        address.append("presentation/find?$id$=").append(authId).append(query.toGetParams());
        HttpGet get = new HttpGet(address.toString());
        Type type = new TypeToken<SearchResult<Reel>>() {
        }.getType();
        return sendRequest(get, type);
    }

    @Override
    public boolean sharePresentationToUsers(String presentationId, List<String> userIds, String personalMessage) {
        String address = String.format("%spresentation/share?$id$=%s", baseUrl, authId);

        JsonObject permissions = new JsonObjectBuilder()
                .add("allowDownloadProxy", false)
                .add("allowDownloadMaster", false)
                .build();

        JsonObject shareContext = new JsonObjectBuilder()
                .add("permissions", permissions)
                .addArray("toUsers", userIds.toArray(new String[userIds.size()]))
                .add("personalMessage", personalMessage)
                .build();

        JsonObject lastPost = new JsonObjectBuilder()
                .addArray("documents", presentationId)
                .add("shareContext", shareContext)
                .build();

        HttpPost post = createPost(address, lastPost.toString());
        String response = sendRequest(post);
        JsonObject responseObj = new JsonParser().parse(response).getAsJsonObject();
        return responseObj.getAsJsonPrimitive("result").getAsString().equals("ok");
    }

    @Override
    public Reel getReel(String reelId, boolean withPermissions) {
        StringBuilder address = new StringBuilder(baseUrl);
        address.append("presentation/").append(reelId).append("?$id$=").append(authId);
        if (withPermissions) {
            address.append("&with=permissions");
        }
        HttpGet get = new HttpGet(address.toString());
        return sendRequest(get, Reel.class);
    }

    @Override
    public Reel updateReel(Reel reel) {
        HttpPut put = createPut(baseUrl + "presentation/" + reel.getId() + "?$id$=" + authId, gson.toJson(reel));
        return sendRequest(put, Reel.class);
    }

    @Override
    public void deleteReel(String reelId) {
        HttpDelete delete = new HttpDelete(baseUrl + "presentation/" + reelId + "?$id$=" + authId);
        sendRequest(delete);
    }

    @Override
    public Reel createReel(Reel reel) {
        JsonObject common = new JsonObject();
        common.addProperty("name", reel.getName());
        common.addProperty("description", reel.getDescription() != null ? reel.getDescription() : "");

        JsonObject view = new JsonObject();
        view.addProperty("style", "dark");
        view.addProperty("screen", "slider");
        view.addProperty("thumbnails", "roller");

        JsonObject cm = new JsonObject();
        cm.add("common", common);
        cm.add("view", view);

        JsonObject request = new JsonObject();
        request.add("assets", new JsonObject());
        request.add("_cm", cm);

        HttpPost post = createPost(baseUrl + "presentation?$id$=" + authId, request.toString());
        return sendRequest(post, Reel.class);
    }

    @Override
    public AgencyProjectTeam createAgencyTeam(AgencyProjectTeam agencyProjectTeam) {
        JsonObject common = new JsonObject();
        common.addProperty("name", agencyProjectTeam.getName());
        common.add("members", gson.toJsonTree(agencyProjectTeam.getMembers()));

        JsonObject cm = new JsonObject();
        cm.add("common", common);

        JsonObject request = new JsonObject();
        request.add("_cm", cm);

        HttpPost post = createPost(baseUrl + "agency/team?$id$=" + authId, request.toString());
        return sendRequest(post, AgencyProjectTeam.class);
    }

    @Override
    public void addObjectToAgencyProjectTeam(String agencyTeamId, String objectId) {
        JsonObject request = new JsonObject();
        request.addProperty("fsObjectId", objectId);
        HttpPost post = createPost(baseUrl + "agency/team/" + agencyTeamId + "/apply?$id$=" + authId, request.toString());
        sendRequest(post);
    }

    @Override
    public SearchResult<AgencyProjectTeam> findAgencyProjectTeams(LuceneSearchingParams query) {
        StringBuilder address = new StringBuilder(baseUrl);
        address.append("agency/team/find?$id$=").append(authId).append(query.toGetParams());
        HttpGet get = new HttpGet(address.toString());
        Type type = new TypeToken<SearchResult<AgencyProjectTeam>>() {
        }.getType();
        return sendRequest(get, type);
    }

    @Override
    public void deleteAgencyProjectTeam(String teamId) {
        HttpDelete delete = new HttpDelete(baseUrl + "agency/team/" + teamId + "?$id$=" + authId);
        sendRequest(delete);
    }

    @Override
    public void addUsageRights(String objectId, List<UsageRight> listUR) {
        StringBuilder address = new StringBuilder(baseUrl);
        address.append("usage_rights/").append(objectId).append("?$id$=").append(authId);
        JsonObject request0 = new JsonObject();
        JsonObject request = new JsonObject();
        JsonArray array = new JsonArray();
        for (UsageRight usageRight : listUR) {
            if (usageRight instanceof GeneralUsageRight) {
                JsonElement value = gson.toJsonTree(((GeneralUsageRight) usageRight).getGeneral());
                request.add("General", value);
                value = gson.toJsonTree(((GeneralUsageRight) usageRight).getExpiration());
                request.add("expiration", value);
                array.add(gson.toJsonTree(request));
            }
            if (usageRight instanceof CountriesUsageRight) {
                JsonElement value = gson.toJsonTree(((CountriesUsageRight) usageRight).getCountries());
                request.add("Countries", value);
                value = gson.toJsonTree(((CountriesUsageRight) usageRight).getExpiration());
                request.add("expiration", value);
                array.add(gson.toJsonTree(request));
            }
            if (usageRight instanceof MediaTypesUsageRight) {
                JsonElement value = gson.toJsonTree(((MediaTypesUsageRight) usageRight).getMediaTypes());
                request.add("Media Types", value);
                array.add(gson.toJsonTree(request));
            }
            if (usageRight instanceof VisualTalentUsageRight) {
                JsonElement value = gson.toJsonTree(((VisualTalentUsageRight) usageRight).getVisualTalent());
                request.add("Visual Talent", value);
                array.add(gson.toJsonTree(request));
            }
            if (usageRight instanceof VoiceOverArtistUsageRight) {
                JsonElement value = gson.toJsonTree(((VoiceOverArtistUsageRight) usageRight).getVoiceOverArtist());
                request.add("Voice-over Artist", value);
                value = gson.toJsonTree(((VoiceOverArtistUsageRight) usageRight).getExpiration());
                request.add("expiration", value);
                array.add(gson.toJsonTree(request));
            }
            if (usageRight instanceof MusicUsageRight) {
                JsonElement value = gson.toJsonTree(((MusicUsageRight) usageRight).getMusic());
                request.add("Music", value);
                request.add("expiration", value);
                array.add(gson.toJsonTree(request));
            }
            if (usageRight instanceof OtherUsageRight) {
                JsonElement value = gson.toJsonTree(((OtherUsageRight) usageRight).getOtherUsageRight());
                request.add("Other usage ", value);
                array.add(gson.toJsonTree(request));
            }
        }
        request0.add("usages", array);
        HttpPut put = createPut(address.toString(), request0.toString());
        sendRequest(put);
    }

    @Override
    public BaseUsageRight getUsageRight(String objectId) {
        HttpGet get = new HttpGet(baseUrl + "usage_rights/" + objectId + "?$id$=" + authId);
        return sendRequest(get, BaseUsageRight.class);
    }

    @Override
    public void deleteUsageRight(String objectId) {
        StringBuilder address = new StringBuilder(baseUrl);
        address.append("usage_rights/").append(objectId).append("?$id$=").append(authId);
        HttpDelete delete = new HttpDelete(address.toString());
        sendRequest(delete);
    }

    @Override
    public void shareFileOrAsset(String documentType, List<String> assetIds, List<String> userIds, Long expiration, String message, boolean createActivity, boolean allowView, boolean allowDownloadProxy, boolean allowDownloadMaster) {
        if (documentType.equals("element") || documentType.equals("asset")) {
            JsonObject request = new JsonObjectBuilder()
                    .addArray("documents", assetIds.toArray(new String[assetIds.size()]))
                    .forNode("shareContext")
                    .addArray("toUsers", userIds.toArray(new String[userIds.size()]))
                    .add("expiration", expiration)
                    .add("personalMessage", message)
                    .add("createActivity", createActivity)
                    .forNode("permissions")
                    .add("allowView", allowView)
                    .add("allowDownloadProxy", allowDownloadProxy)
                    .add("allowDownloadMaster", allowDownloadMaster)
                    .build();
            HttpPost post = createPost(baseUrl + "filesharing/" + documentType + "/share?$id$=" + authId, request.toString());
            sendRequest(post);
        } else {
            throw new IllegalArgumentException("Wrong document type. Can be element or asset.");
        }
    }

    @Override
    public PublicShare createPublicShare(String documentType, String documentId, Long expiration, String[] users, String[] roles) {
        JsonObject request = new JsonObject();
        request.addProperty("documentType", documentType);
        request.addProperty("documentId", documentId);
        if (expiration != null) {
            request.addProperty("expiration", expiration);
        }
        if (users != null) {
            request.add("toUsers", gson.toJsonTree(users));
        }
        if (roles != null) {
            request.add("roles", gson.toJsonTree(roles));
        }

        HttpPost post = createPost(baseUrl + "publicsharing?$id$=" + authId, request.toString());
        return sendRequest(post, PublicShare.class);
    }

    @Override
    public Integer getInboxCacheStatus() {
        HttpGet get = new HttpGet(baseUrl + "inbox/cache/status");
        Type returnType = new TypeToken<Map<String, Integer>>() {
        }.getType();
        Map<String, Integer> result = sendRequest(get, returnType);
        return result.get("pendingJobs");
    }

    @Override
    public Integer createInboxCache() {
        HttpPost post = new HttpPost(baseUrl + "inbox/cache");
        Type returnType = new TypeToken<Map<String, Integer>>() {
        }.getType();
        Map<String, Integer> result = sendRequest(post, returnType);
        return result.get("updated");
    }

    @Override
    public Boolean createInboxCache(String collectionId) {
        HttpPost post = new HttpPost(baseUrl + "inbox/cache/" + collectionId);
        Type returnType = new TypeToken<Map<String, Boolean>>() {
        }.getType();
        Map<String, Boolean> result = sendRequest(post, returnType);
        return result.get("ok");
    }

    @Override
    public BatchTaskApi batchTaskApi() {
        return new BatchTaskApi(baseUrl, authId);
    }

    @Override
    public SearchResult<Content> findAssetsInSharedCollection(String collectionId, LuceneSearchingParams query) {
        StringBuilder address = new StringBuilder(baseUrl);
        address.append("inbox/").append(collectionId).append("/assets?$id$=").append(authId).append(query.toGetParams());
        HttpGet get = new HttpGet(address.toString());
        Type returnType = new TypeToken<SearchResult<Content>>() {
        }.getType();
        return sendRequest(get, returnType);
    }

    @Override
    public SearchResult<InboxCategory> getInboxCategories(String agencyId) {
        HttpGet get = new HttpGet(baseUrl + "inbox/" + agencyId + "/categories?$id$=" + authId);
        Type returnType = new TypeToken<SearchResult<InboxCategory>>() {}.getType();
        return sendRequest(get, returnType);
    }

    // SchemasMap

    public SchemasMap findSchemasMap(String groupOne, String agencyIdOne, String groupTwo, String agencyIdTwo) {
        String url = String.format("%smaps/%s/%s/%s/%s?$id$=%s", baseUrl, groupOne, agencyIdOne, groupTwo, agencyIdTwo, authId);
        return sendRequest(new HttpGet(url), SchemasMap.class);
    }

    // Projects access rules

    @Override
    public CustomMetadata enableProjectsAccessRulesForAgency(String agencyId, int interval) {
        return null;
    }

    @Override
    public ProjectsAccessRule createProjectsAccessRule(ProjectsAccessRule projectsAccessRule) {
        String url = String.format("%sprojects_access_rule/agency/%s/user/%s?$id$=%s",
                baseUrl, projectsAccessRule.getAgencyId(), projectsAccessRule.getUserId(), authId);
        JsonObject request = new JsonObject();
        request.addProperty("expiration", projectsAccessRule.getExpiration());
        request.addProperty("roleId", projectsAccessRule.getRoleId());
        request.add("terms", gson.toJsonTree(projectsAccessRule.getTerms()));
        HttpPost post = createPost(url, request.toString());

        return sendRequest(post, ProjectsAccessRule.class);
    }

    @Override
    public ProjectsAccessRule getProjectsAccessRule(String agencyId, String userId) {
        String url = String.format("%sprojects_access_rule/agency/%s/user/%s?$id$=%s", baseUrl, agencyId, userId, authId);
        HttpGet get = new HttpGet(url);
        return sendRequest(get, ProjectsAccessRule.class);
    }

    @Override
    public ProjectsAccessRule getProjectsAccessRule(String projectsAccessRuleId) {
        String url = String.format("%sprojects_access_rule/%s?$id$=%s", baseUrl, projectsAccessRuleId, authId);
        HttpGet get = new HttpGet(url);
        return sendRequest(get, ProjectsAccessRule.class);
    }

    @Override
    public ProjectsAccessRule updateProjectsAccessRule(ProjectsAccessRule projectsAccessRule) {
        String url = String.format("%sprojects_access_rule/%s?$id$=%s", baseUrl, projectsAccessRule.getId(), authId);
        JsonObject request = new JsonObject();
        request.addProperty("expiration", projectsAccessRule.getExpiration());
        request.addProperty("roleId", projectsAccessRule.getRoleId());
        request.add("terms", gson.toJsonTree(projectsAccessRule.getTerms()));
        HttpPut put = createPut(url, request.toString());

        return sendRequest(put, ProjectsAccessRule.class);
    }

    @Override
    public ProjectsAccessRule deleteProjectsAccessRule(String projectsAccessRuleId) {
        String url = String.format("%sprojects_access_rule/%s/all?$id$=%s", baseUrl, projectsAccessRuleId, authId);
        HttpDelete delete = new HttpDelete(url);
        return sendRequest(delete, ProjectsAccessRule.class);
    }

    @Override
    public String updateAssetsBulkMetadata(List<String> assetsId, String agencyId, String advertiserValue){
        return "Not implemented yet";
    }

    @Override
    public String updateAssetsButchMetadata(List<ContentBatchUpdate> content) {
        String url = baseUrl + "asset/batch?$id$=" + authId;
        JsonObject request = new JsonObject();
        JsonArray list = new JsonArray();
        for (ContentBatchUpdate contentBatchUpdate: content) {
            JsonObject metadataObject = new JsonObject();
            JsonObject idObject = new JsonObject();
            metadataObject.add("_cm", gson.toJsonTree(contentBatchUpdate.getCm()));
            idObject.add("metadata", gson.toJsonTree(metadataObject));
            idObject.add("_id", gson.toJsonTree(contentBatchUpdate.get_id()));
            list.add(idObject);
        }
        request.add("list", list);
        HttpPut put = createPut(url, request.toString());
        return sendRequest(put);
    }

    @Override
    public String getProcessStatus(String processId, int depth) {
        return "Not implemented yet";
    }

    @Override
    public String getBatchProcessStatus(String processId) {
        HttpGet get = new HttpGet(baseUrl + "batch-task/tasks/" + processId +"?$id$=" + authId);
        return sendRequest(get);
    }

    // Migration A4 -> A5
    @Override
    public String executeMigrationA4toA5(MigrationA4toA5 migrationA4toA5) {
        String url = baseUrl + "/migration/a4?$id$=id-4ef31ce1766ec96769b399c0";
        HttpPost post = createPost(url, gson.toJson(migrationA4toA5).toString());
        return sendRequest(post);
    }

    /*
        ORDERING
    */

    @Override
    public Order createOrder(Order order) {
        JsonObject request = new JsonObject();
        request.addProperty("_subtype", order.getSubtype());
        request.add("_cm", gson.toJsonTree(order.getCm()));

        HttpPost post = createPost(baseUrl + "ordering?with=permissions&$id$=" + authId, request.toString());
        return sendRequest(post, Order.class);
    }

    @Override
    public Order updateOrder(Order order) {
        StringBuilder address = new StringBuilder(baseUrl);
        address.append("ordering/").append(order.getId()).append("?$id$=").append(authId);

        JsonObject request = new JsonObject();
        request.addProperty("_id", order.getId());
        request.addProperty("_subtype", order.getSubtype());
        request.add("_cm", gson.toJsonTree(order.getCm()));

        HttpPut put = createPut(address.toString(), request.toString());
        return sendRequest(put, Order.class);
    }

    @Override
    public Order getOrderById(String orderId, boolean withOrderItems) {
        StringBuilder address = new StringBuilder(baseUrl);
        address.append("ordering/").append(orderId).append("?items=").append(withOrderItems);
        address.append("&$id$=").append(authId);
        HttpGet get = new HttpGet(address.toString());
        return sendRequest(get, Order.class);
    }

    //notReady
    public Integer getOrderFromTrafficById(String orderId){
        return null;
    }

    public Integer getOrderFromTrafficById(String orderId,String qcAssetId){
        return null;
    }

    public String getDeliveryStatusFromA4(String orderReference){
        StringBuilder address = new StringBuilder(TestsContext.getInstance().a4host);
        address.append("/OrderingApplication/Order/").append(TestsContext.getInstance().a4DefaultUser + "/Status/").append(orderReference);
        HttpGet get = new HttpGet(address.toString());
        String responseBody =  sendRequest(get);
        String status = "";
        try {
            DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
            DocumentBuilder builder = factory.newDocumentBuilder();;
            InputSource is = new InputSource();
            is.setCharacterStream(new StringReader(responseBody));
            Document doc = builder.parse(is);
            NodeList nodes = doc.getElementsByTagName("StatusId");
            status= nodes.item(0).getTextContent();

        } catch (ParserConfigurationException e) {
            e.printStackTrace();
        } catch (SAXException e) {
            e.printStackTrace();
        }catch (IOException e) {
            e.printStackTrace();
        }
        return status;
    }
    //notReady
    public String getOrderItemStatusFromTraffic(String orderId, String qcAssetId){
        return null;
    }

    public String getOrderStatusFromTraffic(String orderId, String qcAssetId){
        return null;
    }


    public String getA5ViewStatusFromTraffic(String orderId,String qcAssetId) {
        return null;
    }


    public String getA5ViewStatusFromTraffic(String orderId,String qcAssetId,String destination) {
        return null;
    }

    //notReady
    public String getBroadcasterStatusFromTraffic(String orderId, String destinationName){
        return null;
    }

    public String getBroadcasterStatusFromTrafficForDestination(String orderId, String qcAssetId,String destinationName){
        return null;
    }

    public String getDeliveryStatusFromTraffic(String orderId, String destinationName){
        return null;
    }

    public String getDeliveryStatusFromTraffic(String orderId,String qcAssetId, String destinationName){
        return null;
    }

    @Override
    public Order completeOrder(Order order, QcView qcView) {
        JsonObject request = new JsonObject();
        request.addProperty("jobNumber", order.getJobNumber());
        request.addProperty("poNumber", order.getPoNumber());
        request.addProperty("pin", order.getPin());
        request.addProperty("handleStandardsConversions", order.getHandleStandardsConversions());
        request.addProperty("notifyAboutDelivery", order.getNotifyAboutDelivery());
        request.addProperty("notifyAboutQc", order.getNotifyAboutQc());
        request.add("notificationEmails", gson.toJsonTree(order.getNotificationEmails()));
        request.add("qcView", gson.toJsonTree(qcView));
        HttpPost post = createPost(baseUrl + "ordering/" + order.getId() + "/complete?$agencyId$=id-"+ order.getAgency().getId() + "&$id$=" + authId, request.toString());
        return sendRequest(post, Order.class);
    }

    @Override
    public Order forceCompleteOrder(Order order) {
        JsonObject request = new JsonObject();
        request.addProperty("jobNumber", order.getJobNumber());
        request.addProperty("poNumber", order.getPoNumber());
        request.addProperty("pin", order.getPin());
        request.addProperty("handleStandardsConversions", order.getHandleStandardsConversions());
        request.addProperty("notifyAboutDelivery", order.getNotifyAboutDelivery());
        request.addProperty("notifyAboutQc", order.getNotifyAboutQc());
        request.add("notificationEmails", gson.toJsonTree(order.getNotificationEmails()));

        HttpPost post = createPost(baseUrl + "ordering/" + order.getId() + "/complete?force=true&$id$=" + authId, request.toString());
        return sendRequest(post, Order.class);
    }

    @Override
    public void moveOrderToBU(String orderId, String agencyId) {
        StringBuilder address = new StringBuilder(baseUrl);
        address.append("ordering/").append(orderId).append("/move_to_bu/").append(agencyId).append("?$id$=").append(authId);

        JsonObject request = new JsonObject();
        HttpPost post = createPost(address.toString(), request.toString());
        sendRequest(post);
    }

    @Override
    public List<BeamTvClock> getBeamTvClocks(String date) {
        StringBuilder address = new StringBuilder(baseUrl);
        address.append("plugins/beam_tv/find?date=").append(Common.urlEncode(date));
        HttpGet get = new HttpGet(address.toString());
        Type type = new TypeToken<List<BeamTvClock>>() {
        }.getType();
        return sendRequest(get, type);
    }

    @Override
    public SearchResult<Order> findOrders(LuceneSearchingParams query) {
        StringBuilder address = new StringBuilder(baseUrl);
        address.append("ordering/find?$id$=").append(authId).append(query.toGetParams());
        HttpGet get = new HttpGet(address.toString());
        Type type = new TypeToken<SearchResult<Order>>() {
        }.getType();
        return sendRequest(get, type);
    }

    @Override
    public SearchResult<OrderCounter> getOrderCounters(String orderType) {
        StringBuilder address = new StringBuilder(baseUrl);
        address.append("ordering/counters?filter=").append(orderType).append("&$id$=").append(authId);
        HttpGet get = new HttpGet(address.toString());
        Type type = new TypeToken<SearchResult<OrderCounter>>() {
        }.getType();
        return sendRequest(get, type);
    }

    @Override
    public void deleteOrder(String orderId) {
        StringBuilder address = new StringBuilder(baseUrl);
        address.append("ordering/").append(orderId).append("?$id$=").append(authId);
        HttpDelete delete = new HttpDelete(address.toString());
        sendRequest(delete);
    }

    @Override
    public void deleteOrders(String[] ordersIds) {
        StringBuilder address = new StringBuilder(baseUrl);
        address.append("ordering/delete?$id$=").append(authId);

        JsonObject request = new JsonObject();
        request.add("items", gson.toJsonTree(ordersIds));

        HttpPost post = createPost(address.toString(), request.toString());
        sendRequest(post);
    }

    @Override
    public OrderItem createOrderItem(String orderId, String orderItemType, OrderItem orderItem) {
        StringBuilder address = new StringBuilder(baseUrl);
        address.append("ordering/").append(orderId).append("/item?item_type=").append(orderItemType);
        address.append("&$id$=").append(authId);

        JsonObject request = new JsonObject();
        request.addProperty("_subtype", orderItemType);
        request.add("_cm", gson.toJsonTree(orderItem.getCm()));

        HttpPost post = createPost(address.toString(), request.toString());
        return sendRequest(post, OrderItem.class);
    }

    @Override
    public OrderItem updateOrderItem(String orderId, String orderItemId, String orderItemType, OrderItem orderItem) {
        StringBuilder address = new StringBuilder(baseUrl);
        address.append("ordering/").append(orderId).append("/item/").append(orderItemId).append("?item_type=").append(orderItemType);
        address.append("&$id$=").append(authId);

        JsonObject request = new JsonObject();
        request.addProperty("_id", orderItemId);
        request.addProperty("_subtype", orderItemType);
        request.add("_cm", gson.toJsonTree(orderItem.getCm()));

        HttpPut put = createPut(address.toString(), request.toString());
        return sendRequest(put, OrderItem.class);
    }

    @Override
    public SearchResult<OrderItem> findOrderItems(String orderItemType, LuceneSearchingParams query) {
        StringBuilder address = new StringBuilder(baseUrl);
        address.append("ordering/find?item_type=").append(orderItemType).append("&$id$=").append(authId).append(query.toGetParams());
        HttpGet get = new HttpGet(address.toString());
        Type type = new TypeToken<SearchResult<OrderItem>>() {
        }.getType();
        return sendRequest(get, type);
    }

    @Override
    public OrderItem holdForApprovalOrderItem(String orderId, String orderItemId, String orderItemType, String approvalValue) {
        StringBuilder address = new StringBuilder(baseUrl);
        address.append("ordering/").append(orderId).append("/item/").append(orderItemId).append("/approval_status?value=").append(approvalValue);
        address.append("&item_type=").append(orderItemType).append("&$id$=").append(authId);

        JsonObject request = new JsonObject();

        HttpPut put = createPut(address.toString(), request.toString());
        return sendRequest(put, OrderItem.class);
    }

    @Override
    public void deleteOrderItemApprovalStatus(String orderId, String orderItemId, String orderItemType) {
        StringBuilder address = new StringBuilder(baseUrl);
        address.append("ordering/").append(orderId).append("/item/").append(orderItemId).append("/approval_status?item_type=").append(orderItemType);
        address.append("&$id$=").append(authId);
        HttpDelete delete = new HttpDelete(address.toString());
        sendRequest(delete);
    }

    @Override
    public OrderItem addMediaToOrderItem(String orderId, String orderItemId, String elementId, String orderItemType) {
        StringBuilder address = new StringBuilder(baseUrl);
        address.append("ordering/").append(orderId).append("/item/").append(orderItemId).append("/").append(elementId).append("?item_type=").append(orderItemType);
        address.append("&$id$=").append(authId);

        JsonObject request = new JsonObject();

        HttpPut put = createPut(address.toString(), request.toString());
        return sendRequest(put, OrderItem.class);
    }

    @Override
    public List<OrderItem> createOrderItemsAssociatedWithMedia(String orderId, String orderItemType, String[] assetElementIds) {
        StringBuilder address = new StringBuilder(baseUrl);
        address.append("ordering/").append(orderId).append("/items?item_type=").append(orderItemType);
        address.append("&$id$=").append(authId);

        JsonObject request = new JsonObject();
        request.add("assetElementIds", gson.toJsonTree(assetElementIds));

        HttpPost post = createPost(address.toString(), request.toString());
        Type type = new TypeToken<EntityList<OrderItem>>() {
        }.getType();
        EntityList<OrderItem> entity = sendRequest(post, type);
        return entity.getResult();
    }

    @Override
    public void removeMediaFromOrderItem(String orderId, String orderItemId, String elementId, String orderItemType) {
        StringBuilder address = new StringBuilder(baseUrl);
        address.append("ordering/").append(orderId).append("/item/").append(orderItemId).append("/").append(elementId).append("?item_type=").append(orderItemType);
        address.append("&$id$=").append(authId);
        HttpDelete delete = new HttpDelete(address.toString());
        sendRequest(delete);
    }

    @Override
    public void deleteOrderItem(String orderId, String orderItemId, String orderItemType) {
        StringBuilder address = new StringBuilder(baseUrl);
        address.append("ordering/").append(orderId).append("/item/").append(orderItemId).append("?item_type=").append(orderItemType);
        address.append("&$id$=").append(authId);
        HttpDelete delete = new HttpDelete(address.toString());
        sendRequest(delete);
    }

    @Override
    public void deleteOrderItems(String[] orderItemsIds) {
        StringBuilder address = new StringBuilder(baseUrl);
        address.append("ordering/item/delete?$id$=").append(authId);

        JsonObject request = new JsonObject();
        request.add("items", gson.toJsonTree(orderItemsIds));

        HttpPost post = createPost(address.toString(), request.toString());
        sendRequest(post);
    }

    @Override
    public void deleteOrdersFromOrdersNotReplicatedToA4Queue(List<String> ordersIds){
        StringBuilder address = new StringBuilder(baseUrl);
        address.append("ordering/delete?$id$=").append(authId);

        JsonObject request = new JsonObject();
        request.add("items", gson.toJsonTree(ordersIds));

        HttpPost post = createPost(address.toString(), request.toString());
        sendRequest(post);
    }

    @Override
    public SearchResult<OrderCompletionQueue> getOrdersFromOrderCompletionQueue() {
        StringBuilder address = new StringBuilder(baseUrl);
        address.append("transaction/find?$id$=").append(authId);
        HttpGet get = new HttpGet(address.toString());
        Type type = new TypeToken<SearchResult<OrderCompletionQueue>>() {
        }.getType();
        return sendRequest(get, type);
    }

    public List<String> getOrdersFromOrderCompletionQueue_id() {
        List<String> data = new ArrayList<String>();
        StringBuilder address = new StringBuilder(baseUrl);
        address.append("transaction/find?$id$=").append(authId);
        HttpGet get = new HttpGet(address.toString());
        String responseBody =  sendRequest(get);
        JsonArray jsonArray=new JsonParser().parse(responseBody).getAsJsonObject().get("list").getAsJsonArray();
        for (JsonElement obj:jsonArray) {
            String status=obj.getAsJsonObject().get("status").getAsJsonObject().get("status").getAsString();
            if(status.equalsIgnoreCase("failed"))
               data.add(obj.getAsJsonObject().get("_id").getAsString());
        }
        return data;
    }

    public void deleteOrdersFromCompletionQueue(String id) {
        StringBuilder address = new StringBuilder(baseUrl);
        address.append("transaction/").append(id).append("?$id$=").append(authId);
        HttpDelete delete = new HttpDelete(address.toString());
        sendRequest(delete);
    }

    @Override
    public SearchResult<Deliveries> findDeliveries(String clockNumber, LuceneSearchingParams query) {
        StringBuilder address = new StringBuilder(baseUrl);
        address.append("ordering/deliveries/").append(clockNumber).append("?$id$=").append(authId).append(query.toGetParams());
        HttpGet get = new HttpGet(address.toString());
        Type type = new TypeToken<SearchResult<Deliveries>>() {
        }.getType();
        return sendRequest(get, type);
    }

    @Override
    public DeliveryReport getDeliveryReport(String orderId) {
        StringBuilder address = new StringBuilder(baseUrl);
        address.append("ordering/").append(orderId).append("/delivery_report").append("?$id$=").append(authId);
        HttpGet get = new HttpGet(address.toString());
        Type type = new TypeToken<DeliveryReport>() {
        }.getType();
        return sendRequest(get, type);
    }

    @Override
    public String getDeliveryReportUrl(String orderId) {
        StringBuilder address = new StringBuilder(baseUrl);
        address.append("ordering/").append(orderId).append("/reports/delivery/pdf?$id$=").append(authId);
        return address.toString();
    }

    @Override
    public String getBeamConfirmationReportUrl(String orderId) {
        StringBuilder address = new StringBuilder(baseUrl);
        address.append("ordering/").append(orderId).append("/reports/delivery_beam/pdf?$id$=").append(authId);
        return address.toString();
    }

    @Override
    public String getDraftOrderReportUrl(String orderId) {
        StringBuilder address = new StringBuilder(baseUrl);
        address.append("ordering/").append(orderId).append("/reports/draft_order/pdf?$id$=").append(authId);
        return address.toString();
    }

    @Override
    public String getBillingOrderReportUrl(String orderId) {
        StringBuilder address = new StringBuilder(baseUrl);
        address.append("ordering/finance/billing/view/").append(orderId).append("?$id$=").append(authId);
        return address.toString();
    }

    @Override
    public String getDeliveryOrderReport(String orderId, String deliveryReportType, List<QcOrderItem> qcOrderItems) {
        StringBuilder address = new StringBuilder(baseUrl);
        address.append("ordering/").append(orderId).append("/reports/").append(deliveryReportType).append("/html?$id$=").append(authId);

        JsonObject archive = new JsonObject();
        for (QcOrderItem qcOrderItem: qcOrderItems) {
            QcAsset qcAsset = qcOrderItem.getAssets().get(0);
            archive.addProperty(qcAsset.getClockNumber(), qcAsset.getAdbanked() ? 1 : 0);
        }
        JsonObject request = new JsonObject();
        request.add("archive", archive);

        HttpPost post = createPost(address.toString(), request.toString());
        return sendRequest(post);
    }

    @Override
    public BaseSearchResult<Market> getTvMarkets() {
        StringBuilder address = new StringBuilder(baseUrl);
        address.append("dictionary/ordering_tv_market?$id$=").append(authId);
        HttpGet get = new HttpGet(address.toString());
        Type type = new TypeToken<BaseSearchResult<Market>>() {
        }.getType();
        return sendRequest(get, type);
    }

    @Override
    public SearchDestinationPerMarketResult getDestinationsByMarket(String market, LuceneSearchingParams query) {
        StringBuilder address = new StringBuilder(baseUrl);
        address.append("dictionary/ordering_tv_market/").append(Common.urlEncode(market)).append("?$id$=").append(authId).append(query.toGetParams());
        HttpGet get = new HttpGet(address.toString());
        return sendRequest(get, SearchDestinationPerMarketResult.class);
    }

    @Override
    public void addAdditionalDestinations(Map<UploadRequestType, List<AdditionalDestination>> additionalDestinations) {
        StringBuilder address = new StringBuilder(baseUrl);
        address.append("additional_destinations?$id$=").append(authId);
        if (additionalDestinations.isEmpty())
            throw new IllegalArgumentException("Empty additional destinations map!");

        if (additionalDestinations.containsKey(UploadRequestType.PHYSICAL)) {
            for (AdditionalDestination additionalDestination : additionalDestinations.get(UploadRequestType.PHYSICAL)) {
                JsonObject destination = new JsonObject();
                destination.addProperty("name", additionalDestination.getName());
                if (additionalDestination.getContactName() != null)
                    destination.addProperty("contactName", additionalDestination.getContactName());
                if (additionalDestination.getContactDetails() != null)
                    destination.addProperty("contactDetails", additionalDestination.getContactDetails());
                if (additionalDestination.getStreetAddress() != null)
                    destination.addProperty("streetAddress", additionalDestination.getStreetAddress());
                if (additionalDestination.getCity() != null) destination.addProperty("city", additionalDestination.getCity());
                if (additionalDestination.getPostCode() != null) destination.addProperty("postCode", additionalDestination.getPostCode());
                if (additionalDestination.getCountry() != null) destination.addProperty("country", additionalDestination.getCountry());
                destination.addProperty("marketId", additionalDestination.getMarketId());
                destination.addProperty("destType", UploadRequestType.PHYSICAL.toString());
                destination.addProperty("agencyId", getCurrentAgency().getId());
                HttpPost post = createPost(address.toString(), destination.toString());
                sendRequest(post);
            }

        }
        if (additionalDestinations.containsKey(UploadRequestType.FTP)) {
            for (AdditionalDestination additionalDestination : additionalDestinations.get(UploadRequestType.FTP)) {
                JsonObject destination = new JsonObject();
                destination.addProperty("name", additionalDestination.getName());
                if (additionalDestination.getContactDetails() != null)
                    destination.addProperty("contactDetails", additionalDestination.getContactDetails());
                if (additionalDestination.getHostName() != null) destination.addProperty("hostName", additionalDestination.getHostName());
                if (additionalDestination.getUserName() != null) destination.addProperty("userName", additionalDestination.getUserName());
                if (additionalDestination.getPass() != null) destination.addProperty("pass", additionalDestination.getPass());
                if (additionalDestination.getPath() != null) destination.addProperty("path", additionalDestination.getPath());
                destination.addProperty("marketId", additionalDestination.getMarketId());
                destination.addProperty("destType", UploadRequestType.FTP.toString());
                destination.addProperty("agencyId", getCurrentAgency().getId());
                HttpPost post = createPost(address.toString(), destination.toString());
                sendRequest(post);
            }
        }
        if (additionalDestinations.containsKey(UploadRequestType.NVERGE)) {
            for (AdditionalDestination additionalDestination : additionalDestinations.get(UploadRequestType.NVERGE)) {
                JsonObject destination = new JsonObject();
                destination.addProperty("name", additionalDestination.getName());
                destination.addProperty("marketId", additionalDestination.getMarketId());
                destination.addProperty("destType", UploadRequestType.NVERGE.toString());
                destination.addProperty("agencyId", getCurrentAgency().getId());
                HttpPost post = createPost(address.toString(), destination.toString());
                sendRequest(post);
            }
        }
        if (additionalDestinations.containsKey(UploadRequestType.GENERICS)) {
            for (AdditionalDestination additionalDestination : additionalDestinations.get(UploadRequestType.GENERICS)) {
                JsonObject destination = new JsonObject();
                destination.addProperty("name", additionalDestination.getName());
                destination.addProperty("destType", UploadRequestType.GENERICS.toString());
                destination.addProperty("marketId", additionalDestination.getMarketId());
                destination.addProperty("agencyId",getCurrentAgency().getId());
                HttpPost post = createPost(address.toString(), destination.toString());
                sendRequest(post);
            }
        }


/*        JsonObject destinations = new JsonObject();

        JsonObject request = new JsonObject();
        request.addProperty("session", destinations.toString());

        HttpPost post = createPost(address.toString(), genericDestinationArray.toString());
        sendRequest(post);*/
    }

    @Override
    public GDNFileRegister registerDocuments(List<GDNFileWrapper> gdnDocuments, String referenceId, String reference) {
        JsonArray array = new JsonArray();
        for (GDNFileWrapper gdnFileWrapper : gdnDocuments) {
            JsonObject regInfo = new JsonObject();
            JsonObject refInfo = new JsonObject();
            JsonObject finalobj = new JsonObject();
            regInfo.addProperty("externalID", gdnFileWrapper.getExternalId());
            regInfo.addProperty("name", gdnFileWrapper.getName());
            regInfo.addProperty("size", gdnFileWrapper.getSize());
            regInfo.addProperty("uploadedTimestamp", System.currentTimeMillis());
            regInfo.addProperty("uploaderName", getCurrentUser().getFullName());

            refInfo.addProperty("id", referenceId);
            refInfo.addProperty("ref", reference);

            finalobj.add("file",regInfo );
            finalobj.add("reference",refInfo );

            array.add(finalobj);

        }
        JsonObject request = new JsonObject();
        request.add("list", array);

        HttpPost post = createPost(baseUrl + "attached-files/register?$id$=" + authId, request.toString());
        return sendRequest(post, GDNFileRegister.class);
    }

    @Override
    public void uploadDocumentsComplete(String gdnFileId) {
        JsonObject request = new JsonObject();
        HttpPost post = createPost(baseUrl + "fs/upload/" + gdnFileId + "/complete?$id$=" + authId, request.toString());
        sendRequest(post);
    }

    @Override
    public void uploadDocumentsCompleteTest(String attachedFileId, String gdnFileId) {
        JsonObject request = new JsonObject();
        request.addProperty("fileId",gdnFileId);
        HttpPost post = createPost(baseUrl + "attached-files/" + attachedFileId + "/complete?$id$=" + authId, request.toString());
        sendRequest(post);
    }

    @Override
    public QcView getQcView(String orderId) {
        StringBuilder address = new StringBuilder(baseUrl);
        address.append("ordering/").append(orderId).append("/complete/view?$id$=").append(authId);
        HttpGet get = new HttpGet(address.toString());
        Type type = new TypeToken<QcView>() {
        }.getType();
        return sendRequest(get, type);
    }

    @Override
    public void assignOrders(String[] ordersIds, String userEmail, String message) {
        StringBuilder address = new StringBuilder(baseUrl);
        address.append("ordering/assign?$id$=").append(authId);

        JsonObject request = new JsonObject();
        request.add("orders", gson.toJsonTree(ordersIds));
        request.addProperty("to", userEmail);
        request.addProperty("message", message);

        HttpPost post = createPost(address.toString(), request.toString());
        sendRequest(post);
    }

    @Override
    public List<Transfer> getAssigns(String orderId) {
        StringBuilder address = new StringBuilder(baseUrl);
        address.append("ordering/assign/").append(orderId).append("?$id$=").append(authId);
        HttpGet get = new HttpGet(address.toString());
        Type type = new TypeToken<List<Transfer>>() {
        }.getType();
        return sendRequest(get, type);
    }

    @Override
    public String enableBilling() {
        HttpPost post = new HttpPost(baseUrl + "/billing/on");
        Type returnType = new TypeToken<BillingService>() {
        }.getType();
        BillingService billingService = sendRequest(post, returnType);
        return billingService.getStatus();
    }

    @Override
    public String disableBilling() {
        HttpPost post = new HttpPost(baseUrl + "/billing/off");
        Type returnType = new TypeToken<BillingService>() {
        }.getType();
        BillingService billingService = sendRequest(post, returnType);
        return billingService.getStatus();
    }

    @Override
    public String getBillingStatus() {
        HttpGet get = new HttpGet(baseUrl + "billing/status");
        Type returnType = new TypeToken<BillingService>() {
        }.getType();
        BillingService billingService = sendRequest(get, returnType);
        return billingService.getStatus();
    }

    @Override
    public Bookmark createBookmark(String name, int marketId, boolean isShared) {
        StringBuilder address = new StringBuilder(baseUrl);
        address.append("ordering/bookmark?$id$=").append(authId);

        JsonObject request = new JsonObject();
        request.addProperty("name", name);
        request.addProperty("marketId", marketId);
        request.addProperty("shared", isShared);

        HttpPost post = createPost(address.toString(), request.toString());
        Type type = new TypeToken<Bookmark>() {
        }.getType();
        return sendRequest(post, type);
    }

    @Override
    public Bookmark updateBookmark(Bookmark bookmark) {
        StringBuilder address = new StringBuilder(baseUrl);
        address.append("ordering/bookmark/").append(bookmark.getId()).append("?$id$=").append(authId);
        HttpPut put = createPut(address.toString(), gson.toJson(bookmark));
        Type type = new TypeToken<Bookmark>() {
        }.getType();
        return sendRequest(put, type);
    }

    @Override
    public Bookmark getBookmarkById(String bookmarkId) {
        StringBuilder address = new StringBuilder(baseUrl);
        address.append("ordering/bookmark/").append(bookmarkId).append("?$id$=").append(authId);
        HttpGet get = new HttpGet(address.toString());
        Type type = new TypeToken<Bookmark>() {
        }.getType();
        return sendRequest(get, type);
    }

    @Override
    public SearchResult<Bookmark> findBookmarks() {
        StringBuilder address = new StringBuilder(baseUrl);
        address.append("ordering/bookmark?$id$=").append(authId);
        HttpGet get = new HttpGet(address.toString());
        Type type = new TypeToken<SearchResult<Bookmark>>() {
        }.getType();
        return sendRequest(get, type);
    }

    @Override
    public void deleteBookmark(String bookmarkId) {
        StringBuilder address = new StringBuilder(baseUrl);
        address.append("ordering/bookmark/").append(bookmarkId).append("?$id$=").append(authId);
        HttpDelete delete = new HttpDelete(address.toString());
        sendRequest(delete);
    }

    @Override
    public void authenticateToARPP(String userName, String password) {
        StringBuilder address = new StringBuilder(baseUrl);
        address.append("pubid/fr/authenticate?$id$=").append(authId);

        JsonObject request = new JsonObject();
        request.addProperty("username", userName);
        request.addProperty("password", password);

        HttpPost post = createPost(address.toString(), request.toString());
        sendRequest(post);
    }

    @Override
    public void updateUserSessionByARPPUserCredentials(String userNameHash, String passwordHash) {
        StringBuilder address = new StringBuilder(baseUrl);
        address.append("user/current/session?$id$=").append(authId);

        JsonObject obj = new JsonObject();
        obj.addProperty("username", userNameHash);
        obj.addProperty("password", passwordHash);

        JsonObject ordering_fr = new JsonObject();
        ordering_fr.add("ordering_arpp", obj);

        JsonObject request = new JsonObject();
        request.addProperty("session", ordering_fr.toString());

        HttpPut put = createPut(address.toString(), request.toString());
        sendRequest(put);
    }

    @Override
    public void findFieldsFromARPP(String criteria, String userName, String password) {
        StringBuilder address = new StringBuilder(baseUrl);
        address.append("pubid/fr/find?$id$=").append(authId);

        JsonObject request = new JsonObject();
        request.addProperty("criteria", criteria);
        request.addProperty("username", userName);
        request.addProperty("password", password);

        HttpPost post = createPost(address.toString(), request.toString());
        sendRequest(post);
    }

    // baseUrl: http://LNO1V-SAPUAPP01.sydney.adstream.com.au:8080/
    @Override
    public Price[] getPrices(BillingView billingView, String endPointUrl) {
        StringBuilder address = new StringBuilder(baseUrl);
        address.append(endPointUrl);

        JsonObject request = new JsonObject();
        request.addProperty("TimeStamp", billingView.getTimeStamp());
        request.addProperty("Agency", billingView.getAgency());
        request.addProperty("AgencyCountry", billingView.getAgencyCountry());
        request.addProperty("BillToCustomer", billingView.getBillToCustomer());
        request.addProperty("BillToCountry", billingView.getBillToCountry());
        request.add("Items", gson.toJsonTree(billingView.getItems()));

        HttpPut put = createPut(address.toString(), request.toString());
        Type type = new TypeToken<Price[]>() {
        }.getType();
        return sendRequest(put, type);
    }

    // baseUrl: http://LNO1V-SAPUAPP01.sydney.adstream.com.au:8080/
    @Override
    public Payment[] billOrder(List<Bill> bills, String endPointUrl) {
        StringBuilder address = new StringBuilder(baseUrl);
        address.append(endPointUrl);

        HttpPut put = createPut(address.toString(), gson.toJson(bills));
        Type type = new TypeToken<Payment[]>() {
        }.getType();
        return sendRequest(put, type);
    }

    @Override
    public IngestDoc getIngestId(String assetId) throws UnsupportedEncodingException {
        String temp = "{terms:{\"asset._id\":[\""+ assetId + "\"]}}";
        String encode = URLEncoder.encode(temp , "UTF-8");
        StringBuilder address = new StringBuilder(baseUrl);
        address.append("asset/ingest/find?query=").append(encode);
        HttpGet get = new HttpGet(address.toString());
        AssetIngestResult assetIngestResult = sendRequest(get, AssetIngestResult.class);
        return !assetIngestResult.getList().isEmpty() ? assetIngestResult.getList().get(0) : null;
    }

    @Override
    public String setIngestId(IngestDoc ingestdoc, String ingestID, long size, String fileId, String assetId) {
        setRevision(ingestdoc, ingestID, size, fileId, assetId);
        Gson gson = new Gson();
        String jsonInString = gson.toJson(ingestdoc);
        HttpPut put = createPut(baseUrl + "asset/ingest/" + ingestID, jsonInString);
        return sendRequest(put);
    }

    @Override
    public IngestDoc setCommentA5(String orderRef, String userId) throws UnsupportedEncodingException {
        StringBuilder address = new StringBuilder(baseUrl);
        address.append("asset/ingest/order/").append(orderRef).append("/comment?").append(URLEncoder.encode("$id$", "UTF-8")).append("=id-" + userId);
        HttpPut put = createPut(baseUrl + "asset/ingest/order/" + orderRef + "/comment", "New comment for ingest");
        AssetIngestResult assetIngestResult = sendRequest(put, AssetIngestResult.class);
        return !assetIngestResult.getList().isEmpty() ? assetIngestResult.getList().get(0) : null;
    }


    @Override
    public String setAssetStatus(String assetId, String userId, String status) throws UnsupportedEncodingException {
        String encode = URLEncoder.encode(status, "UTF-8");
        HttpPut put = createPut(baseUrl + "asset/" + assetId + "/status?value=" + encode + "&$id$=id-" + userId, "");
        return sendRequest(put);
    }

    @Override
    public String redeliverAssetbyExtId(String extId, String userId) throws UnsupportedEncodingException {
        String body = "{\"items\":[\"" + extId +"\"]}";
        HttpPost post = createPost(baseUrl + "ordering/delivery/redeliver-destinations?with=permissions&$id$=id-" + userId, body);
        return sendRequest(post);
    }

    @Override
    public String redeliverAssetbyDeliveryId(String deliveryId, String userId) throws UnsupportedEncodingException {
        HttpPost post = createPost(baseUrl + "ordering/delivery/" + deliveryId + "/redeliver?with=permissions&$id$=id-" + userId, "");
        return sendRequest(post);
    }

    @Override
    public String orderdeliverbyOrderId(String orderId, String userId) throws UnsupportedEncodingException {
        HttpPut put = createPut(baseUrl + "ordering/delivery/order/" + orderId + "?with=permissions&$id$=id-" + userId, "");
        return sendRequest(put);
    }

    @Override
    public String cancelDeliverybyDeliveryId(String deliveryId, String userId) throws UnsupportedEncodingException {
        HttpDeleteWithBody delete = createDelete(baseUrl + "ordering/delivery/" + deliveryId + "?with=permissions&$id$=id-" + userId, "");
        return sendRequest(delete);
    }

    @Override
    public String cancelDeliverybyExtId(String extId, String userId) throws UnsupportedEncodingException {
        String body = "{\"items\":[\"" + extId +"\"]}";
        HttpDeleteWithBody delete = createDelete(baseUrl + "ordering/delivery/destinations?with=permissions&$id$=id-" + userId, body);
        return sendRequest(delete);
    }

    @Override
    public List<GDNDeliveryDoc> getDeliveryDoc(String clockNumber, String userId) throws UnsupportedEncodingException {
        String temp = "{\"prefix\":{\"clockNumber\":\""+clockNumber+"\"}}";
        String encode = URLEncoder.encode(temp, "UTF-8");
        StringBuilder address = new StringBuilder(baseUrl);
        address.append("ordering/delivery/find?query=").append(encode).append("&page=1&size=10?with=permissions&")
                .append(URLEncoder.encode("$id$", "UTF-8")).append("=id-" + userId);
        HttpGet get = new HttpGet(address.toString());
        DeliveryResult deliveryResult = sendRequest(get, DeliveryResult.class);
        // return !deliveryResult.getList().isEmpty() ? deliveryResult.getList().get(0) : null;
        return !deliveryResult.getList().isEmpty() ? deliveryResult.getList() : null;
    }



    @Override
    public String refreshDestinations() throws UnsupportedEncodingException {
        String body = "{\"indexTypes\":[\"destination\"],\"withoutRefresh\":true}";
        HttpPost post = createPost(baseUrl + "admin/index/rebuild?$id$=id-4ef31ce1766ec96769b399c0", body);
        return sendRequest(post);
    }

    @Override
    public String setHouseNumber(String userId,String deliveryId,String houseNumber) throws UnsupportedEncodingException {
        String body = "{\"houseNumber\":\""+houseNumber+"\",\"proxyApproval\":true,\"legalApproval\": true}";
        HttpPut put = createPut(baseUrl + "ordering/traffic/delivery/" + deliveryId + "/approval" +
                "?$id$=id-" + userId, body);
        return sendRequest(put);
    }

    @Override
    public String deleteIngestRepo(String assetId){
        HttpDeleteWithBody delete = createDelete(baseUrl + "/asset/ingest/asset/" + assetId + "?$id$=id-4ef31ce1766ec96769b399c0", "");
        return sendRequest(delete);
    }

    @Override
    public String addIngestRepo(String assetId){
        HttpPost post = createPost(baseUrl + "/asset/ingest/asset/" + assetId + "?$id$=id-4ef31ce1766ec96769b399c0", "");
        return sendRequest(post);
    }

    @Override
    public String setDuration(String assetId, String orderinguserId, String trafficuserId) throws UnsupportedEncodingException {
        String jsonbody = "{\"master\": {\"duration\" : {\"firstActiveFrame\": 75, \"fullDurationInFrames\": 750, " +
                "\"adDurationInFrames\": 500 }}}";
        HttpPatch patch = createPatch(baseUrl + "document/" + assetId + "/last-revision?$id$=id-" + orderinguserId + "&$originId$=id-" + trafficuserId, jsonbody);
        return sendRequest(patch);
    }

    @Override
    public String setMasterArrived(String orderId,String itemId, String orderinguserId, String trafficuserId, Map<String, String> row) throws UnsupportedEncodingException {
        java.util.Date currDate = new Date();
        DateTimeUtils dateFormat = new DateTimeUtils();
        String currentDate = dateFormat.formatDate(currDate, "yyyy-MM-dd'T'HH:mm:ss.sss'Z'");
        String jsonbody = "{\"comment\":\""+row.get("masterArrivedComment")+"\",\"date\":\""+currentDate+"\",\"tape\":\""+
                row.get("tapeNumber")+"\"," + "\"status\":\"Tape Received - Awaiting Ingestion\"}";
        HttpPut put = createPut(baseUrl + "ordering/" + orderId + "/item/" + itemId + "/asset_status?$id$=id-" + orderinguserId + "&$originId$=id-" + trafficuserId, jsonbody);
        return sendRequest(put);
    }

    @Override
    public String removeMasterArrived(String orderId,String itemId, String orderinguserId, String trafficuserId) throws UnsupportedEncodingException {
        String temp = "Awaiting Master Tape";
        String encode = URLEncoder.encode(temp, "UTF-8");
        HttpDeleteWithBody delete = createDelete(baseUrl + "ordering/" + orderId + "/item/" + itemId + "/asset_status?status=" + encode + "&$id$=id-" + orderinguserId + "&$originId$=id-" + trafficuserId, "");
        return sendRequest(delete);
    }


    @Override
    public String retranscodeAsset(String assetId, String orderinguserId, String trafficuserId) throws UnsupportedEncodingException {
        HttpPut put = createPut(baseUrl + "asset/ingest/" + assetId + "/retranscode?$id$=id-" + orderinguserId + "&$originId$=id-" + trafficuserId, "");
        return sendRequest(put);
    }


    public String getMasterReceivedDateTraffic(String orderId, String qcAssetId){
        return null;
    }

    public GDNFileRegister registerGDNFiles(String agencyId, GDNFileWrapper gdnFileWrapper) {
        JsonArray array = new JsonArray();
        JsonObject regInfo = new JsonObject();
        regInfo.addProperty("externalID", gdnFileWrapper.getExternalId());
        regInfo.addProperty("fileName", gdnFileWrapper.getName());
        regInfo.addProperty("size", gdnFileWrapper.getSize());
        array.add(regInfo);
        JsonObject request = new JsonObject();
        request.add("files", array);
        HttpPost post = createPost(baseUrl + "agency/" + agencyId + "/file/register?$id$=" + authId, request.toString());
        return sendRequest(post, GDNFileRegister.class);
    }


    @Override
    public void uploadDocumentsCompleteTest_WaterMarking(String agencyId, String gdnFileId, String fileName) {
        JsonObject request = new JsonObject();
        request.addProperty("fileName", fileName);
        HttpPost post = createPost(baseUrl + "agency/" + agencyId + "/file/uplcomplete/" + gdnFileId + "?type=video-watermark&$id$=" + authId, request.toString());
        sendRequest(post);
    }

    public String generateCustomCode(String agencyId, String customCodeFieldName){
        HttpPost post = createPost(baseUrl + "/schema/custom_code/generate?schema=project&agency="+agencyId+"&schema_path=_cm.common."+customCodeFieldName+"&index=1&code_type=project_job_number&$id$="+authId, new JsonObject().toString());
        String response = sendRequest(post);
        JsonParser jsonParser = new JsonParser();
        JsonObject jo = (JsonObject)jsonParser.parse(response);
        return jo.get("value").toString().replace("\"","");
    }


    // Adcosts
    public HttpPost uploadDocs(File file, String fileName, String formName, StringBuilder postUrl, HttpPost httpPost){
//        HttpPost httpPost = null;
        httpPost = new HttpPost(postUrl.toString());
        MultipartEntityBuilder builder = MultipartEntityBuilder.create();
        builder.addBinaryBody("file", file, org.apache.http.entity.ContentType.APPLICATION_OCTET_STREAM, fileName);
        HttpEntity multipart = builder.build();
        httpPost.setEntity(multipart);
        return  httpPost;
    }

    public HttpResponse uploadAdcostSupportingDocsRegisterUpload(List<SupportingDocsWrapper> docs) {
        try {
            HttpPost httpPost = null;
            String fileName;
            for (SupportingDocsWrapper docsWrapper : docs) {
                StringBuilder postUrl = new StringBuilder(TestsContext.getInstance().adcostCore.toString());
                postUrl.append("/v1/costs/").append(docsWrapper.getCostId()).append("/stage/").append(docsWrapper.getCostStageId()).append("/revision/").append(
                        docsWrapper.getCostStageRevisionId()).append("/supporting-documents/registerUpload?").append(adcostAuthId);
                fileName = docsWrapper.getFile().getName();
                JsonObject request = new JsonObject();
                request.addProperty("fileName", fileName);
                request.addProperty("fileSize", docsWrapper.getFile().length());
                httpPost = createPost(postUrl.toString(), request.toString());
            }
            CloseableHttpClient client = HttpClients.createDefault();
            return client.execute(httpPost);
        } catch (IOException e) {
            throw new IllegalStateException("Unable to upload document: " + e.getCause());
        }
    }

    public void uploadAdcostSupportingDocsCompleteUpload(List<SupportingDocsWrapper> docs,String request) {
        try {
            HttpPost httpPost = null;
            String fileName = null;
            String formName = null;
            for (SupportingDocsWrapper docsWrapper : docs) {
                StringBuilder postUrl = new StringBuilder(TestsContext.getInstance().adcostCore.toString());
                postUrl.append("/v1/costs/").append(docsWrapper.getCostId()).append("/stage/").append(docsWrapper.getCostStageId()).append("/revision/").append(
                        docsWrapper.getCostStageRevisionId()).append("/supporting-documents/").append(docsWrapper.getSupportingDocumentId()).append("/completeUpload?").append(adcostAuthId);
                fileName = docsWrapper.getFile().getName();
                formName = docsWrapper.getFormName();
                httpPost = createPost(postUrl.toString(), request);
            }
            CloseableHttpClient client = HttpClients.createDefault();
            HttpResponse response = client.execute(httpPost);
            if(response.getStatusLine().getStatusCode()>=400){
                throw new Error("Unable to upload '"+fileName+"' document to '"+formName+"'. Check supporting document form name or GDN is down \n"+
                        "Status code: "+response.getStatusLine().getStatusCode()+" Reason: "+response.getStatusLine().getReasonPhrase());
            }
        } catch (IOException e) {
            throw new IllegalStateException("Unable to upload document: " + e.getCause());
        }
    }

    public void uploadAdcostSupportingDocs(List<SupportingDocsWrapper> docs) {
        try {
            HttpPost httpPost = null;
            String fileName = null;
            String formName = null;
            for (SupportingDocsWrapper docsWrapper : docs) {
                StringBuilder postUrl = new StringBuilder(TestsContext.getInstance().adcostCore.toString());
                postUrl.append("/v1/costs/").append(docsWrapper.getCostId()).append("/stage/").append(docsWrapper.getCostStageId()).append("/revision/").append(
                        docsWrapper.getCostStageRevisionId()).append("/supporting-documents/").append(docsWrapper.getSupportingDocumentId()).append("/upload?").append(adcostAuthId);
                fileName = docsWrapper.getFile().getName();
                formName = docsWrapper.getFormName();
                httpPost = uploadDocs(docsWrapper.getFile(),fileName,formName,postUrl, httpPost);
            }
            CloseableHttpClient client = HttpClients.createDefault();
            HttpResponse response = client.execute(httpPost);
            if(response.getStatusLine().getStatusCode()>=400){
                throw new Error("Unable to upload '"+fileName+"' document to '"+formName+"'. Check supporting document form name or GDN is down \n"+
                        "Status code: "+response.getStatusLine().getStatusCode()+" Reason: "+response.getStatusLine().getReasonPhrase());
            }
        } catch (IOException e) {
            throw new IllegalStateException("Unable to upload document: " + e.getCause());
        }
    }

    public void uploadAdditionalSupportingDocumentsInAdCostCompleteUpload(List<SupportingDocsWrapper> docs,String request) {
        try {
            HttpPost httpPost = null;
            String fileName = null;
            String formName = null;
            for (SupportingDocsWrapper docsWrapper : docs) {
                StringBuilder postUrl = new StringBuilder(TestsContext.getInstance().adcostCore.toString());
                postUrl.append("/v1/costs/").append(docsWrapper.getCostId()).append("/stage/").append(docsWrapper.getCostStageId()).append("/revision/").append(
                        docsWrapper.getCostStageRevisionId()).append("/supporting-documents/completeUpload?").append(adcostAuthId);
                fileName = docsWrapper.getFile().getName();
                formName = docsWrapper.getFormName();
                httpPost = createPost(postUrl.toString(), request);
            }
            CloseableHttpClient client = HttpClients.createDefault();
            HttpResponse response = client.execute(httpPost);
            if(response.getStatusLine().getStatusCode()>=400){
                throw new Error("Unable to upload '"+fileName+"' document to '"+formName+"'. Check supporting document form name or GDN is down \n"+
                        "Status code: "+response.getStatusLine().getStatusCode()+" Reason: "+response.getStatusLine().getReasonPhrase());
            }
        } catch (IOException e) {
            throw new IllegalStateException("Unable to upload document: " + e.getCause());
        }
    }

    public void uploadAdcostAdditionalSupportingDocs(List<SupportingDocsWrapper> docs) {
        try {
            HttpPost httpPost = null;
            String fileName = null;
            String formName = null;
            for (SupportingDocsWrapper docsWrapper : docs) {
                StringBuilder postUrl = new StringBuilder(TestsContext.getInstance().adcostCore.toString());
                postUrl.append("/v1/costs/").append(docsWrapper.getCostId()).append("/stage/").append(docsWrapper.getCostStageId()).append("/revision/").append(
                        docsWrapper.getCostStageRevisionId()).append("/supporting-documents/upload?").append(adcostAuthId);
                fileName = docsWrapper.getFile().getName();
                formName = docsWrapper.getFormName();
                httpPost = uploadDocs(docsWrapper.getFile(),fileName,formName,postUrl, httpPost);
            }
            CloseableHttpClient client = HttpClients.createDefault();
            HttpResponse response = client.execute(httpPost);
            if(response.getStatusLine().getStatusCode()>=400){
                throw new Error("Unable to upload '"+fileName+"' document to '"+formName+"'. Check additional supporting document form name or GDN is down \n"+
                        "Status code: "+response.getStatusLine().getStatusCode()+" Reason: "+response.getStatusLine().getReasonPhrase());
            }
        } catch (IOException e) {
            throw new IllegalStateException("Unable to upload document: " + e.getCause());
        }
    }

    public void uploadBudgetForms(List<BudgetFormsWrapper> docs) {
        try {
            HttpPost httpPost = null;
            String fileName = null;
            String formName = null;
            for (BudgetFormsWrapper docsWrapper : docs) {
                StringBuilder postUrl = new StringBuilder(TestsContext.getInstance().adcostCore.toString());
                postUrl.append("/v1/admin/budget-form-template/").append(docsWrapper.getBudgetFormTemplateId()).append("/upload?").append(adcostAuthId);
                fileName = docsWrapper.getFile().getName();
                formName = docsWrapper.getFormName();
                httpPost = uploadDocs(docsWrapper.getFile(),fileName,formName,postUrl,httpPost);
            }
            CloseableHttpClient client = HttpClients.createDefault();
            HttpResponse response = client.execute(httpPost);
            if(response.getStatusLine().getStatusCode()>=400){
                throw new Error("Unable to upload '"+fileName+"' Budgetform to '"+formName+"'. Check Budget Form Template or GDN is down \n"+
                        "Status code: "+response.getStatusLine().getStatusCode()+" Reason: "+response.getStatusLine().getReasonPhrase());
            }
        } catch (IOException e) {
            throw new IllegalStateException("Unable to upload document: " + e.getCause());
        }
    }

    public String uploadBudgetFormInCostLineItem(List<BudgetFormsWrapper> docs, boolean checkBadRequest) {
        try {
            HttpPost httpPost = null;
            String fileName = null;
            String formName = null;
            for (BudgetFormsWrapper docsWrapper : docs) {
                StringBuilder postUrl = new StringBuilder(TestsContext.getInstance().adcostCore.toString());
                postUrl.append("/v1/costs/").append(docsWrapper.getCostId()).append("/stage/").append(docsWrapper.getCostStageId()).append("/revision/").append(
                        docsWrapper.getCostStageRevisionId()).append("/budget-form/upload?").append(adcostAuthId);
                fileName = docsWrapper.getFile().getName();
                formName = docsWrapper.getFormName();
                httpPost = uploadDocs(docsWrapper.getFile(),fileName,formName,postUrl,httpPost);
            }
            CloseableHttpClient client = HttpClients.createDefault();
            HttpResponse response = client.execute(httpPost);
            if(checkBadRequest) {
              if ((response.getStatusLine().getStatusCode() == 400))
                  return "Status code: 400 , Reason: Bad Request";
              else if ((response.getStatusLine().getStatusCode()>= 400))
                  throw new Error("Unable to upload '"+fileName+"' Budgetform to '"+formName+"'. Check Budget Form Template or GDN is down \n"+
                          "Status code: "+response.getStatusLine().getStatusCode()+" Reason: "+response.getStatusLine().getReasonPhrase());
             }
             if ((!checkBadRequest)&& (response.getStatusLine().getStatusCode()>=400)){
                throw new Error("Unable to upload '"+fileName+"' Budgetform to '"+formName+"'. Check Budget Form Template or GDN is down \n"+
                        "Status code: "+response.getStatusLine().getStatusCode()+" Reason: "+response.getStatusLine().getReasonPhrase());
             }

        } catch (IOException e) {
            throw new IllegalStateException("Unable to upload document: " + e.getCause());
        }
        return null;
    }

    public String downloadBudgetForms(String formTemplateId) {
        try {
            HttpGet httpGet = null;
            String fileName = null;
            String formName = null;
            BudgetFormsWrapper docsWrapper;
            StringBuilder getUrl = new StringBuilder(TestsContext.getInstance().adcostCore.toString());
            getUrl.append("/v1/admin/budget-form-template/").append(formTemplateId).append("/download?").append(adcostAuthId);
            httpGet = new HttpGet(getUrl.toString());
            CloseableHttpClient client = HttpClients.createDefault();
            HttpResponse response = client.execute(httpGet);
            String downloadResponse = response.toString();
            if (response.getStatusLine().getStatusCode() >= 400) {
                throw new Error("Unable to download '" + fileName + "' Budgetform. Check Budget Form Template or GDN is down \n" +
                        "Status code: " + response.getStatusLine().getStatusCode() + " Reason: " + response.getStatusLine().getReasonPhrase());
            }
            return downloadResponse;
        } catch (IOException e) {
            throw new IllegalStateException("Unable to download document: " + e.getCause());
        }
    }

    public String downloadAssociatedAssets(String costId, String revisionId){
        StringBuilder address = new StringBuilder(TestsContext.getInstance().adcostCore.toString());
        address.append("/v1/costs/").append(costId).append("/revisions/").append(revisionId).append("/associated-assets/download?").append(adcostAuthId);
        HttpGet get = new HttpGet(address.toString());
        return sendRequest(get);
    }

    public String checkDownloadProjectTotals(String projectId){
        StringBuilder address = new StringBuilder(TestsContext.getInstance().adcostCore.toString());
        address.append("/v1/project/").append(projectId).append("/downloadCsv?").append(adcostAuthId);
        HttpGet get = new HttpGet(address.toString());
        return sendRequest(get);
    }

    public String downloadExpectedAssets(String costId, String stageId, String revisionId){
        StringBuilder address = new StringBuilder(TestsContext.getInstance().adcostCore.toString());
        address.append("/v1/costs/").append(costId).append("/stage/").append(stageId).append("/revision/").append(revisionId).append("/expected-assets/downloadCsv?").append(adcostAuthId);
        HttpGet get = new HttpGet(address.toString());
        return sendRequest(get);
    }

    public CostStage getCostStage(String costId) {
        StringBuilder address = new StringBuilder(TestsContext.getInstance().adcostCore.toString());
        address.append("/v1/costs/").append(costId).append("/stage/latest?").append(adcostAuthId);
        HttpGet get = new HttpGet(address.toString());
        return sendRequest(get, CostStage.class);
    }

    public CostStageRevision getCostStageRevision(String costId, String costStageId) {
        StringBuilder address = new StringBuilder(TestsContext.getInstance().adcostCore.toString());
        address.append("/v1/costs/").append(costId).append("/stage/").append(costStageId).append("/revision/latest?").append(adcostAuthId);
        HttpGet get = new HttpGet(address.toString());
        return sendRequest(get, CostStageRevision.class);
    }

    public SupportingDocuments[] getSupportingDocuments(String costId, String costStageId, String costStageRevisionId) {
        StringBuilder address = new StringBuilder(TestsContext.getInstance().adcostCore.toString());
        address.append("/v1/costs/").append(costId).append("/stage/").append(costStageId).append("/revision/").append(costStageRevisionId).append("/supporting-documents?").append(adcostAuthId);
        HttpGet get = new HttpGet(address.toString());
        Type type = new TypeToken<SupportingDocuments[]>() { }.getType();
        return sendRequest(get, type);
    }

    public HttpResponse downloadSupportingDocuments(String costId, String costStageId, String costStageRevisionId,String supportingDocumentId,String formName) {
        try {
            StringBuilder address = new StringBuilder(TestsContext.getInstance().adcostCore.toString());
            address.append("/v1/costs/").append(costId).append("/stage/").append(costStageId).append("/revision/").append(costStageRevisionId).append("/supporting-documents/")
                    .append(supportingDocumentId).append("/downloadInfo?").append(adcostAuthId);
            HttpResponse httpResponse = executeDownloadCall(address.toString(),formName);
            String response = EntityUtils.toString(httpResponse.getEntity());
            JsonParser jsonParser = new JsonParser();
            JsonElement element1 = jsonParser.parse(response).getAsJsonObject();
            JsonObject object1 = element1.getAsJsonObject();
            String fileUri = object1.get("fileUri").getAsString();
            return  executeDownloadCall(fileUri,formName);
        }catch (IOException e) {
        throw new IllegalStateException("Unable to download supporting document: "+formName+"\n" + e.getCause());
        }
    }

    private HttpResponse executeDownloadCall(String address, String formName){
        try {
            HttpGet httpGet =new HttpGet(address.toString());
            CloseableHttpClient client = HttpClients.createDefault();
            HttpResponse response = client.execute(httpGet);

            if (response.getStatusLine().getStatusCode() >= 400) {
                throw new Error("Unable to download supporting document from Cost Review page: '" + formName + "' \n" +
                        "Status code: " + response.getStatusLine().getStatusCode() + " Reason: " + response.getStatusLine().getReasonPhrase());
            }
            return response;
        }catch (IOException e) {
            throw new IllegalStateException("Unable to download supporting document: "+formName+"\n" + e.getCause());
        }
    }

    public BudgetFormTemplates[] getBudgetFormTemplates() {
        StringBuilder address = new StringBuilder(TestsContext.getInstance().adcostCore.toString());
        address.append("/v1/admin/budget-form-template?").append(adcostAuthId);
        HttpGet get = new HttpGet(address.toString());
        Type type = new TypeToken<BudgetFormTemplates[]>() { }.getType();
        return sendRequest(get, type);
    }

    public CostsCount getCosts() {
        StringBuilder address = new StringBuilder(TestsContext.getInstance().adcostCore.toString());
        address.append("/v1/costs/search?pageNumber=1&pageSize=10000&searchText=&").append(adcostAuthId);
        HttpGet get = new HttpGet(address.toString());
        Type type = new TypeToken<CostsCount>() { }.getType();
        return sendRequest(get, type);
    }

    public CostTemplates[] getCostTemplates() {
        StringBuilder address = new StringBuilder(TestsContext.getInstance().adcostCore.toString());
        address.append("/v1/costtemplate?").append(adcostAuthId);
        HttpGet get = new HttpGet(address.toString());
        Type type = new TypeToken<CostTemplates[]>() { }.getType();
        return sendRequest(get, type);
    }

    public AdcostDictionaries[] getAdcostDictionaries() {
        StringBuilder address = new StringBuilder(TestsContext.getInstance().adcostCore.toString());
        address.append("/v1/dictionary?names=ProductionType&names=ContentType&").append(adcostAuthId);
        HttpGet get = new HttpGet(address.toString());
        Type type = new TypeToken<AdcostDictionaries[]>() { }.getType();
        return sendRequest(get, type);
    }

    public AdcostCurrency[] getAdcostCurrnecy() {
        StringBuilder address = new StringBuilder(TestsContext.getInstance().adcostCore.toString());
        address.append("/v1/currency?").append(adcostAuthId);
        HttpGet get = new HttpGet(address.toString());
        Type type = new TypeToken<AdcostCurrency[]>() { }.getType();
        return sendRequest(get, type);
    }

    public Costs createCostDetails(CostDetails costDetails) {
        StringBuilder address = new StringBuilder(TestsContext.getInstance().adcostCore.toString());
        address.append("/v1/costs?").append(adcostAuthId);
        HttpPost post = createPost(address.toString(), gson.toJson(costDetails));
        return sendRequest(post, Costs.class);
    }

    public ExchangeRates[] getExchangeRates(String costId){
        StringBuilder address = new StringBuilder(TestsContext.getInstance().adcostCore.toString());
        address.append("/v1/costs/").append(costId).append("/exchangerates?").append(adcostAuthId);
        HttpGet get = new HttpGet(address.toString());
        Type type = new TypeToken<ExchangeRates[]>() { }.getType();
        return sendRequest(get, type);
    }

    public AdcostDictionaries[] getTravellerRole() {
        StringBuilder address = new StringBuilder(TestsContext.getInstance().adcostCore.toString());
        address.append("/v1/dictionary?search=Role&").append(adcostAuthId);
        HttpGet get = new HttpGet(address.toString());
        Type type = new TypeToken<AdcostDictionaries[]>() { }.getType();
        return sendRequest(get, type);
    }

    public AdcostDictionaries[] getShootCity() {
        StringBuilder address = new StringBuilder(TestsContext.getInstance().adcostCore.toString());
        address.append("/v1/dictionary?search=ShootCity&").append(adcostAuthId);
        HttpGet get = new HttpGet(address.toString());
        Type type = new TypeToken<AdcostDictionaries[]>() { }.getType();
        return sendRequest(get, type);
    }

    public TravelRegions[] getTravelRegions() {
        StringBuilder address = new StringBuilder(TestsContext.getInstance().adcostCore.toString());
        address.append("/v1/regions?").append(adcostAuthId);
        HttpGet get = new HttpGet(address.toString());
        Type type = new TypeToken<TravelRegions[]>() {
        }.getType();
        return sendRequest(get, type);
    }

    public PerDiems[] getTravelPerDiems() {
        StringBuilder address = new StringBuilder(TestsContext.getInstance().adcostCore.toString());
        address.append("/v1/perDiems?").append(adcostAuthId);
        HttpGet get = new HttpGet(address.toString());
        Type type = new TypeToken<PerDiems[]>() {
        }.getType();
        return sendRequest(get, type);
    }

    public TravelCountry[] getTravelCountry(){
        StringBuilder address = new StringBuilder(TestsContext.getInstance().adcostCore.toString());
        address.append("/v1/countries?").append(adcostAuthId);
        HttpGet get = new HttpGet(address.toString());
        Type type = new TypeToken<TravelCountry[]>() {
        }.getType();
        return sendRequest(get, type);
    }

    public TravelDetails createTravelCostDetails(TravelDetails details) {
        StringBuilder address = new StringBuilder(TestsContext.getInstance().adcostCore.toString());
        address.append("/v1/costs/").append(details.getCostId()).append("/stage/").append(details.getStageId()).append("/revision/").append(details.getRevisionId()).append("/travelcosts?").append(adcostAuthId);
        HttpPost post = createPost(address.toString(), gson.toJson(details));
        return sendRequest(post, TravelDetails.class);
    }

    public void deleteTravelCostDetails(TravelDetails details) {
        StringBuilder address = new StringBuilder(TestsContext.getInstance().adcostCore.toString());
        address.append("/v1/costs/").append(details.getCostId()).append("/stage/").append(details.getStageId()).append("/revision/").append(details.getStageId()).append("/travelcosts/").append(details.getId()).append("?").append(adcostAuthId);
        HttpDelete delete = new HttpDelete(address.toString());
        sendRequest(delete);
    }

    public TravelDetails[] getTravelCostDetails(TravelDetails details) {
        StringBuilder address = new StringBuilder(TestsContext.getInstance().adcostCore.toString());
        address.append("/v1/costs/").append(details.getCostId()).append("/stage/").append(details.getStageId()).append("/revision/").append(details.getStageId()).append("/travelcosts?").append(adcostAuthId);
        HttpGet get = new HttpGet(address.toString());
        Type type = new TypeToken<TravelDetails[]>() {
        }.getType();
        return sendRequest(get, type);
    }

    public AdcostDictionaries[] getDirectorName(){
        StringBuilder address = new StringBuilder(TestsContext.getInstance().adcostCore.toString());
        address.append("/v1/dictionary?search=DirectorName&").append(adcostAuthId);
        HttpGet get = new HttpGet(address.toString());
        Type type = new TypeToken<AdcostDictionaries[]>() { }.getType();
        return sendRequest(get, type);
    }

    public AdcostDictionaries[] getPhotographerName(){
        StringBuilder address = new StringBuilder(TestsContext.getInstance().adcostCore.toString());
        address.append("/v1/dictionary?search=PhotographerName&").append(adcostAuthId);
        HttpGet get = new HttpGet(address.toString());
        Type type = new TypeToken<AdcostDictionaries[]>() { }.getType();
        return sendRequest(get, type);
    }

    public SmoOrganisations[] getSmoOrganisations(String budgetRegionId){
        StringBuilder address = new StringBuilder(TestsContext.getInstance().adcostCore.toString());
        address.append("/v1/regions/smos?idOrKey=").append(budgetRegionId).append("&").append(adcostAuthId);
        HttpGet get = new HttpGet(address.toString());
        Type type = new TypeToken<SmoOrganisations[]>() { }.getType();
        return sendRequest(get, type);
    }

    public BudgetRegions[] getBudgetRegions(){
        StringBuilder address = new StringBuilder(TestsContext.getInstance().adcostCore.toString());
        address.append("/v1/regions?").append(adcostAuthId);
        HttpGet get = new HttpGet(address.toString());
        Type type = new TypeToken<BudgetRegions[]>() { }.getType();
        return sendRequest(get, type);
    }

    public VendorsCount getVendors(String searchText){
        StringBuilder address = new StringBuilder(TestsContext.getInstance().adcostCore.toString());
        address.append("/v1/vendors/query?pageNumber=1&pageSize=100&searchText=").append(searchText).append("&").append(adcostAuthId);
        HttpGet get = new HttpGet(address.toString());
        Type type = new TypeToken<VendorsCount>() { }.getType();
        return sendRequest(get, type);
    }

    public Vendors[] getVendorListPerProductionCategory(String productionCategory){
        StringBuilder address = new StringBuilder(TestsContext.getInstance().adcostCore.toString());
        address.append("/v1/vendors/%20/category/").append(productionCategory).append("Company?").append(adcostAuthId);
        HttpGet get = new HttpGet(address.toString());
        Type type = new TypeToken<Vendors[]>() { }.getType();
        return sendRequest(get, type);
    }

    public Vendors[] getVendorListforNonProductionCost(String productionCategory){
        StringBuilder address = new StringBuilder(TestsContext.getInstance().adcostCore.toString());
        address.append("/v1/vendors/%20/category/").append(productionCategory).append("?").append(adcostAuthId);
        HttpGet get = new HttpGet(address.toString());
        Type type = new TypeToken<Vendors[]>() { }.getType();
        return sendRequest(get, type);
    }

    public Vendors createVendors( Vendors vendors){
        StringBuilder address = new StringBuilder(TestsContext.getInstance().adcostCore.toString());
        address.append("/v1/vendors?").append(adcostAuthId);
        HttpPut put = createPut(address.toString(), gson.toJson(vendors));
        return sendRequest(put, Vendors.class);
    }

    public void updateVendors( Vendors vendors){
        StringBuilder address = new StringBuilder(TestsContext.getInstance().adcostCore.toString());
        address.append("/v1/vendors?").append(adcostAuthId);
        HttpPut put = createPut(address.toString(), gson.toJson(vendors));
        sendRequest(put);
    }

    public void createProductionDetails(String costId, BaseProductionDetails details){
        StringBuilder address = new StringBuilder(TestsContext.getInstance().adcostCore.toString());
        address.append("/v1/costs/").append(costId).append("?").append(adcostAuthId);
        HttpPut put = createPut(address.toString(), gson.toJson(details));
        sendRequest(put);
    }

    public AdcostDictionaries[] getInitiatives(){
        StringBuilder address = new StringBuilder(TestsContext.getInstance().adcostCore.toString());
        address.append("/v1/dictionary?search=Initiative&").append(adcostAuthId);
        HttpGet get = new HttpGet(address.toString());
        Type type = new TypeToken<AdcostDictionaries[]>() { }.getType();
        return sendRequest(get, type);
    }

    public AdcostDictionaries[] getAdcostDictionaryByName(String dictionaryName) {
        StringBuilder address = new StringBuilder(TestsContext.getInstance().adcostCore.toString());
        address.append("/v1/dictionary?names=").append(dictionaryName).append("&").append(adcostAuthId);
        HttpGet get = new HttpGet(address.toString());
        Type type = new TypeToken<AdcostDictionaries[]>() { }.getType();
        return sendRequest(get, type);
    }

    public AdId generateAdId(AdId adId){
        StringBuilder address = new StringBuilder(TestsContext.getInstance().adcostCore.toString());
        address.append("/v1/adid?").append(adcostAuthId);
        HttpPost post = createPost(address.toString(), gson.toJson(adId));
        return sendRequest(post,AdId.class);
    }

    public void createExpectedAssets(ExpectedAssets assets){
        StringBuilder address = new StringBuilder(TestsContext.getInstance().adcostCore.toString());
        address.append("/v1/costs/").append(assets.getCostId()).append("/stage/").append(assets.getCostStageId()).append("/revision/").append(assets.getRevisionId()).append("/expected-assets?").append(adcostAuthId);
        HttpPost post = createPost(address.toString(), gson.toJson(assets));
        sendRequest(post);
    }

    public void createCostLineItemData(CostLineItems lineItems){
        StringBuilder address = new StringBuilder(TestsContext.getInstance().adcostCore.toString());
        address.append("/v1/costs/").append(lineItems.getCostId())
                .append("/stage/").append(lineItems.getCostStageId())
                .append("/revision/").append(lineItems.getRevisionId())
                .append("/line-item?").append(adcostAuthId);
        HttpPut put = createPut(address.toString(), gson.toJson(lineItems));
        sendRequest(put);
    }

    public void createIoNumber(String objectId, String name, Data data){
        StringBuilder address = new StringBuilder(TestsContext.getInstance().adcostCore.toString());
        address.append("/v1/custom-data/").append(objectId).append("/").append(name).append("?").append(adcostAuthId);
        HttpPost post = createPost(address.toString(), gson.toJson(data));
        sendRequest(post);
    }

    public CustomData getIoNumber(String objectId, String name){
        StringBuilder address = new StringBuilder(TestsContext.getInstance().adcostCore.toString());
        address.append("/v1/custom-data/").append(objectId).append("/").append(name).append("?").append(adcostAuthId);
        HttpGet get = new HttpGet(address.toString());
        Type type = new TypeToken<CustomData>() { }.getType();
        return sendRequest(get, type);
    }

    public CostLineItemDataResponse[] getCostLineItemDetails(String costId,String costStageId,String revisionId){
        StringBuilder address = new StringBuilder(TestsContext.getInstance().adcostCore.toString());
        address.append("/v1/costs/").append(costId)
                .append("/stage/").append(costStageId)
                .append("/revision/").append(revisionId)
                .append("/line-item?").append(adcostAuthId);
        HttpGet get = new HttpGet(address.toString());
        Type type = new TypeToken<CostLineItemDataResponse[]>() { }.getType();
        return sendRequest(get, type);
    }

    public Approvals[] getApproversListForCost(String costId, String costStageId, String revisionId){
        StringBuilder address = new StringBuilder(TestsContext.getInstance().adcostCore.toString());
        address.append("/v1/costs/").append(costId)
                .append("/stage/").append(costStageId)
                .append("/revision/").append(revisionId)
                .append("/approvals?").append(adcostAuthId);
        HttpGet get = new HttpGet(address.toString());
        Type type = new TypeToken<Approvals[]>() { }.getType();
        return sendRequest(get, type);
    }

    public ApprovalMembers[] getApproverDetails(String id){
        StringBuilder address = new StringBuilder(TestsContext.getInstance().adcostCore.toString());
        address.append("/v1/approval/").append(id).append("/approvers?").append(adcostAuthId);
        HttpGet get = new HttpGet(address.toString());
        Type type = new TypeToken<ApprovalMembers[]>() { }.getType();
        return sendRequest(get, type);
    }

    public void addApprovers(String costId, String costStageId, String revisionId, List<Approvals> approvers){
        StringBuilder address = new StringBuilder(TestsContext.getInstance().adcostCore.toString());
        address.append("/v1/costs/").append(costId)
                .append("/stage/").append(costStageId)
                .append("/revision/").append(revisionId)
                .append("/approvals?").append(adcostAuthId);
        HttpPost post = createPost(address.toString(), gson.toJson(approvers));
        sendRequest(post, Approvals.class);
    }

    public void submitCostForApproval(String costId,String action, String comments){
        StringBuilder address = new StringBuilder(TestsContext.getInstance().adcostCore.toString());
        address.append("/v1/costs/").append(costId).append("/workflow/actions?").append(adcostAuthId);
        JsonObject createApprovalRequest = new JsonObject();
        createApprovalRequest.addProperty("costId",costId);
        createApprovalRequest.addProperty("action",action);
        if((!comments.isEmpty())){
        JsonObject parameters = new JsonObject();
        parameters.addProperty("comments",comments);
        createApprovalRequest.add("parameters", parameters);
        }
        HttpPost post = createPost(address.toString(), createApprovalRequest.toString());
        sendRequest(post, Approvers.class);
    }

    public void createUsageBuyOutDetails(UpdateCostForm details, String costId){
        StringBuilder address = new StringBuilder(TestsContext.getInstance().adcostCore.toString());
        address.append("/v1/costs/").append(costId).append("?").append(adcostAuthId);
        HttpPatch patch = createPatch(address.toString(), gson.toJson(details));
        sendRequest(patch);
    }

    public void createNegotiatedTerms(UpdateCostForm details, String costId){
        StringBuilder address = new StringBuilder(TestsContext.getInstance().adcostCore.toString());
        address.append("/v1/costs/").append(costId).append("?").append(adcostAuthId);
        HttpPatch patch = createPatch(address.toString(), gson.toJson(details));
        sendRequest(patch);
    }

    public ProjectSearch[] getProjectNumber(String gdamProjectId){
        StringBuilder address = new StringBuilder(TestsContext.getInstance().adcostCore.toString());
        address.append("/v1/project/search?").append(adcostAuthId);
        JsonObject searchText = new JsonObject();
        searchText.addProperty("gdamProjectId",gdamProjectId);
        HttpPost post = createPost(address.toString(), searchText.toString());
        Type type = new TypeToken<ProjectSearch[]>() { }.getType();
        return sendRequest(post, type);
    }

    public CostUser searchUserByAgencyID(String email){
        StringBuilder address = new StringBuilder(TestsContext.getInstance().adcostCore.toString());
        address.append("/v1/users/search?$id$=").append(authId.replace("id-",""));
        JsonObject searchText = new JsonObject();
        searchText.addProperty("searchText",email);
        HttpPost post = createPost(address.toString(), searchText.toString());
        Type type = new TypeToken<CostUser>() { }.getType();
        return sendRequest(post, type);
    }

    public UserRoles[] getBusinessRoles(){
        StringBuilder address = new StringBuilder(TestsContext.getInstance().adcostCore.toString());
        if(authId.equalsIgnoreCase("id-null"))
            address.append("/v1/roles/business?").append(adcostAuthId);
        else
            address.append("/v1/roles/business?$id$=").append(authId.replace("id-",""));
        HttpGet get = new HttpGet(address.toString());
        Type type = new TypeToken<UserRoles[]>() { }.getType();
        return sendRequest(get, type);
    }

    public Agencies[] getAgencyIdInCostModule(){
        StringBuilder address = new StringBuilder(TestsContext.getInstance().adcostCore.toString());
        if(authId.equalsIgnoreCase("id-null"))
            address.append("/v1/agencies?").append(adcostAuthId);
        else
            address.append("/v1/agencies?$id$=").append(authId.replace("id-",""));
        HttpGet get = new HttpGet(address.toString());
        Type type = new TypeToken<Agencies[]>() { }.getType();
        return sendRequest(get, type);
    }

    public void grantUserAccessInCostModule(String userId,String businessRoleId,String approvalLimit,String accessType,String typeId, String labelName, String notificationBudgetRegionId){
        StringBuilder address = new StringBuilder(TestsContext.getInstance().adcostCore.toString());
        if(authId.equalsIgnoreCase("id-null"))
            address.append("/v1/users/").append(userId).append("?").append(adcostAuthId);
        else
            address.append("/v1/users/").append(userId).append("?$id$=").append(authId.replace("id-",""));
        JsonObject baseObject = new JsonObject();
        JsonObject userAccess = new JsonObject();
        JsonArray accessDetails = new JsonArray();
        userAccess.addProperty("businessRoleId",businessRoleId);
        if(!(approvalLimit==null || approvalLimit.isEmpty()))
            baseObject.addProperty("approvalLimit",Integer.parseInt(approvalLimit));
        if(!(notificationBudgetRegionId==null || notificationBudgetRegionId.isEmpty()))
            baseObject.addProperty("notificationBudgetRegionId",notificationBudgetRegionId);
        userAccess.addProperty("objectType",accessType);
        if(!(labelName==null || labelName.isEmpty()))
            userAccess.addProperty("labelName",labelName);
        accessDetails.add(userAccess);
        baseObject.add("accessDetails",accessDetails);

        HttpPut put = createPut(address.toString(), gson.toJson(baseObject));
        sendRequest(put);
    }

    public String getCostsAsString(String costTitle) {
        StringBuilder address = new StringBuilder(TestsContext.getInstance().adcostCore.toString());
        address.append("/v1/costs/search?pageNumber=1&pageSize=10000&").append(adcostAuthId);
        HttpGet get = new HttpGet(address.toString());
        return sendRequest(get);
    }

    public ExpectedAssets[] getExpectedAssets(String costId, String costStageId, String revisionId){
        StringBuilder address = new StringBuilder(TestsContext.getInstance().adcostCore.toString());
        address.append("/v1/costs/").append(costId).append("/stage/").append(costStageId).append("/revision/").append(revisionId).append("/expected-assets?").append(adcostAuthId);
        HttpGet get = new HttpGet(address.toString());
        Type type = new TypeToken<ExpectedAssets[]>() { }.getType();
        return sendRequest(get,type);
    }


    public ValueReportingDetails getValueReportingdetails(String costId,String costRevisionId) {
        StringBuilder address = new StringBuilder(TestsContext.getInstance().adcostCore.toString());
        address.append("/v1/costs/").append(costId).append("/revisions/").append(costRevisionId).append("/value-reporting?").append(adcostAuthId);
        HttpGet get = new HttpGet(address.toString());
        Type type = new TypeToken<ValueReportingDetails>() { }.getType();
        return sendRequest(get, type);
    }

    public ValueReportingDetails editValueReportingdetails(String costId,String costRevisionId, ValueReportingDetails reportingDetails) {
        StringBuilder address = new StringBuilder(TestsContext.getInstance().adcostCore.toString());
        address.append("/v1/costs/").append(costId).append("/revisions/").append(costRevisionId).append("/value-reporting?").append(adcostAuthId);
        HttpPost post = createPost(address.toString(), gson.toJson(reportingDetails));
        return sendRequest(post, ValueReportingDetails.class);
    }

    public void createEntryInAdcostDictionary(ContentType request){
        StringBuilder address = new StringBuilder(TestsContext.getInstance().adcostCore.toString());
        address.append("/v1/dictionary/").append(request.getDictionaryId()).append("/dictionaryentries?").append(adcostAuthId);
        HttpPost post = createPost(address.toString(), gson.toJson(request));
        sendRequest(post);
    }

    public void createEntryInAdcostDictionaryGDAMway(ContentType request){
        String gdamWayAuthId = authId.replace("id-","$id$=");
        StringBuilder address = new StringBuilder(TestsContext.getInstance().adcostCore.toString());
        address.append("/v1/dictionary/").append(request.getDictionaryId()).append("/dictionaryentries?").append(gdamWayAuthId);
        HttpPost post = createPost(address.toString(), gson.toJson(request));
        sendRequest(post);
    }

    public AdcostDictionaries[] getAdcostDictionaryByNameGDAMway(String dictionaryName) {
        String gdamWayAuthId = authId.replace("id-","$id$=");
        StringBuilder address = new StringBuilder(TestsContext.getInstance().adcostCore.toString());
        address.append("/v1/dictionary?names=").append(dictionaryName).append("&").append(gdamWayAuthId);
        HttpGet get = new HttpGet(address.toString());
        Type type = new TypeToken<AdcostDictionaries[]>() { }.getType();
        return sendRequest(get, type);
    }

    public VendorsCount getVendorsGDAMway(String searchText){
        String gdamWayAuthId = authId.replace("id-","$id$=");
        StringBuilder address = new StringBuilder(TestsContext.getInstance().adcostCore.toString());
        address.append("/v1/vendors/query?pageNumber=1&pageSize=100&searchText=").append(searchText).append("&").append(gdamWayAuthId);
        HttpGet get = new HttpGet(address.toString());
        return sendRequest(get,VendorsCount.class);
    }

    public Vendors createVendorsGDAMway(Vendors vendors){
        String gdamWayAuthId = authId.replace("id-","$id$=");
        StringBuilder address = new StringBuilder(TestsContext.getInstance().adcostCore.toString());
        address.append("/v1/vendors?").append(gdamWayAuthId);
        HttpPut put = createPut(address.toString(), gson.toJson(vendors));
        return sendRequest(put, Vendors.class);
    }

    public String checkAdCostHeartBeat(){
        StringBuilder address = new StringBuilder(TestsContext.getInstance().adcostCore.toString());
        HttpGet get = new HttpGet(address.append("/status").toString());
        return sendRequest(get);
    }

    public Vendors getVendorDetails(String id){
        StringBuilder address = new StringBuilder(TestsContext.getInstance().adcostCore.toString());
        address.append("/v1/vendors/").append(id).append("?").append(adcostAuthId);
        HttpGet get = new HttpGet(address.toString());
        Type type = new TypeToken<Vendors>() { }.getType();
        return sendRequest(get, type);
    }

    public void getCommandSpecificDetails(String logger){
        ChannelExec channel = null;
        Session session = null;
        FileWriter fw = null;
        String fileName = "adcost-performance-logFile.log";
        String hostIp= TestsContext.getInstance().adcostFrontUrl.toString().replace("http://","");
        String userName = "qa-test";
        String pwd = "qwerty";
        try{
            JSch jsch=new JSch();
            session = jsch.getSession(userName, hostIp, 22);
            session.setPassword(pwd);

            java.util.Properties config = new java.util.Properties();
            config.put("StrictHostKeyChecking", "no");
            session.setConfig(config);
            UserInfo ui=new MyUserInfo();
            session.setUserInfo(ui);
            session.connect();

            channel=(ChannelExec)session.openChannel("exec");
            channel.setCommand("top");
            channel.setPty(true);
            channel.setInputStream(null);
            channel.setErrStream(System.err);
            channel.connect();

            Scanner scanner = new Scanner(new InputStreamReader(channel.getInputStream()));
            String path = (TestsContext.getInstance().testDataFolderName + "/" + fileName).replace("\\", "/");
            File file = new File(path);
            try {
                path = file.getCanonicalPath();
            } catch (IOException e) {
                e.printStackTrace();
            }

            fw = new FileWriter(path, true);
            fw.write(logger);
            int counter=1;
            while(scanner.hasNextLine()){
                if(counter<=20) { // just get first 20 lines
                    counter++;
                    fw.write(scanner.nextLine());
                } else break;
            } fw.close();
        } catch (JSchException | IOException e ) {
            System.out.println(e.getMessage());
        }
        finally {
            if (channel != null) {
                channel.disconnect();
            }
            if (session != null) {
                session.disconnect();
            }
        }
    }

    public String getUserRoleInCostModule(String email){
        StringBuilder address = new StringBuilder(TestsContext.getInstance().adcostCore.toString());
        if(authId.equalsIgnoreCase("id-null"))
            address.append("/v1/users/search?").append(adcostAuthId);
        else
            address.append("/v1/users/search?$id$=").append(authId.replace("id-",""));
        JsonObject searchText = new JsonObject();
        searchText.addProperty("searchText",email);
        HttpPost post = createPost(address.toString(), searchText.toString());
        String response = sendRequest(post);
        JsonParser jsonParser = new JsonParser();
        JsonElement element1 = jsonParser.parse(response).getAsJsonObject();
        JsonObject object1 = element1.getAsJsonObject();
        JsonElement element2 =object1.getAsJsonArray("users").get(0);
        JsonObject object2 = element2.getAsJsonObject();
        JsonElement element3 =object2.getAsJsonArray("businessRoles").get(0);
        return element3.getAsJsonObject().get("value").toString().replace("\"","").trim();
    }

    /** NEW LIB **/
    public AssetFilter createAssetFilterNEWLIB(String name, String subtype, String query,String assetId) {
        JsonObject common = new JsonObject();
        JsonArray arr = new JsonArray();
        common.addProperty("name", name);
        common.addProperty("query", query);
        JsonObject cm = new JsonObject();
        cm.add("common", common);
        JsonObject request = new JsonObject();
        request.add("_cm", cm);
        request.addProperty("_subtype", subtype);
        HttpPost post = createPost(baseUrl + "asset/filter?with=permissions&$id$=" + authId, request.toString());
        return sendRequest(post, AssetFilter.class);

    }


    public void addAssetToReel(String reelId,String assetId) {
        JsonPrimitive asset_id = new JsonPrimitive(assetId);
        JsonObject request = new JsonObject();
        JsonArray listArray = new JsonArray();
        listArray.add(asset_id);
        request.add("assetIds", listArray);
        HttpPut put = createPut(baseUrl + "presentation/"+reelId+"/add?$id$=" + authId,request.toString());
        sendRequest(put);

    }

    /** NEW LIB **/
    public AssetFilter addAssetToCollection(String name, String subtype, String query,String collectionId,String assetId){
        JsonObject common = new JsonObject();
        JsonArray arr = new JsonArray();
        common.addProperty("name", name);
        common.addProperty("query", query);
        JsonObject cm = new JsonObject();
        cm.add("common", common);
        if(assetId == null)
            cm.addProperty("emptyByDefault", false);
        JsonObject request = new JsonObject();
        request.add("_cm", cm);
        request.addProperty("_subtype", subtype);
        HttpPut put = createPut(baseUrl + "asset/filter/"+collectionId +"/add?asset_id="+assetId+"&$id$=" + authId,"{}");
        return sendRequest(put, AssetFilter.class);
    }

    public void acceptAssetsFromCollection(String collectionId,String[] assetIds){
        JsonObject request = new JsonObjectBuilder()
                .addArray("assetsIds", assetIds)
                .build();
        HttpPost post = createPost(baseUrl + "inbox/"+collectionId +"/accept?$id$=" + authId,request.toString());
        sendRequest(post);
    }

    public static class MyUserInfo implements UserInfo, UIKeyboardInteractive {
        public String getPassword() {  return null; }
        public boolean promptYesNo(String str) { return false; }
        public String getPassphrase() { return null; }
        public boolean promptPassphrase(String message) { return true; }
        public boolean promptPassword(String message) { return false; }
        public void showMessage(String message) { }
        public String[] promptKeyboardInteractive(String destination, String name, String instruction, String[] prompt, boolean[] echo) { return null; }
    }

    /** MEDIA MANAGER **/
    public PAPIApplication[] listApplications(String email){
        String jsonString = null;
        String nameParam = null;
        String emailParam = null;
        try {
            nameParam = URLEncoder.encode("[name]", "UTF-8");
            emailParam = URLEncoder.encode(email, "UTF-8");
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        StringBuilder address = new StringBuilder(TestsContext.getInstance().applicationUrl.toString());
        address.append("/api/v2/applications?query").append(nameParam).append("=").append(emailParam);
        HttpGet get = new HttpGet(address.toString());

        try {
            String generateTokenURL = TestsContext.getInstance().applicationUrl.toString() + "/api/v2/auth/token?" +
                    "key=5523cafcbc2668dc030ddd1e"+
                    "&secret=VSPK0LwmaNwDDd0eeusIcwodLh49nQ00";
            HttpGet r = new HttpGet(generateTokenURL);
            CloseableHttpClient httpClient = HttpClientBuilder.create().build();
            HttpResponse response = httpClient.execute(r);
            jsonString = EntityUtils.toString(response.getEntity());
        } catch (IOException e) {
            System.out.println(e.getCause());
        }

        get.addHeader("Authorization",jsonString.split("\",\"hash\":\"")[1].split("\"}")[0]);
        return gson.fromJson(sendRequest(get), PAPIApplication[].class);

    }

    public PAPIApplication generatePAPIKeySecret(String email, String id){
        String jsonString = null;

        JsonObject request = new JsonObjectBuilder().build();
        request.addProperty("name",email);
        request.addProperty("role","user");
        request.addProperty("trusted","false");
        request.addProperty("description","Key Secret creation");
        request.addProperty("user",id);

        HttpPost post = createPost(TestsContext.getInstance().applicationUrl.toString() + "/api/v2/applications",request.toString());
        try {
            String generateTokenURL = TestsContext.getInstance().applicationUrl.toString() + "/api/v2/auth/token?" +
                    "key=5523cafcbc2668dc030ddd1e"+
                    "&secret=VSPK0LwmaNwDDd0eeusIcwodLh49nQ00";
            HttpGet r = new HttpGet(generateTokenURL);
            CloseableHttpClient httpClient = HttpClientBuilder.create().build();
            HttpResponse response = httpClient.execute(r);
            jsonString = EntityUtils.toString(response.getEntity());
        } catch (IOException e) {
            System.out.println(e.getCause());
        }

           post.addHeader("Authorization",jsonString.split("\",\"hash\":\"")[1].split("\"}")[0]);
          return gson.fromJson(sendRequest(post),PAPIApplication.class);
    }


    public AQAReport getQCReportDataView(String fileId, String currentUserEmail){
        StringBuilder address = new StringBuilder(TestsContext.getInstance().mediamanager_core_url.toString());
        address.append("/v1/file/"+fileId+"/aqa-report");
        HttpGet request = new HttpGet(address.toString());
        request.addHeader("X-UserId" ,currentUserEmail);
        request.addHeader("X-UserEmail" ,currentUserEmail);
        return sendRequest(request,AQAReport.class);
    }



    public CostOwners[] getCostOwnersforCostId(String costId){
        StringBuilder address = new StringBuilder(TestsContext.getInstance().adcostCore.toString());
        address.append("/v1/costs/").append(costId).append("/owners?").append(adcostAuthId);
        HttpGet get = new HttpGet(address.toString());
        Type type = new TypeToken<CostOwners[]>() { }.getType();
        return sendRequest(get,type);
    }

    public Boolean checkAssetDownloaded_newlibrary(String assetName,String assetId,String assetType){
        JsonObject downloadRequest= new JsonObject();
        AssetDowload assetDowload = new AssetDowload();
        assetDowload.setGuises(assetType.split(","));
        assetDowload.setDocuments(assetId.split(","));
        assetDowload.setAssets(assetId.split(","));
        HttpPost post = createPost( TestsContext.getInstance().coreUrl[0]+ "/asset/download/archive?$id$="+ authId,gson.toJson(assetDowload));
        String response =sendRequest(post);
        return checkDownloadableAsset(response,assetType,assetName);
    }

    public Boolean checkAssetDownloadedSendplus(String assetId,String assetType){
        JsonObject downloadRequest= new JsonObject();
        AssetDowload assetDowload = new AssetDowload();
        assetDowload.setGuises(assetType.split(","));
        assetDowload.setDocuments(assetId.split(","));
        assetDowload.setAssets(assetId.split(","));
        HttpPost post = createPost(baseUrl + "/plugins/nverge/assets/download?$id$="+ authId,gson.toJson(assetDowload));
        String response =sendRequest(post);
        return checkDownloadableAsset_sendplus(response);
    }

    private Boolean checkDownloadableAsset(String response,String targetName,String assetName){
        Boolean checkZipCreated=false;
        JsonObject obj= new JsonParser().parse(response).getAsJsonObject();
        JsonArray jsonArray=obj.getAsJsonArray("files");
        String[] fileNames=targetName.split(",");
        for(int j=0;j<fileNames.length;j++)
        for (int i = 0; i < jsonArray.size(); i++)
           checkZipCreated=checkZipCreated || (jsonArray.get(i).getAsJsonObject().get("fileName").getAsString().equalsIgnoreCase(assetName.substring(0,assetName.indexOf(".")).concat("_"+fileNames[j]).concat(assetName.substring(assetName.indexOf(".")))));
        String archiveName=obj.getAsJsonPrimitive("archiveName").getAsString();
        String zipFile=targetName.replace(",","_").toString().concat(".zip");
        checkZipCreated=archiveName.equalsIgnoreCase(zipFile);
        return checkZipCreated;
    }

    private Boolean checkDownloadableAsset_sendplus(String response){
        Boolean checkDownload=false;
        JsonObject obj= new JsonParser().parse(response).getAsJsonObject();
        checkDownload=obj.get("result").getAsString().equalsIgnoreCase("Ok");
        return checkDownload;
    }

    public Boolean checkStoryBoardDownload(String assetId,String[] fileIds){
        StringBuilder address = new StringBuilder(TestsContext.getInstance().coreUrl[0] +"/asset/").append(assetId).append("/storyboards/createZip?$id$=").append(authId).append("&$originId$=").append("id-4ef31ce1766ec96769b399c0");
        HttpPost post = createPost(address.toString(),"");
        StoryBoardDownload response =sendRequest(post, StoryBoardDownload.class);
        String[] actualFileIds = response.getFileIds();
        log.info("fileIds ====> " + Arrays.toString(fileIds));
        log.info("actualFileIds ====> " +  Arrays.toString(actualFileIds));
        Arrays.sort(fileIds);
        Arrays.sort(actualFileIds);
        return Arrays.equals(fileIds,actualFileIds) && response.getDocuments()[0].equals(assetId);
    }


    public String getNewLibraryMiddleTierVersion(){
        return null;
    }
    public String getNewLibraryWebappVersion(){
        return null;
    }

    public String uploadDocument_WorkRequest(GDNFileWrapper fileWrapper){
        JsonObject obj = new JsonObject();
        JsonArray array= new JsonArray();
        JsonObject finalobj = new JsonObject();
        obj.addProperty("externalID",fileWrapper.getExternalId());
        obj.addProperty("fileName",fileWrapper.getName());
        obj.addProperty("size",fileWrapper.getSize());
        array.add(obj);
        finalobj.add("files",array);
        HttpPost post =createPost(TestsContext.getInstance().coreUrl[0] +"/fs/upload/register?$id$="+authId,finalobj.toString());
        String response =sendRequest(post);
        JsonObject jobject = new JsonParser().parse(response).getAsJsonObject();
        return jobject.getAsJsonArray("files").get(0).getAsJsonObject().getAsJsonPrimitive("fileUri").getAsString();
    }

    public BaseObject UploadComplete_WorkRequest(String projectFolderId,String brieffileId,String fileName){
        String briefFolderId=getBriefFolderId(projectFolderId);
        JsonObject request = new JsonObjectBuilder()
                .add("_subtype", "element")
                .forNode("_cm.common")
                .add("name", fileName)
                .build();
        HttpPost post = createPost(TestsContext.getInstance().coreUrl[0] + "/project/content/" + briefFolderId + "/uplcomplete/"+brieffileId + "?$id$=" + authId, request.toString());
        return sendRequest(post, BaseObject.class);
    }

    private String getBriefFolderId(String projectFolderId){
        JsonObject request = new JsonObjectBuilder()
                .add("_subtype", "folder")
                .forNode("_cm.common")
                .add("name", "Brief")
                .build();
        HttpPost post = createPost(TestsContext.getInstance().coreUrl[0] + "/project/content/" + projectFolderId + "?$id$=" + authId +"&$originId$=" +"id-4ef31ce1766ec96769b399c0",request.toString());
        String response = sendRequest(post);
        JsonParser jsonParser = new JsonParser();
        JsonObject jo = (JsonObject)jsonParser.parse(response);
        return jo.get("_id").toString().replace("\"", "");

    }

    public String getAdditionalServiceStatusFromTraffic(String orderReference, String qcAssetId, String destination,String serviceType)throws IOException{
       return null;
    }

    public String getOrderItemA5ViewStatusfromTrafficForClones(String orderId,String destination){
        StringBuilder address = new StringBuilder(baseUrl);
        address.append("ordering/").append(orderId).append("?$id$=").append(authId);
        HttpGet get = new HttpGet(address.toString());
        String responseBody =  sendRequest(get);
        String a5ViewStatus= null;
        JsonArray jsonArray=new JsonParser().parse(responseBody).getAsJsonObject().get("deliverables").getAsJsonObject().get("items").getAsJsonArray().get(0).getAsJsonObject().get("_cm").getAsJsonObject().get("destinations").getAsJsonObject().get("items").getAsJsonArray();
        for (JsonElement obj:jsonArray){
            if(obj.getAsJsonObject().get("name").getAsString().equalsIgnoreCase(destination)) {
                a5ViewStatus=obj.getAsJsonObject().get("viewStatus").getAsString();
            }
        }

        return a5ViewStatus;
    }
}