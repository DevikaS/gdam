package com.adstream.automate.babylon.JsonObjects.ordering.billing;

/*
 * Created by demidovskiy-r on 04.07.2014.
 */
public class Price {
    private String QUOTID;
    private PriceItem[] Items;
    private String DocCur;
    private String DocSymbol;
    private String GrosProfit;
    private String VatSum;
    private String DiscPrcnt;
    private String DocTotal;
    private CreditStatus CreditStatus;
    private Integer RelatedDoc;
    private String SLD;

    public String getQUOTID() {
        return QUOTID;
    }

    public void setQUOTID(String QUOTID) {
        this.QUOTID = QUOTID;
    }

    public PriceItem[] getItems() {
        return Items;
    }

    public void setItems(PriceItem[] items) {
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

    public CreditStatus getCreditStatus() {
        return CreditStatus;
    }

    public void setCreditStatus(CreditStatus creditStatus) {
        CreditStatus = creditStatus;
    }

    public Integer getRelatedDoc() {
        return RelatedDoc;
    }

    public void setRelatedDoc(Integer relatedDoc) {
        RelatedDoc = relatedDoc;
    }

    public String getSLD() {
        return SLD;
    }

    public void setSLD(String SLD) {
        this.SLD = SLD;
    }
}