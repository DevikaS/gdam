package com.adstream.automate.babylon.tests.steps.utils.heartbeat;

import com.adstream.automate.babylon.TestsContext;
import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.util.EntityUtils;

import java.io.IOException;

/**
 * Created by Saritha.Dhanala on 17/07/2018.
 */
public class MediaManagerHeartBeatSource extends HeartbeatSource {
    private HttpGet request = new HttpGet(TestsContext.getInstance().mediamanager_core_url.toString() + "/admin/heartbeat");

    public MediaManagerHeartBeatSource(HeartbeatListener heartbeatListener) {
        super(heartbeatListener);
    }

    @Override
    public void checkHeartbeat() throws IOException {
        HttpResponse response = getHttpClient().execute(request);
        if(response.getEntity() != null){
            EntityUtils.consume(response.getEntity());
        }
        if (response.getStatusLine().getStatusCode() != 200) {
            heartbeatStopped();
        }

    }
}
