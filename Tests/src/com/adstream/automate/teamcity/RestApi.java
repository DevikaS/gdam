package com.adstream.automate.teamcity;

import org.apache.commons.codec.binary.Base64;
import org.apache.commons.lang.StringEscapeUtils;
import org.apache.http.Header;
import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.client.methods.HttpRequestBase;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.message.BasicHeader;
import org.apache.http.util.EntityUtils;
import org.apache.log4j.Logger;
import org.w3c.dom.Document;
import org.w3c.dom.NodeList;
import org.w3c.dom.Node;
import org.w3c.dom.Element;
import org.xml.sax.InputSource;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import java.io.IOException;
import java.io.StringReader;
import java.nio.charset.UnsupportedCharsetException;
import java.text.MessageFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created with IntelliJ IDEA.
 * User: savitskiy-a
 * Date: 16.08.12
 * Time: 16:43
 */
public class RestApi {
    /*
    http://service1:123@shadow/httpAuth/app/rest/buildTypes/id:bt457/builds/?locator=running:true
    <builds count="1">
    <build id="53340" number="1.0.0.168" running="true" percentageComplete="16" status="FAILURE" buildTypeId="bt457" startDate="20120816T161648+0300" href="/httpAuth/app/rest/builds/id:53340" webUrl="http://shadow/viewLog.html?buildId=53340&buildTypeId=bt457"/>
    </builds>
     */
    /*
    webServerUrl =   http://service1:123@shadow
    buildTypeId =  bt457
     */
    private final HttpClient httpClient;
    private final String webServerUrl;
    private final String buildTypeId;

    protected final static Logger log = Logger.getLogger(RestApi.class);

    public RestApi(String webServerUrl) {
        this.httpClient = HttpClients.createDefault();
        this.webServerUrl = webServerUrl;
        this.buildTypeId = System.getProperty("teamcity.buildType.id", "");
    }

    private Header getTemacityUserAuthHeader() {
        String userId = System.getProperty("teamcity.auth.userId", "");
        String userPassword = System.getProperty("teamcity.auth.password", "");
        String auth = new String(Base64.encodeBase64((userId + ":" + userPassword).getBytes()));
        return new BasicHeader("Authorization","Basic " + auth);
    }

    private Header getUserAuthHeader() {
        String userId = "service1";
        String userPassword = "123";
        String auth = new String(Base64.encodeBase64((userId + ":" + userPassword).getBytes()));
        return new BasicHeader("Authorization","Basic " + auth);
    }

    public String getRunningBuildId() {
        return System.getProperty("teamcity.agent.dotnet.build_id","");
    }

    private String sendRequest(HttpRequestBase request) {
        String result = "";
        HttpResponse response = null;
        log.info(request.toString());
        try {
            response = httpClient.execute(request);
        } catch (IOException e) {
            log.error(e);
        }
        if (response != null && response.getEntity() != null) {
            try {
                result = EntityUtils.toString(response.getEntity());
            } catch (IOException e) {
                log.error(e);
            }
        }
        log.info(result);
        return result;
    }

    //http://shadow/httpAuth/app/rest/builds/53227/tags
    public void setBuildTag(String buildTag) {
        HttpPost post = new HttpPost(webServerUrl + "/httpAuth/app/rest/builds/" + getRunningBuildId() + "/tags");
        post.setEntity(createEntity(buildTag, "text/plain"));
        post.setHeader(getUserAuthHeader());
        sendRequest(post);
    }

    private StringEntity createEntity(String body, String contentType) {
        StringEntity entity;
        try {
            entity = new StringEntity(body, "UTF-8");
        } catch (UnsupportedCharsetException e) {
            log.error(e);
            return null;
        }
        entity.setContentType(contentType);
        return entity;
    }

    //http://shadow/app/rest/testOccurrences?locator=currentlyMuted:true,build:(buildType:Gdam_Qa_GdamUiTests2670fullRegressionSuite)
    public Map<String, List<String>> getMutedTests() {
        StringBuilder fullUrl = new StringBuilder(webServerUrl)
                .append("/httpAuth/app/rest/testOccurrences?locator=")
                .append("currentlyMuted:true")
                .append(String.format(",build:(buildType:%s)", buildTypeId))
                .append(",count:10000");

        HttpGet get = new HttpGet(fullUrl.toString());
        get.setHeader(getUserAuthHeader());
        String resultXml = sendRequest(get);
        return parseTestOccurrencesResult(resultXml);
    }

    private Map<String, List<String>> parseTestOccurrencesResult(String resultXml) {
        final String DELIMETER = ": ";
        Map<String, List<String>> suits = new HashMap<String, List<String>>();
        DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
        //<testOccurrence id="id:116568,build:(id:132282)" name="Project List: Filtering by media type in Project list0" status="FAILURE" duration="13471" currentlyMuted="true" currentlyInvestigated="true" href="/app/rest/testOccurrences/id:116568,build:(id:132282)"/>s
        try {
            DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
            Document doc = dBuilder.parse(new InputSource(new StringReader(resultXml)));
            doc.getDocumentElement().normalize();
            NodeList nList = doc.getElementsByTagName("testOccurrence");

            for (int i = 0; i < nList.getLength(); i++) {
                Node nNode = nList.item(i);
                if (nNode.getNodeType() == Node.ELEMENT_NODE) {
                    Element eElement = (Element) nNode;
                    String rawTestName = eElement.getAttribute("name");
                    int indexOfStoryDelimeter = rawTestName.indexOf(DELIMETER);
                    String suitName = rawTestName.substring(0, indexOfStoryDelimeter);
                    if (!suits.containsKey(suitName)) {
                        suits.put(suitName, new ArrayList<String>());
                    }
                    //trim digits in the end
                    suits.get(suitName).add(rawTestName.substring(indexOfStoryDelimeter + DELIMETER.length()).replaceAll("\\d+$", ""));
                }
            }
        } catch (Exception e) {
            log.error(e);
        }
        return suits;
    }
}
