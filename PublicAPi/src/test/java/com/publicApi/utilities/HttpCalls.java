package com.publicApi.utilities;

import com.publicApi.jsonPayLoads.ExpectedData;
import org.apache.http.Header;
import org.apache.http.HttpResponse;
import org.apache.http.client.methods.*;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.util.EntityUtils;
import org.testng.Assert;

import java.io.IOException;
import java.net.URI;
import java.nio.charset.StandardCharsets;

/**
 * Created by Raja.Gone on 27/07/2016.
 */
public class HttpCalls {

    private TokenGenerator tg;
    private HttpResponse response;
    private String jsonString;
    private String tokenType = "agencyAdmin"; // agencyAdmin || broadcastManager || trafficManager || approval || internalAdmin

    public HttpCalls() throws IOException {
        tg = new TokenGenerator();
    }

    private String getToken() {
        return getTokenType().equals("admin") ? tg.getToken(getTokenType()) :
                getTokenType().equals("agencyAdmin") ? tg.getToken(getTokenType()) :
                    getTokenType().equals("broadcastManager") ? tg.getToken(getTokenType()) :
                        getTokenType().equals("trafficManager") ? tg.getToken(getTokenType()) :
                                getTokenType().equals("approval") ? tg.getToken(getTokenType()) :
                                        getTokenType().equals("s3StorageAdmin") ? tg.getToken(getTokenType()) :
                                                    getTokenType().equals("internalAdmin") ? tg.getToken(getTokenType()) : "Confirm for whom token to generate";
    }

    public String getTokenType() {
        return tokenType;
    }

    public void setTokenType(String tokenType) {
        this.tokenType = tokenType;
    }

    public String  customPostCall(String url, String endPoint, StringEntity requestPayload) {
        HttpPost request = new HttpPost(url);
        request.addHeader("X-A5-Impersonate", ExpectedData.USEREMAIL);
        request.setEntity(requestPayload);
        executeEndpoint(request, endPoint, requestPayload);
        return jsonString;
    }

    public String   customPostCall(String url, String endPoint, StringEntity requestPayload, String userMail) {
        HttpPost request = new HttpPost(url);
        request.addHeader("X-A5-Impersonate", userMail);
        request.setEntity(requestPayload);
        executeEndpoint(request, endPoint, requestPayload);
        return jsonString;
    }

    public String customGetCall(String url, String endPoint) {
        HttpGet request = new HttpGet(url);
        StringEntity payload=new StringEntity("No Request Payload", StandardCharsets.UTF_8);
        executeEndpoint(request,endPoint,payload);
        return jsonString;
    }

    public String customGetCall(String url, String endPoint, boolean negativeTest, String userMail) {
        HttpGet request = new HttpGet(url);
        request.addHeader("X-A5-Impersonate", userMail);
        StringEntity payload=new StringEntity("No Request Payload", StandardCharsets.UTF_8);
        executeEndpoint(request,endPoint,payload, negativeTest);
        return jsonString;
    }
    public Boolean customGetCall(String url) {
        HttpGet request = new HttpGet(url);
        return executeEndpoint(request);
    }

    public String customGetCall(HttpRequestBase request, String endPoint) {
        StringEntity payload = new StringEntity("No Request Payload", StandardCharsets.UTF_8);
        executeEndpoint(request, endPoint, payload);
        return jsonString;
    }

    public String customPostCall(HttpRequestBase request, String endPoint, StringEntity requestPayload) {
        executeEndpoint(request, endPoint, requestPayload);
        return jsonString;
    }

    public String customPutCall(String url, String endPoint, StringEntity requestPayload) {
        HttpPut request = new HttpPut(url);
        request.addHeader("X-A5-Impersonate", ExpectedData.USEREMAIL);
        request.setEntity(requestPayload);
        executeEndpoint(request,endPoint,requestPayload);
        return jsonString;
    }

    public String customPutCall(HttpRequestBase request, String endPoint, StringEntity requestPayload) {
        executeEndpoint(request,endPoint,requestPayload);
        return jsonString;
    }

    public String customPatchCall(String url, String endPoint, StringEntity requestPayload) {
        HttpPatch request = new HttpPatch(url);
        request.setEntity(requestPayload);
        executeEndpoint(request, endPoint, requestPayload);
        return jsonString;
    }

    public Boolean customDeleteCallWithBody(String url, String endPoint, StringEntity requestPayload) {
        HttpDeleteWithBody request = new HttpDeleteWithBody(url);
        request.setEntity(requestPayload);
        return executeEndpoint_WithoutAnyResponse(request,endPoint,requestPayload);
    }

    public Boolean customDeleteCall(String url, String endPoint) {
        HttpDelete request = new HttpDelete(url);
        StringEntity payload=new StringEntity("No Request Payload", StandardCharsets.UTF_8);
        return executeEndpoint_WithoutAnyResponse(request,endPoint,payload);
    }

    public String customDeleteCallWithResponse(String url, String endPoint) {
        HttpDelete request = new HttpDelete(url);
        StringEntity payload=new StringEntity("No Request Payload", StandardCharsets.UTF_8);
        return executeEndpoint(request,endPoint,payload);
    }

    public Boolean customPutCallWithoutEntity(String url, String endPoint) {
        HttpPut request = new HttpPut(url);
        StringEntity payload=new StringEntity("No Request Payload", StandardCharsets.UTF_8);
        return executeEndpoint_WithoutAnyResponse(request,endPoint,payload);
    }

    public Boolean customPutCallWithoutResponse(String url, String endPoint, StringEntity requestPayload) {
        HttpPut request = new HttpPut(url);
        request.addHeader("X-A5-Impersonate", ExpectedData.USEREMAIL);
        request.setEntity(requestPayload);
        return executeEndpoint_WithoutAnyResponse(request,endPoint,requestPayload);
    }

    public String customPostCall_WithOutRequestPayload(URI url, String endPoint) {
        HttpPost request = new HttpPost(url);
        StringEntity payload=new StringEntity("No Request Payload", StandardCharsets.UTF_8);
        executeEndpoint(request,endPoint,payload);
        return jsonString;
    }

    private String executeEndpoint(HttpRequestBase request, String endPoint, StringEntity requestPayload) {
        try {
            System.out.println("--- " + endPoint.toUpperCase() + " --- \nRequest Payload: " +
                    EntityUtils.toString(requestPayload));
            response=processRequest(request);

            jsonString = EntityUtils.toString(response.getEntity());
            int statusCode=response.getStatusLine().getStatusCode();
            if (!(statusCode >= 200 && statusCode < 400))
                Assert.fail(endPoint.toUpperCase() + ": END-POINT FAILED - due to status code:" + statusCode+",  "+jsonString);
            else
                System.out.println("StatusCode: " + response.getStatusLine().getStatusCode() +
                        "\nResponse Payload: " + jsonString + "\n");
        } catch (IOException e) {
            System.out.println(e.getCause());
        }

        return jsonString;
    }

    private String executeEndpoint(HttpRequestBase request, String endPoint, StringEntity requestPayload, boolean negativeTest) {
        try {
            System.out.println("--- " + endPoint.toUpperCase() + " --- \nRequest Payload: " +
                    EntityUtils.toString(requestPayload));
            response=processRequest(request);

            jsonString = EntityUtils.toString(response.getEntity());
            int statusCode=response.getStatusLine().getStatusCode();
            if (!(statusCode >= 200 && statusCode < 400) && !negativeTest)
                Assert.fail(endPoint.toUpperCase() + ": END-POINT FAILED - due to status code:" + statusCode+",  "+jsonString);
            else
                System.out.println("StatusCode: " + response.getStatusLine().getStatusCode() +
                        "\nResponse Payload: " + jsonString + "\n");
        } catch (IOException e) {
            System.out.println(e.getCause());
        }

        return jsonString;
    }

    private Boolean executeEndpoint_WithoutAnyResponse(HttpRequestBase request, String endPoint, StringEntity requestPayload) {
        try {

            System.out.println("--- " + endPoint.toUpperCase() + " --- \nRequest Payload: " +
                    EntityUtils.toString(requestPayload));

            response=processRequest(request);
            int statusCode=response.getStatusLine().getStatusCode();

            if (!(statusCode >= 200 || statusCode < 400))
                Assert.fail(endPoint.toUpperCase() + ": END-POINT FAILED - due to " +
                        statusCode + "____" + response.getStatusLine().getReasonPhrase());
            else
                System.out.println(endPoint.toUpperCase() + "-StatusCode: " + statusCode + "\n");
        } catch (IOException e) {
            System.out.println(e.getCause());
        }

        return true;
    }

    private Header[] executeEndpoint_WithNoResponse_GetHeader(HttpRequestBase request, String endPoint, StringEntity requestPayload) {

        try {

            System.out.println("--- " + endPoint.toUpperCase() + " --- \nRequest Payload: " +
                    EntityUtils.toString(requestPayload));

            //Here no authorisation is used
            CloseableHttpClient httpClient = HttpClientBuilder.create().build();
            response = httpClient.execute(request);

            int statusCode=response.getStatusLine().getStatusCode();

            if (!(statusCode >= 200 || statusCode < 400))
                Assert.fail(endPoint.toUpperCase() + ": END-POINT FAILED - due to " +
                        statusCode + "____" + response.getStatusLine().getReasonPhrase());
            else
                System.out.println(endPoint.toUpperCase() + "-StatusCode: " + statusCode + "\n");
        } catch (IOException e) {
            System.out.println(e.getCause());
        }

        return response.getAllHeaders();
    }

    public Boolean executeEndpoint(HttpRequestBase request) {
        boolean status = false;
        try {
        response = processRequest(request);
        int statusCode = response.getStatusLine().getStatusCode();
        if (statusCode >= 200 || statusCode < 400)
            status = true;
        }
        catch(Exception e) {
            status = false;
        }
        return status;
   }

    private HttpResponse processRequest(HttpRequestBase request) {
        try {
            request.addHeader("Authorization", getToken());
            request.addHeader("Content-Type", "application/json");

            CloseableHttpClient httpClient = HttpClientBuilder.create().build();
            response = httpClient.execute(request);
        } catch (IOException e) {
            System.out.println(e.getCause());
        }

        return response;
    }
}