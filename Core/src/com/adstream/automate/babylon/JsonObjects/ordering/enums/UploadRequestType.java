package com.adstream.automate.babylon.JsonObjects.ordering.enums;

/*
 * Created by demidovskiy on 20.01.14.
 */
public enum UploadRequestType {
    FTP("FTP"),
    PHYSICAL("Physical"),
    NVERGE("nVerge"),
    GENERICS("Generics");

    private String name;

    private UploadRequestType(String name) {
        this.name = name;
    }

    public static UploadRequestType findByName(String name) {
        for (UploadRequestType uploadRequestType: values())
            if (uploadRequestType.toString().equals(name))
                return uploadRequestType;
        throw new IllegalArgumentException("Unknown upload request type: " + name);
    }

    @Override
    public String toString() {
        return name;
    }
}