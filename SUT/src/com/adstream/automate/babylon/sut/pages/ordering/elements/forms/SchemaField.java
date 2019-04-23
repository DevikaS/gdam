package com.adstream.automate.babylon.sut.pages.ordering.elements.forms;

/**
 * Created with IntelliJ IDEA.
 * User: demidovskiy-r
 * Date: 04.11.13
 * Time: 19:13
 */
public enum SchemaField {
    CLOCK_NUMBER(PathName.CLOCK_NUMBER, "Clock Number", "ISRC Code", "AdID/ISCI", "Spotgate Code", "Copy Code"),
    ADVERTISER(PathName.ADVERTISER, "Advertiser", "Record Company"),
    BRAND(PathName.BRAND, "Brand"),
    SUB_BRAND(PathName.SUB_BRAND, "Sub Brand"),
    PRODUCT(PathName.PRODUCT, "Product", "Label"),
    CAMPAIGN(PathName.CAMPAIGN, "Campaign", "Artist"),
    TITLE(PathName.TITLE, "Title"),
    DURATION(PathName.DURATION, "Duration"),
    FIRST_AIR_DATE(PathName.FIRST_AIR_DATE, "First Air Date", "Release Date"),
    FORMAT(PathName.FORMAT, "Format"),
    SUBTITLES_REQUIRED(PathName.SUBTITLES_REQUIRED, "Subtitles Required"),
    MEDIA_AGENCY(PathName.MEDIA_AGENCY, "Media Agency"),
    CREATIVE_AGENCY(PathName.CREATIVE_AGENCY, "Creative Agency"),
    POST_HOUSE(PathName.POST_HOUSE, "Post House"),
    ADDITIONAL_INFORMATION(PathName.ADDITIONAL_INFORMATION, "Additional Information"),
    CLAVE(PathName.CLAVE, "Clave"),
    WATERMARKING_REQUIRED(PathName.WATERMARKING_REQUIRED, "Watermarking Required"),
    WATERMARKING_CODE(PathName.WATERMARKING_CODE, "Watermarking Code"),
    WATERMARKING_BRAND(PathName.WATERMARKING_BRAND, "Watermarking Brand"),
    MODEL(PathName.MODEL, "Model"),
    PRODUCT_DESCRIPTION(PathName.PRODUCT_DESCRIPTION, "Product Description"),
    CREATIVE_DESCRIPTION(PathName.CREATIVE_DESCRIPTION, "Creative Description"),
    SECTOR(PathName.SECTOR, "Sector"),
    GROUP(PathName.GROUP, "Group"),
    WATERMARKING_PRODUCT(PathName.WATERMARKING_PRODUCT, "Watermarking Product"),
    CREATIVE_AGENCY_CONTACT(PathName.CREATIVE_AGENCY_CONTACT, "Creative Agency Contact"),
    LANGUAGE(PathName.LANGUAGE, "Language"),
    MEDIA_AGENCY_CONTACT(PathName.MEDIA_AGENCY_CONTACT, "Media Agency Contact"),
    MBCID_CODE(PathName.MBCID_CODE, "MBCID Code"),
    CATEGORIA_MERCEOLOGICA_SETTORE(PathName.CATEGORIA_MERCEOLOGICA_SETTORE, "Categoria Merceologica Settore"),
    MATCH(PathName.MATCH, "Match"),
    MEDIA_SUB_TYPE(PathName.MEDIA_SUB_TYPE, "Media Subtype"),
    TYPE(PathName.TYPE, "Type"),
    MARKET_SEGMENT(PathName.MARKET_SEGMENT, "Market Segment"),
    CRT(PathName.CRT, "CRT"),
    DATE_OF_ANCINE_REGISTRATION(PathName.DATE_OF_ANCINE_REGISTRATION, "Date of Ancine Registration"),
    DIRECTOR(PathName.DIRECTOR, "Director"),
    NUMBER_OF_VERSIONS(PathName.NUMBER_OF_VERSIONS, "Number of Versions"),
    CNPJ(PathName.CNPJ, "CNPJ"),
    TYPE_DE_MENTIONS(PathName.TYPE_DE_MENTIONS, "Type De Mentions"),
    MENTIONS(PathName.MENTIONS, "Mentions"),
    ARPP_VERSION_NUMBER(PathName.ARPP_VERSION_NUMBER, "ARPP Version Number"),
    ARPP_SUBMISSION_NUMBER(PathName.ARPP_SUBMISSION_NUMBER, "ARPP Submission Number"),
    ARPP_SUBMISSION_RESULTS(PathName.ARPP_SUBMISSION_RESULTS, "ARPP Submission Results"),
    ARPP_SUBMISSION_COMMENTS_CODE(PathName.ARPP_SUBMISSION_COMMENTS_CODE, "ARPP Submission Comments Code"),
    ARPP_SUBMISSION_DETAILS(PathName.ARPP_SUBMISSION_DETAILS, "ARPP Submission Details"),
    DISNEY_CODE(PathName.DISNEY_CODE, "Disney Code"),
    SUISA(PathName.SUISA, "Suisa"),
    MOTIVNUMMER(PathName.MOTIVNUMMER, "Motivnummer"),
    SUJET_AKM(PathName.SUJET_AKM, "SUJET/AKM"),
    DELIVERY_TITLE(PathName.DELIVERY_TITLE, "Delivery Title"),
    VERSION(PathName.VERSION, "Version"),
    CAD_NO(PathName.CAD_NO, "CAD#"),
    MEGATIME_CODE(PathName.MEGATIME_CODE, "Megatime Code"),
    TELEVISA_ID(PathName.TELEVISA_ID, "Televisa ID"),
    RIF_CODE(PathName.RIF_CODE, "RIF Code"),
    TYPE_OF_COMMERCIAL(PathName.TYPE_OF_COMMERCIAL, "Type of Commercial");

    private PathName pathName;
    private String[] names;

    private SchemaField(PathName pathName, String... names) {
        this.pathName = pathName;
        this.names = names;
    }

    public String[] getNames() {
        return names;
    }

    public static SchemaField findByName(String name) {
        for (SchemaField field : values())
            for (String fieldName : field.getNames())
                if (fieldName.equals(name))
                    return field;
        throw new IllegalArgumentException("Unknown field name: " + name);
    }

    @Override
    public String toString() {
        return names[0];
    }

    public PathName getPathName() {
        return pathName;
    }
}