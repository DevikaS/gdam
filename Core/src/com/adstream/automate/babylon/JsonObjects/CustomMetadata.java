package com.adstream.automate.babylon.JsonObjects;

import com.google.gson.internal.LinkedTreeMap;
import org.joda.time.DateTime;
import org.joda.time.DateTimeZone;

import java.lang.reflect.Array;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * User: ruslan.semerenko
 * Date: 14.02.13 13:11
 */
public class CustomMetadata extends HashMap<String, Object> {
    public CustomMetadata() {
        super();
    }

    public CustomMetadata(Map<String, Object> m) {
        super(m);
    }

    public CustomMetadata getOrCreateNode(String key) {
        if (containsKey(key)) {
            Object o = get(key);
            if (o instanceof Map && !(o instanceof CustomMetadata)) {
                put(key, new CustomMetadata((Map<String, Object>)o));
            }
        } else {
            this.put(key, new CustomMetadata());
        }

        return (CustomMetadata)get(key);
    }

    public CustomMetadata getOrCreateNodeForPath(String path) {
        CustomMetadata meta = this;
        for (String key : path.split("\\.")) {
            meta = meta.getOrCreateNode(key);
        }
        return meta;
    }

    public String getString(String key) {
        return (String) get(key);
    }

    public Integer getInteger(String key) {
        Long value = getLong(key);

        return value == null ? null : value.intValue();
    }

    public Long getLong(String key) {
        Object value = get(key);
        if (value instanceof Double) {
            put(key, ((Double) value).longValue());
        } else if (value instanceof String) {
            put(key, Long.parseLong((String) value));
        }  else if (value instanceof Integer) {
            put(key, ((Integer) value).longValue());
        } else if (value instanceof LinkedTreeMap){
           Double dub = Double.valueOf((String)((LinkedTreeMap) value).get(key).toString()).doubleValue();
            put(key, ((Double) dub).longValue());
        }

        return (Long) get(key);
    }

    public Double getDouble(String key) {
        Object value = get(key);
        if (value instanceof Long) {
            put(key, ((Long) value).doubleValue());
        } else if (value instanceof Integer) {
            put(key, ((Integer) value).doubleValue());
        }

        return (Double) get(key);
    }

    public Boolean getBoolean(String key) {
        return (Boolean) get(key);
    }

    public DateTime getDateTime(String key) {
        return getForClass(key, DateTime.class);
    }

    public Identity getIdentity(String key) {
        return getForClass(key, Identity.class);
    }

    public String[] getStringArray(String key) {
        return getArrayForClass(key, String.class);
    }

    public <T> T getForClass(String key, Class<T> clazz) {
        Object value = get(key);
        T obj = castOrDeserialize(value, clazz);
        put(key, obj);
        return obj;
    }

    public <T> T[] getArrayForClass(String key, Class<T> clazz) {
        Object value = get(key);
        if (value == null) {
            return null;
        } else if (value.getClass().isArray() && value.getClass().getComponentType() == clazz) {
            return (T[]) value;
        } else if (value instanceof List) {
            List<T> list = (List<T>) value;
            T[] array = (T[]) Array.newInstance(clazz, list.size());
            for (int i = 0; i < list.size(); i++) {
                T obj = castOrDeserialize(list.get(i), clazz);
                array[i] = obj;
            }
            put(key, array);
            return array;
        } else if (value.getClass() == clazz) {
            T[] array = (T[]) Array.newInstance(clazz, 1);
            array[0] = (T) value;
            put(key, array);
            return array;
        } else {
            throw new ClassCastException(String.format("Could not create %s array from %s", clazz, value.getClass()));
        }
    }

    protected <T> T castOrDeserialize(Object obj, Class<T> clazz) {
        if (obj == null) {
            return null;
        } else if (obj.getClass() == clazz) {
            return (T) obj;
        } else if (obj instanceof Map) {
            return deserialize((Map) obj, clazz);
        } else if (clazz == DateTime.class) {
            return (T) new DateTime(obj, DateTimeZone.UTC);
        } else {
            throw new ClassCastException(String.format("Could not create %s from %s", clazz, obj.getClass()));
        }
    }

    protected <T> T deserialize(Map fields, Class<T> clazz) {
        try {
            return clazz.getConstructor(CustomMetadata.class).newInstance(new CustomMetadata(fields));
        } catch (NoSuchMethodException e) {
            throw new ClassCastException(String.format("%s hasn't constructor to instantiate from Map", clazz));
        } catch (Exception e) {
            throw new ClassCastException(String.format("Something goes wrong. Could not create %s instance from map", clazz));
        }
    }
}
