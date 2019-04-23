package com.adstream.automate.babylon.tests.steps.utils.heartbeat;

import com.adstream.automate.babylon.TestsContext;
import org.apache.http.HttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.util.EntityUtils;

import java.io.IOException;

public class AdcostHeartBeatSource extends HeartbeatSource {
    private HttpGet request = new HttpGet(TestsContext.getInstance().adcostCore + "/status");

    public AdcostHeartBeatSource(HeartbeatListener listener) {
        super(listener);
    }

    @Override
    public void checkHeartbeat() throws IOException {
        HttpResponse response = getHttpClient().execute(request);
        EntityUtils.consume(response.getEntity());
        if (response.getStatusLine().getStatusCode() != 200) {
            heartbeatStopped();
        }
    }
}