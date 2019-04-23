package com.adstream.automate.babylon;

import com.adstream.automate.babylon.JsonObjects.gdn.GDNJobSerializer;
import com.adstream.automate.babylon.JsonObjects.gdn.WorkflowAction;
import com.adstream.gdn.api.client.serialization.Job;
import com.adstream.gdn.api.client.serialization.JobResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;

import java.io.IOException;
import java.net.URL;

/**
 * Created by Ramababu.Bendalam on 10/08/2017.
 */
public class GDNCoreService extends BabylonMessageSender implements GDNService {

    public GDNCoreService(URL url) {
        super(url);
        contentType = "application/xml";
    }

    public JobResponse submitJob(Job job) {
        HttpPost post = createPost(baseUrl + "job/submit/e2eTests", GDNJobSerializer.serializeJob(job));
        String response = sendRequest(post);
        return GDNJobSerializer.deserializeJobResponse(response);
    }

    public WorkflowAction getworkflowAction(String workflowId) throws IOException {

        StringBuilder address = new StringBuilder(baseUrl);
        address.append("workflow/id/").append(workflowId);
        HttpGet get = new HttpGet(address.toString());
        return sendRequest(get, WorkflowAction.class);
    }

}
