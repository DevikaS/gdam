package com.adstream.automate.babylon.JsonObjects.ordering.templates;

import java.util.Map;

/*
 * Created by demidovskiy-r on 03.12.2014.
 */
public class DeliveryOrderReport {
    private DeliveryOrderReportTranslations translations;
    private String accountType;
    private String language;
    private String clockNumber;
    private String orderReference;
    private String orderType;
    private String jobNumber;
    private String poNumber;
    private String orderItemsCount;
    private String dateOrderSubmitted;
    private String commercialNumber;
    private String country;
    private String advertiserLabel;
    private String advertiser;
    private String brandLabel;
    private String brand;
    private String subBrandLabel;
    private String subBrand;
    private String productLabel;
    private String product;
    private String campaignLabel;
    private String campaign;
    private String title;
    private String duration;
    private String format;
    private String deliveryMethod;
    private String dateArrivedCommercials;
    private String timeArrivedCommercials;
    private String masterHeldAt;
    private String firstAirDate;
    private String archive;
    private String note;
    private String attachments;
    private String deliveryPoints;
    private String subtitlesRequired;
    private String languageMetadata;
    private String suisa;
    private String clave;
    private String watermarkingRequired;
    private String watermarkingCode;
    private String watermarkingBrand;
    private String model;
    private String watermarkingProductDescription;
    private String creativeDescription;
    private String sector;
    private String group;
    private String watermarkingProduct;
    private String serviceLevel;
    private String destinationGroup;
    private String destination;
    private String additionalInstruction;
    private String additionalServiceType;
    private String additionalServiceDestination;
    private String notesAndLabels;
    private String additionalServiceFormat;
    private String noCopies;
    private String mediaCompile;
    private String additionalServiceLevel;
    private String productionServiceType;
    private String productionServiceNote;
    private String addressMetadata;
    private String[] catalogueStructure;
    private String customCodeMetadata;
    private String dateMetadata;
    private String dropdownMetadata;
    private String hyperLinkMetadata;
    private String multiLineMetadata;
    private String phoneMetadata;
    private String radioButtonsMetadata;
    private String stringMetadata;

    public DeliveryOrderReport(Map<String, String> row) {
        initBaseFields(row);
        translations = new DeliveryOrderReportTranslations(getLanguage());
    }

    public DeliveryOrderReportTranslations getTranslations() {
        return translations;
    }

    public void setTranslations(DeliveryOrderReportTranslations translations) {
        this.translations = translations;
    }

    public String getAccountType() {
        return accountType;
    }

    public void setAccountType(String accountType) {
        this.accountType = accountType;
    }

    public String getLanguage() {
        return language;
    }

    public void setLanguage(String language) {
        this.language = language;
    }

    public String getClockNumber() {
        return clockNumber;
    }

    public void setClockNumber(String clockNumber) {
        this.clockNumber = clockNumber;
    }

    public String getOrderReference() {
        return orderReference;
    }

    public void setOrderReference(String orderReference) {
        this.orderReference = orderReference;
    }

    public String getOrderType() {
        return orderType;
    }

    public void setOrderType(String orderType) {
        this.orderType = orderType;
    }

    public String getJobNumber() {
        return jobNumber;
    }

    public void setJobNumber(String jobNumber) {
        this.jobNumber = jobNumber;
    }

    public String getPoNumber() {
        return poNumber;
    }

    public void setPoNumber(String poNumber) {
        this.poNumber = poNumber;
    }

    public String getOrderItemsCount() {
        return orderItemsCount;
    }

    public void setOrderItemsCount(String orderItemsCount) {
        this.orderItemsCount = orderItemsCount;
    }

    public String getDateOrderSubmitted() {
        return dateOrderSubmitted;
    }

    public void setDateOrderSubmitted(String dateOrderSubmitted) {
        this.dateOrderSubmitted = dateOrderSubmitted;
    }

    public String getCommercialNumber() {
        return commercialNumber;
    }

    public void setCommercialNumber(String commercialNumber) {
        this.commercialNumber = commercialNumber;
    }

    public String getCountry() {
        return country;
    }

    public void setCountry(String country) {
        this.country = country;
    }

    public String getAdvertiserLabel() {
        return advertiserLabel;
    }

    public void setAdvertiserLabel(String advertiserLabel) {
        this.advertiserLabel = advertiserLabel;
    }

    public String getAdvertiser() {
        return advertiser;
    }

    public void setAdvertiser(String advertiser) {
        this.advertiser = advertiser;
    }

    public String getBrandLabel() {
        return brandLabel;
    }

    public void setBrandLabel(String brandLabel) {
        this.brandLabel = brandLabel;
    }

    public String getBrand() {
        return brand;
    }

    public void setBrand(String brand) {
        this.brand = brand;
    }

    public String getSubBrandLabel() {
        return subBrandLabel;
    }

    public void setSubBrandLabel(String subBrandLabel) {
        this.subBrandLabel = subBrandLabel;
    }

    public String getSubBrand() {
        return subBrand;
    }

    public void setSubBrand(String subBrand) {
        this.subBrand = subBrand;
    }

    public String getProductLabel() {
        return productLabel;
    }

    public void setProductLabel(String productLabel) {
        this.productLabel = productLabel;
    }

    public String getProduct() {
        return product;
    }

    public void setProduct(String product) {
        this.product = product;
    }

    public String getCampaignLabel() {
        return campaignLabel;
    }

    public void setCampaignLabel(String campaignLabel) {
        this.campaignLabel = campaignLabel;
    }

    public String getCampaign() {
        return campaign;
    }

    public void setCampaign(String campaign) {
        this.campaign = campaign;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDuration() {
        return duration;
    }

    public void setDuration(String duration) {
        this.duration = duration;
    }

    public String getFormat() {
        return format;
    }

    public void setFormat(String format) {
        this.format = format;
    }

    public String getDeliveryMethod() {
        return deliveryMethod;
    }

    public void setDeliveryMethod(String deliveryMethod) {
        this.deliveryMethod = deliveryMethod;
    }

    public String getDateArrivedCommercials() {
        return dateArrivedCommercials;
    }

    public void setDateArrivedCommercials(String dateArrivedCommercials) {
        this.dateArrivedCommercials = dateArrivedCommercials;
    }

    public String getTimeArrivedCommercials() {
        return timeArrivedCommercials;
    }

    public void setTimeArrivedCommercials(String timeArrivedCommercials) {
        this.timeArrivedCommercials = timeArrivedCommercials;
    }

    public String getMasterHeldAt() {
        return masterHeldAt;
    }

    public void setMasterHeldAt(String masterHeldAt) {
        this.masterHeldAt = masterHeldAt;
    }

    public String getFirstAirDate() {
        return firstAirDate;
    }

    public void setFirstAirDate(String firstAirDate) {
        this.firstAirDate = firstAirDate;
    }

    public String getArchive() {
        return archive;
    }

    public void setArchive(String archive) {
        this.archive = archive;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public String getAttachments() {
        return attachments;
    }

    public void setAttachments(String attachments) {
        this.attachments = attachments;
    }

    public String getDeliveryPoints() {
        return deliveryPoints;
    }

    public void setDeliveryPoints(String deliveryPoints) {
        this.deliveryPoints = deliveryPoints;
    }

    public String getSubtitlesRequired() {
        return subtitlesRequired;
    }

    public void setSubtitlesRequired(String subtitlesRequired) {
        this.subtitlesRequired = subtitlesRequired;
    }

    public String getLanguageMetadata() {
        return languageMetadata;
    }

    public void setLanguageMetadata(String languageMetadata) {
        this.languageMetadata = languageMetadata;
    }

    public String getSuisa() {
        return suisa;
    }

    public void setSuisa(String suisa) {
        this.suisa = suisa;
    }

    // metadata of Spain market
    public String getClave() {
        return clave;
    }

    public void setClave(String clave) {
        this.clave = clave;
    }

    public String getWatermarkingRequired() {
        return watermarkingRequired;
    }

    public void setWatermarkingRequired(String watermarkingRequired) {
        this.watermarkingRequired = watermarkingRequired;
    }

    public String getWatermarkingCode() {
        return watermarkingCode;
    }

    public void setWatermarkingCode(String watermarkingCode) {
        this.watermarkingCode = watermarkingCode;
    }

    public String getWatermarkingBrand() {
        return watermarkingBrand;
    }

    public void setWatermarkingBrand(String watermarkingBrand) {
        this.watermarkingBrand = watermarkingBrand;
    }

    public String getModel() {
        return model;
    }

    public void setModel(String model) {
        this.model = model;
    }

    public String getWatermarkingProductDescription() {
        return watermarkingProductDescription;
    }

    public void setWatermarkingProductDescription(String watermarkingProductDescription) {
        this.watermarkingProductDescription = watermarkingProductDescription;
    }

    public String getCreativeDescription() {
        return creativeDescription;
    }

    public void setCreativeDescription(String creativeDescription) {
        this.creativeDescription = creativeDescription;
    }

    public String getSector() {
        return sector;
    }

    public void setSector(String sector) {
        this.sector = sector;
    }

    public String getGroup() {
        return group;
    }

    public void setGroup(String group) {
        this.group = group;
    }

    public String getWatermarkingProduct() {
        return watermarkingProduct;
    }

    public void setWatermarkingProduct(String watermarkingProduct) {
        this.watermarkingProduct = watermarkingProduct;
    }

    public String getServiceLevel() {
        return serviceLevel;
    }

    public void setServiceLevel(String serviceLevel) {
        this.serviceLevel = serviceLevel;
    }

    public String getDestinationGroup() {
        return destinationGroup;
    }

    public void setDestinationGroup(String destinationGroup) {
        this.destinationGroup = destinationGroup;
    }

    public String getDestination() {
        return destination;
    }

    public void setDestination(String destination) {
        this.destination = destination;
    }

    public String getAdditionalInstruction() {
        return additionalInstruction;
    }

    public void setAdditionalInstruction(String additionalInstruction) {
        this.additionalInstruction = additionalInstruction;
    }

    public String getAdditionalServiceType() {
        return additionalServiceType;
    }

    public void setAdditionalServiceType(String additionalServiceType) {
        this.additionalServiceType = additionalServiceType;
    }

    public String getAdditionalServiceDestination() {
        return additionalServiceDestination;
    }

    public void setAdditionalServiceDestination(String additionalServiceDestination) {
        this.additionalServiceDestination = additionalServiceDestination;
    }

    public String getNotesAndLabels() {
        return notesAndLabels;
    }

    public void setNotesAndLabels(String notesAndLabels) {
        this.notesAndLabels = notesAndLabels;
    }

    public String getAdditionalServiceFormat() {
        return additionalServiceFormat;
    }

    public void setAdditionalServiceFormat(String additionalServiceFormat) {
        this.additionalServiceFormat = additionalServiceFormat;
    }

    public String getNoCopies() {
        return noCopies;
    }

    public void setNoCopies(String noCopies) {
        this.noCopies = noCopies;
    }

    public String getMediaCompile() {
        return mediaCompile;
    }

    public void setMediaCompile(String mediaCompile) {
        this.mediaCompile = mediaCompile;
    }

    public String getAdditionalServiceLevel() {
        return additionalServiceLevel;
    }

    public void setAdditionalServiceLevel(String additionalServiceLevel) {
        this.additionalServiceLevel = additionalServiceLevel;
    }

    public String getProductionServiceType() {
        return productionServiceType;
    }

    public void setProductionServiceType(String productionServiceType) {
        this.productionServiceType = productionServiceType;
    }

    public String getProductionServiceNote() {
        return productionServiceNote;
    }

    public void setProductionServiceNote(String productionServiceNote) {
        this.productionServiceNote = productionServiceNote;
    }

    public String getAddressMetadata() {
        return addressMetadata;
    }

    public void setAddressMetadata(String addressMetadata) {
        this.addressMetadata = addressMetadata;
    }

    public String[] getCatalogueStructure() {
        return catalogueStructure;
    }

    public void setCatalogueStructure(String[] catalogueStructure) {
        this.catalogueStructure = catalogueStructure;
    }

    public String getCustomCodeMetadata() {
        return customCodeMetadata;
    }

    public void setCustomCodeMetadata(String customCodeMetadata) {
        this.customCodeMetadata = customCodeMetadata;
    }

    public String getDateMetadata() {
        return dateMetadata;
    }

    public void setDateMetadata(String dateMetadata) {
        this.dateMetadata = dateMetadata;
    }

    public String getDropdownMetadata() {
        return dropdownMetadata;
    }

    public void setDropdownMetadata(String dropdownMetadata) {
        this.dropdownMetadata = dropdownMetadata;
    }

    public String getHyperLinkMetadata() {
        return hyperLinkMetadata;
    }

    public void setHyperLinkMetadata(String hyperLinkMetadata) {
        this.hyperLinkMetadata = hyperLinkMetadata;
    }

    public String getMultiLineMetadata() {
        return multiLineMetadata;
    }

    public void setMultiLineMetadata(String multiLineMetadata) {
        this.multiLineMetadata = multiLineMetadata;
    }

    public String getPhoneMetadata() {
        return phoneMetadata;
    }

    public void setPhoneMetadata(String phoneMetadata) {
        this.phoneMetadata = phoneMetadata;
    }

    public String getRadioButtonsMetadata() {
        return radioButtonsMetadata;
    }

    public void setRadioButtonsMetadata(String radioButtonsMetadata) {
        this.radioButtonsMetadata = radioButtonsMetadata;
    }

    public String getStringMetadata() {
        return stringMetadata;
    }

    public void setStringMetadata(String stringMetadata) {
        this.stringMetadata = stringMetadata;
    }

    private void initBaseFields(Map<String, String> row) {
        accountType = row.get("Account Type");
        language = row.get("Language");
        clockNumber = row.get("Clock Number");
        orderReference = row.get("Order Reference");
        orderType = row.get("Order Type");
        jobNumber = row.get("Job Number");
        poNumber = row.get("PO Number");
        orderItemsCount = row.get("Order Items Count");
        dateOrderSubmitted = row.get("Date Order Submitted");
        commercialNumber = row.get("Commercial Number");
        country = row.get("Country");
        advertiserLabel = row.get("Advertiser Description");
        advertiser = row.get("Advertiser");
        brandLabel = row.get("Brand Description");
        brand = row.get("Brand");
        subBrandLabel = row.get("Sub Brand Description");
        subBrand = row.get("Sub Brand");
        productLabel = row.get("Product Description");
        product = row.get("Product");
        campaignLabel = row.get("Campaign Description");
        campaign = row.get("Campaign");
        title = row.get("Title");
        duration = row.get("Duration");
        format = row.get("Format");
        deliveryMethod = row.get("Delivery Method");
        dateArrivedCommercials = row.get("Deadline Date");
        timeArrivedCommercials = row.get("Time Arrived");
        masterHeldAt = row.get("Master Held At");
        firstAirDate = row.get("First Air Date");
        archive = row.get("Archive");
        note = row.get("Note");
        attachments = row.get("Attachments");
        deliveryPoints = row.get("Delivery Points");
        subtitlesRequired = row.get("Subtitles Required");
        languageMetadata = row.get("Language Metadata");
        suisa = row.get("Suisa");
        clave = row.get("Clave");
        watermarkingRequired = row.get("Watermarking Required");
        watermarkingCode = row.get("Watermarking Code");
        watermarkingBrand = row.get("Watermarking Brand");
        model = row.get("Model");
        watermarkingProductDescription = row.get("Watermarking Product Description");
        creativeDescription = row.get("Creative Description");
        sector = row.get("Sector");
        group = row.get("Group");
        watermarkingProduct = row.get("Watermarking Product");
        serviceLevel = row.get("Service Level");
        destinationGroup = row.get("Destination Group");
        destination = row.get("Destination");
        additionalInstruction = row.get("Additional Instruction");
        additionalServiceType = row.get("Additional Service Type");
        additionalServiceDestination = row.get("Additional Service Destination");
        notesAndLabels = row.get("Notes & Labels");
        additionalServiceFormat = row.get("Additional Service Format");
        noCopies = row.get("No copies");
        mediaCompile = row.get("Media Compile");
        additionalServiceLevel = row.get("Additional Service Level");
        productionServiceType = row.get("Additional Production Service Type");
        productionServiceNote = row.get("Additional Production Service Note");
        addressMetadata = row.get("Address");
        catalogueStructure = row.get("Catalogue Structure") == null ? new String[]{} : row.get("Catalogue Structure").split(",");
        customCodeMetadata = row.get("Custom Code");
        dateMetadata = row.get("Date");
        dropdownMetadata = row.get("Dropdown");
        hyperLinkMetadata = row.get("Hyperlink");
        multiLineMetadata = row.get("Multiline");
        phoneMetadata = row.get("Phone");
        radioButtonsMetadata = row.get("Radio Buttons");
        stringMetadata = row.get("String");
    }
}