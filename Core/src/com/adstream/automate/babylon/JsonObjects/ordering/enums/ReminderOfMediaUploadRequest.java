package com.adstream.automate.babylon.JsonObjects.ordering.enums;

/*
 * Created by demidovskiy-r on 15.05.2015.
 */
public enum ReminderOfMediaUploadRequest {
    BEFORE_DEADLINE_DATE("Before Deadline Date") {
        @Override
        public String getAppropriateMessage(int days) {
            return String.format("before %s", days);
        }
    },
    ON_DEADLINE_DATE("On Deadline Date") {
        @Override
        public String getAppropriateMessage(int days) {
            return String.format("on %s", days);
        }
    },
    AFTER_DEADLINE_DATE("After Deadline Date") {
        @Override
        public String getAppropriateMessage(int days) {
            return String.format("after %s", days);
        }
    };

    private String reminderType;

    private ReminderOfMediaUploadRequest(String reminderType) {
        this.reminderType = reminderType;
    }

    public abstract String getAppropriateMessage(int days);

    @Override
    public String toString() {
        return reminderType;
    }

    public static ReminderOfMediaUploadRequest findByType(String reminderType) {
        for (ReminderOfMediaUploadRequest r: values())
            if (r.toString().equalsIgnoreCase(reminderType))
                return r;
        throw new IllegalArgumentException("Unknown reminder type: " + reminderType);
    }
}