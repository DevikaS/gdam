package com.adstream.automate.babylon.JsonObjects.ordering.billing;

import java.util.List;

/*
 * Created by demidovskiy-r on 07.07.2014.
 */
public class Payment {
    private String SOID;
    private List<PayItem> Items;
    private String DocCur;
    private String DocSymbol;
    private String GrosProfit;
    private String VatSum;
    private String DiscPrcnt;
    private String DocTotal;

    public String getSOID() {
        return SOID;
    }

    public void setSOID(String SOID) {
        this.SOID = SOID;
    }

    public List<PayItem> getItems() {
        return Items;
    }

    public void setItems(List<PayItem> items) {
        Items = items;
    }

    public String getDocCur() {
        return DocCur;
    }

    public void setDocCur(String docCur) {
        DocCur = docCur;
    }

    public String getDocSymbol() {
        return DocSymbol;
    }

    public void setDocSymbol(String docSymbol) {
        DocSymbol = docSymbol;
    }

    public String getGrosProfit() {
        return GrosProfit;
    }

    public void setGrosProfit(String grosProfit) {
        GrosProfit = grosProfit;
    }

    public String getVatSum() {
        return VatSum;
    }

    public void setVatSum(String vatSum) {
        VatSum = vatSum;
    }

    public String getDiscPrcnt() {
        return DiscPrcnt;
    }

    public void setDiscPrcnt(String discPrcnt) {
        DiscPrcnt = discPrcnt;
    }

    public String getDocTotal() {
        return DocTotal;
    }

    public void setDocTotal(String docTotal) {
        DocTotal = docTotal;
    }
}