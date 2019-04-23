package com.adstream.automate.babylon.middleware;

import com.adstream.automate.babylon.JsonObjectBuilder;
import com.adstream.automate.babylon.JsonObjects.*;
import com.adstream.automate.babylon.LuceneSearchingParams;
import com.adstream.automate.babylon.TestsContext;
import com.adstream.automate.babylon.sso.SSOProfile;
import com.adstream.automate.babylon.sso.SSOUtils;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import org.apache.http.Header;
import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.client.methods.HttpPut;
import org.apache.http.entity.FileEntity;
import org.apache.http.entity.StringEntity;
import org.apache.http.entity.mime.MultipartEntityBuilder;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;

import java.io.File;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * User: ruslan.semerenko
 * Date: 24.12.13 15:47
 */
public class BabylonSendplusMiddleTierService extends BabylonMiddlewareService {
    public BabylonSendplusMiddleTierService(URL url) {
        super(url);
    }

    @Override
    public String auth(String email, String password) {
        throw new UnsupportedOperationException("Unavailable for nverge");
    }

    @Override
    public String impersonate(String email, String comment) {
        throw new UnsupportedOperationException("Unavailable for nverge");
    }

    @Override
    public User getCurrentUser() {
        HttpGet get = new HttpGet(baseUrl + "svc/nverge/current");
        String response = sendRequest(get);
        String userId = new JsonParser().parse(response).getAsJsonObject()
                .getAsJsonObject("current").getAsJsonPrimitive("user_id").getAsString();
        return getUser(userId);
    }
    @Override
    public String loginToSendplusMiddleTier(String emailID, String passWord) throws IOException {
        JsonObject loginRequest = new JsonObjectBuilder()

                .add("login", emailID)
                .add("password", passWord)
                .build();
        CloseableHttpClient httpClient = HttpClientBuilder.create().build();
        HttpPost request = new HttpPost(TestsContext.getInstance().sendplusMiddleTierUrl+"/login");
        StringEntity params = new StringEntity(loginRequest.toString());
        request.addHeader("content-type", "application/json");
        request.setEntity(params);
        HttpResponse response = httpClient.execute(request);
        String jsonString = EntityUtils.toString(response.getEntity());
        Header[] headers = response.getAllHeaders();
        for (Header header : headers) {
            //  System.out.println("Key : " + header.getName()
            //     + " ,Value : " + header.getValue());
        }
        String cookie = response.getFirstHeader("set-cookie").getValue();
        JsonObject obj = new JsonParser().parse(jsonString).getAsJsonObject();
        httpClient.close();
        return cookie;

    }
    @Override
    public HashMap<String, String> createFileIDForSendplusUploadToProjects(String cookie, String folderId) throws IOException

    {
        HashMap<String, String> hmap = new HashMap<String, String>();
        CloseableHttpClient httpClient = HttpClientBuilder.create().build();
        HttpPost request  = new HttpPost(TestsContext.getInstance().sendplusMiddleTierUrl+"/v2/transfers/adbank/files/upload");
        StringEntity params = new StringEntity(
                "    {\n"+
                        "\"folderId\": \""+folderId+"\",\n" +
                        "\"limit\": 6,"+
                        "     \"path\": \"\",\n" +
                        "        \"name\": \"logo3.jpg\",\n" +
                        "        \"size\": 2996,\n" +
                        "        \"transferId\": \"{341ea983-23c7-4629-8ff4-24be3b5a4226}\",\n" +
                        "        \"type\": \"projects\"\n" +
                        "    }\n"
        );
        String content = EntityUtils.toString(params);
        request.setHeader("Cookie", cookie);
        request.addHeader("Content-Type", "application/json");
        request.setEntity(params);
        HttpResponse response = httpClient.execute(request);
        String jsonString = EntityUtils.toString(response.getEntity());
        String fileID = new JsonParser().parse(jsonString).getAsJsonObject().getAsJsonPrimitive("fileId").getAsString();
        String isS3 = new JsonParser().parse(jsonString).getAsJsonObject().getAsJsonPrimitive("isS3").getAsString();
        String uploadURL = new JsonParser().parse(jsonString).getAsJsonObject().get("urlList").getAsJsonArray().get(0).getAsJsonObject().get("url").getAsString();
        hmap.put("upload_id", fileID);
        hmap.put("upload_url", uploadURL);
        hmap.put("isS3", isS3);
        return hmap;


    }

    @Override
    public void downloadFolderAndProjectViaUsingSendplusMiddletier(String cookie, String elementID, String fileID)
    {
        HttpGet request = new HttpGet(TestsContext.getInstance().sendplusMiddleTierUrl+"/destinations/adbank%40adstream.com/locations/"+elementID+"/files/"+fileID+"?type=projects&transferId=12356");
        request.setHeader("Cookie", cookie);
        request.addHeader("Content-Type", "application/json");
        String response = sendRequest(request);
    }

    @Override
    public void uploadFileToAdbankStorageViaSendplusMiddleTier(String uploadURL, File file) throws IOException
    {

        File filename = file;
        CloseableHttpClient client = HttpClients.createDefault();
        HttpPost request = new HttpPost(uploadURL);
        MultipartEntityBuilder entityBuilder = MultipartEntityBuilder.create();
        File file_path = new File(String.valueOf(filename));
        entityBuilder.addBinaryBody("image", file_path);
        request.setEntity(entityBuilder.build());
        HttpResponse response = client.execute(request);
    }

    @Override
    public String uploadFileToS3AdbankStorageViaSendplusMiddleTier(String uploadURL, File file) throws IOException
    {

        File filename = file;
        CloseableHttpClient client = HttpClients.createDefault();
        HttpPut httppost = new HttpPut(uploadURL);
        File file_path = new File(String.valueOf(filename));
        FileEntity reqEntity = new FileEntity(file_path, "binary/octet-stream");
        httppost.setEntity(reqEntity);
        reqEntity.setContentType("binary/octet-stream");
        HttpResponse response = client.execute(httppost);
        HttpEntity resEntity = response.getEntity();
        Header[] headers = response.getAllHeaders();
        String eTagParse = response.getFirstHeader("ETag").getValue();
        String eTag = eTagParse.substring(1, eTagParse.length() - 1);
        return eTag;
    }

    @Override
    public void displayFileInProjectsViaSendplusMiddleTier(String cookie, String uploadID, String folderId)throws IOException
    {
        CloseableHttpClient httpClient = HttpClientBuilder.create().build();
        HttpPut request  = new HttpPut(TestsContext.getInstance().sendplusMiddleTierUrl+"/v2/transfers/adbank/files/upload/"+uploadID);
        String id = uploadID;
        StringEntity params = new StringEntity("{\n" +
                "    \"partList\": [   \n" +

                "    ]\n" +
                "}");
        String content = EntityUtils.toString(params);
        request.setHeader("Cookie", cookie);
        request.addHeader("Content-Type", "application/json");
        request.setEntity(params);
        HttpResponse response = httpClient.execute(request);
        String jsonString = EntityUtils.toString(response.getEntity());

    }

    @Override
    public void displayS3FileInProjectsViaSendplusMiddleTier(String cookie, String uploadID, String folderId,String eTag)throws IOException
    {
        CloseableHttpClient httpClient = HttpClientBuilder.create().build();
        HttpPut request  = new HttpPut(TestsContext.getInstance().sendplusMiddleTierUrl+"/v2/transfers/adbank/files/upload/"+uploadID);
        String id = uploadID;
        StringEntity params = new StringEntity("{\n" +
                "\"partList\":[\n"+
                "{"+
                "\"ETag\": \""+eTag+"\",\n" +
                "\"PartNumber\":1 \n" +
                "} \n"+
                "]\n"+
                "}");
        String content = EntityUtils.toString(params);
        request.setHeader("Cookie", cookie);
        request.addHeader("Content-Type", "application/json");
        request.setEntity(params);
        HttpResponse response = httpClient.execute(request);
        String jsonString = EntityUtils.toString(response.getEntity());

    }
    @Override
    public HashMap<String, String> createFileIDForSendplusUploadToLibrary(String cookie) throws IOException

    {
        HashMap<String, String> hmap = new HashMap<String, String>();
        CloseableHttpClient httpClient = HttpClientBuilder.create().build();
        HttpPost request  = new HttpPost(TestsContext.getInstance().sendplusMiddleTierUrl+"/v2/transfers/adbank/files/upload");
        StringEntity params = new StringEntity(
                "    {\n"+
                        "\"folderId\": \"library\",\n" +
                        "\"limit\": 6,"+
                        "     \"path\": \"\",\n" +
                        "        \"name\": \"logo3.jpg\",\n" +
                        "        \"size\": 2996,\n" +
                        "        \"transferId\": \"{341ea983-23c7-4629-8ff4-24be3b5a4226}\",\n" +
                        "        \"type\": \"library\"\n" +
                        "    }\n"
        );
        String content = EntityUtils.toString(params);
        request.setHeader("Cookie", cookie);
        request.addHeader("Content-Type", "application/json");
        request.setEntity(params);
        HttpResponse response = httpClient.execute(request);
        String jsonString = EntityUtils.toString(response.getEntity());
        String isS3 = new JsonParser().parse(jsonString).getAsJsonObject().getAsJsonPrimitive("isS3").getAsString();
        String fileID = new JsonParser().parse(jsonString).getAsJsonObject().getAsJsonPrimitive("fileId").getAsString();
        String uploadURL = new JsonParser().parse(jsonString).getAsJsonObject().get("urlList").getAsJsonArray().get(0).getAsJsonObject().get("url").getAsString();
        hmap.put("upload_id", fileID);
        hmap.put("upload_url", uploadURL);
        hmap.put("isS3", isS3);
        return hmap;


    }



    @Override
    public HashMap<String, String> uploadFileRevisionViaSendplus(String cookie,String fileId,String fname,int fsize) throws IOException

    {
        HashMap<String, String> hmap = new HashMap<String, String>();
        CloseableHttpClient httpClient = HttpClientBuilder.create().build();
        HttpPost request  = new HttpPost(TestsContext.getInstance().sendplusMiddleTierUrl+"/v2/transfers/adbank/files/upload");
        StringEntity params = new StringEntity(
                "    {\n"+
                        "\"fileId\": \""+fileId+"\",\n" +
                        "\"limit\": 6,"+
                        "     \"path\": \"\",\n" +
                        "        \"name\": \""+fname+"\",\n" +
                        "        \"size\": "+fsize+",\n" +
                        "        \"transferId\": \"{341ea983-23c7-4629-8ff4-24be3b5a4226}\",\n" +
                        "        \"type\": \"projectFileRevision\"\n" +
                        "    }\n"
        );
        String content = EntityUtils.toString(params);
        request.setHeader("Cookie", cookie);
        request.addHeader("Content-Type", "application/json");
        request.setEntity(params);
        HttpResponse response = httpClient.execute(request);
        String jsonString = EntityUtils.toString(response.getEntity());
        String isS3 = new JsonParser().parse(jsonString).getAsJsonObject().getAsJsonPrimitive("isS3").getAsString();
        String fileID = new JsonParser().parse(jsonString).getAsJsonObject().getAsJsonPrimitive("fileId").getAsString();
        String uploadURL = new JsonParser().parse(jsonString).getAsJsonObject().get("urlList").getAsJsonArray().get(0).getAsJsonObject().get("url").getAsString();
        hmap.put("upload_id", fileID);
        hmap.put("upload_url", uploadURL);
        hmap.put("isS3", isS3);
        return hmap;


    }

    @Override
    public HashMap<String, String> uploadFileAttachmentViaSendplus(String cookie,String fileId,String fname,int fsize) throws IOException

    {
        HashMap<String, String> hmap = new HashMap<String, String>();
        CloseableHttpClient httpClient = HttpClientBuilder.create().build();
        HttpPost request  = new HttpPost(TestsContext.getInstance().sendplusMiddleTierUrl+"/v2/transfers/adbank/files/upload");
        StringEntity params = new StringEntity(
                "    {\n"+
                        "\"fileId\": \""+fileId+"\",\n" +
                        "\"limit\": 6,"+
                        "     \"path\": \"\",\n" +
                        "        \"name\": \""+fname+"\",\n" +
                        "        \"size\": "+fsize+",\n" +
                        "        \"transferId\": \"{341ea983-23c7-4629-8ff4-24be3b5a4226}\",\n" +
                        "        \"type\": \"projectAttachments\"\n" +
                        "    }\n"
        );
        request.setHeader("Cookie", cookie);
        request.addHeader("Content-Type", "application/json");
        request.setEntity(params);
        HttpResponse response = httpClient.execute(request);
        String jsonString = EntityUtils.toString(response.getEntity());
        String isS3 = new JsonParser().parse(jsonString).getAsJsonObject().getAsJsonPrimitive("isS3").getAsString();
        String fileID = new JsonParser().parse(jsonString).getAsJsonObject().getAsJsonPrimitive("fileId").getAsString();
        String uploadURL = new JsonParser().parse(jsonString).getAsJsonObject().get("urlList").getAsJsonArray().get(0).getAsJsonObject().get("url").getAsString();
        hmap.put("upload_id", fileID);
        hmap.put("upload_url", uploadURL);
        hmap.put("isS3", isS3);
        return hmap;


    }


    @Override
    public void displayFileInLibraryViaSendplusMiddleTier(String cookie, String uploadID)throws IOException
    {
        CloseableHttpClient httpClient = HttpClientBuilder.create().build();
        HttpPut request  = new HttpPut(TestsContext.getInstance().sendplusMiddleTierUrl+"/v2/transfers/adbank/files/upload/"+uploadID);
        String id = uploadID;
        StringEntity params = new StringEntity("{\n" +
                "    \"partList\": [   \n" +

                "    ]\n" +
                "}");
        String content = EntityUtils.toString(params);
        request.setHeader("Cookie", cookie);
        request.addHeader("Content-Type", "application/json");
        request.setEntity(params);
        HttpResponse response = httpClient.execute(request);
        String jsonString = EntityUtils.toString(response.getEntity());
    }

    @Override
    public void displayS3FileInLibraryViaSendplusMiddleTier(String cookie, String uploadID,String eTag)throws IOException
    {
        CloseableHttpClient httpClient = HttpClientBuilder.create().build();
        HttpPut request  = new HttpPut(TestsContext.getInstance().sendplusMiddleTierUrl+"/v2/transfers/adbank/files/upload/"+uploadID);
        String id = uploadID;
        StringEntity params = new StringEntity("{\n" +
                "\"partList\":[\n"+
                "{"+
                "\"ETag\": \""+eTag+"\",\n" +
                "\"PartNumber\":1 \n" +
                "} \n"+
                "]\n"+
                "}");
        String content = EntityUtils.toString(params);
        request.setHeader("Cookie", cookie);
        request.addHeader("Content-Type", "application/json");
        request.setEntity(params);
        HttpResponse response = httpClient.execute(request);
        String jsonString = EntityUtils.toString(response.getEntity());
    }


    @Override
    public HashMap<String, String> assetAttachmentViaSendplus(String cookie,String assetId,String fname,int fsize) throws IOException

    {
        HashMap<String, String> hmap = new HashMap<String, String>();
        CloseableHttpClient httpClient = HttpClientBuilder.create().build();
        HttpPost request  = new HttpPost(TestsContext.getInstance().sendplusMiddleTierUrl+"/v2/transfers/adbank/files/upload");
        StringEntity params = new StringEntity(
                "    {\n"+
                        "\"assetId\": \""+assetId+"\",\n" +
                        "\"limit\": 6,"+
                        "     \"path\": \"\",\n" +
                        "        \"name\": \""+fname+"\",\n" +
                        "        \"size\": "+fsize+",\n" +
                        "        \"transferId\": \"{341ea983-23c7-4629-8ff4-24be3b5a4226}\",\n" +
                        "        \"type\": \"libraryAttachments\"\n" +
                        "    }\n"
        );
        String content = EntityUtils.toString(params);
        request.setHeader("Cookie", cookie);
        request.addHeader("Content-Type", "application/json");
        request.setEntity(params);
        HttpResponse response = httpClient.execute(request);
        String jsonString = EntityUtils.toString(response.getEntity());
        String isS3 = new JsonParser().parse(jsonString).getAsJsonObject().getAsJsonPrimitive("isS3").getAsString();
        String fileID = new JsonParser().parse(jsonString).getAsJsonObject().getAsJsonPrimitive("fileId").getAsString();
        String uploadURL = new JsonParser().parse(jsonString).getAsJsonObject().get("urlList").getAsJsonArray().get(0).getAsJsonObject().get("url").getAsString();
        hmap.put("upload_id", fileID);
        hmap.put("upload_url", uploadURL);
        hmap.put("isS3", isS3);
        return hmap;


    }




    @Override
    public String authSSO(String email, String password) {
        try {
            String contentTypeOld = contentType;
            String samlResponse = logInCosmos(email, password);
            String xmlResponse = SSOUtils.decodeSamlMessage(samlResponse);
            SSOProfile profile = SSOUtils.parseProfile(xmlResponse);
            String agencyName = profile.getAgencyName();
            String ssoToken = profile.getAuthenticationToken();
            contentType = contentTypeOld;

            JsonObject request = new JsonObjectBuilder()
                    .add("sso", ssoToken)
                    .forNode("profile")
                    .add("http://www.adstream.com/ns/accounts/agencyName", agencyName)
                    .add("http://www.adstream.com/ns/accounts/userEmail", email)
                    .build();
            HttpPost post = createPost(baseUrl + "auth", request.toString());
            return sendRequest(post);
        } catch (RuntimeException e) {
            throw new RuntimeException(String.format("Could not login as user '%s' with password '%s' using nverg auth", email, password), e);
        }
    }

    @Override
    public FileStorage getGdnStorageForAgency(String agencyId) {
        HttpGet get = new HttpGet(baseUrl + "svc/nverge/storage");
        String response = sendRequest(get);
        JsonObject obj = new JsonParser().parse(response).getAsJsonObject().getAsJsonObject("storage");
        return gson.fromJson(obj, FileStorage.class);
    }

    @Override
    public FileStorage getGdnStorageForFolder(String folderId) {
        String key = "storage/" + folderId;
        HttpGet get = new HttpGet(baseUrl + "svc/nverge/" + key);
        String response = sendRequest(get);
        JsonObject obj = new JsonParser().parse(response).getAsJsonObject().getAsJsonObject(key);
        return gson.fromJson(obj, FileStorage.class);
    }

    @Override
    public String getDeliveryStatusFromA4(String orderRefference) {
        return null;
    }

    public List<Project> getProjects(int page, int size) {
        HttpGet get = new HttpGet(baseUrl + "svc/nverge/projects?sort=_cm.common.name&page=" + page + "&size=" + size + "&depth=1");
        String result = sendRequest(get);
        List<Project> projects = new ArrayList<>();
        JsonObject projectsObj = new JsonParser().parse(result).getAsJsonObject().getAsJsonObject("projects");
        for (Map.Entry<String, JsonElement> entry : projectsObj.entrySet()) {
            if (entry.getKey().equals("_")) {
                continue;
            }
            JsonObject obj = entry.getValue().getAsJsonObject();
            Project project = new Project();
            project.setId(obj.getAsJsonPrimitive("id").getAsString());
            project.setName(obj.getAsJsonPrimitive("name").getAsString());
            projects.add(project);
        }
        return projects;
    }

    @Override
    public Project getProject(String projectId) {
        String key = "projects/" + projectId;
        HttpGet get = new HttpGet(baseUrl + "svc/nverge/" + key);
        String result = sendRequest(get);
        JsonObject contentObj = new JsonParser().parse(result).getAsJsonObject().getAsJsonObject(key);
        Project project = new Project();
        project.setId(contentObj.getAsJsonPrimitive("id").getAsString());
        project.setName(contentObj.getAsJsonPrimitive("name").getAsString());
        return project;
    }

    @Override
    public SearchResult<Project> findProjects(LuceneSearchingParams query) {
        String address = String.format(baseUrl + "svc/nverge/projectFind?name=%s&size=%d&page=%d&depth=1",
                query.getQuery(), query.getResultsOnPage(), query.getPageNumber());
        HttpGet get = new HttpGet(address);
        String response = sendRequest(get);
        JsonObject obj = new JsonParser().parse(response).getAsJsonObject().getAsJsonObject("projectFind");
        List<Project> projects = new ArrayList<>();
        for (Map.Entry<String, JsonElement> entry : obj.entrySet()) {
            if (!entry.getKey().equals("_")) {
                JsonObject value = entry.getValue().getAsJsonObject();
                Project project = new Project();
                project.setName(value.get("name").getAsString());
                project.setId(value.get("id").getAsString());
                projects.add(project);
            }
        }
        SearchResult<Project> result = new SearchResult<>();
        result.setResult(projects);
        result.setMore(obj.get("_").getAsJsonObject().get("_").getAsJsonObject().get("extra").getAsJsonObject().get("more").getAsBoolean());
        return result;
    }

    @Override
    public Content getContent(String contentId) {
        String key = "files/" + contentId;
        HttpGet get = new HttpGet(baseUrl + "svc/nverge/" + key);
        String result = sendRequest(get);
        JsonObject contentObj = new JsonParser().parse(result).getAsJsonObject().getAsJsonObject(key);
        Content content = new Content();
        content.setId(contentObj.getAsJsonPrimitive("id").getAsString());
        content.setName(contentObj.getAsJsonPrimitive("name").getAsString());
        return content;
    }

    public Content getFullContent(String contentId) {
        return super.getContent(contentId);
    }

    @Override
    public SearchResult<Content> findContentAllProjects(LuceneSearchingParams query) {
        String key = "projects/" + query.getQuery() + "/folders";
        HttpGet get = new HttpGet(baseUrl + "svc/nverge/" + key + "?perm=folder.read");
        String result = sendRequest(get);

        List<Content> folders = new ArrayList<>();
        JsonObject obj = new JsonParser().parse(result).getAsJsonObject().get(key).getAsJsonObject();
        for (Map.Entry<String, JsonElement> entry : obj.entrySet()) {
            JsonObject element = entry.getValue().getAsJsonObject();
            if (!element.get("isRoot").getAsBoolean()) {
                Content folder = new Content();
                folder.setName(element.get("name").getAsString());
                folder.setId(element.get("id").getAsString());
                folders.add(folder);
            }
        }
        SearchResult<Content> sr = new SearchResult<>();
        sr.setResult(folders);
        return sr;
    }

    public List<Content> findFolders(String name, int page, int size) {
        HttpGet get = new HttpGet(baseUrl + "svc/nverge/projectContentFolderFind?name=" + name + "&page=" + page + "&size=" + size);
        String result = sendRequest(get);
        JsonObject foldersObj = new JsonParser().parse(result).getAsJsonObject().getAsJsonObject("projectContentFolderFind");
        List<Content> folders = new ArrayList<>();
        for (Map.Entry<String, JsonElement> entry : foldersObj.entrySet()) {
            if (entry.getKey().equals("_")) {
                continue;
            }
            JsonObject obj = entry.getValue().getAsJsonObject();
            Content folder = new Content();
            folder.setId(obj.getAsJsonPrimitive("id").getAsString());
            folder.setName(obj.getAsJsonPrimitive("name").getAsString());
            folders.add(folder);
        }
        return folders;
    }

    @Override
    public Content createContent(String parentId, Content content) {
        JsonObject request = new JsonObjectBuilder()
                .forNode("nverge/files.@1")
                .add("_subtype", content.getSubtype())
                .add("folderId", parentId)
                .add("tmp-path", content.getTmpPath())
                .add("name", content.getName())
                .build();

        HttpPost post = createPost(baseUrl + "svc/nverge/files?", request.toString());
        String response = sendRequest(post);
        JsonObject result = new JsonParser().parse(response).getAsJsonObject();
        for (Map.Entry<String, JsonElement> entry : result.entrySet()) {
            if (entry.getKey().startsWith("files/")) {
                return gson.fromJson(entry.getValue(), Content.class);
            }
        }
        return null;
    }

    public void triggerDownloadFiles(List<Content> files) {
        JsonArray list = new JsonArray();
        for (Content file : files) {
            JsonObject obj = new JsonObject();
            obj.addProperty("fileId", file.getLastRevision().getMaster().getFileID());
            obj.addProperty("elementId", file.getId());
            list.add(obj);
        }

        JsonObject request = new JsonObjectBuilder()
                .forNode("nVerge.@1")
                .add("list", list)
                .build();

        HttpPost post = createPost(baseUrl + "svc/nVerge?", request.toString());
        sendRequest(post);
    }
}
