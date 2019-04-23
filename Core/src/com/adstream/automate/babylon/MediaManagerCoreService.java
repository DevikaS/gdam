package com.adstream.automate.babylon;

import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import org.apache.http.client.methods.HttpGet;

import java.net.URL;

/**
 * Created by Saritha.Dhanala on 17/07/2018.
 */
public class MediaManagerCoreService extends BabylonMessageSender {

    public MediaManagerCoreService(URL url) {
        this(url, null);
    }

    public MediaManagerCoreService (URL url, String userId) {
        super(url);
        contentType = "application/json";
    }

    public JsonObject getResponseObject(){
        HttpGet get = new HttpGet(TestsContext.getInstance().mediamanager_core_url.toString() + "/admin/version");
        String response = sendRequest(get);
        JsonObject responseObj = new JsonParser().parse(response).getAsJsonObject();
        return responseObj;
    }

    public String getVersion(){
        String version = getResponseObject().get("version").getAsString();
        return version;

    }

    public String getBranch() {
        return getResponseObject().get("branch").getAsString();
    }




}
