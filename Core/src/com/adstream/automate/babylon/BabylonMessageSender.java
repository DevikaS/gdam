package com.adstream.automate.babylon;

import com.adstream.automate.babylon.JsonObjects.gdn.HttpDeleteWithBody;
import com.adstream.automate.utils.Common;
import com.google.gson.*;
import org.apache.commons.io.IOUtils;
import org.apache.http.*;
import org.apache.http.client.CookieStore;
import org.apache.http.client.methods.*;
import org.apache.http.config.SocketConfig;
import org.apache.http.conn.ConnectionKeepAliveStrategy;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.NoConnectionReuseStrategy;
import org.apache.http.impl.client.BasicCookieStore;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.DefaultRedirectStrategy;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.impl.conn.PoolingHttpClientConnectionManager;
import org.apache.http.protocol.HttpContext;
import org.apache.http.util.EntityUtils;
import org.apache.log4j.Logger;
import org.joda.time.DateTime;
import org.joda.time.DateTimeZone;
import java.io.IOException;
import java.lang.reflect.Type;
import java.net.MalformedURLException;
import java.net.URI;
import java.net.URISyntaxException;
import java.net.URL;
import java.nio.charset.UnsupportedCharsetException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * User: ruslan.semerenko
 * Date: 02.04.12 13:47
 */
public abstract class BabylonMessageSender {
    private CookieStore cookieStore;
    private TrackingRedirectStrategy redirectStrategy;
    private CloseableHttpClient client;
    private boolean debug;
    private boolean forceHttp = false;
    public Gson gson;
    protected String baseUrl;
    protected String contentType;

    protected final static Logger log = Logger.getLogger(BabylonService.class);

    public BabylonMessageSender() {
        this(null);
    }

    public BabylonMessageSender(URL baseUrl) {
        client = createHttpClient(true);
        gson = createGson();
        debug = log.isDebugEnabled();
        if (baseUrl != null) {
            this.baseUrl = removePathFromUrl(baseUrl);
        }
    }

    public void setForceHttp(boolean forceHttp) {
        this.forceHttp = forceHttp;
    }

    private CloseableHttpClient createHttpClient(boolean useKeepAlive) {
        SocketConfig socketConfig = SocketConfig.custom().setSoTimeout(2 * 60 * 1000).build();
        PoolingHttpClientConnectionManager connectionManager = new PoolingHttpClientConnectionManager();
        connectionManager.setDefaultSocketConfig(socketConfig);
        HttpClientBuilder builder = HttpClientBuilder.create()
                .setUserAgent("HttpClient/4.3 A5 QA Automation")
                .setRedirectStrategy(redirectStrategy = new TrackingRedirectStrategy())
                .setConnectionManager(connectionManager)
                .setDefaultCookieStore(cookieStore = new BasicCookieStore())
                .setDefaultSocketConfig(socketConfig);


        if (!useKeepAlive) {
            builder.setConnectionReuseStrategy(new NoConnectionReuseStrategy());
            builder.setKeepAliveStrategy(new ConnectionKeepAliveStrategy() {
                @Override
                public long getKeepAliveDuration(HttpResponse response, HttpContext context) {
                    return -1;
                }
            });
        }
        return builder.build();
    }

    private Gson createGson() {
        return new GsonBuilder()
                .registerTypeAdapter(DateTime.class, new DateTypeAdapter())
                .create();
    }

    public String removePathFromUrl(URL baseUrl) {
        StringBuilder url = new StringBuilder();
        url.append(baseUrl.getProtocol()).append("://").append(baseUrl.getAuthority()).append("/");
        return url.toString();
    }

    protected URL getBaseUrl() {
        try {
            return new URL(baseUrl);
        } catch (MalformedURLException e) {
            log.error(Common.exceptionToString(e));
            return null;
        }
    }

    protected void clearCookies() {
        cookieStore.clear();
    }

    protected HttpPost createPost(String url, String body) {
        HttpPost post = new HttpPost(url);
        post.setEntity(createEntity(body));
        return post;
    }

    protected HttpDeleteWithBody createDelete(String url, String body) {
        HttpDeleteWithBody delete = new HttpDeleteWithBody(url);
        delete.setEntity(createEntity(body));
        return delete;
    }
    public static String createQueryString(Map<String, String> params) {
        StringBuilder query = new StringBuilder();
        for (Map.Entry<String, String> entry : params.entrySet()) {
            String key = Common.urlEncode(entry.getKey());
            String value = Common.urlEncode(entry.getValue());
            query.append(key).append("=").append(value).append("&");
        }
        return query.substring(0, query.length() - 1);
    }

    public HttpPut createPut(String url, String body) {
        HttpPut put = new HttpPut(url);
        put.setEntity(createEntity(body));
        return put;
    }

    public HttpPatch createPatch(String url, String body) {
        HttpPatch patch = new HttpPatch(url);
        patch.setEntity(createEntity(body));
        return patch;
    }

    private StringEntity createEntity(String body) {
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

    public <T> T sendRequest(HttpRequestBase request, Class<T> responseClass) {
        String responseBody = sendRequest(request);
        if (responseBody == null)
            return null;
        JsonObject responseObj = new JsonParser().parse(responseBody).getAsJsonObject();
        JsonElement data = responseObj.get("status");
        JsonArray jArray = new JsonArray();
        if(data != null) {
            if (data instanceof com.google.gson.JsonPrimitive) {
                responseObj.remove("status"); // Remove status if it comes as a JsonPrimitive instead of JsonArray NGN-18508
                jArray.add(data);
                responseObj.add("status", jArray);
            }
        }
        return gson.fromJson(responseObj.toString(), responseClass);
    }

    public <T> T sendRequest(HttpRequestBase request, Type responseType) {
        String responseBody = sendRequest(request);
        if (responseBody == null)
            return null;
        return gson.fromJson(responseBody, responseType);
    }

    protected String sendRequest(HttpRequestBase request) {
        try {
            return processRequest(request);
        } catch (IOException e) {
            log.error(Common.exceptionToString(e));
        }
        return null;
    }

    protected byte[] sendRequestRaw(HttpRequestBase request) {
        try {
            HttpEntity response = executeRequest(request);
            if (response == null)
                return null;
            if (debug) log.debug("[raw data]");
            byte[] bytes = EntityUtils.toByteArray(response);
            request.releaseConnection();
            return bytes;
        } catch (IOException e) {
            log.error(Common.exceptionToString(e));
        }
        return null;
    }

    protected URI getLastRedirectURI() {
        return redirectStrategy.getLastRedirectURI();
    }
    
    private String processRequest(HttpRequestBase request) throws IOException {
        HttpEntity response = executeRequest(request);
        if (response == null)
            return null;
        String responseBody = EntityUtils.toString(response);
        if (debug) log.debug(responseBody);
        request.releaseConnection();
        return responseBody;
    }

    private HttpEntity executeRequest(HttpRequestBase request) throws IOException {
        request = isCustomGA(request);
        if (debug) log.debug(getRequestInfoForDebug(request));
        if (forceHttp) {
            try {
                URI newUri = new URI(request.getURI().toString().replaceAll("^https", "http"));
                request.setURI(newUri);
            } catch (URISyntaxException e) {
                e.printStackTrace();
            }
        }
        HttpResponse response = client.execute(request);
        int statusCode = response.getStatusLine().getStatusCode();
        if (debug) log.debug("Response: " + statusCode);
        if (statusCode < 200 || statusCode >= 400) {
            String responseBody = EntityUtils.toString(response.getEntity());
            //if (!responseBody.contains("Already exists")) {
                StringBuilder errorCollector = new StringBuilder();
                if (!debug)
                    errorCollector.append(getRequestInfoForDebug(request));
                errorCollector.append("Response: ").append(statusCode).append(IOUtils.LINE_SEPARATOR).append(responseBody);
                log.error(errorCollector.toString());
            //} else {
                log.trace(responseBody);
            //}
            if (statusCode >= 500) {
                throw new TargetServerErrorException(statusCode + " " + responseBody);
            }
            return null;
        }
        return response.getEntity();
    }

    private HttpRequestBase isCustomGA(HttpRequestBase request){
        String url = request.getURI().toString();
        List<String> userIds = getCustomGlobalAdminUserIds();
        for(String id:userIds) {
            if(url.contains(id)){
                request.setHeader("X-TargetService", "Gdam");
                url = url.replace(TestsContext.getInstance().coreUrl[0].toString(),TestsContext.getInstance().gaCoreUrl[0].toString());
                request.setURI(URI.create(url));
                return request;
            }
        }
        return request;
    }

    private List<String> getCustomGlobalAdminUserIds(){
        List<String> userIds = new ArrayList<>();
        HttpGet get = new HttpGet(TestsContext.getInstance().coreUrl[0] + "/user/find?query=_private.cpe:56f3bf77ce8bdde34133e516&$id$=id-4ef31ce1766ec96769b399c0");
        try {
            HttpResponse response = client.execute(get);
            int statusCode = response.getStatusLine().getStatusCode();
            if (debug) log.debug("Response: " + statusCode);
            if (statusCode < 200 || statusCode >= 400) {
                String responseBody = EntityUtils.toString(response.getEntity());
                StringBuilder errorCollector = new StringBuilder();
                errorCollector.append("Response: ").append(statusCode).append(IOUtils.LINE_SEPARATOR).append(responseBody);
                log.error(errorCollector.toString());
                log.trace(responseBody);
                if (statusCode >= 500)
                    throw new TargetServerErrorException(statusCode + " " + responseBody);
                return null;
            }

            String responseBody = EntityUtils.toString(response.getEntity());
            JsonParser jsonParser = new JsonParser();
            JsonElement element1 = jsonParser.parse(responseBody).getAsJsonObject();
            JsonObject object1 = element1.getAsJsonObject();
            JsonArray array =object1.getAsJsonArray("list");

            for(int i=0;i<array.size();i++){
                JsonElement element=array.get(i);
                JsonObject object = element.getAsJsonObject();
                userIds.add(object.get("_id").toString().replace("\"",""));
            }
            return userIds;
        } catch (Exception e ){
            throw new Error("Failed to get new GlobalAdmin User Ids:"+e.getMessage());
        }
    }

    public Integer returnStatusCode(HttpRequestBase request) throws IOException {
        HttpResponse response = client.execute(request);
        int statusCode = response.getStatusLine().getStatusCode();
        request.releaseConnection();
        return statusCode;
    }

    private String getRequestInfoForDebug(HttpRequestBase request) {
        StringBuilder sb = new StringBuilder();
        try {
            sb.append("Request: ").append(request.getMethod()).append(" ").append(request.getURI());
            sb.append(IOUtils.LINE_SEPARATOR);
            if (request instanceof HttpEntityEnclosingRequestBase) {
                sb.append(EntityUtils.toString(((HttpEntityEnclosingRequestBase) request).getEntity()));
                sb.append(IOUtils.LINE_SEPARATOR);
            }
        } catch(IOException e) {
            log.error(Common.exceptionToString(e));
        }
        return sb.toString();
    }



    private class TrackingRedirectStrategy extends DefaultRedirectStrategy {
        private URI lastRedirectURI;

        @Override
        public HttpUriRequest getRedirect(HttpRequest request, HttpResponse response, HttpContext context) throws ProtocolException {
            HttpUriRequest uriRequest = super.getRedirect(request, response, context);
            lastRedirectURI = uriRequest.getURI();
            if (forceHttp) {
                if (uriRequest instanceof HttpRequestBase) {
                    try {
                        URI newUri = new URI((uriRequest.getURI().toString().replaceAll("^https", "http")));
                        ((HttpRequestBase) uriRequest).setURI(newUri);
                    } catch (URISyntaxException e) {
                        e.printStackTrace();
                    }
                }
            }
            return uriRequest;
        }

        public URI getLastRedirectURI() {
            return lastRedirectURI;
        }
    }

    private class DateTypeAdapter implements JsonSerializer<DateTime>, JsonDeserializer<DateTime> {
        @Override
        public JsonElement serialize(DateTime dateTime, Type type, JsonSerializationContext jsonSerializationContext) {
            return new JsonPrimitive(dateTime.toString());
        }

        @Override
        public DateTime deserialize(JsonElement jsonElement, Type type, JsonDeserializationContext jsonDeserializationContext) throws JsonParseException {
            return new DateTime(jsonElement.getAsJsonPrimitive().getAsString(), DateTimeZone.UTC);
        }
    }
}