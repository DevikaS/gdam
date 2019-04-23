package com.adstream.automate.babylon.JsonObjects.ordering.templates;

/*
 * Created by demidovskiy-r on 23.02.2015.
 */
public class DeliveryOrderReportTranslations {
    private Language language;
    private String deliveryOrderNumberLabel;
    private String orderNumberLabel;
    private String jobNumberLabel;
    private String poNumberLabel;
    private String numberOfCommercialsLabel;
    private String commercialsLabel;
    private String countryLabel;
    private String brandLabel;
    private String productLabel;
    private String titleLabel;
    private String durationLabel;
    private String formatLabel;
    private String deliveryMethodToLabel;
    private String dateArriveAtLabel;
    private String archiveLabel;
    private String subtitlesRequiredLabel;
    private String noteLabel;
    private String attachmentsLabel;
    private String deliveryPointLabel;
    private String deliverToLabel;
    private String instructionsLabel;
    private final static String DEFAULT_ADVERTISER_LABEL = "Advertiser";
    private final static String DEFAULT_BRAND_LABEL = "Brand";
    private final static String DEFAULT_SUB_BRAND_LABEL = "Sub Brand";
    private final static String DEFAULT_PRODUCT_LABEL = "Product";

    public DeliveryOrderReportTranslations(String language) {
        this.language = Language.findByLanguage(language);
        loadTranslations();
    }

    public String getDeliveryOrderNumberLabel() {
        return deliveryOrderNumberLabel;
    }

    public String getOrderNumberLabel() {
        return orderNumberLabel;
    }

    public String getJobNumberLabel() {
        return jobNumberLabel;
    }

    public String getPoNumberLabel() {
        return poNumberLabel;
    }

    public String getNumberOfCommercialsLabel() {
        return numberOfCommercialsLabel;
    }

    public String getCommercialsLabel() {
        return commercialsLabel;
    }

    public String getCountryLabel() {
        return countryLabel;
    }

    public String getBrandLabel() {
        return brandLabel;
    }

    public String getBrandLabel(String brandLabel) {
        return brandLabel.equals(DEFAULT_BRAND_LABEL) ? getBrandLabel() : brandLabel;  // custom labels don't translate
    }

    public String getProductLabel() {
        return productLabel;
    }

    public String getProductLabel(String productLabel) {
        return productLabel.equals(DEFAULT_PRODUCT_LABEL) ? getProductLabel() : productLabel; // custom labels don't translate
    }

    public String getTitleLabel() {
        return titleLabel;
    }

    public String getDurationLabel() {
        return durationLabel;
    }

    public String getFormatLabel() {
        return formatLabel;
    }

    public String getDeliveryMethodToLabel() {
        return deliveryMethodToLabel;
    }

    public String getDateArriveAtLabel() {
        return dateArriveAtLabel;
    }

    public String getFirstAirDateLabel(String firstAirDateLabel) {
        return initFirstAirDateLabel(firstAirDateLabel);
    }

    public String getArchiveLabel() {
        return archiveLabel;
    }

    public String getSubtitlesRequiredLabel() {
        return subtitlesRequiredLabel;
    }

    public String getSubtitlesRequired(String subtitlesRequired) {
        return initSubtitlesRequired(subtitlesRequired);
    }

    public String getNoteLabel() {
        return noteLabel;
    }

    public String getAttachmentsLabel() {
        return attachmentsLabel;
    }

    public String getDeliveryPointLabel() {
        return deliveryPointLabel;
    }

    public String getDeliverToLabel() {
        return deliverToLabel;
    }

    public String getServiceLevelLabel(String serviceLevel) {
        return initServiceLevelLabel(serviceLevel);
    }

    public String getInstructionsLabel() {
        return instructionsLabel;
    }

    private void initDeliveryOrderNumberLabel() {
        switch (language) {
            case ENGLISH: deliveryOrderNumberLabel = "TV Delivery Order No."; break;
            case SPAIN: deliveryOrderNumberLabel = "Referencia del pedido"; break;
            default: deliveryOrderNumberLabel = "TV Delivery Order No."; break;
        }
    }

    private void initOrderNumberLabel() {
        switch (language) {
            case ENGLISH: orderNumberLabel = "Order no."; break;
            case SPAIN: orderNumberLabel = "Pedido nº"; break;
            default: orderNumberLabel = "Order no."; break;
        }
    }

    private void initJobNumberLabel() {
        switch (language) {
            case ENGLISH: jobNumberLabel = "Job no."; break;
            case SPAIN: jobNumberLabel = "Nº de Referencia de Campaña"; break;
            default: jobNumberLabel = "Job no."; break;
        }
    }

    private void initPoNumberLabel() {
        switch (language) {
            case ENGLISH: poNumberLabel = "Po no."; break;
            case SPAIN: poNumberLabel = "Nº de Orden de Compra"; break;
            default: poNumberLabel = "Po no."; break;
        }
    }

    private void initNumberOfCommercialsLabel() {
        switch (language) {
            case ENGLISH: numberOfCommercialsLabel = "No. of commercials"; break;
            case SPAIN: numberOfCommercialsLabel = "Nº de creatividades"; break;
            default: numberOfCommercialsLabel = "No. of commercials"; break;
        }
    }

    private void initCommercialsLabel() {
        switch (language) {
            case ENGLISH: commercialsLabel = "Commercial"; break;
            case SPAIN: commercialsLabel = "ª Creatividad"; break;
            default: commercialsLabel = "Commercial"; break;
        }
    }

    private void initCountryLabel() {
        switch (language) {
            case ENGLISH: countryLabel = "Country"; break;
            case SPAIN: countryLabel = "Mercado"; break;
            default: countryLabel = "Country"; break;
        }
    }

    private void initBrandLabel() {
        switch (language) {
            case ENGLISH: brandLabel = "Brand"; break;
            case SPAIN: brandLabel = "Marca"; break;
            default: brandLabel = "Brand"; break;
        }
    }

    private void initProductLabel() {
        switch (language) {
            case ENGLISH: productLabel = "Product"; break;
            case SPAIN: productLabel = "Producto"; break;
            default: productLabel = "Product"; break;
        }
    }

    private void initTitleLabel() {
        switch (language) {
            case ENGLISH: titleLabel = "Title"; break;
            case SPAIN: titleLabel = "Nombre de campaña"; break;
            default: titleLabel = "Title"; break;
        }
    }

    private void initDurationLabel() {
        switch (language) {
            case ENGLISH: durationLabel = "Duration"; break;
            case SPAIN: durationLabel = "Duración"; break;
            default: durationLabel = "Duration"; break;
        }
    }

    private void initFormatLabel() {
        switch (language) {
            case ENGLISH: formatLabel = "Format"; break;
            case SPAIN: formatLabel = "Formato"; break;
            default: formatLabel = "Format"; break;
        }
    }

    private void initDeliveryMethodToLabel() {
        switch (language) {
            case ENGLISH: deliveryMethodToLabel = "Delivery method to"; break;
            case SPAIN: deliveryMethodToLabel = "Método de envío a"; break;
            default: deliveryMethodToLabel = "Delivery method to"; break;
        }
    }

    private void initDateArriveAtLabel() {
        switch (language) {
            case ENGLISH: dateArriveAtLabel = "Date commercials will arrive at"; break;
            case SPAIN: dateArriveAtLabel = "Fecha de envío a"; break;
            default: dateArriveAtLabel = "Date commercials will arrive at"; break;
        }
    }

    private String initFirstAirDateLabel(String firstAirDateLabel) {
        switch (language) {
            case ENGLISH: return firstAirDateLabel;
            case SPAIN: return "Fecha de primera emisión";
            default: return firstAirDateLabel;
        }
    }

    private void initArchiveLabel() {
        switch (language) {
            case ENGLISH: archiveLabel = "Archive"; break;
            case SPAIN: archiveLabel = "Almacenar"; break;
            default: archiveLabel = "Archive"; break;
        }
    }

    private void initNoteLabel() {
        switch (language) {
            case ENGLISH: noteLabel = "Note"; break;
            case SPAIN: noteLabel = "Nota"; break;
            default: noteLabel = "Note"; break;
        }
    }

    private void initAttachmentsLabel() {
        switch (language) {
            case ENGLISH: attachmentsLabel = "Attachments"; break;
            case SPAIN: attachmentsLabel = "Adjuntos"; break;
            default: attachmentsLabel = "Attachments"; break;
        }
    }

    private void initSubtitlesRequiredLabel() {
        switch (language) {
            case ENGLISH: subtitlesRequiredLabel = "Subtitles Required"; break;
            case SPAIN: subtitlesRequiredLabel = "Servicio de subtitulado de spots"; break;
            default: subtitlesRequiredLabel = "Subtitles Required"; break;
        }
    }

    private String initSubtitlesRequired(String subtitlesRequired) {
        switch (language) {
            case ENGLISH: return subtitlesRequired;
            case SPAIN:
                switch (subtitlesRequired) {
                    case "Already Supplied": return "Ya enviado";
                    default: throw new IllegalArgumentException("Unknown subtitles required: " + subtitlesRequired);
                }
            default: return subtitlesRequired;
        }
    }

    private void initDeliveryPointsLabel() {
        switch (language) {
            case ENGLISH: deliveryPointLabel = "Delivery Points"; break;
            case SPAIN: deliveryPointLabel = "Nº de envíos"; break;
            default: deliveryPointLabel = "Delivery Points"; break;
        }
    }

    private void initDeliverToLabel() {
        switch (language) {
            case ENGLISH: deliverToLabel = "Deliver to"; break;
            case SPAIN: deliverToLabel = "Destinos"; break;
            default: deliverToLabel = "Deliver to"; break;
        }
    }

    private String initServiceLevelLabel(String serviceLevel) {
        switch (language) {
            case ENGLISH: return serviceLevel;
            case SPAIN:
                switch (serviceLevel) {
                    case "Standard": return "Estándar";
                    case "Express": return "Express";
                    default: throw new IllegalArgumentException("Unknown service level: " + serviceLevel);
                }
            default: return serviceLevel;
        }
    }

    private void initInstructionsLabel() {
        switch (language) {
            case ENGLISH: instructionsLabel = "Instructions"; break;
            case SPAIN: instructionsLabel = "Instrucciones"; break;
            default: instructionsLabel = "Instructions"; break;
        }
    }

    private void loadTranslations() {
        initDeliveryOrderNumberLabel();
        initOrderNumberLabel();
        initJobNumberLabel();
        initPoNumberLabel();
        initNumberOfCommercialsLabel();
        initCommercialsLabel();
        initCountryLabel();
        initBrandLabel();
        initProductLabel();
        initTitleLabel();
        initDurationLabel();
        initFormatLabel();
        initDeliveryMethodToLabel();
        initDateArriveAtLabel();
        initArchiveLabel();
        initNoteLabel();
        initAttachmentsLabel();
        initSubtitlesRequiredLabel();
        initDeliveryPointsLabel();
        initDeliverToLabel();
        initInstructionsLabel();
    }

    protected enum Language {
        ENGLISH("en-us"),
        SPAIN("es-ar");

        private String language;

        private Language(String language) {
            this.language = language;
        }

        @Override
        public String toString() {
            return language;
        }

        public static Language findByLanguage(String language) {
            for (Language lang: values())
                if (lang.toString().equals(language))
                    return lang;
            return Language.ENGLISH;  // returned default language
        }
    }
}