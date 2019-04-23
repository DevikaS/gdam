package com.adstream.automate.babylon.JsonObjects;

import java.util.Locale;

/**
 * User: konstantin.lynda
 * Date: 19.03.14 08:00
 */
public enum UserDateFormat {
//              language      date       projectOverview      time            approval            comment date  comment time            locale
    EN         ("en",         "M/d/yy",     "MM/dd/yyyy",   "h:mm a", ", ", "EEEE d MMMM yyyy", "M/d/yyyy",   "hh:mm a", " 'at' ",    Locale.ENGLISH),
    EN_AU      ("en-au",      "d/MM/yy",   "MM/dd/yyyy",    "h:mm a", ", ", "EEEE d MMMM yyyy", "d/MM/yyyy",  "hh:mm a", " 'at' ",    Locale.ENGLISH),
    EN_GB      ("en-gb",      "dd/MM/yyyy", "MM/dd/yyyy", "HH:mm",  " " , "dd/MM/yyyy",       "dd/MM/yyyy", "HH:mm",   " 'at' ",    Locale.ENGLISH),
 // EN_US      ("en-us",      "MM/dd/yyyy", "MM/dd/yyyy",     "h:mm a", ", ", "EEEE d MMMM yyyy", "M/d/yyyy",   "h:mm a",  " 'at' ",    Locale.ENGLISH),
    EN_US      ("en-us",      "M/d/yy",     "MM/dd/yyyy", "h:mm a", ", ", "EEEE d MMMM yyyy", "M/d/yyyy",   "h:mm a",  " 'at' ",    Locale.ENGLISH),
    DE         ("de",         "dd.MM.yy",   "MM/dd/yyyy", "HH:mm",  " ",  "EEEE d MMMM yyyy", "dd.MM.yyyy", "HH:mm",   " 'um' ",    Locale.GERMAN),
    FR         ("fr",         "dd/MM/yyyy", "MM/dd/yyyy", "HH:mm",  " ",  "EEEE d MMMM yyyy", "dd/MM/yyyy", "HH:mm",   " 'at' ",    Locale.FRENCH),
    ES_ES      ("es-es",      "dd/MM/yy",   "MM/dd/yyyy", "HH:mm",  " ",  "EEEE d MMMM yyyy", "dd/MM/yyyy", "HH:mm",   " 'a las' ", Locale.forLanguageTag("es")),
    ES_AR      ("es-ar",      "dd/MM/yy",   "MM/dd/yyyy", "HH:mm",  " ",  "EEEE d MMMM yyyy", "dd/MM/yyyy", "HH:mm a", " 'at' ",    Locale.forLanguageTag("es")),
    EN_BEAM    ("en-beam",    "dd/MM/yyyy", "MM/dd/yyyy", "HH:mm",  " ",  "EEEE d MMMM yyyy", "dd/MM/yyyy", "HH:mm",   " 'at' ",    Locale.ENGLISH),
    EN_BEAM_US ("en-beam-us", "M/d/yy",     "MM/dd/yyyy", "h:mm a", ", ", "EEEE d MMMM yyyy", "M/d/yyyy",   "hh:mm a", " 'at' ",    Locale.ENGLISH);

    private String language;

    private String dateFormat;
    private String projectOverviewDateFormat;
    private String timeFormat;
    private String dateTimeSeparator;
    private String approvalEmailDateFormat;

    private String commentDateFormat;
    private String commentTimeFormat;
    private String commentDateTimeSeparator;

    private Locale locale;

    /**
     *
     * @param language                    a5 user language
     * @param dateFormat                  common date format
     * @param timeFormat                  common time format
     * @param dateTimeSeparator           common date time separator
     * @param approvalEmailDateFormat     common date format for approval emails
     * @param commentDateFormat           date format for comments
     * @param commentTimeFormat           time format for comments
     * @param commentDateTimeSeparator    date time separator for comments
     * @param locale                      locale for user language
     */
    private UserDateFormat(String language, String dateFormat,String projectOverviewDateFormat, String timeFormat, String dateTimeSeparator,
                           String approvalEmailDateFormat, String commentDateFormat, String commentTimeFormat,
                           String commentDateTimeSeparator, Locale locale) {
        this.language = language;
        this.dateFormat = dateFormat;
        this.projectOverviewDateFormat = projectOverviewDateFormat;
        this.timeFormat = timeFormat;
        this.dateTimeSeparator = dateTimeSeparator;
        this.approvalEmailDateFormat = approvalEmailDateFormat;
        this.commentDateFormat = commentDateFormat;
        this.commentTimeFormat = commentTimeFormat;
        this.commentDateTimeSeparator = commentDateTimeSeparator;
        this.locale = locale;
    }

    public String getDateFormat() {
       // System.out.println(dateFormat);
        return dateFormat;
    }

    public String getProjectOverviewDateFormat() {
        // System.out.println(dateFormat);
        return projectOverviewDateFormat;
    }

    public String getTimeFormat() {
        return timeFormat;
    }

    public String getDateTimeFormat() {
        return dateFormat + dateTimeSeparator + timeFormat;
    }

    public String getApprovalEmailDateFormat() {
        return approvalEmailDateFormat;
    }

    public String getCommentDateFormat() {
        return commentDateFormat;
    }

    public String getCommentTimeFormat() {
        return commentTimeFormat;
    }

    public String getCommentDateTimeFormat() {
        return commentDateFormat + commentDateTimeSeparator + commentTimeFormat;
    }

    public Locale getLocale() {
        return locale;
    }

    public static UserDateFormat getForLanguage(String language) {
        for (UserDateFormat dateFormat : values())
            if (dateFormat.language.equals(language))
                return dateFormat;

        throw new IllegalArgumentException("Could not find any formats for language: " + language);
    }
}