package com.adstream.automate.babylon.tests.steps.utils.heartbeat;

import com.adstream.automate.babylon.TestsContext;
import com.google.gson.JsonParser;
import org.apache.http.HttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.util.EntityUtils;

import java.io.IOException;

public class PaperPusherHeartbeatSource extends HeartbeatSource {
    private HttpGet request = new HttpGet(TestsContext.getInstance().paperPusherUrl + "/admin/heartbeat");

    public PaperPusherHeartbeatSource(HeartbeatListener listener) {
        super(listener);
    }

    @Override
    public void checkHeartbeat() throws IOException {
        HttpResponse response = getHttpClient().execute(request);
        String body = EntityUtils.toString(response.getEntity());
        if (response.getStatusLine().getStatusCode() != 200) {
            heartbeatStopped();
        }
        String message = new JsonParser().parse(body).getAsJsonObject().getAsJsonPrimitive("message").getAsString();
        if (!message.equals("It's alive!")) {
            heartbeatStopped();
        }
    }
}
