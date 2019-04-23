package com.adstream.automate.babylon.JsonObjects.ordering.enums;

/*
 * Created by demidovskiy-r on 19.06.2014.
 */
public enum DateFormat {
    DD("dd"),
    MM("MM"),
    YYYY("YYYY"),
    MMDDYYYY("MMddYYYY"),
    DDMMYYYY("ddMMYYYY");

    private String format;

    private DateFormat(String format) {
        this.format = format;
    }

    @Override
    public String toString() {
        return format;
    }

    public static String findByFormat(String format) {
        for (DateFormat dateFormat : values())
            if (dateFormat.toString().equalsIgnoreCase(format))
                return dateFormat.toString();
        throw new IllegalArgumentException("Unknown date format: " + format);
    }
}