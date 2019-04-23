package com.adstream.automate.babylon.JsonObjects;

import java.util.HashMap;
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
public class BatchTask {
    private String _id;
    private String processId;
    private int taskStatus;
    private String taskDescription;
    private Map<String,String> error;

    public int getTaskStatus() {
        return taskStatus;
    }

    public void setTaskStatus(int taskStatus) {
        this.taskStatus = taskStatus;
    }

    public String getId() {
        return _id;
    }

    public String getProcessId() {
        return processId;
    }

    public void setProcessId(String processId) {
        this.processId = processId;
    }


    public String getTaskDescription() {
        return taskDescription;
    }

    public void setTaskDescription(String taskDescription) {
        this.taskDescription = taskDescription;
    }

    public Map<String, String> getError() {
        return error == null? new HashMap<String,String>(): error;
    }

    public void setError(Map<String, String> error) {
        this.error = error;
    }

    public String getErrorMessage(){
        return getError().get("message");

    }

    public String getErrorStackTrace(){
        return getError().get("stackTrace");
    }
}