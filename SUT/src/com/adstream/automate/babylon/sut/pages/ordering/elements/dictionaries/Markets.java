package com.adstream.automate.babylon.sut.pages.ordering.elements.dictionaries;

/*
 * Created by demidovskiy-r on 12.08.2014.
 */
public enum Markets {
    FRANCE("France", "fr"),
    DISNEY_PAN_NORDIC("Disney Pan Nordic", "d-"),   // country code is d#, but it has been converted to d- for flag on front side to avoid characters problem
    SPAIN("Spain", "ES"),
    SWITZERLAND("Switzerland", "ch"),
    GERMANY("Germany", "de"),
    AUSTRIA("Austria", "at"),
    NETHERLANDS("Netherlands", "nl"),
    BRASIL("Brasil", "br"),
    AUSTRALIA("Australia", "au"),
    BELGIUM("Belgium", "be"),
    CHILE("Chile", "cl"),
    MEXICO("Mexico", "mx"),
    VENEZUELA("Venezuela", "ve"),
    SWEDEN("Sweden", "se"),
    UAE("United Arab Emirates", "ae");

    private String name;
    private String countryCode;

    private Markets(String name, String countryCode) {
        this.name = name;
        this.countryCode = countryCode;
    }

    @Override
    public String toString() {
        return name;
    }

    public String getCountryCode() {
        return countryCode;
    }

    public static Markets findByName(String name) {
        for (Markets market : values())
            if (market.toString().equals(name))
                return market;
        throw new IllegalArgumentException("Unknown market: " + name);
    }
}