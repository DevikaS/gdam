package com.adstream.automate.babylon.tests.steps.domain.ordering.section;

import com.adstream.automate.babylon.JsonObjects.CustomMetadata;
import com.adstream.automate.babylon.JsonObjects.User;
import com.adstream.automate.babylon.JsonObjects.mediamanager.PAPIApplication;
import com.adstream.automate.babylon.JsonObjects.ordering.*;
import com.adstream.automate.babylon.JsonObjects.ordering.enums.UploadRequestType;

import com.adstream.automate.babylon.PAPIServiceCalls;
import com.adstream.automate.babylon.sut.pages.ordering.elements.Data;
import com.adstream.automate.babylon.sut.pages.ordering.elements.OrderStatus;
import com.adstream.automate.babylon.sut.pages.ordering.elements.dictionaries.*;
import com.adstream.automate.babylon.sut.pages.ordering.elements.forms.SchemaField;
import com.adstream.automate.babylon.sut.pages.ordering.elements.forms.AddInformationForm;
import com.adstream.automate.babylon.sut.pages.ordering.elements.forms.AddInformationForm.GeneratedCodeType;
import com.adstream.automate.babylon.sut.pages.ordering.elements.forms.popupForms.ARPPLoginForm;
import com.adstream.automate.babylon.tests.steps.domain.ordering.DraftOrderSteps;
import com.adstream.automate.hamcrest.StringByRegExpCheck;
import com.adstream.automate.utils.Common;
import com.mongodb.BasicDBObject;
import com.mongodb.DBCollection;
import com.mongodb.DBObject;
import com.publicApi.jsonPayLoads.GsonClasses.BaseOfBase;
import org.apache.commons.codec.binary.Base64;
import org.jbehave.core.annotations.Alias;
import org.jbehave.core.annotations.Given;
import org.jbehave.core.annotations.Then;
import org.jbehave.core.annotations.When;
import org.jbehave.core.model.ExamplesTable;
import org.joda.time.DateTime;
import org.openqa.selenium.By;

import java.io.File;
import java.util.*;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.*;

/*
 * Created by demidovskiy-r on 30.05.2014.
 */
public class AddInformationSteps extends DraftOrderSteps {
    
    private AddInformationForm getAddInformationForm() {
        return getOrderItemPage().getAddInformationForm();
    }

    private OrderItem buildAddInformationSectionOfOrderItem(String market, OrderItem orderItem, Map<String, String> row) {
        if (Data.containsField(SchemaField.ADDITIONAL_INFORMATION, row, true))
            orderItem.setAdditionalInformation(Data.getField(SchemaField.ADDITIONAL_INFORMATION, row));
        if (Data.containsField(SchemaField.ADVERTISER, row, true))
            orderItem.setAdvertiser(new String[]{prepareAdvertiser(Data.getField(SchemaField.ADVERTISER, row))});
        if (Data.containsField(SchemaField.BRAND, row, true))
            orderItem.setBrand(new String[]{wrapVariableWithTestSession(Data.getField(SchemaField.BRAND, row))});
        if (Data.containsField(SchemaField.SUB_BRAND, row, true))
            orderItem.setSubBrand(new String[]{wrapVariableWithTestSession(Data.getField(SchemaField.SUB_BRAND, row))});
        if (Data.containsField(SchemaField.PRODUCT, row, true))
            orderItem.setProduct(new String[]{wrapVariableWithTestSession(Data.getField(SchemaField.PRODUCT, row))});
        if (Data.containsField(SchemaField.CAMPAIGN, row, true))
            orderItem.setCampaign(wrapVariableWithTestSession(Data.getField(SchemaField.CAMPAIGN, row)));
        if (Data.containsField(SchemaField.DURATION, row, true))
            orderItem.setDuration(Data.getField(SchemaField.DURATION, row));
        if (Data.containsField(SchemaField.CLOCK_NUMBER, row, true))
            orderItem.setClockNumber(wrapVariableWithTestSession(Data.getField(SchemaField.CLOCK_NUMBER, row)));
        if (Data.containsField(SchemaField.FIRST_AIR_DATE, row, true)) {
            DateTime firstAirDateTime = parseDateWithUTCZone(Data.getField(SchemaField.FIRST_AIR_DATE, row));
        /*  String formattedDate = dateTime.toString(DateTimeFormat.forPattern("yyyy-MM-dd'T'HH:mm:ss.SSSZ"));
            DateTime formattedDateTime = new DateTime(formattedDate);*/
            orderItem.setFirstAirDate(firstAirDateTime);
        }
        if (Data.containsField(SchemaField.FORMAT, row, true))
            orderItem.setFormat(new String[]{Format.findByName(Data.getField(SchemaField.FORMAT, row))});
        if (Data.containsField(SchemaField.TITLE, row, true))
            orderItem.setTitle(wrapVariableByCriteria(Data.getField(SchemaField.TITLE, row)));
        if (Data.containsField(SchemaField.SUBTITLES_REQUIRED, row, true))
            orderItem.setMetadataSubtitlesRequired(new String[]{SubtitlesRequired.findByName(Data.getField(SchemaField.SUBTITLES_REQUIRED, row)).toString()});
        if (Data.containsField(SchemaField.MEDIA_AGENCY, row, true))
            orderItem.setMediaAgency(new String[]{Data.getField(SchemaField.MEDIA_AGENCY, row)});
        if (Data.containsField(SchemaField.CREATIVE_AGENCY, row, true))
            orderItem.setCreativeAgency(new String[]{Data.getField(SchemaField.CREATIVE_AGENCY, row)});
        if (Data.containsField(SchemaField.POST_HOUSE, row, true))
            orderItem.setPostHouse(new String[]{Data.getField(SchemaField.POST_HOUSE, row)});
        if (Markets.UAE.toString().equals(market)) {
            if (Data.containsField(SchemaField.LANGUAGE, row, true))
                orderItem.setLanguage(new String[]{Data.getField(SchemaField.LANGUAGE, row)});
        }
        if (Markets.SPAIN.toString().equals(market)) {
            if (Data.containsField(SchemaField.CLAVE, row, true))
                orderItem.setClave(Data.getField(SchemaField.CLAVE, row));
            if (Data.containsField(SchemaField.WATERMARKING_REQUIRED, row, true))
                orderItem.setWatermarkingRequired(new String[]{Data.getField(SchemaField.WATERMARKING_REQUIRED, row)});
            if (Data.containsField(SchemaField.WATERMARKING_CODE, row, true))
                orderItem.setWatermarkingCode(Data.getField(SchemaField.WATERMARKING_CODE, row));
            if (Data.containsField(SchemaField.WATERMARKING_BRAND, row, true))
                orderItem.setWatermarkingBrand(new String[]{Data.getField(SchemaField.WATERMARKING_BRAND, row)});
            if (Data.containsField(SchemaField.MODEL, row, true))
                orderItem.setModel(new String[]{Data.getField(SchemaField.MODEL, row)});
            if (Data.containsField(SchemaField.PRODUCT_DESCRIPTION, row, true))
                orderItem.setProductDescription(Data.getField(SchemaField.PRODUCT_DESCRIPTION, row));
            if (Data.containsField(SchemaField.CREATIVE_DESCRIPTION, row, true))
                orderItem.setCreativeDescription(Data.getField(SchemaField.CREATIVE_DESCRIPTION, row));
            if (Data.containsField(SchemaField.SECTOR, row, true))
                orderItem.setSector(new String[]{Data.getField(SchemaField.SECTOR, row)});
            if (Data.containsField(SchemaField.GROUP, row, true))
                orderItem.setGroup(new String[]{Data.getField(SchemaField.GROUP, row)});
            if (Data.containsField(SchemaField.WATERMARKING_PRODUCT, row, true))
                orderItem.setWatermarkingProduct(new String[]{Data.getField(SchemaField.WATERMARKING_PRODUCT, row)});
        }
        if (Markets.FRANCE.toString().equals(market)) {
            if (Data.containsField(SchemaField.TYPE_DE_MENTIONS, row, true))
                orderItem.setTypeDeMentions(new String[]{TypeDeMentions.findByName(Data.getField(SchemaField.TYPE_DE_MENTIONS, row))});
            if (Data.containsField(SchemaField.MENTIONS, row, true))
                orderItem.setMentions(new String[]{Mentions.findByName(Data.getField(SchemaField.MENTIONS, row))});
            if (Data.containsField(SchemaField.ARPP_VERSION_NUMBER, row, true))
                orderItem.setARPPVersionNumber(Data.getField(SchemaField.ARPP_VERSION_NUMBER, row));
            if (Data.containsField(SchemaField.ARPP_SUBMISSION_NUMBER, row, true))
                orderItem.setARPPSubmissionNumber(wrapVariableByCriteria(Data.getField(SchemaField.ARPP_SUBMISSION_NUMBER, row)));
            if (Data.containsField(SchemaField.ARPP_SUBMISSION_RESULTS, row, true))
                orderItem.setARPPSubmissionResults(Data.getField(SchemaField.ARPP_SUBMISSION_RESULTS, row));
            if (Data.containsField(SchemaField.ARPP_SUBMISSION_COMMENTS_CODE, row, true))
                orderItem.setARPPSubmissionCommentsCode(wrapVariableByCriteria(Data.getField(SchemaField.ARPP_SUBMISSION_COMMENTS_CODE, row)));
            if (Data.containsField(SchemaField.ARPP_SUBMISSION_DETAILS, row, true))
                orderItem.setARPPSubmissionDetails(wrapVariableWithTestSession(Data.getField(SchemaField.ARPP_SUBMISSION_DETAILS, row)));
        }
        if (Markets.DISNEY_PAN_NORDIC.toString().equals(market) && Data.containsField(SchemaField.DISNEY_CODE, row, true))
            orderItem.setDisneyCode(Data.getField(SchemaField.DISNEY_CODE, row));
        if (Markets.SWITZERLAND.toString().equals(market)) {
            if (Data.containsField(SchemaField.SUISA, row, true))
                orderItem.setSuisa(wrapVariableWithTestSession(Data.getField(SchemaField.SUISA, row)));
            if (Data.containsField(SchemaField.LANGUAGE, row, true))
                orderItem.setLanguage(new String[]{Data.getField(SchemaField.LANGUAGE, row)});
        }
        if (Markets.GERMANY.toString().equals(market) && Data.containsField(SchemaField.MOTIVNUMMER, row, true))
            orderItem.setMotivnummer(wrapVariableWithTestSession(Data.getField(SchemaField.MOTIVNUMMER, row)));
        if (Markets.AUSTRIA.toString().equals(market) && Data.containsField(SchemaField.SUJET_AKM, row, true))
            orderItem.setSujectAkm(wrapVariableWithTestSession(Data.getField(SchemaField.SUJET_AKM, row)));
        if (Markets.NETHERLANDS.toString().equals(market)) {
            if (Data.containsField(SchemaField.DELIVERY_TITLE, row, true))
                orderItem.setDeliveryTitle(Data.getField(SchemaField.DELIVERY_TITLE, row));
            if (Data.containsField(SchemaField.VERSION, row, true))
                orderItem.setVersion(new String[]{Data.getField(SchemaField.VERSION, row)});
        }
        if (Markets.BRASIL.toString().equals(market)) {
            if (Data.containsField(SchemaField.CNPJ, row, true))
                orderItem.setCNPJ(Data.getField(SchemaField.CNPJ, row));
            if (Data.containsField(SchemaField.CRT, row, true))
                orderItem.setCRT(Data.getField(SchemaField.CRT, row));
            if (Data.containsField(SchemaField.DATE_OF_ANCINE_REGISTRATION, row, true))
                orderItem.setDateOfAncineReg(parseDateWithUTCZone(Data.getField(SchemaField.DATE_OF_ANCINE_REGISTRATION, row)));
            if (Data.containsField(SchemaField.DIRECTOR, row, true))
                orderItem.setDirector(Data.getField(SchemaField.DIRECTOR, row));
            if (Data.containsField(SchemaField.MARKET_SEGMENT, row, true))
                orderItem.setMarketSegment(Data.getField(SchemaField.MARKET_SEGMENT, row));
            if (Data.containsField(SchemaField.NUMBER_OF_VERSIONS, row, true))
                orderItem.setNumberOfVersions(Data.getField(SchemaField.NUMBER_OF_VERSIONS, row));
            if (Data.containsField(SchemaField.TYPE, row, true))
                orderItem.setType(Data.getField(SchemaField.TYPE, row));
        }
        if (Markets.AUSTRALIA.toString().equals(market) && Data.containsField(SchemaField.CAD_NO, row, true))
            orderItem.setCadNo(wrapVariableWithTestSession(Data.getField(SchemaField.CAD_NO, row)));
        if (Markets.BELGIUM.toString().equals(market) && Data.containsField(SchemaField.MBCID_CODE, row, true))
            orderItem.setMbcidCode(wrapVariableWithTestSession(Data.getField(SchemaField.MBCID_CODE, row)));
        if (Markets.CHILE.toString().equals(market) && Data.containsField(SchemaField.MEGATIME_CODE, row, true))
            orderItem.setMegatimeCode(wrapVariableWithTestSession(Data.getField(SchemaField.MEGATIME_CODE, row)));
        if (Markets.MEXICO.toString().equals(market) && Data.containsField(SchemaField.TELEVISA_ID, row, true))
            orderItem.setTelevisaId(wrapVariableWithTestSession(Data.getField(SchemaField.TELEVISA_ID, row)));
        if (Markets.VENEZUELA.toString().equals(market) && Data.containsField(SchemaField.RIF_CODE, row, true))
            orderItem.setRifCode(wrapVariableWithTestSession(Data.getField(SchemaField.RIF_CODE, row)));
        if (Markets.SWEDEN.toString().equals(market) && Data.containsField(SchemaField.TYPE_OF_COMMERCIAL, row, true))
            orderItem.setMediaSubType(new String[]{Data.getField(SchemaField.TYPE_OF_COMMERCIAL, row)});
        return orderItem;
    }

    protected Map<String, String> prepareAddInformationFields(ExamplesTable fieldsTable) {
        Map<String, String> row = parametrizeTabularRow(fieldsTable);
        if (Data.containsField(SchemaField.CLOCK_NUMBER, row, false)) {
            String clockNumber = Data.getField(SchemaField.CLOCK_NUMBER, row);
            row.put(SchemaField.CLOCK_NUMBER.toString(), isClockNumberFromARPPSystem(clockNumber) ? clockNumber : wrapVariableWithTestSession(clockNumber) );
            Data.removeExtraField(SchemaField.CLOCK_NUMBER, row);
        }
        if (Data.containsField(SchemaField.ADVERTISER, row, false)) {
            row.put(SchemaField.ADVERTISER.toString(), prepareAdvertiser(Data.getField(SchemaField.ADVERTISER, row)));
            Data.removeExtraField(SchemaField.ADVERTISER, row);
        }
        if (Data.containsField(SchemaField.BRAND, row, false))
            row.put(SchemaField.BRAND.toString(), wrapVariableWithTestSession(Data.getField(SchemaField.BRAND, row)));
        if (Data.containsField(SchemaField.SUB_BRAND, row, false))
            row.put(SchemaField.SUB_BRAND.toString(), wrapVariableWithTestSession(Data.getField(SchemaField.SUB_BRAND, row)));
        if (Data.containsField(SchemaField.PRODUCT, row, false)) {
            row.put(SchemaField.PRODUCT.toString(), wrapVariableWithTestSession(Data.getField(SchemaField.PRODUCT, row)));
            Data.removeExtraField(SchemaField.PRODUCT, row);
        }
        if (Data.containsField(SchemaField.CAMPAIGN, row, false)) {
            row.put(SchemaField.CAMPAIGN.toString(), wrapVariableWithTestSession(Data.getField(SchemaField.CAMPAIGN, row)));
            Data.removeExtraField(SchemaField.CAMPAIGN, row);
        }
        if (Data.containsField(SchemaField.TITLE, row, false)) row.put(SchemaField.TITLE.toString(), wrapVariableByCriteria(Data.getField(SchemaField.TITLE, row)));
        if (Data.containsField(SchemaField.MEDIA_AGENCY_CONTACT, row, false)) row.put(SchemaField.MEDIA_AGENCY_CONTACT.toString(), wrapVariableWithTestSession(Data.getField(SchemaField.MEDIA_AGENCY_CONTACT, row)));
        if (Data.containsField(SchemaField.CREATIVE_AGENCY_CONTACT, row, false)) row.put(SchemaField.CREATIVE_AGENCY_CONTACT.toString(), wrapVariableWithTestSession(Data.getField(SchemaField.CREATIVE_AGENCY_CONTACT, row)));
        if (Data.containsField(SchemaField.FIRST_AIR_DATE, row, false)) {
            row.put(SchemaField.FIRST_AIR_DATE.toString(), !Data.getField(SchemaField.FIRST_AIR_DATE, row).isEmpty()
                                                           ? formatDateToDefaultStoriesFormat(Data.getField(SchemaField.FIRST_AIR_DATE, row))
                                                           : "");
            Data.removeExtraField(SchemaField.FIRST_AIR_DATE, row);
        }
        if (Data.containsField(SchemaField.ARPP_SUBMISSION_NUMBER, row, false))
            row.put(SchemaField.ARPP_SUBMISSION_NUMBER.toString(), wrapVariableByCriteria(Data.getField(SchemaField.ARPP_SUBMISSION_NUMBER, row)));
        if (Data.containsField(SchemaField.ARPP_SUBMISSION_COMMENTS_CODE, row, false))
            row.put(SchemaField.ARPP_SUBMISSION_COMMENTS_CODE.toString(), wrapVariableByCriteria(Data.getField(SchemaField.ARPP_SUBMISSION_COMMENTS_CODE, row)));
        if (Data.containsField(SchemaField.ARPP_SUBMISSION_DETAILS, row, false))
            row.put(SchemaField.ARPP_SUBMISSION_DETAILS.toString(), wrapVariableWithTestSession(Data.getField(SchemaField.ARPP_SUBMISSION_DETAILS, row)));
        if (Data.containsField(SchemaField.DELIVERY_TITLE, row, false)) {
            StringBuilder preparedDeliveryTitle = new StringBuilder();
            String[] deliveryTitleParts = Data.getField(SchemaField.DELIVERY_TITLE, row).split("_");
            for (int i = 0; i < deliveryTitleParts.length; i++) {
                String deliveryTitlePart = deliveryTitleParts[i].matches("\\d*") || deliveryTitleParts[i].matches("v\\d{1}") || deliveryTitleParts[i].equals("DD-MM-YYYY") ? deliveryTitleParts[i] : wrapVariableWithTestSession(deliveryTitleParts[i]);
                preparedDeliveryTitle.append(deliveryTitlePart);
                if (i != deliveryTitleParts.length - 1) preparedDeliveryTitle.append("_");
            }
            row.put(SchemaField.DELIVERY_TITLE.toString(), preparedDeliveryTitle.toString());
        }
        if (Data.containsField(SchemaField.CNPJ, row, false))
            row.put(SchemaField.CNPJ.toString(), Data.getField(SchemaField.CNPJ, row));
        if (Data.containsField(SchemaField.CRT, row, false))
            row.put(SchemaField.CRT.toString(), Data.getField(SchemaField.CRT, row));
        if (Data.containsField(SchemaField.DATE_OF_ANCINE_REGISTRATION, row, false))
            row.put(SchemaField.DATE_OF_ANCINE_REGISTRATION.toString(), !Data.getField(SchemaField.DATE_OF_ANCINE_REGISTRATION, row).isEmpty()
                    ? formatDateToDefaultStoriesFormat(Data.getField(SchemaField.DATE_OF_ANCINE_REGISTRATION, row))
                    : "");
        if (Data.containsField(SchemaField.DIRECTOR, row, false))
            row.put(SchemaField.DIRECTOR.toString(), Data.getField(SchemaField.DIRECTOR, row));
        if (Data.containsField(SchemaField.MARKET_SEGMENT, row, false))
            row.put(SchemaField.MARKET_SEGMENT.toString(), Data.getField(SchemaField.MARKET_SEGMENT, row));
        if (Data.containsField(SchemaField.TYPE, row, false))
            row.put(SchemaField.TYPE.toString(), Data.getField(SchemaField.TYPE, row));
        return row;
    }

    protected Map<String, String> prepareAddInformationFieldsWthoutWrappingTestSession(ExamplesTable fieldsTable) {
        Map<String, String> row = parametrizeTabularRow(fieldsTable);
        if (Data.containsField(SchemaField.CLOCK_NUMBER, row, false)) {
            String clockNumber = Data.getField(SchemaField.CLOCK_NUMBER, row);
            row.put(SchemaField.CLOCK_NUMBER.toString(), isClockNumberFromARPPSystem(clockNumber) ? clockNumber :wrapVariableWithTestSession(clockNumber));
            Data.removeExtraField(SchemaField.CLOCK_NUMBER, row);
        }
        if (Data.containsField(SchemaField.ADVERTISER, row, false)) {
            row.put(SchemaField.ADVERTISER.toString(), prepareAdvertiserWithoutTestSession(Data.getField(SchemaField.ADVERTISER, row)));
            Data.removeExtraField(SchemaField.ADVERTISER, row);
        }
        if (Data.containsField(SchemaField.BRAND, row, false))
            row.put(SchemaField.BRAND.toString(), Data.getField(SchemaField.BRAND, row));
        if (Data.containsField(SchemaField.SUB_BRAND, row, false))
            row.put(SchemaField.SUB_BRAND.toString(),Data.getField(SchemaField.SUB_BRAND, row));
        if (Data.containsField(SchemaField.PRODUCT, row, false)) {
            row.put(SchemaField.PRODUCT.toString(), Data.getField(SchemaField.PRODUCT, row));
            Data.removeExtraField(SchemaField.PRODUCT, row);
        }
        if (Data.containsField(SchemaField.PRODUCT, row, false)) {
            row.put(SchemaField.PRODUCT.toString(), Data.getField(SchemaField.PRODUCT, row));
            Data.removeExtraField(SchemaField.PRODUCT, row);
        }
        if (Data.containsField(SchemaField.CAMPAIGN, row, false)) {
            row.put(SchemaField.CAMPAIGN.toString(), Data.getField(SchemaField.CAMPAIGN, row));
            Data.removeExtraField(SchemaField.CAMPAIGN, row);
        }
        if (Data.containsField(SchemaField.TITLE, row, false)) row.put(SchemaField.TITLE.toString(), wrapVariableByCriteria(Data.getField(SchemaField.TITLE, row)));
        if (Data.containsField(SchemaField.MEDIA_AGENCY_CONTACT, row, false)) row.put(SchemaField.MEDIA_AGENCY_CONTACT.toString(), Data.getField(SchemaField.MEDIA_AGENCY_CONTACT, row));
        if (Data.containsField(SchemaField.CREATIVE_AGENCY_CONTACT, row, false)) row.put(SchemaField.CREATIVE_AGENCY_CONTACT.toString(), Data.getField(SchemaField.CREATIVE_AGENCY_CONTACT, row));
        if (Data.containsField(SchemaField.FIRST_AIR_DATE, row, false)) {
            row.put(SchemaField.FIRST_AIR_DATE.toString(), !Data.getField(SchemaField.FIRST_AIR_DATE, row).isEmpty()
                    ? formatDateToDefaultStoriesFormat(Data.getField(SchemaField.FIRST_AIR_DATE, row))
                    : "");
            Data.removeExtraField(SchemaField.FIRST_AIR_DATE, row);
        }
        if (Data.containsField(SchemaField.ARPP_SUBMISSION_NUMBER, row, false))
            row.put(SchemaField.ARPP_SUBMISSION_NUMBER.toString(), wrapVariableByCriteria(Data.getField(SchemaField.ARPP_SUBMISSION_NUMBER, row)));
        if (Data.containsField(SchemaField.ARPP_SUBMISSION_COMMENTS_CODE, row, false))
            row.put(SchemaField.ARPP_SUBMISSION_COMMENTS_CODE.toString(), wrapVariableByCriteria(Data.getField(SchemaField.ARPP_SUBMISSION_COMMENTS_CODE, row)));
        if (Data.containsField(SchemaField.ARPP_SUBMISSION_DETAILS, row, false))
            row.put(SchemaField.ARPP_SUBMISSION_DETAILS.toString(), Data.getField(SchemaField.ARPP_SUBMISSION_DETAILS, row));
        if (Data.containsField(SchemaField.DELIVERY_TITLE, row, false)) {
            StringBuilder preparedDeliveryTitle = new StringBuilder();
            String[] deliveryTitleParts = Data.getField(SchemaField.DELIVERY_TITLE, row).split("_");
            for (int i = 0; i < deliveryTitleParts.length; i++) {
                String deliveryTitlePart = deliveryTitleParts[i].matches("\\d*") || deliveryTitleParts[i].matches("v\\d{1}") || deliveryTitleParts[i].equals("DD-MM-YYYY") ? deliveryTitleParts[i] : deliveryTitleParts[i];
                preparedDeliveryTitle.append(deliveryTitlePart);
                if (i != deliveryTitleParts.length - 1) preparedDeliveryTitle.append("_");
            }
            row.put(SchemaField.DELIVERY_TITLE.toString(), preparedDeliveryTitle.toString());
        }
        if (Data.containsField(SchemaField.CNPJ, row, false))
            row.put(SchemaField.CNPJ.toString(), Data.getField(SchemaField.CNPJ, row));
        if (Data.containsField(SchemaField.CRT, row, false))
            row.put(SchemaField.CRT.toString(), Data.getField(SchemaField.CRT, row));
        if (Data.containsField(SchemaField.DATE_OF_ANCINE_REGISTRATION, row, false))
            row.put(SchemaField.DATE_OF_ANCINE_REGISTRATION.toString(), !Data.getField(SchemaField.DATE_OF_ANCINE_REGISTRATION, row).isEmpty()
                    ? formatDateToDefaultStoriesFormat(Data.getField(SchemaField.DATE_OF_ANCINE_REGISTRATION, row))
                    : "");
        if (Data.containsField(SchemaField.DIRECTOR, row, false))
            row.put(SchemaField.DIRECTOR.toString(), Data.getField(SchemaField.DIRECTOR, row));
        if (Data.containsField(SchemaField.MARKET_SEGMENT, row, false))
            row.put(SchemaField.MARKET_SEGMENT.toString(), Data.getField(SchemaField.MARKET_SEGMENT, row));
        if (Data.containsField(SchemaField.TYPE, row, false))
            row.put(SchemaField.TYPE.toString(), Data.getField(SchemaField.TYPE, row));
        return row;
    }

    protected Map<String, String> prepareAddInformationCustomFields(ExamplesTable fieldsTable){
        Map<String, String> row = parametrizeTabularRow(fieldsTable);
        for (Map.Entry<String, String> entry : row.entrySet())
            row.put(entry.getKey(), wrapVariableWithTestSession(entry.getValue()));
        return row;
    }

    // destinations: array of destination:serviceLevel pairs
    private List<DestinationItem> prepareDestinationItems(String market, String[] destinations) {
        List<DestinationItem> destinationItems = new ArrayList<>(destinations.length);
        for (String destination_serviceLvl: destinations) {
            String[] parts = destination_serviceLvl.split(":");
            Destination destination = getCoreApi().getDestinationByName(market, parts[0]);
            ServiceLevel serviceLevel = getCoreApi().getDestinationServiceLevelByName(destination, parts[1]);

            CustomMetadata cmServiceLvl = new CustomMetadata();
            cmServiceLvl.put("id", new String[]{serviceLevel.getKey()});

            CustomMetadata cmDestinationItem = new CustomMetadata();
            cmDestinationItem.put("id", new String[]{destination.getKey()});
            cmDestinationItem.put("serviceLevel", new ServiceLevel(cmServiceLvl));

            DestinationItem destinationItem = new DestinationItem(cmDestinationItem);
            destinationItems.add(destinationItem);
        }
        return destinationItems;
    }

    private void setARPPUserCookies(String userName, String password) {
        String userCookiesJson = String.format("dojo.cookie('ordering_arpp', '{\"username\":\"%s\",\"password\":\"%s\"}')", Base64.encodeBase64String(userName.getBytes()), Base64.encodeBase64String(password.getBytes()));
        getSut().getWebDriver().getJavascriptExecutor().executeScript(userCookiesJson);
    }

    // | Additional Information | Advertiser | Campaign | Clock Number | Duration | First Air Date | Format | Product | Title | Subtitles Required | Destination |
    // | CNPJ | CRT | Date of Ancine Registration | Director | Market Segment | Number of Versions | Type |
    @Given("{I |}create '$orderType' order with market '$market' and items with following fields: $fieldsTable")
    @When("{I |}created '$orderType' order with market '$market' and items with following fields: $fieldsTable")
    @Then("{I |}create '$orderType' order with market '$market' and items with following fields: $fieldsTable")
    public void createOrderWithItems(String orderType, String market, ExamplesTable fieldsTable) {
        if (market.isEmpty()) throw new IllegalArgumentException("Market is not specified!");
        Order order = getCoreApi().createOrdernew(market, getOrderType(orderType));
        if (order != null) {
            waitForOrderIndex(order.getId(), OrderStatus.VIEW_DRAFT_ORDERS.toString(), sleep);
            for (int i = 0; i < fieldsTable.getRowCount(); i++) {
                Map<String, String> row = parametrizeTabularRow(fieldsTable, i);
                OrderItem orderItem = buildAddInformationSectionOfOrderItem(market, new OrderItem(), row);
                if (row.containsKey("Destination") && !row.get("Destination").isEmpty()) {
                    String[] destinations = row.get("Destination").split(";");
                    List<DestinationItem> destinationItems = prepareDestinationItems(market, destinations);
                    orderItem.setDestinationItems(destinationItems.toArray(new DestinationItem[destinationItems.size()]));
                }
                OrderItem orderItemCore = getCoreApi().createOrderItem(order.getId(), getItemTypeByOrderType(orderType), orderItem);
                Common.sleep(1000);
                if (orderItemCore == null) throw new NullPointerException("Order item was not created!");
            }
        } else {
            throw new NullPointerException("Order is not created!");
        }
        Common.sleep(1000);
        getOrderItems(order.getId()); // to indexing order with created items
    }

    // | Additional Information | Advertiser | Campaign | Clock Number | Duration | First Air Date | Format | Product | Title | Subtitles Required | Destination |
    @Given("{I |}update '$orderType' order item with clock number '$clockNumber' by following fields: $fieldsTable")
    @When("{I |}updated '$orderType' order item with clock number '$clockNumber' by following fields: $fieldsTable")
    public void updateOrderItem(String orderType, String clockNumber, ExamplesTable fieldsTable) {
        Map<String, String> row = parametrizeTabularRow(fieldsTable);
        clockNumber = wrapVariableWithTestSession(clockNumber);
        Order order = getOrderByItemClockNumber(clockNumber);
        OrderItem orderItem = getOrderItemByClockNumber(order.getId(), clockNumber);
        buildAddInformationSectionOfOrderItem(order.getTvMarket(), orderItem, row);
        getCoreApi().updateOrderItem(order.getId(), orderItem.getId(), getItemTypeByOrderType(orderType), orderItem);
    }

    // | Document |
    @Given("{I |}upload to '$orderType' order item with clock number '$clockNumber' following documents: $fieldsTable")
    @When("{I |}uploaded to '$orderType' order item with clock number '$clockNumber' following documents: $fieldsTable")
    public void uploadDocumentsToOrderItem(String orderType, String clockNumber, ExamplesTable fieldsTable) {
        clockNumber = wrapVariableWithTestSession(clockNumber);
        Order order = getOrderByItemClockNumber(clockNumber);
        OrderItem orderItem = getOrderItemByClockNumber(order.getId(), clockNumber);
        for (int i = 0; i < fieldsTable.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(fieldsTable, i);
            String documentPath = getFilePath(row.get("Document"));
            getCoreApi().uploadDocumentToOrderItem(new File(documentPath), order.getId(), orderItem.getId(), getItemTypeByOrderType(orderType), orderItem);
        }
    }

    // | Additional Information | Advertiser | Campaign | Clock Number | Duration | First Air Date | Format | Product | Title | Subtitles Required | Media Agency | Clave | Media Agency Contact | Creative Agency Contact |
    // | Type De Mentions | Mentions | ARPP Version Number | ARPP Submission Number | ARPP Submission Results | ARPP Submission Comments Code | ARPP Submission Details | Version | Delivery Title |
    // | CNPJ | CRT | Date of Ancine Registration | Director | Market Segment | Number of Versions | Type |
    // | Watermarking Required | Watermarking Code | Watermarking Brand | Model | Product Description | Creative Description | Sector | Group | Watermarking Product |
    @When("{I |}{fill|edit} following fields for Add information form on order item page: $fieldsTable")
    public void fillAddInformationForm(ExamplesTable fieldsTable) {
        Map<String, String> row = prepareAddInformationFields(fieldsTable);
        getAddInformationForm().fill(row);
    }

    @When("{I |}fill following fields for Add information form on order item page without wrapping with test Session: $fieldsTable")
    public void fillAddInformationFormWithoutTestSession(ExamplesTable fieldsTable) {
        Map<String, String> row = prepareAddInformationFieldsWthoutWrappingTestSession(fieldsTable);
        getAddInformationForm().fill(row);
    }

    // | Advertiser Custom | Brand Custom | Sub Brand Custom | Product Custom |
    @When("{I |}fill following custom advertiser hierarchy fields for Add information form on order item page: $fieldsTable")
    public void fillAddInformationFormCustomAdvertiserHierarchyFields(ExamplesTable fieldsTable) {
        Map<String, String> row = prepareAddInformationCustomFields(fieldsTable);
        getAddInformationForm().fillAdvertiserHierarchyCustomFields(row);

    }

    // | String | Date | Multiline | Phone | Dropdown | Catalogue Structure | Address | Radio Buttons | Hyperlink | Custom Code |
    @When("{I |}fill following custom fields for Add information form on order item page: $fieldsTable")
    public void fillAddInformationFormCustomFields(ExamplesTable fieldsTable) {
        Map<String, String> row = parametrizeTabularRow(fieldsTable);
        AddInformationForm form = getAddInformationForm();
        for (Map.Entry<String, String> entry : row.entrySet())
            form.fillFieldByName(entry.getKey(), entry.getValue());
    }

    // codeType: auto code, spot gate code, watermarking code
    @When("{I |}generate '$codeType' value for Add information form on order item page")
    public void generateAddInfoSectionAutoCode(String codeType) {
        getAddInformationForm().generateCode(codeType);
    }

    @Then("{I |} should see unique '$codeType' generated on Add information form on order item page")
    public void captureAddInfoSectionAutoCode(String codeType) {
        for(int i=1;i<=3;i++) {
            getAddInformationForm().generateCode(codeType);
            String autoCodeGenFirst = getAddInformationForm().getClockNumber();
            String[] tempFirst = autoCodeGenFirst.split("/");
            String firstAutoCode = tempFirst[0];
            Integer parseAutoCode = Integer.valueOf(firstAutoCode);
            Integer expAutoCode = ++parseAutoCode;
            getAddInformationForm().generateCode(codeType);
            String autoCodeGenSecond = getAddInformationForm().getClockNumber();
            String[] tempSecond = autoCodeGenSecond.split("/");
            String secondAutoCode = tempSecond[0];
            Integer actAutoCode = Integer.valueOf(secondAutoCode);
            assertThat("Check the uniqueness of sequential number", actAutoCode.equals(expAutoCode));
        }
    }


    // codeType: auto code, spot gate code
    @When("{I |}click '$codeType' button for Add information form on order item page")
    public void clickAutoCodeButton(String codeType) {
        getAddInformationForm().pushAutoCodeButton(codeType);
    }

    // codeType: auto code, spot gate code
    @When("{I |}wait for generating '$codeType' for Add information form on order item page")
    public void waitForCodeGenerating(String codeType) {
        Common.sleep(4000);
        getAddInformationForm().waitForAutoCodeGeneration(GeneratedCodeType.findByType(codeType));
    }

    @When("{I |}select following custom code '$customCodeName' on Select from existing formats popup of Add information form")
    public void selectPopUpsCustomCode(String customCodeName) {
        getAddInformationForm().getSelectFromExistingFormatsPopUp().getAdCodeByName(wrapVariableWithTestSession(customCodeName)).selectAdCode();
    }

    @When("{I |}applied selected custom code for Add information form of order item page")
    public void clickOkButtonForCustomCodesPopUp() {
        getAddInformationForm().getSelectFromExistingFormatsPopUp().clickOkBtn();
    }

    // | Login | Password |
    @When("{I |}fill following fields for ARPP login popup of Add information form on order item page: $fieldsTable")
    public void fillARPPLoginPopUp(ExamplesTable fieldsTable) {
        Map<String, String> row = parametrizeTabularRow(fieldsTable);
        getAddInformationForm().getARPPLoginForm().fill(row);
    }

    @When("{I |}push Login on ARPP login popup of Add information form")
    public void loginToARPP() {
        getAddInformationForm().getARPPLoginForm().login();
    }

    @When("{I |}click Login button on ARPP login popup of Add information form")
    public void clickLoginButton() {
        getAddInformationForm().getARPPLoginForm().clickLoginButton();
    }

    @Given("{I |}logged into ARPP system by default user")
    @When("{I |}log in to ARPP system by default user")
    public void logInToARPPSystem() {
        getCoreApi().authenticationToARPPSystem(OrderingSettings.ARPP_USER_NAME, OrderingSettings.ARPP_USER_PASSWORD);
        setARPPUserCookies(OrderingSettings.ARPP_USER_NAME, OrderingSettings.ARPP_USER_PASSWORD);
    }

    @When("{I |}log off from ARPP system on Add information form")
    public void logOffARPPSystem() {
        getAddInformationForm().logOffARPPSystem();
    }

    @Then("{I |}should see following {auto|spot gate|watermarking} generated code '$autoCodePattern' for field '$fieldName' on Add information form of order item page")
    public void checkAutoGeneratedCode(String autoCodePattern, String fieldName) {
        assertThat("Check auto generated code on Add Information section: ", getAddInformationForm().getFieldValue(Data.getPrimaryFieldName(SchemaField.findByName(fieldName))),
                StringByRegExpCheck.matches(autoCodePattern));
    }

    @Then("{I |}'$Shouldstate' see generated watermarking code in field '$fieldName' on the BackEnd")
    public void getSpainWaterMakingCode(String Shouldstate,String fieldName) {
        boolean codeStatus = false;
        String code =getAddInformationForm().getFieldValue(Data.getPrimaryFieldName(SchemaField.findByName(fieldName)));
        DBCollection schemaCollection = getMongoDB().getCollection("asset");
        BasicDBObject query = new BasicDBObject();
        BasicDBObject Map = new BasicDBObject();
        Map.append("$elemMatch", new BasicDBObject().append("s", code));
        query.put("_cm.metadata", Map);
        DBObject obj = schemaCollection.findOne(query);
        if(obj!=null) {
            codeStatus = true;
        }
            assertThat("Auto generate watermarking code is not unique", codeStatus, is(Shouldstate.equals("should")));
        }


    // state: active, inactive
    @Then("{I |}should see '$state' Auto code button on Add information form of order item page")
    public void checkAutoGenerateCodeButtonState(String state) {
        assertThat("Check Auto generate code button state on Add information form: ", getAddInformationForm().isAutoCodeBtnActive(), is(state.equals("active")));
    }

    @Then("{I |}'$shouldState' see following custom code{s|} '$customCodeNames' on Select from existing formats popup of Add information form")
    public void checkVisibilityPopUpsCustomCodes(String shouldState, String customCodeNames) {
        List<String> visibleCustomCodeNames = getAddInformationForm().getSelectFromExistingFormatsPopUp().getVisibleAdCodeNames();
        for (String customCodeName : customCodeNames.split(","))
            assertThat("Check visibility custom code name: " + customCodeName, visibleCustomCodeNames, shouldState.equals("should")
                                                                               ? hasItem(wrapVariableWithTestSession(customCodeName))
                                                                               : not(hasItem(wrapVariableWithTestSession(customCodeName))));
    }

    @Then("{I |}'$shouldState' see Select from existing formats popup on Add information form of order item page")
    public void checkVisibilityCustomCodesPopUp(String shouldState) {
        assertThat("Check visibility custom code popup: ", getAddInformationForm().isSelectFromExistingFormatsPopUpVisible(), is(shouldState.equals("should")));
    }

    @Then("{I |}should see following ARPP hint message '$message' on Add information form of order item page")
    public void checkARPPHintMessage(String message) {
        assertThat("Check ARPP hint message: ", getAddInformationForm().getARPPHintMessage(), equalTo(message));
    }

    // | Login | Password |
    @Then("{I |}'$shouldState' see validation error for following fields '$fieldNamesList' on ARPP login popup of Add information form")
    public void checkARPPLoginPopUpFieldsValidation(String shouldState, String fieldNamesList) {
        ARPPLoginForm form = getAddInformationForm().getARPPLoginForm();
        for (String fieldName: fieldNamesList.split(","))
            assertThat("Check visibility validation error for field: " + fieldName, form.isValidationFieldErrorVisible(fieldName),
                                                                                    is(shouldState.equals("should")));
    }

    @Then("{I |} '$shouldState' see an error '$errorText'")
    public void checkARPPLoginPopUpFieldsValidation1(String shouldState,String errorText) {
        boolean condition = shouldState.equalsIgnoreCase("should");
        String actualErrorText = verifyUniqueCodeError();
        if (condition == true) {

            assertThat("Check Unique code Validation", errorText, equalToIgnoringCase(actualErrorText));
        }
        else
        {
            assertThat("Check Unique code Validation", "false", equalToIgnoringCase(actualErrorText));
        }
    }
    @Then("{I |}'$shouldState' see available following pub ids '$pubIds' in Pub Id field on Add Information form")
    public void checkAvailablePubIds(String shouldState, String pubIds) {
        List<String> availablePubIds = getAddInformationForm().getAvailablePubIds();
        for (String pubId: pubIds.split(","))
            assertThat("Check availability pub id: " + pubId, availablePubIds, shouldState.equals("should")
                                                              ? hasItem(isClockNumberFromARPPSystem(pubId) ? pubId : wrapVariableWithTestSession(pubId))
                                                              : not(hasItem(isClockNumberFromARPPSystem(pubId) ? pubId : wrapVariableWithTestSession(pubId))));
    }

    // | Additional Information | Advertiser | Campaign | Clock Number | Duration | First Air Date | Format | Product | Title | Subtitles Required | Media Agency | Clave | Media Agency Contact | Creative Agency Contact |
    // | Type De Mentions | Mentions | ARPP Version Number | ARPP Submission Number | ARPP Submission Results | ARPP Submission Comments Code | ARPP Submission Details |
    // | Version | Delivery Title |
    // | CNPJ | CRT | Date of Ancine Registration | Director | Market Segment | Number of Versions | Type |
    // | Watermarking Required | Watermarking Code | Watermarking Brand | Model | Product Description | Creative Description | Sector | Group | Watermarking Product |
    @Then("{I |}should see following data for order item on Add information form: $fieldsTable")
    public void checkAddInformationFormData(ExamplesTable fieldsTable) {
        Map<String, String> row = prepareAddInformationFields(fieldsTable);
        AddInformationForm form = getAddInformationForm();

        for (Map.Entry<String, String> entry : row.entrySet())
            assertThat("Check field: " + entry.getKey(), form.getFieldValue(entry.getKey()), equalTo(entry.getValue()));
    }

    @Then("{I |}should see following custom advertiser hierarchy fields data for order item on Add information form: $fieldsTable")
    public void checkAddInformationFormCustomAdvertiserHierarchyFieldsData(ExamplesTable fieldsTable){
        Map<String, String> row = prepareAddInformationCustomFields(fieldsTable);
        AddInformationForm form = getAddInformationForm();
        for (Map.Entry<String, String> entry : row.entrySet())
            assertThat("Check field: " + entry.getKey(), form.getAdvertiserHierarchyCustomFieldValue(entry.getKey()), equalTo(entry.getValue()));
    }

    // | String | Date | Multiline | Phone | Dropdown | Catalogue Structure | Address | Radio Buttons | Hyperlink | Custom Code |
    @Then("{I |}should see following custom fields data for Add information form on order item page: $fieldsTable")
    public void checkAddInformationFormCustomFieldsData(ExamplesTable fieldsTable) {
        Map<String, String> row = parametrizeTabularRow(fieldsTable);
        AddInformationForm form = getAddInformationForm();
        for (Map.Entry<String, String> entry : row.entrySet())
            assertThat("Check field: " + entry.getKey(), form.getFieldValueByName(entry.getKey()), equalTo(entry.getValue()));
    }

    // dataType: common, custom
    // | Additional Information | Advertiser | Campaign | Clock Number | Duration | First Air Date | Format | Product | Title | Subtitles Required | Media Agency | Clave | Media Agency Contact | Creative Agency Contact |
    @Then("{I |}should see following read-only '$dataType' data for order item on Add information form: $fieldsTable")
    public void checkAddInformationFormReadOnlyData(String dataType, ExamplesTable fieldsTable) {
        Map<String, String> row = dataType.equals("common") ? prepareAddInformationFields(fieldsTable) : prepareAddInformationCustomFields(fieldsTable);
        if (Data.containsField(SchemaField.FIRST_AIR_DATE, row, false)) row.put(SchemaField.FIRST_AIR_DATE.toString(), convertDateToDefaultUserLocale(Data.getField(SchemaField.FIRST_AIR_DATE, row)));
        AddInformationForm form = getAddInformationForm();
        for (Map.Entry<String, String> entry : row.entrySet())
            assertThat("Check field: " + entry.getKey(), form.getReadOnlyValue(entry.getKey()), equalTo(entry.getValue()));
    }

    // Additional Information,Advertiser,Campaign,Clock Number,Duration,First Air Date,Format,Product,Title,Subtitles Required,Clave,Creative Agency Contact,Language,Media Agency,Media Agency Contact,MBCID Code,Categoria Merceologica Settore,Match,Media Subtype
    @Then("{I |}'$shouldState' see {following|able to edit following} fields '$fields' for order item on Add information form")
    public void checkAddInformationFormFieldsVisibility(String shouldState, String fields) {
        AddInformationForm form = getAddInformationForm();
        for (String fieldName : fields.split(","))
            assertThat("Check visibility field: " + fieldName, form.isFieldVisible(Data.getPrimaryFieldName(SchemaField.findByName(fieldName))), is(shouldState.equals("should")));
    }

    @Then("{I |}'$shouldState' see following custom field{s|} '$fields' for order item on Add information form")
    public void checkAddInformationFormCustomFieldsVisibility(String shouldState, String fields) {
        AddInformationForm form = getAddInformationForm();
        for (String fieldName: fields.split(","))
            assertThat("Check visibility custom field: " + fieldName, form.isCustomFieldVisible(fieldName), is(shouldState.equals("should")));
    }

    // | Additional Information | Advertiser | Campaign | Clock Number | Duration | First Air Date | Format | Product | Title | Subtitles Required |
    @Then("{I |}should see following fields labels for order item on Add information form: $fieldsTable")
    public void checkAddInformationFormFieldsLabels(ExamplesTable fieldsTable) {
        Map<String, String> row = parametrizeTabularRow(fieldsTable);
        AddInformationForm form = getAddInformationForm();
        for (Map.Entry<String, String> entry : row.entrySet())
            assertThat("Check label for field: " + entry.getKey(), form.getFieldsLabel(entry.getKey()), equalTo(entry.getValue()));
    }

    // metadataFieldsList: name1, name2,... nameN
    @Then("{I |}should see that metadata fields in following order '$metadataFieldsList' for order item on Add information form")
    public void checkAddInformationFormMetadataFieldsOrder(String metadataFieldsList) {
        List<String> metadataFieldLabels = Arrays.asList(metadataFieldsList.split(","));
        assertThat("Check metadata fields order: ", getAddInformationForm().getMetadataFieldLabels(), equalTo(metadataFieldLabels));
    }

    @Then("{I |}'$shouldState' see that following fields '$fields' are required for order item on Add information form")
    @Alias("{I |}'$shouldState' see validation error{s|} next to following field{s|} '$fields' for order item on Add information form")
    public void checkAddInformationFormFieldsValidation(String shouldState, String fields) {
        AddInformationForm form = getAddInformationForm();
        for (String fieldName : fields.split(","))
            assertThat("Check is field required: " + fieldName, form.isValidationFieldErrorVisible(Data.getPrimaryFieldName(SchemaField.findByName(fieldName))),
                                                                is(shouldState.equals("should")));
    }

    // state: enabled, disabled
    @Then("{I |}should see '$state' following fields '$fields' for order item on Add information form")
    public void checkAddInformationFormFieldsState(String state, String fields) {
        AddInformationForm form = getAddInformationForm();
        for (String fieldName : fields.split(","))
            assertThat("Check Add information form field: " + fieldName,
                        form.isFieldEnabled(Data.getPrimaryFieldName(SchemaField.findByName(fieldName))), is(state.equals("enabled")));
    }

    @Then("{I |}'$shouldState' see warning icon next following fields '$fields' for order item on Add information form")
    public void checkVisibilityWarningIcon(String shouldState, String fields){
        AddInformationForm form = getAddInformationForm();
        Common.sleep(1000);
        for (String fieldName : fields.split(","))
            assertThat("Check visibility warning icon next field: " + fieldName, form.isWarningIconVisibleNextFollowingField(Data.getPrimaryFieldName(SchemaField.findByName(fieldName))),
                                                                                 is(shouldState.equals("should")));
    }

    @Then("{I |}should see warning tooltip with following message '$message' next field '$fieldName' for order item on Add information form")
    public void checkWarmingTooltipMessageNextAddInformationFormField(String message, String fieldName) {
        AddInformationForm form = getAddInformationForm();
        assertThat("Check warning tooltip message next field: " + fieldName, form.getWarningMessageNextFollowingField(Data.getPrimaryFieldName(SchemaField.findByName(fieldName))),
                                                                             equalTo(message));
    }

    public String verifyUniqueCodeError()
    {
        String text="true";
    try
    {  text = getSut().getWebDriver().findElement(By.xpath("//div[@class='message error']")).getText(); }
    catch(Exception e)
    {
        text="false";
    }
    return text;


}

    // | Additional Information | Advertiser | Campaign | Clock Number | Duration | First Air Date | Format | Product | Title | Subtitles Required | Destination |
    // | CNPJ | CRT | Date of Ancine Registration | Director | Market Segment | Number of Versions | Type |
    @Given("{I |}created '$orderType' streamline order with market '$market' and items with following fields : $fieldsTable")
    @When("{I |}create '$orderType' streamline order with market '$market' and items with following fields : $fieldsTable")
    @Then("{I |}create '$orderType' streamline order with market '$market' and items with following fields : $fieldsTable")
    public void createStreamlineOrder(String orderType, String market, ExamplesTable fieldsTable) {
        if (market.isEmpty()) throw new IllegalArgumentException("Market is not specified!");
        String destinationID = null;
        PAPIApplication app = null;
        PAPIServiceCalls papiCalls = new PAPIServiceCalls();
        User user = getData().getCurrentUser();
        PAPIApplication[] s = getCoreApi().listApplications(user.getEmail());
        if(s.length == 0) {
            app = getCoreApi().generatePAPIKeySecret(user.getEmail(),user.getId());
            user.setKey(app.getKey());
            user.setSecret(app.getSecret());
        }else{
            app = s[0];
            user.setKey(app.getKey());
            user.setSecret(app.getSecret());
        }
        Common.sleep(2000);
        String orderId = papiCalls.createPAPIOrder(getCoreApi().getMarketKey(market), orderType,  user.getKey(), user.getSecret());
        Common.sleep(2000);
        if (orderId != null) {
            for (int i = 0; i < fieldsTable.getRowCount(); i++) {
                Map<String, String> row = parametrizeTabularRow(fieldsTable, i);
                String[] assignee = row.get("Assignee").split(",");
                for(int j = 0; j< assignee.length; j++) {
                    if (!assignee[j].equalsIgnoreCase("autotest@adstream.com")) {
                        assignee[j] = wrapVariableWithTestSession(assignee[j]) + "@adstream.com";
                    }
                }
                OrderItem orderItem = buildAddInformationSectionOfOrderItem(market, new OrderItem(), row);
                orderItem.setUploadRequestAssignees(assignee);
                orderItem.setUploadRequestAlreadySupplied(row.containsKey("Already Supplied") && row.get("Already Supplied").equals("should"));
                if (row.containsKey("Supply Via")) orderItem.setUploadRequestUploadType(new String[]{UploadRequestType.findByName(row.get("Supply Via")).toString()});
                if (row.containsKey("Message")) orderItem.setUploadRequestMessage(row.get("Message"));
                if (row.containsKey("Deadline Date")) {
                    String deadlineDate = row.get("Deadline Date").contains("/") ? row.get("Deadline Date") : prepareDateToStoriesFormat(row.get("Deadline Date"));
                    orderItem.setUploadRequestDeadlineDate(parseDateWithUTCZone(deadlineDate));
                }
                BaseOfBase orderItemPAPI = papiCalls.createPAPIOrderItem(orderId, orderItem, user.getKey(), user.getSecret());
                if (row.containsKey("DestinationID") && !row.get("DestinationID").isEmpty()) {
                      papiCalls.addDestinationPAPI(orderId, orderItemPAPI.getId(),row.get("DestinationID"),user.getKey(), user.getSecret());

                }
                papiCalls.processOrder(orderId, orderItemPAPI.getId(),user.getKey(), user.getSecret());
                Common.sleep(1000);
                if (orderItem == null) throw new NullPointerException("Order item was not created!");
            }
        } else {
            throw new NullPointerException("Order is not created!");
        }
        Common.sleep(2000);
      }

}

