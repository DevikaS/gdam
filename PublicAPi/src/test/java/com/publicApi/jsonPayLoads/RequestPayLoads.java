package com.publicApi.jsonPayLoads;

import com.publicApi.jsonPayLoads.GsonClasses.traffic.Traffic;

import javax.json.*;
import java.math.BigDecimal;
import java.util.*;

/**
 * Created by Raja.Gone on 10/07/2016.
 */
public class RequestPayLoads extends ExpectedData{


    JsonBuilderFactory factory;
    JsonObject requestPayload;
    JsonArray js;

    public RequestPayLoads(){
        factory = Json.createBuilderFactory(null);
    }

    //<editor-fold desc="Ordering">
    private String generate_UniqueClock(){
        Random randomGenerator = new Random();
        return Integer.toString(randomGenerator.nextInt(1000000));
    }

    public String createOrderPayLoad(){
        requestPayload = factory.createObjectBuilder()
                .add("meta",factory.createObjectBuilder()
                        .add("tv",factory.createObjectBuilder()
                                .add("market", MARKET)
                                .add("marketCountry", MARKETCOUNTRY)
                                .add("marketId",factory.createArrayBuilder()
                                        .add(MARKETID))))
                .build();

        return requestPayload.toString();
    }

    public String createOrderPayLoad(String market, String marketCountry, String marketId){
        requestPayload = factory.createObjectBuilder()
                .add("meta",factory.createObjectBuilder()
                        .add("tv",factory.createObjectBuilder()
                                .add("market",market)
                                .add("marketCountry",marketCountry)
                                .add("marketId",factory.createArrayBuilder()
                                        .add(marketId))))
                .build();

        return requestPayload.toString();
    }

    public String createItemPayLoad(){
        CLOCKNUMBER=generate_UniqueClock();
        requestPayload = factory.createObjectBuilder()
                .add("meta",factory.createObjectBuilder()
                        .add("tv",factory.createObjectBuilder()
                                .add("market",MARKET)
                                .add("marketCountry",MARKETCOUNTRY)
                                .add("marketId",factory.createArrayBuilder()
                                        .add(MARKETID)))
                        .add("metadata",factory.createObjectBuilder()
                                .add("subtitlesRequired",factory.createArrayBuilder()
                                        .add(SUBTITLESREQUIRED)))
                        .add("common", factory.createObjectBuilder()
                                .add("duration", DURATION)
                                .add("firstAirDate", FIRSTAIRDATE)
                                .add("additionalInformation", ADDITIONALINFORMATION)
                                .add("clockNumber", CLOCKNUMBER)
                                .add("format", FORMAT)
                                .add("campaign", CAMPAIGN)
                                .add("title", TITLE))
                        .add("asset",factory.createObjectBuilder()
                                .add("common",factory.createObjectBuilder()
                                        .add("advertiser", factory.createArrayBuilder()
                                                .add(ADVERTISER))
                                        .add("brand",factory.createArrayBuilder()
                                                .add(BRAND)))))
                .build();

        return requestPayload.toString();
    }

    public String createItemPayLoad(String market, String marketCountry,String marketId){
        CLOCKNUMBER=generate_UniqueClock();
        requestPayload = factory.createObjectBuilder()
                .add("meta",factory.createObjectBuilder()
                        .add("tv",factory.createObjectBuilder()
                                .add("market",MARKET)
                                .add("marketCountry",MARKETCOUNTRY)
                                .add("marketId",factory.createArrayBuilder()
                                        .add(MARKETID)))
                        .add("metadata",factory.createObjectBuilder()
                                .add("motivnummer","test001")
                                .add("GEMA_1474908737200","test0003"))
                        .add("common", factory.createObjectBuilder()
                                .add("duration", DURATION)
                                .add("firstAirDate", FIRSTAIRDATE)
                                .add("additionalInformation", ADDITIONALINFORMATION)
                                .add("clockNumber", CLOCKNUMBER)
                                .add("format", FORMAT)
                                .add("campaign", CAMPAIGN)
                                .add("title", TITLE))
                        .add("asset",factory.createObjectBuilder()
                                .add("common",factory.createObjectBuilder()
                                        .add("advertiser",factory.createArrayBuilder()
                                                .add(ADVERTISER))
                                        .add("brand",factory.createArrayBuilder()
                                                .add(BRAND)))))
                .build();

        return requestPayload.toString();
    }

    public String createItemPayLoad(String market, String marketCountry,String marketId, String duration){
        if(duration.isEmpty())
            return createItemPayLoadWithoutDuration(market,marketCountry,marketId,duration);
        CLOCKNUMBER=generate_UniqueClock();
        requestPayload = factory.createObjectBuilder()
                .add("meta",factory.createObjectBuilder()
                        .add("tv",factory.createObjectBuilder()
                                .add("market",MARKET)
                                .add("marketCountry",MARKETCOUNTRY)
                                .add("marketId",factory.createArrayBuilder()
                                        .add(MARKETID)))
                        .add("common", factory.createObjectBuilder()
                                .add("duration", duration)
                                .add("firstAirDate", FIRSTAIRDATE)
                                .add("additionalInformation", ADDITIONALINFORMATION)
                                .add("clockNumber", CLOCKNUMBER)
                                .add("format", FORMAT)
                                .add("campaign", CAMPAIGN)
                                .add("title", TITLE))
                        .add("asset",factory.createObjectBuilder()
                                .add("common",factory.createObjectBuilder()
                                        .add("advertiser",factory.createArrayBuilder()
                                                .add(ADVERTISER))
                                        .add("product",factory.createArrayBuilder()
                                                .add(PRODUCT))
                                        .add("sub_brand",factory.createArrayBuilder()
                                                .add(SUBBRAND))
                                        .add("brand",factory.createArrayBuilder()
                                                .add(BRAND)))))
                .build();

        return requestPayload.toString();
    }

    public String createItemPayLoadWithoutDuration(String market, String marketCountry,String marketId, String duration){
        CLOCKNUMBER=generate_UniqueClock();
        requestPayload = factory.createObjectBuilder()
                .add("meta",factory.createObjectBuilder()
                        .add("tv",factory.createObjectBuilder()
                                .add("market",MARKET)
                                .add("marketCountry",MARKETCOUNTRY)
                                .add("marketId",factory.createArrayBuilder()
                                        .add(MARKETID)))
                        .add("common", factory.createObjectBuilder()
                                .add("firstAirDate", FIRSTAIRDATE)
                                .add("additionalInformation", ADDITIONALINFORMATION)
                                .add("clockNumber", CLOCKNUMBER)
                                .add("format", FORMAT)
                                .add("campaign", CAMPAIGN)
                                .add("title", TITLE))
                        .add("asset",factory.createObjectBuilder()
                                .add("common",factory.createObjectBuilder()
                                        .add("advertiser",factory.createArrayBuilder()
                                                .add(ADVERTISER))
                                        .add("product",factory.createArrayBuilder()
                                                .add(PRODUCT))
                                        .add("sub_brand",factory.createArrayBuilder()
                                                .add(SUBBRAND))
                                        .add("brand",factory.createArrayBuilder()
                                                .add(BRAND)))))
                .build();

        return requestPayload.toString();
    }
    public String editOrderPayLoad(){
        requestPayload = factory.createObjectBuilder()
                .add("meta",factory.createObjectBuilder()
                        .add("tv",factory.createObjectBuilder()
                                .add("market", MARKET_ForEdit)
                                .add("marketId",factory.createArrayBuilder()
                                        .add(MARKETID_ForEdit))))
                .build();

        return requestPayload.toString();
    }

    public String processDraftorders(String orderItemId,String meta) {

        switch (meta){

            case "All":
                requestPayload = factory.createObjectBuilder()
                        .add("library", factory.createArrayBuilder()
                                        .add(orderItemId)
                        )
                        .add("notificationEmails", factory.createObjectBuilder()
                                        .add("confirmed", factory.createArrayBuilder().add(email1).add(email2))
                                        .add("ingested", factory.createArrayBuilder().add(email1).add(email2))
                                        .add("completed", factory.createArrayBuilder().add(email1).add(email2))
                        )
                        .add("poNumber", poNumber)
                        .add("jobNumber", jobNumber)
                        .add("notifyAboutQc",true)
                        .add("notifyAboutDelivery",true)
                        .add("handleStandardsConversions",false)
                        .build();
                break;

            case "Library":
                requestPayload = factory.createObjectBuilder()
                        .add("library", factory.createArrayBuilder()
                                        .add(orderItemId)
                        )
                        .build();
                break;

            case "Pojobnumber":
                requestPayload = factory.createObjectBuilder()
                        .add("poNumber", poNumber)
                        .add("jobNumber", jobNumber)
                        .build();
                break;

            case "Notifications":
                requestPayload = factory.createObjectBuilder()
                        .add("notificationEmails", factory.createObjectBuilder()
                                        .add("confirmed", factory.createArrayBuilder().add(email1).add(email2))
                                        .add("ingested", factory.createArrayBuilder().add(email1).add(email2))
                                        .add("completed", factory.createArrayBuilder().add(email1).add(email2))
                        )
                        .add("poNumber", poNumber)
                        .add("jobNumber", jobNumber)
                        .add("notifyAboutQc", true)
                        .add("notifyAboutDelivery", true)
                        .add("handleStandardsConversions", false)
                        .build();
                break;

            case "PojonumberwithLibrary":
                requestPayload = factory.createObjectBuilder()
                        .add("library", factory.createArrayBuilder()
                                        .add(orderItemId)
                        )
                        .add("poNumber", poNumber)
                        .build();
                break;

            case "None":
                requestPayload = factory.createObjectBuilder()
                        .build();
                break;
        }
        return requestPayload.toString();
    }

    public String updateItemPayLoad(){
        requestPayload = factory.createObjectBuilder()
                .add("meta",factory.createObjectBuilder()
                        .add("common",factory.createObjectBuilder()
                                .add("additionalInformation",ADDITIONALINFORMATION_EDIT)
                                .add("duration",DURATION_EDIT)
                                .add("firstAirDate",FIRSTAIRDATE_EDIT)
                                .add("format", factory.createArrayBuilder()
                                        .add(FORMAT_EDIT))
                                .add("title",TITLE)))
                .build();

        return requestPayload.toString();
    }

    public String updateItemPayLoad_Clock(String clock){
        requestPayload = factory.createObjectBuilder()
                .add("meta",factory.createObjectBuilder()
                        .add("common",factory.createObjectBuilder()
                                .add("clockNumber",clock)))
                .build();

        return requestPayload.toString();
    }

    public String editItemPayLoad(){
        requestPayload = factory.createObjectBuilder()
                .add("meta",factory.createObjectBuilder()
                        .add("common", factory.createObjectBuilder()
                                .add("additionalInformation", ADDITIONALINFORMATION_EDIT)
                                .add("duration", DURATION_EDIT)
                                .add("firstAirDate", FIRSTAIRDATE_EDIT)
                                .add("format", factory.createArrayBuilder()
                                        .add(FORMAT_EDIT))
                                .add("title", TITLE))
                        .add("metadata",factory.createObjectBuilder()
                                .add("subtitlesRequired",factory.createArrayBuilder()
                                        .add(SUBTITLESREQUIRED_EDIT))))
                .build();

        return requestPayload.toString();
    }

    public String addDestinationItemsPayLoad(){
        requestPayload = factory.createObjectBuilder()
                .add("id", factory.createArrayBuilder()
                        .add(DESTINATION_ID))
                .add("serviceLevel",factory.createObjectBuilder()
                        .add("id",factory.createArrayBuilder()
                                .add(DESTINATION_SERVICELEVEL_ID)))
                .build();

        return requestPayload.toString();
    }

    public String editDestinationItemsPayLoad(){
        requestPayload = factory.createObjectBuilder()
                .add("id", factory.createArrayBuilder()
                        .add(DESTINATION_ID))
                .add("serviceLevel",factory.createObjectBuilder()
                        .add("id",factory.createArrayBuilder()
                                .add(DESTINATION_SERVICELEVEL_ID_EDIT)))
                .build();

        return requestPayload.toString();
    }

    public String removeDestinationItemsPayLoad(){
        requestPayload = factory.createObjectBuilder()
                .add("id",factory.createArrayBuilder()
                        .add(DESTINATION_ID))
                .build();

        return requestPayload.toString();
    }

    public String setOrderApprovalStatusPayLoad(){
        requestPayload=factory.createObjectBuilder()
                .add("status",SET_ORDER_APPROVAL_STATUS)
                .build();
        return requestPayload.toString();
    }
    //</editor-fold>


    //<editor-fold desc="Projects">
    public String updateUsageRightsPayLoad(){
        requestPayload = factory.createObjectBuilder()
                .add("usages",factory.createArrayBuilder()
                        .add(factory.createObjectBuilder()
                                .add("General",factory.createObjectBuilder())
                                .add("expiration",factory.createObjectBuilder()
                                        .add("startDate", Long.parseLong(USAGERIGHTSSTARTDATE))
                                        .add("notifications",factory.createArrayBuilder()
                                                .add(factory.createObjectBuilder()
                                                        .add("id","517a4fc1b41048eb68c3e3a7")
                                                        .add("notify", JsonValue.TRUE)
                                                        .add("daysBefore",BigDecimal.ONE)
                                                        .add("notifyTeam",JsonValue.TRUE))
                                                .add(factory.createObjectBuilder()
                                                        .add("id","517a4fc1b41048eb68c3e3a7")
                                                        .add("notify", JsonValue.TRUE)
                                                        .add("daysBefore",BigDecimal.TEN)
                                                        .add("notifyTeam",JsonValue.FALSE)))
                                        .add("expireType","period"))))
                .build();

        return requestPayload.toString();
    }

    public String createProjectPayLoad(){
        PROJECT_NAME =("ProjectName_").concat(String.valueOf(System.currentTimeMillis()));
        requestPayload = factory.createObjectBuilder()
                .add("meta",factory.createObjectBuilder()
                        .add("common",factory.createObjectBuilder()
                                .add("projectMediaType", factory.createArrayBuilder().add(PROJECT_MEDIATYPE))
                                .add("name", PROJECT_NAME)
                                .add("published", PROJECT_ISPUBLISHED)))
                .build();

        return requestPayload.toString();
    }

    public String createProjectApproval(String revisionId,String shortId,String projectId,String projectName,String folderId){
        PROJECT_APPROVALNAME =("ProjectApproval_").concat(String.valueOf(System.currentTimeMillis()));
        requestPayload = factory.createObjectBuilder()
                .add("name", PROJECT_APPROVALNAME)
                .add("revisionId", revisionId)
                .add("shortId", shortId)
                .add("entityName", ASSETFILENAME)
                .add("entityType", ASSETTYPE)
                .add("projectId", projectId)
                .add("projectName", projectName)
                .add("projectAdvertiser", " ")
                .add("folderId", folderId)
                .build();
        return requestPayload.toString();
    }

    public String projectDeleteApproval(String mediaId,String fileId){
        requestPayload = factory.createObjectBuilder()
                .add("fileId", fileId)
                .add("mediaId", mediaId)
                .build();
        return requestPayload.toString();
    }

    public String projectCreateApprovalStage(boolean withDeadLineDate, String approvalType){
        PROJECT_APPROVALSTAGENAME =("ProjectApprovalStage_").concat(String.valueOf(System.currentTimeMillis()));
        if(withDeadLineDate) {
            requestPayload = factory.createObjectBuilder()
                    .add("name", PROJECT_APPROVALSTAGENAME)
                    .add("approvalType",approvalType)
                    .add("deadline","2021-07-01T11:30:20Z")
                    .add("reminder","2021-06-01T11:30:20Z")
                    .build();
        } else {
            requestPayload = factory.createObjectBuilder()
                    .add("name", PROJECT_APPROVALSTAGENAME)
                    .build();
        }
        return requestPayload.toString();
    }

    public String projectStartApproval(String mediaId,String fileId){
        requestPayload = factory.createObjectBuilder()
                .add("fileId", fileId)
                .add("mediaId", mediaId)
                .build();
        return requestPayload.toString();
    }

    public String projectSubmitApproval(String status){
        requestPayload = factory.createObjectBuilder()
                .add("status", status)
                .build();
        return requestPayload.toString();
    }

    public String projectUpdateApprovalStage(){
        requestPayload = factory.createObjectBuilder()
                .add("name", PROJECT_APPROVALSTAGENAME_AFTERUPDATE)
                .build();
        return requestPayload.toString();
    }


    public String createProjectFilePayLoad(){
        PROJECT_FILENAME =("ProjectFileName_").concat(String.valueOf(System.currentTimeMillis()));
        requestPayload = factory.createObjectBuilder()
                .add("meta",factory.createObjectBuilder()
                        .add("common",factory.createObjectBuilder()
                                .add("name", PROJECT_FILENAME)))
                .build();

        return requestPayload.toString();
    }

    public String updateProjectFilePayLoad(){
        PROJECT_FILENAME_UPDATE =("ProjectFileName_AfterUpdate_").concat(String.valueOf(System.currentTimeMillis()));
        requestPayload = factory.createObjectBuilder()
                .add("meta",factory.createObjectBuilder()
                        .add("common",factory.createObjectBuilder()
                                .add("name", PROJECT_FILENAME_UPDATE)
                                .add("Campaign", CAMPAIGN)
                                .add("advertiser",factory.createArrayBuilder()
                                        .add(ADVERTISER))))
                .build();

        return requestPayload.toString();
    }

    public String editProjectFilePayLoad(boolean isValidName){
        PROJECT_FILENAME_UPDATE =isValidName ? ("ProjectFileName_AfterUpdate_").concat(String.valueOf(System.currentTimeMillis())) : "";
        requestPayload = factory.createObjectBuilder()
                .add("meta",factory.createObjectBuilder()
                        .add("common",factory.createObjectBuilder()
                                .add("name", PROJECT_FILENAME_UPDATE)))
                .build();

        return requestPayload.toString();
    }

    public String updateProjectPayLoad(){
        PROJECT_NAME_UPDATE =("ProjectNameAfterUpdate_").concat(String.valueOf(System.currentTimeMillis()));
        requestPayload = factory.createObjectBuilder()
                .add("meta",factory.createObjectBuilder()
                        .add("common",factory.createObjectBuilder()
                                .add("projectMediaType",factory.createArrayBuilder().add(PROJECT_MEDIATYPE_UPDATE)) // Update mediaType
                                .add("name", PROJECT_NAME_UPDATE))) // Update project name
                .build();

        return requestPayload.toString();
    }

    public String createRelationPayLoad(String parentElement,String childElement) {
        requestPayload=factory.createObjectBuilder()
                .add("relationTypeId", RELATION_TYPE_ID)
                .add("primary", factory.createObjectBuilder()
                        .add("documentId", parentElement)
                        .add("documentType", "element"))
                .add("secondary",factory.createObjectBuilder()
                        .add("documentId", childElement)
                        .add("documentType","element"))
                .build();

        return requestPayload.toString();

    }

    public String assignTeamToProjectPayLoad(){
        requestPayload=factory.createObjectBuilder()
                .add("id",TEAMNAME_ID)
                .build();

        return requestPayload.toString();
    }

    public String createATeam(String teamName , String teamType){
        requestPayload=factory.createObjectBuilder()
                .add("name",teamName)
                .add("type",teamType)
               //Optional field - Team description (Library teams only)
                .add("description",LIBRARYTEAMDESCRIPTION)
                .build();

        return requestPayload.toString();

    }

    public String addUserToTeam(String roleId, String teamType){
        if(teamType.equals("project")) {
            requestPayload = factory.createObjectBuilder()
                    .add("roleId", roleId)
                    .add("teamType", teamType)
                    .build();
        }
        else if(teamType.equals("library")) {
            requestPayload = factory.createObjectBuilder()
                    .add("teamType", teamType)
                    .build();
        }
        return requestPayload.toString();

    }

    public String deleteUserFromATeam(String teamType){
        requestPayload = factory.createObjectBuilder()
                .add("teamType", teamType)
                .build();

        return requestPayload.toString();
    }

    public String deleteATeam(String teamType){
        requestPayload = factory.createObjectBuilder()
                .add("type", teamType)
                .build();

        return requestPayload.toString();
    }

    public String createFolderPayload(String folderId) {
        PROJECT_FOLDER_NAME =("FolderNameAPI_").concat(String.valueOf(System.currentTimeMillis()));
        requestPayload=factory.createObjectBuilder()
                .add("parent", folderId)
                .add("meta",factory.createObjectBuilder()
                        .add("common",factory.createObjectBuilder()
                                .add("name",PROJECT_FOLDER_NAME)))
                .build();

        return requestPayload.toString();
    }

    public String updateFolderPayload() {
        PROJECT_FOLDER_NAME_UPDATE =("FolderNameAPI_AfterUpdate").concat(String.valueOf(System.currentTimeMillis()));
        requestPayload=factory.createObjectBuilder()
                .add("meta",factory.createObjectBuilder()
                        .add("common",factory.createObjectBuilder()
                                .add("name",PROJECT_FOLDER_NAME_UPDATE)))
                .build();

        return requestPayload.toString();
    }

    public String createFilePayload() {
        PROJECT_FOLDER_FIlENAME =("ProjectFileAPI_").concat(String.valueOf(System.currentTimeMillis()));
        requestPayload=factory.createObjectBuilder()
                .add("meta",factory.createObjectBuilder()
                        .add("common",factory.createObjectBuilder()
                                .add("name",PROJECT_FOLDER_FIlENAME)))
                .build();

        return requestPayload.toString();
    }

    public String createRolePayLoad(){
        ProjectRoles pr =ProjectRoles.PublicProjectTemaplteReader;
        PROJECT_ROLE=pr.getProjectRoles();
        requestPayload=factory.createObjectBuilder()
                .add("id",PROJECT_ROLE)
                .add("inheritance", PROJECT_ROLE_INHERITANCE)
                .add("message", "You have been assigned a " + pr.name() + " role")
                .add("noNotification",JsonValue.FALSE)
                .build();

        return requestPayload.toString();
    }

    public String createRolePayLoad(String userId, boolean inheritance){
        ProjectRoles pr =ProjectRoles.ProjectUser;
        PROJECT_ROLE=pr.getProjectRoles();
        requestPayload=factory.createObjectBuilder()
                .add("id",PROJECT_USER_ROLE)
                .add("inheritance", inheritance)
                .add("userId",userId)
                .add("message", "You have been assigned a " + pr.name() + " role")
                .add("noNotification",JsonValue.FALSE)
                .build();

        return requestPayload.toString();
    }

    public String updateRolePayLoad(){
        ProjectRoles pr =ProjectRoles.ProjectObserver;
        PROJECT_ROLE_UPDATE=pr.getProjectRoles();

        requestPayload=factory.createObjectBuilder()
                .add("roles",factory.createArrayBuilder()
                        .add(factory.createObjectBuilder()
                                .add("id",PROJECT_ROLE_UPDATE)
                                .add("inheritance",PROJECT_ROLE_INHERITANCE)
                                .add("message","You have been assigned a "+pr.name()+" role")
                                .add("noNotification",JsonValue.FALSE)))
                .build();

        return requestPayload.toString();
    }

    public String assignTeamToFolderPayLoad(String roleId, boolean inheritance, String expireDate){
        if(inheritance==false && expireDate.isEmpty()){
            requestPayload=factory.createObjectBuilder()
                    .add("roleId",roleId)
                    .build();
        }else {
            requestPayload = factory.createObjectBuilder()
                    .add("roleId", roleId)
                    .add("inheritance", inheritance)
                    .add("expiration", expireDate)
                    .build();
        }
        return requestPayload.toString();

    }

    public String mediaCompletePayLoad(String fileName){
        requestPayload=factory.createObjectBuilder()
                .add("meta", factory.createObjectBuilder()
                        .add("common", factory.createObjectBuilder()
                                .add("name", fileName)))
                .add("subtype","element")
                .build();
        return requestPayload.toString();


    }

    public String publishProjectPayLoad(){
        requestPayload=factory.createObjectBuilder()
                .add("noemail",JsonValue.FALSE)
                .build();

        return requestPayload.toString();
    }

    public String filesRevisionPayLoad(String mediaId){
        requestPayload=factory.createObjectBuilder()
                .add("mediaId",mediaId)
                .build();

        return requestPayload.toString();
    }

    public String submitApprovalsPayLoad(){
        requestPayload=factory.createObjectBuilder()
                .add("status","approved")
                .build();

        return requestPayload.toString();
    }

    public String projectFilesCreateACommentForAFile(String comment,String subjects, String objRevision, String answerTo){
        if(answerTo==null)
        {
            requestPayload=factory.createObjectBuilder()
                    .add("text",comment)
                    .add("subjects",factory.createArrayBuilder()
                            .add(subjects))
                    .add("objRevision",objRevision)
                    .build();
        } else {
            requestPayload=factory.createObjectBuilder()
                    .add("text",comment)
                    .add("subjects",factory.createArrayBuilder()
                            .add(subjects))
                    .add("objRevision",objRevision)
                    .add("answerTo",answerTo)
                    .build();
        }
        return requestPayload.toString();
    }

    //</editor-fold>


    //<editor-fold desc="Libary">
    public String createAssetPayLoad(){
        CREATEASSETNAME = ("TestAssetNameAPI_").concat(String.valueOf(System.currentTimeMillis()));
        requestPayload = factory.createObjectBuilder()
                .add("meta",factory.createObjectBuilder()
                        .add("common",factory.createObjectBuilder()
                                .add("name",CREATEASSETNAME)))
                .build();

        return requestPayload.toString();
    }

    public String uploadAssetPayLoad(){
        requestPayload=factory.createObjectBuilder()
                .add("reference",ASSETPATH)
                .add("filename", ASSETFILENAME)
                .add("size",ASSETSIZE)
                .build();

        return requestPayload.toString();

    }

    public String registerMediaPayLoad(boolean sizeZero){
        int size = sizeZero ? 0 : ASSETSIZE;
        requestPayload=factory.createObjectBuilder()
                .add("reference",ASSETPATH)
                .add("filename", ASSETFILENAME)
                .add("size",size)
                .build();

        return requestPayload.toString();

    }

    //Here the file size should be more than 5MB
    public String s3UploadAssetPayLoad(){
        requestPayload=factory.createObjectBuilder()
                .add("reference",S3ASSETPATH)
                .add("filename", S3ASSETFILENAME)
                .add("size",S3ASSETSIZE)
                .build();

        return requestPayload.toString();

    }



    public String requestNewUploadSegmentPayLoad(String s3StorageId, String fileUploadId){
        if(fileUploadId.equals("")) {
            requestPayload = factory.createObjectBuilder()
                    .add("storageId", s3StorageId)
                    .build();
        }else if(fileUploadId!=""){
            requestPayload = factory.createObjectBuilder()
                    .add("storageId", s3StorageId)
                    .add("uploadId", fileUploadId)
                    .build();
        }
        return requestPayload.toString();
    }

    public String completeS3Upload_PrepareForIngestion(String s3StorageId, String uploadId, String etagValue,int filePartNumber){
       requestPayload=factory.createObjectBuilder()
               .add("storageId",s3StorageId)
               .add("uploadId",uploadId)
               .add("partETags",factory.createArrayBuilder()
                       .add(factory.createObjectBuilder()
                               .add("ETag",etagValue)
                               .add("PartNumber",filePartNumber)))
               .build();

       return requestPayload.toString();

   }
   //Overloading
    public String completeS3Upload_PrepareForIngestion(String s3StorageId, String uploadId, String[] etagValue,int[] filePartNumber){
        requestPayload=factory.createObjectBuilder()
                .add("storageId",s3StorageId)
                .add("uploadId",uploadId)
                .add("partETags",factory.createArrayBuilder()
                        .add(factory.createObjectBuilder()
                                .add("ETag",etagValue[0])
                                .add("PartNumber",filePartNumber[0]))
                        .add(factory.createObjectBuilder()
                        .add("ETag",etagValue[1])
                        .add("PartNumber",filePartNumber[1])))

                             .build();

        return requestPayload.toString();

    }



    public String completeAssetPayLoad(String fileName){
        requestPayload=factory.createObjectBuilder()
                .add("meta",factory.createObjectBuilder()
                        .add("common",factory.createObjectBuilder()
                                .add("name",fileName)))
                .build();

        return requestPayload.toString();
    }

    public String assetCreateAttachmentPayload(String mediaName,String mediaSize,String mediaId){
        requestPayload=factory.createObjectBuilder()
                .add("name", mediaName)
                .add("media",factory.createObjectBuilder()
                        .add("size", mediaSize)
                        .add("id",mediaId))
                .build();

        return requestPayload.toString();
    }

    public String assetEditAttachmentPayLoad(String mediaName,String mediaSize,String mediaId){
        requestPayload=factory.createObjectBuilder()
                .add("name",mediaName)
                .add("description", ASSETDESC)
                .add("media",factory.createObjectBuilder()
                        .add("size", mediaSize)
                        .add("id",mediaId))
                .build();

        return requestPayload.toString();
    }

    public String updateAssetPayLoad(){
        requestPayload = factory.createObjectBuilder()
                .add("meta",factory.createObjectBuilder()
                        .add("common",factory.createObjectBuilder()
                                .add("name",CREATEASSETNAME_UPDATE)))
                .build();

        return requestPayload.toString();
    }

    public String createCollectionPayLoad() {
        COLLECTION_NAME = ("CollectionNameAPI_").concat(String.valueOf(System.currentTimeMillis()));
        requestPayload = factory.createObjectBuilder()
                .add("name", COLLECTION_NAME)
                .add("type", "collection")
                .build();

        return requestPayload.toString();
    }

    public String createChildCollectionPayLoad(){
        requestPayload=factory.createObjectBuilder()
                .add("name", COLLECTION_NAME)
                .add("filter", factory.createArrayBuilder()
                        .add(factory.createObjectBuilder()
                                .add("meta.common.name", "name")) // filter values are hardcoded, so in future if test needs add/remove filters then accordingly change in "Collection_CreateChildCollection.java'
                        .add(factory.createObjectBuilder()
                                .add("meta.common.video.accountDirector", "test")))
                .add("type","collection")
                .build();

        return requestPayload.toString();
    }

    public String shareCollection(){
        requestPayload=factory.createObjectBuilder()
                .add("subjectId", LIBRARY_TEAM_ID)
                .add("roleId", SHARE_COLLECTION_LIBRARYROLENAME)
                .build();

        return requestPayload.toString();
    }

    public String updateCollectionPayLoad(){
        requestPayload=factory.createObjectBuilder()
                .add("name",COLLECTION_NAME)
                .add("filter", factory.createArrayBuilder()
                        .add(factory.createObjectBuilder()
                                .add("meta.common.name", "name")) // filter values are hardcoded, so in future if test needs add/remove filters then accordingly change in "Collection_CreateChildCollection.java'
                        .add(factory.createObjectBuilder()
                                .add("meta.common.video.accountDirector", "test")))
                .add("type","collection")
                .build();

        return requestPayload.toString();
    }

    public String createPresentationPayLoad(){
        PRESENTATION_NAME = ("PresentationNameAPI_").concat(String.valueOf(System.currentTimeMillis()));
        requestPayload = factory.createObjectBuilder()
                .add("meta",factory.createObjectBuilder()
                        .add("common",factory.createObjectBuilder()
                                .add("name",PRESENTATION_NAME)))
                .build();

        return requestPayload.toString();
    }

    public String addPresentationAssets(String assetId){
        requestPayload = factory.createObjectBuilder()
                .add("assets",factory.createArrayBuilder()
                        .add(assetId))
                .build();

        return requestPayload.toString();
    }

    public String orderPresentationAssetsPayLoad(String [] assetIDs){
        requestPayload=factory.createObjectBuilder()
                .add("assets",factory.createArrayBuilder()
                        .add(assetIDs[0])
                        .add(assetIDs[1]))
                .build();

        return  requestPayload.toString();

    }

    public String sharePresentationPayLoad(){
        requestPayload=factory.createObjectBuilder()
                .add("recipients",factory.createArrayBuilder()
                        .add(SHAREPRESENATIONWITH))
                .add("allowDownloadMaster",JsonValue.FALSE)
                .add("allowDownloadProxy",JsonValue.FALSE)
                .add("expiration", "2022-07-31")
                .add("personalMessage","Public API ... share presentation with test@test.com")
                .build();

        return requestPayload.toString();
    }

    public String stopSharingPresentation(){
        requestPayload=factory.createObjectBuilder()
                .add("recipients",factory.createArrayBuilder().add(SHAREPRESENATIONUSERID))
                .build();

        return requestPayload.toString();
    }

    public String addAssetToCollectionPayLoad(String assetId){
        requestPayload=factory.createObjectBuilder()
                .add("id",assetId)
                .build();

        return requestPayload.toString();
    }

    public String assetCreateAPublicShare(String expiration, String recipients,boolean allowDownloadMaster,
                                          boolean allowDownloadProxy,String message){

        JsonObjectBuilder jsonObjBuild = factory.createObjectBuilder();

        if(expiration!=null)
            jsonObjBuild.add("expiration", expiration);
        if(allowDownloadMaster)
            jsonObjBuild.add("allowDownloadMaster", allowDownloadMaster);
        if(allowDownloadProxy)
            jsonObjBuild.add("allowDownloadProxy", allowDownloadProxy);
        if(message!=null && !message.isEmpty())
            jsonObjBuild.add("message", message);

        jsonObjBuild.add("recipients", factory.createArrayBuilder().add(recipients));
        requestPayload=jsonObjBuild.build();

        return requestPayload.toString();
    }

    public String assetUpdateAPublicShare(String expiration, boolean allowDownloadMaster,
                                          boolean allowDownloadProxy,String message){

        JsonObjectBuilder jsonObjBuild = factory.createObjectBuilder();

        if(expiration!=null)
            jsonObjBuild.add("expiration", expiration);
        if(allowDownloadMaster)
            jsonObjBuild.add("allowDownloadMaster", allowDownloadMaster);
        if(allowDownloadProxy)
            jsonObjBuild.add("allowDownloadProxy", allowDownloadProxy);
        if(message!=null && !message.isEmpty())
            jsonObjBuild.add("message", message);

        requestPayload=jsonObjBuild.build();

        return requestPayload.toString();
    }

    //</editor-fold>


    //<editor-fold desc="Dictionary">
    public String deleteDictionaryElementPayLoad(String keyName){
        requestPayload=factory.createObjectBuilder()
                .add("key",keyName)
                .build();

        return requestPayload.toString();
    }

    public String deleteChildDictionaryElementPayLoad(String keyName){

        requestPayload=factory.createObjectBuilder()
                .add("key",DICTIONARY_CHILD_ID_UPDATE)
                .add("path", factory.createArrayBuilder()
                        .add(keyName))
                .build();
        return requestPayload.toString();
    }








    public String updateDictionaryPayLoad() {

        requestPayload=factory.createObjectBuilder()
                .add("key", DICTIONARY_ID_UPDATE)
                .add("additionalParameter", DICTIONARY_ID_ADDITIONALPARAM)
                .add("values", factory.createArrayBuilder()
                        .add(factory.createObjectBuilder()
                                .add("key", DICTIONARY_CHILD_ID_UPDATE)
                                .add("additionalParameter", DICTIONARY_ID_ADDITIONALPARAM)
                                .add("values", factory.createArrayBuilder()
                                )))
                .build();
        return requestPayload.toString();


    }

    //</editor-fold>
    public String addSetHouseNumberFilePayLoad(String houseNumber) {

        requestPayload = factory.createObjectBuilder()
                .add("houseNumber",houseNumber)
                .build();

        return requestPayload.toString();
    }

    //<editor-fold desc="Traffic">
    public String trafficSetApprovalsForOrderItemsPayLoad(String itemId, String destId, String message){
        requestPayload=factory.createObjectBuilder()
                .add("notification",factory.createObjectBuilder()
                        .add("emails",factory.createArrayBuilder()
                                .add("test@email.com"))
                        .add("message",message))
                .add("items",factory.createArrayBuilder()
                        .add(factory.createArrayBuilder()
                                .add(itemId)
                                .add(destId)))
                .build();

        return requestPayload.toString();
    }
    //</editor-fold>

    public String createInternalOrderPayLoad(String trafficMgrID){
        requestPayload = factory.createObjectBuilder()
                .add("meta",factory.createObjectBuilder()
                        .add("tv",factory.createObjectBuilder()
                                .add("market",MARKET)
                                .add("marketCountry",MARKETCOUNTRY)
                                .add("marketId",factory.createArrayBuilder()
                                        .add(MARKETID))))
                .add("trafficTrafficManagerId",trafficMgrID)
                .build();

        return requestPayload.toString();
    }

    public String setAgencyDetailsForIngestion(String ingestLocationId, String ingestName,String agencyId, String storageId){
        requestPayload=factory.createObjectBuilder()
                .add("agency",factory.createObjectBuilder()
                        .add("ingestLocationId",ingestLocationId)
                        .add("name",ingestName)
                        .add("_id",agencyId)
                        .add("storageId",storageId))
                .build();
        return requestPayload.toString();
    }

    public String setOrderDetailsForIngestion(String orderReferenceId, String submittedDate,String serviceLevel){
        requestPayload=factory.createObjectBuilder()
                .add("order",factory.createObjectBuilder()
                        .add("reference",orderReferenceId)
                        .add("submitted",submittedDate)
                        .add("service_level",serviceLevel))
                .build();
        return requestPayload.toString();
    }

    public String updateAssetStatus(String assetStatus){
        requestPayload=factory.createObjectBuilder()
                .add("status",assetStatus)
                .build();

        return requestPayload.toString();
    }

    public String setAssetDetailsForIngestion(String created, String qcAssetId,String fileSize,String fileId){
        requestPayload=factory.createObjectBuilder()
                .add("asset",factory.createObjectBuilder()
                        .add("duration","30")
                        .add("advertiser","Adstream")
                        .add("watermarkingInitialised",JsonValue.FALSE)
                        .add("created",created)
                        .add("unique","982903")
                        .add("closedCaptionStatus", "No")
                        .add("_id",qcAssetId)
                        .add("title", "Public-API_Test_Title")
                        .add("revision",factory.createObjectBuilder()
                                .add("duration",factory.createObjectBuilder()
                                        .add("adDurationInFrames","375")
                                        .add("fullDurationInFrames","500")
                                        .add("firstActiveFrame","25"))
                                .add("audioTracks",factory.createArrayBuilder()
                                        .add(factory.createObjectBuilder()
                                                .add("specId","f1:audio:track:channel:StereoLeft")
                                                .add("langId","en"))
                                        .add(factory.createObjectBuilder()
                                                .add("specId","f1:audio:track:channel:StereoRight")
                                                .add("langId","en")))
                                .add("fileSize",fileSize)
                                .add("name",qcAssetId.concat(".zip"))
                                .add( "specDbDocID","f1:video:master:SD:720x576i@25fps:PAL:16x9:50Mbps")
                                .add("fileID",fileId)
                                .add("MD5","389A2F05C0F15B408BC80BFD4E872B69")))
                .build();
        return requestPayload.toString();
    }

    public String assetsIngest_UpdateIngest(Traffic[] response, String status,String fileSize,String fileId){
        requestPayload=factory.createObjectBuilder()
                .add("status",status)
                .add("agency",factory.createObjectBuilder()
                        .add("ingestLocationId",response[0].getAgency().getIngestLocationId())
                        .add("name",response[0].getAgency().getName())
                        .add("_id",response[0].getAgency().get_id())
                        .add("storageId",response[0].getAgency().getStorageId()))
                .add("order",factory.createObjectBuilder()
                        .add("reference",Integer.parseInt(response[0].getOrder().getReference()))
                        .add("submitted",response[0].getOrder().getSubmitted())
                        .add("service_level",response[0].getOrder().getService_level()))
                .add("asset", factory.createObjectBuilder()
                        .add("duration", Integer.parseInt(response[0].getAsset().getDuration()))
                        .add("advertiser", response[0].getAsset().getAdvertiser())
                        .add("watermarkingInitialised", false)
                        .add("created", response[0].getAsset().getCreated())
                        .add("unique", response[0].getAsset().getUnique())
                        .add("closedCaptionStatus", response[0].getAsset().getClosedCaptionStatus())
                        .add("_id", response[0].getAsset().get_id())
                        .add("title", response[0].getAsset().getTitle())
                        .add("revision", factory.createObjectBuilder()
                                .add("duration", factory.createObjectBuilder()
                                        .add("adDurationInFrames", Integer.parseInt("375"))
                                        .add("fullDurationInFrames", Integer.parseInt("500"))
                                        .add("firstActiveFrame", Integer.parseInt("25")))
                                .add("audioTracks", factory.createArrayBuilder()
                                        .add(factory.createObjectBuilder()
                                                .add("specId", "f1:audio:track:channel:StereoLeft")
                                                .add("langId", "en"))
                                        .add(factory.createObjectBuilder()
                                                .add("specId", "f1:audio:track:channel:StereoRight")
                                                .add("langId", "en")))
                                .add("fileSize", Integer.parseInt(fileSize))
                                .add("name", response[0].getAsset().get_id().concat(".zip"))
                                .add("specDbDocID", "f1:video:master:SD:720x576i@25fps:PAL:16x9:50Mbps")
                                .add("fileID", fileId)
                                .add("MD5", "389A2F05C0F15B408BC80BFD4E872R01")))
                .add("metadata",factory.createObjectBuilder())
                .build();
        return requestPayload.toString();
    }


    public String addDestinationItemsPayLoad(String destinationId, String serviceLevel){
        requestPayload = factory.createObjectBuilder()
                .add("id",factory.createArrayBuilder()
                        .add(destinationId))
                .add("serviceLevel",factory.createObjectBuilder()
                        .add("id", factory.createArrayBuilder()
                                .add(serviceLevel)))
                .build();

        return requestPayload.toString();
    }

    public String addContactPayLoad() {
        requestPayload = factory.createObjectBuilder()
                .add("contacts",factory.createArrayBuilder().
                        add(factory.createObjectBuilder()
                .add("id", ADD_CONTACT_USER_ID)
                .add("email", ADD_CONTACT_EMAIL)
                )).build() ;

        return requestPayload.toString();
    }
}
