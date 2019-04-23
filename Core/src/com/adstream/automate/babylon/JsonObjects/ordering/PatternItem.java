package com.adstream.automate.babylon.JsonObjects.ordering;

import com.adstream.automate.babylon.JsonObjects.CustomMetadata;

/*
 * Created by demidovskiy-r on 18.06.2014.
 */
public class PatternItem {
    private String type;
    private Integer characters;
    private String pattern;
    private String path;
    private Integer number_of_characters;
    private String character;

    public PatternItem(CustomMetadata cm) {
        setType(cm.getString("type"));
        setCharacters(cm.getInteger("characters"));
        setPattern(cm.getString("pattern"));
        setPath(cm.getString("path"));
        setNumberOfCharacters(cm.getInteger("number_of_characters"));
        setCharacter(cm.getString("character"));
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public Integer getCharacters() {
        return characters;
    }

    public void setCharacters(Integer characters) {
        this.characters = characters;
    }

    public String getPattern() {
        return pattern;
    }

    public void setPattern(String pattern) {
        this.pattern = pattern;
    }

    public String getPath() {
        return path;
    }

    public void setPath(String path) {
        this.path = path;
    }

    public Integer getNumberOfCharacters() {
        return number_of_characters;
    }

    public void setNumberOfCharacters(Integer number_of_characters) {
        this.number_of_characters = number_of_characters;
    }

    public String getCharacter() {
        return character;
    }

    public void setCharacter(String character) {
        this.character = character;
    }
}