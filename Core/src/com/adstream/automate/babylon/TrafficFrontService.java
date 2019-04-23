package com.adstream.automate.babylon;

import com.adstream.automate.babylon.JsonObjects.traffic.TrafficOrder;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import org.apache.http.client.methods.HttpGet;

import java.io.UnsupportedEncodingException;
import java.net.URL;

public class TrafficFrontService extends BabylonMessageSender implements TrafficService {

    public TrafficFrontService(URL url) {
        super(url);
        contentType = "application/json";
    }

    public String getVersion(){
        String address =  baseUrl + "traffic/version";
        String response = sendRequest(new HttpGet(address));
        JsonObject responseObj = new JsonParser().parse(response).getAsJsonObject();
        String version = responseObj.get("version").getAsString();
        return version;
    }

    public String getApiVersion(){throw new UnsupportedOperationException("Not implemented yet");}

    public String auth(String email, String password, URL coreUrl) {throw new UnsupportedOperationException("Not implemented yet");}

    public TrafficOrder getOrderItemByA4DeliveryId(String deliveryId){throw new UnsupportedOperationException("Not implemented yet");}

    public String setCommentTraffic(String orderId, String userId) throws UnsupportedEncodingException {
        throw new UnsupportedOperationException("Not implemented yet");}
}
