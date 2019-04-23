package com.adstream.automate.babylon.sut.pages.NewLibrary.elements;

/**
 * Created by Janaki.Kamat on 29/06/2017.
 */
public enum SelectionType {
    BY_ITEMS("Using selected items"),
    BY_FILTERS("Using filters");

    private String type;

    private SelectionType(String selectionType) {
        this.type = selectionType;
    }

    public String getType(){
        return type;
    }


    public static SelectionType findByType(String type){
        for (SelectionType selectionType : values()) {
            if(selectionType.getType().equals(type))
                return selectionType;
        }
        throw new IllegalArgumentException("Unknown Selection type: " + type);
    }

    public String toString() {
        return this.type;
    }

}
