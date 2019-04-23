package com.adstream.automate.babylon.JsonObjects.gdn;

import com.adstream.automate.babylon.BabylonMessageSender;
import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.HttpClients;
import java.io.IOException;
import java.net.URL;

/**
 * Created by Ramababu.Bendalam on 05/02/2016.
 */
public class A4RestService extends BabylonMessageSender {

    public A4RestService(URL baseUrl) {
        super(baseUrl);
        contentType = "application/soap+xml;charset=UTF-8";

    }

    public HttpResponse postMetadata(String xml) {
        HttpClient httpclient = HttpClients.createDefault();
        HttpPost post = createPost(baseUrl + "/AMS/Metadata.svc", xml);
        HttpResponse response = null;
        try {
            response = httpclient.execute(post);
            } catch (IOException e) {
            e.printStackTrace();
        }
        return response;
    }

    public HttpResponse postAsset(String xml){
        HttpClient httpclient = HttpClients.createDefault();
        HttpPost post = createPost(baseUrl + "/AMS/Asset.svc", xml);
        HttpResponse response = null;
        try {
            response = httpclient.execute(post);
            } catch (IOException e) {
            e.printStackTrace();
        }
        return response;
    }
}
