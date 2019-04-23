package com.adstream.automate.babylon;

import com.adstream.automate.babylon.JsonObjects.ordering.Order;
import com.adstream.automate.babylon.JsonObjects.ordering.OrderItem;


import com.adstream.automate.utils.Common;
import com.publicApi.jsonPayLoads.GsonClasses.BaseOfBase;
import org.apache.http.HttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.client.methods.HttpPut;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.util.EntityUtils;

import com.google.gson.*;
import java.io.IOException;
import java.util.HashMap;


/**
 * Created by Saritha.Dhanala on 16/04/2018.
 */
public class PAPIServiceCalls extends BabylonMessageSender {

    String baseUrl = TestsContext.getInstance().applicationUrl + "/api/v2";
    CloseableHttpClient httpClient = HttpClientBuilder.create().build();

    public String createPAPIOrder(String market, String orderType, String key, String secret) {
        String id = null;
        HttpPost request  = new HttpPost( baseUrl+"/orders");
        request.addHeader("content-type", "application/json");
        request.addHeader("Authorization",generateAuthorizationCode(key, secret));
        try {
           StringEntity params = new StringEntity("{\n" +
                           "   \"meta\":{\n" +
                           "    \"" + orderType + "\":{\n" +
                           "     \"marketId\": [\"" + market + "\"]\n" +
                           "    }\n" +
                           "}}");
           request.setEntity(params);
           HttpResponse response = httpClient.execute(request);
           String jsonString = EntityUtils.toString(response.getEntity());
           id = new JsonParser().parse(jsonString).getAsJsonObject().getAsJsonPrimitive("id").getAsString();
       }catch(Exception e) {
       }
           return id;

    }

    public BaseOfBase createPAPIOrderItem(String orderId, OrderItem orderItem,String key, String secret){
        String url =  baseUrl+"/orders/"+orderId+"/items";
        JsonObject request = new JsonObject();
        request.add("meta", gson.toJsonTree(orderItem.getCm()));
        HttpPost post = createPost(url, request.toString());
        post.addHeader("content-type", "application/json");
        post.addHeader("Authorization",generateAuthorizationCode(key, secret));
        return sendRequest(post, BaseOfBase.class);
    }

    public void addDestinationPAPI(String orderId, String orderItemId, String destinationID, String key, String secret) {
        String url = baseUrl + "/orders/" + orderId + "/items/" + orderItemId + "/destinations";
        HttpPost request = new HttpPost(url);
        request.addHeader("content-type", "application/json");
        request.addHeader("Authorization", generateAuthorizationCode(key, secret));
        try {
            StringEntity params = new StringEntity("[{\n" +
                    "    \"id\":[\"" + destinationID + "\"],\n" +
                    "    \"serviceLevel\": {\n" +
                    "        \"id\": [\"2\"]\n" +
                    "    }\n" +
                    "}]");
            request.setEntity(params);
            httpClient.execute(request);
            Common.sleep(2000);
        } catch (Exception e) {
        }
    }

    public void processOrder(String orderId, String OrderItemId, String key, String secret){
        String url = baseUrl + "/orders/" + orderId + "/process";
        HttpPut request = new HttpPut(url);
        request.addHeader("content-type", "application/json");
        request.addHeader("Authorization", generateAuthorizationCode(key, secret));
        try {
            StringEntity params = new StringEntity("{\n" +
                    "    \"library\":[\"" + OrderItemId + "\"]\n" +
                    "}");
            request.setEntity(params);
            httpClient.execute(request);
        } catch (Exception e) {
        }
    }


    public String generateAuthorizationCode(String key, String secret){
        String jsonString = null;
        try {
            String generateTokenURL = TestsContext.getInstance().applicationUrl.toString() + "/api/v2/auth/token?" +
                    "key="+key+"&secret="+secret;
            HttpGet r = new HttpGet(generateTokenURL);
            HttpResponse response = httpClient.execute(r);
            jsonString = EntityUtils.toString(response.getEntity());
        } catch (IOException e) {
            System.out.println(e.getCause());
        }

        return jsonString.split("\",\"hash\":\"")[1].split("\"}")[0];

    }

}
