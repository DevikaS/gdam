package com.adstream.automate.babylon.scripts.pg;

import com.adstream.automate.babylon.BabylonServiceWrapper;
import com.adstream.automate.babylon.JsonObjects.Content;
import com.adstream.automate.babylon.middleware.BabylonMiddlewareService;
import com.google.gson.*;
import com.google.gson.internal.bind.DateTypeAdapter;
import com.google.gson.reflect.TypeToken;
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
import org.apache.log4j.PropertyConfigurator;

import java.io.*;
import java.lang.reflect.Type;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.*;

/**
 * Created with IntelliJ IDEA.
 * User: solomin-y
 * Date: 9/5/14
 * Time: 7:57 AM

 */
public class DeletePGAssets {

    private static final Logger log = Logger.getLogger(DeletePGAssets.class);
    private static BabylonServiceWrapper service;
    private static final String APPLICATION_URL = "http://preproda5.adstream.com";
    private static final String ELASTIC_SEARCH_URL = "http://10.64.161.10:9200";
    private static final String LOGIN = "AgencyGUID_68bbe2c4-2736-474d-86a2-02ad858390ea_migrate_user@adbank.me";
    private static final String PASSWORD = "Adstream01";
    private static final String agencyName = "P&G Global Library";

    protected Gson gson;
    protected int responseCode;
    protected String statusLine;
    protected String redirectUrl;
    protected HttpResponse response;

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


    public DeletePGAssets() throws MalformedURLException {
        setUpLogger();
        service = new BabylonServiceWrapper(new BabylonMiddlewareService(new URL(APPLICATION_URL)));
        log.info("Log in as " + LOGIN);
        service.logIn(LOGIN, PASSWORD);

    }

    public static void main(String[] args) throws MalformedURLException {
        new DeletePGAssets().deleteAllAssetsUseA4FromFile();
    }

    public void deleteAllAssetsUseA4FromFile() {
        String sourceFile = "scripts/src/main/resources/a4Ids.txt";
        List<String> a4IDs = readTextFile(System.getProperty("user.dir").concat("\\").concat(sourceFile));
        log.info("There are " + a4IDs.size() + " assets must be deleted");
        int emptyCount= 0;
        int notEmpty= 0;
        int error= 0;
        long startTime = System.currentTimeMillis();

        for (String a4id: a4IDs) {
            try {
                String a5Id = getA5Id(a4id.toLowerCase());

                if (a5Id.isEmpty()) {
                    log.warn("For A4GUID = " + a4id.toLowerCase() + " there isn't asset in the A5. There are " + ++emptyCount + " same assets");
                }
                else {
                    service.deleteAsset(a5Id);
                    log.info("Asset with A4GUID = " + a4id.toLowerCase() + " was deleted. There are " + ++ notEmpty + " deleted assets");
                }
            }
            catch (Throwable t) {
                log.error("There are some problems with delete assets. A4GUID = " + a4id.toLowerCase() + ++ error + " exception was through");
            }
        }
        log.info("Done! There are " + notEmpty + " was deleted\n There are " + emptyCount + " wasn't founded in the A5\n There are " + error + " had got exceptions") ;
        log.info("Script worked " + (System.currentTimeMillis() - startTime)/1000 + " sec.");
    }

    public static List<String> readTextFile(String fileName) {
        List<String> result = new LinkedList<>();
        try {
            BufferedReader in = new BufferedReader(new FileReader( new File(fileName).getAbsoluteFile()));
            try {
                String s;
                while ((s = in.readLine()) != null) {
                    result.add(s.trim());
                }
            } finally {
                in.close();
            }
        } catch(IOException e) {
            throw new RuntimeException(e);
        }
        return result;
    }

    public String getA5Id(String a4Id) {
        String requestBody = String.format("{\"query\":{\"bool\":{\"must\":[{\"term\":{\"_private.a4.id\":\"%s\"}}],\"must_not\":[{\"term\":{\"_deleted\":\"true\"}}]}},\"from\":0,\"size\":50}", a4Id);
        HttpPost post = createPost(ELASTIC_SEARCH_URL.concat("/asset/_search"), requestBody);
        Type returnType = new TypeToken<ElasticSearchResult>() {
        }.getType();                                              //
        //new JsonParser().parse(responseBody).getAsJsonObject().getAsJsonObject("hits").getAsJsonArray("hits").get(1).getAsJsonObject().get("_source").getAsJsonObject().get("agency").getAsJsonObject().get("name").getAsString()
        String responseBody = sendRequest(post);
        JsonArray jsonArray = new JsonParser().parse(responseBody).getAsJsonObject().getAsJsonObject("hits").getAsJsonArray("hits");
        if (jsonArray.size() == 1)
            return new JsonParser().parse(responseBody).getAsJsonObject().getAsJsonObject("hits").getAsJsonArray("hits").get(0).getAsJsonObject().get("_id").getAsString();
        else {
            for (JsonElement jsonElement: jsonArray) {
                if (agencyName.equals(jsonElement.getAsJsonObject().get("_source").getAsJsonObject().get("agency").getAsJsonObject().get("name").getAsString()))
                    return jsonElement.getAsJsonObject().get("_id").getAsString();
            }
        }
        return "";
    }

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
        entity = new StringEntity(body, "UTF-8");
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

    private void setUpLogger() {
        Properties properties = new Properties();
        properties.setProperty("log4j.rootLogger", "INFO,console");
        properties.setProperty("log4j.appender.console", "org.apache.log4j.ConsoleAppender");
        properties.setProperty("log4j.appender.console.layout", "org.apache.log4j.PatternLayout");
        properties.setProperty("log4j.appender.console.layout.ConversionPattern", "%d %-5p %t %c{1} %m%n");
        properties.setProperty("log4j.logger.com.adstream.automate.babylon.BabylonService", "INFO");
        PropertyConfigurator.configure(properties);
    }

}
