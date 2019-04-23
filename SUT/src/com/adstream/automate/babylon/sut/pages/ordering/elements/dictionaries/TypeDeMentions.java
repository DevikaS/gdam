package com.adstream.automate.babylon.sut.pages.ordering.elements.dictionaries;

/*
 * Created by demidovskiy-r on 01.08.2014.
 */
public enum TypeDeMentions {
    FOOD("Food / Alimentaire"),
    GAMBLING("Gambling / Jeux d'argent et de hasard"),
    KIDS_FOOD_MINUS_3YEARS_OLD("Kids food (-3 years old) / Alimentaire Enfant -3 ans"),
    KIDS_FOOD("Kids food / Alimentaire Enfant");

    private String name;

    private TypeDeMentions(String name) {
        this.name = name;
    }

    @Override
    public String toString() {
        return name;
    }

    public static String findByName(String name) {
        for (TypeDeMentions typeDeMentions : values())
            if (typeDeMentions.toString().equals(name))
                return typeDeMentions.toString();
        throw new IllegalArgumentException("Unknown type de mentions name: " + name);
    }
}