package com.adstream.automate.babylon;

import com.adstream.automate.babylon.JsonObjects.gdn.HttpDeleteWithBody;
import com.adstream.automate.babylon.JsonObjects.traffic.TrafficOrder;
import com.adstream.automate.babylon.core.BabylonCoreService;
import com.adstream.automate.utils.DateTimeUtils;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPatch;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.client.methods.HttpPut;

import java.io.UnsupportedEncodingException;
import java.net.URL;
import java.net.URLEncoder;
import java.util.Date;
import java.util.Map;

/**
 * Created by denysb on 23/06/2016.
 */
public class TrafficCoreService extends BabylonMessageSender implements TrafficService {

    private String authId;
    private BabylonCoreService core;

    public TrafficCoreService(URL url) {
        this(url, null);
    }

    public TrafficCoreService(URL url, String userId) {
        super(url);
        contentType = "application/json";
        authId = "id-" + userId;
    }

    public String getVersion(){
        String address =  baseUrl + "/version";
        String response = sendRequest(new HttpGet(address));
        JsonObject responseObj = new JsonParser().parse(response).getAsJsonObject();
        String version = responseObj.get("buildVersion").getAsString();
        return version;
    }

    public String getApiVersion(){
        String address =  baseUrl + "/api/info";
        String response = sendRequest(new HttpGet(address));
        JsonObject responseObj = new JsonParser().parse(response).getAsJsonObject();
        String version = responseObj.get("ApiVersion").getAsString();
        return version;
    }

    public String auth(String email, String password, URL coreUrl) {
        core = new BabylonCoreService(coreUrl);
        authId = core.auth(email,password);
        return core.auth(email,password);
    }

    public TrafficOrder getOrderItemByA4DeliveryId(String deliveryId){
        String address = baseUrl + "api/traffic/v1/orderitem/a4-delivery-id/" + deliveryId;
        HttpGet get = new HttpGet(address);
        get.addHeader("X-User-Id",authId.replace("id-",""));
        return sendRequest(get, TrafficOrder.class);
    }


    @Override
    public String setCommentTraffic(String orderId, String userId) throws UnsupportedEncodingException {
        String body = "{\"comment\":\"Auto test to verify comment on ingestdoc\",\"items\":{\"" + orderId + "\":\"" + orderId + "\"}}\"";
        HttpPost post = createPost(baseUrl + "api/traffic/v1/comments", body);
        post.addHeader("X-User-Id", userId);
        post.addHeader("Content-Type", "application/json");
        return sendRequest(post);
    }

}
