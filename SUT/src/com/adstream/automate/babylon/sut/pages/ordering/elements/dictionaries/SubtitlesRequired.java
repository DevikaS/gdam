package com.adstream.automate.babylon.sut.pages.ordering.elements.dictionaries;

/**
 * Created with IntelliJ IDEA.
 * User: demidovskiy-r
 * Date: 28.10.13
 * Time: 18:02
 */
public enum  SubtitlesRequired {
    ALREADY_SUPPLIED("Already Supplied", ""),
    NONE("None", ""),
    YES("Yes", ""),
    ADTEXT("Adtext", "subtitlers@adtext.tv"),
    ADTEXTHD("Adtext HD", "subtitlers@adtext.tv"),
    ADTEXTSD("Adtext SD", "subtitlers@adtext.tv"),
    BTI_STUDIOS("BTI Studios", "playout@ims-media.com");  // previously called as IMS

    private String name;
    private String emailTo;

    private SubtitlesRequired(String name, String emailTo){
        this.name = name;
        this.emailTo = emailTo;
    }

    @Override
    public String toString() {
        return name;
    }

    public String getEmailTo() {
        return emailTo;
    }

    public static SubtitlesRequired findByName(String name) {
        for (SubtitlesRequired subtitlesRequired : values())
            if (subtitlesRequired.toString().equals(name))
                return subtitlesRequired;
        throw new IllegalArgumentException("Unknown Subtitle Required name: " + name);
    }
}