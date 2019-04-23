package com.adstream.automate.babylon.JsonObjects.gdn;

import java.util.Objects;

/**
 * Created by Ramababu.Bendalam on 16/05/2016.
 */
public class MetaDataAttribute {


    private final String name;
    private final String value;

    public MetaDataAttribute(String name, String value) {
        this.name = name;
        this.value = value;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        MetaDataAttribute attribute = (MetaDataAttribute) o;
        return Objects.equals(name, attribute.name) &&
                Objects.equals(value, attribute.value);
    }

    @Override
    public int hashCode() {
        return Objects.hash(name, value);
    }

    @Override
    public String toString() {
        return "MetaDataAttribute{" +
                "name='" + name + '\'' +
                ", value='" + value + '\'' +
                '}';
    }

}


