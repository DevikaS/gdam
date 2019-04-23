package com.adstream.automate.babylon.JsonObjects.usagerights;

/**
 * Created with IntelliJ IDEA.
 * User: solomin-y
 * Date: 10/23/13
 * Time: 6:27 PM

 */
public class CountriesUsageRight implements UsageRight {
    private UsageCountry Countries;
    public Expiration expiration;

    public UsageCountry getCountries() {
        return Countries;
    }

    public void setCountries(UsageCountry countries) {
        Countries = countries;
    }

    public Expiration getExpiration() {
        return expiration;
    }

    public void setExpiration(Expiration expiration) {
        this.expiration = expiration;
    }
}
