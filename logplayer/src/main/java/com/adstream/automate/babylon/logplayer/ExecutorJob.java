package com.adstream.automate.babylon.logplayer;

import com.adstream.automate.utils.Common;
import com.google.gson.Gson;
import org.joda.time.DateTime;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.nio.charset.Charset;
import java.util.concurrent.atomic.AtomicInteger;

/**
 * User: ruslan.semerenko
 * Date: 04.11.13 17:27
 */
public class ExecutorJob implements Runnable {
    private static AtomicInteger enqueuedJobsCounter = new AtomicInteger();
    private static AtomicInteger executingJobsCounter = new AtomicInteger();
    private static Gson gson = new Gson();
    private static int poolSize = Integer.MAX_VALUE;
    private Message message;
    private DateTime dateStart;

    public static int getEnqueuedJobsCount() {
        return enqueuedJobsCounter.get();
    }

    public static void setPoolSize(int poolSize) {
        ExecutorJob.poolSize = poolSize;
    }

    ExecutorJob(Message message, DateTime dateStart) {
        enqueuedJobsCounter.incrementAndGet();
        this.message = message;
        this.dateStart = dateStart;
    }

    @Override
    public void run() {
        while (new DateTime().isBefore(dateStart)) {
            Common.sleep(100);
        }
        if (executingJobsCounter.incrementAndGet() >= poolSize) {
            System.out.println("WARN: Max pool size reached.");
        }
        sendMessage();
        executingJobsCounter.decrementAndGet();
        enqueuedJobsCounter.decrementAndGet();
    }

    private void sendMessage() {
        System.out.println(message.getOriginalMessage());
        HttpURLConnection connection = null;
        try {
            connection = (HttpURLConnection) message.getUrl().openConnection();
            connection.setRequestMethod(message.getMethod().toUpperCase());
            connection.setUseCaches(false);
            connection.setDoInput(true);
            if (connection.getRequestMethod().equals("POST") || connection.getRequestMethod().equals("PUT")) {
                byte[] body = gson.toJson(message.getBody()).getBytes(Charset.forName("UTF-8"));
                connection.setDoOutput(true);
                connection.setRequestProperty("Content-Type", "application/json");
                connection.setRequestProperty("Content-Length", String.valueOf(body.length));
                OutputStream out = connection.getOutputStream();
                out.write(body);
                out.flush();
                out.close();
            }
            consumeInputStream(connection.getInputStream());
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            if (connection != null) {
                connection.disconnect();
            }
        }
    }

    private void consumeInputStream(InputStream in) throws IOException {
        byte[] buffer = new byte[4096];
        while (in.read(buffer) >= 0) {
            // do nothing
        }
        in.close();
    }
}
