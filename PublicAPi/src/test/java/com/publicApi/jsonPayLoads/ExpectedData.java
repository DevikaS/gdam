package com.publicApi.jsonPayLoads;


import java.util.Random;

/**
 * Created by Raja.Gone on 10/07/2016.
 */
public class ExpectedData {

    public static final String PRIMARY_BU_ID = "5571809ee4b0310b4fceae0f"; // BU Name = Test Automation 07
    public static final String SECONDARY_BU_ID = "54c26469e4b075ef647eefe8"; // BU Name = Test Automation 02
    public static final String S3_STORAGE_BU_ID = "5612986ee4b0f8f13c80f2bb"; // TestAutomation08
    public static final String USERID = "557180e6e4b0310b4fceae38";
    public static final String USEREMAIL = "testautomation07_user01@adstream.com";
    public static final String TEAMNAME = "APITestTeam";
    public static final String TEAMNAME_ID = "578c9f0625ae686479c11fa9"; // project team created with project Contributor role
    public static final String PROJECTTEAMTYPE = TeamType.project.toString();
    public static final String LIBRARYTEAMTYPE = TeamType.library.toString();
    public static final String NEWASSIGNTEAM_EXPIRATION= "2030-01-01";
    public static final String LIBRARYTEAMDESCRIPTION = "New library team is created";
    public static final String TEAM_USERID_1 = "586be26225ae68543453c728";
    public static final String TEAM_USERID_2 = "586cf5cbd530374948e13872";
    public static final String PROJECT_LOGO_ENTITY_ID = "578ca0cad530377a0d9a58ce"; // Project Id is given as entityId (Note: Project should have logo in it)
    public static final String RELATION_TYPE_ID = "5571809ee4b0310b4fceae13";
    public static final String LIBRARY_TEAM_NAME = "LibraryTeamAPI";
    public static final String LIBRARY_TEAM_ID = "57961711d530377c4355abb2";
    public static final String BU_STORAGE_ID = "547f5c85e4b0e3c6faf9d32d";
    public static final String INGEST_LOCATION_ID = "557174ffe4b00078a1306a63";
    public static final String INGEST_LOCATION_name = "Ingest Centre London";
    public static final String LIBRARY_ASSET_ID = "578ca71525ae686479c128a1"; // ASSERT SHARED TO 'libraryAssets@getAssetShares.com' WITH DOWNLOAD PROXY AND NEVER EXPIRES
    public static final String PROJECT_FILE_ID = "586cf5b725ae68543454d611"; // FILE SHARED TO 'projectFiles@getFileShares.com' WITH DOWNLOAD PROXY AND NEVER EXPIRES


    public static final String DICTIONARY_ID="advertiser";
    public static final String DICTIONARY_ID_UPDATE="advertiser_AfterUpdate";
    public static final String DICTIONARY_CHILD_ID_UPDATE="advertiser_ChildAfterUpdate";
    public static final String DICTIONARY_ID_ADDITIONALPARAM="advertiser_AdditionalParamater";


    //<editor-fold desc="Ordering">
    public static final String MARKET = "United Kingdom";
    public static final String MARKETCOUNTRY = "gb";
    public static final String MARKETID = "3";
    public static final String ITALY_PUBLICITA_MARKET_ID = "20";
    public static final String GAMARKETID = "2130";
    public static final String SUBTITLESREQUIRED = "None";
    public static String CLOCKNUMBER="TestClock";
    public static final String DURATION = "30";
    public static final String FIRSTAIRDATE = "2024-07-01T00:00:00.000Z";
    public static final String ADDITIONALINFORMATION = "Public-API_Test_AdditionalInformation";
    public static final String FORMAT = "f1:video:master:HD:1920x1080i@25fps:PAL:16x9:MPEG2:TS:I-Frame";
    public static final String CAMPAIGN = "Ad";
    public static final String TITLE = "Public-API_Test_Title";

    public static final String ADVERTISER = "Adstream";
    public static final String BRAND = "Adstream";
    public static final String SUBBRAND = "Adstream";
    public static final String PRODUCT = "Adstream";
    public static final String SET_ORDER_APPROVAL_STATUS = "on_hold";

    public static final String DESTINATION_COUNTRYCODE = "gb";
    public static final String DESTINATION_STATUSID = "51";
    public static final String DESTINATION_ID = "954";
    public static final String DESTINATION_NAME = "AAJ TAK";
    public static final String DESTINATION_SERVICELEVEL_ID = "2";
    public static final String DESTINATION_SERVICELEVEL_NAME = DestinationServiceLevel.Standard.toString(); // Standard: Express: Hot


    public static final String MARKET_ForEdit = "CongoMarket";
    public static final String MARKETID_ForEdit = "559";
    public static final String SUBTITLESREQUIRED_EDIT = "BTI Studios";
    public static final String DURATION_EDIT = "50";
    public static final String FIRSTAIRDATE_EDIT = "2024-11-06T00:00:00.000Z";
    public static final String ADDITIONALINFORMATION_EDIT = "Public-API_Test_AdditionalInformation_AfterEdit";
    public static final String FORMAT_EDIT = "f1:video:master:SD:720x480i@29.97fps:NTC:4x3:50Mbps";
    public static final String CAMPAIGN_EDIT = "Ad_AfterEdit";
    public static final String TITLE_EDIT = "Public-API_Test_Title_AfterEdit";

    public static final String DESTINATION_STATUSID_Edit = "51";
    public static final String DESTINATION_ID_EDIT = "954";
    public static final String DESTINATION_NAME_EDIT = "AAJ TAK";
    public static final String DESTINATION_SERVICELEVEL_ID_EDIT = "3";
    public static final String DESTINATION_SERVICELEVEL_NAME_EDIT = DestinationServiceLevel.Express.toString(); // Standard: Express: Hot
    public static String poNumber = "123445";
    public static String jobNumber = "56789";
    public static boolean notifyAboutQc;
    public static boolean notifyAboutDelivery;
    public static boolean handleStandardsConversions;
    public static String email1 = "sonymusicadmin@adbank.me";
    public static String email2 = "Julia.Guba@adstream.com";
    //</editor-fold>


    //<editor-fold desc="Projects">
    public static final String PROJECT_MEDIATYPE = ProjectMediaType.Digital.toString();
    public static String PROJECT_NAME = "Adstream";
    public static Boolean PROJECT_ISPUBLISHED =false; // false || true
    public static String PROJECT_FILENAME = "Adstream";
    public static String PROJECT_APPROVALNAME = "Adstream";
    public static String PROJECT_APPROVALSTAGENAME = "Adstream";
    public static String PROJECT_STATUS_AFTERAPPROVAL = "Approved";
    public static String PROJECT_STATUS_BEFOREAPPROVAL = "Pending";
    public static final String PROJECT_MEDIATYPE_UPDATE = ProjectMediaType.Broadcast.toString();
    public static String PROJECT_NAME_UPDATE = "Adstream";
    public static Boolean PROJECT_ISPUBLISHED_UPDATE =true; // false || true
    public static String PROJECT_FILENAME_UPDATE = "Adstream";
    public static String PROJECT_APPROVALSTAGENAME_AFTERUPDATE = "approvalstage_AfterUpdate";


    public static String CREATEASSETNAME = "TestAsset";
    public static final String USAGERIGHTSSTARTDATE = "1366934400000"; // Start Date is common for 'OrderItemRights_UpdateUsageRights' & 'UsageRights_UpdateUsageRights'
    public static final String CREATEASSETNAME_UPDATE = "updateassetName";

    public static String PROJECT_FOLDER_NAME="Adstream";
    public static String PROJECT_FOLDER_FIlENAME="Adstream";
    public static String PROJECT_ROLE=ProjectRoles.ProjectContributor.role;
    public static String PROJECT_USER_ROLE=ProjectRoles.ProjectUser.role;
    public static Boolean PROJECT_ROLE_INHERITANCE=true; // true || false


    public static String PROJECT_ROLE_UPDATE=ProjectRoles.ProjectContributor.role;
    public static String PROJECT_FOLDER_NAME_UPDATE="Adstream";
    //</editor-fold>


    //<editor-fold desc="Library">
    public static String COLLECTION_NAME = "Adstream";
    public static String SHARE_COLLECTION_LIBRARYROLENAME = LibraryRoles.LibraryAdmin.role;

    public static String PRESENTATION_NAME="Adstream";
    public static String SHAREPRESENATIONWITH="testautomation06_user01@adstream.com";
    public static String SHAREPRESENATIONUSERID="55717c12e4b0310b4fce9609"; // user id of 'testautomation06_user01@adstream.com' available in 'Test Automation 06' BU

    public static String ASSETPATH = System.getProperty("user.dir")+"//src//test//resources//Fish-Ad.mov";
    public static String ASSETFILENAME = "Fish-Ad.mov";
    public static String ASSETTYPE = "video";
    public static int ASSETSIZE=Integer.parseInt("392669");
    public static String ASSETDESC="admin@apicall.com";
    public static String NEWAssetStatus = AssetStatus.New.assetStatus;
    public static String UploadingFilesStatus = AssetStatus.UploadingFiles.assetStatus;
    public static String Cancelled = AssetStatus.Cancelled.assetStatus;
    public static String TVCIngestedOK =AssetStatus.TVCIngestedOK.assetStatus;

    //</editor-fold>
    public static String S3ASSETPATH = System.getProperty("user.dir")+"//src//test//resources//globular_cluster.mpeg";
    public static String S3ASSETFILENAME = "globular_cluster.mpeg";
    public static int S3ASSETSIZE= 11729844;
    public static String ASSETSEGMENTPATH1 = System.getProperty("user.dir")+"//src//test//resources//globular_cluster.mpeg.001";
    public static String ASSETSEGMENTPATH2 = System.getProperty("user.dir")+"//src//test//resources//globular_cluster.mpeg.002";
    public static int NumberOfSegments = 2;

    public static final String MARKET_COUNTRY_FINLAND = "fi";
    public static final String MARKET_FINLAND = "Finland";
    public static final String MARKET_ID_FINLAND = "11";
    public static final String BEAM_ADMIN_USER = "beam@grey.com";

    //<editor-fold desc="Traffic">
    public static  final String TRAFFIC_TYPE="proxy";
    public static  final String TRAFFIC_OPERATIONS="approve";
    //</editor-fold>

    //Contacts
    public static final String ADD_CONTACT_USER_ID = "578cb0e425ae686479c1326c";
    public static final String ADD_CONTACT_EMAIL = "btm@testapi.com";

    public static String generate_UniqueHN(){
        Random randomGenerator = new Random();
        return "abc-def-"+Integer.toString(randomGenerator.nextInt(1000));
    }

    public enum DestinationServiceLevel {
        Standard("Standard"),
        Express("Express"),
        Hot("Hot");

        private String sLevel;

        private DestinationServiceLevel(String sLevel) {
            this.sLevel = sLevel;
        }

        public String getSLevel() {
            return this.sLevel;
        }
    }

    public enum LibraryRoles{
        LibraryAdmin("512cef304caf8dda81c0fc8d"),
        LibraryUser("512cef324caf8dda81c0fc8f"),
        LibraryViewer("54edb62e7db1980ecca1f8af");

        private String role;

        private LibraryRoles(String role){
            this.role=role;
        }

        private String getLibraryRole(){
            return this.role;
        }

    }

    public enum ProjectRoles {
        Approver("5059aa1ffbc55596d01a3da4"),
        FolderOrElementOwner("55df1dc048f558b74ab79eb4"),
        ProjectAdmin("4f719aed0f915e82984dc84e"),
        ProjectContributor("509a93c29e02c7ba9d977f25"),
        ProjectObserver("509a93c29e02c7ba9d977f28"),
        ProjectUser("506f0ff7e4b088f04d9d794a"),
        PublicProjectTemaplteReader("538591d7f7a47fe17a66d8a9");

        private String role;

        private ProjectRoles(String role) {
            this.role = role;
        }

        public String getProjectRoles() {
            return this.role;
        }

        public String getProjectRoleName(String roleName) {
            String name = null;
            switch (roleName) {
                case "5059aa1ffbc55596d01a3da4":
                    name = "Approver";
                    break;
                case "55df1dc048f558b74ab79eb4":
                    name = "folder.or.element.owner";
                    break;
                case "4f719aed0f915e82984dc84e":
                    name = "project.admin";
                    break;
                case "509a93c29e02c7ba9d977f25":
                    name = "Project Contributor";
                    break;
                case "509a93c29e02c7ba9d977f28":
                    name = "Project Observer";
                    break;
                case "506f0ff7e4b088f04d9d794a":
                    name = "Project  User";
                    break;
                case "538591d7f7a47fe17a66d8a9":
                    name = "public_project_template.reader";
                    break;
            }
            return name;
        }
    }


    public enum ProjectMediaType{
        Broadcast("Broadcast"),
        CrossMedia("Cross Media"),
        Digital("Digital"),
        Other("Other"),
        Print("Print");

        private String mediaType;

        private ProjectMediaType(String mediaType){
            this.mediaType=mediaType;
        }

        private String getProjectMediaType(){
            return this.mediaType;
        }
    }

    public enum TeamType{
        project("project"),
        library("library");

        private String teamType;

        private TeamType(String teamType){
            this.teamType=teamType;
        }

    }

    public enum AssetStatus {
        New("New"),
        AwaitingMasterTape("Awaiting Master Tape"),
        TapeReceivedWaitingIngestion("Tape Received - Awaiting Ingestion"),
        ClapperDoesNotMatchOrder("Clapper Does Not Match Order"),
        TapeFailedQA("Tape Failed QA"),
        FileFailedQA("File Failed QA"),
        TransferringFromIngestion("Transferring From Ingestion"),
        AwaitingCaptioning("Awaiting Captioning"),
        UploadingFiles("Uploading Files"),
        TVCIngestedOK("TVC Ingested OK"),
        Cancelled("Cancelled"),
        TVCuploaded("TVC uploaded");

        private String assetStatus;

        private AssetStatus(String s) {
            assetStatus = s;
        }

     }
}
