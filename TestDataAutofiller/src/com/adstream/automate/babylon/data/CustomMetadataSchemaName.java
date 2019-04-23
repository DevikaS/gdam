package com.adstream.automate.babylon.data;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

/**
 * User: konstantin.lynda
 * Date: 22.02.13 13:31
 */
public class CustomMetadataSchemaName {
    public static final String COMMON = "common";
    public static final String PROJECT = "project";
    public static final String AUDIO = "audio";
    public static final String DIGITAL = "digital";
    public static final String DOCUMENT = "document";
    public static final String IMAGE = "image";
    public static final String PRINT = "print";
    public static final String VIDEO = "video";
    public static final String OTHER = "other";
    private static final List<String> schemaNames = new ArrayList<String>();

    public static boolean contains(String schema) {
        if (schemaNames.isEmpty())
            Collections.addAll(schemaNames, COMMON, PROJECT, AUDIO, DIGITAL, DOCUMENT, IMAGE, PRINT, VIDEO, OTHER);
        return schemaNames.contains(schema);
    }

    public static String findByName(String schema) {
        if (contains(schema))
            for (String name : schemaNames)
                if (name.equals(schema))
                    return name;
        throw new IllegalArgumentException("Unknown schema: " + schema);
    }

    public static boolean isCommonSchema(String schema) {
        return COMMON.equals(schema);
    }

    public static boolean isProjectSchema(String schema) {
        return PROJECT.equals(schema);
    }

    public static boolean isAssetSchema(String schema) {
        List<String> assetSchemaNames = new ArrayList<String>();
        Collections.addAll(assetSchemaNames, AUDIO, DIGITAL, DOCUMENT, IMAGE, PRINT, VIDEO, OTHER);

        return assetSchemaNames.contains(schema);
    }

    private CustomMetadataSchemaName() {}
}