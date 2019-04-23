package com.adstream.automate.babylon.JsonObjects.gdn;

import org.joda.time.DateTime;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by Ramababu.Bendalam on 27/04/2016.
 */
public class IngestOrder {
    String reference;
    String service_level;
    DateTime submitted;


    public String getReference() {
        return reference;
    }

    public void setReference(String reference) {
        this.reference = reference;
    }

    public String getService_level() {
        return service_level;
    }

    public void setService_level(String service_level) {
        this.service_level = service_level;
    }

    public DateTime getSubmitted() {
        return submitted;
    }

    public void setSubmitted(DateTime submitted) {
        this.submitted = submitted;
    }
}
