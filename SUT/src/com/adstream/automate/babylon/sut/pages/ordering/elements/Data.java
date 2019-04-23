package com.adstream.automate.babylon.sut.pages.ordering.elements;

import com.adstream.automate.babylon.sut.pages.ordering.elements.forms.SchemaField;
import java.util.Map;

/**
 * Created with IntelliJ IDEA.
 * User: demidovskiy-r
 * Date: 22.12.13
 * Time: 23:10
 */
public class Data {

    public static boolean containsField(SchemaField field, Map<String, String> data, boolean withEmptyCheck) {
        String[] fieldNames = field.getNames();
        for (String fieldName : fieldNames)
            if (withEmptyCheck ? data.containsKey(fieldName) && !data.get(fieldName).isEmpty() : data.containsKey(fieldName))
                return true;
        return false;
    }

    public static String getField(SchemaField field, Map<String, String> data) {
        String[] fieldNames = field.getNames();
        for (String fieldName : fieldNames)
            if (data.containsKey(fieldName))
                return data.get(fieldName);
        throw new IllegalArgumentException("Unknown field is present!");
    }

    public static String getPrimaryFieldName(SchemaField field) {
        return field.toString();
    }

    public static void removeExtraField(SchemaField field, Map<String, String> data) {
        String[] fieldNames = field.getNames();
        for (int i = 1; i < fieldNames.length; i++)
            if (data.containsKey(fieldNames[i]))
                data.remove(fieldNames[i]);
    }
}