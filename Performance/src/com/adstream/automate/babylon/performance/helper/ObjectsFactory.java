package com.adstream.automate.babylon.performance.helper;

import com.adstream.automate.babylon.JsonObjects.*;
import com.adstream.automate.babylon.JsonObjects.ordering.enums.CustomMetadataField;
import com.adstream.automate.utils.Gen;
import org.joda.time.DateTime;
import org.joda.time.Period;

/**
 * User: ruslan.semerenko
 * Date: 07.10.13 13:18
 */
public class ObjectsFactory {
    public static Project getProject(String name) {
        Project project = new Project();
        project.setMediaType("Broadcast");
        project.setAdministrators(new String[0]);
        project.setSubtype("project");
        project.setLogo("");
        project.setDateStart(new DateTime());
        project.setDateEnd(new DateTime().plus(Period.days(10)));
        project.setName(name);
        project.setJobNumber(Gen.getHumanReadableString(8, true));
        return project;
    }

    public static Project getTemplate(String name) {
        Project project = getProject(name);
        project.setSubtype("project_template");
        return project;
    }

    public static User getUser(Agency agency, Role role) {
        User user = new User();
        user.setAgency(agency);
        user.setPhoneNumber("1234567890");
        user.setAdvertiser(agency.getId());
        user.setPassword("abcdefghA1");
        user.setAccess();
        user.setRoles(new BaseObject[] {role});
        user.setFirstName(Gen.getHumanReadableString(6, true));
        user.setLastName(Gen.getHumanReadableString(6, true));
        user.setEmail((user.getFirstName() + "." + user.getLastName() + "@test.com").toLowerCase());
        return user;
    }

    public static Agency createAgency(String storageId) {
        Agency agency = new Agency();
        agency.setTimeZone("Europe-Andorra");
        agency.setPin("1");
        agency.setAgencyType("Advertiser");
        agency.setCountry("AF");
        agency.setPasswordExpirationInDays(30);
        agency.setPasswordMinIncludingUppercase(0);
        agency.setPasswordMinTotalLengthOfPassword(1);
        agency.setPasswordMinimumIncludingNumbers(0);
        agency.setName(Gen.getHumanReadableString(6, true) + " Agency");
        agency.setA4AdvertiserField(CustomMetadataField.ADVERTISER.getPath());
        agency.setA4ProductField(CustomMetadataField.PRODUCT.getPath());
        agency.setStorageId(storageId);
        return agency;
    }
}
