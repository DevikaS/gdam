package com.adstream.automate.babylon.JsonObjects.ordering.billing;

/*
 * Created by demidovskiy-r on 04.07.2014.
 */
public class CreditStatus {
    private Integer Valid;
    private String CreditAvailable;
    private String CreditExceeded;

    public Integer getValid() {
        return Valid;
    }

    public void setValid(Integer valid) {
        Valid = valid;
    }

    public String getCreditAvailable() {
        return CreditAvailable;
    }

    public void setCreditAvailable(String creditAvailable) {
        CreditAvailable = creditAvailable;
    }

    public String getCreditExceeded() {
        return CreditExceeded;
    }

    public void setCreditExceeded(String creditExceeded) {
        CreditExceeded = creditExceeded;
    }
}