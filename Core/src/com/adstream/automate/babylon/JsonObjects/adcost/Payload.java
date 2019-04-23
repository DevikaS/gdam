package com.adstream.automate.babylon.JsonObjects.adcost;

/**
 * Created by Raja.Gone on 06/06/2017.
 */
public class Payload {
    private String startDate;

    private String vendor;

    private String categoryId;

    private String itemCode;

    private String accountCode;

    private String poNumber;

    private String commodity;

    private String ioNumber;

    private String tNumber;

    private String currency;

    private String costNumber;

    private String gl;

    private String basketName;

    private String description;

    private LongText longText;

    private String totalAmount;

    private String deliveryDate;

    private String requisitionerEmail;

    private String paymentAmount;

    private String[] grNumbers;

    public String[] getGrNumbers ()
    {
        return grNumbers;
    }

    public void setGrNumbers (String[] grNumbers)
    {
        this.grNumbers = grNumbers;
    }

    public String getPaymentAmount() {
        return paymentAmount;
    }

    public void setPaymentAmount(String paymentAmount) {
        this.paymentAmount = paymentAmount;
    }

    public String getRequisitionerEmail() {
        return requisitionerEmail;
    }

    public void setRequisitionerEmail(String requisitionerEmail) {
        this.requisitionerEmail = requisitionerEmail;
    }

    public String getStartDate ()
    {
        return startDate;
    }

    public void setStartDate (String startDate)
    {
        this.startDate = startDate;
    }

    public String getVendor ()
    {
        return vendor;
    }

    public void setVendor (String vendor)
    {
        this.vendor = vendor;
    }

    public String getCategoryId ()
    {
        return categoryId;
    }

    public void setCategoryId (String categoryId)
    {
        this.categoryId = categoryId;
    }

    public String getAccountCode ()
    {
        return accountCode;
    }

    public void setAccountCode (String accountCode)
    {
        this.accountCode = accountCode;
    }

    public String getItemCode ()
    {
        return itemCode;
    }

    public void setItemCode (String itemCode)
    {
        this.itemCode = itemCode;
    }

    public String getPoNumber ()
    {
        return poNumber;
    }

    public void setPoNumber (String poNumber)
    {
        this.poNumber = poNumber;
    }

    public String getCommodity ()
    {
        return commodity;
    }

    public void setCommodity (String commodity)
    {
        this.commodity = commodity;
    }

    public String getIoNumber ()
    {
        return ioNumber;
    }

    public void setIoNumber (String ioNumber)
    {
        this.ioNumber = ioNumber;
    }

    public String getTNumber ()
    {
        return tNumber;
    }

    public void setTNumber (String tNumber)
    {
        this.tNumber = tNumber;
    }

    public String getCurrency ()
    {
        return currency;
    }

    public void setCurrency (String currency)
    {
        this.currency = currency;
    }

    public String getCostNumber ()
    {
        return costNumber;
    }

    public void setCostNumber (String costNumber)
    {
        this.costNumber = costNumber;
    }

    public String getGl ()
    {
        return gl;
    }

    public void setGl (String gl)
    {
        this.gl = gl;
    }

    public String getBasketName ()
    {
        return basketName;
    }

    public void setBasketName (String basketName)
    {
        this.basketName = basketName;
    }

    public String getDescription ()
    {
        return description;
    }

    public void setDescription (String description)
    {
        this.description = description;
    }

    public LongText getLongText ()
    {
        if(longText==null) longText = new LongText();
        return longText;
    }

    public void setLongText (LongText longText)
    {
        this.longText = longText;
    }

    public String getTotalAmount ()
    {
        return totalAmount;
    }

    public void setTotalAmount (String totalAmount)
    {
        this.totalAmount = totalAmount;
    }

    public String getDeliveryDate ()
    {
        return deliveryDate;
    }

    public void setDeliveryDate (String deliveryDate)
    {
        this.deliveryDate = deliveryDate;
    }
}
