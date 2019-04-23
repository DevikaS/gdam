package com.adstream.automate.babylon.middleware;

import com.adstream.automate.babylon.*;
import com.adstream.automate.babylon.JsonObjects.*;
import com.adstream.automate.babylon.JsonObjects.activity.ActivityQuery;
import com.adstream.automate.babylon.JsonObjects.activity.ActivityType;
import com.adstream.automate.babylon.JsonObjects.activity.Pager;
import com.adstream.automate.babylon.JsonObjects.adcost.*;
import com.adstream.automate.babylon.JsonObjects.approval.Approval;
import com.adstream.automate.babylon.JsonObjects.approval.ApprovalStage;
import com.adstream.automate.babylon.JsonObjects.dictionary.Dictionary;
import com.adstream.automate.babylon.JsonObjects.dictionary.DictionaryItem;
import com.adstream.automate.babylon.JsonObjects.dictionary.DictionaryType;
import com.adstream.automate.babylon.JsonObjects.dictionary.DictionaryValues;
import com.adstream.automate.babylon.JsonObjects.gdn.*;
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
import com.adstream.automate.babylon.core.BabylonCoreService;
import com.adstream.automate.babylon.core.BatchTaskApi;
import com.adstream.automate.babylon.utils.SignatureCreator;
import com.adstream.automate.utils.Common;
import com.adstream.gdn.api.client.serialization.Job;
import com.adstream.gdn.api.client.serialization.JobResponse;
import com.google.gson.*;
import com.google.gson.reflect.TypeToken;
import org.apache.commons.lang.StringEscapeUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.http.HttpResponse;
import org.apache.http.client.methods.*;
import org.joda.time.DateTime;

import javax.annotation.Nullable;
import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.lang.reflect.Type;
import java.net.URL;
import java.util.*;

/**
 * User: ruslan_semerenko
 * Date: 02.04.12 15:17
 */
public class BabylonMiddlewareService extends BabylonMessageSender implements BabylonService, BabylonMonoService, PaperPusherService {
    private BabylonCoreService coreService;

    private BabylonCoreService getCoreService() {
        if (coreService == null) {
            try {
                MiddlewareCurrent current = getCurrent();
                URL url = new URL(baseUrl);
                coreService = new BabylonCoreService(new URL(url.getProtocol() + "://" + url.getHost() + ":8080/"));
                coreService.auth(current.getUser().getEmail(), current.getUser().getSubtype().equals("global.administrator") ? "abcdefghA1" : "1");
            } catch (Exception e) { e.printStackTrace(); }
        }
        return coreService;
    }

    @Override
    public BaseObject getObjectIdentity(String objectId) {
        throw new UnsupportedOperationException("Not implemented yet");
    }

    @Override
    public String getVersion() {
        HttpGet get = new HttpGet(baseUrl + "version.js");
        String result = sendRequest(get);
        int start = result.indexOf("'") + 1;
        int end = result.indexOf("'", start);
        return result.substring(start, end);
    }

    @Override
    public String getAdcostVersion(){
        return null;
    }

    @Override
    public String getBranch() {
        HttpGet get = new HttpGet(baseUrl + "version.js");
        String result = sendRequest(get);
        int start = result.indexOf("'") + 1;
        int end = result.indexOf("'", start);
        return result.substring(start, end);
    }

    @Override
    public void rebuildIndex() {
        rebuildIndex(null, null, null);
    }

    @Override
    public void rebuildIndex(String[] indexType, String[] agencyId, Integer batchSize) {
        getCoreService().rebuildIndex(indexType, agencyId, batchSize);
    }

    @Override
    public ProjectTermsAndConditions getProjectTermsAndConditions(String projectId) { return null; }

    public BabylonMiddlewareService(URL url) {
        super(url);
        contentType = "application/json";
    }

    @Override
    public Dictionary getDictionary(DictionaryType type) {
        return getAgencyDictionaryByName("global", type.toString());
    }

    @Override
    public Dictionary getAgencyDictionaryByName(String agencyId, String dictionaryName) {
        String key = String.format("agencies/%s/schemaDictionaries/%s", agencyId, dictionaryName);
        HttpGet get = new HttpGet(baseUrl + "svc/" + key + "?depth=0");
        String response = sendRequest(get);
        JsonObject result = new JsonParser().parse(response).getAsJsonObject();
        CustomMetadata mtDictionary = gson.fromJson(result.get(key), CustomMetadata.class);

        DictionaryValues values = new DictionaryValues();
        parseDictionaryValuesRecursive(values, mtDictionary.getOrCreateNode("values"));
        Dictionary dictionary = new Dictionary();
        dictionary.setId(mtDictionary.getString("_id"));
        dictionary.setName(mtDictionary.getString("name"));
        dictionary.setDocumentType(mtDictionary.getString("_documentType"));
        dictionary.setVersion(mtDictionary.getInteger("_version"));
        dictionary.setValues(values);

        return dictionary;

    }

    @Override
    public Dictionary createAgencyDictionary(String agencyId, String dictionaryName, List<CustomMetadata> values) {
        return getCoreService().createAgencyDictionary(agencyId, dictionaryName, values);
    }

    @Override
    public Dictionary updateAgencyDictionaryValues(String agencyId, String dictionaryName, List<CustomMetadata> values) {
        throw new UnsupportedOperationException("Not implemented yet");
    }

    @Override
    public Dictionary updateAgencyDictionary(String agencyId, String dictionaryName, DictionaryValues values) {
        String key = String.format("agencies/%s/schemaDictionaries/%s", agencyId, dictionaryName);
        Dictionary dictionary = getAgencyDictionaryByName(agencyId, dictionaryName);

        CustomMetadata mtValues = new CustomMetadata();
        parseDictionaryMtValuesRecursive(mtValues, values);

        JsonObject request = new JsonObject();
        JsonObject inner = new JsonObject();
        inner.addProperty("_id", dictionary.getId());
        inner.addProperty("name", dictionary.getName());
        inner.addProperty("_documentType", dictionary.getDocumentType());
        inner.addProperty("_version", dictionary.getVersion());
        inner.add("values", gson.toJsonTree(mtValues));

        request.add(key, inner);

        String response = sendRequest(createPut(baseUrl + "svc/" + key, request.toString()));
        JsonObject result = new JsonParser().parse(response).getAsJsonObject();
        CustomMetadata mtDictionary = gson.fromJson(result.get(key), CustomMetadata.class);

        DictionaryValues updatedValues = new DictionaryValues();
        parseDictionaryValuesRecursive(updatedValues, mtDictionary.getOrCreateNode("values"));
        Dictionary updatedDictionary = new Dictionary();
        updatedDictionary.setId(mtDictionary.getString("_id"));
        updatedDictionary.setName(mtDictionary.getString("name"));
        updatedDictionary.setDocumentType(mtDictionary.getString("_documentType"));
        updatedDictionary.setVersion(mtDictionary.getInteger("_version"));
        updatedDictionary.setValues(updatedValues);

        return updatedDictionary;
    }

    @Override
    public String copyFolder(List folderIds, String newParentId, boolean updateMetadata) {
        throw new UnsupportedOperationException("Not implemented yet");
    }

    @Override
    public String moveFolder(List folderIds, String newParentId, boolean updateMetadata) {
        throw new UnsupportedOperationException("Not implemented yet");
    }

    @Override
    public String auth(String email, String password) {
        contentType = "application/x-www-form-urlencoded";
        Map<String, String> authParams = new HashMap<String, String>();
        authParams.put("username", email);
        authParams.put("password", password);
        String response = sendRequest(createPost(baseUrl + "login", createQueryString(authParams)));
        contentType = "application/json";
        return response;
    }

    public String adcostAuth(String email){return null;}

    @Override
    public String impersonate(String email, String comment) {
        JsonObject query = new JsonObjectBuilder()
                .forNode("impersonate.@1")
                .add("email", email)
                .add("comment", comment)
                .build();
        HttpPost post = createPost(baseUrl + "svc/impersonate?", query.toString());
        sendRequest(post);
        return "";
    }

    @Override
    public String authSSO(String email, String password) {
        try {
            String contentTypeOld = contentType;
            String samlResponse = logInCosmos(email, password);
            sendSSORequest(samlResponse);
            contentType = contentTypeOld;
            return "";
        } catch (RuntimeException e) {
            throw new RuntimeException(String.format("Could not login as user '%s' with password '%s'", email, password), e);
        }
    }

    @Override
    public String loginToSendplusMiddleTier(String emailID, String passWord) throws IOException {
        return "";
    }

    @Override
    public void addAssetToReel(String reelId,String assetId) {
        throw new UnsupportedOperationException("Implementation not needed");
    }

    @Override
    public HashMap<String, String> assetAttachmentViaSendplus(String cookie,String assetId,String fname,int fsize) throws IOException {
        HashMap<String, String> hmap = new HashMap<String, String>();
        return hmap;
    }

    @Override
    public  HashMap<String, String> createFileIDForSendplusUploadToProjects(String cookie,String folderId) throws IOException {
        HashMap<String, String> hmap = new HashMap<String, String>();
        return hmap;
    }

    @Override
    public  void downloadFolderAndProjectViaUsingSendplusMiddletier(String cookie, String elementID, String fileID) throws IOException {

    }

    @Override
    public HashMap<String, String> createFileIDForSendplusUploadToLibrary(String cookie) throws IOException {
        HashMap<String, String> hmap = new HashMap<String, String>();
        return hmap;
    }


    @Override
    public HashMap<String, String> uploadFileRevisionViaSendplus(String cookie,String fileId,String fname,int fsize) throws IOException {
        HashMap<String, String> hmap = new HashMap<String, String>();
        return hmap;
    }

    @Override
    public HashMap<String, String> uploadFileAttachmentViaSendplus(String cookie,String fileId,String fname,int fsize) throws IOException {
        HashMap<String, String> hmap = new HashMap<String, String>();
        return hmap;
    }

    @Override
    public void uploadFileToAdbankStorageViaSendplusMiddleTier(String uploadURL,File file) throws IOException {

    }

    @Override
    public void displayFileInProjectsViaSendplusMiddleTier(String cookie, String uploadID,String folderId) throws IOException {

    }

    @Override
    public void displayFileInLibraryViaSendplusMiddleTier(String cookie, String uploadID) throws IOException {

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


    protected String logInCosmos(String email, String password) {
        final String LOGIN_FORM_ACTION = "id=\"externalLoginForm\" action=\"";
        final String SIGNATURE_ALG = "http://www.w3.org/2000/09/xmldsig#rsa-sha1";
        final String SAML = "name=\"SAMLRequest\" value=\"";

        contentType = "application/x-www-form-urlencoded";
        clearCookies();
        //HttpGet get = new HttpGet(getCosmosUrl());
        HttpGet get = new HttpGet(String.valueOf(getBaseUrl()));
        String loginFormBody = sendRequest(get);
        int actionStart = loginFormBody.indexOf(LOGIN_FORM_ACTION) + LOGIN_FORM_ACTION.length();
        int actionEnd = loginFormBody.indexOf("\"", actionStart);
        String actionUrl = loginFormBody.substring(actionStart, actionEnd);
        String samlRequest = "";
//        for (String param : uri.getQuery().split("&")) {
//            String[] parts = param.split("=", 2);
//            if (parts[0].equals("SAMLRequest")) {
//                samlRequest = parts[1];
//                break;
//            }
//        }

        //Pick SAML from the response rasther than the request parameters
        int samlStart = loginFormBody.indexOf(SAML) + SAML.length();
        int samlEnd = loginFormBody.indexOf("\"", samlStart);
        samlRequest = loginFormBody.substring(samlStart, samlEnd);
//        URI uri = get.getURI();
//        StringBuilder authUrl = new StringBuilder(uri.getScheme());
//        authUrl.append("://").append(uri.getHost());
//        if (uri.getPort() != -1) {
//            authUrl.append(":").append(uri.getPort());
//        }
        //Build cosmose Url from proprty file as it no longer exists in the response. All IP addresses are hidden
        String authUrl = (TestsContext.getInstance().ssourl).toString().concat(actionUrl);
        StringBuilder authRequest = new StringBuilder();
        authRequest.append("SAMLRequest=").append(Common.urlEncode(samlRequest));
        authRequest.append("&RelayState=").append(Common.urlEncode("/"));
        authRequest.append("&SigAlg=").append(Common.urlEncode(SIGNATURE_ALG));
        //sign part of url and append
        String signature = SignatureCreator.sign(authRequest.toString());
        authRequest.append("&Signature=").append(Common.urlEncode(signature));
        authRequest.append("&username=").append(Common.urlEncode(email));
        authRequest.append("&password=").append(Common.urlEncode(password));

        HttpPost post = createPost(authUrl.toString(), authRequest.toString());
        return getSamlResponse(sendRequest(post));
    }

    @Override
    public void logoutSSO() {
        String contentTypeOld = contentType;
        contentType = "application/x-www-form-urlencoded";
        HttpGet get = new HttpGet(baseUrl + "logout");
        String samlResponse = getSamlResponse(sendRequest(get));
        sendSSORequest(samlResponse);
        contentType = contentTypeOld;
    }

    private String getCosmosUrl() {
        final String URL_LOCATION = "window.location = \"";

        HttpGet get = new HttpGet(baseUrl);
        String response = sendRequest(get);
        URL cosmos = TestsContext.getInstance().ssourl;
        int start = response.indexOf(URL_LOCATION) + URL_LOCATION.length();
        int end = response.indexOf("\"", start);
        return response.substring(start, end);
    }

    private String getSamlResponse(String body) {
        final String SAML_RESPONSE_VALUE = "name=\"SAMLResponse\" value=\"";
        int samlResponseStart = body.indexOf(SAML_RESPONSE_VALUE) + SAML_RESPONSE_VALUE.length();
        if (samlResponseStart < SAML_RESPONSE_VALUE.length()) {
            throw new RuntimeException("Could not find SAML response");
        }
        int samlResponseEnd = body.indexOf("\"", samlResponseStart);
        return body.substring(samlResponseStart, samlResponseEnd);
    }

    public void sendSSORequest(String samlResponse) {
        StringBuilder ssoRequest = new StringBuilder();
        ssoRequest.append("SAMLResponse=").append(Common.urlEncode(samlResponse)).append("&RelayState=/");
        HttpPost post = createPost(baseUrl + "ssoRequest", ssoRequest.toString());
        sendRequest(post);
    }

    @Override
    public User getUser(String userId) {
        String key = "users/" + userId;
        HttpGet get = new HttpGet(baseUrl + "svc/" + key + "?depth=1");
        String response = sendRequest(get);
        JsonObject obj = new JsonParser().parse(response).getAsJsonObject().getAsJsonObject(key);
        return gson.fromJson(obj, User.class);
    }

    private MiddlewareCurrent getCurrent() {
        Type type = new TypeToken<Map<String, MiddlewareCurrent>>(){}.getType();
        Map<String, MiddlewareCurrent> response = sendRequest(new HttpGet(baseUrl + "svc/current"), type);
        return response.get("current");
    }

    @Override
    public User getCurrentUser() {
        return getCurrent().getUser();
    }

    @Override
    public SearchResult<User> findUsers(LuceneSearchingParams query) {
        StringBuilder address = new StringBuilder(baseUrl);
        address.append("svc/usersSearch?sort=_cm.common.firstName&depth=1").append(query.toGetParams());

        HttpGet get = new HttpGet(address.toString());
        String response = sendRequest(get);
        JsonObject obj = new JsonParser().parse(response).getAsJsonObject().getAsJsonObject("usersSearch");
        List<User> users = new ArrayList<>();
        boolean more = false;
        int total = 0;
        for (Map.Entry<String, JsonElement> entry : obj.entrySet()) {
            if (entry.getKey().equals("_")) {
                JsonObject extra = ((JsonObject) entry.getValue()).getAsJsonObject("extra");
                more = extra.getAsJsonPrimitive("more").getAsBoolean();
                total = extra.getAsJsonPrimitive("total").getAsInt();
            } else {
                users.add(gson.fromJson(entry.getValue(), User.class));
            }
        }
        SearchResult<User> result = new SearchResult<>();
        result.setResult(users);
        result.setMore(more);
        result.setTotal(total);
        return result;
    }

    @Override
    public SearchResult<User> findUsers(LuceneSearchingParams query, With with) {
        return findUsers(query);
    }

    @Override
    public void createXMPMapping(String agencyId, List<XMPMapping> postMapping) {
    }

    public User createGlobalAdminUser(String groupId, User user){return null;}

    public User editGlobalAdminUser(String groupId, User user){return null;}

    public List<String> getGlobalAdminUsers(){return null;}

    @Override
    public User createUser(String groupId, User user) {
        JsonObject access = new JsonObject();
        access.addProperty("folders", user.hasFoldersAccess());
        access.addProperty("library", user.hasLibraryAccess());
        access.addProperty("ordering", user.hasDeliveryAccess());

        JsonObject view = new JsonObject();
        view.add("access", access);

        JsonObject common = new JsonObject();
        common.addProperty("firstName", user.getFirstName());
        common.addProperty("lastName", user.getLastName());
        common.addProperty("jobTitle", user.getJobTitle());
        common.addProperty("email", user.getEmail());
        common.addProperty("phoneNumber", user.getPhoneNumber());
        common.addProperty("mobileNumber", user.getMobileNumber());
        common.addProperty("skypeNumber", user.getSkypeNumber());
        common.addProperty("gTalkContact", user.getGoogleTalkContact());

        JsonObject cm = new JsonObject();
        cm.add("view", view);
        cm.add("common", common);

        JsonObject inner = new JsonObject();
        inner.add("subscriptions", new JsonObject());
        inner.add("_cm", cm);
        inner.add("roles", gson.toJsonTree(user.getRoles()));
        inner.addProperty("password", user.getPassword());
        inner.addProperty("agencyId", user.getAdvertiser());

        JsonObject users = new JsonObject();
        users.add("@3", inner);

        JsonObject request = new JsonObject();
        request.add("users", users);

        HttpPost post = createPost(baseUrl + "svc/users?size=7&page=1&depth=1", request.toString());
        String response = sendRequest(post);
        JsonObject result = new JsonParser().parse(response).getAsJsonObject();
        for (Map.Entry<String, JsonElement> entry : result.entrySet()) {
            if (entry.getKey().startsWith("users")) {
                return gson.fromJson(entry.getValue(), User.class);
            }
        }
        return null;
    }

    @Override
    public User updateUser(String userId, User newUser) {
        JsonObject request = new JsonObject();
        request.add("users/" + userId, gson.toJsonTree(newUser));

        HttpPut put = createPut(baseUrl + "svc/users/" + userId + "?sort=_cm.common.firstName&size=7&page=1", request.toString());
        String response = sendRequest(put);
        JsonObject result = new JsonParser().parse(response).getAsJsonObject();
        for (Map.Entry<String, JsonElement> entry : result.entrySet()) {
            if (entry.getKey().startsWith("users")) {
                return gson.fromJson(entry.getValue(), User.class);
            }
        }
        return null;
    }

    @Override
    public void deleteUser(String userId, String reassignDataToUserId) {
        throw new UnsupportedOperationException("Not implemented yet");
    }

    @Override
    public User inviteUser(String email) {
        throw new UnsupportedOperationException("Not implemented yet");
    }

    @Override
    public void addExistingUserToAgency(String userId, String agencyId, String roleId) {
    }

    @Override
    public String getElasticSearchRebuildTime() {
        return getCoreService().getElasticSearchRebuildTime();
    }


    @Override
    public AssetSchema getAssetSchema(String agencyId) {
        throw new UnsupportedOperationException("Not implemented yet");
    }

    @Override
    public AssetSchema updateAssetSchema(String agencyId, AssetSchema schema) {
        throw new UnsupportedOperationException("Not implemented yet");
    }

    @Override
    public AssetElementCommonSchema getAssetElementCommonSchema(String agencyId) {
        throw new UnsupportedOperationException("Not implemented yet");
    }

    @Override
    public AssetElementCommonSchema updateAssetElementCommonSchema(String agencyId, AssetElementCommonSchema schema) {
        throw new UnsupportedOperationException("Not implemented yet");
    }

    @Override
    public ProjectSchema getProjectSchema(String agencyId) {
        throw new UnsupportedOperationException("Not implemented yet");
    }

    @Override
    public ProjectSchema updateProjectSchema(String agencyId, ProjectSchema schema) {
        throw new UnsupportedOperationException("Not implemented yet");
    }

    @Override
    public AssetElementProjectCommonSchema getAssetElementProjectCommonSchema(String agencyId) {
        throw new UnsupportedOperationException("Not implemented yet");
    }

    @Override
    public AssetElementProjectCommonSchema updateAssetElementProjectCommonSchema(String agencyId, AssetElementProjectCommonSchema schema) {
        throw new UnsupportedOperationException("Not implemented yet");
    }

    @Override
    public BaseObject getHead() {
        return getCoreService().getHead();
    }

    @Override
    public BaseObject getGroup(String groupId) {
        throw new UnsupportedOperationException("Not implemented yet");
    }

    @Override
    public <T> SearchResult<T> getChildren(String groupId, String type) {
        throw new UnsupportedOperationException("Not implemented yet");
    }

    @Override
    public void addChild(String parentId, BaseObject child) {
        throw new UnsupportedOperationException("Not implemented yet");
    }

    @Override
    public void addChild(String parentId, String childId) {
        throw new UnsupportedOperationException("Not implemented yet");
    }

    @Override
    public void removeChild(String groupId, String childId) {
        throw new UnsupportedOperationException("Not implemented yet");
    }

    @Override
    public void removeChildren(String groupId, String... childrenId) {
        throw new UnsupportedOperationException("Not implemented yet");
    }

    @Override
    public BaseObject createGroup(String parentId, String name, String subtype) {
        throw new UnsupportedOperationException("Not implemented yet");
    }

    public BaseObject createLibraryTeam(String name) {
        JsonObject query = new JsonObjectBuilder()
                .forNode("teams.@5")
                .add("_subtype", "user_group")
                .forNode("_cm.common")
                .add("name", name)
                .build();
        HttpPost post = createPost(baseUrl + "svc/teams?prefix=&size=10&page=1", query.toString());
        String response = sendRequest(post);
        JsonObject responseObj = new JsonParser().parse(response).getAsJsonObject();
        for (Map.Entry<String, JsonElement> entry : responseObj.entrySet()) {
            if (entry.getKey().startsWith("teams")) {
                return gson.fromJson(entry.getValue(), BaseObject.class);
            }
        }
        return null;
    }

    public void addUsersToLibraryTeam(String teamId, List<String> usersId) {
        String key = "teams/" + teamId + "/users";
        JsonObjectBuilder query = new JsonObjectBuilder();
        for (int i = 0 ; i < usersId.size(); i++) {
            query.forRootNode().forNode(key).forNode("@" + (i + 6)).add("_id", usersId.get(i));
        }
        HttpPost post = createPost(baseUrl + "svc/" + key + "?", query.build().toString());
        sendRequest(post);
    }

    @Override
    public BaseObject updateGroup(String groupId, String newName) {
        throw new UnsupportedOperationException("Not implemented yet");
    }

    @Override
    public void deleteGroup(String groupId) {
        throw new UnsupportedOperationException("Not implemented yet");
    }

    @Override
    public byte[] getLogo(String objectType, String objectId) {
        HttpGet get = new HttpGet(baseUrl + "logo/find?documentId=" + objectId + "&documentType=" + objectType);
        return sendRequestRaw(get);
    }

    @Override
    public Agency createAgency(Agency agency) {
        JsonObject request = new JsonObjectBuilder()
                .forNode("agencies.@1")
                .add("_cm", gson.toJsonTree(agency.getCm()))
                .build();
        HttpPost post = createPost(baseUrl + "svc/agencies?prefix=&size=10&page=0", request.toString());
        String response = sendRequest(post);
        JsonObject agencyObj = new JsonParser().parse(response).getAsJsonObject();
        for (Map.Entry<String, JsonElement> entry : agencyObj.entrySet()) {
            if (entry.getKey().startsWith("agencies/")) {
                return gson.fromJson(entry.getValue(), Agency.class);
            }
        }
        return null;
    }

    @Override
    public Agency updateAgency(Agency agency) {
        throw new UnsupportedOperationException("Not implemented yet");
    }

    @Override
    public Agency getCurrentAgency() {
        return getCurrent().getAgency();
    }

    @Override
    public List<Agency> getAgencies() {
        int size = 10;
        int page = 0;
        String address = String.format("svc/agencies?agencyType=Advertiser&size=%d&page=%d&depth=1", size, page);
        HttpGet get = new HttpGet(baseUrl + address);
        Type returnType = new TypeToken<Map<String, Map<String, Agency>>>(){}.getType();
        Map<String, Map<String, Agency>> result = sendRequest(get, returnType);

        List<Agency> agencyList = new ArrayList<Agency>();

        for(Map.Entry<String, Agency> entry: result.get("agencies").entrySet()){
            if(!entry.getKey().equals("_")){
                agencyList.add(entry.getValue());
            }
        }

        return agencyList;
    }

    @Override
    public Agency getAgency(String agencyId) {
        String key = "agencies/" + agencyId;
        HttpGet get = new HttpGet(baseUrl + "svc/" + key + "?depth=0");
        String response = sendRequest(get);
        JsonObject obj = new JsonParser().parse(response).getAsJsonObject();
        if (obj.has(key)) {
            return gson.fromJson(obj.getAsJsonObject(key), Agency.class);
        }
        return null;
    }

    @Override
    public SearchResult<Agency> findAgencies(LuceneSearchingParams query) {
        String prefix = query.getQuery() == null ? "" : query.getQuery().split(":")[1].replace("\"", "");
        int size = query.getResultsOnPage() == null ? 10 : query.getResultsOnPage();
        int page = query.getPageNumber() == null ? 1 : query.getPageNumber();
        HttpGet get = new HttpGet(baseUrl + "svc/agenciesList?prefix=" + prefix + "*&size=" + size + "&page=" + page + "&depth=1");
        String response = sendRequest(get);
        JsonObject agenciesObj = new JsonParser().parse(response).getAsJsonObject().getAsJsonObject("agenciesList");
        List<Agency> agencies = new ArrayList<>();
        for (Map.Entry<String, JsonElement> entry : agenciesObj.entrySet()) {
            if (entry.getKey().equals("_")) {
                continue;
            }
            agencies.add(gson.fromJson(entry.getValue(), Agency.class));
        }
        SearchResult<Agency> result = new SearchResult<>();
        result.setResult(agencies);
        return result;
    }

    @Override
    public List<Agency> getAgenciesSimple() {
        throw new UnsupportedOperationException("Not implemented yet");
    }

    @Override
    public SearchResult<Agency> findAgenciesSimple(LuceneSearchingParams query) {
        throw new UnsupportedOperationException("Not implemented yet");
    }

    @Override
    public List<Agency> getPartnerAgencies(String agencyId) {
        throw new UnsupportedOperationException("Not implemented yet");
    }

    @Override
    public Agency addPartnerAgency(String agencyId, String partnerAgencyId, boolean canBill, boolean canView) {
        throw new UnsupportedOperationException("Not implemented yet");
    }

    @Override
    public void removePartnerAgency(String agencyId, String partnerAgencyId) {
        throw new UnsupportedOperationException("Not implemented yet");
    }

    @Override
    public void setUserRole(String agencyId, String userId, String[] rolesId) {
        throw new UnsupportedOperationException("Use setUserRole(User user, String roleId) instead");
    }

    public void setUserRole(User user, String roleId) {
        String address = baseUrl + "svc/users/" + user.getId() + "?sort=_cm.common.firstName&size=7&page=1&global=false";
        BaseObject oldRole = user.getRoles().length > 0 ? user.getRoles()[0] : null;
        JsonObject newRole = new JsonObject();
        newRole.addProperty("_id", roleId);
        if (oldRole != null) {
            newRole.addProperty("oldid", oldRole.getId());
        }
        JsonArray newRoles = new JsonArray();
        newRoles.add(newRole);
        JsonObject userObj = gson.toJsonTree(user).getAsJsonObject();
        userObj.remove("roles");
        userObj.add("roles", newRoles);
        JsonObject query = new JsonObject();
        query.add("users/" + user.getId(), userObj);
        HttpPut put = createPut(address, query.toString());
        sendRequest(put);
    }

    @Override
    public Content getAsset(String assetId) {
        HttpGet get = new HttpGet(baseUrl + "svc/assets/" + assetId + "?depth=0");
        String response = sendRequest(get);
        JsonObject obj = new JsonParser().parse(response).getAsJsonObject();
        for (Map.Entry<String, JsonElement> entry : obj.entrySet()) {
            if (entry.getKey().startsWith("assets")) {
                JsonObject assetObject = entry.getValue().getAsJsonObject();
                for (JsonElement revision : assetObject.getAsJsonArray("revisions")) {
                    if (revision.getAsJsonObject().has("preview")) {
                        JsonObject preview = revision.getAsJsonObject().remove("preview").getAsJsonObject();
                        JsonArray previewArray = new JsonArray();
                        previewArray.add(preview.getAsJsonObject("preview"));
                        previewArray.add(preview.getAsJsonObject("thumbnail"));
                        revision.getAsJsonObject().add("preview", previewArray);
                    }
                }
                return gson.fromJson(assetObject, Content.class);
            }
        }
        return null;
    }

    @Override
    public SearchResult<Content> findAssets(LuceneSearchingParams query) {
        throw new UnsupportedOperationException("Not implemented yet");
    }

    @Override
    public SearchResult<Content> findAssets(String parentId, LuceneSearchingParams query) {
        int pageNumber = query.getPageNumber() == null ? 1 : query.getPageNumber();
        int resultsOnPage = query.getResultsOnPage() == null ? 20 : query.getResultsOnPage();

        StringBuilder address = new StringBuilder(baseUrl);
        address.append("svc/assets?sort=_created&order=desc&deleted=false&query=&scroll=false&id=").append(parentId);
        address.append("&offset=").append(pageNumber);
        address.append("&count=").append(resultsOnPage);
        address.append("&size=").append(resultsOnPage).append("&global=false&depth=1");

        HttpGet get = new HttpGet(address.toString());
        String response = sendRequest(get);
        JsonObject map = new JsonParser().parse(response).getAsJsonObject().getAsJsonObject("assets");
        List<Content> assets = new ArrayList<>();
        for (Map.Entry<String, JsonElement> entry : map.entrySet()) {
            if (!entry.getKey().equals("_")) {
                JsonObject assetObject = entry.getValue().getAsJsonObject();
                for (JsonElement revision : assetObject.getAsJsonArray("revisions")) {
                    if (revision.getAsJsonObject().has("preview")) {
                        JsonObject preview = revision.getAsJsonObject().remove("preview").getAsJsonObject();
                        JsonArray previewArray = new JsonArray();
                        previewArray.add(preview.getAsJsonObject("preview"));
                        previewArray.add(preview.getAsJsonObject("thumbnail"));
                        revision.getAsJsonObject().add("preview", previewArray);
                    }
                }
                assets.add(gson.fromJson(assetObject, Content.class));
            }
        }
        SearchResult<Content> result = new SearchResult<>();
        result.setResult(assets);
        result.setMore(map.getAsJsonObject("_").getAsJsonObject("extra").getAsJsonPrimitive("more").getAsBoolean());
        return result;
    }

    @Override
    public SearchResult<Content> findAssetsForClient(String parentId, LuceneSearchingParams query,String userId) {
        return null;
    }

    @Override
    public SearchResult<Content> findAssets(String parentId) {
        return null;
    }

    @Override
    public SearchResult<Content> findAssets(String parentId, LuceneSearchingParams query, With with) {
        return null;
    }

    @Override
    public SearchResult<Content> findAssetsForClient(String parentId, LuceneSearchingParams query, With with,String userId) {
        return null;
    }


    @Override
    public AssetFilters getAssetFilters() {
        return getAssetFilters(null);
    }

    @Override
    public AssetFilters getAssetFiltersForClient(String userId) {
        throw new UnsupportedOperationException("Not implemented yet");
    }


    @Override
    public AssetFilters getAssetFiltersForClient(String subtype,String userId) {
        throw new UnsupportedOperationException("Not implemented yet");
    }


    @Override
    public AssetFilters getAssetFilters(String subtype) {
        String address = baseUrl + "svc/collections?depth=1" + (subtype == null ? "" : "&type=" + subtype);
        HttpGet get = new HttpGet(address);
        JsonObject response = new JsonParser().parse(sendRequest(get)).getAsJsonObject();
        List<AssetFilter> assetFiltersList = new ArrayList<>();
        for (Map.Entry<String, JsonElement> entry : response.getAsJsonObject("collections").entrySet()) {
            if (!entry.getKey().equals("_")) {
                assetFiltersList.add(gson.fromJson(entry.getValue(), AssetFilter.class));
            }
        }
        AssetFilters filters = new AssetFilters();
        filters.setFilters(assetFiltersList);
        return filters;
    }
       @Override
    public BaseObject getAssetFilterRootFolder() {
        throw new UnsupportedOperationException("Not implemented yet");
    }

    @Override
    public AssetFilter createAssetFilter(String name, String subtype, String query) {
        String body = String.format("{\"collections\":{\"@2\":{\"_cm\":{\"common\":{\"name\":\"%s\",\"query\":%s}},\"_subtype\":\"%s\"}}}",
                name, query, subtype);
        HttpPost post = createPost(baseUrl + "svc/collections?type=" + subtype, body);
        Type returnType = new TypeToken<Map<String, AssetFilter>>(){}.getType();
        Map<String, AssetFilter> response = sendRequest(post, returnType);
        for (String key : response.keySet()) {
            if (key.startsWith("collections")) {
                return response.get(key);
            }
        }
        return null;
    }

    @Override
    public AssetFilter createAssetFilterForClient(String name, String subtype, String query,String userId) {
        throw new UnsupportedOperationException("Not implemented yet");
    }

    @Override
    public void shareAssetFilter(String assetFilterId, String subjectId, String roleId) {
        JsonObject query = new JsonObjectBuilder()
                .forNode("shareMultiCollections")
                .add("responseContainer", "users")
                .forNode("shareBody")
                .addArray("assetFilterIds", assetFilterId)
                .forNode("context")
                .add("inheritance", true)
                .add("role", roleId)
                .addArray("to", subjectId)
                .add("withChildren", true)
                .build();
        HttpPut put = createPut(baseUrl + "svc/shareMultiCollections", query.toString());
        sendRequest(put);
    }

    @Override
    public void shareAssetFilter(String assetFilterId, String subjectId, String roleId, Boolean write, Long expiration) {
        throw new UnsupportedOperationException("Not implemented yet");
    }

    @Override
    public void unshareAssetFilter(String assetFilterId, String... subjectId) {
        HttpDelete delete = new HttpDelete(baseUrl + "/svc/collections/" + assetFilterId + "/users/" + subjectId[0]);
        sendRequest(delete);
    }

    @Override
    public AssetFilter updateAssetFilter(String assetFilterId, String name, String query) {
        throw new UnsupportedOperationException("Not implemented yet");
    }

    @Override
    public void deleteAssetFilter(String assetFilterId) {
        throw new UnsupportedOperationException("Not implemented yet");
    }

    @Override
    public SearchResult<Agency> getAssetFilterAgencies(String assetFilterId) {
        throw new UnsupportedOperationException("Not implemented yet");
    }

    @Override
    public SearchResult<BaseObject> getAssetFilterSubjects(String assetFilterId) {
        throw new UnsupportedOperationException("Not implemented yet");
    }

    @Override
    public AssetFilter addAssetsToNewCollection(List<String> assetIds, String collectionName) {
        String body = String.format("{\"collections\":{\"@1\":{\"_subtype\":\"asset_filter_collection\",\"_cm\":{\"common\":{\"name\":\"%s\"}},\"assetIds\":[\"%s\"]}}}",
                collectionName, StringUtils.join(assetIds, "\",\""));
        HttpPost post = createPost(baseUrl + "svc/collections?", body);
        Type returnType = new TypeToken<Map<String, AssetFilter>>(){}.getType();
        Map<String, AssetFilter> response = sendRequest(post, returnType);

        for (String key : response.keySet()) {
            if (key.startsWith("collections")) {
                return response.get(key);
            }
        }
        return null;
    }

    @Override
    public AssetFilter addAssetsToExistingCollection(List<String> assetIds, AssetFilter collection) {
        JsonObject request = new JsonObject();
        collection.setAssetIds(assetIds);
        request.add("collections/" + collection.getId(), gson.toJsonTree(collection));

        HttpPut put = createPut(baseUrl + "svc/collections/" + collection.getId() + "?", request.toString());
        Type returnType = new TypeToken<Map<String, AssetFilter>>(){}.getType();
        Map<String, AssetFilter> response = sendRequest(put, returnType);

        for (String key : response.keySet()) {
            if (key.startsWith("collections")) {
                return response.get(key);
            }
        }

        return null;
    }

    @Override
    public AssetFilterFolder createAssetFilterFolder(String parentId, String name) {
        int args = 1;
        JsonObject folderJson = new JsonObject();
        folderJson.addProperty("name", name);
        if (parentId != null) {
            folderJson.addProperty("folderId", parentId);
            args++;
        }

        JsonObject inner = new JsonObject();
        inner.add("@" + args, folderJson);

        JsonObject request = new JsonObject();
        request.add("filterFolders", inner);

        HttpPost post = createPost(baseUrl + "svc/filterFolders", request.toString());
        Type returnType = new TypeToken<Map<String, AssetFilterFolder>>(){}.getType();
        Map<String, AssetFilterFolder> response = sendRequest(post, returnType);
        for (String key : response.keySet()) {
            if (key.startsWith("filterFolders"))
                return response.get(key);
        }
        return null;
    }

    @Override
    public AssetFilterFolder updateAssetFilterFolder(String folderId, String name) {
        JsonObject nameJson = new JsonObject();
        nameJson.addProperty("name", name);

        JsonObject request = new JsonObject();
        request.add("filterFolders/" + folderId, nameJson);

        HttpPut put = createPut(baseUrl + "svc/filterFolders/" + folderId, request.toString());
        Type returnType = new TypeToken<Map<String, AssetFilterFolder>>(){}.getType();
        Map<String, AssetFilterFolder> response = sendRequest(put, returnType);
        for (String key : response.keySet()) {
            if (key.startsWith("filterFolders"))
                return response.get(key);
        }
        return null;
    }

    @Override
    public void deleteAssetFilterFolder(String folderId) {
        throw new UnsupportedOperationException("Not implemented yet");
    }

    @Override
    public void copyAssetFilterToFolder(String assetFilterId, String folderId) {
        throw new UnsupportedOperationException("Not implemented yet");
    }

    @Override
    public void moveAssetFilterToFolder(String assetFilterId, String fromFolderId, String toFolderId) {
        throw new UnsupportedOperationException("Not implemented yet");
    }

    @Override
    public void addRelationBetweenFiles(String agencyId, String asType, String childFileId, String parentFileId) {
        throw new UnsupportedOperationException("Not implemented yet");
    }

    @Override
    public void deleteAssetFilterFromFolder(String folderId, String assetFilterId) {
        throw new UnsupportedOperationException("Not implemented yet");
    }

    @Override
    public void addAssetToProjectFolder(String assetId, String parentId) {
        throw new UnsupportedOperationException("Not implemented yet");
    }

    @Override
    public Project getProject(String projectId) {
        StringBuilder address = new StringBuilder(baseUrl);
        address.append("svc/projects/").append(projectId);
        address.append("?perm=folder.read&torder=asc&tsort=userName&ids=").append(projectId);
        address.append("&subtype=element&subtype=project&subtype=comment&asort=_created&aorder=DESC&asize=10&apage=1&id=").append(projectId);
        address.append("&ufsort=_created&uforder=DESC&page=1&ufsize=10&ufpage=1&depth=1");
        HttpGet get = new HttpGet(address.toString());
        String response = sendRequest(get);
        JsonObject result = new JsonParser().parse(response).getAsJsonObject();
        for (Map.Entry<String, JsonElement> entry : result.entrySet()) {
            if (entry.getKey().startsWith("projects")) {
                JsonObject projectObject = entry.getValue().getAsJsonObject();
                JsonObject folders = projectObject.getAsJsonObject("folders");
                JsonArray folders_list = new JsonArray();
                for (Map.Entry<String, JsonElement> entry1 : folders.entrySet()) {
                    folders_list.add(entry1.getValue());
                }
                projectObject.add("folders", folders_list);
                JsonArray admins = projectObject.remove("administrators").getAsJsonArray();
                String[] adminsIds = new String[admins.size()];
                for (int i = 0; i < admins.size(); i++) {
                    User admin = gson.fromJson(admins.get(i).getAsJsonObject(), User.class);
                    adminsIds[i] = admin.getId();
                }
                Project project = gson.fromJson(projectObject, Project.class);
                project.setAdministrators(adminsIds);
                return project;
            }
        }
        return null;
    }

    @Override
    public Project getProject(String projectId, With with) {
        return getProject(projectId);
    }

    @Override
    public SearchResult<Project> findProjects(LuceneSearchingParams query) {
        StringBuilder address = new StringBuilder(baseUrl)
                .append("svc/projects?scroll=false&sort=_created&order=desc&mediaType=&offset=0&count=10&depth=1");
        if (query.getQuery() == null) query.setQuery("");
        if (query.getPageNumber() == null) query.setPageNumber(1);
        if (query.getResultsOnPage() == null) query.setResultsOnPage(10);
        address.append("&query=").append(Common.urlEncode(query.getQuery().replaceAll("\\*", "")));
        address.append("&page=").append(query.getPageNumber());
        address.append("&size=").append(query.getResultsOnPage());
        HttpGet get = new HttpGet(address.toString());
        String response = sendRequest(get);

        JsonObject obj = new JsonParser().parse(response).getAsJsonObject().getAsJsonObject("projects");
        List<Project> projects = new ArrayList<Project>();
        for (Map.Entry<String, JsonElement> entry : obj.entrySet()) {
            if (!entry.getKey().equals("_"))
                projects.add(gson.fromJson(entry.getValue(), Project.class));
        }
        SearchResult<Project> result = new SearchResult<Project>();
        result.setResult(projects);
        result.setMore(obj.get("_").getAsJsonObject().get("extra").getAsJsonObject().get("more").getAsBoolean());
        return result;
    }

    @Override
    public SearchResult<Project> findTemplates(LuceneSearchingParams query) {
        throw new UnsupportedOperationException("Not implemented yet");
    }

    @Override
    public String createTemplateFromProject(String projectId, String name, String[] mediaType, DateTime campaignStart, DateTime campaignEnd, boolean withFolders, boolean withTeam) {
        throw new UnsupportedOperationException("Not implemented yet");
    }

    @Override
    //todo review
    public Project createProject(Project project) {
        JsonObject inner = new JsonObject();
        inner.add("trash", new JsonObject());
        inner.add("_cm", gson.toJsonTree(project.getCm()));

        JsonObject projects = new JsonObject();
        projects.add("@1", inner);

        JsonObject request = new JsonObject();
        request.add("projects", projects);

        HttpPost post = createPost(baseUrl + "svc/projects?scroll=false&query=&sort=_created&order=desc&mediaType=&page=1&size=10&offset=0&count=10&perm=folder.read&torder=asc&tsort=userName&ufsort=_created&uforder=DESC&ufsize=10&ufpage=1&undefined.scroll=false&tfsize=20&tfpage=1&tfoffset=0&tfcount=10&folders.perm=folder.read&teams.torder=asc&teams.tsort=userName&uploadedFiles.ufsort=_created&uploadedFiles.uforder=DESC&uploadedFiles.ufsize=10&uploadedFiles.ufpage=1&undefined.tfsize=20&undefined.tfpage=1&undefined.tfoffset=0&undefined.tfcount=10&files.scroll=false&files.tfsize=20&files.tfpage=1&files.tfoffset=0&files.tfcount=10", request.toString());
        String response = sendRequest(post);
        JsonObject result = new JsonParser().parse(response).getAsJsonObject();
        for (Map.Entry<String, JsonElement> entry : result.entrySet()) {
            if (entry.getKey().startsWith("projects")) {
                projects = entry.getValue().getAsJsonObject();
                //mapping "folders" field to list as required in Project.java, line 148-150
                JsonObject folders = projects.getAsJsonObject("folders");
                JsonArray folders_list = new JsonArray();
                for (Map.Entry<String, JsonElement> entry1 : folders.entrySet()) {
                    folders_list.add(entry1.getValue());
                }
                projects.add("folders", folders_list);
                return gson.fromJson(projects, Project.class);
            }
        }
        return null;
    }

    @Override
    public Project createProject(String agencyId, Project project) {
        throw new UnsupportedOperationException("Not implemented yet");
    }

    @Override
    public Project updateProject(String projectId, Project newProject) {
        JsonObject request = new JsonObject();
        request.add("projects/" + projectId, gson.toJsonTree(newProject));

        StringBuilder address = new StringBuilder(baseUrl);
        address.append("svc/projects/").append(projectId);
        address.append("?scroll=false&query=&sort=_created&order=desc&mediaType=&offset=0&size=10&page=1&count=10");
        HttpPut put = createPut(address.toString(), request.toString());
        String response = sendRequest(put);
        JsonObject result = new JsonParser().parse(response).getAsJsonObject();
        for (Map.Entry<String, JsonElement> entry : result.entrySet()) {
            if (entry.getKey().startsWith("projects")) {
                JsonObject projects = entry.getValue().getAsJsonObject();
                //mapping "folders" field to list as required in Project.java, line 148-150
                JsonObject folders = projects.getAsJsonObject("folders");
                JsonArray folders_list = new JsonArray();
                for (Map.Entry<String, JsonElement> entry1 : folders.entrySet()) {
                    folders_list.add(entry1.getValue());
                }
                projects.add("folders", folders_list);
                return gson.fromJson(projects, Project.class);
            }
        }
        return null;
    }

    @Override
    public void deleteProject(String projectId) {
        HttpDelete delete = new HttpDelete(baseUrl + "svc/projects/" + projectId);
        sendRequest(delete);
    }

    @Override
    public void restoreProject(String projectId) {
        throw new UnsupportedOperationException("Not implemented yet");
    }

    @Override
    public Content getContent(String contentId) {
        HttpGet get = new HttpGet(baseUrl + "svc/files/" + contentId + "?depth=0");
        String response = sendRequest(get);
        JsonObject obj = new JsonParser().parse(response).getAsJsonObject();
        for (Map.Entry<String, JsonElement> entry : obj.entrySet()) {
            if (entry.getKey().startsWith("files")) {
                JsonObject fileObject = entry.getValue().getAsJsonObject();
                for (JsonElement revision : fileObject.getAsJsonArray("revisions")) {
                    if (revision.getAsJsonObject().has("preview")) {
                        JsonObject preview = revision.getAsJsonObject().remove("preview").getAsJsonObject();
                        JsonArray previewArray = new JsonArray();
                        previewArray.add(preview.getAsJsonObject("preview"));
                        previewArray.add(preview.getAsJsonObject("thumbnail"));
                        revision.getAsJsonObject().add("preview", previewArray);
                    }
                }
                return gson.fromJson(fileObject, Content.class);
            }
        }
        return null;
    }

    @Override
    public SearchResult<Content> findContent(String folderId, LuceneSearchingParams query) {
        throw new UnsupportedOperationException("Not implemented yet");
    }

    @Override
    public SearchResult<Content> findContentAllProjects(LuceneSearchingParams query) {
        throw new UnsupportedOperationException("Not implemented yet");
    }

    @Override
    public SearchResult<Content> findFoldersContent(String folderId, LuceneSearchingParams query) {
        String sort = query.getSortingField() == null ? "_created" : query.getSortingField();
        String order = query.getSortingOrder() == null ? "desc" : query.getSortingOrder();
        int count = query.getResultsOnPage() == null ? 20 : query.getResultsOnPage();
        int page = query.getPageNumber() == null ? 1 : query.getPageNumber();

        StringBuilder address = new StringBuilder(baseUrl);
        address.append("svc/files?recursive=false&mediaType=&includeFolders=true&folderId=").append(folderId);
        address.append("&scroll=false&sort=").append(sort);
        address.append("&order=").append(order);
        address.append("&size=").append(count);
        address.append("&count=").append(count);
        address.append("&offset=").append((page - 1) * count + 1);
        address.append("&depth=1");

        HttpGet get = new HttpGet(address.toString());
        String response = sendRequest(get);
        List<Content> files = new ArrayList<Content>();
        boolean more = false;
        JsonObject filesObject = new JsonParser().parse(response).getAsJsonObject().getAsJsonObject("files");
        for (Map.Entry<String, JsonElement> fileEntry : filesObject.entrySet()) {
            if (fileEntry.getKey().equals("_")) {
                more = fileEntry.getValue().getAsJsonObject().getAsJsonObject("extra").getAsJsonPrimitive("more").getAsBoolean();
            } else {
                JsonObject fileObject = fileEntry.getValue().getAsJsonObject();
                if (fileObject.has("revisions")) {
                    for (JsonElement revision : fileObject.getAsJsonArray("revisions")) {
                        if (revision.getAsJsonObject().has("preview")) {
                            JsonObject preview = revision.getAsJsonObject().remove("preview").getAsJsonObject();
                            JsonArray previewArray = new JsonArray();
                            previewArray.add(preview.getAsJsonObject("preview"));
                            previewArray.add(preview.getAsJsonObject("thumbnail"));
                            revision.getAsJsonObject().add("preview", previewArray);
                        }
                    }
                }
                files.add(gson.fromJson(fileObject, Content.class));
            }
        }
        SearchResult<Content> result = new SearchResult<Content>();
        result.setResult(files);
        result.setMore(more);
        return result;
    }

    @Override
    public SearchResult<Content> findClientFoldersContent(String folderId,String userId, LuceneSearchingParams query) {
        throw new UnsupportedOperationException("Not implemented yet");
    }


    public List<Content> getProjectFolders(String projectId, String parentId) {
        String key = "projects/" + projectId + "/folders";

        StringBuilder address = new StringBuilder(baseUrl);
        address.append("svc/").append(key);
        address.append("?parentid=").append(parentId);
        address.append("&perm=folder.read&depth=1");

        String response = sendRequest(new HttpGet(address.toString()));

        List<Content> folders = new ArrayList<Content>();
        JsonObject obj = new JsonParser().parse(response).getAsJsonObject();
        JsonObject elements = obj.getAsJsonObject(key);
        for (Map.Entry<String, JsonElement> entry : elements.entrySet()) {
            folders.add(gson.fromJson(entry.getValue(), Content.class));
        }
        return folders;
    }

    @Override
    public Content createContent(String parentId, Content content) {
        JsonObject common = new JsonObject();
        common.addProperty("name", content.getName());
        JsonObject cm = new JsonObject();
        cm.add("common", common);
        JsonObject internal = new JsonObject();
        internal.add("_cm", cm);
        internal.addProperty("_subtype", content.getSubtype());

        String key;
        StringBuilder address = new StringBuilder(baseUrl);
        if (content.getSubtype().equals("element")) {
            key = "files";
            address.append("svc/files?scroll=false&sort=_created&order=desc&size=10&page=1&offset=0&count=10&asort=_created&aorder=DESC&asize=10&apage=1");
            internal.addProperty("tmp-path", content.getTmpPath());
            internal.addProperty("folderId", parentId);
        } else {
            key = "projects/" + content.getProject() + "/folders";
            address.append("svc/").append(key);
            address.append("?parentid=").append(parentId).append("&perm=folder.read");
        }

        JsonObject node = new JsonObject();
        node.add("@1", internal);
        JsonObject request = new JsonObject();
        request.add(key, node);

        HttpPost post = createPost(address.toString(), request.toString());
        String response = sendRequest(post);
        JsonObject result = new JsonParser().parse(response).getAsJsonObject();
        for (Map.Entry<String, JsonElement> entry : result.entrySet()) {
            if (entry.getKey().startsWith("projects") || entry.getKey().startsWith("files")) {
                return gson.fromJson(entry.getValue(), Content.class);
            }
        }
        return null;
    }

    @Override
    public GDNFileRegister registerGDNContent(String parentId, List<GDNFileWrapper> gdnFiles) {
        JsonArray jsonFiles = new JsonArray();
        for (GDNFileWrapper gdnFile : gdnFiles) {
            jsonFiles.add(new JsonObjectBuilder()
                    .add("externalID", gdnFile.getExternalId())
                    .add("fileName", gdnFile.getName())
                    .add("size", gdnFile.getSize())
                    .build());
        }

        JsonObject request = new JsonObjectBuilder()
                .forNode("gdn/registration.@1")
                .add("files", jsonFiles)
                .forNode("params")
                .add("type", "files")
                .add("folder", parentId)
                .build();
        HttpPost post = createPost(baseUrl + "svc/gdn/registration", request.toString());
        String response = sendRequest(post);
        JsonObject result = new JsonParser().parse(response).getAsJsonObject();
        for (Map.Entry<String, JsonElement> entry : result.entrySet()) {
            if (entry.getKey().startsWith("gdn/registration")) {
                RegistrationFileInfo fileInfo = gson.fromJson(entry.getValue(), RegistrationFileInfo.class);
                GDNFileRegister fileRegister = new GDNFileRegister();
                fileRegister.setFiles(new RegistrationFileInfo[] {fileInfo});
                return fileRegister;
            }
        }
        return null;
    }

    @Override
    public Content createContentGDN(String parentId, Content content, String gdnFileId) {
        JsonObject request = new JsonObjectBuilder()
                .forNode("gdn/completion.@2")
                .add("gdnFileId", gdnFileId)
                .forNode("_cm.common")
                .add("name", content.getName())
                .forRootNode()
                .forNode("gdn/completion.@2.params")
                .add("type", "files")
                .add("folder", parentId)
                .build();
        HttpPost post = createPost(baseUrl + "svc/gdn/completion", request.toString());
        String response = sendRequest(post);
        JsonObject result = new JsonParser().parse(response).getAsJsonObject();
        for (Map.Entry<String, JsonElement> entry : result.entrySet()) {
            if (entry.getKey().startsWith("gdn/completion")) {
                return gson.fromJson(entry.getValue(), Content.class);
            }
        }
        return null;
    }

    @Override
    public Content createClientContentGDN(String parentId, Content content, String gdnFileId,String userId) {
        throw new UnsupportedOperationException("Not implemented yet");
    }

    @Override
    public int getFilesCount(String projectId, String folderId) {
        StringBuilder address = new StringBuilder(baseUrl);
        address.append("svc/projects/").append(projectId);
        address.append("/folders/").append(folderId);
        address.append("/files?depth=1");
        HttpGet get = new HttpGet(address.toString());
        Type returnType = new TypeToken<Map<String, Map<String, Integer>>>(){}.getType();
        Map<String, Map<String, Integer>> response = sendRequest(get, returnType);
        for (Map.Entry<String, Map<String, Integer>> entry : response.entrySet()) {
            if (entry.getKey().startsWith("projects")) return entry.getValue().get("count");
        }
        return 0;
    }

    @Override
    public Content updateContent(String contentId, Content newContent) {
        StringBuilder address = new StringBuilder(baseUrl);
        address.append("svc/files/").append(contentId);
        address.append("?folderId=").append(newContent.getFolderId());
        address.append("&scroll=false&sort=_created&order=desc&size=20&offset=0&page=1&count=10");

        JsonObject request = new JsonObject();
        request.add("files/" + contentId, gson.toJsonTree(newContent));

        HttpPut put = createPut(address.toString(), request.toString());
        String response = sendRequest(put);
        JsonObject fileObjectHolder = new JsonParser().parse(response).getAsJsonObject();
        for (Map.Entry<String, JsonElement> entry : fileObjectHolder.entrySet()) {
            if (entry.getKey().startsWith("files/")) {
                JsonObject fileObject = entry.getValue().getAsJsonObject();
                if (fileObject.has("revisions")) {
                    for (JsonElement revision : fileObject.getAsJsonArray("revisions")) {
                        if (revision.getAsJsonObject().has("preview")) {
                            JsonObject preview = revision.getAsJsonObject().remove("preview").getAsJsonObject();
                            JsonArray previewArray = new JsonArray();
                            previewArray.add(preview.getAsJsonObject("preview"));
                            previewArray.add(preview.getAsJsonObject("thumbnail"));
                            revision.getAsJsonObject().add("preview", previewArray);
                        }
                    }
                }
                return gson.fromJson(fileObject, Content.class);
            }
        }
        return null;
    }

    public void deleteFolder(String projectId, String folderId) {
        HttpDelete delete = new HttpDelete(baseUrl + "svc/projects/" + projectId + "/folders/" + folderId);
        sendRequest(delete);
    }

    @Override
    public void deleteContent(String contentId) {
        HttpDelete delete = new HttpDelete(baseUrl + "svc/files/" + contentId);
        sendRequest(delete);
    }

    @Override
    public void copyContent(String[] contentId, String toFolderId) {
        throw new UnsupportedOperationException("Not implemented yet");
    }

    @Override
    public String moveContent(String[] contentId, String toFolderId) {
        throw new UnsupportedOperationException("Not implemented yet");
    }

    @Override
    public SearchResult<Content> findTrashBinFiles(String projectId) {
        throw new UnsupportedOperationException("Not implemented yet");
    }

    @Override
    public SearchResult<Content> findTrashBinFolders(String projectId) {
        throw new UnsupportedOperationException("Not implemented yet");
    }

    @Override
    public SearchResult<Content> findTrashBinFoldersContent(String folderId, LuceneSearchingParams query) {
        throw new UnsupportedOperationException("Not implemented yet");
    }

    @Override
    public SearchResult<User> getTeamUsers(String projectId, boolean children) {
        String key = "projects/" + projectId + "/teams";
        HttpGet get = new HttpGet(baseUrl + "svc/" + key + "?torder=asc&tsort=userName&depth=1");
        String json = sendRequest(get);

        List<User> users = new ArrayList<User>();
        JsonObject obj = new JsonParser().parse(json).getAsJsonObject().getAsJsonObject(key);
        for (Map.Entry<String, JsonElement> entry : obj.entrySet()) {
            users.add(gson.fromJson(entry.getValue(), User.class));
        }
        SearchResult<User> result = new SearchResult<User>();
        result.setResult(users);
        return result;
    }

    @Override
    public SearchResult<User> addUserToProjectTeam(TeamPermission[] permissions) {
        return addUserToProjectTeam(permissions[0].getFsObjectId(), permissions);
    }

    @Override
    public SearchResult<User> addUserToProjectTeam(String projectId, TeamPermission[] permissions) {
        String projectPath = String.format("projects/%s/teams", projectId);

        JsonObject request = new JsonObjectBuilder()
                .forNode(projectPath)
                .forNode("@2")
                .add("permissions", gson.toJsonTree(permissions))
                .build();

        HttpPost post = createPost(baseUrl + "svc/" + projectPath + "?torder=asc&tsort=userName", request.toString());
        String response = sendRequest(post);

        List<User> users = new ArrayList<>();
        JsonObject usersObj = new JsonParser().parse(response).getAsJsonObject();
        for (Map.Entry<String, JsonElement> entry : usersObj.entrySet()) {
            if (entry.getKey().startsWith("projects")) {
                users.add(gson.fromJson(entry.getValue(), User.class));
            }
        }
        SearchResult<User> result = new SearchResult<User>();
        result.setResult(users);
        return result;
    }

    public void addProjectOwner(String projectId, String userId) {
        String key = "projects/" + projectId + "/owners";
        String address = baseUrl + "svc/" + key + "?";
        JsonObject query = new JsonObjectBuilder()
                .forNode(key)
                .forNode("@1")
                .add("userId", userId)
                .build();
        HttpPost post = createPost(address, query.toString());
        sendRequest(post);
    }

    public void removeProjectOwner(String projectId, String userId) {
        HttpDelete delete = new HttpDelete(baseUrl + "svc/projects/" + projectId + "/owners/" + userId);
        sendRequest(delete);
    }

    public void removeUserFromProjectTeam(String projectId, String userId) {
        HttpDelete delete = new HttpDelete(baseUrl + "svc/projects/" + projectId + "/teams/" + userId);
        sendRequest(delete);
    }

    @Override
    public void allowUserToViewPublicTemplates(String agencyId, String userId, boolean allow) {
        throw new UnsupportedOperationException("Not implemented yet");
    }

    @Override
    public String batchUpdateElementsMetadata(String agencyId, String projectId, CustomMetadata metadata) {
        throw new UnsupportedOperationException("Not implemented yet");
    }

    @Override
    public Role getRole(String roleId) {
        List<Role> roles = findRoles(new LuceneSearchingParams()).getResult();
        for (Role role : roles) {
            if (role.getId().equals(roleId)) {
                return role;
            }
        }
        return null;
    }

    @Override
    public SearchResult<Role> findRoles(LuceneSearchingParams query) {
        HttpGet get = new HttpGet(baseUrl + "svc/roles?showasis=false&depth=1");
        String response = sendRequest(get);
        JsonObject respObj = new JsonParser().parse(response).getAsJsonObject().getAsJsonObject("roles");
        List<Role> roles = new ArrayList<Role>();
        for (Map.Entry<String, JsonElement> entry : respObj.entrySet()) {
            if (!entry.getKey().equals("_")) {
                roles.add(gson.fromJson(entry.getValue(), Role.class));
            }
        }
        SearchResult<Role> result = new SearchResult<Role>();
        result.setResult(roles);
        return result;
    }

    @Override
    public Role createRole(String agencyId, Role role) {
        throw new UnsupportedOperationException("Not implemented yet");
    }

    @Override
    public Role updateRole(Role role) {
        throw new UnsupportedOperationException("Not implemented yet");
    }

    @Override
    public void deleteRole(String roleId) {
        throw new UnsupportedOperationException("Not implemented yet");
    }

    @Override
    public void createAcl(String roleId, Acl acl) {
        throw new UnsupportedOperationException("Not implemented yet");
    }

    @Override
    public SearchResult<User> getAclSubjects(String roleId, String objectId) {
        return getCoreService().getAclSubjects(roleId, objectId);
    }

    @Override
    public void deleteAcl(String roleId, String objectId, String subjectId) {
        throw new UnsupportedOperationException("Not implemented yet");
    }

    @Override
    public void hideRole(String roleId, boolean hide) {
        throw new UnsupportedOperationException("Not implemented yet");
    }

    @Override
    public SearchResult<FileStorage> getGdnStorages() {
        HttpGet get = new HttpGet(baseUrl + "svc/storages?depth=0");
        String response = sendRequest(get);
        JsonObject obj = new JsonParser().parse(response).getAsJsonObject().getAsJsonObject("storages");
        List<FileStorage> storages = new ArrayList<FileStorage>();
        for (Map.Entry<String, JsonElement> entry : obj.entrySet()) {
            storages.add(gson.fromJson(entry.getValue(), FileStorage.class));
        }
        SearchResult<FileStorage> result = new SearchResult<FileStorage>();
        result.setResult(storages);
        return result;
    }

    @Override
    public FileStorage getGdnStorageForAgency(String agencyId) {
        throw new UnsupportedOperationException("Not implemented yet");
    }

    @Override
    public FileStorage getGdnStorageForFolder(String folderId) {
        String key = "folders/" + folderId + "/storage";
        HttpGet get = new HttpGet(baseUrl + "svc/" + key + "?depth=0");
        String response = sendRequest(get);
        JsonObject obj = new JsonParser().parse(response).getAsJsonObject().getAsJsonObject(key);
        return gson.fromJson(obj, FileStorage.class);
    }

    @Override
    public String getDownloadUrl(String fileId, String a4FileId, String saveAsFileName) {
        downloadFile(fileId, a4FileId, saveAsFileName);
        return getLastRedirectURI().toString();
    }

    public byte[] downloadFile(String fileId, String a4FileId, String saveAsFileName) {
        StringBuilder address = new StringBuilder(baseUrl);
        address.append("media/preview?id=").append(fileId);
        address.append("&fileId=").append(a4FileId);
        address.append("&saveAs=").append(Common.urlEncode(saveAsFileName));
        address.append("&exprire=").append(System.currentTimeMillis());
        HttpGet get = new HttpGet(address.toString());
        return sendRequestRaw(get);
    }

    @Override
    public GlobalSearchResult globalSearch(LuceneSearchingParams query) {
        StringBuilder address = new StringBuilder(baseUrl);
        address.append("svc/globalSearch?value=").append(query.getQuery().replace("*", "")).append("&isGlobal=true&depth=1&highlight=true");
        HttpGet get = new HttpGet(address.toString());
        MiddlewareGlobalSearchResult result = sendRequest(get, MiddlewareGlobalSearchResult.class);
        return result.getResult();
    }

    @Override
    public Contact addContact(String email) {
        throw new UnsupportedOperationException("Not implemented yet");
    }

    @Override
    public Contact addContactToGroup(String email, String... groupName) {
        throw new UnsupportedOperationException("Not implemented yet");
    }

    @Override
    public void addNotificationSetting(String userId,String notificationSetting,String settingState) {
        throw new UnsupportedOperationException("Not implemented yet");
    }

    @Override
    public Contact getContact(String email) {
        throw new UnsupportedOperationException("Not implemented yet");
    }

    @Override
    public SearchResult<Contact> getContacts(ContactSearchingParams query) {
        throw new UnsupportedOperationException("Not implemented yet");
    }

    @Override
    public List<String> getTeamTemplates(ContactSearchingParams query) {
        throw new UnsupportedOperationException("Not implemented yet");
    }

    @Override
    public void deleteContact(String contactId) {
        throw new UnsupportedOperationException("Not implemented yet");
    }

    @Override
    public int getNotificationsCount(boolean isHasReadNotification) {
        throw new UnsupportedOperationException("Not implemented yet");
    }

    @Override
    public SearchResult<Notification> findNotifications(boolean isHasReadNotification, LuceneSearchingParams query) {
        throw new UnsupportedOperationException("Not implemented yet");
    }

    public Content updateBatchAssets(List<Content> contentList){
        throw new UnsupportedOperationException("Not implemented yet");
    }

    @Override
    public Content updateAsset(Content content) {
        JsonObject request = new JsonObject();
        request.add("assets/" + content.getId(), gson.toJsonTree(content));

        HttpPut put = createPut(baseUrl + "svc/assets/" + content.getId()
                + "?sort=_created&order=desc&query=&scroll=false&deleted=false&offset=0&size=20&page=1&count=10", request.toString());
        String response = sendRequest(put);
        JsonObject assetObjectHolder = new JsonParser().parse(response).getAsJsonObject();
        for (Map.Entry<String, JsonElement> entry : assetObjectHolder.entrySet()) {
            if (entry.getKey().startsWith("assets/")) {
                JsonObject assetObject = entry.getValue().getAsJsonObject();
                for (JsonElement revision : assetObject.getAsJsonArray("revisions")) {
                    if (revision.getAsJsonObject().has("preview")) {
                        JsonObject preview = revision.getAsJsonObject().remove("preview").getAsJsonObject();
                        JsonArray previewArray = new JsonArray();
                        previewArray.add(preview.getAsJsonObject("preview"));
                        previewArray.add(preview.getAsJsonObject("thumbnail"));
                        revision.getAsJsonObject().add("preview", previewArray);
                    }
                }
                return gson.fromJson(assetObject, Content.class);
            }
        }
        return null;
    }

    public Content patchAsset(String assetId, String campaign){return null;}

    @Override
    public GDNFileRegister registerGDNAssets(List<GDNFileWrapper> files) {
        JsonArray jsonFiles = new JsonArray();
        for (GDNFileWrapper gdnFile : files) {
            jsonFiles.add(new JsonObjectBuilder()
                    .add("externalID", gdnFile.getExternalId())
                    .add("fileName", gdnFile.getName())
                    .add("size", gdnFile.getSize())
                    .build());
        }

        JsonObject request = new JsonObjectBuilder()
                .forNode("gdn/registration.@1")
                .add("files", jsonFiles)
                .forNode("params")
                .add("type", "assets")
                .build();
        HttpPost post = createPost(baseUrl + "svc/gdn/registration", request.toString());
        String response = sendRequest(post);
        JsonObject result = new JsonParser().parse(response).getAsJsonObject();
        for (Map.Entry<String, JsonElement> entry : result.entrySet()) {
            if (entry.getKey().startsWith("gdn/registration")) {
                RegistrationFileInfo fileInfo = gson.fromJson(entry.getValue(), RegistrationFileInfo.class);
                GDNFileRegister fileRegister = new GDNFileRegister();
                fileRegister.setFiles(new RegistrationFileInfo[] {fileInfo});
                return fileRegister;
            }
        }
        return null;
    }

    @Override
    public Content createAssetGDN(Content content, String gdnFileId) {
        JsonObject request = new JsonObjectBuilder()
                .forNode("gdn/completion.@2")
                .add("gdnFileId", gdnFileId)
                .forNode("_cm.common")
                .add("name", content.getName())
                .forRootNode()
                .forNode("gdn/completion.@2.params")
                .add("type", "assets")
                .build();
        HttpPost post = createPost(baseUrl + "svc/gdn/completion", request.toString());
        String response = sendRequest(post);
        JsonObject result = new JsonParser().parse(response).getAsJsonObject();
        for (Map.Entry<String, JsonElement> entry : result.entrySet()) {
            if (entry.getKey().startsWith("gdn/completion")) {
                return gson.fromJson(entry.getValue(), Content.class);
            }
        }
        return null;
    }


    @Override
    public Content createAssetGDN(Content content, String gdnFileId, String agencyId) {
        return  createAssetGDN(content, gdnFileId);
    }

    @Override
    public AmazonContent createfilePart(String gdnFileId,String storageId) {
        return  null;
    }

    @Override
    public JobResponse gdnIngestRegister(Job job) {
       return null;
    }

    @Override
    public IngestDoc getIngestID(String assetID) {
        return null;
    }

    @Override
    public void setRevision(IngestDoc ingestdoc, String ingestID, long size, String fileId, String assetId ){
        throw new UnsupportedOperationException("Not implemented yet");
    }

    @Override
    public void multipartIngestComplete(String gdnFileId,MultiPartUploadCompleteData multiPartUploadCompleteData) {
        throw new UnsupportedOperationException("Not implemented yet");
    }

    @Override
    public void deleteAsset(String assetId) {
        HttpDelete delete = new HttpDelete(baseUrl + "svc/assets/" + assetId);
        sendRequest(delete);
    }

    @Override
    public BatchTaskApi batchTaskApi() {
        throw new UnsupportedOperationException("Not implemented yet");
    }

    @Override
    public Content moveFileIntoLibrary(Content content) {
        JsonObject request = new JsonObjectBuilder()
                .forNode("assets.@1")
                .add("usageRights", new JsonObject())
                .add("element", content.getId())
                .add("_cm", gson.toJsonTree(content.getCm()))
                .build();

        HttpPost post = createPost(baseUrl + "svc/assets?scroll=false&deleted=false&offset=1&size=20&count=20&deliveries.scroll=false&deliveries.size=10&page=1&deliveries.offset=0&deliveries.count=10", request.toString());
        String response = sendRequest(post);
        JsonObject responseObj = new JsonParser().parse(response).getAsJsonObject();
        for (Map.Entry<String, JsonElement> entry : responseObj.entrySet()) {
            if (entry.getKey().startsWith("assets/")) {
                return gson.fromJson(entry.getValue(), Content.class);
            }
        }
        return null;
    }

    @Override
    public Comment createComment(String text, String objectId, String objectType, long objectRevision, String answerTo) {
        throw new UnsupportedOperationException("Not implemented yet");
    }

    @Override
    public SearchResult<Comment> findComments(String fileId, int revisionNum) {
        throw new UnsupportedOperationException("Not implemented yet");
    }

    @Override
    public Content createRevision(String elementId, Content content) {
        throw new UnsupportedOperationException("Not implemented yet");
    }

    @Override
    public Content createClientRevision(String elementId, Content content,String userId) {
        throw new UnsupportedOperationException("Not implemented yet");
    }

    @Override
    public Content createAttachedFile(Content originalFile, AttachedFile attachedFile) {
        return null;
    }

    @Override
    public SearchResult<Reel> findReels(LuceneSearchingParams query) {
        String order = query.getSortingOrder() == null ? "asc" : query.getSortingOrder();
        String sort = query.getSortingField() == null ? "_cm.common.name" : query.getSortingField();
        int count = query.getResultsOnPage() == null ? 40 : query.getResultsOnPage();
        int offset = query.getPageNumber() == null ? 0 : (query.getPageNumber() - 1) * count;
        if (offset < 0) {
            offset = 0;
        }

        StringBuilder address = new StringBuilder(baseUrl);
        address.append("svc/reels?order=").append(order);
        address.append("&sort=").append(sort);
        address.append("&offset=").append(offset);
        address.append("&size=").append(count);
        address.append(count).append("&scroll=false&global=false&depth=1");

        HttpGet get = new HttpGet(address.toString());
        JsonObject result = new JsonParser().parse(sendRequest(get)).getAsJsonObject();
        JsonObject map = result.getAsJsonObject("reels");
        List<Reel> reels = new ArrayList<>();
        for (Map.Entry<String, JsonElement> entry : map.entrySet()) {
            JsonObject reel = entry.getValue().getAsJsonObject();
            reels.add(gson.fromJson(reel, Reel.class));
        }
        SearchResult<Reel> out = new SearchResult<>();
        out.setResult(reels);
        return out;
    }

    @Override
    public boolean sharePresentationToUsers(String presentationId, List<String> userIds, String personalMessage) {
        throw new UnsupportedOperationException("Not implemented yet");
    }

    @Override
    public Reel createReel(Reel reel) {
        JsonArray assetsOrder = new JsonArray();
        if (reel.getAssets().containsKey("assetsOrder")) {
            assetsOrder = gson.toJsonTree(reel.getAssets().getStringArray("assetsOrder")).getAsJsonArray();
        }
        JsonObject request = new JsonObjectBuilder()
                .forNode("reels.@1")
                .add("assets", new JsonObject())
                .add("publicLink", new JsonObject())
                .add("_assetsOrder", assetsOrder)
                .forNode("_cm.common")
                .add("name", reel.getName())
                .add("description", reel.getDescription())
                .build();

        HttpPost post = createPost(baseUrl + "svc/reels?order=asc&sort=_cm.common.name&scroll=false&global=false&offset=0&size=40&type=master&protocol=http&zip.type=master&zip.protocol=http", request.toString());

        String response = sendRequest(post);
        JsonObject obj = new JsonParser().parse(response).getAsJsonObject();
        for (Map.Entry<String, JsonElement> entry : obj.entrySet())
            if (entry.getKey().startsWith("reels"))
                return gson.fromJson(entry.getValue(), Reel.class);
        return null;
    }

    @Override
    public Reel updateReel(Reel reel) {
        JsonObject request = new JsonObject();
        request.add("reels/" + reel.getId(), gson.toJsonTree(reel));
        HttpPut put = createPut(baseUrl + "svc/reels/" + reel.getId(), request.toString());
        String response = sendRequest(put);
        JsonObject obj = new JsonParser().parse(response).getAsJsonObject();
        for (Map.Entry<String, JsonElement> entry : obj.entrySet())
            if (entry.getKey().startsWith("reels"))
                return gson.fromJson(entry.getValue(), Reel.class);
        return null;
    }

    @Override
    public void deleteReel(String reelId) {
        HttpDelete delete = new HttpDelete(baseUrl + "svc/reels/" + reelId);
        sendRequest(delete);
    }

    @Override
    public Reel getReel(String reelId, boolean withPermissions) {
        return getReel(reelId);
    }

    public Reel getReel(String reelId) {
        HttpGet get = new HttpGet(baseUrl + "svc/reels/" + reelId + "?type=master&protocol=http&depth=2");
        String response = sendRequest(get);
        JsonObject obj = new JsonParser().parse(response).getAsJsonObject();
        for (Map.Entry<String, JsonElement> entry : obj.entrySet())
            if (entry.getKey().startsWith("reels"))
                return gson.fromJson(entry.getValue(), Reel.class);
        return null;
    }

    @Override
    public void shareAssetFilterToAgency(String assetFilterId, String agencyId) {
        throw new UnsupportedOperationException("Not implemented yet");
    }

    @Override
    public AgencyProjectTeam createAgencyTeam(AgencyProjectTeam agencyProjectTeam) {
        String address = baseUrl + "svc/agencyTeams?name=&size=10&page=0";
        JsonObject query = new JsonObjectBuilder()
                .forNode("agencyTeams")
                .add("@1", gson.toJson(agencyProjectTeam))
                .build();
        HttpPost post = createPost(address, query.toString());
        String response = sendRequest(post);
        JsonObject obj = new JsonParser().parse(response).getAsJsonObject();
        for (Map.Entry<String, JsonElement> entry : obj.entrySet()) {
            if (entry.getKey().startsWith("agencyTeams")) {
                return gson.fromJson(entry.getValue(), AgencyProjectTeam.class);
            }
        }
        return null;
    }

    @Override
    public void addObjectToAgencyProjectTeam(String agencyTeamId, String objectId) {
        String key = "projects/" + objectId + "/agencyTeams";
        String address = baseUrl + "svc/" + key + "?";
        JsonObject query = new JsonObjectBuilder()
                .forNode(key)
                .forNode("@1")
                .add("teamId", agencyTeamId)
                .addArray("folders", new String[] {objectId})
                .build();
        HttpPost post = createPost(address, query.toString());
        sendRequest(post);
    }

    @Override
    public SearchResult<AgencyProjectTeam> findAgencyProjectTeams(LuceneSearchingParams query) {
        throw new UnsupportedOperationException("Not implemented yet");
    }

    @Override
    public void deleteAgencyProjectTeam(String teamId) {
        throw new UnsupportedOperationException("Not implemented yet");
    }

    @Override
    public SearchResult<Approval> findApprovals(LuceneSearchingParams query, String type, boolean onlyCompleted) {
        String q = query.getQuery() == null ? "" : query.getQuery();
        int page = query.getPageNumber() == null ? 1 : query.getPageNumber();
        int size = query.getResultsOnPage() == null ? 10 : query.getResultsOnPage();
        String sort= query.getSortingField() == null ? "_created" : query.getSortingField();
        String order = query.getSortingOrder() == null ? "desc" : query.getSortingOrder();
        int offset = (page - 1) * size;

        StringBuilder address = new StringBuilder(baseUrl);
        address.append("svc/approvals?type=").append(type).append("&query=").append(q);
        address.append("&page=1&count=").append(size).append("&size=").append(size);
        address.append("&offset=").append(offset).append("&showCompletedApprovals").append(onlyCompleted);
        address.append("&sort=").append(sort).append("&order=").append(order).append("&scroll=true&mediaType=&depth=1");

        HttpGet get = new HttpGet(address.toString());
        String json = sendRequest(get);
        JsonObject obj = new JsonParser().parse(json).getAsJsonObject().getAsJsonObject("approvals");
        List<Approval> approvals = new ArrayList<Approval>();
        for (Map.Entry<String, JsonElement> entry : obj.entrySet()) {
            approvals.add(gson.fromJson(entry.getValue(), Approval.class));
        }
        boolean more = obj.getAsJsonObject("_").getAsJsonObject("extra").getAsJsonPrimitive("more").getAsBoolean();
        SearchResult<Approval> result = new SearchResult<Approval>();
        result.setResult(approvals);
        result.setMore(more);
        return result;
    }

    @Override
    public Approval getApproval(String fileId, String masterId) {
        StringBuilder address = new StringBuilder(baseUrl);
        address.append("svc/").append("files/").append(fileId).append("/approvals/").append(masterId).append("?depth=0");
        HttpGet get = new HttpGet(address.toString());
        String response = sendRequest(get);
        return getApprovalFromJson(response);
    }

    @Override
    public String createApprovalStage(String fileId, String masterId, ApprovalStage stage) {
        String key = "files/" + fileId + "/approvals/" + masterId + "/stages";
        JsonObject stageTree = gson.toJsonTree(stage).getAsJsonObject();
        stageTree.add("members", gson.toJsonTree(stage.getMembersIds() == null ? new ArrayList<String>() : stage.getMembersIds()));

        JsonObject deadline_date = new JsonObject();
        deadline_date.add("date",gson.toJsonTree(stage.getDeadline().getDate()));
        deadline_date.add("reminderType",gson.toJsonTree(stage.getDeadline().getReminderType()));
        if (stage.getDeadline() != null) stageTree.add("deadline", deadline_date);

        JsonObject reminder_date = new JsonObject();
        reminder_date.add("date",gson.toJsonTree(stage.getReminder().getDate()));
        reminder_date.add("reminderType",gson.toJsonTree(stage.getReminder().getReminderType()));
        if (stage.getReminder() != null) stageTree.add("reminder", reminder_date);

        // if (stage.getDeadline() != null) stageTree.add("deadline", gson.toJsonTree(stage.getDeadline().getDate()));
        // if (stage.getReminder() != null) stageTree.add("reminder", gson.toJsonTree(stage.getReminder().getDate()));

        JsonObject internal = new JsonObject();
        internal.add("@2", stageTree);

        JsonObject request = new JsonObject();
        request.add(key, internal);

        HttpPost post = createPost(baseUrl + "svc/" + key, request.toString());
        String response = sendRequest(post);
        JsonObject obj = new JsonParser().parse(response).getAsJsonObject()
                .entrySet().iterator().next().getValue().getAsJsonObject();
        if (obj.has("_id")) {
            return obj.get("_id").getAsString();
        } else {
            return obj.get("approvalId").getAsString();
        }
    }

    @Override
    public void changeApprovalState(String fileId, String masterId, String approvalId, String stageId, String status) {
        String key = new StringBuilder("files/")
                .append(fileId).append("/approvals/").append(masterId).append("/stages/").append(stageId).append("/stageStatus").toString();
        JsonObject internal = new JsonObject();
        internal.addProperty("stageId", stageId);
        internal.addProperty("approvalId", approvalId);
        internal.addProperty("status", status);
        internal.addProperty("action", "approve");

        JsonObject request = new JsonObject();
        request.add(key, internal);

        HttpPut put = createPut(baseUrl + "/svc/" + key, request.toString());
        sendRequest(put);
    }

    private Approval getApprovalFromJson(String json) {
        JsonObject obj = new JsonParser().parse(json).getAsJsonObject()
                .entrySet().iterator().next().getValue().getAsJsonObject();
        List<ApprovalStage> stages = new ArrayList<ApprovalStage>();
        JsonElement stagesElm = obj.remove("stages");
        if (stagesElm instanceof JsonObject) {
            JsonObject stagesObj = stagesElm.getAsJsonObject();
            for (Map.Entry<String, JsonElement> entry : stagesObj.entrySet()) {
                stages.add(gson.fromJson(entry.getValue(), ApprovalStage.class));
            }
        }
        Approval approval = gson.fromJson(obj, Approval.class);
        approval.setStages(stages);
        return approval;
    }

    @Override
    public SearchResult<com.adstream.automate.babylon.JsonObjects.activity.Activity> getActivities(ActivityType type, String objectId, @Nullable String creatorUserId, @Nullable String recipientUserId, @Nullable Pager pager) {
        throw new UnsupportedOperationException("Not implemented yet");
    }

    @Override
    public SearchResult<com.adstream.automate.babylon.JsonObjects.activity.Activity> getActivities(ActivityType type, @Nullable String recipientUserId, @Nullable String agencyId, @Nullable Pager pager) {
        throw new UnsupportedOperationException("Not implemented yet");
    }

    @Override
    public SearchResult<com.adstream.automate.babylon.JsonObjects.activity.Activity> findActivities(ActivityType type, ActivityQuery query, @Nullable Pager pager) {
        throw new UnsupportedOperationException("Not implemented yet");
    }

    @Override
    public void addUsageRights(String objectId, List<UsageRight> listUR) {
    }

    @Override
    public BaseUsageRight getUsageRight (String objectId) {
        return null;
    }

    @Override
    public void deleteUsageRight(String objectId) {
    }

    @Override
    public void shareFileOrAsset(String documentType, List<String> assetIds, List<String> userIds, Long expiration, String message, boolean createActivity, boolean allowView, boolean allowDownloadProxy, boolean allowDownloadMaster) {
        throw new UnsupportedOperationException("Not implemented yet");
    }

    @Override
    public PublicShare createPublicShare(String documentType, String documentId, Long expiration, String[] users, String[] roles) {
        if (users == null) {
            users = new String[0];
        }
        if (roles == null) {
            roles = new String[0];
        }
        if (documentType.equals("fsobject")) {
            String key = "projects/000000000000000000000000/folders/000000000000000000000000/shareFiles";
            JsonObject request = new JsonObjectBuilder()
                    .forNode(key)
                    .forNode("@1")
                    .add("publicLink", new JsonObject())
                    .addArray("users", users)
                    .addArray("emails", users)
                    .add("isPublic", false)
                    .addArray("filesId", new String[]{documentId})
                    .add("expireDate", expiration)
                    .add("downloadProxy", roles.length > 0)
                    .add("downloadOriginal", false)
                    .add("message", "")
                    .build();
            HttpPost post = createPost(baseUrl + key, request.toString());
            JsonObject response = new JsonParser().parse(sendRequest(post)).getAsJsonObject().get(key).getAsJsonObject();
            return gson.fromJson(response, PublicShare.class);
        } else {
            throw new UnsupportedOperationException("Not implemented yet");
        }
    }

    @Override
    public Map<String, String> getDownloadInfo(String fileId, String a4FileId, String saveAsFileName) {
        return null;
    }

    @Override
    public Integer getInboxCacheStatus() {
        throw  new UnsupportedOperationException("Not implemented yet");
    }

    @Override
    public Integer createInboxCache() {
        throw  new UnsupportedOperationException("Not implemented yet");
    }

    @Override
    public Boolean createInboxCache(String collectionId) {
        throw  new UnsupportedOperationException("Not implemented yet");
    }

    @Override
    public Project publishProject(String projectId, boolean publish, Boolean noEmail) {
        throw new UnsupportedOperationException("Not implemented yet");
    }

    @Override
    public String createProjectFromTemplate(String projectId, String name, String[] mediaType, DateTime campaignStart, DateTime campaignEnd, boolean withFolders, boolean withTeam, boolean isPublished) {
        throw new UnsupportedOperationException("Not implemented yet");
    }

    // SchemasMap

    public SchemasMap findSchemasMap(String groupOne, String agencyIdOne, String groupTwo, String agencyIdTwo) {
        throw new UnsupportedOperationException("Not implemented yet");
    }

    // Projects access rules

    @Override
    public CustomMetadata enableProjectsAccessRulesForAgency(String agencyId, int interval) {
        String key = String.format("agencies/%s/accessRulesSettings", agencyId);
        JsonObject inner = new JsonObject();
        inner.addProperty("enable", true);
        inner.addProperty("interval", interval);
        JsonObject request = new JsonObject();
        request.add(key, inner);

        String response = sendRequest(createPut(baseUrl + "svc/" + key, request.toString()));
        JsonObject result = new JsonParser().parse(response).getAsJsonObject();
        return gson.fromJson(result.get(key), CustomMetadata.class);
    }

    @Override
    public ProjectsAccessRule createProjectsAccessRule(ProjectsAccessRule projectsAccessRule) {
        String url = String.format("%ssvc/users/%s/accessRules", baseUrl, projectsAccessRule.getUserId());
        JsonObject request = new JsonObject();

        JsonObject inner = new JsonObject();
        inner.add("@1", gson.toJsonTree(projectsAccessRule));


        request.add(String.format("users/%s/accessRules", projectsAccessRule.getUserId()), inner);

        Type returnType = new TypeToken<Map<String, ProjectsAccessRule>>(){}.getType();
        Map<String, ProjectsAccessRule> result = sendRequest(createPost(url, request.toString()), returnType);
        for (Map.Entry<String, ProjectsAccessRule> entry : result.entrySet()) {
            if (entry.getKey().startsWith("users/"))
                return entry.getValue();
        }

        return null;

    }

    @Override
    public ProjectsAccessRule getProjectsAccessRule(String agencyId, String userId) {
        throw new UnsupportedOperationException("Not implemented yet");
    }

    @Override
    public ProjectsAccessRule getProjectsAccessRule(String projectsAccessRuleId) {
        throw new UnsupportedOperationException("Not implemented yet");
    }

    @Override
    public ProjectsAccessRule updateProjectsAccessRule(ProjectsAccessRule projectsAccessRule) {
        String url = String.format("%ssvc/users/%s/accessRules/%s", baseUrl, projectsAccessRule.getUserId(), projectsAccessRule.getId());
        JsonObject request = new JsonObject();

        request.add(String.format("users/%s/accessRules/%s", projectsAccessRule.getUserId(), projectsAccessRule.getId()),
                gson.toJsonTree(projectsAccessRule));


        Type returnType = new TypeToken<Map<String, ProjectsAccessRule>>(){}.getType();
        Map<String, ProjectsAccessRule> result = sendRequest(createPut(url, request.toString()), returnType);
        for (Map.Entry<String, ProjectsAccessRule> entry : result.entrySet()) {
            if (entry.getKey().startsWith("users/"))
                return entry.getValue();
        }

        return null;
    }

    @Override
    public SearchResult<Content> findAssetsInSharedCollection(String collectionId, LuceneSearchingParams query) {
        throw new UnsupportedOperationException("Not implemented yet");
    }

    @Override
    public SearchResult<InboxCategory> getInboxCategories(String agencyId) {
        throw new UnsupportedOperationException("Not implemented yet");
    }

    @Override
    public ProjectsAccessRule deleteProjectsAccessRule(String projectsAccessRuleId) {
        throw new UnsupportedOperationException("Not implemented yet");
    }

    // Ordering

    @Override
    public Order createOrder(Order order) {
        StringBuilder address = new StringBuilder(baseUrl);
        address.append("svc/orders?sort=_created&order=desc&status=draft&query=%7B%22and%22%3A%5B%7B%22terms%22%3A%7B%22status%22%3A%5B%22draft%22%5D%7D%7D%2C%7B%22terms%22%3A%7B%22_subtype%22%3A%5B%22").append(order.getSubtype()).append("%22%5D%7D%7D%5D%7D&scroll=false&offset=0&size=10&page=1&count=10");

        JsonObject obj = new JsonObject();
        obj.addProperty("_subtype", order.getSubtype());
        obj.add("complete", new JsonObject());
        obj.add("copy_section", new JsonObject());
        obj.add("uploads", new JsonObject());

        //this part will be creates order item in order with empty values

        /*JsonObject inner = new JsonObject();
        inner.add("uploads", new JsonObject());
        inner.add("metadata", new JsonObject());
        inner.add("clockValidate", new JsonObject());
        inner.add("delivery_asset_metadata", new JsonObject());
        inner.add("destinations", new JsonObject());
        inner.add("media", new JsonObject());
        inner.add("non_broadcast_destinations", new JsonObject());
        inner.add("usageRights", new JsonObject());

        JsonObject internal = new JsonObject();
        internal.add("@2", inner);

        obj.add("items", internal);*/

        JsonObject orders = new JsonObject();
        orders.add("@1", obj);

        JsonObject request = new JsonObject();
        request.add("orders", orders);

        HttpPost post = createPost(address.toString(), request.toString());
        Type returnType = new TypeToken<Map<String, Order>>(){}.getType();
        Map<String, Order> result = sendRequest(post, returnType);
        for (Map.Entry<String, Order> entry : result.entrySet()) {
            if (entry.getKey().startsWith("orders"))
                return entry.getValue();
        }
        return null;
    }

    @Override
    public Order updateOrder(Order order) {
        String key = "orders/" + order.getId();
        StringBuilder address = new StringBuilder(baseUrl);
        address.append("svc/").append(key).append("?status=draft&query=%7B%22and%22%3A%5B%7B%22or%22%3A%5B%7B%22prefix%22%3A%7B%22orderReference.string%22%3A%22%22%7D%7D%2C%7B%22nested%22%3A%7B%22deliverables.items%22%3A%7B%22or%22%3A%5B%7B%22prefix%22%3A%7B%22deliverables.items._cm.common.clockNumber%22%3A%22%22%7D%7D%2C%7B%22prefix%22%3A%7B%22deliverables.items._cm.common.title%22%3A%22%22%7D%7D%2C%7B%22prefix%22%3A%7B%22deliverables.items._cm.asset.common.advertiser%22%3A%22%22%7D%7D%2C%7B%22prefix%22%3A%7B%22deliverables.items._cm.asset.common.brand%22%3A%22%22%7D%7D%2C%7B%22prefix%22%3A%7B%22deliverables.items._cm.asset.common.sub_brand%22%3A%22%22%7D%7D%2C%7B%22prefix%22%3A%7B%22deliverables.items._cm.asset.common.product%22%3A%22%22%7D%7D%2C%7B%22prefix%22%3A%7B%22deliverables.items._cm.asset.common.Campaign%22%3A%22%22%7D%7D%5D%7D");

        JsonObject obj = new JsonObject();
        obj.addProperty("_id", order.getId());
        obj.addProperty("_subtype", order.getSubtype());
        obj.addProperty("newMarketId", order.getTVMarketId()[0]);
        obj.add("_cm", gson.toJsonTree(order.getCm()));

        JsonObject agency = new JsonObject();
        agency.addProperty("_id", order.getAgency().getId());
        agency.addProperty("country", order.getAgency().getAgencyCountry());
        agency.addProperty("name", order.getAgency().getName());

        obj.add("agency", agency);

        JsonObject request = new JsonObject();
        request.add(key, obj);

        HttpPut put = createPut(address.toString(), request.toString());
        Type returnType = new TypeToken<Map<String, Order>>(){}.getType();
        Map<String, Order> result = sendRequest(put, returnType);
        for (Map.Entry<String, Order> entry : result.entrySet()) {
            if (entry.getKey().equals(key))
                return entry.getValue();
        }
        return null;
    }

    public Order saveAsDraftOrder(JsonObject order, String orderId) {
        String key = "orders/" + orderId;
        StringBuilder address = new StringBuilder(baseUrl);
        address.append("svc/").append(key).append("?sort=_created&order=desc&status=draft&query=%7B%22and%22%3A%5B%7B%22terms%22%3A%7B%22status%22%3A%5B%22draft%22%5D%7D%7D%2C%7B%22terms%22%3A%7B%22_subtype%22%3A%5B%22").append(order.getAsJsonPrimitive("_subtype").getAsString()).append("%22%5D%7D%7D%5D%7D&scroll=false&offset=0&size=10&page=1&count=10");

        JsonObject request = new JsonObject();
        request.add(key, order);

        HttpPut put = createPut(address.toString(), request.toString());
        Type returnType = new TypeToken<Map<String, Order>>(){}.getType();
        Map<String, Order> result = sendRequest(put, returnType);
        for (Map.Entry<String, Order> entry : result.entrySet()) {
            if (entry.getKey().equals(key))
                return entry.getValue();
        }
        return null;
    }

    public JsonObject prepareSaveAsDraftOrderRequest(Order order) {
        JsonObject obj = new JsonObject();
        obj.addProperty("_id", order.getId());
        obj.addProperty("_subtype", order.getSubtype());
        obj.add("_cm", gson.toJsonTree(order.getCm()));
        obj.addProperty("_created", order.getCreated().toString());
        obj.addProperty("_documentType", order.getDocumentType());
        obj.addProperty("_modified", order.getModified().toString());
        obj.add("_parents", gson.toJsonTree(order.getParents()));
        obj.addProperty("_version", order.get_version());

        JsonObject agency = new JsonObject();
        agency.addProperty("_id", order.getAgency().getId());
        agency.addProperty("country", order.getAgency().getAgencyCountry());
        agency.addProperty("name", order.getAgency().getName());

        obj.add("agency", agency);

        obj.add("copy_section", new JsonObject());
        obj.addProperty("assignee", order.getAssignee());

        JsonObject assignedTo = new JsonObject();
        assignedTo.addProperty("_id", order.getAssignedTo().getId());
        assignedTo.addProperty("email", order.getAssignedTo().getUserEmail());
        assignedTo.addProperty("firstName", order.getAssignedTo().getUserFirstName());
        assignedTo.addProperty("lastName", order.getAssignedTo().getUserLastName());
        assignedTo.addProperty("fullName", order.getAssignedTo().getUserFullName());

        obj.add("assignedTo", assignedTo);

        JsonObject createdBy = new JsonObject();
        createdBy.addProperty("_id", order.getCreatedBy().getId());
        createdBy.addProperty("email", order.getCreatedBy().getUserEmail());
        createdBy.addProperty("firstName", order.getCreatedBy().getUserFirstName());
        createdBy.addProperty("lastName", order.getCreatedBy().getUserLastName());
        createdBy.addProperty("fullName", order.getCreatedBy().getUserFullName());

        obj.add("createdBy", createdBy);

        JsonObject deliverables = new JsonObject();
        deliverables.add("items", new JsonArray());
        deliverables.addProperty("total", 0);

        obj.add("deliverables", deliverables);
        obj.add("deliveryReport", new JsonObject());

        JsonObject items = new JsonObject();
        for (int i = 0; i < order.getDeliverables().getOrderItems().length; i++) {
            JsonObject itemObj = new JsonObject();
            OrderItem orderItem = order.getDeliverables().getOrderItems()[i];
            itemObj.add("_cm", gson.toJsonTree(orderItem.getCm()));
            itemObj.addProperty("_created", orderItem.getCreated().toString());
            itemObj.addProperty("_documentType", orderItem.getDocumentType());
            itemObj.addProperty("_id", orderItem.getId());
            itemObj.addProperty("_modified", orderItem.getModified().toString());
            itemObj.add("_parents", gson.toJsonTree(orderItem.getParents()));
            itemObj.addProperty("_subtype", orderItem.getSubtype());
            itemObj.addProperty("_version", orderItem.get_version());

            JsonObject itemAgency = new JsonObject();
            itemAgency.addProperty("_id", orderItem.getAgency().getId());
            itemAgency.addProperty("country", orderItem.getAgency().getAgencyCountry());
            itemAgency.addProperty("name", orderItem.getAgency().getName());

            itemObj.add("agency", itemAgency);

            itemObj.add("clockValidate", new JsonObject());
            itemObj.add("a4", new JsonObject());
            itemObj.add("assets", new JsonObject());
            itemObj.add("clear_section", new JsonObject());
            itemObj.add("usageRights", new JsonObject());

            JsonObject itemCreatedBy = new JsonObject();
            itemCreatedBy.addProperty("_id", orderItem.getCreatedBy().getId());
            itemCreatedBy.addProperty("email", orderItem.getCreatedBy().getUserEmail());
            itemCreatedBy.addProperty("firstName", orderItem.getCreatedBy().getUserFirstName());
            itemCreatedBy.addProperty("lastName", orderItem.getCreatedBy().getUserLastName());
            itemCreatedBy.addProperty("fullName", orderItem.getCreatedBy().getUserFullName());

            itemObj.add("createdBy", itemCreatedBy);

            itemObj.addProperty("orderId", orderItem.getOrderId());
            itemObj.addProperty("owner", orderItem.getOwner());
            itemObj.add("status", gson.toJsonTree(orderItem.getStatus()));
            itemObj.add("uploads", new JsonObject());

            items.add(orderItem.getId(), itemObj);
        }
        obj.add("items", items);

        obj.addProperty("orderReference", order.getOrderReference());
        obj.addProperty("onHold", order.isOnHold());
        obj.addProperty("owner", order.getOwner());
        obj.add("status", gson.toJsonTree(order.getStatus()));
        obj.add("uploads", new JsonObject());
        return obj;
    }

    @Override
    public Order getOrderById(String orderId, boolean withOrderItems) {
        return getCoreService().getOrderById(orderId, withOrderItems);
    }

    @Override
    public String getDeliveryStatusFromA4(String orderRefference) {
        return null;
    }

    @Override
    public Integer getOrderFromTrafficById(String orderId) throws IOException {
        StringBuilder address = new StringBuilder(baseUrl);
        address.append("traffic/api/order_items/" + orderId);
        HttpGet get = new HttpGet(address.toString());
        return returnStatusCode(get);
    }

    public Integer getOrderFromTrafficById(String orderId,String qcAssetId) throws IOException {
        StringBuilder address = new StringBuilder(baseUrl);
        address.append("traffic/api/order_items/" + orderId+"?qcAssetId="+qcAssetId);
        HttpGet get = new HttpGet(address.toString());
        return returnStatusCode(get);
    }

    public String getOrderItemStatusFromTraffic(String orderId, String qcAssetId){
        StringBuilder address = new StringBuilder(baseUrl);
        address.append("traffic/api/order_items/"+orderId+"?qcAssetId="+qcAssetId);
        HttpGet get = new HttpGet(address.toString());
        String responseBody =  sendRequest(get);
        try{
            JsonObject tempjson = new JsonParser().parse(responseBody).getAsJsonObject().get("orderItems").getAsJsonArray().get(0).getAsJsonObject();
            return (tempjson.get("status").getAsString());
        }catch(Exception I)
        {return("");}

    }

    public String getOrderStatusFromTraffic(String orderId, String qcAssetId){
        StringBuilder address = new StringBuilder(baseUrl);
        address.append("traffic/api/order_items/"+orderId+"?qcAssetId="+qcAssetId);
        HttpGet get = new HttpGet(address.toString());
        String responseBody =  sendRequest(get);
        try{
            JsonObject tempjson = new JsonParser().parse(responseBody).getAsJsonObject();
            return (tempjson.get("status").getAsString());
        }catch(Exception I)
        {return("");}
    }


    public String getBroadcasterStatusFromTraffic(String orderId,String qcAssetId){
        StringBuilder address = new StringBuilder(baseUrl);
        address.append("traffic/api/order_items/"+orderId+"?qcAssetId="+qcAssetId);
        HttpGet get = new HttpGet(address.toString());
        String responseBody =  sendRequest(get);
         try{
             JsonObject tempjson = new JsonParser().parse(responseBody).getAsJsonObject();
             JsonObject json =tempjson.get("orderItems").getAsJsonArray().get(0).getAsJsonObject().get("deliveryItems").getAsJsonArray().get(0).getAsJsonObject();
            return (json.get("broadcasterStatus").getAsString());
        }catch(Exception I)
        {return("");}
    }


    public String getBroadcasterStatusFromTrafficForDestination(String orderId,String qcAssetId,String destination){
        StringBuilder address = new StringBuilder(baseUrl);
        address.append("traffic/api/order_items/" + orderId + "?qcAssetId=" + qcAssetId);
        HttpGet get = new HttpGet(address.toString());
        String responseBody =  sendRequest(get);
        JsonObject tempjson = new JsonParser().parse(responseBody).getAsJsonObject();
        Integer deliveriesNumber = new JsonParser().parse(responseBody).getAsJsonObject().get("orderItems").
                getAsJsonArray().get(0).getAsJsonObject().get("deliveryItems").getAsJsonArray().size();
        for (int i = 0; i < deliveriesNumber ; i++) {
            String deliveryName = new JsonParser().parse(responseBody).getAsJsonObject().get("orderItems")
                    .getAsJsonArray().get(0).getAsJsonObject().get("deliveryItems").getAsJsonArray().get(i)
                    .getAsJsonObject().get("name").getAsString();
            if(deliveryName.equalsIgnoreCase(destination)){
                return new JsonParser().parse(responseBody).getAsJsonObject().get("orderItems").getAsJsonArray()
                        .get(0).getAsJsonObject().get("deliveryItems").getAsJsonArray().get(i).getAsJsonObject()
                        .get("broadcasterStatus").getAsString();
            }
        }
        return null;
    }




    public String getA5ViewStatusFromTraffic(String orderId,String qcAssetId){
        StringBuilder address = new StringBuilder(baseUrl);
        address.append("traffic/api/order_items/"+orderId+"?qcAssetId="+qcAssetId);
        HttpGet get = new HttpGet(address.toString());
        String responseBody =  sendRequest(get);
        JsonObject json =new JsonParser().parse(responseBody).getAsJsonObject().get("orderItems").getAsJsonArray().get(0).getAsJsonObject().get("deliveryItems").getAsJsonArray().get(0).getAsJsonObject().get("details").getAsJsonObject();
        return (json.get("a5ViewStatus").getAsString());
    }
    public String getDeliveryStatusFromTraffic(String orderId,String destinationName){
        StringBuilder address = new StringBuilder(baseUrl);
        address.append("traffic/api/order_items/"+orderId);
        HttpGet get = new HttpGet(address.toString());
        String responseBody =  sendRequest(get);
        Integer deliveriesNumber = new JsonParser().parse(responseBody).getAsJsonObject().get("orderItems").
                getAsJsonArray().get(0).getAsJsonObject().get("deliveryItems").getAsJsonArray().size();
        for (int i = 0; i < deliveriesNumber ; i++) {
            String deliveryName = new JsonParser().parse(responseBody).getAsJsonObject().get("orderItems")
                    .getAsJsonArray().get(0).getAsJsonObject().get("deliveryItems").getAsJsonArray().get(i)
                    .getAsJsonObject().get("name").getAsString();
            if(deliveryName.equalsIgnoreCase(destinationName)){
                return new JsonParser().parse(responseBody).getAsJsonObject().get("orderItems").getAsJsonArray()
                        .get(0).getAsJsonObject().get("deliveryItems").getAsJsonArray().get(i).getAsJsonObject()
                        .get("deliveryItemStatus").getAsString();
            }
        }
        return null;
    }


    public String getDeliveryStatusFromTraffic(String orderId,String qcAssetId,String destinationName){
        StringBuilder address = new StringBuilder(baseUrl);
        address.append("traffic/api/order_items/"+orderId+"?qcAssetId="+qcAssetId);
        HttpGet get = new HttpGet(address.toString());
        String responseBody =  sendRequest(get);
        Integer deliveriesNumber = new JsonParser().parse(responseBody).getAsJsonObject().get("orderItems").
                getAsJsonArray().get(0).getAsJsonObject().get("deliveryItems").getAsJsonArray().size();
        for (int i = 0; i < deliveriesNumber ; i++) {
            String deliveryName = new JsonParser().parse(responseBody).getAsJsonObject().get("orderItems")
                    .getAsJsonArray().get(0).getAsJsonObject().get("deliveryItems").getAsJsonArray().get(i)
                    .getAsJsonObject().get("name").getAsString();
            if(destinationName.equalsIgnoreCase(deliveryName) || destinationName.substring(0,destinationName.length()-5).equalsIgnoreCase(deliveryName)){
               return new JsonParser().parse(responseBody).getAsJsonObject().get("orderItems").getAsJsonArray()
                        .get(0).getAsJsonObject().get("deliveryItems").getAsJsonArray().get(i).getAsJsonObject().get("details").getAsJsonObject()
                        .get("deliveryItemStatus").getAsString();
            }
        }
        return null;
    }


    @Override
    public Order completeOrder(Order order, QcView qcView) {
        String key = "orders/" + order.getId() + "/complete";
        StringBuilder address = new StringBuilder(baseUrl);
        address.append("svc/").append(key);

        JsonObject obj = new JsonObject();
        obj.addProperty("jobNumber", order.getJobNumber());
        obj.addProperty("poNumber", order.getPoNumber());
        obj.addProperty("pin", order.getPin());
        obj.addProperty("handleStandardsConversions", order.getHandleStandardsConversions());
        obj.addProperty("notifyAboutDelivery", order.getNotifyAboutDelivery());
        obj.addProperty("notifyAboutQc", order.getNotifyAboutQc());
        obj.add("notificationEmails", gson.toJsonTree(order.getNotificationEmails()));
        obj.add("qcView", gson.toJsonTree(qcView));

        JsonObject request = new JsonObject();
        request.add(key, obj);

        HttpPut put = createPut(address.toString(), request.toString());
        Type returnType = new TypeToken<Map<String, Order>>(){}.getType();
        Map<String, Order> result = sendRequest(put, returnType);
        for (Map.Entry<String, Order> entry : result.entrySet()) {
            if (entry.getKey().equals(key))
                return entry.getValue();
        }
        return null;
    }

    @Override
    public Order forceCompleteOrder(Order order) {
        throw new UnsupportedOperationException("Not implemented yet");
    }

    @Override
    public void moveOrderToBU(String orderId, String agencyId) {
    }

    @Override
    public List<BeamTvClock> getBeamTvClocks(String date) {
        throw new UnsupportedOperationException("Not implemented yet");
    }

    @Override
    public SearchResult<Order> findOrders(LuceneSearchingParams query) {
        String key = "orders";
        String q = query.getQuery() == null ? "" : query.getQuery();
        String order = query.getSortingOrder() == null ? "desc" : query.getSortingOrder();
        String sort = query.getSortingField() == null ? "_created" : query.getSortingField();
        String status = query.getStatus() == null ? "draft" : query.getStatus();
        int page = query.getPageNumber() == null ? 1 : query.getPageNumber();
        int size = query.getResultsOnPage() == null ? 10 : query.getResultsOnPage();
        int offset = (page - 1) * size;

        StringBuilder address = new StringBuilder(baseUrl);
        address.append("svc/").append(key).append("?sort=").append(sort).append("&order=").append(order).append("&status=").append(status);
        address.append("&query=").append(Common.urlEncode(q)).append("&scroll=false&size=").append(size).append("&page=").append(page);
        address.append("&offset=").append(offset).append("&count=").append(size).append("&depth=1");

        HttpGet get = new HttpGet(address.toString());
        Type returnType = new TypeToken<Map<String, Map<String, Order>>>(){}.getType();
        Map<String, Map<String, Order>> result = sendRequest(get, returnType);
        List<Order> orders = new ArrayList<Order>();
        for (Map.Entry<String, Order> entry : result.get(key).entrySet()) {
            if (entry.getKey().equals("_")) continue;
            orders.add(entry.getValue());
        }
        SearchResult<Order> searchResult = new SearchResult<Order>();
        searchResult.setResult(orders);
        return searchResult;
    }

    @Override
    public SearchResult<OrderCounter> getOrderCounters(String orderType) {
        HttpGet get = new HttpGet(baseUrl + "svc/ordersCount/" + orderType + "?depth=1");
        String json = sendRequest(get);
        JsonObject obj = new JsonParser().parse(json).getAsJsonObject().getAsJsonObject("ordersCount/" + orderType);
        List<OrderCounter> orderCounters = new ArrayList<OrderCounter>();
        for (Map.Entry<String, JsonElement> entry : obj.entrySet()) {
            orderCounters.add(gson.fromJson(entry.getValue(), OrderCounter.class));
        }
        SearchResult<OrderCounter> searchResult = new SearchResult<OrderCounter>();
        searchResult.setResult(orderCounters);
        return searchResult;
    }

    @Override
    public void deleteOrder(String orderId) {
        throw new UnsupportedOperationException("Not implemented yet");
    }

    @Override
    public void deleteOrders(String[] ordersIds) {
        throw new UnsupportedOperationException("Not implemented yet");
    }

    @Override
    public OrderItem createOrderItem(String orderId, String orderItemType, OrderItem orderItem) {
        String key = "orders/" + orderId + "/items";
        StringBuilder address = new StringBuilder(baseUrl);
        address.append("svc/").append(key).append("?");

        JsonObject obj = new JsonObject();

        JsonObject inner = new JsonObject();
        inner.addProperty("_subtype", orderItemType);
        inner.add("clear_section", new JsonObject());
        inner.add("clockValidate", new JsonObject());
        inner.add("uploads", new JsonObject());
        inner.add("usageRights", new JsonObject());
        inner.add("_cm", gson.toJsonTree(orderItem.getCm()));

        obj.add("@3", inner);

        JsonObject request = new JsonObject();
        request.add(key, obj);

        HttpPost post = createPost(address.toString(), request.toString());
        Type returnType = new TypeToken<Map<String, OrderItem>>(){}.getType();
        Map<String, OrderItem> result = sendRequest(post, returnType);
        for (Map.Entry<String, OrderItem> entry : result.entrySet()) {
            if (entry.getKey().startsWith(key))
                return entry.getValue();
        }
        return null;
    }

    @Override
    public OrderItem updateOrderItem(String orderId, String orderItemId, String orderItemType, OrderItem orderItem) {
        throw new UnsupportedOperationException("Not implemented yet");
    }

    @Override
    public SearchResult<OrderItem> findOrderItems(String orderItemType, LuceneSearchingParams query) {
        throw new UnsupportedOperationException("Not implemented yet");
    }

    @Override
    public OrderItem holdForApprovalOrderItem(String orderId, String orderItemId, String orderItemType, String approvalValue){
        throw new UnsupportedOperationException("Not implemented yet");
    }

    @Override
    public void deleteOrderItemApprovalStatus(String orderId, String orderItemId, String orderItemType){
        throw new UnsupportedOperationException("Not implemented yet");
    }

    @Override
    public OrderItem addMediaToOrderItem(String orderId, String orderItemId, String elementId, String orderItemType){
        throw new UnsupportedOperationException("Not implemented yet");
    }

    @Override
    public List<OrderItem> createOrderItemsAssociatedWithMedia(String orderId, String orderItemType, String[] assetElementIds){
        throw new UnsupportedOperationException("Not implemented yet");
    }

    @Override
    public void removeMediaFromOrderItem(String orderId, String orderItemId, String elementId, String orderItemType) {
        throw new UnsupportedOperationException("Not implemented yet");
    }

    @Override
    public void deleteOrderItem(String orderId, String orderItemId, String orderItemType) {
        throw new UnsupportedOperationException("Not implemented yet");
    }

    @Override
    public void deleteOrderItems(String[] orderItemsIds){
        throw new UnsupportedOperationException("Not implemented yet");
    }

    @Override
    public void deleteOrdersFromOrdersNotReplicatedToA4Queue(List<String> orderIds){
        throw new UnsupportedOperationException("Not implemented yet");
    }

    @Override
    public SearchResult<OrderCompletionQueue> getOrdersFromOrderCompletionQueue(){
        throw new UnsupportedOperationException("Not implemented yet");
    }

    @Override
    public List<String> getOrdersFromOrderCompletionQueue_id(){
        throw new UnsupportedOperationException("Not implemented yet");
    }

    @Override
    public void deleteOrdersFromCompletionQueue(String id){
        throw new UnsupportedOperationException("Not implemented yet");
    }

    @Override
    public SearchResult<Deliveries> findDeliveries(String clockNumber, LuceneSearchingParams query) {
        throw new UnsupportedOperationException("Not implemented yet");
    }

    @Override
    public DeliveryReport getDeliveryReport(String orderId) {
        throw new UnsupportedOperationException("Not implemented yet");
    }

    @Override
    public String getDeliveryReportUrl(String orderId) {
        StringBuilder address = new StringBuilder(baseUrl);
        address.append("orders/").append(orderId).append("/report/delivery/pdf");
        return address.toString();
    }

    @Override
    public String getBeamConfirmationReportUrl(String orderId) {
        StringBuilder address = new StringBuilder(baseUrl);
        address.append("orders/").append(orderId).append("/report/delivery_beam/pdf");
        return address.toString();
    }

    @Override
    public String getDraftOrderReportUrl(String orderId) {
        StringBuilder address = new StringBuilder(baseUrl);
        address.append("orders/").append(orderId).append("/report/draft_order/pdf");
        return address.toString();
    }

    @Override
    public String getDeliveryOrderReport(String orderId, String deliveryReportType, List<QcOrderItem> qcOrderItems) {
        throw new UnsupportedOperationException("Not implemented yet");
    }

    @Override
    public BaseSearchResult<Market> getTvMarkets() {
        String key = "deepDictionaries/ordering_tv_market";
        HttpGet get = new HttpGet(baseUrl + "svc/" + key + "?depth=0");
        Type returnType = new TypeToken<Map<String, BaseSearchResult<Market>>>(){}.getType();
        Map<String, BaseSearchResult<Market>> result = sendRequest(get, returnType);
        for (Map.Entry<String, BaseSearchResult<Market>> entry: result.entrySet())
            if (entry.getKey().equals(key))
                return entry.getValue();
        return null;
    }

    @Override
    public SearchDestinationPerMarketResult getDestinationsByMarket(String market, LuceneSearchingParams query) {
        String key = "deepDictionaries/ordering_tv_market." + Common.urlEncode(market);
        HttpGet get = new HttpGet(baseUrl + "svc/" + key + "?depth=0");
        Type returnType = new TypeToken<Map<String, SearchDestinationPerMarketResult>>(){}.getType();
        Map<String, SearchDestinationPerMarketResult> result = sendRequest(get, returnType);
        for (Map.Entry<String, SearchDestinationPerMarketResult> entry : result.entrySet()) {
            if (entry.getKey().equals(key))
                return entry.getValue();
        }
        return null;
    }

    @Override
    public void addAdditionalDestinations(Map<UploadRequestType, List<AdditionalDestination>> additionalDestinations) {
    }

    @Override
    public GDNFileRegister registerDocuments(List<GDNFileWrapper> gdnDocuments, String test, String type) {
        throw new UnsupportedOperationException("Not implemented yet");
    }

    @Override
    public void uploadDocumentsComplete(String gdnFileId) {
    }

    @Override
    public void uploadDocumentsCompleteTest(String attachedFileId, String gdnFileId) {
    }


    @Override
    public QcView getQcView(String orderId) {
        String key = "orders/" + orderId + "/proceedAssets";
        StringBuilder address = new StringBuilder(baseUrl);
        address.append("svc/").append(key);

        JsonObject obj = new JsonObject();
        obj.addProperty("doProceed", true);

        JsonObject request = new JsonObject();
        request.add(key, obj);

        HttpPut put = createPut(address.toString(), request.toString());
        String json = sendRequest(put);
        JsonObject proceedAssets = new JsonParser().parse(json).getAsJsonObject().getAsJsonObject("orders/" + orderId).getAsJsonObject("proceedAssets");
        List<QcOrderItem> qcOrderItems = new ArrayList<>();
        for (Map.Entry<String, JsonElement> entry : proceedAssets.entrySet())
            qcOrderItems.add(gson.fromJson(entry.getValue(), QcOrderItem.class));
        QcView qcView = new QcView();
        qcView.setItems(qcOrderItems.toArray(new QcOrderItem[qcOrderItems.size()]));
        return qcView;
    }

    @Override
    public void assignOrders(String[] ordersIds, String userEmail, String message) {
        throw new UnsupportedOperationException("Not implemented yet");
    }

    @Override
    public List<Transfer> getAssigns(String orderId) {
        throw new UnsupportedOperationException("Not implemented yet");
    }

    @Override
    public String enableBilling() {
        throw new UnsupportedOperationException("Not implemented yet");
    }

    @Override
    public String disableBilling() {
        throw new UnsupportedOperationException("Not implemented yet");
    }

    @Override
    public String getBillingStatus(){
        throw new UnsupportedOperationException("Not implemented yet");
    }

    @Override
    public Bookmark createBookmark(String name, int marketId, boolean isShared) {
        throw new UnsupportedOperationException("Not implemented yet");
    }

    @Override
    public Bookmark updateBookmark(Bookmark bookmark) {
        throw new UnsupportedOperationException("Not implemented yet");
    }

    @Override
    public Bookmark getBookmarkById(String bookmarkId) {
        throw new UnsupportedOperationException("Not implemented yet");
    }

    @Override
    public SearchResult<Bookmark> findBookmarks() {
        throw new UnsupportedOperationException("Not implemented yet");
    }

    @Override
    public void deleteBookmark(String bookmarkId) {
    }

    @Override
    public void authenticateToARPP(String userName, String password) {
    }

    @Override
    public void updateUserSessionByARPPUserCredentials(String userNameHash, String passwordHash) {
    }

    @Override
    public void findFieldsFromARPP(String criteria, String userName, String password) {
    }

    @Override
    public Price[] getPrices(BillingView billingView, String endPointUrl) {
        throw new UnsupportedOperationException("Not implemented yet");
    }

    @Override
    public Payment[] billOrder(List<Bill> bills, String endPointUrl) {
        throw new UnsupportedOperationException("Not implemented yet");
    }

    @Override
    public String updateAssetsBulkMetadata(List<String> assetsId, String agencyId, String advertiserValue) {
        JsonObject bulkMetadata = new JsonObject();
        JsonArray documentsId = new JsonArray();
        JsonArray list = new JsonArray();
        documentsId = gson.toJsonTree(assetsId).getAsJsonArray();
        bulkMetadata.add("documentIds", documentsId);
        bulkMetadata.addProperty("entityType", "asset");
        JsonObject listObject = new JsonObject();
        JsonObject mediaSubType = new JsonObject();
        mediaSubType.add("list", new JsonArray());
        listObject.add("mediaSubTypes", mediaSubType);
        JsonArray mediaType = new JsonArray();
        JsonArray advertiser = new JsonArray();
        mediaType.add(gson.toJsonTree("common").getAsJsonPrimitive());
        advertiser.add(gson.toJsonTree(advertiserValue).getAsJsonPrimitive());
        JsonObject common = new JsonObject();
        JsonObject _cm = new JsonObject();
        JsonObject metadata = new JsonObject();
        common.add("mediaType", mediaType);
        common.add("advertiser", advertiser);
        _cm.add("common", common);
        metadata.add("_cm", _cm);
        listObject.addProperty("agencyId", agencyId);
        listObject.add("metadata", metadata);
        list.add(listObject);

        bulkMetadata.add("list", list);
        JsonObject request = new JsonObject();
        request.add("bulkMetadata", bulkMetadata);

        HttpPut put = createPut(baseUrl + "svc/bulkMetadata", request.toString());
        return sendRequest(put);
    }

    @Override
    public String updateAssetsButchMetadata(List<ContentBatchUpdate> content) {
        return "Not implemented yet";
    }

    @Override
    public String getBatchProcessStatus(String processId) {
        return "Not implemented yet";
    }

    public String getProcessStatus(String processId, int depth) {
        HttpGet get = new HttpGet(baseUrl + "svc/processes/" + processId + "?depth" + depth);
        String responseBody =  sendRequest(get);
        return new JsonParser().parse(responseBody).getAsJsonObject().get("processes/".concat(processId)).getAsJsonObject().get("list").getAsJsonArray().get(0).getAsJsonObject().get("taskStatus").getAsString();
    }

    private void parseDictionaryMtValuesRecursive(CustomMetadata mtValues, DictionaryValues values) {
        if (values != null) {
            for (String key : values.getKeys()) {
                mtValues.put(key, new CustomMetadata());
                mtValues.getOrCreateNode(key).put("key", key);
                CustomMetadata items = new CustomMetadata();
                if (values.get(key).getValues() != null)
                    for (DictionaryItem item : values.get(key).getValues())
                        items.getOrCreateNode(item.getKey());
                mtValues.getOrCreateNode(key).put("values", items);
                String mtValuesPath = key + ".values";
                parseDictionaryMtValuesRecursive(mtValues.getOrCreateNodeForPath(mtValuesPath), values.get(key).getValues());
            }
        }
    }

    private void parseDictionaryValuesRecursive(DictionaryValues values, CustomMetadata mtValues) {
        for (String key : mtValues.keySet()) {
            DictionaryItem item = new DictionaryItem();
            item.setKey(key);
            item.setValues(new DictionaryValues());
            values.add(item);
            if (mtValues.getOrCreateNode(key).containsKey("values")) {
                parseDictionaryValuesRecursive(item.getValues(), mtValues.getOrCreateNodeForPath(key + ".values"));
            }
        }
    }

    @Override
    public String executeMigrationA4toA5(MigrationA4toA5 migrationA4toA5) {
        return "";
    }

    public String getMasterReceivedDateTraffic(String orderId, String qcAssetId){
        StringBuilder address = new StringBuilder(baseUrl);
        address.append("traffic/api/order_items/"+orderId+"?qcAssetId="+qcAssetId);
        HttpGet get = new HttpGet(address.toString());
        String responseBody =  sendRequest(get);
        return new JsonParser().parse(responseBody).getAsJsonObject().get("orderItems").getAsJsonArray().get(0).getAsJsonObject().get("orderItemDetails").getAsJsonObject().get("masterArrivedDate").getAsString();
    }

    @Override
    public IngestDoc getIngestId(String assetId) throws UnsupportedEncodingException {
        return null;
    }

    @Override
    public String setIngestId(IngestDoc ingestdoc, String ingestID, long size, String fileId, String assetId) {
        return null;
    }

    @Override
    public IngestDoc setCommentA5(String orderRef, String userId) throws UnsupportedEncodingException {
        return null;
    }


    @Override
    public String setAssetStatus(String assetId, String userId, String status) throws UnsupportedEncodingException {
        return null;
    }

    @Override
    public String redeliverAssetbyExtId(String extId, String userId) throws UnsupportedEncodingException {
        return null;
    }

    @Override
    public String redeliverAssetbyDeliveryId(String deliveryId, String userId) throws UnsupportedEncodingException {
        return null;
    }

    @Override
    public String orderdeliverbyOrderId(String orderId, String userId) throws UnsupportedEncodingException {
        return null;
    }

    @Override
    public String cancelDeliverybyDeliveryId(String deliveryId, String userId) throws UnsupportedEncodingException {
        return null;
    }

    @Override
    public String cancelDeliverybyExtId(String extId, String userId) throws UnsupportedEncodingException {
        return null;
    }

    @Override
    public List<GDNDeliveryDoc> getDeliveryDoc(String clockNumber, String userId) throws UnsupportedEncodingException {
        return null;
    }

    @Override
    public String setDuration(String assetId, String orderinguserId, String trafficuserId) throws UnsupportedEncodingException {
        return null;
    }


    @Override
    public String removeMasterArrived(String orderId,String itemId, String orderinguserId, String trafficuserId) throws UnsupportedEncodingException {
        return null;
    }


    @Override
    public String retranscodeAsset(String assetId, String orderinguserId, String trafficuserId) throws UnsupportedEncodingException {
        return null;
    }

    @Override
    public String refreshDestinations() throws UnsupportedEncodingException {
        return null;
    }

    @Override
    public String setHouseNumber(String userId,String deliveryId,String houseNumber) throws UnsupportedEncodingException {
        return null;
    }

    @Override
    public String deleteIngestRepo(String assetId){
        return null;
    }

    @Override
    public String addIngestRepo(String assetId){
        return null;
    }

    public String setMasterArrived(String orderId,String itemId, String orderinguserId, String trafficuserId, Map<String, String> row) throws UnsupportedEncodingException{
        return null;
    }

    @Override
    public GDNFileRegister registerGDNFiles(String agencyId,GDNFileWrapper file) {
        throw new UnsupportedOperationException("Implementation not needed");
    }

    public void uploadDocumentsCompleteTest_WaterMarking(String agencyId, String gdnFileId,String fileName){
        throw new UnsupportedOperationException("Implementation not needed");
    }

    public AssetFilter createAssetFilterNEWLIB(String name, String subtype, String query, String assetId) {
        String body = assetId != null ?
                String.format("{\"assetIds\":[\"%s\"],\"_subtype\":\"%s\",\"_cm\":{\"common\":{\"query\":\"%s\",\"name\":\"%s\"},\"emptyByDefault\":true}}",
                        assetId, subtype, StringEscapeUtils.escapeJava(query), name)
                : String.format("{\"_subtype\":\"%s\",\"_cm\":{\"common\":{\"query\":\"%s\",\"name\":\"%s\"}}}",
                subtype, StringEscapeUtils.escapeJava(query), name);
        HttpPost post = createPost(baseUrl + "new-library-beta/api/collections", body);
        Type returnType = new TypeToken<AssetFilter>() {
        }.getType();
        AssetFilter response = sendRequest(post, returnType);
        return response;
    }

    public AssetFilter addAssetToCollection(String name, String subtype, String query, String collectionId, String assetId) {
        throw new UnsupportedOperationException("Implementation not needed");
    }


    public void acceptAssetsFromCollection(String collectionId, String[] assetIds) {
        throw new UnsupportedOperationException("Implementation not needed");
    }

    public String generateCustomCode(String agencyId, String customCodeFieldName) {
        return null;
    }

    // Adcost
    public HttpResponse uploadAdcostSupportingDocsRegisterUpload(List<SupportingDocsWrapper> docsWrapper){ return null;}

    public void uploadAdcostSupportingDocsCompleteUpload(List<SupportingDocsWrapper> docsWrapper, String request){ }

    public void uploadAdcostSupportingDocs(List<SupportingDocsWrapper> docsWrapper){ }

    public void uploadAdditionalSupportingDocumentsInAdCostCompleteUpload(List<SupportingDocsWrapper> docsWrapper,String request){ }

    public void uploadAdcostAdditionalSupportingDocs(List<SupportingDocsWrapper> docsWrapper){ }

    public CostStage getCostStage(String costId ) { return null;}

    public CostStageRevision getCostStageRevision(String costId, String costStageId) { return null; }

    public SupportingDocuments[] getSupportingDocuments(String costId, String costStageId, String costStageRevision) { return null; }

    public HttpResponse downloadSupportingDocuments(String costId, String costStageId, String costStageRevisionId,String supportingDocumentId,String formName){ return null; }

    public BudgetFormTemplates[] getBudgetFormTemplates() { return null; }

    public String downloadBudgetForms(String budgetFormTemplateId) { return null;}

    public String downloadAssociatedAssets(String costId, String revisionId){return null;}

    public String checkDownloadProjectTotals(String projectId){return null;}

    public String downloadExpectedAssets(String costId,  String stageId, String revisionId){return null;}

    public void uploadBudgetForms(List<BudgetFormsWrapper> docsWrapper){ }

    public String uploadBudgetFormInCostLineItem(List<BudgetFormsWrapper> docsWrapper, boolean checkBadRequest){ return  null;}

    public CostsCount getCosts(){ return null;}

    public CostsCount getCostsByPage(int pageNumber){return null;}

    public CostTemplates[] getCostTemplates() { return null; }

    public AdcostDictionaries[] getAdcostDictionaries() { return null; }

    public AdcostCurrency[] getAdcostCurrnecy() { return null; }

    public Costs createCostDetails(CostDetails costDetails) {return null;}

    public ExchangeRates[] getExchangeRates(String costId){return null;}

    public AdcostDictionaries[] getTravellerRole(){return null;}

    public AdcostDictionaries[] getShootCity(){return null;}

    public TravelRegions[] getTravelRegions(){return null;}

    public PerDiems[] getTravelPerDiems() {return null;}

    public TravelCountry[] getTravelCountry(){return null;}

    public TravelDetails createTravelCostDetails(TravelDetails travelDetails){return null;}

    public void deleteTravelCostDetails(TravelDetails travelDetails){}

    public TravelDetails[] getTravelCostDetails(TravelDetails travelDetails){return null;}

    public AdcostDictionaries[] getDirectorName(){return null;}

    public AdcostDictionaries[] getPhotographerName(){return null;}

    public SmoOrganisations[] getSmoOrganisations(String budgetRegionId){return null;}

    public BudgetRegions[] getBudgetRegions(){return null;}

    public VendorsCount getVendors(String searchText){return null;}

    public Vendors[] getVendorListPerProductionCategory(String productionCategory){return null;}

    public Vendors[] getVendorListforNonProductionCost(String productionCategory){return  null;}

    public Vendors createVendors(Vendors vendors){return null;};

    public void updateVendors(Vendors vendors){};

    public void createProductionDetails(String costId, BaseProductionDetails details){}

    public AdcostDictionaries[] getInitiatives(){return null;}

    public AdcostDictionaries[] getAdcostDictionaryByName(String name){return null;}

    public void createEntryInAdcostDictionary(ContentType request){};

    public AdcostDictionaries[] getAdcostDictionaryByNameGDAMway(String name){return null;}

    public void createEntryInAdcostDictionaryGDAMway(ContentType request){};

    public AdId generateAdId(AdId adId){return null;}

    public void createExpectedAssets(ExpectedAssets assets){}

    public void createCostLineItemData(CostLineItems lineItems){}

    public void createIoNumber(String objectId, String name, Data data){};

    public CustomData getIoNumber(String objectId, String name){return null;}

    public CostLineItemDataResponse[] getCostLineItemDetails(String costId,String costStageId,String revisionId){return null;}

    public Approvals[] getApproversListForCost(String costId, String costStageId, String revisionId){return null;}

    public ApprovalMembers[] getApproverDetails(String id){return null;};

    public void addApprovers(String costId, String costStageId, String revisionId, List<Approvals> approvers){};

    public void submitCostForApproval(String costId, String action, String Comments){};

    public void createUsageBuyOutDetails(UpdateCostForm details, String costId){};

    public void createNegotiatedTerms(UpdateCostForm details, String costId){};

    public ProjectSearch[] getProjectNumber(String gdamProjectId){return null;};

    public CostUser searchUserByAgencyID(String gdamAgencyId){return null;};

    public String getUserRoleInCostModule(String email){return  null;};

    public UserRoles[] getBusinessRoles(){return null;};

    public Agencies[] getAgencyIdInCostModule(){return  null;}

    public void grantUserAccessInCostModule(String userId,String businessRoleId,String approvalLimit,String accessType,String typeId,String labelName, String notificationBudgetRegionId){};

    public String getCostsAsString(String costTitle){return null;};

    public ValueReportingDetails getValueReportingdetails(String costId,String costRevisionId){return null;};

    public ValueReportingDetails editValueReportingdetails(String costId,String costRevisionId, ValueReportingDetails reportingDetails){return null;};

    public ExpectedAssets[] getExpectedAssets(String costId, String costStageId, String revisionId){return null;};

    public VendorsCount getVendorsGDAMway(String searchText){return null;};

    public Vendors createVendorsGDAMway(Vendors vendors){return null;};

    public String checkAdCostHeartBeat(){return  null;};

    public Vendors getVendorDetails(String id){return null;}

    public CostOwners[] getCostOwnersforCostId(String costId){return null;};


    /** MEDIA MANAGER **/
    public AQAReport getQCReportDataView(String fileId, String currentUserEmail) {return null;}

    public PAPIApplication generatePAPIKeySecret(String email, String id){ return null;}

    public PAPIApplication[] listApplications(String email){ return null;}


    public String getBillingOrderReportUrl(String orderId) {
        throw new UnsupportedOperationException("Not yet implemented");
    }

    public Boolean checkAssetDownloaded_newlibrary(String assetName,String assetId,String assetType){ return false;};

    public Boolean checkAssetDownloadedSendplus(String assetId,String assetType){ return false;};

    public Boolean checkStoryBoardDownload(String assetId,String[] fileIds){ return false;};
    public String uploadDocument_WorkRequest(GDNFileWrapper fileWrapper) {
        throw new UnsupportedOperationException("Implementation not needed");
    }

    class VersionBranch {
        String version;

        public String getVersion() {
            return version;
        }
    }


    public String getNewLibraryMiddleTierVersion() {
        HttpGet get = new HttpGet(baseUrl + "streamlined-library-beta/api/heartbeat");
        VersionBranch result = sendRequest(get, VersionBranch.class);
        return result.getVersion();
    }

    public String getNewLibraryWebappVersion() {
        HttpGet get = new HttpGet(baseUrl + "streamlined-library-beta/version");
        VersionBranch result = sendRequest(get, VersionBranch.class);
        return result.getVersion();
    }


    public BaseObject UploadComplete_WorkRequest(String projectFolderId,String brieffileId,String fileName){
        return null;
    }


    public String getAdditionalServiceStatusFromTraffic(String orderId,String qcAssetId,String destination,String serviceType){
        StringBuilder address = new StringBuilder(baseUrl);
        address.append("traffic/api/order_items/"+orderId+"?qcAssetId="+qcAssetId);
        HttpGet get = new HttpGet(address.toString());
        String responseBody =  sendRequest(get);
        JsonObject json=null;
        String status="";
        JsonArray jsonArray= new JsonArray();
        try{
            JsonObject tempjson = new JsonParser().parse(responseBody).getAsJsonObject();
            if(serviceType.equalsIgnoreCase("dubbing"))
                jsonArray =tempjson.get("orderItems").getAsJsonArray().get(0).getAsJsonObject().get("additionalServices").getAsJsonObject().get("dubbingServices").getAsJsonArray();
            else if(serviceType.equalsIgnoreCase("production"))
                    jsonArray =tempjson.get("orderItems").getAsJsonArray().get(0).getAsJsonObject().get("additionalServices").getAsJsonObject().get("productionServices").getAsJsonArray();
            for (JsonElement obj:jsonArray){
                if(obj.getAsJsonObject().get("destination").getAsString().equalsIgnoreCase(destination)) {
                    status=(obj.getAsJsonObject().get("status").getAsString());
                }
            }
            return status;
        }catch(Exception I)
        {return("");}
    }

    public String getA5ViewStatusFromTraffic(String orderId,String qcAssetId,String destination){
        StringBuilder address = new StringBuilder(baseUrl);
        address.append("traffic/api/order_items/"+orderId+"?qcAssetId="+qcAssetId);
        HttpGet get = new HttpGet(address.toString());
        String responseBody =  sendRequest(get);
        JsonObject json = null;
        String a5ViewStatus= null;
        JsonArray jsonArray=new JsonParser().parse(responseBody).getAsJsonObject().get("orderItems").getAsJsonArray().get(0).getAsJsonObject().get("deliveryItems").getAsJsonArray();
        for (JsonElement obj:jsonArray){
           if(obj.getAsJsonObject().get("name").getAsString().equalsIgnoreCase(destination)) {
               a5ViewStatus=(obj.getAsJsonObject().get("details").getAsJsonObject().get("a5ViewStatus").getAsString());
           }
        }

        return a5ViewStatus;
    }

    public String getOrderItemA5ViewStatusfromTrafficForClones(String orderId,String destination) throws IOException{return  null;}


}