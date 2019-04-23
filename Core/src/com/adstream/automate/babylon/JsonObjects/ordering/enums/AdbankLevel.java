package com.adstream.automate.babylon.JsonObjects.ordering.enums;

/**
 * Created with IntelliJ IDEA.
 * User: demidovskiy-r
 * Date: 21.10.13
 * Time: 13:12
 */
public enum AdbankLevel {
    None(0, "None"),
    AdbankLite(1, "Adbank Lite"),
    AdbankStandard(2, "Adbank Standard"),
    AdbankPlus(3, "Adbank Plus"),
    AdbankPro(4, "Adbank Pro");

    private Integer key;
    private String name;

    private AdbankLevel(int key, String name) {
        this.key = key;
        this.name = name;
    }

    @Override
    public String toString() {
        return name;
    }
}