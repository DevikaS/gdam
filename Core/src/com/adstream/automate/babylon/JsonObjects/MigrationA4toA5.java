package com.adstream.automate.babylon.JsonObjects;

/**
 * Created with IntelliJ IDEA.
 * User: solomin-y
 * Date: 1/28/15
 * Time: 1:07 PM

 */
public class MigrationA4toA5 {

    private String xmlLocation;
    private boolean withPM = false;
    private boolean withODT;
    private boolean withWIP = false;
    private boolean withCM = true;
    private boolean deliveryOnly;
    private String source;
    private String fakeUserEmail;
    private String agencyName;
    private String a4UserEmail;
    private String fakeUserPass;

    public MigrationA4toA5() {}

    @Override
    public String toString() {
        String result = "Parameters: \n" + "xmlLocation : " + xmlLocation + ",\n" +
                "withPM : " + withPM + ",\n" + "withODT : " + withODT + ", " + "withWIP : " + withWIP + ", " + "withCM : " + withCM + ", " + "deliveryOnly : " + deliveryOnly + ",\n" +
                "source : " + source;
        if (!fakeUserEmail.isEmpty())
            result += ",\nfakeUserEmail : " + fakeUserEmail;
        if (!agencyName.isEmpty())
            result += ",\nagencyName : " + agencyName;
        if (a4UserEmail != null && !a4UserEmail.isEmpty())
            result += ",\na4UserEmail : " + a4UserEmail;
        if (fakeUserPass != null && !fakeUserPass.isEmpty())
            result += ",\nfakeUserPass : " + fakeUserPass;
        return result;
    }

    public MigrationA4toA5(String xmlLocation) {
        this.xmlLocation = xmlLocation;
    }

    public String getXmlLocation() {
        return xmlLocation;
    }

    public void setXmlLocation(String xmlLocation) {
        this.xmlLocation = xmlLocation;
    }

    public boolean isWithPM() {
        return withPM;
    }

    public void setWithPM(boolean withPM) {
        this.withPM = withPM;
    }

    public boolean isWithODT() {
        return withODT;
    }

    public void setWithODT(boolean withODT) {
        this.withODT = withODT;
    }

    public boolean isWithWIP() {
        return withWIP;
    }

    public void setWithWIP(boolean withWIP) {
        this.withWIP = withWIP;
    }

    public boolean isWithCM() {
        return withCM;
    }

    public void setWithCM(boolean withCM) {
        this.withCM = withCM;
    }

    public String getSource() {
        return source;
    }

    public void setSource(String source) {
        this.source = source;
    }

    public String getFakeUserEmail() {
        return fakeUserEmail;
    }

    public void setFakeUserEmail(String fakeUserEmail) {
        this.fakeUserEmail = fakeUserEmail;
    }

    public String getAgencyName() {
        return agencyName;
    }

    public void setAgencyName(String agencyName) {
        this.agencyName = agencyName;
    }

    public String getA4UserEmail() {
        return a4UserEmail;
    }

    public void setA4UserEmail(String a4UserEmail) {
        this.a4UserEmail = a4UserEmail;
    }

    public String getFakeUserPass() {
        return fakeUserPass;
    }

    public void setFakeUserPass(String fakeUserPass) {
        this.fakeUserPass = fakeUserPass;
    }

    public boolean isDeliveryOnly() {
        return deliveryOnly;
    }

    public void setDeliveryOnly(boolean deliveryOnly) {
        this.deliveryOnly = deliveryOnly;
    }
}
