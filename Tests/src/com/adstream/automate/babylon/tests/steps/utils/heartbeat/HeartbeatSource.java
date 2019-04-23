package com.adstream.automate.babylon.tests.steps.utils.heartbeat;

import com.adstream.automate.utils.Common;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;

import java.io.IOException;

public abstract class HeartbeatSource extends Thread {
    private static final int HEARTBEAT_CHECK_INTERVAL = 5000;
    private static final int DELAY_AFTER_HEARTBEAT_STOP = 40000;
    private HeartbeatListener listener;
    private CloseableHttpClient httpClient;

    public HeartbeatSource(HeartbeatListener listener) {
        this.listener = listener;
        setDaemon(true);
    }

    public void run() {
        while (true) {
            try {
                checkHeartbeat();
            } catch (IOException e) {
                heartbeatStopped();
            }
            Common.sleep(HEARTBEAT_CHECK_INTERVAL);
        }
    }

    public abstract void checkHeartbeat() throws IOException;

    protected CloseableHttpClient getHttpClient() {
        if (httpClient == null) {
            httpClient = HttpClients.createDefault();
        }
        return httpClient;
    }

    protected void heartbeatStopped() {
        listener.heartbeatStopped(this.getClass());
        Common.sleep(DELAY_AFTER_HEARTBEAT_STOP);
    }
}
