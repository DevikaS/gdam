package com.adstream.automate.babylon;

import com.adstream.automate.utils.Common;

import java.lang.reflect.Field;
import java.lang.reflect.Modifier;

/**
 * User: ruslan.semerenko
 * Date: 06.07.12 14:21
 */
public class SearchingParams {
    public String toGetParams() {
        StringBuilder str = new StringBuilder();
        for (Field field : this.getClass().getDeclaredFields()) {
            if (Modifier.isStatic(field.getModifiers())) continue;
            try {
                field.setAccessible(true);
                Object obj = field.get(this);
                if (obj != null) {
                    String key = Common.urlEncode(field.getName());
                    String value = Common.urlEncode(obj.toString());
                    str.append("&").append(key).append("=").append(value);
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return str.toString();
    }
}
