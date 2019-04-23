package com.adstream.automate.babylon;

import com.adstream.automate.babylon.JsonObjects.SearchResult;
import com.adstream.automate.babylon.JsonObjects.activity.Activity;
import com.adstream.automate.babylon.JsonObjects.activity.ActivityQuery;
import com.adstream.automate.babylon.JsonObjects.activity.ActivityType;
import com.adstream.automate.babylon.JsonObjects.activity.Pager;
import com.google.gson.JsonParser;
import com.google.gson.reflect.TypeToken;
import org.apache.http.client.methods.HttpDelete;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;

import javax.annotation.Nullable;
import java.lang.reflect.Type;
import java.net.URL;

public class PaperPusherCoreService extends BabylonMessageSender implements PaperPusherService {
    public PaperPusherCoreService(URL baseUrl) {
        super(baseUrl);
        contentType = "application/json";
    }

    public String getStatus() {
        String response = sendRequest(new HttpGet(baseUrl + "admin/heartbeat"));
        return new JsonParser().parse(response).getAsJsonObject().getAsJsonPrimitive("message").getAsString();
    }

    public String getVersion() {
        String response = sendRequest(new HttpGet(baseUrl + "admin/version"));
        return new JsonParser().parse(response).getAsJsonObject().getAsJsonPrimitive("version").getAsString();
    }

    public void createIndices() {
        sendRequest(createPost(baseUrl + "admin/indices", "{}"));
    }

    public void deleteIndices() {
        sendRequest(new HttpDelete(baseUrl + "admin/indices"));
    }

    public void reindex() {
        sendRequest(createPost(baseUrl + "admin/reindex", "{}"));
    }

    @Override
    public SearchResult<Activity> getActivities(ActivityType type, String objectId, @Nullable String creatorUserId, @Nullable String recipientUserId, @Nullable Pager pager) {
        StringBuilder address = new StringBuilder(baseUrl);
        address.append(type).append("/").append(objectId);
        if (creatorUserId != null || recipientUserId != null || pager != null) {
            address.append("?");
            if (creatorUserId != null) {
                address.append("subjectId=").append(creatorUserId);
            }
            if (recipientUserId != null) {
                if (creatorUserId != null) {
                    address.append("&");
                }
                address.append("userId=").append(recipientUserId);
            }
            if (pager != null) {
                address.append(pager.toGetParams());
            }
        }
        HttpGet get = new HttpGet(address.toString());
        Type responseType = new TypeToken<SearchResult<Activity>>(){}.getType();
        return sendRequest(get, responseType);
    }

    @Override
    public SearchResult<Activity> getActivities(ActivityType type, @Nullable String recipientUserId, @Nullable String agencyId, @Nullable Pager pager) {
        StringBuilder address = new StringBuilder(baseUrl);
        address.append(type);
        if (recipientUserId != null || agencyId != null || pager != null) {
            address.append("?");
            if (recipientUserId != null) {
                address.append("userId=").append(recipientUserId);
            }
            if (agencyId != null) {
                if (recipientUserId != null) {
                    address.append("&");
                }
                address.append("agencyId=").append(agencyId);
            }
            if (pager != null) {
                address.append(pager.toGetParams());
            }
        }
        HttpGet get = new HttpGet(address.toString());
        Type responseType = new TypeToken<SearchResult<Activity>>(){}.getType();
        return sendRequest(get, responseType);
    }

    @Override
    public SearchResult<Activity> findActivities(ActivityType type, ActivityQuery query, @Nullable Pager pager) {
        String address = baseUrl + type + (pager != null ? "?" + pager.toGetParams() : "");
        HttpPost post = createPost(address, query.toString());
        Type responseType = new TypeToken<SearchResult<Activity>>(){}.getType();
        return sendRequest(post, responseType);
    }
}
