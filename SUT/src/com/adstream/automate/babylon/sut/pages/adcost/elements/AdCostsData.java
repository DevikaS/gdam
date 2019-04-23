package com.adstream.automate.babylon.sut.pages.adcost.elements;

import java.util.Map;

/**
 * Created by Raja.Gone on 23/05/2017.
 */
public class AdCostsData {
    public static boolean containsField(AdCostsSchemaField field, Map<String, String> data, boolean withEmptyCheck) {
        String[] fieldNames = field.getNames();
        for (String fieldName : fieldNames)
            if (withEmptyCheck ? data.containsKey(fieldName) && !data.get(fieldName).isEmpty() : data.containsKey(fieldName))
                return true;
        return false;
    }

    public static String getField(AdCostsSchemaField field, Map<String, String> data) {
        String[] fieldNames = field.getNames();
        for (String fieldName : fieldNames)
            if (data.containsKey(fieldName))
                return data.get(fieldName);
        throw new IllegalArgumentException("Unknown field is present!");
    }

    public static String getPrimaryFieldName(AdCostsSchemaField field) {
        return field.toString();
    }

    public static void removeExtraField(AdCostsSchemaField field, Map<String, String> data) {
        String[] fieldNames = field.getNames();
        for (int i = 0; i < fieldNames.length; i++)
            if (data.containsKey(fieldNames[i]))
                data.remove(fieldNames[i]);
    }
}
