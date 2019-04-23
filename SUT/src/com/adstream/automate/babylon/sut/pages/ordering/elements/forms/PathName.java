package com.adstream.automate.babylon.sut.pages.ordering.elements.forms;

/*
 * Created by demidovskiy-r on 06.01.2015.
 */
public enum PathName {
    CLOCK_NUMBER("clockNumber"),
    ADVERTISER("advertiser"),
    BRAND("brand"),
    SUB_BRAND("sub_brand"),
    PRODUCT("product"),
    CAMPAIGN("Campaign"),
    TITLE("title"),
    DURATION("duration"),
    FIRST_AIR_DATE("firstAirDate"),
    FORMAT("format"),
    SUBTITLES_REQUIRED("subtitlesRequired"),
    ADDITIONAL_INFORMATION("additionalInformation"),
    MEDIA_AGENCY("mediaAgency"),
    CREATIVE_AGENCY("creativeAgency"),
    POST_HOUSE("posthouse"),
    CLAVE("clave"),
    WATERMARKING_REQUIRED("watermarkingRequired"),
    WATERMARKING_CODE("watermarkingCode"),
    WATERMARKING_BRAND("brand"),
    MODEL("model"),
    PRODUCT_DESCRIPTION("productDescription"),
    CREATIVE_DESCRIPTION("creativeDescription"),
    SECTOR("sector"),
    GROUP("group"),
    WATERMARKING_PRODUCT("product"),
    CREATIVE_AGENCY_CONTACT("creativeAgencyContact"),
    LANGUAGE("language"),
    MEDIA_AGENCY_CONTACT("mediaAgencyContact"),
    MBCID_CODE("mbcidCode"),
    CATEGORIA_MERCEOLOGICA_SETTORE("categoria"),
    MATCH("match"),
    MEDIA_SUB_TYPE("mediaSubtype"),
    TYPE("type"),
    MARKET_SEGMENT("marketSegment"),
    CRT("crt"),
    DATE_OF_ANCINE_REGISTRATION("dateOfAncineReg"),
    DIRECTOR("director"),
    NUMBER_OF_VERSIONS("numberOfVersions"),
    CNPJ("cnpj"),
    TYPE_DE_MENTIONS("typeDeMentions"),
    MENTIONS("mentions"),
    ARPP_VERSION_NUMBER("version"),
    ARPP_SUBMISSION_NUMBER("sNumber"),
    ARPP_SUBMISSION_RESULTS("sResults"),
    ARPP_SUBMISSION_COMMENTS_CODE("sCommentsCode"),
    ARPP_SUBMISSION_DETAILS("sDetails"),
    DISNEY_CODE("disneyCode"),
    SUISA("suisa"),
    MOTIVNUMMER("motivnummer"),
    SUJET_AKM("sujetAkm"),
    DELIVERY_TITLE("deliveryTitle"),
    VERSION("version"),
    CAD_NO("cadNo"),
    MEGATIME_CODE("megatimeCode"),
    TELEVISA_ID("televisaId"),
    RIF_CODE("rifCode"),
    TYPE_OF_COMMERCIAL("mediaSubtype");

    private String pathName;

    private PathName(String pathName) {
        this.pathName = pathName;
    }

    @Override
    public String toString() {
        return pathName;
    }
}