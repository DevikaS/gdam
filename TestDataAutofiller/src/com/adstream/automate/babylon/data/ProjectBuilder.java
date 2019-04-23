package com.adstream.automate.babylon.data;

import com.adstream.automate.babylon.JsonObjects.Agency;
import com.adstream.automate.babylon.JsonObjects.Project;
import com.adstream.automate.babylon.JsonObjects.User;
import com.adstream.automate.babylon.TestDataContainer;
import com.adstream.automate.utils.Gen;
import org.joda.time.DateTime;
import org.joda.time.Period;
import org.joda.time.format.DateTimeFormat;
import org.joda.time.format.DateTimeFormatter;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static java.util.Arrays.asList;


public class ProjectBuilder {
    public static final String PROJECT_SUBTYPE = "project";
    public static final String TEMPLATE_SUBTYPE = "project_template";
    public static final String WORK_REQUEST_SUBTYPE = "adkit";
    public static final String WORK_REQUEST_TEMPLATE_SUBTYPE = "adkit_template";
    private static final List<String> KNOWN_SUBTYPES = asList(PROJECT_SUBTYPE, TEMPLATE_SUBTYPE, WORK_REQUEST_SUBTYPE, WORK_REQUEST_TEMPLATE_SUBTYPE);

    private DateTimeFormatter dateTimeFormatter;
    private TestDataContainer dataSet;
    private final Agency agency;
    private String subtype;

    public ProjectBuilder(TestDataContainer dataSet, String datePattern, Agency agency, String subtype) {
        if (!KNOWN_SUBTYPES.contains(subtype)) throw new IllegalArgumentException(String.format("Unknown"));
        this.subtype = subtype;
        this.dataSet = dataSet;
        this.dateTimeFormatter = DateTimeFormat.forPattern(datePattern);
        this.agency = agency;
    }

    private ProjectFieldsHolder getBlankFieldsSet() {
        ProjectFieldsHolder projectFields = new ProjectFieldsHolder();
        projectFields.put(Fields.PROJECT_NAME, "");
        projectFields.put(Fields.JOB_NUMBER, "");
        projectFields.put(Fields.PRODUCT, "");
        projectFields.put(Fields.BRAND, "");
        projectFields.put(Fields.SUB_BRAND, "");
        projectFields.put(Fields.CAMPAIGN, "");
        projectFields.put(Fields.MEDIA_TYPE, "Broadcast");
        projectFields.put(Fields.PUBLISH_DATETIMEZONE, "");
        projectFields.put(Fields.PUBLISH_TIME, "");
        projectFields.put(Fields.END_DATE, "");
        projectFields.put(Fields.START_DATE, "");
        projectFields.put(Fields.PUBLISH_DATE, "");
        projectFields.put(Fields.LOGO, Logo.EMPTY_PROJECT_LOGO.toString());
        projectFields.put(Fields.ADMINISTRATORS, null);
        projectFields.put(Fields.BUSINESS_UNIT, "");
        projectFields.put(Fields.PUBLISH_MESSAGE, "");
        return projectFields;
    }

    private ProjectFieldsHolder getMinFieldsSet(String name) {

        ProjectFieldsHolder projectFields = getBlankFieldsSet();
        projectFields.put(Fields.PROJECT_NAME, name == null || name.isEmpty() ? "##" : name);
        projectFields.put(Fields.BUSINESS_UNIT, "##");
        projectFields.put(Fields.START_DATE, "[Today]");
        projectFields.put(Fields.END_DATE, "[DeepFuture]");
        projectFields.put(Fields.PUBLISHED, "true");
        return projectFields;
    }

    private ProjectFieldsHolder getMaxFieldsSet(String name) {
        ProjectFieldsHolder projectFields = getMinFieldsSet(name);
        projectFields.put(Fields.PRODUCT, "##");
        projectFields.put(Fields.BRAND, "##");
        projectFields.put(Fields.SUB_BRAND, "##");
        projectFields.put(Fields.CAMPAIGN, "##");
        projectFields.put(Fields.JOB_NUMBER, "##");
        return projectFields;
    }

    public Project getProject() {
        return getProject(null, null);
    }

    public Project getProject(String name) {
        return getProject(name, null);
    }

    public Project getProject(String name, String fields) {
        return getProject(name, fields, Logo.EMPTY_PROJECT_LOGO);
    }

    public Project getProject(String name, String fields, Logo logo) {
        ProjectFieldsHolder projectFields = getMinFieldsSet(name);
        if ("AllFilledFields".equalsIgnoreCase(fields)) {
            projectFields = getMaxFieldsSet(name);
        }
        projectFields.put(Fields.LOGO, logo.toString());
        return getProject(projectFields);
    }

    public Project getProject(Map<String, String> fields) {
        ProjectFieldsHolder projectFields = new ProjectFieldsHolder(fields);
        projectFields.put(Fields.PROJECT_NAME, wrapVariableWithTestSession(projectFields.get(Fields.PROJECT_NAME)));
        return getProject(projectFields);
    }

    private Project getProject(ProjectFieldsHolder fields) {
        ProjectFieldsHolder projectFields = getMinFieldsSet(fields.get(Fields.PROJECT_NAME));
        projectFields.putAll(fields);

        Project project = new Project();
        project.setSubtype(subtype);

        if (projectFields.get(Fields.CUSTOMMODULENUMBER) != null) {
            project.setCostModuleNumber(projectFields.get(Fields.CUSTOMMODULENUMBER));
        }
        if (projectFields.get(Fields.PROJECT_NAME).equals("##")) {
            project.setName(Gen.getHumanReadableString(10, true));
        } else {
            project.setName(projectFields.get(Fields.PROJECT_NAME));
        }
        if (projectFields.get(Fields.JOB_NUMBER).equals("##")) {
            project.setJobNumber(Gen.getHumanReadableString(10, true));
        } else {
            project.setJobNumber(projectFields.get(Fields.JOB_NUMBER));
        }
        if (projectFields.get(Fields.ADVERTISER) != null) {
            project.setAdvertiser(projectFields.get(Fields.ADVERTISER));
        }
        if (projectFields.get(Fields.PRODUCT) != null) {
            project.setBrand(projectFields.get(Fields.PRODUCT));
        }
        if (projectFields.get(Fields.BUSINESS_UNIT).equals("##")) {
            project.setAgency(agency); //should be current agency
        } else {
            Agency desiredAgency = dataSet.getAgencyByName(projectFields.get(Fields.BUSINESS_UNIT));
            // if agency is not null then set from enum else set actual name value
            if (desiredAgency != null) {
                project.setAgency(desiredAgency);
            } else {
                Agency agency = new Agency();
                agency.setName(wrapVariableWithTestSession(projectFields.get(Fields.BUSINESS_UNIT)));
                project.setAgency(agency);
            }
        }
        project.setMediaType(projectFields.get(Fields.MEDIA_TYPE));
        project.setDateStart(processStringToDate(projectFields.get(Fields.START_DATE)));
        project.setDateEnd(processStringToDate(projectFields.get(Fields.END_DATE)));

        if ((!projectFields.get(Fields.PUBLISH_DATE).equalsIgnoreCase("Current")) && !projectFields.get(Fields.PUBLISH_DATE).isEmpty() ) {
           DateTime publishDateInput =  processStringToDate(projectFields.get(Fields.PUBLISH_DATE));
            DateTime date = publishDateInput;
            String[] parsePublishDate = date.toString().split("T");
            String getPublishDate = parsePublishDate[0]+projectFields.get(Fields.PUBLISH_TIME);
            project.setPublishDate(getPublishDate);
        }

        if (projectFields.get(Fields.PUBLISH_DATE).equalsIgnoreCase("Current") && !projectFields.get(Fields.PUBLISH_DATE).isEmpty()) {
            DateTime addMinuteToCurrentDate = DateTime.now().plusMinutes(3);
            String[] currentDate = addMinuteToCurrentDate.toString().split("T");
            String currentpublishDate = currentDate[0]+"T"+currentDate[1].substring(0, 5)+":00.000Z";
            project.setPublishDate(currentpublishDate);
        }


        if (!projectFields.get(Fields.PUBLISH_DATETIMEZONE).isEmpty()) {
            project.setPublishDateTimeZone(projectFields.get(Fields.PUBLISH_DATETIMEZONE));
        }

        if (!projectFields.get(Fields.PUBLISH_MESSAGE).isEmpty()) {
            project.setPublishMessage(projectFields.get(Fields.PUBLISH_MESSAGE));
        }
        project.setAdministrators(prepareAdmins(projectFields.get(Fields.ADMINISTRATORS)));

        String realLogo = Logo.valueOf(projectFields.get(Fields.LOGO)).toString();
        String emptyLogo = Logo.EMPTY_PROJECT_LOGO.toString();
        String logoPath = "";
        if(!realLogo.equals(emptyLogo)) {
            logoPath = Logo.valueOf(projectFields.get(Fields.LOGO)).getPath();
        }
        project.setLogo(logoPath);
        project.setPublished(Boolean.parseBoolean(projectFields.get(Fields.PUBLISHED)));

        return project;
    }
    // NGN-16211-QAA: User from multiple BU's should see all Advertiser values in Project Filters code Changes Starts

    public Project getProjectwithAdvertiserHier(Map<String, String> fields) {
        ProjectFieldsHolder projectFields = new ProjectFieldsHolder(fields);
        projectFields.put(Fields.PROJECT_NAME, wrapVariableWithTestSession(projectFields.get(Fields.PROJECT_NAME)));
        return getProjectwithAdvertiserHier(projectFields);
    }
    private Project getProjectwithAdvertiserHier(ProjectFieldsHolder fields) {

        ProjectFieldsHolder projectFields = getMinFieldsSet(fields.get(Fields.PROJECT_NAME));
        projectFields.putAll(fields);

        Project project = new Project();
        project.setSubtype(subtype);

        if (projectFields.get(Fields.PROJECT_NAME).equals("##")) {
            project.setName(Gen.getHumanReadableString(10, true));
        } else {
            project.setName(projectFields.get(Fields.PROJECT_NAME));
        }
        if (projectFields.get(Fields.JOB_NUMBER).equals("##")) {
            project.setJobNumber(Gen.getHumanReadableString(10, true));
        } else {
            project.setJobNumber(projectFields.get(Fields.JOB_NUMBER));
        }
        if (projectFields.get(Fields.ADVERTISER) != null && !projectFields.get(Fields.ADVERTISER).isEmpty()) {
            project.setAdvertiser(projectFields.get(Fields.ADVERTISER));
        }
        if (projectFields.get(Fields.PRODUCT) != null  && !projectFields.get(Fields.PRODUCT).isEmpty()) {
            project.setBrand(projectFields.get(Fields.PRODUCT));
        }
        if (projectFields.get(Fields.JUSTPRODUCT) != null && !projectFields.get(Fields.JUSTPRODUCT).isEmpty()) {
            project.setProduct(projectFields.get(Fields.JUSTPRODUCT));
        }
        if (projectFields.get(Fields.SUB_BRAND) != null && !projectFields.get(Fields.SUB_BRAND).isEmpty()) {
            project.setSubBrand(projectFields.get(Fields.SUB_BRAND));
        }
        if (projectFields.get(Fields.BUSINESS_UNIT).equals("##")) {
            project.setAgency(agency); //should be current agency
        } else {
            Agency desiredAgency = dataSet.getAgencyByName(projectFields.get(Fields.BUSINESS_UNIT));
            // if agency is not null then set from enum else set actual name value
            if (desiredAgency != null) {
                project.setAgency(desiredAgency);
            } else {
                Agency agency = new Agency();
                agency.setName(wrapVariableWithTestSession(projectFields.get(Fields.BUSINESS_UNIT)));
                project.setAgency(agency);
            }
        }

        project.setMediaType(projectFields.get(Fields.MEDIA_TYPE));
        project.setDateStart(processStringToDate(projectFields.get(Fields.START_DATE)));
        project.setDateEnd(processStringToDate(projectFields.get(Fields.END_DATE)));
        project.setAdministrators(prepareAdmins(projectFields.get(Fields.ADMINISTRATORS)));
        String realLogo = Logo.valueOf(projectFields.get(Fields.LOGO)).toString();
        String emptyLogo = Logo.EMPTY_PROJECT_LOGO.toString();
        String logoPath = "";
        if(!realLogo.equals(emptyLogo)) {
            logoPath = Logo.valueOf(projectFields.get(Fields.LOGO)).getPath();
        }
        project.setLogo(logoPath);
        project.setPublished(Boolean.parseBoolean(projectFields.get(Fields.PUBLISHED)));

        return project;
    }
    // NGN-16211-QAA: User from multiple BU's should see all Advertiser values in Project Filters code Changes Ends
    private String[] prepareAdmins(String string) {
        if (string == null || string.isEmpty()) return null;
        else {
            String[] admins = string.split(",");
            for (int i = 0; i < admins.length; i++) {
                if (!admins[i].contains("@")) {
                    admins[i] = wrapUserEmailWithTestSession(admins[i]);
                }
            }
            return admins;
        }
    }

    private DateTime processStringToDate(String dateString) { // TODO MOVE out to data generator
        if (null == dateString || dateString.isEmpty()) {
            return null;

        } else if ("[Today]".equals(dateString)) {
            return new DateTime();
        } else if ("[Tomorrow]".equals(dateString)) {
            return new DateTime().plus(Period.days(1));
        } else if ("[Yesterday]".equals(dateString)) {
            return new DateTime().minus(Period.days(1));
        } else if ("[DeepFuture]".equals(dateString)) {
            return new DateTime().plus(Period.years(1));
        } else {
            return dateTimeFormatter.parseDateTime(dateString);
        }
    }


    public String wrapVariableWithTestSession(String variable) {
        if (variable == null || variable.isEmpty()) return "";
        if (variable.contains(dataSet.getSessionId())) return variable;
        return variable + dataSet.getSessionId();
    }

    public String wrapUserEmailWithTestSession(String userName) {
        User user = dataSet.getUserByType(userName);
        if (user != null) return user.getEmail();
        if (userName.contains("@")) return userName; // todo not sure about this
        return "qatbabylonautotester+" + wrapVariableWithTestSession(userName) + "@gmail.com";
    }

    public class ProjectFieldsHolder {
        private Map<String, String> fields;

        public ProjectFieldsHolder() {
            this(new HashMap<String, String>());
        }

        public ProjectFieldsHolder(Map<String, String> fields) {
            this.fields = fields;
        }

        public ProjectFieldsHolder put(Fields field, String value) {
            fields.put(field.toString(), value);
            return this;
        }

        public String get(Fields field) {
            return fields.get(field.toString());
        }

        public void putAll(ProjectFieldsHolder projectFields) {
            this.fields.putAll(projectFields.getAll());
        }

        public Map<String, String> getAll() {
            return fields;
        }
    }

    enum Fields {
        PROJECT_NAME("Name"),
        JOB_NUMBER("Job Number"),
        ADVERTISER("Advertiser"),
        CUSTOMCODE("Custom Code"),
        CUSTOMMODULENUMBER("CostModuleNumber"),
        PRODUCT("Product/Brand"), //TODO rename to product there and in all stories
        BRAND("Brand"),
        SUB_BRAND("SubBrand"),
        JUSTPRODUCT("Product"),
        CAMPAIGN("Campaign"),
        MEDIA_TYPE("Media Type"),
        PUBLISH_DATETIMEZONE("Publish DateTimeZone"),
        PUBLISH_TIME("Publish Time"),
        START_DATE("Start date"),
        PUBLISH_DATE("Publish Date"),
        END_DATE("End date"),
        LOGO("Logo"),
        ADMINISTRATORS("Administrators"),
        PUBLISHED("Published"),
        PUBLISH_MESSAGE("Publish Message"),
        BUSINESS_UNIT("Business Unit");

        private String field;

        Fields(String field) {
            this.field = field;
        }

        @Override
        public String toString() {
            return field;
        }
    }
}
