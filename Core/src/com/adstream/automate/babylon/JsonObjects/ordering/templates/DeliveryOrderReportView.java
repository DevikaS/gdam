package com.adstream.automate.babylon.JsonObjects.ordering.templates;

import com.adstream.automate.babylon.JsonObjects.ordering.enums.AccountType;
import com.adstream.automate.babylon.JsonObjects.ordering.enums.OrderType;
import com.adstream.automate.babylon.JsonObjects.ordering.templates.DeliveryOrderReportTranslations.Language;
import java.util.ArrayList;
import java.util.List;

/*
 * Created by demidovskiy-r on 12.12.2014.
 */
public class DeliveryOrderReportView {
    private List<String> reportViewFields;

    public DeliveryOrderReportView(DeliveryOrderReport report) {
        initReportViewFields(report);
        skipFieldIfNullIn();
    }

    public List<String> getReportViewFields() {
        return reportViewFields;
    }

    private List<String> initReportViewFields(DeliveryOrderReport report) {
        DeliveryOrderReportTranslations translationsTool = report.getTranslations();
        Language language = Language.findByLanguage(report.getLanguage());
        reportViewFields = new ArrayList<>();
        reportViewFields.add(String.format("%s %s", translationsTool.getDeliveryOrderNumberLabel(), report.getOrderReference()));
        reportViewFields.add(String.format("%s %s", translationsTool.getOrderNumberLabel(), report.getOrderReference()));
        reportViewFields.add(String.format("%s %s", translationsTool.getJobNumberLabel(), report.getJobNumber()));
        reportViewFields.add(String.format("%s %s", translationsTool.getPoNumberLabel(), report.getPoNumber()));
        reportViewFields.add(String.format("%s %s", translationsTool.getNumberOfCommercialsLabel(), report.getOrderItemsCount()));
        reportViewFields.add(String.format("Date order submitted %s", report.getDateOrderSubmitted()));
        reportViewFields.add(language.equals(Language.SPAIN)
                             ? String.format("%s %s %s", report.getCommercialNumber(), translationsTool.getCommercialsLabel(), report.getClockNumber())
                             : String.format("%s %s %s", translationsTool.getCommercialsLabel(), report.getCommercialNumber(), report.getClockNumber()));
        reportViewFields.add(String.format("%s %s", translationsTool.getCountryLabel(), report.getCountry()));
        reportViewFields.add(String.format("%s %s", getClockNumberLabel(getAccountType(report.getAccountType()), OrderType.findByType(report.getOrderType())), report.getClockNumber()));
        reportViewFields.add(String.format("%s %s", report.getAdvertiserLabel(), report.getAdvertiser()));
        reportViewFields.add(String.format("%s %s", translationsTool.getBrandLabel(report.getBrandLabel()), report.getBrand()));
        reportViewFields.add(String.format("%s %s", report.getSubBrandLabel(), report.getSubBrand()));
        reportViewFields.add(String.format("%s %s", translationsTool.getProductLabel(report.getProductLabel()), report.getProduct()));
        reportViewFields.add(String.format("%s %s", report.getCampaignLabel(), report.getCampaign()));
        reportViewFields.add(String.format("%s %s", translationsTool.getTitleLabel(), report.getTitle()));
        reportViewFields.add(String.format("%s %s", translationsTool.getDurationLabel(), report.getDuration()));
        reportViewFields.add(String.format("%s %s", translationsTool.getFormatLabel(), report.getFormat()));
        reportViewFields.add(String.format("%s %s %s", translationsTool.getDeliveryMethodToLabel(), report.getAccountType(), report.getDeliveryMethod()));
        reportViewFields.add(String.format("%s %s %s", translationsTool.getDateArriveAtLabel(), report.getAccountType(), report.getDateArrivedCommercials()));
        reportViewFields.add(String.format("Time commercials will arrive at %s %s", report.getAccountType(), report.getTimeArrivedCommercials()));
        reportViewFields.add(String.format("Master held at %s", report.getMasterHeldAt()));
        reportViewFields.add(String.format("%s %s", translationsTool.getFirstAirDateLabel(getFirstAirDateLabel(getAccountType(report.getAccountType()), OrderType.findByType(report.getOrderType()))), report.getFirstAirDate()));
        reportViewFields.add(String.format("%s %s", translationsTool.getArchiveLabel(), report.getArchive()));
        reportViewFields.add(String.format("%s %s", translationsTool.getNoteLabel(), report.getNote()));
        reportViewFields.add(String.format("%s %s", translationsTool.getAttachmentsLabel(), report.getAttachments()));
        reportViewFields.add(String.format("%s %s", translationsTool.getDeliveryPointLabel(), report.getDeliveryPoints()));
        // metadata of United Kingdom, etc markets
        reportViewFields.add(String.format("%s %s", translationsTool.getSubtitlesRequiredLabel(), translationsTool.getSubtitlesRequired(report.getSubtitlesRequired())));
        // metadata of Switzerland market
        reportViewFields.add(String.format("Language %s", report.getLanguageMetadata()));
        reportViewFields.add(String.format("SUISA %s", report.getSuisa()));
        // metadata of Spain market
        reportViewFields.add(String.format("Clave %s", report.getClave()));
        reportViewFields.add(String.format("Watermarking Required %s", report.getWatermarkingRequired()));
        reportViewFields.add(String.format("Watermarking Code %s", report.getWatermarkingCode()));
        reportViewFields.add(String.format("Brand %s", report.getWatermarkingBrand()));
        reportViewFields.add(String.format("Model %s", report.getModel()));
        reportViewFields.add(String.format("Product Description %s", report.getWatermarkingProductDescription()));
        reportViewFields.add(String.format("Creative Description %s", report.getCreativeDescription()));
        reportViewFields.add(String.format("Sector %s", report.getSector()));
        reportViewFields.add(String.format("Group %s", report.getGroup()));
        reportViewFields.add(String.format("Producto WM %s", report.getWatermarkingProduct()));
        // common custom metadata fields
        reportViewFields.add(String.format("Address %s", report.getAddressMetadata()));
        for (int i = 0; i < report.getCatalogueStructure().length; i++) // mixing catalogue structure items
            reportViewFields.add(String.format("%s", report.getCatalogueStructure()[i]));
        reportViewFields.add(String.format("Custom Code %s", report.getCustomCodeMetadata()));
        reportViewFields.add(String.format("Date %s", report.getDateMetadata()));
        reportViewFields.add(String.format("Dropdown %s", report.getDropdownMetadata()));
        reportViewFields.add(String.format("Hyperlink %s", report.getHyperLinkMetadata()));
        reportViewFields.add(String.format("Multiline %s", report.getMultiLineMetadata()));
        reportViewFields.add(String.format("Phone %s", report.getPhoneMetadata()));
        reportViewFields.add(String.format("Radio Buttons %s", report.getRadioButtonsMetadata()));
        reportViewFields.add(String.format("String %s", report.getStringMetadata()));
        // destinations
        reportViewFields.add(String.format("%s %s %s", translationsTool.getDeliverToLabel(), translationsTool.getServiceLevelLabel(report.getServiceLevel()), translationsTool.getInstructionsLabel()));
        reportViewFields.add(String.format("%s", report.getDestinationGroup()));
        reportViewFields.add(String.format("%s ✓ %s", report.getDestination(), getEmptyIfNull(report.getAdditionalInstruction())));
        reportViewFields.add(String.format("%s %s %s %s %s (%s) %s", report.getAdditionalServiceType(), report.getAdditionalServiceDestination(), getEmptyIfNull(report.getNotesAndLabels()), report.getAdditionalServiceFormat(), report.getNoCopies(), report.getMediaCompile(), report.getAdditionalServiceLevel()));
        reportViewFields.add(String.format("%s %s", report.getProductionServiceType(), report.getProductionServiceNote()));
        reportViewFields.add(getFooterContentForAccountType(getAccountType(report.getAccountType()), language));
        return reportViewFields;
    }

    private String getEmptyIfNull(String fieldValue) {
        return fieldValue == null ? "" : fieldValue;
    }

    private List<String> skipFieldIfNullIn() {
        List<String> reportsViewFieldsWithNull = new ArrayList<>();
        for (String reportViewField: reportViewFields)
            if (reportViewField.contains("null")) reportsViewFieldsWithNull.add(reportViewField);
        reportViewFields.removeAll(reportsViewFieldsWithNull);
        return reportViewFields;
    }

    private AccountType getAccountType(String accountTypeName) {
        return AccountType.findByName(accountTypeName);
    }

    private String getFooterContentForAccountType(AccountType accountType, Language language) {
        switch (accountType){
            case ADSTREAM:
                switch (language) {
                    case ENGLISH: return "© 2019 Adstream Pty Ltd. www.adstream.com";
                    case SPAIN: return "2019 Adstream España & Portugal C/ Velázquez, 11. 6º Izda. Madrid, 28001";
                    default: throw new IllegalArgumentException("Unknown language: " + language.name());
                }
            case BEAM: return "2019 Beam. All rights reserved. Beam is a Mill Group company Beam UK, 11-14 Windmill Street, London, W1T 2JG, United Kingdom";
            default: throw new IllegalArgumentException("Unknown account type: " + accountType);
        }
    }

    private String getClockNumberLabel(AccountType accountType, OrderType orderType) {
        switch (accountType) {
            case ADSTREAM:
                switch (orderType) {
                    case TV: return "Clock Number";
                    case MUSIC: return "Key Number";
                    default: throw new IllegalArgumentException("Unknown order type: " + orderType.getOrderType());
                }
            case BEAM: return "Spot Code";
            default: throw new IllegalArgumentException("Unknown account type: " + accountType);
        }
    }

    private String getFirstAirDateLabel(AccountType accountType, OrderType orderType) {
        switch (accountType) {
            case ADSTREAM:
                switch (orderType) {
                    case TV: return "First Air Date";
                    case MUSIC: return "Release Date";
                    default: throw new IllegalArgumentException("Unknown order type: " + orderType.getOrderType());
                }
            case BEAM: return "First air date";
            default: throw new IllegalArgumentException("Unknown account type: " + accountType);
        }
    }
}