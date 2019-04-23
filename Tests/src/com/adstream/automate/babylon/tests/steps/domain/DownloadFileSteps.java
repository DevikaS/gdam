package com.adstream.automate.babylon.tests.steps.domain;

import com.adstream.automate.babylon.BabylonService;
import com.adstream.automate.babylon.BabylonServiceWrapper;
import com.adstream.automate.babylon.JsonObjects.*;
import com.adstream.automate.babylon.TestDataContainer;
import com.adstream.automate.babylon.TestsContext;
import com.adstream.automate.babylon.core.AbstractTranscodingChecker;
import com.adstream.automate.babylon.core.BabylonCoreService;
import com.adstream.automate.babylon.sut.data.MetadataItem;
import com.adstream.automate.babylon.sut.pages.adbank.projects.AdbankFileApprovalsPage;
import com.adstream.automate.babylon.sut.pages.adbank.projects.AdbankFileCommentsPage;
import com.adstream.automate.babylon.sut.pages.adbank.projects.AdbankFileVersionHistoryPage;
import com.adstream.automate.babylon.sut.pages.adbank.projects.AdbankProjectFileInfoPage;
import com.adstream.automate.babylon.sut.pages.adbank.projects.elements.*;
import com.adstream.automate.babylon.tests.steps.core.GenericSteps;
import com.adstream.automate.hamcrest.StringByRegExpCheck;
import com.adstream.automate.utils.Common;
import com.google.gson.*;
import org.apache.commons.httpclient.Header;
import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpMethod;
import org.apache.commons.httpclient.HttpMethodBase;
import org.apache.commons.httpclient.cookie.CookiePolicy;
import org.apache.commons.httpclient.methods.GetMethod;
import org.apache.commons.lang.StringEscapeUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.util.EntityUtils;
import org.jbehave.core.annotations.Given;
import org.jbehave.core.annotations.Then;
import org.jbehave.core.annotations.When;
import org.jbehave.core.model.ExamplesTable;
import org.junit.Assert;
import org.openqa.selenium.By;
import org.openqa.selenium.TimeoutException;
import org.openqa.selenium.WebElement;
import scala.util.parsing.json.JSONArray;
import scala.util.parsing.json.JSONObject;

import javax.xml.bind.JAXBException;
import java.awt.*;
import java.awt.event.KeyEvent;
import java.io.*;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.*;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.*;


/**
 * Created with IntelliJ IDEA.
 * User: demidovskiy-r
 * Date: 17.09.12
 * Time: 15:06
 */
public class DownloadFileSteps extends AbstractFileViewSteps {

    @Override
    public Project getObjectByName(String objectName) {
        return getCoreApi().getProjectByName(objectName);
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
    protected AdbankFileCommentsPage getFileCommentsPage(String projectId, String folderId, String fileId) {
        return getSut().getPageNavigator().getProjectFileCommentsPage();
    }

    @Override
    protected AdbankProjectFileRelatedFilesPage getProjectRelatedFilesPage(String projectId, String folderId, String fileId) {
        return null;
    }

    @Override
    protected AdbankFileUsageRightsPage getFileUsageRightsPage(String projectId, String folderId, String fileId) {
        return getSut().getPageNavigator().getProjectFileUsageRightsPage();
    }

    @Override
    protected AdbankFileVersionHistoryPage getFileVersionHistoryPage(String projectId, String folderId, String fileId) {
        return getSut().getPageNavigator().getProjectFileVersionHistoryPage(projectId, folderId, fileId);
    }

    @Override
    protected AdbankFileApprovalsPage getFileApprovalsPage(String projectId, String folderId, String fileId) {
        return getSut().getPageNavigator().getProjectFileApprovalsPage(projectId, folderId, fileId);
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

    public ArrayList<Object> downloadFileviaAPI(String type, String filePath, String path, String projectName, String targetFilename) throws IOException {
        String DownloadedSize = null;
        Project fsObject = getObjectByName(wrapVariableWithTestSession(projectName));
        Content folder = getCoreApi(fsObject.getCreatedBy()).getFolderByPath(fsObject.getId(), wrapPathWithTestSession(path));
        Content file = getCoreApi().getFileByName(folder.getId(), new File(filePath).getName());
        AdbankFilesInfoPage filesInfoPage = getFilesInfoPage(fsObject.getId(), folder.getId(), file.getId());
        final String downloadLocation = TestsContext.getInstance().gdnUrl + getDownloadUrl(type, file, targetFilename);
        URL downloadURL = new URL(downloadLocation);
        //WebDriver driver = getSut().getWebDriver();
        HttpClient client = new HttpClient();
        client.getParams().setCookiePolicy(CookiePolicy.RFC_2965);
        client.setHostConfiguration(mimicHostConfiguration(downloadURL.getHost(), downloadURL.getPort()));
        client.setState(mimicCookieState(getSut().getWebDriver().manage().getCookies()));
        HttpMethod getRequest = new GetMethod(downloadLocation);
        int status = client.executeMethod(getRequest);
        final String response = getRequest.getResponseBodyAsString();
        HttpMethod getRequestAdgate = new GetMethod(response);
        status = client.executeMethod(getRequestAdgate);
        ArrayList<Object> downloadrequests = new ArrayList<Object>();
        downloadrequests.add(getRequestAdgate);
        downloadrequests.add(getRequest);
        return downloadrequests;
    }

    @When("{I |}on download size of '$type' file '$filePath' on folder '$path' project '$projectName' file info page matches size of '$targetFilename'")
    @Then("{I |}on download size of '$type' file '$filePath' on folder '$path' project '$projectName' file info page matches size of '$targetFilename'")
    public void downloadOriginalfile(String type, String filePath, String path, String projectName, String targetFilename) throws IOException {
        ArrayList<Object> downloadList = downloadFileviaAPI(type, filePath, path, projectName, targetFilename);
        String originalSize = originalorproxySize(type);
        checkheaderContent((HttpMethod) downloadList.get(0), originalSize, "Content-Length", "");
        checkheaderContent((HttpMethod) downloadList.get(0), null, "Content-Disposition", targetFilename);
        HttpMethod getRequest = (HttpMethod) downloadList.get(1);
        getRequest.releaseConnection();

    }

    //QA-725 - Changes Starts
    @When("{I |}download multiple frame grabbed '$type' file '$filePath' on folder '$path' project '$projectName' file")
    @Then("{I |}download multiple frame grabbed '$type' file '$filePath' on folder '$path' project '$projectName' file")
    public void downloadMultipleFrameGrabs(String type, String filePath, String path, String projectName) throws IOException {
        Project fsObject = getObjectByName(wrapVariableWithTestSession(projectName));
        Content folder = getCoreApi(fsObject.getCreatedBy()).getFolderByPath(fsObject.getId(), wrapPathWithTestSession(path));
        Content file = getCoreApi().getFileByName(folder.getId(), new File(filePath).getName());
        String fileId = file.getId();
        String masterFileId = "";
        if (type.equalsIgnoreCase(("master")))
            masterFileId = file.getLastRevision().getMaster().getFileID();
        downloadMultipleFrames(fileId, masterFileId);
    }

    @When("{I |}download multiple frame grabbed '$type' file '$filePath' in collection '$collectionName' from Library")
    @Then("{I |}download multiple frame grabbed '$type' file '$filePath' in collection '$collectionName' from Library")
    public void downloadMultipleFrameGrabsFromLib(String type, String filePath, String collectionName) throws IOException {
        String collectionId = getCategoryId(wrapCollectionName(collectionName));
        Content asset = getCoreApi().getAssetByName(collectionId, new File(filePath).getName());
        String fileId = asset.getId();
        String masterFileId = "";
        if (type.equalsIgnoreCase(("master")))
            masterFileId = asset.getLastRevision().getMaster().getFileID();
        downloadMultipleFrames(fileId, masterFileId);
    }

    public void downloadMultipleFrames(String fileId, String masterFileId) throws IOException {
        User user = getData().getCurrentUser();
        String userId = user.getId();
        final String stillIdsLocation = TestsContext.getInstance().applicationUrl + getStillIdsLocation(fileId, masterFileId, userId);
        URL downloadURL = new URL(stillIdsLocation);
        HttpClient client = new HttpClient();
        HttpMethodBase getRequest = new GetMethod(stillIdsLocation);
        int status = client.executeMethod(getRequest);
        final String responseBody = getRequest.getResponseBodyAsString(67108864);
        String stildids = getStillids(responseBody);
        //Executing download framegrab post request
        final String downloadLocation = TestsContext.getInstance().applicationUrl + getMultipleFrameGrabsDownloadUrl(userId);
        URL frameGrabberDownloadURL = new URL(downloadLocation);
        String downloadRequestBody = buildFrameGrabberBodyRequest(fileId, masterFileId, stildids);
        StringEntity input = null;
        HttpResponse response = sendFrameGrabberDownloadziprequest(input, downloadLocation, downloadRequestBody);
        String responseasString = response.toString();
        int statusCode = response.getStatusLine().getStatusCode();
        Assert.assertEquals("Multiple framegrabs are not downloaded, please check", statusCode, 200);
        assertThat("Check Transfer-Encoding is empty", responseasString.contains("Transfer-Encoding: chunked"), equalTo(true));
    }

    public HttpResponse sendFrameGrabberDownloadziprequest(StringEntity input, String downloadLocation, String downloadRequestBody) throws IOException {
        DefaultHttpClient httpClient = new DefaultHttpClient();
        HttpPost postRequest = new HttpPost(downloadLocation);
        input = new StringEntity(downloadRequestBody);
        input.setContentType("application/json");
        postRequest.setEntity(input);
        HttpResponse response = httpClient.execute(postRequest);
        postRequest.releaseConnection();
        return response;
    }

    public String buildFrameGrabberBodyRequest(String fileId, String masterFileId, String stildids) {
        StringBuilder body = new StringBuilder();
        body.append("{\"subjectId\":");
        body.append(fileId);
        body.append("\",\"");
        body.append("entityId\":\"");
        body.append(masterFileId);
        body.append("\",\"stillIds\":[");
        body.append(stildids);
        body.append("]}");
        return body.toString();
    }

    public String getStillids(String responseBody) {
        JsonObject jobj = new JsonParser().parse(responseBody).getAsJsonObject();
        JsonArray jsonarr_1 = (JsonArray) jobj.get("stills");
        StringBuilder stillIds = new StringBuilder();
        for (int i = 0; i < jsonarr_1.size(); i++) {
            JsonObject jsonobj_1 = (JsonObject) jsonarr_1.get(i);
            String stillId = jsonobj_1.get("_id").toString();
            stillIds = stillIds.append(stillId).append(",");
        }
        stillIds.setLength(stillIds.length() - 1);
        return stillIds.toString();
    }
    //QA-725 - Changes Ends

    public long downloadOriginalfilesize(String type, String filePath, String path, String projectName, String targetFilename) throws IOException {
        ArrayList<Object> downloadList = downloadFileviaAPI(type, filePath, path, projectName, targetFilename);
        String originalSize = originalorproxySize(type);
        return getContentLength((HttpMethod) downloadList.get(0), originalSize, "Content-Length", "");
    }

    @Then("{I |} '$should' see download size of '$filepath' Proxy file $proxyfileName' on folder '$path' project '$projectName' file info page is less than the size of '$MasterFilename'")
    public void checkMasterProxydownloadsize(String shouldState, String filePath, String proxyfile, String path, String projectName, String MasterFilename) throws IOException {
        boolean should = shouldState.equals("should");
        Long MasterFileSize = downloadOriginalfilesize("original", filePath, path, projectName, MasterFilename);
        Long ProxyFileSize = downloadOriginalfilesize("preview", filePath, path, projectName, proxyfile);
        assertThat("Master File size is Smaller than proxy", (MasterFileSize > ProxyFileSize), equalTo(should));
    }

    protected String getCategoryId(String categoryName) {
        AssetFilter category = getCoreApi().getAssetsFilterByName(categoryName, "");
        if (category != null) {
            return category.getId();
        }
        throw new RuntimeException(String.format("Could not find category '%s'", categoryName));
    }

    protected String getCategoryIdForClient(String categoryName, String userId) {
        AssetFilter category = getCoreApi().getAssetsFilterByNameForClient(categoryName, "", userId);
        if (category != null) {
            return category.getId();
        }
        throw new RuntimeException(String.format("Could not find category '%s'", categoryName));
    }

    public ArrayList<Object> downloadZipfileViaApiFrmLib(String type, String filePath, String targetfilename, String collectionName) throws IOException, JAXBException {
        String collectionId = getCategoryId(wrapCollectionName(collectionName));
        Content asset = getCoreApi().getAssetByName(collectionId, new File(filePath).getName());
        final String downloadLocation = TestsContext.getInstance().gdnUrl + getDownloadUrl(type, asset, targetfilename);
        URL downloadURL = new URL(downloadLocation);
        HttpClient client = new HttpClient();
        client.getParams().setCookiePolicy(CookiePolicy.RFC_2965);
        client.setHostConfiguration(mimicHostConfiguration(downloadURL.getHost(), downloadURL.getPort()));
        client.setState(mimicCookieState(getSut().getWebDriver().manage().getCookies()));
        HttpMethod getRequest = new GetMethod(downloadLocation);
        int status = client.executeMethod(getRequest);
        final String response = getRequest.getResponseBodyAsString();
        HttpMethod getRequestAdgate = new GetMethod(response);
        status = client.executeMethod(getRequestAdgate);
        ArrayList<Object> downloadrequests = new ArrayList<Object>();
        downloadrequests.add(getRequestAdgate);
        downloadrequests.add(getRequest);
        return downloadrequests;
    }

    public ArrayList<Object> downloadZipfileViaApiFrmLibForClient(String type, String filePath, String targetfilename, String collectionName, String email) throws IOException, JAXBException {
        User user = getCoreApi().getUserByEmail(email);
        String userId = user.getId();
        String collectionId = getCategoryIdForClient(wrapCollectionName(collectionName), userId);
        Content asset = getCoreApi().getAssetByName(collectionId, new File(filePath).getName());
        final String downloadLocation = TestsContext.getInstance().gdnUrl + getDownloadUrl(type, asset, targetfilename);
        URL downloadURL = new URL(downloadLocation);
        HttpClient client = new HttpClient();
        client.getParams().setCookiePolicy(CookiePolicy.RFC_2965);
        client.setHostConfiguration(mimicHostConfiguration(downloadURL.getHost(), downloadURL.getPort()));
        client.setState(mimicCookieState(getSut().getWebDriver().manage().getCookies()));
        HttpMethod getRequest = new GetMethod(downloadLocation);
        int status = client.executeMethod(getRequest);
        final String response = getRequest.getResponseBodyAsString();
        HttpMethod getRequestAdgate = new GetMethod(response);
        status = client.executeMethod(getRequestAdgate);
        ArrayList<Object> downloadrequests = new ArrayList<Object>();
        downloadrequests.add(getRequestAdgate);
        downloadrequests.add(getRequest);
        return downloadrequests;
    }

    @When("{I |}'$type' files '$filePath' is downloaded as '$targetfilename' in collection '$collectionName' from Library")
    @Then("{I |}'$type' files '$filePath' is downloaded as '$targetfilename' in collection '$collectionName' from Library")
    public void downloadOriginalfileFromLib(String type, String filePath, String targetFilename, String collectionName) throws IOException, JAXBException {
        ArrayList<Object> downloadList = downloadZipfileViaApiFrmLib(type, filePath, targetFilename, collectionName);
        checkheaderContent((HttpMethod) downloadList.get(0), null, "Content-Disposition", targetFilename);
        HttpMethod getRequest = (HttpMethod) downloadList.get(1);
        getRequest.releaseConnection();

    }

    @When("{I |}'$type' files '$filePath' is downloaded for client as '$targetfilename' in collection '$collectionName' from Library for '$email'")
    @Then("{I |}'$type' files '$filePath' is downloaded for client as '$targetfilename' in collection '$collectionName' from Library for '$email'")
    public void downloadOriginalfileFromLibForClient(String type, String filePath, String targetFilename, String collectionName, String email) throws IOException, JAXBException {
        ArrayList<Object> downloadList = downloadZipfileViaApiFrmLibForClient(type, filePath, targetFilename, collectionName, email);
        checkheaderContent((HttpMethod) downloadList.get(0), null, "Content-Disposition", targetFilename);
        HttpMethod getRequest = (HttpMethod) downloadList.get(1);
        getRequest.releaseConnection();

    }

    public long getContentLength(HttpMethod getRequest, String Size, String headerType, String filename) {
        Long fileSizeKB = null;
        if (headerType.equalsIgnoreCase("Content-Length")) {
            String s = headerType;
            Header[] responseAdgateHeaderCL = getRequest.getResponseHeaders(s);
            int index = responseAdgateHeaderCL[0].toString().trim().indexOf(":");
            String DownloadedSize = responseAdgateHeaderCL[0].toString().trim().substring(index + 1);
            fileSizeKB = Long.parseLong(DownloadedSize.replaceAll("\\s+", "")) / 1024;
            getRequest.releaseConnection();
        }
        return fileSizeKB;
    }

    //Project layer-Download API calls... Type: Can have value master, original, preview, proxy or (master,proxy)
    @When("{I |}'$type' files '$filePath' on folder '$path' project '$projectName' is downloaded as '$targetfilename'")
    @Then("{I |}'$type' files '$filePath' on folder '$path' project '$projectName' is downloaded as '$targetfilename'")
    public void downloadZipfile(String type, String filePath, String path, String projectName, String targetfilename) throws IOException, JAXBException {
        Project fsObject = getObjectByName(wrapVariableWithTestSession(projectName));
        String Agencyname = fsObject.getAgency().getName();
        Agency Ag = getAgencyByName(Agencyname);
        String storageid = Ag.getStorageId();
        String storageSubType = null;
        List<FileStorage> storages = new BabylonCoreService(TestsContext.getInstance().coreUrl[0]).getGdnStorages().getResult();
        for (FileStorage storage : storages) {
            if (storage.getFileStorageId().equals(storageid)) {
                storageSubType = storage.getFileStorageSubType();
            }
        }
        if (storageSubType.equalsIgnoreCase("s3")) {
            BabylonSteps.checkWarningMessage("Your download link is being prepared. You will receive it shortly by email.");
            User user = getData().getCurrentUser();
            EmailSteps emailSteps = new EmailSteps();
            emailSteps.openLinkFromEmail(user.getEmail(), "Your files are available for download");
            LoginSteps loginSteps = new LoginSteps();
            loginSteps.checkIsItLoginPage("should not");
            GenericSteps.checkTextOnPage("Download");
        } else {
            HttpResponse response;
            StringEntity input = null;
            HttpPost postRequest;
            String filenames[] = filePath.split(",");
            if (type.equalsIgnoreCase("master") || type.equalsIgnoreCase("original")) {
                type = "master";
            } else if (type.equalsIgnoreCase("proxy") || type.equalsIgnoreCase("preview")) {
                type = "proxy";
            } else if (type.equalsIgnoreCase("master,proxy")) {
                type = "master_proxy";
            }
            Content folder = getCoreApi(fsObject.getCreatedBy()).getFolderByPath(fsObject.getId(), wrapPathWithTestSession(path));

            final String downloadLocation = TestsContext.getInstance().gdnUrl + getDownloadZipUrl(storageid);
            URL downloadURL = new URL(downloadLocation);
            String ziprequest = buildZipRequest(type, folder, filenames, path);
            response = sendziprequest(input, ziprequest, downloadLocation);
            HttpEntity responseEntity = response.getEntity();
            String responseasString = EntityUtils.toString(responseEntity);
            String adgateCall = responseasString.substring(responseasString.indexOf("http"), responseasString.indexOf("</Url>"));
            String requestbody = StringEscapeUtils.unescapeXml(responseasString.substring(responseasString.indexOf("<Post>") + 6, responseasString.indexOf("</Post>")));
            requestbody = requestbody.replaceAll("\\+", "%2B");
            response = sendziprequest(input, requestbody, adgateCall);
            Assert.assertTrue(checkzipHeaders(response, "Content-Disposition").contains(targetfilename));
            // Assert.assertEquals(checkzipHeaders(response,"Content-Disposition"),targetfilename);
        }
    }

    @When("{I |}'$type' files '$filePath' from Library from collection '$collectionid' is downloaded as '$targetfilename'")
    @Then("{I |}'$type' files '$filePath' from Library from collection '$collectionid' is downloaded as '$targetfilename'")
    public void downloadZipFrmLib(String type, String filePath, String collectionName, String targetfilename) throws IOException {
        ArrayList<Content> assetList = new ArrayList<Content>();
        String filenames[] = filePath.split(",");
        String collectionId = getCategoryId(wrapCollectionName(collectionName));
        for (int i = 0; i < filenames.length; i++) {
            Content asset = getCoreApi().getAssetByName(collectionId, new File(filenames[i]).getName());
            assetList.add(asset);
        }
        HttpResponse response;
        StringEntity input = null;
        HttpPost postRequest;
        User user = getCoreApi().getCurrentUser();
        final String downloadLocation = TestsContext.getInstance().coreUrl[0]+"/asset/download/archive?with=permissions&%24id%24=id-" + user.getId() + "&%24originId%24=id-4ef31ce1766ec96769b399c0";
        String ziprequest = buildZipRequestForLibrary(type, assetList);
        response = sendziprequestwitJSONRequestBody(input, ziprequest, downloadLocation);
        String responseBody = EntityUtils.toString(response.getEntity());
        Assert.assertTrue(responseBody.contains(targetfilename));
    }

    @When("{I |}'$type' files '$filePath' on Presentation '$presentationName' from collection '$collectionid' is downloaded for '$AgencyName'")
    @Then("{I |}'$type' files '$filePath' on Presentation '$presentationName' from collection '$collectionid' is downloaded for '$AgencyName'")
    public void downloadZipfileFrmLib(String type, String filePath, String presentationName, String collectionName, String AgencyName) throws IOException, JAXBException {
        HttpResponse response;
        StringEntity input = null;
        HttpPost postRequest;
        String filenames[] = filePath.split(",");
        if (type.equalsIgnoreCase("master") || type.equalsIgnoreCase("original")) {
            type = "master";
        } else if (type.equalsIgnoreCase("proxy") || type.equalsIgnoreCase("preview")) {
            type = "proxy";
        } else if (type.equalsIgnoreCase("master,proxy")) {
            type = "master_proxy";
        }
        String collectionId = getCategoryId(wrapCollectionName(collectionName));
        Agency Ag = getAgencyByName(AgencyName);
        String storageid = Ag.getStorageId();
        final String downloadLocation = TestsContext.getInstance().gdnUrl + getDownloadZipUrl(storageid);
        URL downloadURL = new URL(downloadLocation);
        String ziprequest = buildZipRequestForReels(type, collectionId, filenames, presentationName);
        response = sendziprequest(input, ziprequest, downloadLocation);
        HttpEntity responseEntity = response.getEntity();
        String responseasString = EntityUtils.toString(responseEntity);
        String adgateCall = responseasString.substring(responseasString.indexOf("http"), responseasString.indexOf("</Url>"));
        String requestbody = StringEscapeUtils.unescapeXml(responseasString.substring(responseasString.indexOf("<Post>") + 6, responseasString.indexOf("</Post>")));
        requestbody = requestbody.replaceAll("\\+", "%2B");
        response = sendziprequest(input, requestbody, adgateCall);
        String targetfilenameWithTestSession = wrapPathWithTestSession(presentationName) + "_" + type + "";
        Assert.assertTrue(checkzipHeaders(response, "Content-Disposition").contains(targetfilenameWithTestSession)); // to handle NGN-19155
        //Assert.assertEquals(checkzipHeaders(response, "Content-Disposition"), targetfilenameWithTestSession);
    }

    public String getDownloadZipUrl(String Storageid) {
        StringBuilder url = new StringBuilder("/storage/");
        url = url.append(Storageid);
        url = url.append("/CreateZipRequest");
        return url.toString();
    }

    public String buildZipRequestForLibrary(String type, List<Content> assetList) {
        StringBuilder sb = new StringBuilder();

        sb.append("{\"documents\":[\"");
        for (int i = 0; i < assetList.size(); i++) {
            sb.append(assetList.get(i).getLastRevision().getMaster().getFileID());
            if (i <= assetList.size() - 2)
                sb.append("\",\"");
        }
        sb.append("\"],\"assets\":[\"");
        for (int i = 0; i < assetList.size(); i++) {
            sb.append(assetList.get(i).getLastRevision().getMaster().getFileID());
            if (i <= assetList.size() - 2)
                sb.append("\",\"");
        }
        sb.append("\"],\"guises\":[\"");
        if (type.equalsIgnoreCase("master")) {
            sb.append("master\"],\"customProxyNames\":[]}");
        }
        if (type.equalsIgnoreCase("proxy")) {
            sb.append("proxy\"],\"customProxyNames\":[]}");
        }
        System.out.println(sb.toString());
        String jsonContentTosend = sb.toString();
        return jsonContentTosend;
    }

    public String buildZipRequest(String type, Content folder, String filenames[], String folderpath) {
        StringBuilder sb = new StringBuilder();
        sb.append("<FileIDListWithName name=\"").append(type).append("\">");
        if (type.equalsIgnoreCase("master")) {
            for (int i = 0; i < filenames.length; i++) {
                sb.append("<id name=\"").append(filenames[i]).append("\" guid=\"").append(getCoreApi().getFileByName(folder.getId(), new File(filenames[i]).getName()).getLastRevision().getMaster().getFileID()).append("\">string</id>");
            }
        } else if (type.equalsIgnoreCase(("proxy"))) {
            for (int i = 0; i < filenames.length; i++) {
                Content file = getCoreApi().getFileByName(folder.getId(), filenames[i]);
                String expectedFileId = null;
                for (FilePreview preview : file.getLastRevision().getPreview())
                    if (preview.getA5Type().equals("video_proxy")) {
                        expectedFileId = preview.getFileID();
                    }
                sb.append("<id name=\"").append(filenames[i].replace(".mov", "_preview.mov")).append("\" guid=\"").append(expectedFileId).append("\">string</id>");
            }
        } else if (type.equalsIgnoreCase(("master_proxy"))) {
            for (int i = 0; i < filenames.length; i++) {
                sb.append("<id name=\"").append(filenames[i]).append("\" guid=\"").append(getCoreApi().getFileByName(folder.getId(), new File(filenames[i]).getName()).getLastRevision().getMaster().getFileID()).append("\">string</id>");
            }
            for (int i = 0; i < filenames.length; i++) {
                Content file = getCoreApi().getFileByName(folder.getId(), filenames[i]);
                String expectedFileId = null;
                for (FilePreview preview : file.getLastRevision().getPreview())
                    if (preview.getA5Type().equals("video_proxy")) {
                        expectedFileId = preview.getFileID();
                    }
                sb.append("<id name=\"").append(filenames[i].replace(".mov", "_preview.mov")).append("\" guid=\"").append(expectedFileId).append("\">string</id>");
            }
        }
        sb.append("</FileIDListWithName>");
        String xmlContentTosend = sb.toString();
        return xmlContentTosend;
    }

    public String buildZipRequestForReels(String type, String collectionId, String filenames[], String presentationName) {
        ArrayList<Content> assetList = new ArrayList<Content>();
        for (int i = 0; i < filenames.length; i++) {
            Content asset = getCoreApi().getAssetByName(collectionId, new File(filenames[i]).getName());
            assetList.add(asset);
        }
        StringBuilder sb = new StringBuilder();
        sb.append("<FileIDListWithName name=\"").append(wrapPathWithTestSession(presentationName) + "_" + type).append("\">");
        if (type.equalsIgnoreCase("master")) {
            for (int i = 0; i < filenames.length; i++) {
                sb.append("<id name=\"").append(filenames[i]).append("\" guid=\"").append(assetList.get(i).getLastRevision().getMaster().getFileID()).append("\">string</id>");
            }
        } else if (type.equalsIgnoreCase(("proxy"))) {
            for (int i = 0; i < filenames.length; i++) {
                Content file = assetList.get(i);
                String expectedFileId = null;
                for (FilePreview preview : file.getLastRevision().getPreview())
                    if (preview.getA5Type().equals("video_proxy")) {
                        expectedFileId = preview.getFileID();
                    }
                sb.append("<id name=\"").append(filenames[i].replace(".mov", "_preview.mov")).append("\" guid=\"").append(expectedFileId).append("\">string</id>");
            }
        } else if (type.equalsIgnoreCase(("master_proxy"))) {
            for (int i = 0; i < filenames.length; i++) {
                sb.append("<id name=\"").append(filenames[i]).append("\" guid=\"").append(assetList.get(i).getLastRevision().getMaster().getFileID()).append("\">string</id>");
            }
            for (int i = 0; i < filenames.length; i++) {
                Content file = assetList.get(i);
                String expectedFileId = null;
                for (FilePreview preview : file.getLastRevision().getPreview())
                    if (preview.getA5Type().equals("video_proxy")) {
                        expectedFileId = preview.getFileID();
                    }
                sb.append("<id name=\"").append(filenames[i].replace(".mov", "_preview.mov")).append("\" guid=\"").append(expectedFileId).append("\">string</id>");
            }
        }
        sb.append("</FileIDListWithName>");
        String xmlContentTosend = sb.toString();
        return xmlContentTosend;
    }

    public HttpResponse sendziprequest(StringEntity input, String body, String endpoint) throws IOException {
        DefaultHttpClient httpClient = new DefaultHttpClient();
        HttpPost postRequest = new HttpPost(endpoint);
        input = new StringEntity(body);
        input.setContentType("text/xml");
        postRequest.setEntity(input);
        HttpResponse response = httpClient.execute(postRequest);
        postRequest.releaseConnection();
        return response;
    }

    public HttpResponse sendziprequestwitJSONRequestBody(StringEntity input, String body, String endpoint) throws IOException {
        DefaultHttpClient httpClient = new DefaultHttpClient();
        HttpPost postRequest = new HttpPost(endpoint);
        input = new StringEntity(body);
        input.setContentType("application/json");
        postRequest.setEntity(input);
        HttpResponse response = httpClient.execute(postRequest);
        postRequest.releaseConnection();
        return response;
    }

    public String checkzipHeaders(HttpResponse response, String headerType) {
        String downloadedFileName = null;
        if (headerType.equalsIgnoreCase("Content-Disposition")) {
            org.apache.http.Header[] responseHeader = response.getHeaders(headerType);
            int index1 = responseHeader[0].toString().trim().indexOf("=");
            downloadedFileName = responseHeader[0].toString().trim().substring(index1 + 1).replaceAll("\"", "");

        }
        return downloadedFileName;
    }

    @When("{I |}'$type' media manager files '$filePath' from Library from collection '$collectionid' is downloaded as '$targetfilename'")
    @Then("{I |}'$type' media manager files '$filePath' from Library from collection '$collectionid' is downloaded as '$targetfilename'")
    public void downloadMediaManagerZipFrmLib(String type, String filePath, String collectionName, String targetfilename) throws IOException {
        ArrayList<Content> assetList = new ArrayList<Content>();
        String filenames[] = filePath.split(",");
        String collectionId = getCategoryId(wrapCollectionName(collectionName));
        for (int i = 0; i < filenames.length; i++) {
            Content asset = getCoreApi().getAssetByName(collectionId, new File(wrapVariableWithTestSession(filenames[i])).getName());
            assetList.add(asset);
        }
        HttpResponse response;
        StringEntity input = null;
        HttpPost postRequest;
        User user = getCoreApi().getCurrentUser();
        final String downloadLocation = TestsContext.getInstance().coreUrl[0]+"/asset/download/archive?with=permissions&%24id%24=id-" + user.getId() + "&%24originId%24=id-4ef31ce1766ec96769b399c0";
        String ziprequest = buildZipRequestForLibrary(type, assetList);
        response = sendziprequestwitJSONRequestBody(input, ziprequest, downloadLocation);
        String responseBody = EntityUtils.toString(response.getEntity());
        Assert.assertTrue(responseBody.contains(targetfilename));
    }
}

