package com.adstream.automate.babylon;

import com.adstream.automate.babylon.JsonObjects.gdn.WorkflowAction;
import com.adstream.gdn.api.client.serialization.Job;
import com.adstream.gdn.api.client.serialization.JobResponse;

import java.io.IOException;

/**
 * Created by Ramababu.Bendalam on 10/08/2017.
 */
public interface GDNService {

    public WorkflowAction getworkflowAction(String workflowId) throws IOException;
    public JobResponse submitJob(Job job);
}
