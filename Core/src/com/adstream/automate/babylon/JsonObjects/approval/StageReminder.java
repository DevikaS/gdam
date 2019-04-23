package com.adstream.automate.babylon.JsonObjects.approval;

import org.joda.time.DateTime;

/**
 * User: ruslan.semerenko
 * Date: 19.06.13 20:14
 */
public class StageReminder {
    private DateTime date;
    private String reminderType;

    public DateTime getDate() {
        return date;
    }

    public void setDate(DateTime date) {
        this.date = date;
    }

    public String getReminderType() {
        return reminderType;
    }

    public void setReminderType(String reminderType) {
        this.reminderType = reminderType;
    }
}
