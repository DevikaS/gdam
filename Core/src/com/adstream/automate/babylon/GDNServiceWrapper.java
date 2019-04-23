package com.adstream.automate.babylon;

import com.adstream.automate.babylon.JsonObjects.gdn.GDNJobSerializer;
import com.adstream.automate.babylon.JsonObjects.gdn.WorkflowAction;
import com.adstream.gdn.api.client.serialization.Job;
import com.adstream.gdn.api.client.serialization.JobResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.log4j.Logger;

import java.io.IOException;

/**
 * Created by Ramababu.Bendalam on 10/08/2017.
 */
public class GDNServiceWrapper {

    private Logger log = Logger.getLogger(this.getClass());
    private GDNService service;


    public GDNServiceWrapper(GDNService service) {
        this.service = service;
    }

    public JobResponse submitJob(Job job) {

        return service.submitJob(job);
    }

    public WorkflowAction getworkflowAction(String workflowId) throws IOException{
        return service.getworkflowAction(workflowId);
    }


}
