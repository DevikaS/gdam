package com.adstream.automate.babylon.JsonObjects;

/*
 * Created by demidovskiy-r on 26.09.2014.
 */
public enum  Localization {
    CLOCK_NUMBER("en", "Clock number", "Clock number");

    private String language;

    private String key;
    private String description;

    private Localization(String language, String key, String description) {
        this.language = language;
        this.key = key;
        this.description = description;
    }

    @Override
    public String toString() {
        return key;
    }

    public String getDescription() {
        return description;
    }

    public String getLanguage() {
        return language;
    }

    public static String findByKey(String key) {
        for (Localization localization : values())
            if (localization.toString().equalsIgnoreCase(key))
                return localization.getDescription();
        return key;
    }


    public static String findByLanguageAndKey(String language, String key) {
        for (Localization localization : values())
            if (localization.getLanguage().equals(language) && localization.toString().equalsIgnoreCase(key))
                return localization.getDescription();
        return key;
    }
}