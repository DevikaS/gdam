package com.adstream.automate.babylon.data;

import com.adstream.automate.babylon.JsonObjects.ordering.enums.AccountType;
import com.adstream.automate.babylon.JsonObjects.ordering.enums.ReminderOfMediaUploadRequest;
import com.adstream.automate.babylon.TestsContext;

import java.net.URL;
import java.util.ArrayList;
import java.util.List;
import static java.util.Arrays.asList;

/**
 * Created with IntelliJ IDEA.
 * User: demidovskiy-r
 * Date: 12.11.12
 * Time: 16:28
 */
public class EmailBody {
    private String subject;
    private String action;
    private String language;
    private String agency;
    private String userFullName;
    private String userEmail;
    private String otherUserFullName;
    private String projectName;
    private String projectId;
    private String folderName;
    private String fileName;
    private String categoryName;
    private String commentText;
    private String presentationName;
    private String approvalStageName;
    private String approvalMessage;
    private String approvalRequestedDate;
    private String approvalRequiredDate;
    private String approvalAction;
    private String message;
    // fields related to ordering are below
    private String orderReference;
    private String dateOrderSubmitted;
    private String orderItemsCount;
    private String commercialNumber;
    private String deadlineDate;
    private String uploadDate;
    private String typeOfCopy = "";
    private String clockNumber;
    private String advertiser;
    private String advertiserDescription;
    private String brand;
    private String brandDescription;
    private String subBrand;
    private String subBrandDescription;
    private String product;
    private String productDescription;
    private String campaign;
    private String campaignDescription;
    private String title;
    private String duration;
    private String format;
    private String jobNumber;
    private String poNumber;
    private String subtitlesRequired;
    private String deliveryPoints;
    private String suisa;
    private String languageMetadata;
    private String serviceLevel;
    private String country;
    private String deliveryMethod;
    private String dateArrivedCommercials;
    private String timeArrivedCommercials;
    private String masterHeldAt;
    private String firstAirDate;
    private String archive;
    private String attachments;
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
    private AccountType accountType;
    private ReminderOfMediaUploadRequest reminderOfMediaUploadRequest;
    private EmailType emailType = EmailType.UNKNOWN;
    private List<String> listOfLinks = new ArrayList<>();
    private URL applicationUrl;
    // fields related to CostModule:
    private String adcostStage;
    private String adcostCostTitle;
    private String adcostCostID;
    private String adcostCostType;
    private String adcostStatus;
    private String adcostAgencyProducer;
    private String adcostAgencyOwner;
    private String adcostAgencyName;
    private String adcostAgencyLocation;
    private String adcostAgencyTracking;
    private String adcostProjectName;
    private String adcostProjectID;
    private String adcostBudgetRegion;
    private String adcostTechnicalApprover;
    private String adcostBrand;
    private String adcostTimestamp;
    private String adcostURLCostId;
    private String adcostRevisionId;
    private String adcostUsageBuyoutContractType;
    private String adcostContentType;
    private String adcostProductionType;
    private String adcostCostApprover;
    private String adcostCostApproverType;
    private String adcostPendingApproval;
    private String adcostCostOwner;
    private String adcostOldCostOwner;
    private String adcostURL;
    private String adcostPnGadmin;
    private String adcostOEApprovedForFM;

    public String getLoggedInUser() {
        return loggedInUser;
    }

    public void setLoggedInUser(String loggedInUser) {
        this.loggedInUser = loggedInUser;
    }

    private String loggedInUser;

    public String getMarket() {
        return market;
    }

    public void setMarket(String market) {
        this.market = market;
    }

    private String market;

    public String getAdcostPnGadmin() {
        return adcostPnGadmin;
    }

    public void setAdcostPnGadmin(String adcostPnGadmin) {
        this.adcostPnGadmin = adcostPnGadmin;
    }

    public String getAdcostOEApprovedForFM() {
        return adcostOEApprovedForFM;
    }

    public void setAdcostOEApprovedForFM(String adcostOEApprovedForFM) {
        this.adcostOEApprovedForFM = adcostOEApprovedForFM;
    }

    public String getAdcostURL() {
        return adcostURL;
    }

    public void setAdcostURL(String adcostURL) {
        this.adcostURL = adcostURL;
    }

    public String getAdcostCostOwner() {
        return adcostCostOwner;
    }

    public void setAdcostCostOwner(String adcostCostOwner) {
        this.adcostCostOwner = adcostCostOwner;
    }

    public String getadcostOldCostOwner() {
        return adcostOldCostOwner;
    }

    public void setadcostOldCostOwner(String adcostOldCostOwner) {
        this.adcostOldCostOwner = adcostOldCostOwner;
    }

    public String getAdcostPendingApproval() {
        return adcostPendingApproval;
    }

    public void setAdcostPendingApproval(String adcostPendingApproval) {
        this.adcostPendingApproval = adcostPendingApproval;
    }

    public String getAdcostCostApprover() {
        return adcostCostApprover;
    }

    public void setAdcostCostApprover(String adcostCostApprover) {
        this.adcostCostApprover = adcostCostApprover;
    }

    public String getAdcostCostApproverType() {
        return adcostCostApproverType;
    }

    public void setAdcostCostApproverType(String adcostCostApproverType) {
        this.adcostCostApproverType = adcostCostApproverType;
    }


    public String getAdcostProductionType() {
        return adcostProductionType;
    }

    public void setAdcostProductionType(String adcostProductionType) {
        this.adcostProductionType = adcostProductionType;
    }

    public String getAdcostUsageBuyoutContractType() {
        return adcostUsageBuyoutContractType;
    }

    public void setAdcostUsageBuyoutContractType(String adcostUsageBuyoutContractType) {
        this.adcostUsageBuyoutContractType = adcostUsageBuyoutContractType;
    }

    public String getAdcostContentType() {
        return adcostContentType;
    }

    public void setAdcostContentType(String adcostContentType) {
        this.adcostContentType = adcostContentType;
    }

    public String getAdcostURLCostId() {
        return adcostURLCostId;
    }

    public void setAdcostURLCostId(String adcostURLCostId) {
        this.adcostURLCostId = adcostURLCostId;
    }

    public String getAdcostRevisionId() {
        return adcostRevisionId;
    }

    public void setAdcostRevisionId(String adcostRevisionId) {
        this.adcostRevisionId = adcostRevisionId;
    }

    public String getAdcostCostType() {
        return adcostCostType;
    }

    public void setAdcostCostType(String adcostCostType) {
        this.adcostCostType = adcostCostType;
    }

    public String getAdcostStatus() {
        return adcostStatus;
    }

    public void setAdcostStatus(String adcostStatus) {
        this.adcostStatus = adcostStatus;
    }

    public String getAdcostAgencyProducer() {
        return adcostAgencyProducer;
    }

    public void setAdcostAgencyProducer(String adcostAgencyProducer) {
        this.adcostAgencyProducer = adcostAgencyProducer;
    }

    public String getAdcostAgencyOwner() {
        return adcostAgencyOwner;
    }

    public void setAdcostAgencyOwner(String adcostAgencyOwner) {
        this.adcostAgencyOwner = adcostAgencyOwner;
    }

    public String getAdcostAgencyName() {
        return adcostAgencyName;
    }

    public void setAdcostAgencyName(String adcostAgencyName) {
        this.adcostAgencyName = adcostAgencyName;
    }

    public String getAdcostAgencyLocation() {
        return adcostAgencyLocation;
    }

    public void setAdcostAgencyLocation(String adcostAgencyLocation) {
        this.adcostAgencyLocation = adcostAgencyLocation;
    }

    public String getAdcostAgencyTracking() {
        return adcostAgencyTracking;
    }

    public void setAdcostAgencyTracking(String adcostAgencyTracking) {
        this.adcostAgencyTracking = adcostAgencyTracking;
    }

    public String getAdcostProjectName() {
        return adcostProjectName;
    }

    public void setAdcostProjectName(String adcostProjectName) {
        this.adcostProjectName = adcostProjectName;
    }

    public String getAdcostProjectID() {
        return adcostProjectID;
    }

    public void setAdcostProjectID(String adcostProjectID) {
        this.adcostProjectID = adcostProjectID;
    }

    public String getAdcostBudgetRegion() {
        return adcostBudgetRegion;
    }

    public void setAdcostBudgetRegion(String adcostBudgetRegion) {
        this.adcostBudgetRegion = adcostBudgetRegion;
    }

    public String getAdcostTechnicalApprover() {
        return adcostTechnicalApprover;
    }

    public void setAdcostTechnicalApprover(String adcostTechnicalApprover) {
        this.adcostTechnicalApprover = adcostTechnicalApprover;
    }

    public String getAdcostBrand() {
        return adcostBrand;
    }

    public void setAdcostBrand(String adcostBrand) {
        this.adcostBrand = adcostBrand;
    }

    public String getAdcostTimestamp() {
        return adcostTimestamp;
    }

    public void setAdcostTimestamp(String adcostTimestamp) {
        this.adcostTimestamp = adcostTimestamp;
    }

    public String getAdcostStage() {
        return adcostStage;
    }

    public void setAdcostStage(String adcostStage) {
        this.adcostStage = adcostStage;
    }

    public String getAdcostCostTitle() {
        return adcostCostTitle;
    }

    public void setAdcostCostTitle(String adcostCostTitle) {
        this.adcostCostTitle = adcostCostTitle;
    }

    public String getAdcostCostID() {
        return adcostCostID;
    }

    public void setAdcostCostID(String adcostCostID) {
        this.adcostCostID = adcostCostID;
    }

    public EmailBody(String action, String agency, String userFullName, URL applicationUrl) {
        this.action = action;
        this.agency = agency;
        this.userFullName = userFullName;
        this.applicationUrl = applicationUrl;
    }

    public EmailBody(String action) {
        this.action = action;
    }

    public void setSubject(String subject) {
        this.subject = subject;
    }

    public void setAction(String action) {
        this.action = action;
    }

    public void setLanguage(String language) {
        this.language = language;
    }

    public void setAgency(String agency) {
        this.agency = agency;
    }

    public void setUserFullName(String userFullName) {
        this.userFullName = userFullName;
    }

    public void setUserEmail(String userEmail) {
        this.userEmail = userEmail;
    }

    public void setProjectName(String projectName) {
        this.projectName = projectName;
    }

    public void setFolderName(String folderName) {
        this.folderName = folderName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    public void setProjectId(String projectId) {
        this.projectId = projectId;
    }

    public void setCommentText(String commentText) {
        this.commentText = commentText;
    }

    public void setOtherUserFullName(String otherUserFullName) {
        this.otherUserFullName = otherUserFullName;
    }

    public void setPresentationName(String presentationName) {
        this.presentationName = presentationName;
    }

    public void setApprovalStageName(String approvalStageName) {
        this.approvalStageName = approvalStageName;
    }

    public void setApprovalMessage(String approvalMessage) {
        this.approvalMessage = approvalMessage;
    }

    public void setApprovalRequestedDate(String approvalRequestedDate) {
        this.approvalRequestedDate = approvalRequestedDate;
    }

    public void setApprovalRequiredDate(String approvalRequiredDate) {
        this.approvalRequiredDate = approvalRequiredDate;
    }

    public void setApprovalAction(String approvalAction) {
        this.approvalAction = approvalAction;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public void setDeadlineDate(String deadlineDate) {
        this.deadlineDate = deadlineDate;
    }

    public void setUploadDate(String uploadDate) {
        this.uploadDate = uploadDate;
    }

    public void setTypeOfCopy(String typeOfCopy) {
        this.typeOfCopy = typeOfCopy;
    }

    public void setOrderReference(String orderReference) {
        this.orderReference = orderReference;
    }

    public void setDateOrderSubmitted(String dateOrderSubmitted) {
        this.dateOrderSubmitted = dateOrderSubmitted;
    }

    public void setOrderItemsCount(String orderItemsCount) {
        this.orderItemsCount = orderItemsCount;
    }

    public void setCommercialNumber(String commercialNumber) {
        this.commercialNumber = commercialNumber;
    }

    public void setClockNumber(String clockNumber) {
        this.clockNumber = clockNumber;
    }

    public void setAdvertiser(String advertiser) {
        this.advertiser = advertiser;
    }

    public void setAdvertiserDescription(String advertiserDescription) {
        this.advertiserDescription = advertiserDescription;
    }

    public void setBrand(String brand) {
        this.brand = brand;
    }

    public void setBrandDescription(String brandDescription) {
        this.brandDescription = brandDescription;
    }

    public void setSubBrand(String subBrand) {
        this.subBrand = subBrand;
    }

    public void setSubBrandDescription(String subBrandDescription) {
        this.subBrandDescription = subBrandDescription;
    }

    public void setProduct(String product) {
        this.product = product;
    }

    public void setProductDescription(String productDescription) {
        this.productDescription = productDescription;
    }

    public void setCampaign(String campaign) {
        this.campaign = campaign;
    }

    public void setCampaignDescription(String campaignDescription) {
        this.campaignDescription = campaignDescription;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public void setDuration(String duration) {
        this.duration = duration;
    }

    public void setFormat(String format) {
        this.format = format;
    }

    public void setJobNumber(String jobNumber) {
        this.jobNumber = jobNumber;
    }

    public void setPoNumber(String poNumber) {
        this.poNumber = poNumber;
    }

    public void setSubtitlesRequired(String subtitlesRequired) {
        this.subtitlesRequired = subtitlesRequired;
    }

    public void setDeliveryPoints(String deliveryPoints) {
        this.deliveryPoints = deliveryPoints;
    }

    public void setSuisa(String suisa) {
        this.suisa = suisa;
    }

    public void setLanguageMetadata(String languageMetadata) {
        this.languageMetadata = languageMetadata;
    }

    public void setServiceLevel(String serviceLevel) {
        this.serviceLevel = serviceLevel;
    }

    public void setCountry(String country) {
        this.country = country;
    }

    public void setDeliveryMethod(String deliveryMethod) {
        this.deliveryMethod = deliveryMethod;
    }

    public void setDateArrivedCommercials(String dateArrivedCommercials) {
        this.dateArrivedCommercials = dateArrivedCommercials;
    }

    public void setTimeArrivedCommercials(String timeArrivedCommercials) {
        this.timeArrivedCommercials = timeArrivedCommercials;
    }

    public void setMasterHeldAt(String masterHeldAt) {
        this.masterHeldAt = masterHeldAt;
    }

    public void setFirstAirDate(String firstAirDate) {
        this.firstAirDate = firstAirDate;
    }

    public void setArchive(String archive) {
        this.archive = archive;
    }

    public void setAttachments(String attachments) {
        this.attachments = attachments;
    }

    public void setDestinationGroup(String destinationGroup) {
        this.destinationGroup = destinationGroup;
    }

    public void setDestination(String destination) {
        this.destination = destination;
    }

    public void setAdditionalInstruction(String additionalInstruction) {
        this.additionalInstruction = additionalInstruction;
    }

    public void setAdditionalServiceType(String additionalServiceType) {
        this.additionalServiceType = additionalServiceType;
    }

    public void setAdditionalServiceDestination(String additionalServiceDestination) {
        this.additionalServiceDestination = additionalServiceDestination;
    }

    public void setNotesAndLabels(String notesAndLabels) {
        this.notesAndLabels = notesAndLabels;
    }

    public void setAdditionalServiceFormat(String additionalServiceFormat) {
        this.additionalServiceFormat = additionalServiceFormat;
    }

    public void setNoCopies(String noCopies) {
        this.noCopies = noCopies;
    }

    public void setMediaCompile(String mediaCompile) {
        this.mediaCompile = mediaCompile;
    }

    public void setAdditionalServiceLevel(String additionalServiceLevel) {
        this.additionalServiceLevel = additionalServiceLevel;
    }

    public void setProductionServiceType(String productionServiceType) {
        this.productionServiceType = productionServiceType;
    }

    public void setProductionServiceNote(String productionServiceNote) {
        this.productionServiceNote = productionServiceNote;
    }

    public void setAccountType(AccountType accountType) {
        this.accountType = accountType;
    }

    public void setReminderOfMediaUploadRequest(ReminderOfMediaUploadRequest reminderOfMediaUploadRequest) {
        this.reminderOfMediaUploadRequest = reminderOfMediaUploadRequest;
    }

    public String generateSubject() {
        String result = "";
        switch (emailType) {
            case PROJECT_OWNER_ADDED:
                String constPart = " has been added as Project Owner on project ";
                result = "Adbank - " + userFullName + constPart + projectName;
                break;
            case PROJECT_OWNER_REMOVED:
                constPart = " has been removed as Project Owner from ";
                result = "Adbank - " + userFullName + constPart + projectName;
                break;
            case COMMENT_WRITTEN:
                result = String.format("A comment has been made on file %s from project %s", fileName, projectName);
                break;
            case SECURE_COMMENT_WRITTEN:
                if ("de".equals(language)) {
                    result = String.format("Adbank - Neuer Kommentar zur Datei %s im Projekt %s", fileName, projectName);
                } else if ("fr".equals(language)) {
                    result = String.format("Adbank - Un commentaire a été ajouté sur le fichier %s du projet %s", fileName, projectName);
                } else if (asList("es-es", "es-ar").contains(language)) {
                    result = String.format("Se ha añadido un comentario en %s dentro de %s", fileName, projectName);
                } else if (asList("en-beam", "en-beam-us").contains(language)) {
                    result = String.format("A comment has been made on file %s from project %s", fileName, projectName);
                } else {
                    result = String.format("A comment has been made on file %s from project %s", fileName, projectName);
                }
                break;
            case FILE_DOWNLOADED:
                if ("de".equals(language)) {
                    result = String.format("Adbank - %s wurde erfolgreich heruntergeladen", fileName);
                } else if ("fr".equals(language)) {
                    result = String.format("Adbank - %s a été téléchargé avec succès", fileName);
                } else if (asList("es-es", "es-ar").contains(language)) {
                    result = String.format("%s ha sido descargado", fileName);
                } else if (asList("en-beam", "en-beam-us").contains(language)) {
                    result = String.format("Beam - %s has been successfully downloaded", fileName);
                } else {
                    result = String.format("Adbank - %s has been successfully downloaded", fileName);
                }
                break;
            case FILE_DELETED:
                // result = "File " + fileName + " has been deleted";
                result = userFullName + " has deleted files from " + projectName;
                break;
            case FILE_PLAYED:
                result = "Adbank - " + fileName + " has been viewed";
                break;
            case FILE_MOVED_TO_LIBRARY:
                if ("de".equals(language)) {
                    result = String.format("Adbank - %s wurde in die Library verschoben", fileName);
                } else if ("fr".equals(language)) {
                    result = String.format("Adbank - %s est copié dans la médiathèque", fileName);
                } else if (asList("es-es", "es-ar").contains(language)) {
                    result = String.format("%s se ha enviado a la Biblioteca", fileName);
                } else if (asList("en-beam", "en-beam-us").contains(language)) {
                    result = String.format("Beam - %s has been sent to the Library", fileName);
                } else {
                    result = String.format("Adbank - %s has been sent to the Library", fileName);
                }
                break;
            case FILE_UPLOADED_TO_PROJECTS:
                if ("de".equals(language)) {
                    result = String.format("Adbank - %s wurde erfolgreich hochgeladen", fileName);
                } else if ("fr".equals(language)) {
                    result = String.format("Adbank - %s est uploadé avec succès", fileName);
                } else if (asList("es-es", "es-ar").contains(language)) {
                    result = String.format("%s se ha subido al proyecto %s", fileName, projectName);
                } else if (asList("en-beam", "en-beam-us").contains(language)) {
                    result = String.format("Beam - %s has been successfully uploaded", fileName);
                } else {
                    result = "Files were uploaded";
                }
                break;
            case ASSET_SHARING:
                if ("de".equals(language)) {
                    result = String.format("%s hat eine Datei mit Ihnen geteilt", userFullName);
                } else if ("fr".equals(language)) {
                    result = String.format("%s partage un fichier avec vous", userFullName);
                } else if (asList("es-es", "es-ar").contains(language)) {
                    result = String.format("%s ha compartido un archivo contigo", userFullName);
                } else {
                    result = String.format("%s has shared file with you", userFullName);
                }
                break;
            case FILE_SHARING:
                if ("de".equals(language)) {
                    result = String.format("%s hat eine Datei mit Ihnen geteilt", userFullName);
                } else if ("fr".equals(language)) {
                    result = "Adbank - Le fichier a été partagé par vous";
                } else if (asList("es-es", "es-ar").contains(language)) {
                    result = String.format("%s ha compartido un archivo contigo", userFullName);
                } else if ("en-au".equals(language)) {
                    result = userFullName + " has shared file with you";
                } else if (asList("en-beam-us", "en-beam").contains(language)) {
                    result = "A file has been shared with you";
                } else {
                    result = userFullName + " has shared file with you";
                }
                break;
            case CATEGORY_SHARING:
                result = String.format("Collection has been shared with %s", userEmail);
                break;
            case FILE_SHARING_WITH_USER:
                if ("de".equals(language)) {
                    result = "Adbank - Datei wurde mit Ihnen geteilt";
                } else if ("fr".equals(language)) {
                    result = "Adbank - Le fichier a été partagé par vous";
                } else if (asList("es-es", "es-ar").contains(language)) {
                    result = "Adbank - Se ha compartido un archivo contigo";
                } else {
                    result = "File(s) has been shared with you";
                }
                break;
            case ASSET_SHARING_WITH_USER:
                if ("de".equals(language)) {
                    result = "Datei wurde mit Ihnen geteilt";
                } else if ("fr".equals(language)) {
                    result = String.format("File %s partage un fichier avec %s", fileName, otherUserFullName);
                } else if (asList("es-es", "es-ar").contains(language)) {
                    result = String.format("Se ha compartido el archivo %s con %s", fileName, otherUserFullName);
                } else {
                    // result = String.format("Assets has been shared with %s", otherUserFullName);
                    result = "Assets has been shared with you";
                }
                break;
            case ASSET_SHARING_WITH_EASY_USER:
                if ("de".equals(language)) {
                    result = "Sie wurden als neuer Benutzer für die Adbank eingeladen";
                } else if ("fr".equals(language)) {
                    result = "Vous êtes invité(e) à vous connecter à Adbank";
                } else if (asList("es-es", "es-ar").contains(language)) {
                    result = "Has sido invitado a Adbank";
                } else if (asList("en-beam", "en-beam-us").contains(language)) {
                    result = "You are invited to Beam";
                } else {
                    result = "You are invited to Adbank";
                }
                break;
            case FOLDER_SHARING_FOR_USER:
                if (action.equalsIgnoreCase("Folder sharing for")) {
                    result = "Folders have been shared with you";
                } else {
                    if ("de".equals(language)) {
                        result = "Adbank - Ordner wurde(n) mit Ihnen geteilt";
                    } else if ("fr".equals(language)) {
                        result = "Adbank - Le dossier a été partagé avec vous";
                    } else if (asList("es-es", "es-ar").contains(language)) {
                        result = "Adbank - Se ha(n) compartido carpeta(s) contigo";
                    } else if (asList("en-beam", "en-beam-us").contains(language)) {
                        result = "A Project Folder(s) has been shared with you";
                    } else {
                        result = "Folders have been shared with you";
                    }
                }
                break;
            case FOLDER_SHARING_FOR_EASY_USER:
                result = "You have been invited to a " + agency + " project";
                break;
            case PROJECT_TEAM_ADDED:
                result = "Adbank - " + userFullName + " has been added to the Project Team for project " + projectName;
                break;
            case PRESENTATION_SHARING_FOR_USER:
                if ("de".equals(language)) {
                    result = String.format("Adbank - Präsentation %s wurde mit Ihnen geteilt", presentationName);
                } else if ("fr".equals(language)) {
                    result = String.format("Adbank - Le showreel %s est partagé avec vous", presentationName);
                } else if (asList("es-es", "es-ar").contains(language)) {
                    result = String.format("Se ha compartido la presentación %s contigo", presentationName);
                } else if (asList("en-beam", "en-beam-us").contains(language)) {
                    result = String.format("BeamPresentation %s has been shared with you", presentationName);
                } else {
                    result = String.format("Presentation %s has been shared with you", presentationName);
                }
                break;
            case PRESENTATION_SHARING_FOR_OTHER_USER:
                result = "Presentation " + presentationName + " has been shared with " + userFullName;
                break;
            case PRESENTATION_FILE_DOWNLOADED:
                result = "Adbank - Presentation " + presentationName + " has been downloaded";
                break;
            case PRESENTATION_VIEWED:
                result = "Adbank - Presentation " + presentationName + " has been viewed";
                break;
            case PREVIEW_TRANSCODE_FAILED:
                result = "Oooops sorry, but Adbank could not generate a preview for file " + fileName;
                break;
            case USER_INVITATION:
                result = "You are invited to the Adstream Platform";
                break;
            case USER_PASSWORD:
                result = "Your Adbank password reset request";
                break;
            case APPROVAL_FEEDBACK_GIVEN:
                result = String.format("%s %s %s", userFullName, approvalAction, fileName);
                break;
            case APPROVAL_REQUEST:
                if ("de".equals(language)) {
                    result = String.format("%s von %s bittet um Freigabe", userEmail, agency);
                } else if ("fr".equals(language)) {
                    result = String.format("%s de %s a demandé votre approbation", userEmail, agency);
                } else if (asList("es-es", "es-ar").contains(language)) {
                    result = String.format("%s de %s solicita tu aprobación", userEmail, agency);
                } else {
                    result = String.format("%s from %s has requested your approval", userFullName, agency);
                }
                break;
            case APPROVAL_COMPLETED:
                if ("de".equals(language)) {
                    result = String.format("Freigabestufe - %s für file %s wurde abgeschlossen", approvalStageName, fileName);
                } else if ("fr".equals(language)) {
                    result = String.format("L'étape d'approbation - %s pourfile %s est achevée", approvalStageName, fileName);
                } else if (asList("es-es", "es-ar").contains(language)) {
                    result = String.format("La fase de aprobación - %s para file %s se ha completado", approvalStageName, fileName);
                } else {
                    result = String.format("Approval for file %s has completed", fileName);
                }
                break;
            case APPROVED_BY_USER:
                if ("de".equals(language)) {
                    result = String.format("%s von %s hat folgende Datei freigegeben: %s - %s", userFullName, agency, approvalStageName, fileName);
                } else if ("fr".equals(language)) {
                    result = String.format("%s de %s a approuvé %s - %s", userFullName, agency, approvalStageName, fileName);
                } else if (asList("es-es", "es-ar").contains(language)) {
                    result = String.format("%s de %s ha aprobado %s - %s", userFullName, agency, approvalStageName, fileName);
                } else {
                    result = String.format("%s approved %s", userFullName, fileName);
                }
                break;
            case APPROVAL_REQUIRED_REMINDER:
                if ("de".equals(language)) {
                    result = "Freigabe erforderlich - Erinnerung!";
                } else if ("fr".equals(language)) {
                    result = "Approbation requise - rappel!";
                } else if (asList("es-es", "es-ar").contains(language)) {
                    result = "Aprobación requerida - Recordatorio";
                } else {
                    result = "Approval required - reminder!";
                }
                break;
            case MEDIA_TRANSFER_REQUEST:
                result = subject;
                break;
            case NVERGE_UPLOAD_REQUEST:
                result = subject;
                break;
            case REMINDER_OF_MEDIA_UPLOAD_REQUEST:
                result = subject;
                break;
            case SUBTITLES_REQUIRED:
                result = subject;
                break;
            case GENERICS_UPLOAD:
                result = subject;
                break;
            case ORDER_CONFIRMATION:
                result = subject;
                break;
            case TRANSFER_ORDER:
                result = subject;
                break;
            case FAILED_ORDER_CONFIRMATION:
                result = String.format("Failed to complete order: %s", orderReference);
                break;
            case PLEASE_IGNORE_UPLOAD_REQUEST:
                result = subject;
                break;
            case ADSTREAM_UPLOAD_REQUEST_FOR:
                result = String.format("Adstream Upload Request for %s",advertiser);
                break;
            case COST_SUBMITTED:
                result = subject;
                break;
            case COST_APPROVERADDED:
                result = subject;
                break;
            case COST_APPROVED_IN_COSTMODULE:
                result = subject;
                break;
            case COST_APPROVED_IN_COUPA:
                result = subject;
                break;
            case COST_PENDING_APPROVAL:
                result = subject;
                break;
            case COST_RECALLED_COSTOWNERS:
                result = subject;
                break;
            case COST_RECALLED_COSTAPPROVERS:
                result = subject;
                break;
            case COST_REQUEST_CHANGES:
                result = subject;
                break;
            case COST_REQUEST_CHANGES_INSURANCEUSER:
                result = subject;
                break;
            case COST_CANCELLED:
                result = subject;
                break;
            case COST_REOPEN_REQUEST:
                result = subject;
                break;
            case COST_REOPEN_SUCCESS:
                result = subject;
                break;
            case COST_APPROVAL_REASSIGNED:
                result = subject;
                break;
        }
        return result;
    }

    // Raja : 10-Nov-2015
    public List<String> generateBody_new() {
        // This method will be return list of strings without \r\n.
        List<String> result = new ArrayList<>();
        switch (emailType) {
            case MEDIA_TRANSFER_REQUEST:
                result.add(String.format("%s from %s has requested the following material to be delivered to %s by %s", userFullName, agency, accountType, deadlineDate));
                result.add(String.format("%s : %s : %s : %s : %s :: %s", clockNumber, advertiser, product, title, duration, format));
                //result.add("Additional message:");
                result.add(String.format("%s", message));
                result.add(String.format("contact your local %s office", accountType));
                result.add(String.format("%s", accountType.getContactUrl()));
                if (accountType.equals(AccountType.ADSTREAM_NORDIC)) {
                    if (destination != null) {  // no destinations in case QC & Ingest only
                        result.add("Destination (s)");
                        for (String dest : destination.split(","))
                            result.add(String.format("%s", dest));
                    }
                    result.add("Thank you & kind regards");
                }
                break;
        }
        return result;
    }

    public List<String> generateBody() {
        // This method will be return list of strings without \r\n.
        List<String> result = new ArrayList<>();
        switch (emailType) {
            case PROJECT_OWNER_ADDED:
                result.add(userFullName + " has been added as Project Owner on project " + projectName + " " + userFullName + " from " + agency + " has been added as Project Owner on project " + projectName);
                result.add("To access the Project click the link below:");
                break;
            case PROJECT_OWNER_REMOVED:
                result.add(userFullName + " has been removed as Project Owner from " + projectName + " " + userFullName + " from " + agency + " has been removed as Project Owner from project " + projectName);
                result.add("To access the Project click the link below:");
                break;
            case COMMENT_WRITTEN:
                result.add(userFullName + " from " + agency + " has left the below comment on file " + fileName + " from project " + projectName);
                result.add(commentText);
                result.add("To view the asset and reply to the comment click the link below:");
                break;
            case SECURE_COMMENT_WRITTEN:
                if ("de".equals(language)) {
                    result.add(String.format("Adbank - Neuer Kommentar zur Datei %s im Projekt", fileName));
                    result.add(String.format("%s %s von %s hat folgenden Kommentar zur Datei %s im Projekt %s hinzugefügt:", projectName, userFullName, agency, fileName, projectName));
                    result.add(commentText);
                    result.add("Klicken Sie auf den folgenden Link, um die Datei zu öffnen oder auf den Kommentar zu antworten:");
                    result.add(fileName);
                } else if ("fr".equals(language)) {
                    result.add(String.format("Adbank - Un commentaire a été ajouté sur le fichier %s du projet", fileName));
                    result.add(String.format("%s de %s a ajouté un commentaire sur le fichier %s du projet", userFullName, agency, fileName));
                    result.add("Pour voir le fichier et répondre au commentaire, merci de cliquer sur le lien ci-dessous");
                } else if (asList("es-es", "es-ar").contains(language)) {
                    result.add(String.format("Se ha añadido un comentario en %s dentro de", fileName));
                    result.add(String.format("%s de %s ha escrito un comentario en el archivo %s dentro del proyecto", userFullName, agency, fileName));
                    result.add("Para ver el archivo y añadir comentarios, haz click en el siguiente enlace");
                } else if (asList("en-beam", "en-beam-us").contains(language)) {
                    result.add(String.format("A comment has been made on file %s from project", fileName));
                    result.add(String.format("%s from %s has left the below comment on file %s from project", userFullName, agency, fileName));
                    result.add("To view the asset and reply to the comment click the link below");
                } else {
                    result.add(String.format("A comment has been made on file %s from project", fileName));
                    result.add(String.format("%s %s has left the below comment on file %s from project", userFullName, agency, fileName));
                    result.add("To view the asset and reply to the comment click the link below");
                }
                break;
            case FILE_DOWNLOADED:
                if ("de".equals(language)) {
                    result.add(String.format("Adbank - %s wurde erfolgreich heruntergeladen", fileName));
                    result.add(String.format("Die Datei %s im Projekt %s wurde erfolgreich von %s von %s heruntergeladen.", fileName, projectName, userFullName, agency));
                    result.add("Klicken Sie auf folgenden Link, um die Datei zu öffnen");
                } else if ("fr".equals(language)) {
                    result.add(String.format("Adbank - %s a été téléchargé avec succès", fileName));
                    result.add(String.format("Fichier %s du projet %s a été téléchargé avec succès par %s de %s", fileName, projectName, userFullName, agency));
                    result.add("Pour voir le fichier, cliquer sur le lien ci-dessous");
                } else if (asList("es-es", "es-ar").contains(language)) {
                    result.add(String.format("%s ha sido descargado", fileName));
                    result.add(String.format("%s de %s ha descargado el archivo El archivo %s del proyecto %s", userFullName, agency, fileName, projectName));
                    result.add("Para ver el archivo, haz click en el siguiente enlace");
                } else if (asList("en-beam", "en-beam-us").contains(language)) {
                    result.add(String.format("Beam - %s has been successfully downloaded", fileName));
                    result.add(String.format("File %s from project %s has been successfully downloaded by %s from %s", fileName, projectName, userFullName, agency));
                    result.add("To view the file click the link below");
                } else {
                    result.add(String.format("Adbank - %s has been successfully downloaded", fileName));
                    result.add(String.format("File %s from project %s has been successfully downloaded by %s from %s", fileName, projectName, userFullName, agency));
                    result.add("To view the file click the link below:");
                }

                result.add(String.format("%s/%s/%s", projectName, folderName, fileName));
                break;
            case FILE_DELETED:
                //result.add("File " + fileName + " has been deleted by " + userFullName);
                result.add(userFullName + " has deleted files from " + projectName);
                break;
            case FILE_PLAYED:
                result.add("File " + fileName + " from project " + projectName + " has been viewed by " + userFullName + " from " + agency);
                result.add("To view the file click the link below:");
                break;
            case FILE_MOVED_TO_LIBRARY:
                if ("de".equals(language)) {
                    result.add(String.format("Adbank - %s wurde in die Library verschoben", fileName));
                    result.add(String.format("Die Datei %s im Projekt %s wurde von %s von %s in die Library verschoben", fileName, projectName, userFullName, agency));
                    result.add("Klicken Sie auf folgenden Link, um die Datei in der Library zu öffnen");
                } else if ("fr".equals(language)) {
                    result.add(String.format("Adbank - %s est copié dans la médiathèque", fileName));
                    result.add(String.format("Fichier %s du projet %s est copié dans la médiathèque par %s de %s", fileName, projectName, userFullName, agency));
                    result.add("Pour visualiser le fichier dans la médiathèque, cliquer sur le lien ci-dessous");
                } else if (asList("es-es", "es-ar").contains(language)) {
                    result.add(String.format("%s se ha enviado a la Biblioteca", fileName));
                    result.add(String.format("%s de %s ha enviado a la Biblioteca el archivo El archivo %s del proyecto %s", userFullName, agency, fileName, projectName));
                    result.add("Para ver el archivo dentro de la Biblioteca, haz click en el siguiente enlace");
                } else if (asList("en-beam", "en-beam-us").contains(language)) {
                    result.add(String.format("Beam - %s has been sent to the Library", fileName));
                    result.add(String.format("File %s from project %s has been sent to the library by %s from %s", fileName, projectName, userFullName, agency));
                    result.add("To view the file in the library click the link below");
                } else {
                    result.add(String.format("Adbank - %s has been sent to the Library", fileName));
                    result.add(String.format("File %s from project %s has been sent to the library by %s from %s", fileName, projectName, userFullName, agency));
                    result.add("To view the file in the library click the link below");
                }

                result.add(String.format("%s/%s/%s", projectName, folderName, fileName));
                break;
            case FILE_UPLOADED_TO_PROJECTS:
                if ("de".equals(language)) {
                    result.add(String.format("Adbank - %s wurde erfolgreich hochgeladen", fileName));
                    result.add(String.format("Die Datei %s wurde erfolgreich von %s von %s in das Projekt %s hochgeladen", fileName, userFullName, agency, projectName));
                    result.add("Klicken Sie auf folgenden Link, um die Datei zu öffnen");
                } else if ("fr".equals(language)) {
                    result.add(String.format("Adbank - %s est uploadé avec succès", fileName));
                    result.add(String.format("Fichier %s est uploadé avec succès dans le projet %s par %s de %s", fileName, projectName, userFullName, agency));
                    result.add("Pour voir le fichier, cliquer sur le lien ci-dessous");
                } else if (asList("es-es", "es-ar").contains(language)) {
                    result.add(String.format("%s se ha subido al proyecto %s", fileName, projectName));
                    result.add(String.format("%s de %s ha subido el siguiente archivo al proyecto %s", userFullName, agency, projectName));
                    result.add(String.format("El archivo %s", fileName));
                    result.add("Para ver el archivo, haz click en el siguiente enlace");
                } else if (asList("en-beam", "en-beam-us").contains(language)) {
                    result.add(String.format("Beam - %s has been successfully uploaded", fileName));
                    result.add(String.format("File %s has been successfully uploaded to project %s by %s from %s", fileName, projectName, userFullName, agency));
                    result.add("To view the file click the link below");
                } else {
                    result.add(String.format("Files were uploaded by %s", userFullName));
                    result.add(String.format("has uploaded files: %s", fileName));
                }

//                result.add(String.format("%s/%s/%s", projectName, folderName, fileName));
                break;
            case ASSET_SHARING:
                if ("de".equals(language)) {
                    result.add(String.format("%s hat eine Datei mit Ihnen geteilt", userFullName));
                    result.add(String.format("%s von %s hat eine Datei mit Ihnen geteilt", userFullName, agency));
                    result.add("Klicken Sie auf folgenden Link, um die Datei zu öffnen");
                } else if ("fr".equals(language)) {
                    result.add(String.format("%s partage un fichier avec vous", userFullName));
                    result.add(String.format("%s de %s partage un fichier avec vous", userFullName, agency));
                    result.add(String.format("%s de %s partage un fichier avec vous", userFullName, agency));
                    result.add("Merci de cliquer sur le lien ci-dessous pour visualiser le fichier");
                } else if (asList("es-es", "es-ar").contains(language)) {
                    result.add(String.format("%s ha compartido un archivo contigo", userFullName));
                    result.add(String.format("%s de %s ha compartido un archivo contigo", userFullName, agency));
                    result.add("Haz click en el siguiente enlace para acceder al archivo");
                } else {
                    result.add(String.format("%s has shared file with you", userFullName));
                    result.add(String.format("%s from %s has shared file with you.", userFullName, agency));
                    result.add("Please click the link below to view the file");
                }

                result.add(fileName);
                if (message != null) result.add(message);
                break;
            case FILE_SHARING:
                if ("de".equals(language)) {
                    result.add(String.format("%s hat eine Datei mit Ihnen geteilt", userFullName));
                    result.add(String.format("%s von %s hat eine Datei mit Ihnen geteilt. Klicken Sie auf folgenden Link, um die Datei zu öffnen: %s", userFullName, agency, fileName));
                    result.add(message);
                } else if ("fr".equals(language)) {
                    result.add("Adbank - Le fichier a été partagé par vous");
                    result.add(String.format("%s de %s a partagé le fichier(s) avec vous : %s", userFullName, agency, fileName));
                } else if (asList("es-es", "es-ar").contains(language)) {
                    result.add(String.format("%s ha compartido un archivo contigo", userFullName));
                    result.add(String.format("%s de %s ha compartido un archivo contigo.", userFullName, agency));
                    result.add(String.format("Haz click en el siguiente enlace para acceder al archivo: %s", fileName));
                } else if ("en-au".equals(language)){
                    result.add(userFullName + " has shared file with you");
                    result.add(String.format("%s from %s has shared file with you", userFullName, agency));
                    result.add("Please click link to view the file:");
                    result.add(fileName);
                } else if (asList("en-beam-us", "en-beam").contains(language)){
                    result.add("A file has been shared with you");
                    result.add(String.format("%s from %s has shared a file with you", userFullName, agency));
                    result.add("Please click the link below to view the file:");
                    result.add(fileName);
                } else {
                    result.add(userFullName + " has shared file with you");
                    result.add(String.format("%s from %s has shared file with you", userFullName, agency));
                    result.add("Please click the link below to view the file:");
                    result.add(fileName);
                }

                if (message != null) result.add(message);
                break;
            case CATEGORY_SHARING:
                result.add("Collection has been shared with");
                result.add(String.format("Dear %s, %s from %s has shared collection %s with your business unit.", userFullName, otherUserFullName, agency, categoryName));
                result.add("To review, accept or reject materials from this collection into your Library click the link below:");
                break;
            case FILE_SHARING_WITH_USER:
                if ("de".equals(language)) {
                    result.add("Adbank - Datei wurde mit Ihnen geteilt");
                    result.add(String.format("%s von %s hat Datei(en) mit Ihnen geteilt: %s", userFullName, agency, fileName));
                } else if ("fr".equals(language)) {
                    result.add("Adbank - Le fichier a été partagé par vous");
                    result.add(String.format("%s de %s a partagé le fichier(s) avec vous : %s", userFullName, agency, fileName));
                } else if (asList("es-es", "es-ar").contains(language)) {
                    result.add("Adbank - Se ha compartido un archivo contigo");
                    result.add(String.format("%s de %s ha compartido un archivo contigo : %s", userFullName, agency, fileName));
                } else {
                    result.add("File(s) has been shared with you");
                    result.add(String.format("%s from %s has shared file(s) with you : %s", userFullName, agency, fileName));
                }
                if (message != null) result.add(message);
                break;
            case ASSET_SHARING_WITH_USER:
                if ("de".equals(language)) {
                    result.add("Datei wurde mit Ihnen geteilt");
                    result.add(String.format("%s von %s hat Datei(en) mit Ihnen geteilt: %s", userFullName, agency, fileName));
                } else if ("fr".equals(language)) {
                    result.add(String.format("File %s partage un fichier avec %s", fileName, otherUserFullName));
                    result.add(String.format("%s de %s partage", userFullName, agency));
                    result.add(String.format("%s avec %s", fileName, otherUserFullName));
                } else if (asList("es-es", "es-ar").contains(language)) {
                    result.add(String.format("Se ha compartido el archivo %s con %s", fileName, otherUserFullName));
                    result.add(String.format("%s de %s ha compartido", userFullName, agency));
                } else {
                    //result.add(String.format("%s %s has shared asset(s) with %s:", userFullName, agency, otherUserFullName));
                    result.add(String.format("%s %s has shared asset(s) with you", userFullName, agency));
                    result.add(String.format("%s", fileName));
                }
                if (message != null) result.add(message);
                break;
            case ASSET_SHARING_WITH_EASY_USER:
                if ("de".equals(language)) {
                    result.add("Sie wurden als neuer Benutzer für die Adbank eingeladen Herzlich Willkommen");
                    result.add(String.format("%s von %s hat eine Datei mit Ihnen geteilt", userFullName, agency));
                    result.add("Klicken Sie auf folgenden Link");
                    result.add("um sich für die Adbank zu registrieren und die Datei zu öffnen:");
                    result.add("Hier registrieren");
                    result.add(message);
                } else if ("fr".equals(language)) {
                    result.add("Vous êtes invité(e) à vous connecter à Adbank");
                    result.add("Madame ou Monsieur");
                    result.add(String.format("%s de %s partage un fichier avec vous dans Adbank", userFullName, agency));
                    result.add("Merci de cliquer sur le lien ci-dessous pour vous enregistrer à Adbank et accéder au fichier");
                    result.add("Registration");
                } else if (asList("es-es", "es-ar").contains(language)) {
                    result.add("Has sido invitado a Adbank");
                    result.add("Hola");
                    result.add(String.format("%s de %s ha compartido un archivo en Adbank", userFullName, agency));
                    result.add("Por favor, haz click en el siguiente enlace para crear tu cuenta en Adbank y acceder al archivo");
                    result.add("Crear cuenta");
                } else if (asList("en-beam", "en-beam-us").contains(language)) {
                    result.add("You are invited to Beam");
                    result.add("Dear Sir or Madam");
                    result.add(String.format("%s from %s has shared file on Beam", userFullName, agency));
                    result.add("Please click the link below to register for Beam and access the file");
                    result.add("Registration");
                } else {
                    result.add("You are invited to Adbank");
                    result.add("Dear Sir or Madam");
                    result.add(String.format("%s from %s has shared file on Adbank", userFullName, agency));
                    result.add("Please click the link below to register for Adbank and access the file");
                    result.add("Registration");
                }
                if (message != null) result.add(message);
                break;
            case FOLDER_SHARING_FOR_USER:
                if (action.equalsIgnoreCase("Folder sharing for")) {
                    result.add(userFullName + " " + agency + " has shared folders with you");
                    result.add("To access the folder click the link below:");
                } else {
                    if ("de".equals(language)) {
                        result.add("Adbank - Ordner wurde(n) mit Ihnen geteilt");
                        result.add(String.format("%s von %s hat Ordner mit Ihnen geteilt", userFullName, agency));
                        result.add("Klicken Sie auf den folgenden Link, um den Ordner zu öffnen");
                    } else if ("fr".equals(language)) {
                        result.add("Adbank - Le dossier a été partagé avec vous");
                        result.add(String.format("%s de %s a partagé le dossier avec vous", userFullName, agency));
                        result.add("Pour accéder au dossier, cliquer sur le lien ci-dessous");
                    } else if (asList("es-es", "es-ar").contains(language)) {
                        result.add("Adbank - Se ha(n) compartido carpeta(s) contigo");
                        result.add(String.format("%s de %s ha compartido carpeta(s) contigo", userFullName, agency));
                        result.add("Para acceder a la carpeta, haz click en el siguiente enlace");
                    } else if (asList("en-beam", "en-beam-us").contains(language)) {
                        result.add("Folder(s) has been shared with you");
                        result.add(String.format("%s from %s has shared folder(s) with you", userFullName, agency));
                        result.add("To access the folder click the link below");
                    } else {
                        result.add("Folders have been shared with you");
                        result.add(String.format("%s %s has shared folders with you", userFullName, agency));
                        result.add("To access the folder click the link below");
                    }

                    result.add(folderName);
                }
                break;
            case FOLDER_SHARING_FOR_EASY_USER:
                result.add("Please register to gain access");
                result.add("Hello,");
                result.add(userFullName + " from " + agency + " has invited you to the " + projectName + " project.");
                result.add("Click HERE to register and access the project");
                result.add("MESSAGE");
                break;
            case PROJECT_TEAM_ADDED:
                result.add(userFullName + " from " + agency + " has been added to the Project Team on project " + projectName);
                result.add("To access the Project click the link below:");
                break;
            case PRESENTATION_SHARING_FOR_USER:
                if ("de".equals(language)) {
                    result.add(String.format("Adbank - Präsentation %s wurde mit Ihnen geteilt", presentationName));
                    result.add(String.format("%s von %s hat eine Präsentation mit Ihnen geteilt", userFullName, agency));
                    result.add("Klicken Sie auf folgenden Link, um die Präsentation zu öffnen");
                } else if ("fr".equals(language)) {
                    result.add(String.format("Adbank - Le showreel %s est partagé avec vous", presentationName));
                    result.add(String.format("%s de %s partage un showreel avec vous", userFullName, agency));
                    result.add("Pour accéder au showreel, merci de cliquer sur le lien ci-dessous");
                } else if (asList("es-es", "es-ar").contains(language)) {
                    result.add(String.format("Se ha compartido la presentación %s contigo", presentationName));
                    result.add(String.format("%s de %s ha compartido una presentación contigo", userFullName, agency));
                    result.add("Para ver la presentación, haz click en el siguiente enlace");
                } else if (asList("en-beam", "en-beam-us").contains(language)) {
                    result.add(String.format("BeamPresentation %s has been shared with you", presentationName));
                    result.add(String.format("%s from %s has shared presentation with you", userFullName, agency));
                    result.add("To access the presentation click the link below");
                } else {
                    result.add(String.format("Presentation %s has been shared with you", presentationName));
                    result.add(String.format("%s has shared presentation %s with you", userFullName, presentationName));
                    result.add("To access the presentation click the link below");
                }

                result.add(message);
                break;
            case PRESENTATION_SHARING_FOR_OTHER_USER:
                result.add(String.format("Presentation %s has been shared with %s by %s", presentationName, userFullName, otherUserFullName));
                result.add(message);
                result.add("To access the presentation click the link below:");
                break;
            case PRESENTATION_FILE_DOWNLOADED:
                result.add("Presentation " + presentationName + " has been downloaded by " + userFullName + " from " + agency);
                result.add("To view the presentation click the link below:");
                break;
            case PRESENTATION_VIEWED:
                result.add("Presentation " + presentationName + " has been viewed by " + userFullName + " from " + agency);
                result.add("To view the presentation click the link below:");
                break;
            case PREVIEW_TRANSCODE_FAILED:
                result.add("We are sorry but Adbank was unable to generate a preview for file " + fileName);
                result.add("Please check that the file meets the minimum spec requirements by clicking the Help Centre link below and then reupload.");
                result.add("Help Centre");
                break;
            case USER_INVITATION:
                result.add("Dear Sir or Madam,");
                result.add(userFullName + " " + agency + " has invited you to join the Adstream Platform");
                result.add("To register and gain access click the link below:");
                break;
            case USER_PASSWORD:
                //result.add("Dear Sir or Madam,");
                result.add("Your Adbank password reset request");
                result.add("You have requested to reset your Adbank password.");
                result.add("Please follow this link:");
                result.add("RESET PASSWORD");
                break;
            case APPROVAL_FEEDBACK_GIVEN:
                result.add(String.format("%s %s %s", userFullName, approvalAction, fileName));
                if (approvalMessage != null && !approvalMessage.isEmpty()) {
                    result.add(String.format("%s %s %s with comment:", userFullName, approvalAction, fileName));
                    result.add(approvalMessage);
                }
                break;
            case APPROVAL_REQUEST:
                if ("de".equals(language)) {
                    result.add(String.format("%s von %s bittet um Freigabe", userEmail, agency));
                    result.add(String.format("%s von %s bittet um Freigabe der Datei – %s aus dem Projekt – %s", userFullName, agency, fileName, projectName));
                    result.add(String.format("Nachricht - %s", approvalMessage));
                    result.add(String.format("Freigabe wurde angefragt am: %s", approvalRequestedDate == null ? "" : approvalRequestedDate));
                    result.add(String.format("Ihre Freigabe wird benötigt bis: %s", approvalRequiredDate == null ? "" : approvalRequiredDate));
                    result.add("Klicken Sie auf folgenden Link, um ihr Feedback zu der Datei abzugeben:");
                    result.add("Hier klicken");
                } else if ("fr".equals(language)) {
                    result.add(String.format("%s de %s a demand&#233; votre approbation", userEmail, agency));
                    result.add(String.format("%s de %s a demandé votre approbation pour le fichier – %s du projet– %s", userFullName, agency, fileName, projectName));
                    result.add(String.format("Message - %s", approvalMessage));
                    result.add(String.format("Votre approbation a été demandée pour : %s", approvalRequestedDate == null ? "" : approvalRequestedDate));
                    result.add(String.format("Votre approbation est requise par : %s", approvalRequiredDate == null ? "" : approvalRequiredDate));
                    result.add("Pour saisir un commentaire sur le fichier, cliquer sur le lien ci-dessous");
                    result.add("Cliquez ici");
                } else if (asList("es-es", "es-ar").contains(language)) {
                    result.add(String.format("%s de %s solicita tu aprobaci&#243;n", userEmail, agency));
                    result.add(String.format("%s de %s solicita tu aprobación del archivo &ldquo;%s&rdquo; dentro del proyecto &ldquo;%s&rdquo;", userFullName, agency, fileName, projectName));
                    result.add(String.format("Mensaje: %s", approvalMessage));
                    result.add(String.format("Solicitud realizada el: %s", approvalRequestedDate == null ? "" : approvalRequestedDate));
                    result.add(String.format("Aprobación requerida antes del: %s", approvalRequiredDate == null ? "" : approvalRequiredDate));
                    result.add("Para añadir tus comentarios al archivo, sigue este enlace:");
                    result.add("Haga click aqu&#237;");
                } else {
                    result.add(String.format("%s from %s has requested your approval on file", userFullName, agency));
                    result.add(String.format("%s from Project", fileName));
                    result.add(String.format("%s", projectName));
                    if(approvalMessage!=null)
                    result.add(String.format("Message text - %s", approvalMessage));
                    result.add(String.format("Your approval was requested on: %s", approvalRequestedDate == null ? "" : approvalRequestedDate));
                    result.add(String.format("Your approval is required by: %s", approvalRequiredDate == null ? "" : approvalRequiredDate));
                    result.add("To enter feedback on the file click the link below:");
                }
                break;
            case APPROVAL_REQUIRED_REMINDER:
                if ("de".equals(language)) {
                    result.add("Freigabe erforderlich - Erinnerung!");
                    result.add(String.format("%s von %s bittet um Freigabe der Datei – %s aus dem Projekt – %s", userFullName, agency, fileName, projectName));
                    result.add(String.format("Nachricht - %s", approvalMessage));
                    result.add(String.format("Die Freigabe wurde angefragt am: %s", approvalRequestedDate == null ? "" : approvalRequestedDate));
                    result.add(String.format("Ihre Freigabe wird benötigt bis: %s", approvalRequiredDate == null ? "" : approvalRequiredDate));
                    result.add("Klicken Sie auf folgenden Link, um ihr Feedback zu der Datei abzugeben:");
                    result.add("Hier klicken");
                } else if ("fr".equals(language)) {
                    result.add("Approbation requise - rappel!");
                    result.add(String.format("%s de %s a demandé votre approbation pour le fichier – %s du projet– %s", userFullName, agency, fileName, projectName));
                    result.add(String.format("Message - %s", approvalMessage));
                    result.add(String.format("Votre approbation a été demandée pour : %s", approvalRequestedDate == null ? "" : approvalRequestedDate));
                    result.add(String.format("Votre approbation est requise par : %s", approvalRequiredDate == null ? "" : approvalRequiredDate));
                    result.add("Pour saisir un commentaire sur le fichier, cliquer sur le lien ci-dessous");
                    result.add("Cliquez ici");
                } else if (asList("es-es", "es-ar").contains(language)) {
                    result.add("Aprobaci&#243;n requerida - Recordatorio");
                    result.add(String.format("%s de %s solicita tu aprobación del archivo &ldquo;%s&rdquo; dentro del proyecto &ldquo;%s&rdquo;", userFullName, agency, fileName, projectName));
                    result.add(String.format("Mensaje: %s", approvalMessage));
                    result.add(String.format("Solicitud realizada el: %s", approvalRequestedDate == null ? "" : approvalRequestedDate));
                    result.add(String.format("Aprobación requerida antes del: %s", approvalRequiredDate == null ? "" : approvalRequiredDate));
                    result.add("Para añadir tus comentarios al archivo, sigue este enlace:");
                    result.add("Haga click aqu&#237;");
                } else {
                    result.add("Approval required - reminder!");
                    result.add(String.format("%s from %s has requested your approval on file - %s from Project - %s", userFullName, agency, fileName, projectName));
                    result.add(String.format("Message text - %s", approvalMessage));
                    result.add(String.format("Your approval was requested on: %s", approvalRequestedDate == null ? "" : approvalRequestedDate));
                    result.add(String.format("Your approval is required by: %s", approvalRequiredDate == null ? "" : approvalRequiredDate));
                    result.add("To enter feedback on the file click the link below:");
                }
                break;
            case APPROVAL_COMPLETED:
                if ("de".equals(language)) {
                    result.add(String.format("Freigabestufe - %s f&#252;r file %s wurde abgeschlossen", approvalStageName, fileName));
                    result.add(String.format("Freigabestufe - %s für file %s wurde", approvalStageName, fileName));
                    result.add("Klicken Sie auf folgenden Link, um die Datei zu öffnen");
                    result.add("Hier klicken");
                } else if ("fr".equals(language)) {
                    result.add(String.format("L'&#233;tape d'approbation - %s pourfile %s est achev&#233;e", approvalStageName, fileName));
                    result.add(String.format("L'étape d'approbation- %s pour file %s est achevée pour ", approvalStageName, fileName));
                    result.add("Pour visualiser le fichier, cliquer sur le lien ci-dessous");
                    result.add("Cliquez ici");
                } else if (asList("es-es", "es-ar").contains(language)) {
                    result.add(String.format("La fase de aprobaci&#243;n - %s para file %s se ha completado", approvalStageName, fileName));
                    result.add(String.format("La fase de aprobación - %s para file %s se ha completado", approvalStageName, fileName));
                    result.add("Para ver el archivo haz click en el siguiente enlace");
                    result.add("Haga click aqu&#237;");
                } else {
                    result.add(String.format("Approval Stage - %s for file %s has completed", approvalStageName, fileName));
                    result.add(String.format("Approval Stage - %s for file %s has completed on", approvalStageName, fileName));
                    result.add("To view the file click the link below");
                }
                break;

            case APPROVED_BY_USER:
                if ("de".equals(language)) {
                    result.add(String.format("%s von %s hat folgende Datei freigegeben: %s - %s", userFullName, agency, approvalStageName, fileName));
                    result.add("Klicken Sie auf folgenden Link, um die Datei zu öffnen:");
                    result.add("Hier klicken");
                } else if ("fr".equals(language)) {
                    result.add(String.format("%s de %s a approuvé %s - %s", userFullName, agency, approvalStageName, fileName));
                    result.add("Pour visualiser le fichier, cliquer sur le lien ci-dessous");
                    result.add("Cliquez ici");
                } else if (asList("es-es", "es-ar").contains(language)) {
                    result.add(String.format("%s de %s ha aprobado %s - %s", userFullName, agency, approvalStageName, fileName));
                    result.add("Para ver el archivo, haz click en el siguiente enlace");
                    result.add("Haga click aqu&#237;");
                } else {
                    result.add(String.format("%s approved %s", userFullName, fileName));
                    result.add("with comment");
                }
                break;
            case MEDIA_TRANSFER_REQUEST:
                if (language.equals("es-ar")) {
                    result.add(String.format("%s %s ha pedido que el siguiente material sea enviado por %s:", userFullName, agency, accountType));
                    // ORD-4972
                    result.add(String.format("%s", deadlineDate));
                    result.add(String.format("%s", clockNumber));
                    result.add(String.format("%s", advertiser));
                    result.add(String.format("%s", product));
                    result.add(String.format("%s", title));
                    result.add(String.format("%s", duration));
                    result.add(String.format("%s", format));
                    result.add(String.format("%s", message));
                    result.add(String.format("Para solicitar un usuario o detalle de las especificaciones técnicas, por favor contactarse con su oficina local de %s.", accountType));
                } else {
                    result.add(String.format("%s from %s has requested the following material to be delivered to %s by %s", userFullName, agency, accountType, deadlineDate));
                    result.add(String.format("%s : %s : %s : %s : %s :: %s", clockNumber, advertiser, product, title, duration, format));
                    //result.add("Additional message:");
                    result.add(String.format("%s", message));
                    result.add(String.format("contact your local %s office", accountType));
                    result.add(String.format("%s", accountType.getContactUrl()));
                    if (accountType.equals(AccountType.ADSTREAM_NORDIC)) {
                        result.add("Destination details: Clock Number Advertiser Advertiser Product Duration First Air Date Upload Date");
                        result.add(String.format("%s %s %s %s %s %s", clockNumber, advertiser, product, duration, firstAirDate, uploadDate));
                        if (destination != null) {  // no destinations in case QC & Ingest only
                            result.add("Destination (s)");
                            for (String dest: destination.split(","))
                                result.add(String.format("%s", dest));
                        }
                        result.add("Thank you & kind regards");
                    }
                }
                break;
            case NVERGE_UPLOAD_REQUEST:
                result.add(String.format("%s %s has requested the following material to be delivered to %s by %s", userFullName, agency, accountType, deadlineDate));
                //result.add(String.format("Message from %s:", userFullName));
                result.add(String.format("%s", message));
                result.add("UPLOAD NOW");
                result.add("OR");
                result.add("ASK SOMEONE ELSE TO UPLOAD");
                result.add("Campaign/Master details");
                result.add(String.format("Clock number %s Advertiser %s Brand %s Sub Brand %s Product %s Title%s Duration%s First air date%s %s", clockNumber, advertiser, brand, subBrand, product, title, duration, firstAirDate, destination));
                //result.add(String.format("For upload credentials and detailed file specifications, please click here to contact your local %s office", accountType));
                break;
            case REMINDER_OF_MEDIA_UPLOAD_REQUEST:
                result.add(String.format("The upload deadline is today, however no files have yet been uploaded As you have been chosen responsible to deliver this copy through %s. Please upload the master file as soon as possible.", accountType));
                result.add("Additional message:");
                result.add(String.format("For upload credentials and detailed file specifications, please click on the following link to contact your local %s office", accountType));
                result.add(String.format("%s", accountType.getContactUrl()));
                result.add("Campaign/Master details");
                result.add(String.format("Clock Number %s", clockNumber));
                result.add("Country Advertiser Product Duration Title First Air Date Upload Date Media Format Type of copy");
                result.add(String.format("%s %s %s %s %s %s %s %s %s", country, advertiser, product, duration, title, firstAirDate, uploadDate, format, typeOfCopy));
                if (destination != null) { // no destinations in case QC & Ingest only
                    result.add("Destination (s)");
                    for (String dest: destination.split(","))
                        result.add(String.format("%s", dest));
                }
                result.add("Thank you & kind regards");
                break;
            case SUBTITLES_REQUIRED:
                result.add(subject);
                result.add(String.format("Dear %s,", subtitlesRequired));
                result.add(String.format("%s from %s has requested the following clock to be booked in for subtitling on %s service level.", userFullName, agency, serviceLevel));
                result.add(String.format("%s %s %s %s %s", clockNumber, advertiser, product, title, message));
                result.add("Kind Regards");
                break;
            case GENERICS_UPLOAD:
                if (accountType.equals(AccountType.BEAM_AMV)) {
                    result.add(String.format("You have just completed a UK version for %s, clock number: %s", agency, clockNumber));
                    result.add("Please arrange for the files below to be sent to");
                    result.add(String.format(accountType.getEmail()));
                } else {
                    result.add(String.format("You have just completed an order for %s, %s as part of Order No : %s", agency, clockNumber, orderReference));
                    result.add(String.format("Please arrange for the generic masters including audio mixes and splits to be sent to %s.", accountType));
                    result.add(String.format("Please contact %s if you require guidelines for the generic masters.", accountType.getEmail()));
                    result.add("The above files are in addition to the broadcast copy required for station transmission.");
                }
                break;
            case ORDER_CONFIRMATION:
                if (accountType.equals(AccountType.BEAM)) {
                    result.add(String.format("TV Delivery Order No. %s", orderReference));
                    result.add(String.format("Order no. %s", orderReference));
                    result.add(String.format("Job no. %s", jobNumber));
                    result.add(String.format("Po no. %s", poNumber));
                    result.add(String.format("No. of commercials %s", orderItemsCount));
                    result.add(String.format("Date order submitted %s", dateOrderSubmitted));
                    result.add(String.format("Commercial %s %s", commercialNumber, clockNumber));
                    result.add(String.format("Country %s", country));
                    result.add(String.format("Spot Code %s", clockNumber));
                    result.add(String.format("%s %s", advertiserDescription, advertiser));
                    result.add(String.format("%s %s", brandDescription, brand));
                    if (subBrand != null) result.add(String.format("%s %s", subBrandDescription, subBrand));
                    result.add(String.format("%s %s", productDescription, product));
                    if (campaign != null) result.add(String.format("%s %s", campaignDescription, campaign));
                    result.add(String.format("Title %s", title));
                    result.add(String.format("Duration %s", duration));
                    result.add(String.format("Format %s", format));
                    result.add(String.format("Delivery method to Beam %s", deliveryMethod));
                    result.add(String.format("Date commercials will arrive at Beam %s", dateArrivedCommercials));
                    result.add(String.format("Time commercials will arrive at Beam %s", timeArrivedCommercials));
                    result.add(String.format("Master held at %s", masterHeldAt));
                    result.add(String.format("First air date %s", firstAirDate));
                    // result.add(String.format("%s ✓ %s", destination, additionalInstruction));
                    result.add(String.format("Archive %s", archive));
                    result.add(String.format("Note %s", message));
                    result.add(String.format("Attachments %s", attachments));
                    if (deliveryPoints != null) result.add(String.format("Delivery Points %s", deliveryPoints));
                    // metadata of United Kingdom, etc markets
                    if (subtitlesRequired != null)
                        result.add(String.format("Subtitles Required %s", subtitlesRequired));
                    // metadata of Switzerland market
                    if (languageMetadata != null) result.add(String.format("Language %s", languageMetadata));
                    if (suisa != null) result.add(String.format("SUISA %s", suisa));
                    result.add(String.format("Deliver to %s Instructions", serviceLevel));
                    result.add(destinationGroup);
                    result.add(String.format("%s ✓ %s", destination, additionalInstruction));
                    if (additionalServiceType != null)
                        result.add(String.format("%s %s %s %s %s (%s) %s", additionalServiceType, additionalServiceDestination, notesAndLabels, additionalServiceFormat, noCopies, mediaCompile, additionalServiceLevel));
                    if (productionServiceType != null)
                        result.add(String.format("%s %s", productionServiceType, productionServiceNote));
                    result.add("2014 Beam. All rights reserved. Beam is a Mill Group company Beam UK, 11-14 Windmill Street, London, W1T 2JG, United Kingdom");
                } else {
                    if (language.equals("es-ar")) {
                        result.add(String.format("Estimado %s", userFullName));
                        result.add(String.format("Informamos que hemos recibido el pedido %s", orderReference));
                        result.add(String.format("Código de trabajo del cliente: %s", jobNumber));
                        result.add(String.format("Orden de compra: %s", poNumber));
                        result.add("Muchas gracias.");
                    } else {
                        result.add(String.format("Dear %s,", userFullName));
                        result.add(String.format("We are pleased to confirm that your order %s has been received.", orderReference));
                        result.add(String.format("Your Job number : %s", jobNumber));
                        result.add(String.format("Your PO number : %s", poNumber));
                        result.add("Kind Regards.");
                    }
                }
                break;
            case TRANSFER_ORDER:
                if (language.equals("es-ar")) {
                    result.add(subject);
                    result.add(String.format("%s %s te ha transferido un pedido %s", userFullName, agency, orderReference));
                    result.add(String.format("Por favor ingresar a %s con tus credenciales para accede a la misma.", accountType));
                    result.add(String.format("%s", message));
                } else {
                    result.add(subject);
                    String txtPart = accountType.equals(AccountType.ADSTREAM) ? "%s %s has transferred draft order %s to you" : "%s from %s has transferred draft order %s to you";  // lite crutch, because different text parts are present depends on an account
                    result.add(String.format(txtPart, userFullName, agency, orderReference));
                    result.add(String.format("Please log in to your %s account to access.", accountType));
                    //result.add("Additional message:");
                    result.add(String.format("%s", message));
                    result.add("Thank you & kind regards");
                }
                break;
            case FAILED_ORDER_CONFIRMATION:
                result.add(String.format("Failed to complete order: %s", orderReference));
                result.add("Failed to complete order.");
                result.add(String.format("Order reference: %s", orderReference));
                result.add(String.format("Agency: %s", agency));
                result.add(String.format("Error message: %s", message));
                result.add(String.format("User: %s", userFullName));
                break;
            case PLEASE_IGNORE_UPLOAD_REQUEST:
                result.add(String.format("Please ignore upload request for clock number: %s", clockNumber));
                result.add(String.format("%s", accountType.getContactUrl()));
                result.add("Thank you & kind regards");
                break;
            case ORDER_DELIVERY_REPORT:
                result.add(String.format("Dear %s,", userFullName));
                result.add(String.format("Please find attached a delivery report of the transfers for Release Dub order %s", orderReference,"."));
                break;
            case ORDER_INGESTION_COMPLETE_REPORT:
                result.add(String.format("Dear %s,", userFullName));
                result.add(String.format("Ingestion Complete. Your ad(s) for Order Number %s have been uploaded to the Adbank.", orderReference));
                result.add(String.format("Your Job number : %s", jobNumber));
                result.add(String.format("Your PO number : %s", poNumber));
                break;
            case ADSTREAM_UPLOAD_REQUEST_FOR:
                result.add(String.format("%s from %s has requested the following material to be delivered to %s by %s", userFullName, agency, accountType, deadlineDate));
                result.add(String.format("This request contains all information and access needed to upload. You can also forward this email to another person you intend to hold responsible for the upload."));
                result.add(String.format("Summary of the material to be supplied:"));
                result.add(String.format("%s %s %s %s %s %s %s", clockNumber, advertiser, product, title, duration,firstAirDate, uploadDate));
                result.add("Additional Message:");
                result.add(String.format("%s", message));
                result.add(String.format("Please upload the file according to our technical specifications. For detailed file specifications, please read the Adstream Technical Specifications."));
                result.add(String.format("Kindly upload the file to our FTP. If you don't have an FTP account with us you can contact us to obtain one."));
                result.add("thank you & kind regards");
                result.add("Adstream Nordic");
                break;

            case TRAFFIC_PREVIEW_FILE_HAS_BEEN_APPROVED:
                result.add(String.format("WITH COMMENT : %s", message));
                result.add(String.format("MASTER DETAILS"));
                result.add(String.format("Clock Number %s", clockNumber));
                result.add(String.format("Advertiser %s", advertiser));
                result.add(String.format("Product %s", product));
                result.add(String.format("Title %s", title));
                result.add(String.format("Duration %s", duration));
                result.add(String.format("DESTINATIONS"));
                result.add(String.format("%s", destination));
                break;
            case TRAFFIC_HAS_BEEN_RELEASED_FOR_DELIVERY:
                result.add(String.format("This commercial has been approved for delivery."));
                result.add(String.format("WITH COMMENT : %s", message));
                result.add(String.format("MASTER DETAILS"));
                result.add(String.format("Clock Number %s", clockNumber));
                result.add(String.format("Advertiser %s", advertiser));
                result.add(String.format("Product %s", product));
                result.add(String.format("Title %s", title));
                result.add(String.format("Duration %s", duration));
                result.add(String.format("DESTINATIONS"));
                result.add(String.format("%s", destination));
                break;
            case TRAFFIC_HAS_BEEN_REJECTED:
                result.add(String.format("WITH COMMENT : %s", message));
                result.add(String.format("MASTER DETAILS"));
                result.add(String.format("Clock Number %s", clockNumber));
                result.add(String.format("Advertiser %s", advertiser));
                result.add(String.format("Product %s", product));
                result.add(String.format("Title %s", title));
                result.add(String.format("Duration %s", duration));
                result.add(String.format("DESTINATIONS"));
                result.add(String.format("%s", destination));
                break;
            case TRAFFIC_MASTER_ESCALATION_HAS_BEEN_SUBMITTED:
                result.add(String.format("A file has been sent to you for approval by %s. Please click on the link below to view the proxy version of the video. Please then give your feedback to %s so that they may approve or reject the video for playout to destination:", userFullName,userFullName));
                result.add(String.format("WITH COMMENT : %s", message));
                result.add(String.format("PREVIEW DETAILS"));
                result.add(String.format("Clock Number %s", clockNumber));
                result.add(String.format("Advertiser %s", advertiser));
                result.add(String.format("Product %s", product));
                result.add(String.format("Title %s", title));
                result.add(String.format("Duration %s", duration));
                result.add(String.format("DESTINATIONS"));
                result.add(String.format("%s", destination));
                break;
            case TRAFFIC_PREVIEW_FILE_HAS_BEEN_REJECTED:
                result.add(String.format("WITH COMMENT : %s", message));
                result.add(String.format("MASTER DETAILS"));
                result.add(String.format("Clock Number %s", clockNumber));
                result.add(String.format("Advertiser %s", advertiser));
                result.add(String.format("Product %s", product));
                result.add(String.format("Title %s", title));
                result.add(String.format("Duration %s", duration));
                result.add(String.format("DESTINATIONS"));
                result.add(String.format("%s", destination));
                break;
            case TRAFFIC_PREVIEW_FILE_HAS_BEEN_RESTORED:
                result.add(String.format("This commercial that was previously rejected has now been restored and is available for approval."));
                result.add(String.format("WITH COMMENT : %s", message));
                result.add(String.format("MASTER DETAILS"));
                result.add(String.format("Clock Number %s", clockNumber));
                result.add(String.format("Advertiser %s", advertiser));
                result.add(String.format("Product %s", product));
                result.add(String.format("Title %s", title));
                result.add(String.format("Duration %s", duration));
                result.add(String.format("DESTINATIONS"));
                result.add(String.format("%s", destination));
                break;
            case TRAFFIC_PREVIEW_FILE_HAS_BEEN_ESCALATED:
                result.add(String.format("A file has been sent to you for approval by %s. Please click on the link below to view the proxy version of the video. Please then give your feedback to %s so that they may approve or reject the video for playout to destination:",userFullName,userFullName));
                result.add(String.format("WITH COMMENT : %s", message));
                result.add(String.format("PREVIEW DETAILS"));
                result.add(String.format("Clock Number %s", clockNumber));
                result.add(String.format("Advertiser %s", advertiser));
                result.add(String.format("Product %s", product));
                result.add(String.format("Title %s", title));
                result.add(String.format("Duration %s", duration));
                result.add(String.format("DESTINATIONS"));
                result.add(String.format("%s", destination));
                break;
            case SENT_TO_ADPRO:
                result.add(String.format("Hello Adpro %s,",market));
                result.add(String.format("%s has sent you %s and would like you to take a look at it.",loggedInUser,clockNumber.concat(".mov")));
                break;
            case FILE_MATCH_ACTIVITY:
                result.add(String.format("Dear %s,",agency));
                result.add(String.format("File %s has been matched to from order . Please click on this link and confirm the uploaded material is correct",fileName));
                break;
        }
        return result;
    }

    public List<String> generateBodyForCostModule() {

        try {
            if (adcostURL == null)
                applicationUrl = TestsContext.getInstance().applicationUrl;
            else
                applicationUrl = new URL(adcostURL);
        } catch (Exception e){
            e.printStackTrace();
        }

        List<String> result = new ArrayList<>();
        switch (emailType) {
            case COST_SUBMITTED:
                result.add(subject);
                result.add(String.format("Dear %s",userFullName));
                result.add("The following cost requires approval, please login in to the Cost module via the link below to review the approval status.");
                result.add(String.format("%s/costs/#/costs/items/review?revisionId=%s&costId=%s",applicationUrl,adcostRevisionId,adcostURLCostId));
                result.add("Cost details:");
                result.add(String.format("Cost Title: %s",adcostCostTitle));
                result.add(String.format("Cost ID: %s",adcostCostID));
                if(adcostContentType!=null)
                    result.add(String.format("Content Type: %s",adcostContentType));
                if(adcostProductionType!=null)
                    result.add(String.format("Production Type: %s",adcostProductionType));
                if(adcostCostType!=null)
                    result.add(String.format("Cost Type: %s",adcostCostType));
                if(adcostUsageBuyoutContractType!=null)
                    result.add(String.format("Usage/Buyout/Contract Type: %s",adcostUsageBuyoutContractType));
                result.add(String.format("Status: %s",adcostStatus));
                result.add(String.format("Agency Producer: %s",adcostAgencyProducer));
                result.add(String.format("Agency Owner: %s",adcostAgencyOwner));
                result.add(String.format("Agency Name: %s",adcostAgencyName));
                result.add(String.format("Agency Location: %s",adcostAgencyLocation));
                result.add(String.format("Agency Tracking #: %s",adcostAgencyTracking));
                result.add(String.format("Project Name: %s",adcostProjectName));
                result.add(String.format("Project ID: %s",adcostProjectID));
                result.add(String.format("Budget Region: %s",adcostBudgetRegion));
                if(adcostTechnicalApprover!=null)
                    result.add(String.format("Technical Approver: %s",adcostTechnicalApprover));
                result.add(String.format("Brand: %s",adcostBrand));
                result.add(String.format("Timestamp: %s",adcostTimestamp));
                break;
            case COST_APPROVERADDED:
                result.add(subject);
                result.add(String.format("Dear %s",userFullName));
                result.add(String.format("The following cost requires your approval, please login in to the Cost module via the link below to begin %s approval.",adcostCostApproverType));
                result.add(String.format("%s/costs/#/costs/items/review?revisionId=%s&costId=%s",applicationUrl,adcostRevisionId,adcostURLCostId));
                result.add("Cost details:");
                result.add(String.format("Cost Title: %s",adcostCostTitle));
                result.add(String.format("Cost ID: %s",adcostCostID));
                if(adcostContentType!=null)
                    result.add(String.format("Content Type: %s",adcostContentType));
                if(adcostProductionType!=null)
                    result.add(String.format("Production Type: %s",adcostProductionType));
                if(adcostCostType!=null)
                    result.add(String.format("Cost Type: %s",adcostCostType));
                if(adcostUsageBuyoutContractType!=null)
                    result.add(String.format("Usage/Buyout/Contract Type: %s",adcostUsageBuyoutContractType));
                result.add(String.format("Status: %s",adcostStatus));
                result.add(String.format("Agency Producer: %s",adcostAgencyProducer));
                result.add(String.format("Agency Owner: %s",adcostAgencyOwner));
                result.add(String.format("Agency Name: %s",adcostAgencyName));
                result.add(String.format("Agency Location: %s",adcostAgencyLocation));
                result.add(String.format("Agency Tracking #: %s",adcostAgencyTracking));
                result.add(String.format("Project Name: %s",adcostProjectName));
                result.add(String.format("Project ID: %s",adcostProjectID));
                result.add(String.format("Budget Region: %s",adcostBudgetRegion));
                if(adcostTechnicalApprover!=null)
                    result.add(String.format("Technical Approver: %s",adcostTechnicalApprover));
                result.add(String.format("Brand: %s",adcostBrand));
                result.add(String.format("Timestamp: %s",adcostTimestamp));
                break;
            case COST_APPROVED_IN_COSTMODULE:
                result.add(subject);
                result.add(String.format("Dear %s",userFullName));
                result.add(String.format("%s has approved the following cost for the %s stage, please login to the Cost module via the link below to review:",adcostCostApprover,adcostStage));
                result.add(String.format("%s/costs/#/costs/items/review?revisionId=%s&costId=%s",applicationUrl,adcostRevisionId,adcostURLCostId));
                result.add("Cost details:");
                result.add(String.format("Cost Title: %s",adcostCostTitle));
                result.add(String.format("Cost ID: %s",adcostCostID));
                if(adcostContentType!=null)
                    result.add(String.format("Content Type: %s",adcostContentType));
                if(adcostProductionType!=null)
                    result.add(String.format("Production Type: %s",adcostProductionType));
                if(adcostCostType!=null)
                    result.add(String.format("Cost Type: %s",adcostCostType));
                if(adcostUsageBuyoutContractType!=null)
                    result.add(String.format("Usage/Buyout/Contract Type: %s",adcostUsageBuyoutContractType));
                result.add(String.format("Status: %s",adcostStatus));
                result.add(String.format("Agency Producer: %s",adcostAgencyProducer));
                result.add(String.format("Agency Owner: %s",adcostAgencyOwner));
                result.add(String.format("Agency Name: %s",adcostAgencyName));
                result.add(String.format("Agency Location: %s",adcostAgencyLocation));
                result.add(String.format("Agency Tracking #: %s",adcostAgencyTracking));
                result.add(String.format("Project Name: %s",adcostProjectName));
                result.add(String.format("Project ID: %s",adcostProjectID));
                result.add(String.format("Budget Region: %s",adcostBudgetRegion));
                if(adcostTechnicalApprover!=null)
                    result.add(String.format("Technical Approver: %s",adcostTechnicalApprover));
                result.add(String.format("Brand: %s",adcostBrand));
                result.add(String.format("Timestamp: %s",adcostTimestamp));
                break;
            case COST_APPROVED_IN_COUPA:
                result.add(subject);
                result.add(String.format("Dear %s",userFullName));
                result.add(String.format("%s has approved the following cost for the %s stage, please login to the Cost module via the link below to review:",adcostCostApprover,adcostStage));
                result.add(String.format("%s/costs/#/costs/items/review?revisionId=%s&costId=%s",applicationUrl,adcostRevisionId,adcostURLCostId));
                result.add("Cost details:");
                result.add(String.format("Cost Title: %s",adcostCostTitle));
                result.add(String.format("Cost ID: %s",adcostCostID));
                if(adcostContentType!=null)
                    result.add(String.format("Content Type: %s",adcostContentType));
                if(adcostProductionType!=null)
                    result.add(String.format("Production Type: %s",adcostProductionType));
                if(adcostCostType!=null)
                    result.add(String.format("Cost Type: %s",adcostCostType));
                if(adcostUsageBuyoutContractType!=null)
                    result.add(String.format("Usage/Buyout/Contract Type: %s",adcostUsageBuyoutContractType));
                result.add(String.format("Status: %s",adcostStatus));
                result.add(String.format("Agency Producer: %s",adcostAgencyProducer));
                result.add(String.format("Agency Owner: %s",adcostAgencyOwner));
                result.add(String.format("Agency Name: %s",adcostAgencyName));
                result.add(String.format("Agency Location: %s",adcostAgencyLocation));
                result.add(String.format("Agency Tracking #: %s",adcostAgencyTracking));
                result.add(String.format("Project Name: %s",adcostProjectName));
                result.add(String.format("Project ID: %s",adcostProjectID));
                result.add(String.format("Budget Region: %s",adcostBudgetRegion));
                if(adcostTechnicalApprover!=null)
                    result.add(String.format("Technical Approver: %s",adcostTechnicalApprover));
                result.add(String.format("Brand: %s",adcostBrand));
                result.add(String.format("Timestamp: %s",adcostTimestamp));
                break;
            case COST_APPROVED:
                result.add(subject);
                result.add(String.format("Dear %s",userFullName));
                result.add(String.format("The %s stage has been approved, please login to the Cost module via the link below to review the cost:",adcostStage));
                if (adcostOEApprovedForFM!=null)
                    result.add("OE stage has been approved please login a assign the IO number to the cost.");
                result.add(String.format("%s/costs/#/costs/items/review?revisionId=%s&costId=%s",applicationUrl,adcostRevisionId,adcostURLCostId));
                result.add("Cost details:");
                result.add(String.format("Cost Title: %s",adcostCostTitle));
                result.add(String.format("Cost ID: %s",adcostCostID));
                if(adcostContentType!=null)
                    result.add(String.format("Content Type: %s",adcostContentType));
                if(adcostProductionType!=null)
                    result.add(String.format("Production Type: %s",adcostProductionType));
                if(adcostCostType!=null)
                    result.add(String.format("Cost Type: %s",adcostCostType));
                if(adcostUsageBuyoutContractType!=null)
                    result.add(String.format("Usage/Buyout/Contract Type: %s",adcostUsageBuyoutContractType));
                result.add(String.format("Status: %s",adcostStatus));
                result.add(String.format("Agency Producer: %s",adcostAgencyProducer));
                result.add(String.format("Agency Owner: %s",adcostAgencyOwner));
                result.add(String.format("Agency Name: %s",adcostAgencyName));
                result.add(String.format("Agency Location: %s",adcostAgencyLocation));
                result.add(String.format("Agency Tracking #: %s",adcostAgencyTracking));
                result.add(String.format("Project Name: %s",adcostProjectName));
                result.add(String.format("Project ID: %s",adcostProjectID));
                result.add(String.format("Budget Region: %s",adcostBudgetRegion));
                if(adcostTechnicalApprover!=null)
                    result.add(String.format("Technical Approver: %s",adcostTechnicalApprover));
                result.add(String.format("Brand: %s",adcostBrand));
                result.add(String.format("Timestamp: %s",adcostTimestamp));
                break;
            case COST_APPROVERADDED_FMUSER:
                result.add(subject);
                result.add(String.format("Dear %s",userFullName));
                result.add(String.format("The following cost requires approval, please login in to the Cost module via the link below to review the approval status.",adcostStage));
                result.add(String.format("%s/costs/#/costs/items/review?revisionId=%s&costId=%s",applicationUrl,adcostRevisionId,adcostURLCostId));
                result.add("Cost details:");
                result.add(String.format("Cost Title: %s",adcostCostTitle));
                result.add(String.format("Cost ID: %s",adcostCostID));
                if(adcostContentType!=null)
                    result.add(String.format("Content Type: %s",adcostContentType));
                if(adcostProductionType!=null)
                    result.add(String.format("Production Type: %s",adcostProductionType));
                if(adcostCostType!=null)
                    result.add(String.format("Cost Type: %s",adcostCostType));
                if(adcostUsageBuyoutContractType!=null)
                    result.add(String.format("Usage/Buyout/Contract Type: %s",adcostUsageBuyoutContractType));
                result.add(String.format("Status: %s",adcostStatus));
                result.add(String.format("Agency Producer: %s",adcostAgencyProducer));
                result.add(String.format("Agency Owner: %s",adcostAgencyOwner));
                result.add(String.format("Agency Name: %s",adcostAgencyName));
                result.add(String.format("Agency Location: %s",adcostAgencyLocation));
                result.add(String.format("Agency Tracking #: %s",adcostAgencyTracking));
                result.add(String.format("Project Name: %s",adcostProjectName));
                result.add(String.format("Project ID: %s",adcostProjectID));
                result.add(String.format("Budget Region: %s",adcostBudgetRegion));
                if(adcostTechnicalApprover!=null)
                    result.add(String.format("Technical Approver: %s",adcostTechnicalApprover));
                result.add(String.format("Brand: %s",adcostBrand));
                result.add(String.format("Timestamp: %s",adcostTimestamp));
                break;
            case COST_PENDING_APPROVAL:
                result.add(String.format("Pending %s for Insurance users",adcostPendingApproval));
                result.add(String.format("Dear %s",userFullName));
                result.add(String.format("Cost %s is pending %s, please login in to the Costs module via the link below to see the status.",adcostCostID,adcostPendingApproval));
                result.add(String.format("%s/costs/#/costs/items/review?revisionId=%s&costId=%s",applicationUrl,adcostRevisionId,adcostURLCostId));
                result.add("Cost details:");
                result.add(String.format("Cost Title: %s",adcostCostTitle));
                result.add(String.format("Cost ID: %s",adcostCostID));
                if(adcostContentType!=null)
                    result.add(String.format("Content Type: %s",adcostContentType));
                if(adcostProductionType!=null)
                    result.add(String.format("Production Type: %s",adcostProductionType));
                if(adcostCostType!=null)
                    result.add(String.format("Cost Type: %s",adcostCostType));
                if(adcostUsageBuyoutContractType!=null)
                    result.add(String.format("Usage/Buyout/Contract Type: %s",adcostUsageBuyoutContractType));
                result.add(String.format("Status: %s",adcostStatus));
                result.add(String.format("Agency Producer: %s",adcostAgencyProducer));
                result.add(String.format("Agency Owner: %s",adcostAgencyOwner));
                result.add(String.format("Agency Name: %s",adcostAgencyName));
                result.add(String.format("Agency Location: %s",adcostAgencyLocation));
                result.add(String.format("Agency Tracking #: %s",adcostAgencyTracking));
                result.add(String.format("Project Name: %s",adcostProjectName));
                result.add(String.format("Project ID: %s",adcostProjectID));
                result.add(String.format("Budget Region: %s",adcostBudgetRegion));
                if(adcostTechnicalApprover!=null)
                    result.add(String.format("Technical Approver: %s",adcostTechnicalApprover));
                result.add(String.format("Brand: %s",adcostBrand));
                result.add(String.format("Timestamp: %s",adcostTimestamp));
                break;
            case COST_RECALLED_COSTOWNERS:
                result.add(subject);
                result.add(String.format("Dear %s",userFullName));
                result.add(String.format("We are informing you that the cost (%s) has been %s from the approval submission by %s to make further edits.",adcostCostID,adcostStatus,adcostCostOwner));
                result.add("Please withdrawn the request for PO from Coupa to complete the action.");
                result.add(String.format("%s/costs/#/costs/items/review?revisionId=%s&costId=%s",applicationUrl,adcostRevisionId,adcostURLCostId));
                result.add("Cost details:");
                result.add(String.format("Cost Title: %s",adcostCostTitle));
                result.add(String.format("Cost ID: %s",adcostCostID));
                if(adcostContentType!=null)
                    result.add(String.format("Content Type: %s",adcostContentType));
                if(adcostProductionType!=null)
                    result.add(String.format("Production Type: %s",adcostProductionType));
                if(adcostCostType!=null)
                    result.add(String.format("Cost Type: %s",adcostCostType));
                if(adcostUsageBuyoutContractType!=null)
                    result.add(String.format("Usage/Buyout/Contract Type: %s",adcostUsageBuyoutContractType));
                result.add(String.format("Status: %s",adcostStatus));
                result.add(String.format("Agency Producer: %s",adcostAgencyProducer));
                result.add(String.format("Agency Owner: %s",adcostAgencyOwner));
                result.add(String.format("Agency Name: %s",adcostAgencyName));
                result.add(String.format("Agency Location: %s",adcostAgencyLocation));
                result.add(String.format("Agency Tracking #: %s",adcostAgencyTracking));
                result.add(String.format("Project Name: %s",adcostProjectName));
                result.add(String.format("Project ID: %s",adcostProjectID));
                result.add(String.format("Budget Region: %s",adcostBudgetRegion));
                if(adcostTechnicalApprover!=null)
                    result.add(String.format("Technical Approver: %s",adcostTechnicalApprover));
                result.add(String.format("Brand: %s",adcostBrand));
                result.add(String.format("Timestamp: %s",adcostTimestamp));
                break;
            case COST_RECALLED_COSTAPPROVERS:
                result.add(subject);
                result.add(String.format("Dear %s",userFullName));
                result.add(String.format("We are informing you that the cost (%s) has been %s from the approval submission by %s to make further edits.",adcostCostID,adcostStatus,adcostCostOwner));
                result.add("Please withdrawn the request for PO from Coupa to complete the action.");
                result.add("Cost details:");
                result.add(String.format("Cost Title: %s",adcostCostTitle));
                result.add(String.format("Cost ID: %s",adcostCostID));
                if(adcostContentType!=null)
                    result.add(String.format("Content Type: %s",adcostContentType));
                if(adcostProductionType!=null)
                    result.add(String.format("Production Type: %s",adcostProductionType));
                if(adcostCostType!=null)
                    result.add(String.format("Cost Type: %s",adcostCostType));
                if(adcostUsageBuyoutContractType!=null)
                    result.add(String.format("Usage/Buyout/Contract Type: %s",adcostUsageBuyoutContractType));
                result.add(String.format("Status: %s",adcostStatus));
                result.add(String.format("Agency Producer: %s",adcostAgencyProducer));
                result.add(String.format("Agency Owner: %s",adcostAgencyOwner));
                result.add(String.format("Agency Name: %s",adcostAgencyName));
                result.add(String.format("Agency Location: %s",adcostAgencyLocation));
                result.add(String.format("Agency Tracking #: %s",adcostAgencyTracking));
                result.add(String.format("Project Name: %s",adcostProjectName));
                result.add(String.format("Project ID: %s",adcostProjectID));
                result.add(String.format("Budget Region: %s",adcostBudgetRegion));
                if(adcostTechnicalApprover!=null)
                    result.add(String.format("Technical Approver: %s",adcostTechnicalApprover));
                result.add(String.format("Brand: %s",adcostBrand));
                result.add(String.format("Timestamp: %s",adcostTimestamp));
                break;
            case COST_REQUEST_CHANGES:
                result.add(subject);
                result.add(String.format("Dear %s",userFullName));
                result.add(String.format("We are informing you that the approval for cost (%s) has been returned, %s would like you make changes to the cost and re-submit.",adcostCostID,adcostCostApprover));
                if(commentText!=null)
                    result.add(commentText);
                result.add("Please login to review the cost.");
                result.add(String.format("%s/costs/#/costs/items/review?revisionId=%s&costId=%s",applicationUrl,adcostRevisionId,adcostURLCostId));
                result.add("Cost details:");
                result.add(String.format("Cost Title: %s",adcostCostTitle));
                result.add(String.format("Cost ID: %s",adcostCostID));
                if(adcostContentType!=null)
                    result.add(String.format("Content Type: %s",adcostContentType));
                if(adcostProductionType!=null)
                    result.add(String.format("Production Type: %s",adcostProductionType));
                if(adcostCostType!=null)
                    result.add(String.format("Cost Type: %s",adcostCostType));
                if(adcostUsageBuyoutContractType!=null)
                    result.add(String.format("Usage/Buyout/Contract Type: %s",adcostUsageBuyoutContractType));
                result.add(String.format("Status: %s",adcostStatus));
                result.add(String.format("Agency Producer: %s",adcostAgencyProducer));
                result.add(String.format("Agency Owner: %s",adcostAgencyOwner));
                result.add(String.format("Agency Name: %s",adcostAgencyName));
                result.add(String.format("Agency Location: %s",adcostAgencyLocation));
                result.add(String.format("Agency Tracking #: %s",adcostAgencyTracking));
                result.add(String.format("Project Name: %s",adcostProjectName));
                result.add(String.format("Project ID: %s",adcostProjectID));
                result.add(String.format("Budget Region: %s",adcostBudgetRegion));
                if(adcostTechnicalApprover!=null)
                    result.add(String.format("Technical Approver: %s",adcostTechnicalApprover));
                result.add(String.format("Brand: %s",adcostBrand));
                result.add(String.format("Timestamp: %s",adcostTimestamp));
                break;
            case COST_REQUEST_CHANGES_FINANCEUSER:
                result.add(subject);
                result.add(String.format("Dear %s",userFullName));
                result.add(String.format("We are informing you that the approval for cost (%s) has been returned, has requested changes to the cost.",adcostCostID));
//                if(commentText!=null)
//                    result.add(commentText);
                result.add("Please login to review the cost.");
                result.add(String.format("%s/costs/#/costs/items/review?revisionId=%s&costId=%s",applicationUrl,adcostRevisionId,adcostURLCostId));
                result.add("Cost details:");
                result.add(String.format("Cost Title: %s",adcostCostTitle));
                result.add(String.format("Cost ID: %s",adcostCostID));
                if(adcostContentType!=null)
                    result.add(String.format("Content Type: %s",adcostContentType));
                if(adcostProductionType!=null)
                    result.add(String.format("Production Type: %s",adcostProductionType));
                if(adcostCostType!=null)
                    result.add(String.format("Cost Type: %s",adcostCostType));
                if(adcostUsageBuyoutContractType!=null)
                    result.add(String.format("Usage/Buyout/Contract Type: %s",adcostUsageBuyoutContractType));
                result.add(String.format("Status: %s",adcostStatus));
                result.add(String.format("Agency Producer: %s",adcostAgencyProducer));
                result.add(String.format("Agency Owner: %s",adcostAgencyOwner));
                result.add(String.format("Agency Name: %s",adcostAgencyName));
                result.add(String.format("Agency Location: %s",adcostAgencyLocation));
                result.add(String.format("Agency Tracking #: %s",adcostAgencyTracking));
                result.add(String.format("Project Name: %s",adcostProjectName));
                result.add(String.format("Project ID: %s",adcostProjectID));
                result.add(String.format("Budget Region: %s",adcostBudgetRegion));
                if(adcostTechnicalApprover!=null)
                    result.add(String.format("Technical Approver: %s",adcostTechnicalApprover));
                result.add(String.format("Brand: %s",adcostBrand));
                result.add(String.format("Timestamp: %s",adcostTimestamp));
                break;
            case COST_REQUEST_CHANGES_INSURANCEUSER:
                result.add(subject);
                result.add(String.format("Dear %s",userFullName));
                result.add(String.format("We are informing you that the approval for cost (%s) has been returned, %s has requested changes to the cost.",adcostCostID,adcostCostApprover));
                if(commentText!=null)
                    result.add(commentText);
                result.add("Please login to review the cost.");
                result.add(String.format("%s/costs/#/costs/items/review?revisionId=%s&costId=%s",applicationUrl,adcostRevisionId,adcostURLCostId));
                result.add("Cost details:");
                result.add(String.format("Cost Title: %s",adcostCostTitle));
                result.add(String.format("Cost ID: %s",adcostCostID));
                if(adcostContentType!=null)
                    result.add(String.format("Content Type: %s",adcostContentType));
                if(adcostProductionType!=null)
                    result.add(String.format("Production Type: %s",adcostProductionType));
                if(adcostCostType!=null)
                    result.add(String.format("Cost Type: %s",adcostCostType));
                if(adcostUsageBuyoutContractType!=null)
                    result.add(String.format("Usage/Buyout/Contract Type: %s",adcostUsageBuyoutContractType));
                result.add(String.format("Status: %s",adcostStatus));
                result.add(String.format("Agency Producer: %s",adcostAgencyProducer));
                result.add(String.format("Agency Owner: %s",adcostAgencyOwner));
                result.add(String.format("Agency Name: %s",adcostAgencyName));
                result.add(String.format("Agency Location: %s",adcostAgencyLocation));
                result.add(String.format("Agency Tracking #: %s",adcostAgencyTracking));
                result.add(String.format("Project Name: %s",adcostProjectName));
                result.add(String.format("Project ID: %s",adcostProjectID));
                result.add(String.format("Budget Region: %s",adcostBudgetRegion));
                if(adcostTechnicalApprover!=null)
                    result.add(String.format("Technical Approver: %s",adcostTechnicalApprover));
                result.add(String.format("Brand: %s",adcostBrand));
                result.add(String.format("Timestamp: %s",adcostTimestamp));
                break;
            case COST_CANCELLED:
                result.add(subject);
                result.add(String.format("Dear %s",userFullName));
                result.add(String.format("Cost (%s) has been cancelled, please login in to the Cost module via the link below to see the status:",adcostCostID));
                result.add(String.format("%s/costs/#/costs/items/review?revisionId=%s&costId=%s",applicationUrl,adcostRevisionId,adcostURLCostId));
                result.add("Cost details:");
                result.add(String.format("Cost Title: %s",adcostCostTitle));
                result.add(String.format("Cost ID: %s",adcostCostID));
                if(adcostContentType!=null)
                    result.add(String.format("Content Type: %s",adcostContentType));
                if(adcostProductionType!=null)
                    result.add(String.format("Production Type: %s",adcostProductionType));
                if(adcostCostType!=null)
                    result.add(String.format("Cost Type: %s",adcostCostType));
                if(adcostUsageBuyoutContractType!=null)
                    result.add(String.format("Usage/Buyout/Contract Type: %s",adcostUsageBuyoutContractType));
                result.add(String.format("Status: %s",adcostStatus));
                result.add(String.format("Agency Producer: %s",adcostAgencyProducer));
                result.add(String.format("Agency Owner: %s",adcostAgencyOwner));
                result.add(String.format("Agency Name: %s",adcostAgencyName));
                result.add(String.format("Agency Location: %s",adcostAgencyLocation));
                result.add(String.format("Agency Tracking #: %s",adcostAgencyTracking));
                result.add(String.format("Project Name: %s",adcostProjectName));
                result.add(String.format("Project ID: %s",adcostProjectID));
                result.add(String.format("Budget Region: %s",adcostBudgetRegion));
                if(adcostTechnicalApprover!=null)
                    result.add(String.format("Technical Approver: %s",adcostTechnicalApprover));
                result.add(String.format("Brand: %s",adcostBrand));
                result.add(String.format("Timestamp: %s",adcostTimestamp));
                break;
            case COST_REOPEN_REQUEST:
                result.add(subject);
                result.add(String.format("Dear %s",userFullName));
                result.add(String.format("As the P&G administrator for the Cost Module there is a request to re-open (%s). Please login to the Cost Module to Reopen the cost.",adcostCostID));
                result.add(String.format("%s/costs/#/costs/items/review?revisionId=%s&costId=%s",applicationUrl,adcostRevisionId,adcostURLCostId));
                result.add("Cost details:");
                result.add(String.format("Cost Title: %s",adcostCostTitle));
                result.add(String.format("Cost ID: %s",adcostCostID));
                if(adcostContentType!=null)
                    result.add(String.format("Content Type: %s",adcostContentType));
                if(adcostProductionType!=null)
                    result.add(String.format("Production Type: %s",adcostProductionType));
                if(adcostCostType!=null)
                    result.add(String.format("Cost Type: %s",adcostCostType));
                if(adcostUsageBuyoutContractType!=null)
                    result.add(String.format("Usage/Buyout/Contract Type: %s",adcostUsageBuyoutContractType));
                result.add(String.format("Status: %s",adcostStatus));
                result.add(String.format("Agency Producer: %s",adcostAgencyProducer));
                result.add(String.format("Agency Owner: %s",adcostAgencyOwner));
                result.add(String.format("Agency Name: %s",adcostAgencyName));
                result.add(String.format("Agency Location: %s",adcostAgencyLocation));
                result.add(String.format("Agency Tracking #: %s",adcostAgencyTracking));
                result.add(String.format("Project Name: %s",adcostProjectName));
                result.add(String.format("Project ID: %s",adcostProjectID));
                result.add(String.format("Budget Region: %s",adcostBudgetRegion));
                if(adcostTechnicalApprover!=null)
                    result.add(String.format("Technical Approver: %s",adcostTechnicalApprover));
                result.add(String.format("Brand: %s",adcostBrand));
                result.add(String.format("Timestamp: %s",adcostTimestamp));
                break;
            case COST_REOPEN_SUCCESS:
                result.add(subject);
                result.add(String.format("Dear %s",userFullName));
                result.add(String.format("As the cost owner for cost (%s) we are informing you that the cost has been re-opened by %s",adcostCostID,adcostPnGadmin));
                result.add(String.format("%s/costs/#/costs/items/review?revisionId=%s&costId=%s",applicationUrl,adcostRevisionId,adcostURLCostId));
                result.add("Cost details:");
                result.add(String.format("Cost Title: %s",adcostCostTitle));
                result.add(String.format("Cost ID: %s",adcostCostID));
                if(adcostContentType!=null)
                    result.add(String.format("Content Type: %s",adcostContentType));
                if(adcostProductionType!=null)
                    result.add(String.format("Production Type: %s",adcostProductionType));
                if(adcostCostType!=null)
                    result.add(String.format("Cost Type: %s",adcostCostType));
                if(adcostUsageBuyoutContractType!=null)
                    result.add(String.format("Usage/Buyout/Contract Type: %s",adcostUsageBuyoutContractType));
                result.add(String.format("Status: %s",adcostStatus));
                result.add(String.format("Agency Producer: %s",adcostAgencyProducer));
                result.add(String.format("Agency Owner: %s",adcostAgencyOwner));
                result.add(String.format("Agency Name: %s",adcostAgencyName));
                result.add(String.format("Agency Location: %s",adcostAgencyLocation));
                result.add(String.format("Agency Tracking #: %s",adcostAgencyTracking));
                result.add(String.format("Project Name: %s",adcostProjectName));
                result.add(String.format("Project ID: %s",adcostProjectID));
                result.add(String.format("Budget Region: %s",adcostBudgetRegion));
                if(adcostTechnicalApprover!=null)
                    result.add(String.format("Technical Approver: %s",adcostTechnicalApprover));
                result.add(String.format("Brand: %s",adcostBrand));
                result.add(String.format("Timestamp: %s",adcostTimestamp));
                break;
            case COST_REOPEN_REJECT:
                result.add(subject);
                result.add(String.format("Dear %s",userFullName));
                result.add(String.format("Your request to re-open cost (%s) has been returned, please discuss with %s.",adcostCostID,adcostPnGadmin));
                result.add(String.format("%s/costs/#/costs/items/review?revisionId=%s&costId=%s",applicationUrl,adcostRevisionId,adcostURLCostId));
                result.add("Cost details:");
                result.add(String.format("Cost Title: %s",adcostCostTitle));
                result.add(String.format("Cost ID: %s",adcostCostID));
                if(adcostContentType!=null)
                    result.add(String.format("Content Type: %s",adcostContentType));
                if(adcostProductionType!=null)
                    result.add(String.format("Production Type: %s",adcostProductionType));
                if(adcostCostType!=null)
                    result.add(String.format("Cost Type: %s",adcostCostType));
                if(adcostUsageBuyoutContractType!=null)
                    result.add(String.format("Usage/Buyout/Contract Type: %s",adcostUsageBuyoutContractType));
                result.add(String.format("Status: %s",adcostStatus));
                result.add(String.format("Agency Producer: %s",adcostAgencyProducer));
                result.add(String.format("Agency Owner: %s",adcostAgencyOwner));
                result.add(String.format("Agency Name: %s",adcostAgencyName));
                result.add(String.format("Agency Location: %s",adcostAgencyLocation));
                result.add(String.format("Agency Tracking #: %s",adcostAgencyTracking));
                result.add(String.format("Project Name: %s",adcostProjectName));
                result.add(String.format("Project ID: %s",adcostProjectID));
                result.add(String.format("Budget Region: %s",adcostBudgetRegion));
                if(adcostTechnicalApprover!=null)
                    result.add(String.format("Technical Approver: %s",adcostTechnicalApprover));
                result.add(String.format("Brand: %s",adcostBrand));
                result.add(String.format("Timestamp: %s",adcostTimestamp));
                break;
            case COST_APPROVAL_REASSIGNED:
                result.add(subject);
                result.add(String.format("Dear %s",userFullName));
                result.add(String.format("%s has removed you as an approver of the following cost.",adcostCostOwner));
                result.add(String.format("%s/costs/#/costs/items/review?revisionId=%s&costId=%s",applicationUrl,adcostRevisionId,adcostURLCostId));
                result.add("Cost details:");
                result.add(String.format("Cost Title: %s",adcostCostTitle));
                result.add(String.format("Cost ID: %s",adcostCostID));
                if(adcostContentType!=null)
                    result.add(String.format("Content Type: %s",adcostContentType));
                if(adcostProductionType!=null)
                    result.add(String.format("Production Type: %s",adcostProductionType));
                if(adcostCostType!=null)
                    result.add(String.format("Cost Type: %s",adcostCostType));
                if(adcostUsageBuyoutContractType!=null)
                    result.add(String.format("Usage/Buyout/Contract Type: %s",adcostUsageBuyoutContractType));
                result.add(String.format("Status: %s",adcostStatus));
                result.add(String.format("Agency Producer: %s",adcostAgencyProducer));
                result.add(String.format("Agency Owner: %s",adcostAgencyOwner));
                result.add(String.format("Agency Name: %s",adcostAgencyName));
                result.add(String.format("Agency Location: %s",adcostAgencyLocation));
                result.add(String.format("Agency Tracking #: %s",adcostAgencyTracking));
                result.add(String.format("Project Name: %s",adcostProjectName));
                result.add(String.format("Project ID: %s",adcostProjectID));
                result.add(String.format("Budget Region: %s",adcostBudgetRegion));
                if(adcostTechnicalApprover!=null)
                    result.add(String.format("Technical Approver: %s",adcostTechnicalApprover));
                result.add(String.format("Brand: %s",adcostBrand));
                result.add(String.format("Timestamp: %s",adcostTimestamp));
                break;
       case COST_OWNER_CHANGED:
        result.add("Cost owner has been changed");
//        result.add(String.format("Sent by on %s",adcostDDMYFTimestamp));
        result.add(String.format("Dear %s",userFullName));
        result.add(String.format("Current cost owner %s was changed by agency admin %s to a new cost owner %s. Please contact now new owner regarding this cost(%s)",adcostOldCostOwner,adcostOldCostOwner,adcostCostOwner,adcostCostID));
        result.add("Cost details:");
        result.add(String.format("Cost Title: %s",adcostCostTitle));
        result.add(String.format("Cost ID: %s",adcostCostID));
        if(adcostContentType!=null)
            result.add(String.format("Content Type: %s",adcostContentType));
        if(adcostProductionType!=null)
            result.add(String.format("Production Type: %s",adcostProductionType));
        if(adcostCostType!=null)
            result.add(String.format("Cost Type: %s",adcostCostType));
        if(adcostUsageBuyoutContractType!=null)
            result.add(String.format("Usage/Buyout/Contract Type: %s",adcostUsageBuyoutContractType));
        result.add(String.format("Status: %s",adcostStatus));
        result.add(String.format("Agency Producer: %s",adcostAgencyProducer));
        result.add(String.format("Agency Owner: %s",adcostAgencyOwner));
        result.add(String.format("Agency Name: %s",adcostAgencyName));
        result.add(String.format("Agency Location: %s",adcostAgencyLocation));
        result.add(String.format("Agency Tracking #: %s",adcostAgencyTracking));
        result.add(String.format("Project Name: %s",adcostProjectName));
        result.add(String.format("Project ID: %s",adcostProjectID));
        result.add(String.format("Budget Region: %s",adcostBudgetRegion));
        if(adcostTechnicalApprover!=null)
            result.add(String.format("Technical Approver: %s",adcostTechnicalApprover));
        result.add(String.format("Brand: %s",adcostBrand));
        result.add(String.format("Timestamp: %s",adcostTimestamp));
        break;
     case COST_TECHNICAL_ISSUE:
         result.add(String.format("There is a technical issue with purchase order for cost %s. Error type &#39;Technical&#39;: %s",adcostCostID,commentText));
         break;
     case COST_TECHNICAL_ISSUE_VENDOR_DETAILS:
         result.add("There is an error with vendor details missing for this cost.");
         result.add("The next step to troubleshoot are:");
         result.add("Check the vendor details of the agency, if it's agency cost");
         result.add("Check the vendor details of the direct payment vendor, if it's a Direct payment vendor cost");
         break;
     case COST_PENDING_REOPEN:
                result.add(subject);
                result.add(String.format("Dear %s",userFullName));
                result.add(String.format("The Final Actual stage is Pending Reopen. Please login to the Cost module via the link below to review the cost:"));
                result.add(String.format("%s/costs/#/costs/items/review?revisionId=%s&costId=%s",applicationUrl,adcostRevisionId,adcostURLCostId));
                result.add("Cost details:");
                result.add(String.format("Cost Title: %s",adcostCostTitle));
                result.add(String.format("Cost ID: %s",adcostCostID));
                if(adcostContentType!=null)
                    result.add(String.format("Content Type: %s",adcostContentType));
                if(adcostProductionType!=null)
                    result.add(String.format("Production Type: %s",adcostProductionType));
                if(adcostCostType!=null)
                    result.add(String.format("Cost Type: %s",adcostCostType));
                if(adcostUsageBuyoutContractType!=null)
                    result.add(String.format("Usage/Buyout/Contract Type: %s",adcostUsageBuyoutContractType));
                result.add(String.format("Status: %s",adcostStatus));
                result.add(String.format("Agency Producer: %s",adcostAgencyProducer));
                result.add(String.format("Agency Owner: %s",adcostAgencyOwner));
                result.add(String.format("Agency Name: %s",adcostAgencyName));
                result.add(String.format("Agency Location: %s",adcostAgencyLocation));
                result.add(String.format("Agency Tracking #: %s",adcostAgencyTracking));
                result.add(String.format("Project Name: %s",adcostProjectName));
                result.add(String.format("Project ID: %s",adcostProjectID));
                result.add(String.format("Budget Region: %s",adcostBudgetRegion));
                if(adcostTechnicalApprover!=null)
                    result.add(String.format("Technical Approver: %s",adcostTechnicalApprover));
                result.add(String.format("Brand: %s",adcostBrand));
                result.add(String.format("Timestamp: %s",adcostTimestamp));
                break;
      }
        return result;
    }

    public List<String> generateLinks() {
        switch (emailType) {
            case PROJECT_OWNER_ADDED:
            case PROJECT_OWNER_REMOVED:
            case PROJECT_TEAM_ADDED:
                listOfLinks.add(applicationUrl + "/adbank#projects/projects/" + projectId + "/overview");
                break;
        }
        return listOfLinks;
    }

    public EmailType getEmailType() {
        if (action.equalsIgnoreCase("Project owner added")) {
            emailType = EmailType.PROJECT_OWNER_ADDED;
        } else if (action.equalsIgnoreCase("Project owner removed")) {
            emailType = EmailType.PROJECT_OWNER_REMOVED;
        } else if (action.equalsIgnoreCase("Comment on file")) {
            emailType = EmailType.COMMENT_WRITTEN;
        } else if (action.equalsIgnoreCase("Comment on secure shared file")) {
            emailType = EmailType.SECURE_COMMENT_WRITTEN;
        } else if (action.equalsIgnoreCase("Download file")) {
            emailType = EmailType.FILE_DOWNLOADED;
        } else if (action.equalsIgnoreCase("File deleted")) {
            emailType = EmailType.FILE_DELETED;
        } else if (action.equalsIgnoreCase("Played file") || action.equalsIgnoreCase("File played")) {
            emailType = EmailType.FILE_PLAYED;
        } else if (action.equalsIgnoreCase("File moved to library")) {
            emailType = EmailType.FILE_MOVED_TO_LIBRARY;
        } else if (action.equalsIgnoreCase("File Uploaded to Projects")) {
            emailType = EmailType.FILE_UPLOADED_TO_PROJECTS;
        } else if (action.equalsIgnoreCase("Asset sharing")) {
            emailType = EmailType.ASSET_SHARING;
        } else if (action.equalsIgnoreCase("File sharing")) {
            emailType = EmailType.FILE_SHARING;
        } else if (action.equalsIgnoreCase("File sharing with user")) {
            emailType = EmailType.FILE_SHARING_WITH_USER;
        } else if (action.equalsIgnoreCase("Asset sharing with user")) {
            emailType = EmailType.ASSET_SHARING_WITH_USER;
        } else if (action.equalsIgnoreCase("Asset sharing with easy user")) {
            emailType = EmailType.ASSET_SHARING_WITH_EASY_USER;
        } else if (action.equalsIgnoreCase("Category sharing")) {
            emailType = EmailType.CATEGORY_SHARING;
        } else if (action.equalsIgnoreCase("Folder sharing for User") || (action.equalsIgnoreCase("Folder sharing for"))) {
            emailType = EmailType.FOLDER_SHARING_FOR_USER;
        } else if (action.equalsIgnoreCase("Folder sharing for Easy User")) {
            emailType = EmailType.FOLDER_SHARING_FOR_EASY_USER;
        } else if (action.equalsIgnoreCase("User added to project team")) {
            emailType = EmailType.PROJECT_TEAM_ADDED;
        } else if (action.equalsIgnoreCase("Shared presentation")) {
            emailType = EmailType.PRESENTATION_SHARING_FOR_USER;
        } else if (action.equalsIgnoreCase("Shared presentation to somebody")) {
            emailType = EmailType.PRESENTATION_SHARING_FOR_OTHER_USER;
        } else if (action.equalsIgnoreCase("Downloaded presentation")) {
            emailType = EmailType.PRESENTATION_FILE_DOWNLOADED;
        } else if (action.equalsIgnoreCase("Viewed presentation")) {
            emailType = EmailType.PRESENTATION_VIEWED;
        } else if (action.equalsIgnoreCase("Transcoding is failed")) {
            emailType = EmailType.PREVIEW_TRANSCODE_FAILED;
        } else if (action.equalsIgnoreCase("Invite user")) {
            emailType = EmailType.USER_INVITATION;
        } else if (action.equalsIgnoreCase("RESET PASSWORD")) {
            emailType = EmailType.USER_PASSWORD;
        } else if (action.equalsIgnoreCase("Approval feedback given")) {
            emailType = EmailType.APPROVAL_FEEDBACK_GIVEN;
        } else if (action.equalsIgnoreCase("Approval request")) {
            emailType = EmailType.APPROVAL_REQUEST;
        } else if (action.equalsIgnoreCase("Approval completed")) {
            emailType = EmailType.APPROVAL_COMPLETED;
        } else if (action.equalsIgnoreCase("Approved by user")) {
            emailType = EmailType.APPROVED_BY_USER;
        } else if (action.equalsIgnoreCase("Approval required reminder")) {
            emailType = EmailType.APPROVAL_REQUIRED_REMINDER;
        } else if (action.equalsIgnoreCase("Media Transfer Request")) {
            emailType = EmailType.MEDIA_TRANSFER_REQUEST;
        } else if (action.equalsIgnoreCase("nVerge Upload Request")) {
            emailType = EmailType.NVERGE_UPLOAD_REQUEST;
        } else if (action.equalsIgnoreCase("Reminder of Media Upload Request")) {
            emailType = EmailType.REMINDER_OF_MEDIA_UPLOAD_REQUEST;
        } else if (action.equalsIgnoreCase("Subtitles Required")) {
            emailType = EmailType.SUBTITLES_REQUIRED;
        } else if (action.equalsIgnoreCase("Generics Upload")) {
            emailType = EmailType.GENERICS_UPLOAD;
        } else if (action.equalsIgnoreCase("Order Confirmation")) {
            emailType = EmailType.ORDER_CONFIRMATION;
        } else if (action.equalsIgnoreCase("Transfer Order")) {
            emailType = EmailType.TRANSFER_ORDER;
        } else if (action.equalsIgnoreCase("Failed Order Confirmation")) {
            emailType = EmailType.FAILED_ORDER_CONFIRMATION;
        }else if  (action.equalsIgnoreCase("Order Delivery Report")) {
            emailType = EmailType.ORDER_DELIVERY_REPORT;
        }else if  (action.equalsIgnoreCase("Order Ingestion Complete Report")) {
            emailType = EmailType.ORDER_INGESTION_COMPLETE_REPORT;
        } else if (action.equalsIgnoreCase("Please ignore upload request")) {
            emailType = EmailType.PLEASE_IGNORE_UPLOAD_REQUEST;
        }else if (action.contains("Adstream Upload Request for")) {
            emailType = EmailType.ADSTREAM_UPLOAD_REQUEST_FOR;
        }else if (action.contains("Preview file for has been approved")) {
            emailType = EmailType.TRAFFIC_PREVIEW_FILE_HAS_BEEN_APPROVED;
        }else if (action.contains("has been released for delivery")) {
            emailType = EmailType.TRAFFIC_HAS_BEEN_RELEASED_FOR_DELIVERY;
        }else if (action.contains("has been rejected")) {
            emailType = EmailType.TRAFFIC_HAS_BEEN_REJECTED;
        }else if (action.contains("Master escalation has been submitted")) {
            emailType = EmailType.TRAFFIC_MASTER_ESCALATION_HAS_BEEN_SUBMITTED;
        }else if (action.contains("Preview file for has been restored")) {
            emailType = EmailType.TRAFFIC_PREVIEW_FILE_HAS_BEEN_RESTORED;
        }else if (action.contains("Preview escalation has been submitted")) {
            emailType = EmailType.TRAFFIC_PREVIEW_FILE_HAS_BEEN_ESCALATED;
        } else if(action.contains("Cost Submitted"))
            emailType = EmailType.COST_SUBMITTED;
        else if(action.contains("Approver Added"))
            emailType = EmailType.COST_APPROVERADDED;
        else if(action.contains("Cost Approved In Cost Module"))
            emailType = EmailType.COST_APPROVED_IN_COSTMODULE;
        else if(action.contains("Cost Approved In Coupa"))
            emailType = EmailType.COST_APPROVED_IN_COUPA;
        else if(action.contains("Cost Approved"))
            emailType = EmailType.COST_APPROVED;
        else if(action.contains("Pending Approval"))
            emailType = EmailType.COST_PENDING_APPROVAL;
        else if(action.contains("Cost Recalled for Cost Owners"))
            emailType = EmailType.COST_RECALLED_COSTOWNERS;
        else if(action.contains("Cost Recalled for Cost Approvers"))
            emailType = EmailType.COST_RECALLED_COSTAPPROVERS;
        else if(action.equalsIgnoreCase("Cost Request Changes"))
            emailType = EmailType.COST_REQUEST_CHANGES;
        else if(action.equalsIgnoreCase("Cost Request Changes for Insurance User"))
            emailType = EmailType.COST_REQUEST_CHANGES_INSURANCEUSER;
        else if(action.equalsIgnoreCase("Cost Cancelled"))
            emailType = EmailType.COST_CANCELLED;
        else if(action.equalsIgnoreCase("Cost Reopen Request"))
            emailType = EmailType.COST_REOPEN_REQUEST;
        else if(action.equalsIgnoreCase("Cost Reopen Success"))
            emailType = EmailType.COST_REOPEN_SUCCESS;
        else if(action.equalsIgnoreCase("Cost Reopen Reject"))
            emailType = EmailType.COST_REOPEN_REJECT;
        else if(action.equalsIgnoreCase("Cost Approval Reassigned"))
            emailType = EmailType.COST_APPROVAL_REASSIGNED;
        else if(action.equalsIgnoreCase("Cost Owner Changed"))
            emailType = EmailType.COST_OWNER_CHANGED;
        else if(action.equals("Technical Issue With Cost"))
            emailType = EmailType.COST_TECHNICAL_ISSUE;
        else if(action.equals("Technical Issue With Cost For Vendor Details"))
            emailType = EmailType.COST_TECHNICAL_ISSUE_VENDOR_DETAILS;
        else if(action.equalsIgnoreCase("Cost Request Changes for Finance User"))
            emailType = EmailType.COST_REQUEST_CHANGES_FINANCEUSER;
        else if(action.contains("Pending Reopen"))
            emailType = EmailType.COST_PENDING_REOPEN;
        else if(action.contains("Approver FM Added"))
            emailType = EmailType.COST_APPROVERADDED_FMUSER;
        else if (action.contains("is now with Adpro"))
            emailType = EmailType.SENT_TO_ADPRO;
        else if(action.contains("has been matched with a file"))
            emailType = EmailType.FILE_MATCH_ACTIVITY;
        return emailType;
    }
}

