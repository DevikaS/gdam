package com.adstream.automate.babylon.JsonObjects;

import java.util.HashMap;
import java.util.List;
import java.util.Map;


/**
 * User: alexey.savitskiy
 * Date: 04.04.12 18:39
 */

/**
 * {
 "_id":"532626280ee8a0f76a00d1ca",
 "processId":"532626280ee8a0f76a00d1c8",
 "taskStatus":3,
 "taskDescription":"Asset update",
 "error":{
 "message":"",
 "stackTrace":""
 }
 }
 */
public class BatchTasks {
    private String processId;
    private List<BatchTask> list;

    public String getProcessId() {
        return processId;
    }

    public void setProcessId(String processId) {
        this.processId = processId;
    }

    public List<BatchTask> getList() {
        return list;
    }

    public void setList(List<BatchTask> list) {
        this.list = list;
    }
}