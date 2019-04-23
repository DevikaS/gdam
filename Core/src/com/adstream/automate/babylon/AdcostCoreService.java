package com.adstream.automate.babylon;

import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import org.apache.http.client.methods.HttpGet;
import java.net.URL;

public class AdcostCoreService extends BabylonMessageSender {

    public AdcostCoreService(URL url) {
        this(url, null);
    }

    public AdcostCoreService(URL url, String userId) {
        super(url);
        contentType = "application/json";
    }

    public String getVersion(){
        HttpGet get = new HttpGet(TestsContext.getInstance().adcostCore.toString() + "/v1/admin/version");
        AdocstVersionBranch result = sendRequest(get, AdocstVersionBranch.class);
        return result.buildNumber;
    }

    public String getBranch(){
        HttpGet get = new HttpGet(TestsContext.getInstance().adcostCore.toString() + "/v1/admin/version");
        AdocstVersionBranch result = sendRequest(get, AdocstVersionBranch.class);
        return result.gitBranch;
    }

    public String getDatabaseTable(){
        HttpGet get = new HttpGet(TestsContext.getInstance().adcostCore.toString() + "/v1/admin/version");
        String result = sendRequest(get);
        JsonObject responseObj = new JsonParser().parse(result).getAsJsonObject();
        responseObj = responseObj.get("databaseTable").getAsJsonObject();
        return responseObj.get("version").getAsString();
    }

    public String getNginxVersion(){
        HttpGet get = new HttpGet(TestsContext.getInstance().adcostFrontUrl.toString() + ":8880/costs/version");
        AdocstVersionBranch result = sendRequest(get, AdocstVersionBranch.class);
        return result.version;
    }

    public String getMiddleTierVersion(){
        HttpGet get = new HttpGet(TestsContext.getInstance().adcostFrontUrl.toString() + ":8888/api/version");
        AdocstVersionBranch result = sendRequest(get, AdocstVersionBranch.class);
        return result.buildNumber;
    }

    class AdocstVersionBranch {
        public String buildNumber;
        public String gitBranch;
        public String version;
    }
}