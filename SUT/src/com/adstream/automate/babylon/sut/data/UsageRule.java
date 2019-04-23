package com.adstream.automate.babylon.sut.data;

import java.util.ArrayList;
import java.util.List;

/**
 * User: konstantin.lynda
 * Date: 22.02.13 13:31
 */
public class UsageRule {
    public static final String GENERAL = "General";
    public static final String COUNTRIES = "Countries";
    public static final String MEDIA_TYPES = "Media Types";
    public static final String VISUAL_TALENT = "Visual Talent";
    public static final String VOICE_OVER_ARTIST = "Voice-over Artist";
    public static final String MUSIC = "Music";
    public static final String OTHER_USAGE = "Other usage";

    public static boolean contains(String rule) {
        List<String> usageRules = new ArrayList<String>();
        usageRules.add(GENERAL);
        usageRules.add(COUNTRIES);
        usageRules.add(MEDIA_TYPES);
        usageRules.add(VISUAL_TALENT);
        usageRules.add(VOICE_OVER_ARTIST);
        usageRules.add(MUSIC);
        usageRules.add(OTHER_USAGE);

        return usageRules.contains(rule);
    }

    private UsageRule() {}
}