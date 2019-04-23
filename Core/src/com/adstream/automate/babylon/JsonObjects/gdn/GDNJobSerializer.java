package com.adstream.automate.babylon.JsonObjects.gdn;

import com.adstream.gdn.api.client.serialization.AbstractGdnClientXmlSerializer;
import com.adstream.gdn.api.client.serialization.Job;
import com.adstream.gdn.api.client.serialization.JobResponse;
import com.typesafe.scalalogging.slf4j.Logger;
import com.typesafe.scalalogging.slf4j.Logging;
import com.typesafe.scalalogging.slf4j.Logging.*;

/**
 * Created by Ramababu.Bendalam on 15/01/2016.
 */
public class GDNJobSerializer extends AbstractGdnClientXmlSerializer {

    private static GDNJobSerializer instance = new GDNJobSerializer();

    public static String serializeJob(Job job) {
        return instance.serializeJobString(job);
    }

    public static <T extends Job> T deserializeJob(String str) {
        return instance.deserializeJobString(str);
    }

    public static String serializeJobResponse(JobResponse obj) {
        return instance.serializeJobResponseString(obj);
    }

    public static <T extends JobResponse> T deserializeJobResponse(String str) {
        return instance.deserializeJobResponseString(str);
    }
}
