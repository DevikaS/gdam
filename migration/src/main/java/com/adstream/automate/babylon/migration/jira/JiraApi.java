package com.adstream.automate.babylon.migration.jira;

import com.adstream.automate.utils.Common;
import com.atlassian.jira.rest.client.IssueRestClient;
import com.atlassian.jira.rest.client.JiraRestClient;
import com.atlassian.jira.rest.client.JiraRestClientFactory;
import com.atlassian.jira.rest.client.domain.Attachment;
import com.atlassian.jira.rest.client.domain.Comment;
import com.atlassian.jira.rest.client.domain.Issue;
import com.atlassian.jira.rest.client.internal.async.AsynchronousJiraRestClientFactory;
import com.atlassian.util.concurrent.Promise;
import org.apache.http.HttpEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.mime.MultipartEntityBuilder;
import org.apache.http.entity.mime.content.FileBody;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;

import java.io.*;
import java.net.URI;
import java.net.URISyntaxException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: solomin-y
 * Date: 3/12/15
 * Time: 10:20 AM

 */
public class JiraApi {

    private static final String JIRA_URL = "https://jira.adstream.com";
    private static final String JIRA_ADMIN_USERNAME = "yuriy.solomin";
    private static final String JIRA_ADMIN_PASSWORD = "bfubhfwww123";

    public static void main(String[] args) throws IOException {
        //getAttachmentFromIssue("https://jira.adstream.com/secure/attachment/72264/%5BUPDATED%20XML%20OUTPUT%5D%202015-3-10T13-06-11_CFS%20Krug%20GmbH%20Commercial%20Film%20Service%20i.G_0000.xml", "./Butch/xxx.xml");
        //addAttachmentToIssue("MIG-491", "./Butch/xxx.xml");
        //Ups("pröhl videoproduktion");
        List<String> aaa = getListOfAttachmentsURLs("MIG-504");
        for (String url: aaa) {
            getAttachmentFromIssue(url, String.format("./Jira/%s", Common.urlDecode(url.split("/")[url.split("/").length-1])));
            //getAttachmentFromIssue(url, String.format("./Jira/%s", url.split("/")[url.split("/").length-1]));
        }
    }

    public static void Ups(String str) throws IOException{
        BufferedReader br = new BufferedReader(
                new InputStreamReader(
                        new FileInputStream("./Jira/aaa.txt")));
        BufferedWriter bw = new BufferedWriter(
                new OutputStreamWriter(
                        new FileOutputStream(str), "UTF-8"));

        char[] buf = new char[512];
        int read;
        while ((read = br.read(buf)) > 0)
            bw.write(buf, 0, read);
        bw.toString();
        br.close(); bw.close();
        System.out.println("The job's finished.");
    }

    public static JiraRestClient getJiraRestClient() {
        JiraRestClientFactory factory = new AsynchronousJiraRestClientFactory();
        URI uri = null;
        try {
            uri = new URI(JIRA_URL);
        } catch (URISyntaxException e) {
            e.printStackTrace();
            return null;
        }
        JiraRestClient client = factory.createWithBasicHttpAuthentication(uri, JIRA_ADMIN_USERNAME, JIRA_ADMIN_PASSWORD);
        return client;
    }

    public static boolean addComment(String issueKey, String commentBody) {
        IssueRestClient issueClient = null;
        Promise<Issue> promiseIssue = getJiraRestClient().getIssueClient().getIssue(issueKey);
        Issue issue = promiseIssue.claim();
        URI issueURI = null;
        try {
            issueURI = new URI(issue.getSelf().toString() + "/comment/");
        } catch (URISyntaxException e) {
            e.printStackTrace();
            return false;
        }
        Comment jiraComment = Comment.valueOf(commentBody);
        Promise<Void> promise = getJiraRestClient().getIssueClient().addComment(issueURI, jiraComment);
        promise.claim();
        return true;
    }

    public static boolean addComment(String issueKey, StringBuffer commentBody) {
        return addComment(issueKey, commentBody.toString());
    }

    public static List<String> getListOfAttachmentsURLs(String issueKey) {
        Promise<Issue> promiseIssue = getJiraRestClient().getIssueClient().getIssue(issueKey);
        Issue issue = promiseIssue.claim();
        Iterator<Attachment> iterator = issue.getAttachments().iterator();
        List<String> result = new ArrayList<>();
        while (iterator.hasNext()) {
            Attachment attachment = iterator.next();
            result.add(attachment.getContentUri().getScheme() +":" + attachment.getContentUri().getRawSchemeSpecificPart());

        }
        return result;
    }


    public static boolean addAttachmentToIssue(String issueKey, String fullfilename) throws IOException{

        CloseableHttpClient httpclient = HttpClients.createDefault();
        String auth = new String(org.apache.commons.codec.binary.Base64.encodeBase64((JIRA_ADMIN_USERNAME+":"+JIRA_ADMIN_PASSWORD).getBytes()));
        HttpPost httppost = new HttpPost(JIRA_ADMIN_USERNAME+"/api/latest/issue/"+issueKey+"/attachments");
        httppost.setHeader("X-Atlassian-Token", "nocheck");
        httppost.setHeader("Authorization", "Basic "+auth);

        File fileToUpload = new File(fullfilename);
        FileBody fileBody = new FileBody(fileToUpload);

        HttpEntity entity = MultipartEntityBuilder.create()
                .addPart("file", fileBody)
                .build();

        httppost.setEntity(entity);
        String mess = "executing request " + httppost.getRequestLine();


        CloseableHttpResponse response;

        try {
            response = httpclient.execute(httppost);
        } finally {
            httpclient.close();
        }

        if(response.getStatusLine().getStatusCode() == 200)
            return true;
        else
            return false;

    }

    public static boolean getAttachmentFromIssue(String contentURI, String fullfilename) throws IOException{

        CloseableHttpClient httpclient = HttpClients.createDefault();
        String auth = new String(org.apache.commons.codec.binary.Base64.encodeBase64((JIRA_ADMIN_USERNAME+":"+JIRA_ADMIN_PASSWORD).getBytes()));
        try {


            HttpGet httpget = new HttpGet(contentURI);
            httpget.setHeader("Authorization", "Basic " + auth);

            System.out.println("executing request " + httpget.getURI());

            CloseableHttpResponse response = httpclient.execute(httpget);

            int status = response.getStatusLine().getStatusCode();
            if (status >=200 && status < 300) {
                HttpEntity entity = response.getEntity();
                if (entity.isStreaming()) {
                    byte data[] = EntityUtils.toByteArray(entity);
                    FileOutputStream fout = new FileOutputStream(new File(fullfilename));
                    fout.write(data);
                    fout.close();
                }
            }
        } finally {
            httpclient.close();
        }

        return true;
    }

}
