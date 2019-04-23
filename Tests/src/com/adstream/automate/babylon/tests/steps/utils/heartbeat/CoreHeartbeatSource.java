package com.adstream.automate.babylon.tests.steps.utils.heartbeat;

import com.adstream.automate.babylon.JsonObjects.ExternalComponent;
import com.adstream.automate.babylon.JsonObjects.HeartBeat;
import com.adstream.automate.babylon.TestsContext;
import com.google.gson.Gson;
import org.apache.http.HttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.util.EntityUtils;
import org.apache.log4j.Logger;
import java.io.IOException;

public class CoreHeartbeatSource extends HeartbeatSource {
    private static final int WARN_RESPONSE_TIME = 5000;
    private static Logger log = Logger.getLogger(CoreHeartbeatSource.class);
    private HttpGet request = new HttpGet(TestsContext.getInstance().coreUrl[0].toString() + "/admin/heartbeat");

    public CoreHeartbeatSource(HeartbeatListener listener) {
        super(listener);
    }

    @Override
    public void checkHeartbeat() throws IOException {
        HttpResponse response = getHttpClient().execute(request);
        String responseBody = EntityUtils.toString(response.getEntity());
        if (response.getStatusLine().getStatusCode() != 200) {
            heartbeatStopped();
        } else {
            checkExternalComponents(responseBody);
        }
    }

    private void checkExternalComponents(String responseBody) {
        if (responseBody != null) {
            HeartBeat heartBeat = new Gson().fromJson(responseBody, HeartBeat.class);
            for (ExternalComponent externalComponent : heartBeat.getExternalComponents()) {
                if (externalComponent.getResponseTimeInMillis() > WARN_RESPONSE_TIME) {
                    log.warn(String.format("%s has response time %d ms.",
                            externalComponent.getName(), externalComponent.getResponseTimeInMillis()));
                }
            }
        } else {
            log.error("Cannot get response body of cores external components!");
        }
    }
}