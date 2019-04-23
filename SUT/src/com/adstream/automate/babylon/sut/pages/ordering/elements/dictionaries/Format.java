package com.adstream.automate.babylon.sut.pages.ordering.elements.dictionaries;

/**
 * Created with IntelliJ IDEA.
 * User: demidovskiy-r
 * Date: 16.09.13
 * Time: 16:09
 */
public enum Format {
    SAME_AS_MASTER("Same as Master", "Same as Master"),
    AS_REQUIRED("As required", "As required"),
    HD_1080i_29_97FPS("f1:video:master:HD:1920x1080i@29.97fps:NTSC:16x9:MPEG2:TS:I-Frame", "HD 1080i 29.97fps"),
    HD_1080i_25FPS("f1:video:master:HD:1920x1080i@25fps:PAL:16x9:MPEG2:TS:I-Frame", "HD 1080i 25fps"),
    SD_NTSC_4x3("f1:video:master:SD:720x480i@29.97fps:NTSC:4x3:50Mbps", "SD NTSC 4x3"),
    SD_PAL_16x9("f1:video:master:SD:720x576i@25fps:PAL:16x9:50Mbps", "SD PAL 16x9"),
    SD_PAL_4x3("f1:video:master:SD:720x576i@25fps:PAL:4x3:50Mbps", "SD PAL 4x3");

    private String format;
    private String name;

    private Format(String format, String name) {
        this.format = format;
        this.name = name;
    }

    @Override
    public String toString() {
        return format;
    }

    public String getName(){
        return name;
    }

    public static String findByName(String name) {
        for (Format f : values())
            if (f.getName().equals(name))
                return f.toString();
        throw new IllegalArgumentException("Unknown format name: " + name);
    }
}