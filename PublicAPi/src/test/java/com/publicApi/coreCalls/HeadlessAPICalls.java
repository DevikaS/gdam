package com.publicApi.coreCalls;

import com.google.gson.reflect.TypeToken;
import com.publicApi.jsonPayLoads.*;
import com.publicApi.jsonPayLoads.GsonClasses.BaseOfBase;
import com.publicApi.jsonPayLoads.GsonClasses.Contact;
import com.publicApi.jsonPayLoads.GsonClasses.Storage;
import com.publicApi.jsonPayLoads.GsonClasses.Users;
import com.publicApi.jsonPayLoads.GsonClasses.traffic.OrderItems;
import com.publicApi.jsonPayLoads.GsonClasses.traffic.Traffic;
import com.publicApi.tests.testsBase.BaseTests;
import com.publicApi.utilities.HttpCalls;
import com.google.gson.Gson;
import com.publicApi.utilities.ResponseParser;
import net.javacrumbs.jsonunit.JsonAssert;
import org.apache.http.Header;
import org.apache.http.HttpResponse;
import org.apache.http.client.methods.*;
import org.apache.http.client.utils.URIBuilder;
import org.apache.http.entity.FileEntity;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.util.EntityUtils;
import org.json.*;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.testng.Assert;

import java.io.*;
import java.lang.reflect.Type;
import java.net.URI;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;

import static net.javacrumbs.jsonunit.JsonAssert.when;
import static net.javacrumbs.jsonunit.core.Option.*;

public class HeadlessAPICalls {
    private Gson gson;
    private String jsonString;
    private String endPointName;
    private String url;
    private StringEntity entity;
    private ExpectedJsonSchema expPayloadSchema;
    private RequestPayLoads reqPayload;
    private HttpResponse response;
    private String baseURL;
    private HttpCalls coreService;

    public HeadlessAPICalls() {
        try {
            gson = new Gson();
            expPayloadSchema = new ExpectedJsonSchema();
            reqPayload=new RequestPayLoads();
            baseURL = BaseTests.getBaseURL()+ "/api/v2";
            coreService = new HttpCalls();
        }catch (Exception e) { e.printStackTrace(); }
    }

    // Read expected response payload
    private String getExpectedJsonResponseStructure(String endPointName)throws IOException {
        byte[] encoded = Files.readAllBytes(Paths.get(System.getProperty("user.dir")+
                "/src/test/java/com/publicApi/jsonPayLoads/Expected_JsonResponse/"+endPointName+".json"));
        return new String(encoded, StandardCharsets.UTF_8);
    }


    //<editor-fold desc="ATTACHMENTS">
    public BaseOfBase createAttachments(String type, String fileId, String mediaId, String mediaName, String mediaSize) {
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        url=baseURL+"/:type(files|assets)/:id/attachments";
        entity = new StringEntity(reqPayload.assetCreateAttachmentPayload(mediaName,mediaSize,mediaId),StandardCharsets.UTF_8);
        jsonString=coreService.customPostCall(url.replace(":type(files|assets)/:id/attachments", type + "/" + fileId + "/attachments"), endPointName, entity);

        JsonAssert.assertJsonEquals(expPayloadSchema.assetCreateAttachment(), jsonString, when(IGNORING_VALUES));

        jsonString = jsonString.substring(1,jsonString.length()-1);
        return gson.fromJson(jsonString, BaseOfBase.class);
    }

    public BaseOfBase editAttachment(String type, String fileId,String mediaId,String mediaName,String mediaSize, String attachmentId) {
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        url=baseURL+"/:type(files|assets)/:fileId/attachments/:id";
        entity = new StringEntity(reqPayload.assetEditAttachmentPayLoad(mediaName, mediaSize, mediaId),StandardCharsets.UTF_8);

        jsonString=coreService.customPutCall(url.replace(":type(files|assets)/:fileId/attachments/:id", type + "/" + fileId + "/attachments/" + attachmentId),
                endPointName, entity);

        JsonAssert.assertJsonEquals(expPayloadSchema.assetEditAttachment(), jsonString, when(IGNORING_VALUES));

        return gson.fromJson(jsonString, BaseOfBase.class);
    }

    public BaseOfBase listAttachments(String type, String fileId) {
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        url=baseURL+"/:type(files|assets)/:id/attachments";
        jsonString=coreService.customGetCall(url.replace(":type(files|assets)/:id/attachments", type + "/" + fileId + "/attachments"), endPointName);

        JsonAssert.assertJsonEquals(expPayloadSchema.assetCreateAttachment(), jsonString, when(IGNORING_VALUES));
        jsonString = jsonString.substring(1,jsonString.length()-1);
        return gson.fromJson(jsonString, BaseOfBase.class);
    }

    public Boolean removeAttachment(String attachmentId) {
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        url=baseURL+"/attachments/:id";
        return coreService.customDeleteCall(url.replace(":id", attachmentId), endPointName);
    }
    //</editor-fold>


    //<editor-fold desc="DICTIONARY">
    public Boolean deleteDictionaryElement(String key) {
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        url=baseURL+"/dictionary/:id";
        entity = new StringEntity(reqPayload.deleteDictionaryElementPayLoad(key),StandardCharsets.UTF_8);
        return coreService.customDeleteCallWithBody(url.replace(":id", ExpectedData.DICTIONARY_ID), endPointName, entity);
    }

    public Boolean deleteChildDictionaryElement(String key) {

        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        url=baseURL+"/dictionary/:id";
        entity = new StringEntity(reqPayload.deleteChildDictionaryElementPayLoad(key),StandardCharsets.UTF_8);
        return coreService.customDeleteCallWithBody(url.replace(":id", ExpectedData.DICTIONARY_ID), endPointName, entity);

    }
    public String getDictionary() {
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        url=baseURL+"/dictionary/:id";
        return coreService.customGetCall(url.replace(":id", ExpectedData.DICTIONARY_ID), endPointName);
    }

    public String listDictionaries() {
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        url=baseURL+"/dictionary";

        return coreService.customGetCall(url, endPointName);
    }

    public String updateDictionary() {
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        url=baseURL+"/dictionary/:id";

        entity = new StringEntity(reqPayload.updateDictionaryPayLoad(),StandardCharsets.UTF_8);
        return coreService.customPatchCall(url.replace(":id", ExpectedData.DICTIONARY_ID), endPointName, entity);
    }


    //</editor-fold>


    //<editor-fold desc="ORDERING">
    public String generateAClockForAnOrder(String orderId, int generatorIndex) throws ParseException {
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        url=baseURL+"/orders/:orderId/clocks/generate";
        if(generatorIndex>0) {
            jsonString = coreService.customGetCall(url.replace(":orderId/clocks/generate", orderId + "/clocks/generate?generatorIndex=" +generatorIndex),
                    endPointName);
        }else {
            jsonString = coreService.customGetCall(url.replace(":orderId/clocks/generate", orderId + "/clocks/generate"),
                    endPointName);
        }

        // PARSE THE JSON CONTENT
        JSONParser parser = new JSONParser();
        JSONObject json = (JSONObject) parser.parse(jsonString);

        JsonAssert.assertJsonEquals(expPayloadSchema.generateAClockForAnOrder(), jsonString, when(IGNORING_VALUES));

        return json.get("clock").toString();
    }

    public BaseOfBase createOrder() {
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        url = baseURL+"/orders";
        coreService.setTokenType("agencyAdmin");
        entity = new StringEntity(reqPayload.createOrderPayLoad(),StandardCharsets.UTF_8);
        jsonString = coreService.customPostCall(url, endPointName, entity);

        JsonAssert.assertJsonEquals(expPayloadSchema.createOrder(), jsonString, when(IGNORING_VALUES));

        return gson.fromJson(jsonString, BaseOfBase.class);
    }

    public BaseOfBase getOrder(String orderId) {
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        url = baseURL+"/orders/:orderId";
        jsonString = coreService.customGetCall(url.replace(":orderId", orderId),
                endPointName);

        JsonAssert.assertJsonEquals(expPayloadSchema.createOrder(), jsonString, when(IGNORING_VALUES));

        return gson.fromJson(jsonString, BaseOfBase.class);
    }

    public Boolean removeOrder(String orderId) {
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        url = baseURL+"/orders/:orderId";

        return coreService.customDeleteCall(url.replace(":orderId", orderId), endPointName);
    }

    public BaseOfBase editOrder(String orderId) {
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        url = baseURL+"/orders/:orderId";
        entity = new StringEntity(reqPayload.editOrderPayLoad(),StandardCharsets.UTF_8);
        jsonString  = coreService.customPutCall(url.replace(":orderId", orderId),
                endPointName, entity);

        JsonAssert.assertJsonEquals(expPayloadSchema.editOrder(), jsonString, when(IGNORING_VALUES));

        return gson.fromJson(jsonString, BaseOfBase.class);
    }

    public BaseOfBase createItem(String orderId){
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        url = baseURL+"/orders/:orderId/items";
        coreService.setTokenType("agencyAdmin");
        entity = new StringEntity(reqPayload.createItemPayLoad(),StandardCharsets.UTF_8);
        jsonString = coreService.customPostCall(url.replace(":orderId/items", orderId + "/items"),
                endPointName, entity);

        JsonAssert.assertJsonEquals(expPayloadSchema.createItem(), jsonString, when(IGNORING_EXTRA_FIELDS,IGNORING_VALUES));
        return gson.fromJson(jsonString, BaseOfBase.class);
    }

    public String getItem(String orderId, String itemId) {
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        url = baseURL+"/orders/:orderId/items/:itemId";
        jsonString = coreService.customGetCall(url.replace(":orderId/items/:itemId", orderId + "/items/" + itemId)
                , endPointName);

        JsonAssert.assertJsonEquals(expPayloadSchema.createItem(), jsonString, when(IGNORING_EXTRA_FIELDS,IGNORING_VALUES));

        return jsonString;
    }

    public Boolean removeItem(String orderId, String itemId) {
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        url = baseURL+"/orders/:orderId/items/:itemId";

        return coreService.customDeleteCall(url.replace(":orderId/items/:itemId", orderId + "/items/" + itemId), endPointName);
    }

    public BaseOfBase editItem(String orderId, String itemId) {
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        url = baseURL+"/orders/:orderId/items/:itemId";
        entity = new StringEntity(reqPayload.editItemPayLoad(),StandardCharsets.UTF_8);
        jsonString = coreService.customPutCall(url.replace(":orderId/items/:itemId", orderId + "/items/" + itemId),
                endPointName, entity);

        JsonAssert.assertJsonEquals(expPayloadSchema.editItem(), jsonString, when(IGNORING_VALUES));

        return gson.fromJson(jsonString, BaseOfBase.class);
    }

    public BaseOfBase updateItem(String orderId, String itemId, StringEntity entity) {
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        url = baseURL+"/orders/:orderId/items/:itemId";

        jsonString= coreService.customPatchCall(url.replace(":orderId/items/:itemId", orderId + "/items/" + itemId),
                endPointName, entity);

        JsonAssert.assertJsonEquals(expPayloadSchema.updateItem(), jsonString, when(IGNORING_VALUES));

        return gson.fromJson(jsonString, BaseOfBase.class);
    }

    public BaseOfBase setOrderApprovalStatus(String orderId, String itemId) {
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        url=baseURL+"/orders/:orderId/items/:itemId";
        entity = new StringEntity(reqPayload.setOrderApprovalStatusPayLoad(),StandardCharsets.UTF_8);

        jsonString=coreService.customPutCall(url.replace(":orderId/items/:itemId",
                orderId + "/items/" + itemId), endPointName, entity);

        JsonAssert.assertJsonEquals(expPayloadSchema.createProjectFile(), jsonString, when(IGNORING_VALUES));

        return gson.fromJson(jsonString, BaseOfBase.class);
    }

    public Boolean deleteApprovalStatus (String orderId, String itemId) {
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        url=baseURL+"/orders/:orderId/items/:itemId/approval";

        return coreService.customDeleteCall(
                url.replace(":orderId/items/:itemId/approval", orderId + "/items/" + itemId + "/approval"), endPointName);
    }

    public Boolean listOrders() {
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        url = baseURL+"/orders";
        jsonString=coreService.customGetCall(url, endPointName);

        Assert.assertNotNull(jsonString); // Note: Not validating response schema, as orders count does varies
        return true;
    }

    public String listOrdersWithJsonResponse() {
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        url = baseURL+"/orders";
        coreService.setTokenType("agencyAdmin");
        jsonString=coreService.customGetCall(url, endPointName);

        Assert.assertNotNull(jsonString); // Note: Not validating response schema, as orders count does varies
        return jsonString;
    }

    public String listItems(String orderId) {
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        url = baseURL+"/orders/:orderId/items";
        jsonString = coreService.customGetCall(url.replace(":orderId/items", orderId + "/items"), endPointName);

        JsonAssert.assertJsonEquals(expPayloadSchema.ordersListItems(), jsonString, when(IGNORING_VALUES));

        return jsonString;
    }

    public String addDestinationItems(String orderId, String itemId) {
        endPointName=Thread.currentThread().getStackTrace()[1].getMethodName();
        url = baseURL+"/orders/:orderId/items/:itemId/destinations";
        coreService.setTokenType("agencyAdmin");
        entity = new StringEntity(reqPayload.addDestinationItemsPayLoad(),StandardCharsets.UTF_8);
        jsonString = coreService.customPostCall(url.replace(":orderId/items/:itemId/destinations",
                orderId + "/items/" + itemId + "/destinations"), endPointName, entity);

        JsonAssert.assertJsonEquals(expPayloadSchema.addDestinationItems(), jsonString, when(IGNORING_VALUES));
        return jsonString;
    }

    public BaseOfBase getDestinationItems(String orderId, String itemId) {
        endPointName=Thread.currentThread().getStackTrace()[1].getMethodName();
        url = baseURL+"/orders/:orderId/items/:itemId/destinations";
        jsonString = coreService.customGetCall(url.replace(":orderId/items/:itemId/destinations",
                orderId + "/items/" + itemId + "/destinations"),endPointName);

        JsonAssert.assertJsonEquals(expPayloadSchema.getDestinationItems(), jsonString, when(IGNORING_VALUES));

        Assert.assertNotNull(jsonString, endPointName.toUpperCase() + " : endCheck response, " + jsonString);

        return gson.fromJson(jsonString, BaseOfBase.class);
    }

    public String editDestinationItems(String orderId, String itemId) {
        endPointName=Thread.currentThread().getStackTrace()[1].getMethodName();
        url = baseURL+"/orders/:orderId/items/:itemId/destinations";
        entity = new StringEntity(reqPayload.addDestinationItemsPayLoad(),StandardCharsets.UTF_8);
        jsonString = coreService.customPutCall(url.replace(":orderId/items/:itemId/destinations",
                orderId + "/items/" + itemId + "/destinations"), endPointName, entity);

        JsonAssert.assertJsonEquals(expPayloadSchema.editDestinationItems(), jsonString, when(IGNORING_VALUES));

        return jsonString;
    }

    public Boolean removeOrderItemDestination(String orderId, String itemId) {
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        url = baseURL+"/orders/:orderId/items/:itemId/destinations";
        entity = new StringEntity(reqPayload.removeDestinationItemsPayLoad(),StandardCharsets.UTF_8);
        return coreService.customDeleteCallWithBody(url.replace(":orderId/items/:itemId", orderId + "/items/" + itemId), endPointName, entity);
    }

    public BaseOfBase addMediaItem(String orderId, String itemId, String assetId) {
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        url = baseURL+"/orders/:orderId/items/:itemId/media/:assetId";

        // Ignore request payload for this Endpoint, all it requires only URL parameters. So using dummy request payload as 'createOrderPayLoad'
        entity = new StringEntity(reqPayload.createOrderPayLoad(),StandardCharsets.UTF_8);

        jsonString = coreService.customPostCall(url.replace(":orderId/items/:itemId/media/:assetId", orderId + "/items/" + itemId + "/media/" + assetId), endPointName, entity);

        JsonAssert.assertJsonEquals(expPayloadSchema.addMediaItem(), jsonString, when(IGNORING_VALUES));

        return gson.fromJson(jsonString, BaseOfBase.class);
    }

    public Boolean removeMediaItem(String orderId, String itemId) {
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        url=baseURL+"/orders/:orderId/items/:itemId/media";

        return coreService.customDeleteCall(url.replace(":orderId/items/:itemId/media", orderId + "/items/" + itemId + "/media"), endPointName);
    }

    public BaseOfBase processDraftorders(String orderId, String orderItemId,String meta) {
        endPointName=Thread.currentThread().getStackTrace()[1].getMethodName();
        url = baseURL+"/orders/:orderId/process";
        coreService.setTokenType("agencyAdmin");
        entity = new StringEntity(reqPayload.processDraftorders(orderItemId, meta),StandardCharsets.UTF_8);
        jsonString = coreService.customPutCall(url.replace(":orderId", orderId), endPointName, entity);

        Assert.assertNotNull(jsonString);
        return gson.fromJson(jsonString, BaseOfBase.class);
    }

    public String updateOrderItemDestination(String orderId, String itemId) {
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        url = baseURL+"/orders/:orderId/items/:itemId/destinations";
        entity = new StringEntity(reqPayload.editDestinationItemsPayLoad(),StandardCharsets.UTF_8);
        jsonString = coreService.customPatchCall(url.replace(":orderId/items/:itemId/destinations",
                orderId + "/items/" + itemId + "/destinations"), endPointName, entity);

        JsonAssert.assertJsonEquals(expPayloadSchema.addDestinationItems(), jsonString, when(IGNORING_VALUES));

        return jsonString;
    }

    public BaseOfBase orderItemUpdateUsageRights(String orderId, String itemId) {
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        url=baseURL+"/orders/:orderId/items/:itemId/rights";
        entity = new StringEntity(reqPayload.updateUsageRightsPayLoad(),StandardCharsets.UTF_8);
        jsonString = coreService.customPutCall(url.replace(":orderId/items/:itemId/rights",
                orderId + "/items/" + itemId + "/rights"), endPointName, entity);

        JsonAssert.assertJsonEquals(expPayloadSchema.updateUsageRightsPayLoad(), jsonString, when(IGNORING_VALUES));

        return gson.fromJson(jsonString, BaseOfBase.class);
    }

    public BaseOfBase getOrderItemUsageRights( String orderId, String itemId){
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        url=baseURL+"/orders/:orderId/items/:itemId/rights";
        jsonString = coreService.customGetCall(url.replace(":orderId/items/:itemId/rights", orderId + "/items/" + itemId + "/rights"), endPointName);

        JsonAssert.assertJsonEquals(expPayloadSchema.updateUsageRightsPayLoad(), jsonString, when(IGNORING_VALUES));

        return gson.fromJson(jsonString, BaseOfBase.class);
    }

    public Boolean deleteOrderItemUsageRights( String orderId, String itemId) {
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        url=baseURL+"/orders/:orderId/items/:itemId/rights";

        return coreService.customDeleteCall(url.replace(":orderId/items/:itemId/rights", orderId + "/items/" + itemId + "/rights"), endPointName);
    }

    public Boolean getOrderMarkets() {
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        url = baseURL+"/markets/:id";
        jsonString = coreService.customGetCall(url.replace(":id", ExpectedData.MARKETID), endPointName);

        Assert.assertNotNull(jsonString, endPointName.toUpperCase() + " Respone payload found empty");
        return true; // Note: Not validating response schema. Response does have destinations array and it varies from Environment to environment.
    }

    public Boolean listOrderMarkets() {
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        url = baseURL+"/markets";
        jsonString = coreService.customGetCall(url, endPointName);

        Assert.assertNotNull(jsonString,endPointName.toUpperCase()+" Respone payload found empty");
        return true; // Note: Not validating response schema. Number of Markets vary from Environment to Environment.
    }

    public Boolean listOrderMarketDestinations() {
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        url = baseURL+"/markets/:id/destinations";

        jsonString = coreService.customGetCall(url.replace(":id/destinations", ExpectedData.MARKETID + "/destinations"),endPointName);

        Assert.assertNotNull(jsonString,endPointName.toUpperCase()+" Respone payload found empty");
        return true; // Note: Not validating response schema. Response does have destinations array and it varies from Environment to environment.
    }

    public BaseOfBase getDeliveryListForSpecifiedClock(String clockNumber) {
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        url = baseURL+"/orders/deliveries?clockNumber=:Id";
        jsonString = coreService.customGetCall(url.replace(":Id",clockNumber),
                endPointName);

        JsonAssert.assertJsonEquals(expPayloadSchema.getDeliveryListForSpecifiedClock(), jsonString, when(IGNORING_VALUES));

        jsonString = jsonString.substring(1,jsonString.length()-1);
        return gson.fromJson(jsonString, BaseOfBase.class);
    }

    public BaseOfBase updateOrder(String OrderId) {
        endPointName=Thread.currentThread().getStackTrace()[1].getMethodName();
        url = baseURL+"/orders/:orderId";
        entity = new StringEntity(reqPayload.editOrderPayLoad(),StandardCharsets.UTF_8);
        jsonString = coreService.customPatchCall(url.replace(":orderId", OrderId),
                endPointName, entity);

        JsonAssert.assertJsonEquals(expPayloadSchema.createOrder(), jsonString, when(IGNORING_VALUES));

        return gson.fromJson(jsonString, BaseOfBase.class);
    }

    public String validateClocksInLibrary(String clock) {
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        url = baseURL+"/clocks";

        return coreService.customGetCall(url.replace(url, url + "?clocks[]=" + clock),
                endPointName);
    }

    public String validateClocksInOrder(String OrderId) {
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        url = baseURL+"/orders/:orderId/clocks";

        return coreService.customGetCall(url.replace(":orderId/clocks", OrderId + "/clocks"), endPointName);
    }

    public Boolean getOrderReport (String OrderId) {
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        url = baseURL+"/orders/:orderId/report";
        jsonString = coreService.customGetCall((url.replace(":orderId/report", OrderId + "/report")),
                endPointName);

        Assert.assertNotNull(jsonString); // Checking response isn't null. As Response payload is in PDF format and parsers implementation is pending (PDF to JSON or PDF to XML and then XML to JSON ... etc ...)
        return true;
    }

    //</editor-fold>


    //<editor-fold desc="TRAFFIC">
    public Traffic traffic_GetOrderItemDestination(String orderItemID, String destinationID) {
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        url=baseURL+"/traffic/Items/:itemId/destinations/:destinationId";
        coreService.setTokenType("broadcastManager");
        jsonString=coreService.customGetCall(url.replace(":itemId/destinations/:destinationId",
                orderItemID + "/destinations/" + destinationID), endPointName);

        if(jsonString.contains("a4Id")) {
            JsonAssert.assertJsonEquals(expPayloadSchema.traffic_GetOrderItemDestination(), jsonString, when(IGNORING_VALUES));
        }
        else {
            JsonAssert.assertJsonEquals(removea4IdFromExpectedResponse(expPayloadSchema.traffic_GetOrderItemDestination()), jsonString, when(IGNORING_VALUES));
        }
        return gson.fromJson(jsonString, Traffic.class);
    }

    public Traffic traffic_GetOrderItem(String orderItemId) {
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        url=baseURL+"/traffic/items/:itemId/";
        coreService.setTokenType("broadcastManager");
        jsonString=coreService.customGetCall(url.replace(":itemId/", orderItemId),endPointName);


        if(jsonString.contains("a4Id")) {
            if(ResponseParser.removeEmptyApprovals(jsonString).contains("approvals")){
                JsonAssert.assertJsonEquals(expPayloadSchema.traffic_GetorderItemWithMasterRelease(), jsonString, when(IGNORING_VALUES));
            }
            else
                JsonAssert.assertJsonEquals(expPayloadSchema.traffic_GetorderItem(), jsonString, when(IGNORING_VALUES));
        }
        else  if(!jsonString.contains("a4Id")){
            if(ResponseParser.removeEmptyApprovals(jsonString).contains("approvals")){
                JsonAssert.assertJsonEquals(removea4IdFromExpectedResponse(expPayloadSchema.traffic_GetorderItemWithMasterRelease()), jsonString, when(IGNORING_VALUES));
            }
            else
                JsonAssert.assertJsonEquals(removea4IdFromExpectedResponse(expPayloadSchema.traffic_GetorderItem()), jsonString, when(IGNORING_VALUES));
        }
        jsonString = jsonString.substring(1,jsonString.length()-1);
        return gson.fromJson(jsonString, Traffic.class);
    }

    public Traffic traffic_GetOrderItemWithOrderDelivered(String orderItemId) {
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        url=baseURL+"/traffic/items/:itemId/";
        coreService.setTokenType("broadcastManager");
        jsonString=coreService.customGetCall(url.replace(":itemId/", orderItemId),endPointName);

        if(jsonString.contains("a4Id")) {
            JsonAssert.assertJsonEquals(expPayloadSchema.traffic_GetorderItemWithOrderDelivered(), jsonString, when(IGNORING_VALUES));
        }
        else  if(!jsonString.contains("a4Id")) {

            JsonAssert.assertJsonEquals(removea4IdFromExpectedResponse(expPayloadSchema.traffic_GetorderItemWithOrderDelivered()), jsonString, when(IGNORING_VALUES));
        }
            jsonString = jsonString.substring(1,jsonString.length()-1);
        return gson.fromJson(jsonString, Traffic.class);
    }

    public Traffic traffic_GetOrderItemWithProxy(String orderItemId) {
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        url=baseURL+"/traffic/items/:itemId/";
        coreService.setTokenType("broadcastManager");
        jsonString=coreService.customGetCall(url.replace(":itemId/", orderItemId),endPointName);

        if(jsonString.contains("a4Id")) {
            if(jsonString.contains("approvals")){
                JsonAssert.assertJsonEquals(expPayloadSchema.traffic_GetorderItemWithProxy(), jsonString, when(IGNORING_VALUES));
            }
            else
                JsonAssert.assertJsonEquals(expPayloadSchema.traffic_GetorderItem(), jsonString, when(IGNORING_VALUES));
        }
        else  if(!jsonString.contains("a4Id")){
            if(jsonString.contains("approvals")){
                JsonAssert.assertJsonEquals(removea4IdFromExpectedResponse(expPayloadSchema.traffic_GetorderItemWithProxy()), jsonString, when(IGNORING_VALUES));
            }
            else
                JsonAssert.assertJsonEquals(removea4IdFromExpectedResponse(expPayloadSchema.traffic_GetorderItem()), jsonString, when(IGNORING_VALUES));
        }
        jsonString = jsonString.substring(1,jsonString.length()-1);
        return gson.fromJson(jsonString, Traffic.class);
    }

    public Traffic traffic_GetOrderItemHN(String orderItemId) {
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        url=baseURL+"/traffic/items/:itemId/";
        coreService.setTokenType("broadcastManager");
        jsonString=coreService.customGetCall(url.replace(":itemId/", orderItemId),endPointName);

        if(jsonString.contains("a4Id")) {
            JsonAssert.assertJsonEquals(expPayloadSchema.traffic_GetorderItemHN(), jsonString, when(IGNORING_VALUES));
        }
        else {
            JsonAssert.assertJsonEquals(removea4IdFromExpectedResponse(expPayloadSchema.traffic_GetorderItemHN()), jsonString, when(IGNORING_VALUES));
        }
        jsonString = jsonString.substring(1,jsonString.length()-1);
        return gson.fromJson(jsonString, Traffic.class);
    }

    public OrderItems[] trafficGetOrderItem(String orderItemId) {
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        url=baseURL+"/traffic/items/:itemId/";
        coreService.setTokenType("broadcastManager");
        jsonString=coreService.customGetCall(url.replace(":itemId/", orderItemId),endPointName);

        Assert.assertNotNull(jsonString);
        return gson.fromJson(jsonString, OrderItems[].class);

    }

    public Traffic traffic_ListOrderItemDestinations(String orderItemId) {
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        url=baseURL+"/traffic/Items/:itemId/destinations";
        coreService.setTokenType("broadcastManager");
        jsonString=coreService.customGetCall(url.replace(":itemId", orderItemId), endPointName);

        if(jsonString.contains("a4Id")) {
            JsonAssert.assertJsonEquals(expPayloadSchema.traffic_ListOrderItemDestinations(), jsonString, when(IGNORING_VALUES));
        }
        else {
            JsonAssert.assertJsonEquals(removea4IdFromExpectedResponse(expPayloadSchema.traffic_ListOrderItemDestinations()), jsonString, when(IGNORING_VALUES));
        }
        jsonString = jsonString.substring(1,jsonString.length()-1);
        return gson.fromJson(jsonString, Traffic.class);
    }

    public String traffic_ListOrderItems() {
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        url=baseURL+"/traffic/Items";
        coreService.setTokenType("broadcastManager");
        jsonString=coreService.customGetCall(url,endPointName);

        Assert.assertNotNull(jsonString);

        return jsonString;
    }

    public OrderItems[] traffic_ListOrderItems(String pageNumber,String size) {
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        url=baseURL+"/traffic/Items?page="+pageNumber+"&size="+size;
        coreService.setTokenType("broadcastManager");
        jsonString=coreService.customGetCall(url,endPointName);

        Assert.assertNotNull(jsonString);

        return gson.fromJson(jsonString, OrderItems[].class);
    }

    public OrderItems[] traffic_ListOrderItems(String pageNumber) {
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        url=baseURL+"/traffic/Items?page="+pageNumber;
        coreService.setTokenType("broadcastManager");
        jsonString=coreService.customGetCall(url,endPointName);

        Assert.assertNotNull(jsonString);

        return gson.fromJson(jsonString, OrderItems[].class);
    }

    public OrderItems[] traffic_ListOrderItems_DateSearch(String[] timeStamp) {
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        url=baseURL+"/traffic/items";
        StringBuffer address = new StringBuffer(url);
        StringBuffer newUrl= address.append("?modified[]=").append(timeStamp[0]).append("&modified[]=").append(timeStamp[1]).append("&created[]=").append(timeStamp[2]).append("&created[]=").append(timeStamp[3]);

        coreService.setTokenType("broadcastManager");
        jsonString=coreService.customGetCall(newUrl.toString(),endPointName);

        Assert.assertNotNull(jsonString);
        return gson.fromJson(jsonString, OrderItems[].class);
    }




    public Traffic traffic_GetOrder(String orderId) {
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        url=baseURL+"/traffic/orders/:orderId/";
        coreService.setTokenType("trafficManager");
        jsonString=coreService.customGetCall(url.replace(":orderId", orderId), endPointName);
        if(jsonString.contains("a4Id")) {
            JsonAssert.assertJsonEquals(expPayloadSchema.traffic_GetOrder(), jsonString, when(IGNORING_VALUES));
        }
        else {
            JsonAssert.assertJsonEquals(removea4IdFromExpectedResponse(expPayloadSchema.traffic_GetOrder()), jsonString, when(IGNORING_VALUES));
        }
        return gson.fromJson(jsonString, Traffic.class);
    }

    public String traffic_ListOrders() {
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        url=baseURL+"/traffic/orders";
        coreService.setTokenType("trafficManager");
        jsonString=coreService.customGetCall(url, endPointName);

        Assert.assertNotNull(jsonString);

        return jsonString;
    }

    public boolean traffic_SetApprovalsForOrderItems(String type, String operation, String itemId, String destId,String message) {
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        url=baseURL+"/traffic/orders/:type/:operation".replace(":type/:operation", type + "/" + operation);
        coreService.setTokenType("broadcastManager");

        HttpPut request = new HttpPut(url);
        entity = new StringEntity(reqPayload.trafficSetApprovalsForOrderItemsPayLoad(itemId, destId, message),StandardCharsets.UTF_8);
        request.setEntity(entity);
        jsonString=coreService.customPutCall(request, endPointName, entity);

        JsonAssert.assertJsonEquals(expPayloadSchema.traffic_SetApprovalsForOrderItems(), jsonString, when(IGNORING_VALUES));
        return true;
    }

    public Traffic traffic_SetDestinationHouseNumber(String itemId, String destinationId, String houseNumber) {
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        url=baseURL+"/traffic/items/:itemId/destinations/:destinationId";
        entity = new StringEntity(reqPayload.addSetHouseNumberFilePayLoad(houseNumber),StandardCharsets.UTF_8);
        coreService.setTokenType("broadcastManager");
        jsonString=coreService.customPatchCall(url.replace(
                ":itemId/destinations/:destinationId", itemId + "/destinations/" + destinationId),endPointName,entity);
        if(jsonString.contains("a4Id")) {
            JsonAssert.assertJsonEquals(expPayloadSchema.traffic_SetDestinationHousenumber(), jsonString, when(IGNORING_VALUES));
        }
        else {
            JsonAssert.assertJsonEquals(removea4IdFromExpectedResponse(expPayloadSchema.traffic_SetDestinationHousenumber()), jsonString, when(IGNORING_VALUES));
        }
        jsonString = jsonString.substring(1,jsonString.length()-1);
        return gson.fromJson(jsonString, Traffic.class);
    }
    //</editor-fold>


    //<editor-fold desc="SCHEMA">
    public Boolean get_MarketSchema(String methodName) {
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName().concat("_"+methodName);
        url = baseURL+"/schema/market/:marketId/:method";
        jsonString = coreService.customGetCall(url.replace(":marketId/:method", ExpectedData.ITALY_PUBLICITA_MARKET_ID + "/" + methodName),
                endPointName);


        // Validating for  marketId 20
        JsonAssert.assertJsonEquals(expPayloadSchema.get_MarketSchema_20(), jsonString, when(IGNORING_VALUES, IGNORING_EXTRA_ARRAY_ITEMS));
        return true;
    }

    public Boolean get_OrderItemDestinationSchema(String orderId,String methodName) {
        try {
            endPointName = Thread.currentThread().getStackTrace()[1].getMethodName().concat("_" + methodName);
            url = baseURL + "/schema/orders/:orderId/items/destinations/:method";
            jsonString = coreService.customGetCall(url.replace(":orderId/items/destinations/:method",
                    orderId + "/items/destinations/" + methodName), endPointName);

            // Not validating response payload structure as it changing from ENV to ENV. So just validating the Status Code is 200
            // JsonAssert.assertJsonEquals(getExpectedJsonResponseStructure("Schema_GetOrderItemDestinationSchema"),jsonString, when(IGNORING_VALUES));
            return true;
        } catch (Exception e) {
            System.out.println(e.getMessage()+"\n");
            e.printStackTrace();
            return false;
        }
    }

    public Boolean getOrderItemSchema(String orderId,String methodName) {
        try {
            endPointName = Thread.currentThread().getStackTrace()[1].getMethodName().concat("_" + methodName);
            url = baseURL + "/schema/orders/:orderId/items/:method";
            jsonString = coreService.customGetCall(url.replace(":orderId/items/:method", orderId + "/items/" + methodName), endPointName);

            // Not validating response payload structure as it changing from ENV to ENV. So just validating the Status Code is 200
            // JsonAssert.assertJsonEquals(getExpectedJsonResponseStructure("Schema_GetOrderItemSchema"),jsonString, when(IGNORING_VALUES));
            return true;
        } catch (Exception e) {
            System.out.println(e.getMessage()+"\n");
            e.printStackTrace();
            return false;
        }
    }

    public Boolean resourceSchema(String resourceName,String methodName) {
        try {
            endPointName = Thread.currentThread().getStackTrace()[1].getMethodName().concat("_" + resourceName + "_" + methodName);
            url = baseURL + "/schema/:resource/:method";

            jsonString = coreService.customGetCall(url.replace(":resource/:method", resourceName + "/" + methodName), endPointName);

            // Not validating response payload structure as it changing from ENV to ENV. So just validating the Status Code is 200
            // JsonAssert.assertJsonEquals(getExpectedJsonResponseStructure("resourceSchema_" + resourceName), jsonString, when(IGNORING_VALUES));
            return true;
        } catch (Exception e) {
            System.out.println(e.getMessage()+"\n");
            e.printStackTrace();
            return false;
        }
    }
    //</editor-fold>


    //<editor-fold desc="PROJECTS">
    public BaseOfBase createFolder(String parentId) {
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        url=baseURL+"/folders";
        entity = new StringEntity(reqPayload.createFolderPayload(parentId),StandardCharsets.UTF_8);

        jsonString=coreService.customPostCall(url,endPointName,entity);

        JsonAssert.assertJsonEquals(expPayloadSchema.createFolder(), jsonString, when(IGNORING_VALUES));

        return gson.fromJson(jsonString, BaseOfBase.class);
    }

    public BaseOfBase searchProjectFolderId(String projectId) {
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        url=baseURL+"/folders";

        String subquery = "?query=project._id:";
        String query = subquery.concat(projectId);
        jsonString = coreService.customGetCall(url.concat(query), endPointName);

        JsonAssert.assertJsonEquals(expPayloadSchema.searchProjectFolderId(), jsonString, when(IGNORING_VALUES));

        jsonString = jsonString.substring(1, jsonString.length() - 1);
        return gson.fromJson(jsonString, BaseOfBase.class);
    }

    public BaseOfBase createFile(String folderId) {
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        url=baseURL+"/folders/:folderId/files";
        entity = new StringEntity(reqPayload.createFilePayload(),StandardCharsets.UTF_8);

        jsonString = coreService.customPostCall(url.replace(":folderId", folderId), endPointName, entity);

        JsonAssert.assertJsonEquals(expPayloadSchema.createFile(), jsonString, when(IGNORING_VALUES));

        return gson.fromJson(jsonString, BaseOfBase.class);

    }

    public BaseOfBase projectsFoldersGetFolder(String folderId) {
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        url=baseURL+"/folders/:folderId";

        jsonString=coreService.customGetCall(url.replace(":folderId", folderId), endPointName);

        JsonAssert.assertJsonEquals(expPayloadSchema.createFolder(), jsonString, when(IGNORING_VALUES));

        return gson.fromJson(jsonString, BaseOfBase.class);
    }

    public Boolean projectsFoldersDeleteFolder(String folderId){
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        url=baseURL+"/folders/:folderId";

        return coreService.customDeleteCall(url.replace(":folderId", folderId), endPointName);
    }

    public Users[] assignTeamToFolder(String folderId, String teamId, String roleId, boolean inheritance, String expireDate) {
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        url = baseURL+"/folders/:folderId/teams/:teamId".replace(":folderId/teams/:teamId", folderId + "/teams/" + teamId);
        entity = new StringEntity(reqPayload.assignTeamToFolderPayLoad(roleId, inheritance, expireDate),StandardCharsets.UTF_8);

        jsonString = coreService.customPostCall(url,endPointName,entity);

        if(inheritance==true && !(expireDate.isEmpty())){
            JsonAssert.assertJsonEquals(expPayloadSchema.assignTeamToFolderWithInheritance(), jsonString, when(IGNORING_VALUES));
        } else if(inheritance==false && !(expireDate.isEmpty())){
            JsonAssert.assertJsonEquals(expPayloadSchema.assignTeamToFolderWithNoInheritance(), jsonString, when(IGNORING_VALUES));
        } else{
            JsonAssert.assertJsonEquals(expPayloadSchema.assignTeamToFolderWithRoleId(), jsonString, when(IGNORING_VALUES));
        }

        Assert.assertNotNull(jsonString);
        return gson.fromJson(jsonString, Users[].class);

    }

    public BaseOfBase moveCopyFile(String folderId, String fileId, String moveOrCopy,boolean isFile) {
        try {
            endPointName = Thread.currentThread().getStackTrace()[1].getMethodName();
            url = baseURL + "/folders/:folderId/files/:fileId".replace(":folderId/files/:fileId", folderId + "/files/" + fileId);

            URI uri = new URIBuilder(url)
                    .addParameter("move", moveOrCopy)
                    .build();

            jsonString = coreService.customPostCall_WithOutRequestPayload(uri, endPointName);

            if(isFile)
                JsonAssert.assertJsonEquals(expPayloadSchema.projectFolderCopyVideoFile(), jsonString, when(IGNORING_VALUES));
            else
                JsonAssert.assertJsonEquals(expPayloadSchema.projectFolderCopyFolder(), jsonString, when(IGNORING_VALUES));
        }catch(Exception e){
            e.printStackTrace();
        }
        return gson.fromJson(jsonString, BaseOfBase.class);
    }

    public BaseOfBase projectsFoldersSearchFolderContent(String folderId) {
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        url=baseURL+"/folders/:folderId/content";

        jsonString=coreService.customGetCall(url.replace(":folderId", folderId),endPointName);

        JsonAssert.assertJsonEquals(expPayloadSchema.projectsFoldersSearchFolderContent(), jsonString, when(IGNORING_EXTRA_FIELDS,IGNORING_VALUES));
        jsonString = jsonString.substring(1,jsonString.length()-1);
        return gson.fromJson(jsonString, BaseOfBase.class);
    }

    public BaseOfBase projectsFoldersSearchFolderContent(String folderId, String queryStr) {
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        url=baseURL+"/folders/:folderId/content?" + queryStr;

        jsonString=coreService.customGetCall(url.replace(":folderId", folderId),endPointName);

        JsonAssert.assertJsonEquals(expPayloadSchema.projectsFoldersSearchFolderContentWithApprovalInfo(), jsonString, when(IGNORING_EXTRA_FIELDS,IGNORING_VALUES));
        jsonString = jsonString.substring(1,jsonString.length()-1);
        return gson.fromJson(jsonString, BaseOfBase.class);
    }

    public String projectsFolderSearchFolder(){
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        url=baseURL+"/folders";

        jsonString=coreService.customGetCall(url, endPointName);

        Assert.assertNotNull(jsonString);
        return jsonString;
    }

    public BaseOfBase shareAsset(String assetId,String xA5Agency,String expiration, String recipients,boolean allowDownloadMaster, boolean allowDownloadProxy,String message){
        boolean isRequestForAllAgencies=false;
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        url = baseURL+"/assets/:id/shares".replace(":id", assetId);
        coreService.setTokenType("agencyAdmin");

        HttpPost request = new HttpPost(url);
        if(!(xA5Agency==null)) {
            request.addHeader("X-A5-Agency", xA5Agency);
            isRequestForAllAgencies=true;
        }

        entity = new StringEntity(reqPayload.assetCreateAPublicShare(expiration,recipients,allowDownloadMaster,allowDownloadProxy,message),StandardCharsets.UTF_8);
        request.setEntity(entity);
        jsonString=coreService.customPostCall(request,endPointName,entity);

        JsonAssert.assertJsonEquals(expPayloadSchema.shareAsset(), jsonString, when(IGNORING_VALUES));
        return gson.fromJson(jsonString, BaseOfBase.class);
    }


    public BaseOfBase projectsFoldersSearchFile(String folderId){
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        url=baseURL+"/folders/:id/files";

        jsonString=coreService.customGetCall(url.replace(":id", folderId), endPointName);

        JsonAssert.assertJsonEquals(expPayloadSchema.projectsFoldersSearchFolderContent(), jsonString, when(IGNORING_EXTRA_FIELDS,IGNORING_VALUES));
        jsonString = jsonString.substring(1, jsonString.length() - 1);

        return gson.fromJson(jsonString, BaseOfBase.class);
    }

    public String projectsFoldersSearchFile_WithoutSchema(String folderId){
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        url=baseURL+"/folders/:id/files";

        jsonString=coreService.customGetCall(url.replace(":id", folderId), endPointName);

        return  jsonString.substring(1, jsonString.length() - 1);
    }

    public BaseOfBase projectsFoldersUpdateFolder(String folderId){
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        url=baseURL+"/folders/:id";
        entity = new StringEntity(reqPayload.updateFolderPayload(),StandardCharsets.UTF_8);
        jsonString=coreService.customPutCall(url.replace(":id", folderId), endPointName, entity);

        JsonAssert.assertJsonEquals(expPayloadSchema.createFolder(), jsonString, when(IGNORING_VALUES));

        return gson.fromJson(jsonString, BaseOfBase.class);
    }

    public BaseOfBase createProject() {
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        url=baseURL+"/projects";
        entity = new StringEntity(reqPayload.createProjectPayLoad(),StandardCharsets.UTF_8);
        jsonString = coreService.customPostCall(url, endPointName, entity);

        JsonAssert.assertJsonEquals(expPayloadSchema.createProject(), jsonString, when(IGNORING_VALUES));
        return gson.fromJson(jsonString, BaseOfBase.class);
    }

    public BaseOfBase createProjectFile(String ProjectId) {
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        url=baseURL+"/projects/:projectId/files";
        entity = new StringEntity(reqPayload.createProjectFilePayLoad(),StandardCharsets.UTF_8);
        jsonString = coreService.customPostCall(url.replace(":projectId", ProjectId), endPointName, entity);

        JsonAssert.assertJsonEquals(expPayloadSchema.createProjectFile(), jsonString, when(IGNORING_VALUES));
        return gson.fromJson(jsonString, BaseOfBase.class);
    }

    public Boolean deleteProject(String projectId) {
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        url=baseURL+"/projects/:projectId";
        return coreService.customDeleteCall(url.replace(":projectId", projectId), endPointName);
    }

    public BaseOfBase getProject(String projectId) {
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        url=baseURL+"/projects/:projectId";

        jsonString = coreService.customGetCall(url.replace(":projectId", projectId), endPointName);

        JsonAssert.assertJsonEquals(expPayloadSchema.getProject(), jsonString, when(IGNORING_VALUES));

        return gson.fromJson(jsonString, BaseOfBase.class);
    }

    public BaseOfBase getProjectOwners(String projectId) {
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        url=baseURL+"/projects/:projectId/owners";

        jsonString = coreService.customGetCall(url.replace(":projectId", projectId),endPointName);

        JsonAssert.assertJsonEquals(expPayloadSchema.getProjectOwners(), jsonString, when(IGNORING_VALUES));

        jsonString = jsonString.substring(1,jsonString.length()-1);

        return gson.fromJson(jsonString, BaseOfBase.class);
    }

    public String assignTeamToProject(String projectId) {
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        url=baseURL+"/projects/:projectId/teams";

        entity = new StringEntity(reqPayload.assignTeamToProjectPayLoad(),StandardCharsets.UTF_8);
        jsonString = coreService.customPostCall(url.replace(":projectId", projectId), endPointName, entity);

        JsonAssert.assertJsonEquals(expPayloadSchema.assignTeamToProject(), jsonString, when(IGNORING_VALUES));

        return jsonString;
    }

    public String updateProject(String projectId) {
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        url=baseURL+"/projects/:projectId";
        entity = new StringEntity(reqPayload.updateProjectPayLoad(), StandardCharsets.UTF_8);
        jsonString=coreService.customPutCall(url.replace(":projectId", projectId), endPointName, entity);

        JsonAssert.assertJsonEquals(expPayloadSchema.updateProject(), jsonString, when(IGNORING_VALUES));

        return jsonString;
    }

    public Boolean roleCreateProject(String projectId) {
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        url=baseURL+"/projects/:projectId/roles";
        entity = new StringEntity(reqPayload.createRolePayLoad(),StandardCharsets.UTF_8);

        jsonString=coreService.customPostCall(url.replace(":projectId", projectId), endPointName, entity);

        JsonAssert.assertJsonEquals(expPayloadSchema.createRole(), jsonString);

        return true; // Returning true as values are also validated in above step.
    }

    public Boolean roleUpdateProject(String projectId) {
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        url=baseURL+"/projects/:projectId";
        entity = new StringEntity(reqPayload.updateRolePayLoad(),StandardCharsets.UTF_8);
        jsonString=coreService.customPatchCall(url.replace(":projectId", projectId), endPointName, entity);

        JsonAssert.assertJsonEquals(expPayloadSchema.updateRole(), jsonString, when(IGNORING_ARRAY_ORDER)); // Ignore the araay the order, but not the values

        return true; // Returning true as values are also validated in above step.
    }

    public BaseOfBase publishProject(String projectId) {
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        url=baseURL+"/projects/:projectId/publish";
        entity = new StringEntity(reqPayload.publishProjectPayLoad(),StandardCharsets.UTF_8);
        jsonString=coreService.customPutCall(url.replace(":projectId", projectId), endPointName, entity);

        JsonAssert.assertJsonEquals(expPayloadSchema.getProject(), jsonString, when(IGNORING_VALUES));

        return gson.fromJson(jsonString, BaseOfBase.class);
    }

    public BaseOfBase unpublishProject(String projectId) {

        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        url=baseURL+"/projects/:projectId/unpublish";
        entity = new StringEntity(reqPayload.publishProjectPayLoad(),StandardCharsets.UTF_8);
        jsonString=coreService.customPutCall(url.replace(":projectId", projectId),endPointName,entity);

        JsonAssert.assertJsonEquals(expPayloadSchema.getProject(), jsonString, when(IGNORING_VALUES));

        return gson.fromJson(jsonString, BaseOfBase.class);
    }

    public BaseOfBase projectMediaRegister(String projectId) {
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        url=baseURL+"/projects/:projectId/media";
        entity = new StringEntity(reqPayload.uploadAssetPayLoad(),StandardCharsets.UTF_8);

        jsonString=coreService.customPostCall(url.replace(":projectId", projectId),endPointName,entity);

        JsonAssert.assertJsonEquals(expPayloadSchema.projectMediaRegister(), jsonString, when(IGNORING_VALUES));

        jsonString = jsonString.substring(1,jsonString.length()-1).replace("status","a4Status");

        return gson.fromJson(jsonString, BaseOfBase.class);
    }

    public Boolean mediaUploadToGdn(String url, String reference) throws IOException {
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();

        HttpPut request = new HttpPut(url);
        //Request payload
        File file = new File(reference);
        FileEntity entity = new FileEntity(file);
        request.setEntity(entity);

        // EXECUTE SERVICE CALL
        CloseableHttpClient httpClient = HttpClientBuilder.create().build();
        HttpResponse response = httpClient.execute(request);

        jsonString = EntityUtils.toString(response.getEntity());

        System.out.println("--- " + endPointName.toUpperCase() + " --- \nRequest Payload: " + reference);

        if (!(response.getStatusLine().getStatusCode() == 200 || response.getStatusLine().getStatusCode() == 201))
            Assert.fail(endPointName.toUpperCase() + ": END-POINT FAILED - due to " + jsonString);
        else
            System.out.println("StatusCode: " + response.getStatusLine().getStatusCode() + "\nResponse Payload: " + jsonString + "\n");

        return true;
    }

    public BaseOfBase projectMediaComplete(String projectId, String fileId, String fileName) {
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        url=baseURL+"/projects/:projectId/media/:fileId";
        entity = new StringEntity(reqPayload.mediaCompletePayLoad(fileName),StandardCharsets.UTF_8);

        jsonString=coreService.customPostCall(url.replace(":projectId/media/:fileId", projectId + "/media/" + fileId), endPointName, entity);

        JsonAssert.assertJsonEquals(expPayloadSchema.projectMediaComplete(), jsonString, when(IGNORING_VALUES));

        return gson.fromJson(jsonString, BaseOfBase.class);
    }

    public String searchProjects() {
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        url=baseURL+"/projects";

        return coreService.customGetCall(url, endPointName);
    }

    public String projects_SearchProjectsTemplates(String xA5Agency) {
        boolean isRequestForAllAgencies=false;
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        url=baseURL+"/projects/templates";
        coreService.setTokenType("agencyAdmin");

        HttpGet request = new HttpGet(url);
        if(!(xA5Agency==null)) {
            request.addHeader("X-A5-Agency", xA5Agency);
            isRequestForAllAgencies=true;
        }

        jsonString=coreService.customGetCall(request, endPointName);
        JsonAssert.assertJsonEquals(expPayloadSchema.projectsSearchProjectsTemplates(isRequestForAllAgencies), jsonString, when(IGNORING_VALUES));

        return jsonString;
    }

    public boolean registerMedia(boolean sizeZero) {
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        url=baseURL+"/media";
        entity = new StringEntity(reqPayload.registerMediaPayLoad(sizeZero),StandardCharsets.UTF_8);

        jsonString=coreService.customPostCall(url,endPointName,entity);

        JsonAssert.assertJsonEquals(expPayloadSchema.mediaUpload(), jsonString, when(IGNORING_VALUES));
        return true;
    }


    public BaseOfBase mediaUpload() {
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        url=baseURL+"/media";
        entity = new StringEntity(reqPayload.uploadAssetPayLoad(),StandardCharsets.UTF_8);

        jsonString=coreService.customPostCall(url,endPointName,entity);

        JsonAssert.assertJsonEquals(expPayloadSchema.mediaUpload(), jsonString, when(IGNORING_VALUES));

        jsonString = jsonString.substring(1,jsonString.length()-1).replace("status","a4Status");
        return gson.fromJson(jsonString, BaseOfBase.class);
    }

    public BaseOfBase mediaUploadWithTokenType(String tokenType){
        coreService.setTokenType(tokenType);
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        url=baseURL+"/media";
        HttpPost request = new HttpPost(url);
        entity = new StringEntity(reqPayload.s3UploadAssetPayLoad(),StandardCharsets.UTF_8);
        request.setEntity(entity);

        jsonString=coreService.customPostCall(request,endPointName,entity);

        JsonAssert.assertJsonEquals(expPayloadSchema.mediaUpload(), jsonString, when(IGNORING_VALUES));

        jsonString = jsonString.substring(1,jsonString.length()-1).replace("status","a4Status");
        return gson.fromJson(jsonString, BaseOfBase.class);

    }

    public Boolean completeMedia(String mediaId) {
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        url=baseURL+"/media/:id";

        return coreService.customPutCallWithoutEntity(url.replace(":id", mediaId), endPointName);
    }

    public Boolean downloadMedia(String elementId, String fileId) {
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        url=baseURL+"/media/:elementId/:fileId";

        jsonString=coreService.customGetCall(url.replace(":elementId/:fileId", elementId + "/" + fileId), endPointName);

        Assert.assertNotNull(jsonString);

        return true;
    }

    public BaseOfBase requestNewUploadSegment(String tokenType,String fileId, int filePartNumber, String s3StorageId , String fileUploadId) {
        endPointName = Thread.currentThread().getStackTrace()[1].getMethodName();
        url=baseURL+"/media/:id/part/:filePartNumber";
        url = url.replace(":id/part/:filePartNumber", fileId + "/part/" + filePartNumber);
        HttpPost request = new HttpPost(url);
        coreService.setTokenType(tokenType);
        entity = new StringEntity(reqPayload.requestNewUploadSegmentPayLoad(s3StorageId,fileUploadId),StandardCharsets.UTF_8);
        request.setEntity(entity);
        jsonString=coreService.customPostCall(request,endPointName,entity);

        JsonAssert.assertJsonEquals(expPayloadSchema.requestNewUploadSegment(), jsonString, when(IGNORING_VALUES));

        return gson.fromJson(jsonString, BaseOfBase.class);

    }

    public Header[] getEtag(String uploadUrl, String assetSegmentPath){

        HttpResponse response = null;
        HttpPut request = new HttpPut(uploadUrl);
            //Request payload
        File file = new File(assetSegmentPath);
        FileEntity entity = new FileEntity(file);
        request.setEntity(entity);
        try {
            // EXECUTE SERVICE CALL
            CloseableHttpClient httpClient = HttpClientBuilder.create().build();
            response = httpClient.execute(request);

            if (!(response.getStatusLine().getStatusCode() == 200 || response.getStatusLine().getStatusCode() == 201))
                Assert.fail(endPointName.toUpperCase() + ": END-POINT FAILED - due to " + jsonString);
            else
                System.out.println("StatusCode: " + response.getStatusLine().getStatusCode() + "\nResponse Payload: " + jsonString + "\n");
        }catch(Exception e){
                e.printStackTrace();

        }

        Assert.assertNotNull(response.getAllHeaders());

        return   response.getAllHeaders();
    }

    public String completeS3Upload_PrepareForIngestion(String fileId,String storageId,String uploadId, String etagValue, int filePartNumber) {
        endPointName = Thread.currentThread().getStackTrace()[1].getMethodName();
        url = baseURL.replace("v2","internal/v1/media/:id/s3/complete").replace(":id", fileId);
        coreService.setTokenType("internalAdmin");
        entity = new StringEntity(reqPayload.completeS3Upload_PrepareForIngestion(storageId,uploadId,etagValue,filePartNumber), StandardCharsets.UTF_8);

        HttpPut request = new HttpPut(url);
        request.setEntity(entity);

        String response =coreService.customPutCall(request,endPointName,entity);

        Assert.assertNotNull(response);

        return response;

    }

    //Overloading
    public String completeS3Upload_PrepareForIngestion(String fileId,String storageId,String uploadId, String[] etagValue, int[] filePartNumber) {
        endPointName = Thread.currentThread().getStackTrace()[1].getMethodName();
        url = baseURL.replace("v2","internal/v1/media/:id/s3/complete").replace(":id", fileId);
        coreService.setTokenType("internalAdmin");
        entity = new StringEntity(reqPayload.completeS3Upload_PrepareForIngestion(storageId,uploadId,etagValue,filePartNumber), StandardCharsets.UTF_8);

        HttpPut request = new HttpPut(url);
        request.setEntity(entity);

        String response =coreService.customPutCall(request,endPointName,entity);

        Assert.assertNotNull(response);

        return response;

    }

    public BaseOfBase projectsFilesCreateAttachments(String fileId, String mediaId, String mediaName, String mediaSize) {
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        url = baseURL + "/files/:id/attachments";
        entity = new StringEntity(reqPayload.assetCreateAttachmentPayload(mediaName, mediaSize, mediaId), StandardCharsets.UTF_8);
        jsonString = coreService.customPostCall(url.replace(":id", fileId),endPointName,entity);

        JsonAssert.assertJsonEquals(expPayloadSchema.assetCreateAttachment(), jsonString, when(IGNORING_VALUES));
        jsonString = jsonString.substring(1,jsonString.length()-1);

        return gson.fromJson(jsonString, BaseOfBase.class);
    }

    public Boolean projectsFilesDeleteFile(String fileId) {
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        url=baseURL+"/files/:fileId";

        return coreService.customDeleteCall(url.replace(":fileId", fileId), endPointName);
    }

    public BaseOfBase projectsFilesEditAttachment(String fileId, String id, String mediaId, String mediaName, String mediaSize) {
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        url=baseURL+"/files/:fileId/attachments/:id";
        entity = new StringEntity(reqPayload.assetEditAttachmentPayLoad(mediaName, mediaSize, mediaId),StandardCharsets.UTF_8);

        jsonString= coreService.customPutCall(url.replace(":fileId/attachments/:id", fileId + "/attachments/" + id), endPointName, entity);
        JsonAssert.assertJsonEquals(expPayloadSchema.assetEditAttachment(), jsonString, when(IGNORING_VALUES));

        return gson.fromJson(jsonString, BaseOfBase.class);
    }

    public Boolean projectsFilesRevision(String fileId, String mediaId,String revisionCount) {
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        url = baseURL + "/files/:fileId/revisions";
        entity = new StringEntity(reqPayload.filesRevisionPayLoad(mediaId),StandardCharsets.UTF_8);

        jsonString=coreService.customPutCall(url.replace(":fileId", fileId), endPointName, entity);

        JsonAssert.assertJsonEquals(expPayloadSchema.projectsFilesRevision(revisionCount), jsonString, when(IGNORING_VALUES));

        return true; // return true as version count is already validated in above step
    }

    public BaseOfBase getFile(String fileId) {
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        url=baseURL+"/files/:fileId";
        jsonString = coreService.customGetCall(url.replace(":fileId", fileId), endPointName);

        JsonAssert.assertJsonEquals(expPayloadSchema.getFile(), jsonString, when(IGNORING_VALUES));
        return gson.fromJson(jsonString, BaseOfBase.class);
    }

    public BaseOfBase projectsFilesListAttachments(String fileId) {
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        url=baseURL + "/files/:id/attachments";

        jsonString = coreService.customGetCall(url.replace(":id", fileId),endPointName);

        JsonAssert.assertJsonEquals(expPayloadSchema.assetCreateAttachment(), jsonString, when(IGNORING_VALUES));

        jsonString = jsonString.substring(1,jsonString.length()-1);
        return gson.fromJson(jsonString, BaseOfBase.class);
    }

    public BaseOfBase projectsFilesUpdateFile(String fileId) {
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        url=baseURL+"/files/:fileId";
        entity = new StringEntity(reqPayload.updateProjectFilePayLoad(),StandardCharsets.UTF_8);
        jsonString=coreService.customPutCall(url.replace(":fileId", fileId), endPointName, entity);

        JsonAssert.assertJsonEquals(expPayloadSchema.updateProjecctFile(), jsonString, when(IGNORING_VALUES));

        return gson.fromJson(jsonString, BaseOfBase.class);
    }

    public BaseOfBase projectFilesEditFile(String fileId, boolean isValidName) {
        endPointName = Thread.currentThread().getStackTrace()[1].getMethodName();
        url = baseURL + "/files/:fileId";
        entity = new StringEntity(reqPayload.editProjectFilePayLoad(isValidName), StandardCharsets.UTF_8);
        jsonString = coreService.customPatchCall(url.replace(":fileId", fileId), endPointName, entity);

        JsonAssert.assertJsonEquals(expPayloadSchema.updateProjecctFile(), jsonString, when(IGNORING_VALUES));

        return gson.fromJson(jsonString, BaseOfBase.class);
    }

    public String projectsFilesSearchFiles(String queryParams) {
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        url=baseURL+"/files" + queryParams;

        jsonString=coreService.customGetCall(url, endPointName);

        Assert.assertNotNull(jsonString);

        return jsonString;
    }

    public BaseOfBase projectsFoldersMediaRegister(String folderId) {
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        url=baseURL + "/folders/:folderId/media";
        entity = new StringEntity(reqPayload.uploadAssetPayLoad(),StandardCharsets.UTF_8);
        jsonString=coreService.customPostCall(url.replace(":folderId", folderId),endPointName,entity);

        JsonAssert.assertJsonEquals(expPayloadSchema.projectMediaRegister(), jsonString, when(IGNORING_VALUES));

        jsonString = jsonString.substring(1, jsonString.length() - 1).replace("status","a4Status");

        return gson.fromJson(jsonString, BaseOfBase.class);
    }

    public BaseOfBase ProjectsFolderMediaComplete(String folderId, String fileName, String fileId) {
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        url=baseURL+"/folders/:folderId/media/:fileId";
        entity = new StringEntity(reqPayload.mediaCompletePayLoad(fileName),StandardCharsets.UTF_8);
        jsonString=coreService.customPostCall(url.replace(":folderId/media/:fileId", folderId + "/media/" + fileId), endPointName, entity);

        JsonAssert.assertJsonEquals(expPayloadSchema.projectsFoldersMediaComplete(), jsonString, when(IGNORING_VALUES));

        return gson.fromJson(jsonString, BaseOfBase.class);
    }

    public Boolean folderRoleCreate(String folderId) {
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        url=baseURL+"/folders/:folderId/roles";
        entity = new StringEntity(reqPayload.createRolePayLoad(),StandardCharsets.UTF_8);
        jsonString=coreService.customPostCall(url.replace(":folderId", folderId),endPointName,entity);

        JsonAssert.assertJsonEquals(expPayloadSchema.folderCreateRole(), jsonString);

        return true; // Returning true as values are also validated in above step.
    }

    public Boolean folderRoleCreate(String userId, String folderId, boolean inheritance) {
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        url=baseURL+"/folders/:folderId/roles";
        entity = new StringEntity(reqPayload.createRolePayLoad(userId, inheritance),StandardCharsets.UTF_8);
        jsonString=coreService.customPostCall(url.replace(":folderId", folderId),endPointName,entity);

        JsonAssert.assertJsonPartEquals(expPayloadSchema.folderCreateRolePart(), jsonString, "[0]", when(IGNORING_VALUES));

        return true;
    }

    public Users[] getFolderRoles(String folderId, boolean recursive) {
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        url=baseURL+"/folders/:folderId/roles";
        if(recursive){
            url = url + "?recursive=true";
        }
        jsonString=coreService.customGetCall(url.replace(":folderId", folderId),endPointName);

        JsonAssert.assertJsonPartEquals(expPayloadSchema.getFolderRole(), jsonString,"[1]", when(IGNORING_EXTRA_FIELDS,IGNORING_VALUES));

        return gson.fromJson(jsonString, Users[].class);
    }

    public BaseOfBase projectFilesCreateACommentForAFile(String comment, String fileId,String revisionId,String answerTo){
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        url=baseURL+"/files/:fileId/comment";
        entity = new StringEntity(reqPayload.projectFilesCreateACommentForAFile(comment, ExpectedData.USERID, revisionId, answerTo),StandardCharsets.UTF_8);
        jsonString=coreService.customPostCall(url.replace(":fileId", fileId),endPointName,entity);

        JsonAssert.assertJsonEquals(expPayloadSchema.projectFilesCreateACommentForAFile(answerTo), jsonString, when(IGNORING_VALUES));

        return gson.fromJson(jsonString, BaseOfBase.class);
    }

    public BaseOfBase projectFilesCreateAPublicShare(String assetId,String xA5Agency,String expiration, String recipients,boolean allowDownloadMaster, boolean allowDownloadProxy,String message){
        boolean isRequestForAllAgencies=false;
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        url = baseURL+"/files/:id/publicshares".replace(":id", assetId);
        coreService.setTokenType("agencyAdmin");

        HttpPost request = new HttpPost(url);
        if(!(xA5Agency==null)) {
            request.addHeader("X-A5-Agency", xA5Agency);
            isRequestForAllAgencies=true;
        }

        // request body method is same for endpoints: presentationsCreateAPublicShare or assetsCreateAPublicShare or projectFilesCreateAPublicShare
        entity = new StringEntity(reqPayload.assetCreateAPublicShare(expiration, recipients, allowDownloadMaster, allowDownloadProxy, message),StandardCharsets.UTF_8);
        request.setEntity(entity);
        jsonString=coreService.customPostCall(request, endPointName, entity);

        JsonAssert.assertJsonEquals(expPayloadSchema.assetCreateAPublicShare(), jsonString, when(IGNORING_VALUES));
        return gson.fromJson(jsonString, BaseOfBase.class);
    }

    public BaseOfBase projectFilesUpdateAPublicShare(String assetId,String xA5Agency,String expiration, boolean allowDownloadMaster,boolean allowDownloadProxy,String message){
        boolean isRequestForAllAgencies=false;
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        url = baseURL+"/files/:id/publicshares".replace(":id", assetId);
        coreService.setTokenType("agencyAdmin");

        HttpPut request = new HttpPut(url);
        if(!(xA5Agency==null)) {
            request.addHeader("X-A5-Agency", xA5Agency);
            isRequestForAllAgencies=true;
        }

        // request body method is same for endpoints: presentationsUpdateAPublicShare or assetsUpdateAPublicShare or projectFilesUpdateAPublicShare
        entity = new StringEntity(reqPayload.assetUpdateAPublicShare(expiration,allowDownloadMaster,allowDownloadProxy,message),StandardCharsets.UTF_8);
        request.setEntity(entity);
        jsonString=coreService.customPutCall(request, endPointName, entity);

        JsonAssert.assertJsonEquals(expPayloadSchema.assetUpdateAPublicShare(), jsonString, when(IGNORING_VALUES));
        return gson.fromJson(jsonString, BaseOfBase.class);
    }

    public String projectFiles_GetFileSharesTest(String fileId) {
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        url=baseURL+"/files/:id/shares".replace(":id",fileId);

        jsonString = coreService.customGetCall(url,endPointName);

        // Response schema for 'assets_GetAssetShares' is same as 'projectFiles_GetFileShares'. So reusing it below for validation.
        JsonAssert.assertJsonEquals(expPayloadSchema.assets_GetAssetShares(), jsonString,when(IGNORING_VALUES));

        return jsonString;
    }

    public String projects_GetAllowedRolesForSharing(String projectId){
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        url=baseURL+"/projects/:projectId/roles/share".replace(":projectId",projectId);
        jsonString= coreService.customGetCall(url,endPointName);

        JsonAssert.assertJsonEquals(expPayloadSchema.projects_GetAllowedRolesForSharing(), jsonString, when(IGNORING_VALUES));

        return jsonString;
    }

    public String projectsFolders_GetAllowedRolesForSharing(String folderId){
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        url=baseURL+"/folders/:folderId/roles/share".replace(":folderId",folderId);
        jsonString= coreService.customGetCall(url, endPointName);

        JsonAssert.assertJsonEquals(expPayloadSchema.projectsFolders_GetAllowedRolesForSharing(), jsonString, when(IGNORING_VALUES));

        return jsonString;
    }

    //</editor-fold>


    //<editor-fold desc="Library">
    public BaseOfBase completeAsset(String fileId, String fileName) {
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        url = baseURL+"/assets/media/:fileId";
        entity = new StringEntity(reqPayload.completeAssetPayLoad(fileName),StandardCharsets.UTF_8);
        jsonString=coreService.customPostCall(url.replace(":fileId", fileId),endPointName,entity);

        JsonAssert.assertJsonEquals(expPayloadSchema.completeAsset(), jsonString, when(IGNORING_VALUES));
        return gson.fromJson(jsonString, BaseOfBase.class);
    }

    public BaseOfBase createAsset() {
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        url = baseURL+"/assets";
        entity = new StringEntity(reqPayload.createAssetPayLoad(),StandardCharsets.UTF_8);
        jsonString = coreService.customPostCall(url, endPointName,entity);

        JsonAssert.assertJsonEquals(expPayloadSchema.createAsset(), jsonString, when(IGNORING_VALUES));
        return gson.fromJson(jsonString, BaseOfBase.class);
    }

    public BaseOfBase uploadAsset() {
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        url=baseURL+"/assets/media";
        entity = new StringEntity(reqPayload.uploadAssetPayLoad(),StandardCharsets.UTF_8);
        jsonString=coreService.customPostCall(url,endPointName,entity);

        JsonAssert.assertJsonEquals(expPayloadSchema.uploadAsset(), jsonString, when(IGNORING_VALUES));
        jsonString = jsonString.substring(1,jsonString.length()-1).replace("status","a4Status");
        return gson.fromJson(jsonString, BaseOfBase.class);
    }

    public BaseOfBase updateAsset(String assetId) {
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        url=baseURL+"/assets/:id";
        entity = new StringEntity(reqPayload.updateAssetPayLoad(),StandardCharsets.UTF_8);
        jsonString = coreService.customPutCall(url.replace(":id", assetId), endPointName,entity);

        JsonAssert.assertJsonEquals(expPayloadSchema.createAsset(), jsonString, when(IGNORING_VALUES));

        return gson.fromJson(jsonString, BaseOfBase.class);
    }

    public BaseOfBase getAsset(String assetId) {
        endPointName = Thread.currentThread().getStackTrace()[1].getMethodName();
        url=baseURL+"/assets/:id";

        jsonString=coreService.customGetCall(url.replace(":id", assetId), endPointName);

        JsonAssert.assertJsonEquals(expPayloadSchema.getAsset(), jsonString, when(IGNORING_VALUES));

        return gson.fromJson(jsonString, BaseOfBase.class);
    }

    public BaseOfBase getQCAsset(String assetId, String status) {
        endPointName = Thread.currentThread().getStackTrace()[1].getMethodName();
        url=baseURL+"/assets/:id";
        coreService.setTokenType("agencyAdmin");
        jsonString=coreService.customGetCall(url.replace(":id", assetId), endPointName);

        if(status.equals("TVC Ingested OK")) {
            //The test fails at this step sometimes due to transcoding problem stating as :
            // JSON documents are different.
            // It will come as above if the asset is not ingested where the status will remain as "status":"Uploading Files" in the response
            JsonAssert.assertJsonEquals(expPayloadSchema.getAssetAfterIngest(),jsonString, when(COMPARING_ONLY_STRUCTURE, IGNORING_ARRAY_ORDER));
        }
        else if(status.equals("New")||status.equals("Uploading Files")){
            JsonAssert.assertJsonEquals(expPayloadSchema.getAssetAfterUpdateStatus(), jsonString, when(IGNORING_VALUES));
        }
        else if(status.equals("Cancelled")){
            JsonAssert.assertJsonEquals(expPayloadSchema.getAssetAfterCancelledStatus(), jsonString, when(IGNORING_VALUES));
        }

        return gson.fromJson(jsonString, BaseOfBase.class);
    }

    public Boolean removeAsset(String assetId) {
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        url=baseURL+"/assets/:id";

        return coreService.customDeleteCall(url.replace(":id", assetId),endPointName);
    }

    public Boolean searchAssets() {
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        url=baseURL+"/assets";
        jsonString=coreService.customGetCall(url,endPointName);

        Assert.assertNotNull(jsonString);

        return true;
    }

    public Boolean searchAssets(String query) {
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        try {
            url=baseURL+"/assets?query="+ URLEncoder.encode(query, "UTF-8");
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
            return false;
        }
        jsonString=coreService.customGetCall(url,endPointName);

        Assert.assertNotNull(jsonString);

        return new JSONArray(jsonString).length() > 0;
    }

    public Boolean searchOrderAssets(String query) {
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        try {
            url=baseURL+"/orders/assets?query="+ URLEncoder.encode(query, "UTF-8");
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
            return false;
        }
        jsonString=coreService.customGetCall(url,endPointName);

        Assert.assertNotNull(jsonString);

        return jsonString.contains(ExpectedData.CLOCKNUMBER);
    }

    public Boolean  searchAssetWithOrder_DESC() {
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        url = baseURL + "/assets";
        jsonString=coreService.customGetCall(url+ "?order=DESC",endPointName);

        Assert.assertNotNull(jsonString);

        return true;
    }

    public BaseOfBase assetCreateAttachment(String assetId, String mediaId, String mediaName, String mediaSize) {
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        url=baseURL+"/assets/:id/attachments";
        entity = new StringEntity(reqPayload.assetCreateAttachmentPayload(mediaName,mediaSize,mediaId),StandardCharsets.UTF_8);
        jsonString=coreService.customPostCall(url.replace(":id", assetId), endPointName, entity);

        JsonAssert.assertJsonEquals(expPayloadSchema.assetCreateAttachment(), jsonString, when(IGNORING_VALUES));
        jsonString = jsonString.substring(1, jsonString.length()-1);

        return gson.fromJson(jsonString, BaseOfBase.class);
    }

    public BaseOfBase assetListAttachments(String assetId) {
        endPointName = Thread.currentThread().getStackTrace()[1].getMethodName();
        url=baseURL+"/assets/:id/attachments";
        jsonString=coreService.customGetCall(url.replace(":id", assetId),endPointName);

        JsonAssert.assertJsonEquals(expPayloadSchema.assetCreateAttachment(), jsonString, when(IGNORING_VALUES));
        jsonString = jsonString.substring(1,jsonString.length()-1);

        return gson.fromJson(jsonString, BaseOfBase.class);
    }

    public BaseOfBase assetEditAttachment(String assetId, String id, String mediaId, String mediaName, String size) {
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        url = baseURL+"/assets/:assetId/attachments/:id";
        entity = new StringEntity(reqPayload.assetEditAttachmentPayLoad(mediaName, size, mediaId),StandardCharsets.UTF_8);
        jsonString=coreService.customPutCall(url.replace(":assetId/attachments/:id", assetId + "/attachments/" + id), endPointName, entity);
        JsonAssert.assertJsonEquals(expPayloadSchema.assetEditAttachment(), jsonString, when(IGNORING_VALUES));

        return gson.fromJson(jsonString, BaseOfBase.class);
    }

    public BaseOfBase createCollection() {
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        url = baseURL +"/collections";
        entity = new StringEntity(reqPayload.createCollectionPayLoad(),StandardCharsets.UTF_8);
        jsonString=coreService.customPostCall(url, endPointName, entity);

        JsonAssert.assertJsonEquals(expPayloadSchema.createCollection(), jsonString, when(IGNORING_VALUES));

        return gson.fromJson(jsonString, BaseOfBase.class);
    }

    public Boolean deleteCollection(String collectionId) {
        endPointName = Thread.currentThread().getStackTrace()[1].getMethodName();
        url = baseURL + "/collections/:id";

        return coreService.customDeleteCall(url.replace(":id", collectionId), endPointName);
    }

    public BaseOfBase updateCollection(String collectionId) {
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        url=baseURL+"/collections/:id";
        entity = new StringEntity(reqPayload.updateCollectionPayLoad(), StandardCharsets.UTF_8);
        jsonString = coreService.customPutCall(url.replace(":id", collectionId),endPointName,entity);

        JsonAssert.assertJsonEquals(expPayloadSchema.createCollection(), jsonString, when(IGNORING_VALUES));

        return gson.fromJson(jsonString, BaseOfBase.class);
    }

    public BaseOfBase shareCollection(String collectionId) {
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        url=baseURL+"/collections/:id/share";
        entity = new StringEntity(reqPayload.shareCollection(),StandardCharsets.UTF_8);

        jsonString=coreService.customPutCall(url.replace(":id", collectionId), endPointName, entity);

        JsonAssert.assertJsonEquals(expPayloadSchema.shareCollectionWithLibaryTeam(), jsonString, when(IGNORING_VALUES));

        return gson.fromJson(jsonString, BaseOfBase.class);
    }

    public String listCollectionAssets(String collectionId) {
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        url=baseURL+"/collections/:id/assets";

        return coreService.customGetCall(url.replace(":id", collectionId), endPointName);
    }

    public BaseOfBase addAssetToCollection(String collectionId, String assetId){
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        url=baseURL+"/collections/:collectionId/assets";
        entity = new StringEntity(reqPayload.addAssetToCollectionPayLoad(assetId),StandardCharsets.UTF_8);

        jsonString= coreService.customPostCall(url.replace(":collectionId", collectionId),endPointName,entity);

        JsonAssert.assertJsonEquals(expPayloadSchema.createCollection(), jsonString, when(IGNORING_VALUES)); // Response payload for create collection and add assets to collection is same, as core doesn't have capability to differentiate

        return gson.fromJson(jsonString, BaseOfBase.class);
    }

    public Boolean removeAssetFromCollection(String collectionId, String assetId) {
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        url=baseURL+"/collections/:collectionId/assets";
        entity = new StringEntity(reqPayload.addAssetToCollectionPayLoad(assetId),StandardCharsets.UTF_8);

        return coreService.customDeleteCallWithBody(url.replace(":collectionId", collectionId), endPointName, entity);
    }

    public String listCollections() {
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        url=baseURL + "/collections";

        return coreService.customGetCall(url, endPointName);
    }

    public BaseOfBase createChildCollection(String collectionId) {
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        url=baseURL+"/collections/:id";
        entity = new StringEntity(reqPayload.createChildCollectionPayLoad(),StandardCharsets.UTF_8);
        jsonString=coreService.customPutCall(url.replace(":id", collectionId), endPointName, entity);

        JsonAssert.assertJsonEquals(expPayloadSchema.createCollection(), jsonString, when(IGNORING_VALUES));

        return gson.fromJson(jsonString, BaseOfBase.class);
    }

    public BaseOfBase createPresentation() {
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        url=baseURL+"/presentations";
        entity = new StringEntity(reqPayload.createPresentationPayLoad(),StandardCharsets.UTF_8);
        jsonString=coreService.customPostCall(url, endPointName, entity);

        JsonAssert.assertJsonEquals(expPayloadSchema.createPresentation(), jsonString, when(IGNORING_VALUES));

        return gson.fromJson(jsonString, BaseOfBase.class);
    }

    public Boolean deletePresentation(String presentationId) {
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        url=baseURL+"/presentations/:id";

        return coreService.customDeleteCall(url.replace(":id", presentationId), endPointName);
    }

    public BaseOfBase getPresentation(String presentationId) {
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        url=baseURL+"/presentations/:id";

        jsonString = coreService.customGetCall(url.replace(":id", presentationId), endPointName);

        JsonAssert.assertJsonEquals(expPayloadSchema.createPresentation(), jsonString, when(IGNORING_VALUES));

        return gson.fromJson(jsonString, BaseOfBase.class);
    }

    public BaseOfBase addPresentationAssets(String presentationId, String assetId) {
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        url=baseURL+"/presentations/:id/assets";
        entity = new StringEntity(reqPayload.addPresentationAssets(assetId),StandardCharsets.UTF_8);
        jsonString=coreService.customPutCall(url.replace(":id", presentationId), endPointName,entity);

        JsonAssert.assertJsonEquals(expPayloadSchema.addPresentationAssets(), jsonString, when(IGNORING_VALUES));

        return gson.fromJson(jsonString, BaseOfBase.class);
    }

    public BaseOfBase addPresentationAssets_WithTwoAssets(String presentationId, String assetId) {
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        url=baseURL+"/presentations/:id/assets";
        entity = new StringEntity(reqPayload.addPresentationAssets(assetId),StandardCharsets.UTF_8);
        jsonString=coreService.customPutCall(url.replace(":id", presentationId), endPointName, entity);

        JsonAssert.assertJsonEquals(expPayloadSchema.addPresentationAssets_WithTwoAssets(), jsonString, when(IGNORING_VALUES));

        return gson.fromJson(jsonString, BaseOfBase.class);
    }

    public BaseOfBase orderPresentationAssets(String presentationId, String... assets) {
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        url=baseURL + "/presentations/:id/assets";
        entity = new StringEntity(reqPayload.orderPresentationAssetsPayLoad(assets),StandardCharsets.UTF_8);
        jsonString = coreService.customPatchCall(url.replace(":id", presentationId),endPointName,entity);

        JsonAssert.assertJsonEquals(expPayloadSchema.addPresentationAssets_WithTwoAssets(), jsonString, when(IGNORING_VALUES));
        return gson.fromJson(jsonString, BaseOfBase.class);
    }

    public Boolean removePresentationAssets(String presentationId, String assetId) {
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        url=baseURL+"/presentations/:id/assets";
        entity = new StringEntity(reqPayload.addPresentationAssets(assetId),StandardCharsets.UTF_8);

        return coreService.customDeleteCallWithBody(url.replace(":id", presentationId),endPointName,entity);
    }

    public String searchPresentation() {
        endPointName = Thread.currentThread().getStackTrace()[1].getMethodName();
        url=baseURL+"/presentations";

        jsonString = coreService.customGetCall(url, endPointName);

        Assert.assertNotNull(jsonString);

        return jsonString;
    }

    public Boolean sharePresentation(String presentationId) {
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        url = baseURL + "/presentations/:id/share";
        entity = new StringEntity(reqPayload.sharePresentationPayLoad(),StandardCharsets.UTF_8);
        jsonString = coreService.customPostCall(url.replace(":id",presentationId),endPointName,entity);

        JsonAssert.assertJsonEquals(expPayloadSchema.sharePresentation(), jsonString);

        return true;
    }

    public Boolean stopSharingPresentation(String presentationId) {
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        url=baseURL+"/presentations/:id/share";
        entity = new StringEntity(reqPayload.stopSharingPresentation(),StandardCharsets.UTF_8);

        return coreService.customDeleteCallWithBody(url.replace(":id",presentationId),endPointName,entity);
    }

    public BaseOfBase assetCreateAPublicShare(String assetId,String xA5Agency,String expiration, String recipients,boolean allowDownloadMaster, boolean allowDownloadProxy,String message){
        boolean isRequestForAllAgencies=false;
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        url = baseURL+"/assets/:id/publicshares".replace(":id", assetId);
        coreService.setTokenType("agencyAdmin");

        HttpPost request = new HttpPost(url);
        if(!(xA5Agency==null)) {
            request.addHeader("X-A5-Agency", xA5Agency);
            isRequestForAllAgencies=true;
        }

        entity = new StringEntity(reqPayload.assetCreateAPublicShare(expiration,recipients,allowDownloadMaster,allowDownloadProxy,message),StandardCharsets.UTF_8);
        request.setEntity(entity);
        jsonString=coreService.customPostCall(request,endPointName,entity);

        JsonAssert.assertJsonEquals(expPayloadSchema.assetCreateAPublicShare(), jsonString, when(IGNORING_VALUES));
        return gson.fromJson(jsonString, BaseOfBase.class);
    }

    public BaseOfBase assetUpdateAPublicShare(String assetId,String xA5Agency,String expiration, boolean allowDownloadMaster,boolean allowDownloadProxy,String message){
        boolean isRequestForAllAgencies=false;
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        url = baseURL+"/assets/:id/publicshares".replace(":id", assetId);
        coreService.setTokenType("agencyAdmin");

        HttpPut request = new HttpPut(url);
        if(!(xA5Agency==null)) {
            request.addHeader("X-A5-Agency", xA5Agency);
            isRequestForAllAgencies=true;
        }

        entity = new StringEntity(reqPayload.assetUpdateAPublicShare(expiration,allowDownloadMaster,allowDownloadProxy,message),StandardCharsets.UTF_8);
        request.setEntity(entity);
        jsonString=coreService.customPutCall(request,endPointName,entity);

        JsonAssert.assertJsonEquals(expPayloadSchema.assetUpdateAPublicShare(), jsonString, when(IGNORING_VALUES));
        return gson.fromJson(jsonString, BaseOfBase.class);
    }

    public BaseOfBase presentationsCreateAPublicShare(String assetId,String xA5Agency,String expiration, String recipients,boolean allowDownloadMaster, boolean allowDownloadProxy,String message){
        boolean isRequestForAllAgencies=false;
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        url = baseURL+"/presentations/:id/publicshares".replace(":id", assetId);
        coreService.setTokenType("agencyAdmin");

        HttpPost request = new HttpPost(url);
        if(!(xA5Agency==null)) {
            request.addHeader("X-A5-Agency", xA5Agency);
            isRequestForAllAgencies=true;
        }

        // request body method is same for endpoints: presentationsCreateAPublicShare or assetsCreateAPublicShare
        entity = new StringEntity(reqPayload.assetCreateAPublicShare(expiration,recipients,allowDownloadMaster,allowDownloadProxy,message),StandardCharsets.UTF_8);
        request.setEntity(entity);
        jsonString=coreService.customPostCall(request,endPointName,entity);

        JsonAssert.assertJsonEquals(expPayloadSchema.assetCreateAPublicShare(), jsonString, when(IGNORING_VALUES));
        return gson.fromJson(jsonString, BaseOfBase.class);
    }

    public BaseOfBase presentationsUpdateAPublicShare(String assetId,String xA5Agency,String expiration, boolean allowDownloadMaster,boolean allowDownloadProxy,String message){
        boolean isRequestForAllAgencies=false;
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        url = baseURL+"/presentations/:id/publicshares".replace(":id", assetId);
        coreService.setTokenType("agencyAdmin");

        HttpPut request = new HttpPut(url);
        if(!(xA5Agency==null)) {
            request.addHeader("X-A5-Agency", xA5Agency);
            isRequestForAllAgencies=true;
        }

        // request body method is same for endpoints: presentationsUpdateAPublicShare or assetsUpdateAPublicShare
        entity = new StringEntity(reqPayload.assetUpdateAPublicShare(expiration,allowDownloadMaster,allowDownloadProxy,message),StandardCharsets.UTF_8);
        request.setEntity(entity);
        jsonString=coreService.customPutCall(request,endPointName,entity);

        JsonAssert.assertJsonEquals(expPayloadSchema.assetUpdateAPublicShare(), jsonString, when(IGNORING_VALUES));
        return gson.fromJson(jsonString, BaseOfBase.class);
    }


    public String assets_GetAssetShares(String assetId) {
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        url=baseURL+"/assets/:id/shares".replace(":id",assetId);

        jsonString = coreService.customGetCall(url,endPointName);
        JsonAssert.assertJsonEquals(expPayloadSchema.assets_GetAssetShares(), jsonString,when(IGNORING_VALUES));
        return jsonString;
    }
    //</editor-fold>


    //<editor-fold desc="RELATIONS">
    public Boolean listRelationTypes() {
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        url=baseURL+"/relations/types";
        jsonString=coreService.customGetCall(url,endPointName);

        Assert.assertNotNull(jsonString);
        Assert.assertTrue(jsonString.contains(ExpectedData.RELATION_TYPE_ID));

        return true;
    }

    public BaseOfBase getRelated(String fileId ) {
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        url=baseURL+"/relations/:id";
        jsonString=coreService.customGetCall(url.replace(":id", fileId ),endPointName);

        JsonAssert.assertJsonEquals(expPayloadSchema.getRelated(), jsonString, when(IGNORING_VALUES));

        return gson.fromJson(jsonString, BaseOfBase.class);
    }

    public BaseOfBase createRelation(String parentFileId,String childFileId) {
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        url=baseURL+"/relations";
        entity = new StringEntity(reqPayload.createRelationPayLoad(parentFileId,childFileId), StandardCharsets.UTF_8);
        jsonString = coreService.customPostCall(url, endPointName, entity);

        JsonAssert.assertJsonEquals(expPayloadSchema.createRelation(), jsonString, when(IGNORING_VALUES));

        String[] jsonTempString = jsonString.substring(9,jsonString.length()-2).split("\"list\":");
        jsonString=jsonTempString[1].substring(1,jsonTempString[1].length()-2);

        return gson.fromJson(jsonString, BaseOfBase.class);
    }

    public Boolean deleteRelation(String relationId ) {
        endPointName = Thread.currentThread().getStackTrace()[1].getMethodName();
        url=baseURL+"/relations/:id";

        return coreService.customDeleteCall(url.replace(":id", relationId), endPointName);
    }
    //</editor-fold>


    //<editor-fold desc="USAGE RIGHTS">
    public BaseOfBase updateUsageRights(String type, String id) {
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        url = baseURL+"/:type/:id/rights";
        entity = new StringEntity(reqPayload.updateUsageRightsPayLoad(), StandardCharsets.UTF_8);
        jsonString = coreService.customPutCall(url.replace(":type/:id/rights", type + "/" + id +"/rights"),
                endPointName,entity);

        JsonAssert.assertJsonEquals(expPayloadSchema.updateUsageRightsPayLoad(), jsonString, when(IGNORING_VALUES));
        return gson.fromJson(jsonString, BaseOfBase.class);
    }

    public BaseOfBase getUsageRights(String type, String id) {
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        url = baseURL+"/:type/:id/rights";
        jsonString = coreService.customGetCall(url.replace(":type/:id/rights", type + "/" + id + "/rights"), endPointName);

        JsonAssert.assertJsonEquals(expPayloadSchema.updateUsageRightsPayLoad(), jsonString, when(IGNORING_VALUES));
        return gson.fromJson(jsonString, BaseOfBase.class);
    }

    public Boolean deleteUsageRights(String type, String id) {
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        url = baseURL + "/:type/:id/rights";

        return coreService.customDeleteCall(url.replace(":type/:id/rights", type + "/" + id + "/rights"), endPointName);
    }
    //</editor-fold>


    //<editor-fold desc="Misc">
    public String projectsApprovals_ListApprovals(String type) {
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        url=baseURL+"/approvals?type="+type;

        jsonString=coreService.customGetCall(url,endPointName);
        JsonAssert.assertJsonEquals(expPayloadSchema.getApprovalsList(type), jsonString, when(IGNORING_VALUES, IGNORING_EXTRA_ARRAY_ITEMS));
        return jsonString;
    }

    public BaseOfBase submitApprovals(String approvalId , String stageId) {
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        url=baseURL+"/approvals/:id/stage/:stageId";
        entity = new StringEntity(reqPayload.submitApprovalsPayLoad(),StandardCharsets.UTF_8);
        jsonString=coreService.customPutCall(url.replace(":id/stage/:stageId", approvalId + "/stage/" + stageId), endPointName, entity);

        JsonAssert.assertJsonEquals(expPayloadSchema.createProjectFile(), jsonString, when(IGNORING_VALUES));

        return gson.fromJson(jsonString, BaseOfBase.class);
    }

    public BaseOfBase getCurrentUser() {
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        url = baseURL + "/auth/user";
        jsonString = coreService.customGetCall(url,endPointName);
        JsonAssert.assertJsonEquals(expPayloadSchema.getCurrentUser(), jsonString, when(IGNORING_VALUES));

        return gson.fromJson(jsonString, BaseOfBase.class);
    }

    public BaseOfBase getUserInfo(String userId) {
        endPointName = Thread.currentThread().getStackTrace()[1].getMethodName();
        url = baseURL+"/users/:userId";
        jsonString = coreService.customGetCall(url.replace(":userId" , userId),endPointName);
        JsonAssert.assertJsonEquals(expPayloadSchema.getCurrentUser(), jsonString, when(IGNORING_VALUES));

        return gson.fromJson(jsonString, BaseOfBase.class);
    }

    public BaseOfBase[] searchTeams() {
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        url = baseURL+"/teams";
        jsonString = coreService.customGetCall(url,endPointName);

        Assert.assertNotNull(jsonString);
        return gson.fromJson(jsonString, BaseOfBase[].class);
    }

    public BaseOfBase[] searchTeamsByParameters(String searchType, String sortBy, String teamType, String query, int page, int size, String order) {
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        url = baseURL+"/teams";
        String addToURL = null;

        switch (searchType) {
            case "onlyTeamType": addToURL = "?teamType="+teamType;
                break;
            case "onlyPagination": addToURL = "?teamType="+teamType+"&page="+page+"&size="+size;
                break;
            case "sorting":  addToURL = "?sort="+sortBy+"&teamType="+teamType+"&order="+order;
                break;
            case "query&pagination": addToURL = "?teamType="+teamType+"&query="+query+"&page="+page+"&size="+size;
                break;
            case "onlyQuery": addToURL = "?teamType="+teamType+"&query="+query;
                break;
            case "withAllParameters": addToURL = "?sort="+sortBy+"&teamType="+teamType+"&query="+query+"&page="+page+"&size="+size+"&order="+order;
                break;
            default: addToURL ="";
                break;

        }

        jsonString = coreService.customGetCall(url.concat(addToURL),endPointName);

        Assert.assertNotNull(jsonString);
        return gson.fromJson(jsonString, BaseOfBase[].class);
    }

    public BaseOfBase createATeam(String name, String teamType) {
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        url = baseURL+"/teams";
        entity = new StringEntity(reqPayload.createATeam(name,teamType),StandardCharsets.UTF_8);
        jsonString=coreService.customPostCall(url,endPointName,entity);

        if(teamType.equals("project"))
            JsonAssert.assertJsonEquals(expPayloadSchema.createAPublicProjectTeamTemplate(), jsonString, when(IGNORING_VALUES));
        else if(teamType.equals("library"))
            JsonAssert.assertJsonEquals(expPayloadSchema.createALibraryTeam(), jsonString, when(IGNORING_VALUES));

        return gson.fromJson(jsonString, BaseOfBase.class);
    }

    public Boolean deleteATeam(String teamId, String teamType) {

        endPointName = Thread.currentThread().getStackTrace()[1].getMethodName();
        url = baseURL + "/teams/:teamId";
        entity = new StringEntity(reqPayload.deleteATeam(teamType),StandardCharsets.UTF_8);

        return coreService.customDeleteCallWithBody(url.replace(":teamId", teamId ),endPointName,entity);
    }

    public Boolean getEnvironmentDetails(){
        url = baseURL + "/status";
        coreService.setTokenType("agencyAdmin");
        return coreService.customGetCall(url);
    }

    public Boolean searchRoles() {
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        url=baseURL+"/roles";
        jsonString = coreService.customGetCall(url,endPointName);
        JsonAssert.assertJsonEquals(expPayloadSchema.SearchRoles(), jsonString, when(IGNORING_ARRAY_ORDER));

        return true;
    }

    public Boolean addUserToTeam(String userId, String teamId, String roleId, String teamType){
        endPointName = Thread.currentThread().getStackTrace()[1].getMethodName();
        url=baseURL+"/teams/:teamId/users/:userId";
        entity = new StringEntity(reqPayload.addUserToTeam(roleId,teamType),StandardCharsets.UTF_8);

        return coreService.customPutCallWithoutResponse(url.replace(":teamId/users/:userId", teamId + "/users/" + userId ),endPointName,entity);
    }

    public Boolean deleteUserFromATeam(String teamId, String userId, String teamType){
        endPointName = Thread.currentThread().getStackTrace()[1].getMethodName();
        url = baseURL+"/teams/:teamId/users/:userId";
        entity = new StringEntity(reqPayload.deleteUserFromATeam(teamType),StandardCharsets.UTF_8);

        return coreService.customDeleteCallWithBody(url.replace(":teamId/users/:userId", teamId + "/users/" + userId),endPointName,entity);
    }

    public Boolean getLogo() {
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        url=baseURL+"/logos/:id";
        jsonString = coreService.customGetCall(url.replace(":id", ExpectedData.PROJECT_LOGO_ENTITY_ID),endPointName);

        Assert.assertNotNull(jsonString, endPointName.toUpperCase() + ": Check end point response");
        return true;
    }

    public Boolean getUserAgencies() {
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        url = baseURL+"/agencies";
        jsonString = coreService.customGetCall(url,endPointName);

        // Not validating response payload structure as it changing from ENV to ENV. So just validating the Status Code is 200
        // JsonAssert.assertJsonEquals(expPayloadSchema.getUserAgencies(), jsonString, when(IGNORING_VALUES));

        Assert.assertNotNull(jsonString, endPointName.toUpperCase() + ": Check the response");
        return true;
    }
    //</editor-fold>

    // For future use
    public BaseOfBase addDestinationItems_WithAsset(String orderId, String itemId) {
        endPointName=Thread.currentThread().getStackTrace()[1].getMethodName();
        url = baseURL+"/orders/:orderId/items/:itemId/destinations";
        entity = new StringEntity(reqPayload.addDestinationItemsPayLoad(),StandardCharsets.UTF_8);
        jsonString = coreService.customPostCall(url.replace(":orderId/items/:itemId/destinations",
                orderId + "/items/" + itemId + "/destinations"),endPointName,entity);

        JsonAssert.assertJsonEquals(expPayloadSchema.addDestinationItems_WithAsset(), jsonString, when(IGNORING_VALUES));
        return gson.fromJson(jsonString, BaseOfBase.class);
    }

    //<editor-fold desc="INTERNAL ENDPOINTS">
    public BaseOfBase createInternalOrder() {
        endPointName = Thread.currentThread().getStackTrace()[1].getMethodName();
        url = baseURL.replace("v2", "internal/v1/orders");
        coreService.setTokenType("internalAdmin");
        String trafficManagerUserID = BaseTests.getProp().getProperty("TrafficManagerUserID");
        entity = new StringEntity(reqPayload.createInternalOrderPayLoad(trafficManagerUserID),StandardCharsets.UTF_8);
        jsonString = coreService.customPostCall(url,endPointName,entity);

        JsonAssert.assertJsonEquals(expPayloadSchema.createOrder(), jsonString, when(IGNORING_VALUES));

        return gson.fromJson(jsonString, BaseOfBase.class);
    }

    public Storage getStorageForAnAgency(String agencyId) {
        endPointName = Thread.currentThread().getStackTrace()[1].getMethodName();
        url = baseURL.replace("v2", "internal/v1/agencies/:agencyId/storage").replace(":agencyId", agencyId);
        coreService.setTokenType("internalAdmin");
        jsonString = coreService.customGetCall(url,endPointName);

        JsonAssert.assertJsonEquals(expPayloadSchema.getStorage(), jsonString, when(IGNORING_VALUES));

        return gson.fromJson(jsonString, Storage.class);
    }

    public BaseOfBase projectCreateApproval(String mediaId, String fileId, String revisionId,String shortId,String projectId,String projectName,String folderId) {
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        url=baseURL+"/approvals/:fileId/media/:mediaId";
        entity = new StringEntity(reqPayload.createProjectApproval(revisionId, shortId, projectId, projectName, folderId),StandardCharsets.UTF_8);
        jsonString=coreService.customPostCall(url.replace(":fileId/media/:mediaId", fileId + "/media/" + mediaId), endPointName, entity);
        JsonAssert.assertJsonEquals(expPayloadSchema.projectCreateApproval(), jsonString, when(IGNORING_VALUES));
        return gson.fromJson(jsonString, BaseOfBase.class);

    }


    public BaseOfBase projectGetApproval(String mediaId, String fileId) {
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        url=baseURL+"/approvals/:fileId/media/:mediaId";
        jsonString=coreService.customGetCall(url.replace(":fileId/media/:mediaId", fileId + "/media/" + mediaId), endPointName);
        //using the schema of projectCreateApproval as there is no schema difference for both projectCreateApproval and projectGetApproval
        JsonAssert.assertJsonEquals(expPayloadSchema.projectCreateApproval(), jsonString, when(IGNORING_VALUES));
        return gson.fromJson(jsonString, BaseOfBase.class);

    }


    public boolean projectDeleteApproval(String mediaId, String fileId,String approvalId) {
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        url=baseURL+"/approvals/:approvalId";
        entity = new StringEntity(reqPayload.projectDeleteApproval(mediaId, fileId), StandardCharsets.UTF_8);
        return coreService.customDeleteCallWithBody(url.replace(":approvalId", approvalId), endPointName, entity);

    }

    public BaseOfBase projectCreateApprovalStage(String approvalId,boolean withDeadLineDate, String approvalType) {
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        url=baseURL+"/approvals/:approvalId/stages";
        entity = new StringEntity(reqPayload.projectCreateApprovalStage(withDeadLineDate,approvalType),StandardCharsets.UTF_8);
        jsonString=coreService.customPostCall(url.replace(":approvalId", approvalId),endPointName,entity);
        JsonAssert.assertJsonEquals(expPayloadSchema.projectCreateApprovalStage(withDeadLineDate), jsonString, when(IGNORING_EXTRA_FIELDS,IGNORING_VALUES));
        return gson.fromJson(jsonString, BaseOfBase.class);
    }

    public BaseOfBase projectStartApproval(String mediaId, String fileId,String approvalId) {
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        url=baseURL+"/approvals/:approvalId";
        entity = new StringEntity(reqPayload.projectStartApproval(mediaId, fileId), StandardCharsets.UTF_8);
        jsonString=coreService.customPutCall(url.replace(":approvalId", approvalId), endPointName, entity);
        JsonAssert.assertJsonEquals(expPayloadSchema.projectStartApproval(), jsonString, when(IGNORING_EXTRA_FIELDS,IGNORING_VALUES));
        return gson.fromJson(jsonString, BaseOfBase.class);
    }


    public BaseOfBase projectSubmitApproval(String approvalId, String stageId,String status) {
        endPointName = Thread.currentThread().getStackTrace()[1].getMethodName();
        url=baseURL+"/approvals/:approvalId/stage/:stageId";
        entity = new StringEntity(reqPayload.projectSubmitApproval(status), StandardCharsets.UTF_8);
        jsonString=coreService.customPutCall(url.replace(":approvalId/stage/:stageId", approvalId + "/stage/" + stageId),endPointName,entity);
        JsonAssert.assertJsonEquals(expPayloadSchema.projectSubmitApproval(status), jsonString, when(IGNORING_EXTRA_FIELDS,IGNORING_VALUES));
        return gson.fromJson(jsonString, BaseOfBase.class);
    }


    public BaseOfBase projectGetApprovalStage(String approvalId, String stageId,boolean withDeadLineDate) {
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        url=baseURL+"/approvals/:approvalId/stages/:stageId";
        jsonString=coreService.customGetCall(url.replace(":approvalId/stages/:stageId", approvalId + "/stages/" + stageId), endPointName);
        //using the schema of projectCreateApprovalStage as there is no schema difference for both projectCreateApprovalStage and projectGetApprovalStage
        JsonAssert.assertJsonEquals(expPayloadSchema.projectCreateApprovalStage(false), jsonString, when(IGNORING_EXTRA_FIELDS,IGNORING_VALUES));
        return gson.fromJson(jsonString, BaseOfBase.class);

    }

    public Boolean projectDeleteApprovalStage(String approvalId, String stageId) {
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        url=baseURL+"/approvals/:approvalId/stages/:stageId";
        return coreService.customDeleteCall(url.replace(":approvalId/stages/:stageId", approvalId + "/stages/" + stageId), endPointName);
    }



    public BaseOfBase projectUpdateApprovalStage(String approvalId, String stageId,boolean withDeadLineDate) {
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        url=baseURL+"/approvals/:approvalId/stages/:stageId";
        entity = new StringEntity(reqPayload.projectUpdateApprovalStage(), StandardCharsets.UTF_8);
        jsonString=coreService.customPutCall(url.replace(":approvalId/stages/:stageId", approvalId + "/stages/" + stageId), endPointName, entity);
        //using the schema of projectCreateApprovalStage as there is no schema difference for both projectCreateApprovalStage and projectUpdateApprovalStage
        JsonAssert.assertJsonEquals(expPayloadSchema.projectCreateApprovalStage(withDeadLineDate), jsonString, when(IGNORING_EXTRA_FIELDS,IGNORING_VALUES));
        return gson.fromJson(jsonString, BaseOfBase.class);
    }

    public BaseOfBase assetsIngestGDN_RegisterAFileInGDN(String payload) {
        org.json.JSONObject registerJobResponse=null;
        try {
            endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
            url = baseURL.replace("v2", "internal/v1/ingest/register");
            coreService.setTokenType("internalAdmin");

            URI uri = new URIBuilder(url)
                    .addParameter("payload",payload)
                    .build();

            jsonString = coreService.customPostCall_WithOutRequestPayload(uri, endPointName);
            registerJobResponse = XML.toJSONObject(jsonString);

            // Note Response payload schema not validated as it's in XML format
        }catch (Exception e){

        }

        return gson.fromJson(registerJobResponse.toString(), BaseOfBase.class);
    }

    public Traffic[] assetsIngest_FindAssetIngestItems(String qcAssetId){
        try {
            endPointName = Thread.currentThread().getStackTrace()[1].getMethodName();
            url = baseURL.replace("v2", "internal/v1/ingest");
            coreService.setTokenType("internalAdmin");

            HttpGet request = new HttpGet(url);

            URI uri = new URIBuilder(request.getURI()).addParameter("query",
                    "{terms:{\"asset._id\":[\"" + qcAssetId + "\"]}}").build();
            request.setURI(uri);

            jsonString = coreService.customGetCall(request, endPointName);
            JsonAssert.assertJsonEquals(expPayloadSchema.assetsIngest_FindAssetIngestItems(), jsonString, when(IGNORING_VALUES));

        } catch (Exception e){
            Assert.fail(e.getMessage());
        }
        return gson.fromJson(jsonString, Traffic[].class);
    }

    public Traffic assetsIngest_UpdateIngest(Traffic[] response, String status,String fileSize,String fileId){
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        url = baseURL.replace("v2", "internal/v1/ingest/:ingestId").replace(":ingestId", response[0].get_id());
        coreService.setTokenType("internalAdmin");

        entity = new StringEntity(reqPayload.assetsIngest_UpdateIngest(response,status,fileSize,fileId),StandardCharsets.UTF_8);

        HttpPut request = new HttpPut(url);
        request.setEntity(entity);

        jsonString = coreService.customPutCall(request, endPointName, entity);
        JsonAssert.assertJsonEquals(expPayloadSchema.assetsIngest_UpdateIngest(), jsonString, when(IGNORING_VALUES));

        return gson.fromJson(jsonString, Traffic.class);
    }
    //</editor-fold>

    public String  assetsIngest_UpdateAssetStatus(String assetId, String status){
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        url = baseURL.replace("v2", "internal/v1/assets/:id/status").replace(":id", assetId);
        coreService.setTokenType("internalAdmin");

        entity = new StringEntity(reqPayload.updateAssetStatus(status),StandardCharsets.UTF_8);

        jsonString = coreService.customPutCall(url,endPointName, entity);
        Assert.assertNotNull(jsonString);

        return jsonString;
    }

    //<editor-fold desc="FOR FUTURE: Passing parameters from Tests">
    public BaseOfBase createOrder(String market, String marketCountry, String marketId, String userMail){
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        url = baseURL+"/orders";
        coreService.setTokenType("admin");
        entity = new StringEntity(reqPayload.createOrderPayLoad(market,marketCountry,marketId),StandardCharsets.UTF_8);
        jsonString = coreService.customPostCall(url, endPointName, entity, userMail);

        JsonAssert.assertJsonEquals(expPayloadSchema.createOrder(), jsonString, when(IGNORING_VALUES));

        return gson.fromJson(jsonString, BaseOfBase.class);
    }

    public BaseOfBase createItem(String orderId,String market, String marketCountry, String marketId){
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        url = baseURL+"/orders/:orderId/items";
        coreService.setTokenType("agencyAdmin");
        entity = new StringEntity(reqPayload.createItemPayLoad(market, marketCountry, marketId),StandardCharsets.UTF_8);
        jsonString = coreService.customPostCall(url.replace(":orderId/items", orderId + "/items"),
                endPointName, entity);

        JsonAssert.assertJsonEquals(expPayloadSchema.createItem("GEMA_1474908737200","motivnummer"), jsonString, when(IGNORING_VALUES));
        return gson.fromJson(jsonString, BaseOfBase.class);
    }

    public BaseOfBase createItem(String orderId,String market, String marketCountry, String marketId, String duration, String userMail){
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        url = baseURL+"/orders/:orderId/items";
        coreService.setTokenType("admin");
        entity = new StringEntity(reqPayload.createItemPayLoad(market, marketCountry, marketId, duration),StandardCharsets.UTF_8);
        jsonString = coreService.customPostCall(url.replace(":orderId/items", orderId + "/items"),
                endPointName, entity, userMail);
        JsonAssert.assertJsonEquals(expPayloadSchema.createItem(duration), jsonString, when(IGNORING_VALUES));

        return gson.fromJson(jsonString, BaseOfBase.class);
    }

    public BaseOfBase addDestinationItems(String orderId, String itemId, String destinationId, String serviceLevel){
        endPointName=Thread.currentThread().getStackTrace()[1].getMethodName();
        url = baseURL+"/orders/:orderId/items/:itemId/destinations";
        coreService.setTokenType("agencyAdmin");
        entity = new StringEntity(reqPayload.addDestinationItemsPayLoad(destinationId,serviceLevel),StandardCharsets.UTF_8);
        jsonString = coreService.customPostCall(url.replace(":orderId/items/:itemId/destinations",
                orderId + "/items/" + itemId + "/destinations"), endPointName, entity);

        JsonAssert.assertJsonEquals(expPayloadSchema.addDestinationItems("gema","motivnummer"), jsonString, when(IGNORING_VALUES));
        return gson.fromJson(jsonString, BaseOfBase.class);
    }


    public List<Contact> addContact() {
        endPointName = Thread.currentThread().getStackTrace()[1].getMethodName();
        url = baseURL + "/contacts";
        entity = new StringEntity(reqPayload.addContactPayLoad(), StandardCharsets.UTF_8);
        jsonString = coreService.customPostCall(url, endPointName, entity);

        JsonAssert.assertJsonEquals(expPayloadSchema.addContact(), jsonString, when(IGNORING_VALUES));
        Type contactListType = new TypeToken<ArrayList<Contact>>() {
        }.getType();
        List<Contact> contacts = gson.fromJson(jsonString, contactListType);
        return contacts;
    }

    public List<Contact> searchContact() {
        endPointName = Thread.currentThread().getStackTrace()[1].getMethodName();
        url = baseURL + "/contacts";

        jsonString = coreService.customGetCall(url, endPointName);

        Type contactListType = new TypeToken<ArrayList<Contact>>() {
        }.getType();
        List<Contact> contacts = gson.fromJson(jsonString, contactListType);
        return contacts;
    }

    public Contact deleteContact(String contactId) {
        endPointName = Thread.currentThread().getStackTrace()[1].getMethodName();
        url = baseURL + "/contacts/:contactId";
        jsonString = coreService.customDeleteCallWithResponse(url.replace(":contactId", contactId), endPointName);

        JsonAssert.assertJsonEquals(expPayloadSchema.deleteContact(), jsonString, when(IGNORING_VALUES));
        return gson.fromJson(jsonString, Contact.class);
    }

    public String removea4IdFromExpectedResponse(String expectedResponse){
        int a4IdIndex = expectedResponse.indexOf("a4Id");
        String expectedWithNoa4Id = expectedResponse.substring(0,a4IdIndex-1);
        expectedWithNoa4Id = expectedWithNoa4Id.concat(expectedResponse.substring(a4IdIndex+13,expectedResponse.length()));
        return expectedWithNoa4Id;
    }

    //</editor-fold>

    public String getQcAssetIdForConfirmedOrders(String orderId) {
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        url = baseURL+"/orders/:orderId";
        jsonString = coreService.customGetCall(url.replace(":orderId", orderId),
                endPointName);

        return ResponseParser.getQCAssetId(jsonString);
    }

    public String generateSpotId(String orderId, String orderItemId, boolean isRequestValid, String userMail) {
        endPointName =Thread.currentThread().getStackTrace()[1].getMethodName();
        url=baseURL+"/orders/:orderId/items/:orderItemId/spotgate";
        coreService.setTokenType("admin");
        jsonString=coreService.customGetCall(url.replace(":orderId/items/:orderItemId", orderId + "/items/" + orderItemId), endPointName, !isRequestValid, userMail);
        if(isRequestValid)
            JsonAssert.assertJsonEquals(expPayloadSchema.generateSpotId(), jsonString, when(IGNORING_VALUES));
        return jsonString;
    }

    public boolean getRawSchemaForGroupAdkitAndTypeAgency() {
        endPointName = Thread.currentThread().getStackTrace()[1].getMethodName();
        url = baseURL.replace("v2", "internal/v1/schemas/groups/:group?type=agency").replace(":group", "adkit");
        coreService.setTokenType("internalAdmin");
        jsonString = coreService.customGetCall(url,endPointName);

        JsonAssert.assertJsonEquals(expPayloadSchema.getSchemasForAdkitGroupAndTypeAgency(), jsonString, when(IGNORING_VALUES));

        return true;
    }

    public boolean getRawSchemaForGroupAssetElementProjectCommonAndTypeAgency() {
        endPointName = Thread.currentThread().getStackTrace()[1].getMethodName();
        url = baseURL.replace("v2", "internal/v1/schemas/groups/:group?type=agency").replace(":group", "asset_element_project_common");
        coreService.setTokenType("internalAdmin");
        jsonString = coreService.customGetCall(url,endPointName);

        JsonAssert.assertJsonEquals(expPayloadSchema.getSchemasForAsetElementProjectCommonGroupAndTypeAgency(), jsonString, when(IGNORING_VALUES));

        return true;
    }
}
