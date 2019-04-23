package com.adstream.automate.babylon.core;

import com.adstream.automate.babylon.BabylonMessageSender;
import com.adstream.automate.babylon.BabylonService;
import com.adstream.automate.babylon.JsonObjects.BatchTask;
import com.adstream.automate.babylon.JsonObjects.BatchTasks;
import com.adstream.automate.babylon.JsonObjects.Content;
import com.adstream.automate.utils.Common;
import com.google.gson.JsonObject;
import com.google.gson.reflect.TypeToken;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPut;
import org.apache.log4j.Logger;

import java.lang.reflect.Type;
import java.util.List;
import java.util.Map;
import java.util.concurrent.TimeoutException;

/**
 * Created by alexeys on 3/26/14.
 */
public class BatchTaskApi {
    private String authId;
    private String baseUrl;
    private BabylonMessageSender messageSender;
    protected final static Logger log = Logger.getLogger(BabylonService.class);

    public BatchTaskApi(String baseUrl, String userId) {
        this.messageSender = new BabylonMessageSender() {
        };
        this.authId = userId;
        this.baseUrl = baseUrl.toString();
    }

    public List<BatchTask> getTaskList(String processId) {
        HttpGet get = new HttpGet(baseUrl + "batch-task/tasks/" + processId + "?$id$=" + authId);
        BatchTasks result = messageSender.sendRequest(get, BatchTasks.class);
        return result.getList();
    }
    //https://connect.adstream.com/display/ArC/Get+batch+task+the+given+id
    public BatchTask getTask(String taskId) {
        HttpGet get = new HttpGet(baseUrl + "batch-task/task/" + taskId + "?$id$=" + authId);
        return messageSender.sendRequest(get, BatchTask.class);
    }

    public String updateAssets(List<Content> contentList) {
        JsonObject request = new JsonObject();
        request.add("list", messageSender.gson.toJsonTree(contentList));
        Type returnType = new TypeToken<Map<String, String>>() {
        }.getType();
        HttpPut put = messageSender.createPut(baseUrl + "asset/batch?$id$=" + authId, request.toString());
        Map<String, String> result = messageSender.sendRequest(put, returnType);

        return result.get("processId");
    }

    public String updateElements(List<Content> contentList) {
        JsonObject request = new JsonObject();
        request.add("list", messageSender.gson.toJsonTree(contentList));
        Type returnType = new TypeToken<Map<String, String>>() {
        }.getType();
        HttpPut put = messageSender.createPut(baseUrl + "project/element/batch?$id$=" + authId, request.toString());
        Map<String, String> result = messageSender.sendRequest(put, returnType);

        return result.get("processId");
    }

    public void waitTillDone(String processId) throws TimeoutException {
        long timeout = 15 * 60 * 1000; //15 min
        long pollInterval = 500; //500 ms
        long timeToEnd = System.currentTimeMillis() + timeout;
        do {
            List<BatchTask> tasks = getTaskList(processId);
            int doneSuccess = 0;
            int doneFailed = 0;

            /*  3 - Completed (task execution has completed without error)
                4 - Failed (task execution has completed with error)
             */
            long st = System.currentTimeMillis();
            for (BatchTask task : tasks) {
                switch (task.getTaskStatus()) {
                    case 3:
                        doneSuccess++;
                        break;
                    case 4:
                        doneFailed++;
                        break;
                    default:
                        break;
                }
            }
            if ((doneSuccess + doneFailed) != tasks.size()) {
                log.debug("success done tasks: " + doneSuccess + "; failed: " + doneFailed + "; ALL " + tasks.size());
                Common.sleep(pollInterval);
            } else {
                log.info("success done tasks: " + doneSuccess + "; failed: " + doneFailed + "; ALL " + tasks.size());
                return; //all done
            }
            if (System.currentTimeMillis() >= timeToEnd) {
                throw new TimeoutException("Task timeout after " + timeout + "ms");
            }
        } while (true);
    }
}
