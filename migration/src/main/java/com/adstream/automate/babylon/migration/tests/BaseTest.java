package com.adstream.automate.babylon.migration.tests;

import com.adstream.automate.babylon.BabylonServiceWrapper;
import com.adstream.automate.babylon.core.BabylonCoreService;
import com.adstream.automate.babylon.migration.TestContext;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.google.gson.*;
import com.google.gson.internal.bind.DateTypeAdapter;
import com.google.gson.reflect.TypeToken;
import com.mongodb.ReadPreference;
import org.apache.commons.lang.StringUtils;
import org.apache.http.Header;
import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.config.RequestConfig;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.client.methods.HttpRequestBase;
import org.apache.http.conn.ConnectionKeepAliveStrategy;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.NoConnectionReuseStrategy;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.protocol.HttpContext;
import org.apache.http.util.EntityUtils;
import org.apache.log4j.Logger;
import org.testng.ITestContext;
import org.testng.annotations.Listeners;
import com.mongodb.DB;
import com.mongodb.MongoClient;
import com.adstream.automate.babylon.migration.utils.XMLParser;


import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.lang.reflect.Type;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.UnknownHostException;
import java.util.*;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;
import com.adstream.automate.babylon.migration.json.*;
import org.testng.annotations.Optional;
import org.testng.annotations.Parameters;

/**
 * Created with IntelliJ IDEA.
 * User: solomin-y
 * Date: 10/9/13
 * Time: 7:10 PM

 */

public class BaseTest {

    private static String elasticURL = "http://10.0.25.34:9200";

    protected static String otherAgencyEmail = "admin.beaumont.tiles.rj.beaumont.co.p.l@adbank.me";
    protected static String otherAgencyPassword = "Adstream01";

    protected static String globalLogin = "admin";
    protected static String globalPassword = "abcdefghA1";


    private static BabylonServiceWrapper service;
    private static BabylonCoreService core;
    protected final static Logger log = Logger.getLogger(BaseTest.class);
    private static MongoClient mongoClient;
    private static DB mongoDB;
    private static Lock webDriverLock = new ReentrantLock();
    private ExtendedWebDriver webDriver;
    //private WebDriver webDriver;
    private ExtendedWebDriver.Browser siteBrowser;
    private String tempFolder;
    private final boolean enableHARFileSupport = false;
    private Map<String, Object> browserCapabilityMap;
    protected Gson gson;
    protected int responseCode;
    protected String statusLine;
    protected String redirectUrl;
    protected HttpResponse response;
    //protected static String ftp = "ftp://mongo-admin:ooquooX4Tha@ftp.adstream.com/";
    protected static String ftp = "";
    protected static String[][] xmlSourceArray = new String[][] {
            // {"", "1", "Agency Name", "Fake User Email", "Fake User Password", "a4 user email", "Jira ticket", "ENV"},
            //
            //{"[UPDATED XML OUTPUT] 2015-3-11T15-04-21_Bitch Productions_0000.xml", "2", "Bitch Productions", "migration.user.bitch.productions@adbank.me", "", "bitchprod.a5del@adbank.me",  "MIG-491", "Test Env"},
            {"2015-3-27T16-23-00_Lemmen Productions BV_0000.xml", "2", "Lemmen Productions", "admin.lemmen.productions@adbank.me", "", "",  "MIG-525", "LIVE"},

    };

    public static String getFtp() {
        return "ftp://" + getContext().ftpLogin + ":" + getContext().ftpPassword + "@" + getContext().ftpPath + "/";
    }

    private final RequestConfig requestConfig = RequestConfig.custom()
            .setConnectionRequestTimeout(30000)
            .setConnectTimeout(30000)
            .setSocketTimeout(30000)
            .build();
    CloseableHttpClient client = HttpClients.custom().setDefaultRequestConfig(requestConfig)
            .setConnectionReuseStrategy(new NoConnectionReuseStrategy())
            .setKeepAliveStrategy(new ConnectionKeepAliveStrategy() {
                @Override
                public long getKeepAliveDuration(HttpResponse response, HttpContext context) {
                    return -1;
                }
            })
            .build();

    public BaseTest() {
        try {
            service = new BabylonServiceWrapper(new BabylonCoreService(new URL(getContext().appUrl)), null);
            core = new BabylonCoreService(new URL(getContext().appUrl));
        } catch (MalformedURLException e) {
            service = null;
            e.printStackTrace();
        }
    }

    public static BabylonServiceWrapper getService() {
        if (service == null) {
            try {
                service = new BabylonServiceWrapper(new BabylonCoreService(new URL(getContext().appUrl)), null);
            } catch (MalformedURLException e) {
                e.printStackTrace();
                service = null;
            }
        }
        return service;

    }

    public static BabylonCoreService getCore() {
        if (core == null) {
            try {
                core = new BabylonCoreService(new URL(getContext().appUrl));
            } catch (MalformedURLException e) {
                e.printStackTrace();
                core = null;
            }
        }
        return core;
    }

    protected static MongoClient getMongoClient() {
        if (mongoClient == null) {
            try {
                //mongoClient = new MongoClient("10.0.25.32", 27017);
                //mongoClient = new MongoClient("10.0.25.34", 27017);
                //mongoClient = new MongoClient("10.0.26.74", 27017);
                //mongoClient = new MongoClient("10.64.160.12", 27017);
                mongoClient = new MongoClient(getContext().mongoUrl, 27017);
                //mongoClient = new MongoClient("10.0.26.75", 27017);
                //mongoClient = new MongoClient("10.0.26.25", 27017);
                //mongoClient = new MongoClient("10.0.26.74", 27017);
                //mongoClient = new MongoClient("10.0.26.75", 27017);
                //mongoClient = new MongoClient("10.0.26.16", 27017);
                //mongoClient = new MongoClient("10.0.26.56", 27017);
            } catch (UnknownHostException e) {
                log.error(e);
            }
        }
        return mongoClient;
    }


    public static DB getMongoDB() {
        if (mongoDB == null) {
            mongoDB = getMongoClient().getDB("gdam");
            ReadPreference preference = ReadPreference.secondaryPreferred();
            mongoDB.setReadPreference(preference);
        }
        return mongoDB;
    }


    public ExtendedWebDriver getWebDriver() {
        if (webDriver == null) {
            webDriverLock.lock();
            try {
                webDriver = new ExtendedWebDriver(ExtendedWebDriver.Browser.getByValue("firefox"), new File("test-temp"), false);
            } finally {
                webDriverLock.unlock();
            }
        }
        return webDriver;

    }


    public String getA5Id(String a4Id) {
        FinalCondition finalCondition = new FinalCondition();
        FinalCondition finalCondition2 = new FinalCondition();
        List<Map<String, FinalCondition>> finalConditionList = new ArrayList<>();
        List<Map<String, FinalCondition>> finalConditionList2 = new ArrayList<>();
        Map<String, FinalCondition> stringListMap = new HashMap<>();
        Map<String, FinalCondition> stringListMap2 = new HashMap<>();
        Condition condition = new Condition();
        Condition condition2 = new Condition();
        LevelUp levelUp = new LevelUp();
        UpperLevel upperLevel = new UpperLevel();
        stringListMap.put("term", finalCondition);

        //finalCondition.setDefault_field("asset._private.a4.id");
        finalCondition.setQuery(a4Id);


        finalCondition2.setAsset_deleted("true");

        stringListMap.put("term", finalCondition);
        stringListMap2.put("term", finalCondition2);
        finalConditionList.add(stringListMap);
        finalConditionList2.add(stringListMap2);
        condition.setMust(finalConditionList);
        condition.setMust_not(finalConditionList2);
        levelUp.setBool(condition);
        upperLevel.setQuery(levelUp);
        upperLevel.setFrom(0);
        upperLevel.setSize(50);
        HttpPost post = createPost(elasticURL.concat("/asset/_search"), createGson().toJsonTree(upperLevel).toString());
        Type returnType = new TypeToken<ElasticSearchResult>() {
        }.getType();                                              //
        //new JsonParser().parse(responseBody).getAsJsonObject().getAsJsonObject("hits").getAsJsonArray("hits").get(1).getAsJsonObject().get("_source").getAsJsonObject().get("agency").getAsJsonObject().get("name").getAsString()
        String responseBody = sendRequest(post);
        JsonArray jsonArray = new JsonParser().parse(responseBody).getAsJsonObject().getAsJsonObject("hits").getAsJsonArray("hits");
        if (jsonArray.size() == 1)
            return new JsonParser().parse(responseBody).getAsJsonObject().getAsJsonObject("hits").getAsJsonArray("hits").get(0).getAsJsonObject().get("_id").getAsString();
        else {

            for (JsonElement jsonElement: jsonArray) {
                //if (XMLParser.getFirstDeptAdminFromCurrentXML().getAgencyName().equals(jsonElement.getAsJsonObject().get("_source").getAsJsonObject().get("agency").getAsJsonObject().get("name").getAsString()))
                if ("BETC - RITA Production".equals(jsonElement.getAsJsonObject().get("_source").getAsJsonObject().get("agency").getAsJsonObject().get("name").getAsString()))
                    return jsonElement.getAsJsonObject().get("_id").getAsString();
            }
        }
        return "";
    }

    protected String getA4IdByA5Id(String a5Id) {
        String query = String.format("{\"query\":{\"bool\":{\"must\":[{\"term\":{\"asset._id\":\"%s\"}}],\"must_not\":[],\"should\":[]}},\"from\":0,\"size\":10,\"sort\":[],\"facets\":{}}}", a5Id);
        HttpPost post = createPost("http://10.64.161.10:9200/asset/_search", query);
        String responseBody = sendRequest(post);
        return new JsonParser().parse(responseBody).getAsJsonObject().getAsJsonObject("hits").getAsJsonArray("hits").get(0).getAsJsonObject().get("_source").getAsJsonObject().get("_private").getAsJsonObject().get("a4").getAsJsonObject().get("id").getAsString();
    }
    //  _id="53b6a5dee4b00805847afe22"
    protected String sendRequest(HttpRequestBase request) {
        return executeRequest(request);
    }

    protected <T> T sendRequest(HttpRequestBase request, Type responseType) {
        String responseBody = sendRequest(request);
        if (responseBody == null)
            return null;
        return gson.fromJson(responseBody, responseType);
    }

    private String executeRequest(HttpRequestBase request) {
        //log.debug(getRequestInfoForDebug(request));
        try {
            response = client.execute(request);
        } catch (IOException e) {
            e.printStackTrace();  //To change body of catch statement use File | Settings | File Templates.
        }

        int statusCode = response.getStatusLine().getStatusCode();
        responseCode = statusCode;
        statusLine = response.getStatusLine().getReasonPhrase();
        String responseBody = null;
        try {
            if (response.getEntity() != null) {
                responseBody = EntityUtils.toString(response.getEntity());
            }
            else {
                responseBody = response.toString();
            }

        } catch (IOException e) {
            throw new Error(e);
        }
        String loggerMessage = "Response code: " + statusCode + "\nStatusLine: " + statusLine + "\nResponce body: " + StringUtils.trim(responseBody);
        if (statusCode < 200 || statusCode >= 400) {
            if (statusCode != 401 && statusCode!=477) {
                log.error(loggerMessage);
                throw new Error("Failed to execute request, message is " + statusLine);
            }
            else {
                log.warn("Found 401 Unauthorized");
                log.debug(loggerMessage);
            }
        } else {
            log.debug(loggerMessage);
            if (statusCode == 302) {
                for (Header header: response.getHeaders("Location")) {
                    redirectUrl = header.getValue();
                }
            }
        }
        return responseBody;
    }

    protected HttpPost createPost(String url, String body) {
        HttpPost post = new HttpPost(url);
        post.setEntity(createEntity(body));
        return post;
    }

    private HttpEntity createEntity(String body) {
        StringEntity entity;
        try {
            entity = new StringEntity(body, "UTF-8");
        } catch (Throwable e) {
            log.error(e);
            return null;
        }
        entity.setContentType("");
        return entity;
    }

    private Gson createGson() {
        return new GsonBuilder()
                .registerTypeAdapter(Date.class, new DateTypeAdapter())
                .setDateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'")
                .setPrettyPrinting()
                .create();
    }

    @Parameters("testConfig")
    protected void TemplateForCLITests(@Optional String testConfig, ITestContext c) {
        if (testConfig != null) {
            File testConfigFile = new File(testConfig);
            if (testConfigFile.exists()) {
                getContext().loadConfig(testConfigFile);
            } else {
                log.warn("Can not find config " + testConfig);
            }
        }
        log.info("Running test with following settings: " + getContext());

        File current_directory = new File(System.getProperty("user.dir"));
        log.info("Working dir: " + current_directory);

    }

    public static TestContext getContext() {
        return TestContext.getInstance();
    }


    /*public WebDriver getWebDriver() {
        if (webDriver == null) {
            webDriver = new FirefoxDriver();
            webDriver.manage().timeouts().implicitlyWait(30, TimeUnit.SECONDS);
        }
        return webDriver;
    } */

}

