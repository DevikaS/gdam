package com.adstream.automate.babylon.data;

import com.adstream.automate.babylon.BabylonServiceWrapper;
import com.adstream.automate.babylon.JsonObjects.Agency;
import com.adstream.automate.babylon.JsonObjects.ApplicationAccess;
import com.adstream.automate.babylon.JsonObjects.Role;
import com.adstream.automate.babylon.JsonObjects.User;
import com.adstream.automate.babylon.TestDataContainer;
import com.adstream.automate.utils.Gen;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * User: ruslan.semerenko
 * Date: 25.04.12 11:29
 */
public class UserBuilder {
    private TestDataContainer dataSet;
    private final Agency agency;
    private BabylonServiceWrapper service;
    private String defaultPassword;
    private boolean isOrdering;

    public UserBuilder(TestDataContainer dataSet,
                       Agency agency,
                       String defaultPassword,
                       BabylonServiceWrapper coreService,
                       boolean isOrdering) {
        this.dataSet = dataSet;
        this.agency = agency;
        this.defaultPassword = defaultPassword;
        this.service = coreService;
        this.isOrdering = isOrdering;
    }

    private Map<String, String> getBlankFieldsSet() {
        Map<String, String> fields = new HashMap<>();
        fields.put("FirstName", "");
        fields.put("LastName", "");
        fields.put("Agency", "##");
        fields.put("Email", "");
        fields.put("Telephone", "");
        fields.put("Password", "");
        fields.put("Notifications", "all");
        fields.put("Logo", "EMPTY");     //todo remove double use of logo field
        fields.put("Access", "");
        fields.put("Role", "");
        fields.put("Language", "en-us");
        return fields;
    }

    private Map<String, String> getMinFieldsSet(String logo, String email) {
        Map<String, String> fields = getBlankFieldsSet();
        fields.put("FirstName", Gen.getHumanReadableString(6, true));
        fields.put("LastName", Gen.getHumanReadableString(6, true));
        if (email == null || email.isEmpty()) {
            fields.put("Email", (fields.get("FirstName") + "." + fields.get("LastName")).toLowerCase() + "@test.com");
        } else
            fields.put("Email", email);
        fields.put("Password", "##");
        fields.put("Role", "agency.admin");
        fields.put("PasswordNeverExpires", "false");
        fields.put("Access", "streamlined_library,library,folders,adkits,approvals,presentations,dashboard" + (isOrdering ? ",ordering" : ""));
        fields.put("Logo", logo == null || logo.isEmpty() ? "EMPTY" : logo);
        return fields;
    }

    private Map<String, String> getMaxFieldsSet(String logo, String emailPrefix) {
        Map<String, String> fields = getMinFieldsSet(logo, emailPrefix);
        fields.put("Telephone", String.valueOf(Gen.getInt(1000000000)));
        fields.put("Access", "library,folders,adkits,approvals,presentations,dashboard" + (isOrdering ? ",ordering" : ""));
        fields.put("MobileNumber", String.valueOf(Gen.getInt(1000000000)));
        fields.put("SkypeNumber", String.valueOf(Gen.getInt(1000000000)));
        fields.put("GoogleTalkContact", String.valueOf(Gen.getInt(1000000000)));
        return fields;
    }

    public User getUser(String fields, String logo, String email) {
        Map<String, String> fieldsSet = getMinFieldsSet(logo, email);
        if ("AllFilledFieldsWithIncorrectTelephoneFormat".equalsIgnoreCase(fields)) {
            fieldsSet = getMaxFieldsSet(logo, email);
            fieldsSet.put("Telephone", "wrongTelephone");
        } else if ("AllFilledFieldsWithIncorrectPrimaryEmailAddressFormat".equals(fields)) {
            fieldsSet = getMaxFieldsSet(logo, email);
            fieldsSet.put("Email", "wrongEmail");
        } else if ("AllFilledFields".equalsIgnoreCase(fields)) {
            fieldsSet = getMaxFieldsSet(logo, email);
        } else if ("MandatoryFieldsAnotherAgency".equalsIgnoreCase(fields)) {
            fieldsSet.put("Agency", "AnotherAgency");
        }  else if ("AllFilledFieldsWithIncorrectMobileContactNumberFormat".equals(fields)) {
            fieldsSet = getMaxFieldsSet(logo, email);
            fieldsSet.put("MobileNumber", "wrongMobileNumber");
        } else if ("MandatoryFieldsNoPassword".equals(fields)) {
            fieldsSet.put("Password", "none");
        }
        return getUser(fieldsSet,false);
    }

    public User getUser(String fields, String logo) {
        return getUser(fields, logo, "");
    }

    public User getUser(String fields) {
        return getUser(fields, "");
    }

    public User getUser(Map<String, String> fieldsMap, boolean isRealDB) {
        Map<String, String> fields = getMinFieldsSet(fieldsMap.get("Logo"), fieldsMap.get("Email"));
        fields.putAll(fieldsMap);
        Agency desiredAgency = fields.get("Agency").equals("##")
                ? agency
                :fields.get("Agency").startsWith("IngestAgency") ?dataSet.getAgencyByName("IngestAgency"):dataSet.getAgencyByName(fields.get("Agency"));
        String desiredPassword = fields.get("Password").equals("##")
                ? defaultPassword
                : fields.get("Password");
        if(desiredAgency.getName().startsWith("AdstreamQaIngest"))
            desiredPassword="abcdefghA1";
        User user = new User();
        user.setLanguage(fields.get("Language"));
        user.setAgency(desiredAgency);
        user.setRoles(getRoles(fields.get("Role").split(","),isRealDB));
        user.setPhoneNumber(fields.get("Telephone"));
        user.setMobileNumber(fields.get("MobileNumber"));
        user.setSkypeNumber(fields.get("SkypeNumber"));
        user.setGoogleTalkContact(fields.get("GoogleTalkContact"));
        user.setDisabled(Boolean.parseBoolean(fields.get("Disabled")));
        user.setFirstName(fields.get("FirstName"));
        user.setLastName(fields.get("LastName"));
        user.setPassword(desiredPassword);
        user.setEmail(fields.get("Email"));
        user.setPasswordNeverExpires(Boolean.parseBoolean(fields.get("PasswordNeverExpires")));
        List<ApplicationAccess> access = new ArrayList<>();
        for (String accessItem : fields.get("Access").split(",")) {
            if (accessItem.trim().isEmpty()) {
                continue;
            }
            access.add(ApplicationAccess.getByValue(accessItem.trim()));
        }
        user.setAccess(access.toArray(new ApplicationAccess[access.size()]));
        Logo logo = Logo.valueOf(fields.get("Logo"));
        if (logo == Logo.EMPTY) {
            user.setLogo("");
        } else {
            user.setLogo(logo.getBase64());
        }
        user.setRegistered(true);
        return user;
    }
    public User getUserForExistingBU(Map<String, String> fieldsMap, boolean isRealDB) {
        Map<String, String> fields = getMinFieldsSet(fieldsMap.get("Logo"), fieldsMap.get("Email"));
        fields.putAll(fieldsMap);
        Agency desiredAgency = service.getAgencyByName(fields.get("Agency"));
        String desiredPassword ="abcdefghA1";
        User user = new User();
        user.setLanguage(fields.get("Language"));
        user.setAgency(desiredAgency);
        user.setRoles(getRoles(fields.get("Role").split(","),isRealDB));
        user.setPhoneNumber(fields.get("Telephone"));
        user.setMobileNumber(fields.get("MobileNumber"));
        user.setSkypeNumber(fields.get("SkypeNumber"));
        user.setGoogleTalkContact(fields.get("GoogleTalkContact"));
        user.setDisabled(Boolean.parseBoolean(fields.get("Disabled")));
        user.setFirstName(fields.get("FirstName"));
        user.setLastName(fields.get("LastName"));
        user.setPassword(desiredPassword);
        user.setEmail(fields.get("Email"));
        user.setPasswordNeverExpires(Boolean.parseBoolean(fields.get("PasswordNeverExpires")));
        List<ApplicationAccess> access = new ArrayList<>();
        for (String accessItem : fields.get("Access").split(",")) {
            if (accessItem.trim().isEmpty()) {
                continue;
            }
            access.add(ApplicationAccess.getByValue(accessItem.trim()));
        }
        user.setAccess(access.toArray(new ApplicationAccess[access.size()]));
        Logo logo = Logo.valueOf(fields.get("Logo"));
        if (logo == Logo.EMPTY) {
            user.setLogo("");
        } else {
            user.setLogo(logo.getBase64());
        }
        user.setRegistered(true);
        return user;
    }

    private Role[] getRoles(String[] roleNames, boolean isRealDb) {
        Role[] roles = new Role[roleNames.length];
        for (int i = 0; i < roleNames.length; i++)
            roles[i] = service.getRoleByName(roleNames[i],isRealDb);
        return roles;
    }
}
