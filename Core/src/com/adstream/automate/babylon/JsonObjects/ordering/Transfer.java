package com.adstream.automate.babylon.JsonObjects.ordering;

import com.adstream.automate.babylon.JsonObjects.User;
import org.joda.time.DateTime;

/*
 * Created by demidovskiy-r on 19.03.14.
 */
public class Transfer {
    private User to;
    private User triggeredBy;
    private String message;
    private DateTime time;

    public User getUserTo() {
        return to;
    }

    public void setUserTo(User to) {
        this.to = to;
    }

    public User getTriggeredBy() {
        return triggeredBy;
    }

    public void setTriggeredBy(User triggeredBy) {
        this.triggeredBy = triggeredBy;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public DateTime getTime() {
        return time;
    }

    public void setTime(DateTime time) {
        this.time = time;
    }
}