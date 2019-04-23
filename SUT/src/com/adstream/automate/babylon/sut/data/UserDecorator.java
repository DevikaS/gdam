package com.adstream.automate.babylon.sut.data;

import com.adstream.automate.babylon.JsonObjects.User;
import com.adstream.automate.utils.Gen;
import org.apache.commons.codec.binary.Base64;
import org.apache.commons.io.FileUtils;

import java.io.File;
import java.io.IOException;

/**
 * User: ruslan.semerenko
 * Date: 25.04.12 11:08
 */
public class UserDecorator {
    private User user;

    public UserDecorator(User user) {
        this.user = user;
    }

    public String getAgencyName() {
        return user.getAgency().getName();
    }

    public String getFirstName() {
        return user.getFirstName();
    }

    public String getLastName() {
        return user.getLastName();
    }

    public String getEmail() {
        return user.getEmail();
    }

    public String getPhoneNumber() {
        return user.getPhoneNumber();
    }

    public String getPassword() {
        return user.getPassword();
    }

    public boolean isFoldersAccess() {
        return user.hasFoldersAccess();
    }

    public boolean isLibraryAccess() {
        return user.hasLibraryAccess();
    }

    public boolean isStreamLinedLibraryAccess() {
        return user.hasStreamlinedlibraryAccess();
    }
    public boolean isOrderingAccess() {
        return user.hasDeliveryAccess();
    }

    public boolean isTrafficAccess() { return user.hasTrafficAccess();}

    public boolean isDashboardAccess() { return user.hasDashboardAccess();}

    public String getRoleName() {
        String unresolvedUserRole = user.getRoles()[0].getName();
        if(unresolvedUserRole.equals("agency.admin")) {
            unresolvedUserRole = "Business Unit Admin" ;
        }else if(unresolvedUserRole.equals("agency.user")){
            unresolvedUserRole = "Business Unit User" ;
        }else if(unresolvedUserRole.equals("guest.user")){
            unresolvedUserRole = "Guest User" ;
        }
        return unresolvedUserRole;
    }

    public String getLogo() {
        return user.getLogo();
    }

    public String getLogoPath() {
        File image = null;
        try {
            image = File.createTempFile(Gen.generateGID(), ".jpg");
            image.deleteOnExit();
            FileUtils.writeByteArrayToFile(image, Base64.decodeBase64(user.getLogo()));
        } catch (IOException e) {
            e.printStackTrace();
        }
        return image != null ? image.getPath() : "";
    }

    public String getId() {
        return user.getId();
    }

    public String getMobileNumber() {
        return user.getMobileNumber();
    }

    public String getSkypeNumber() {
        return user.getSkypeNumber();
    }

    public String getGoogleTalkContact() {
        return user.getGoogleTalkContact();
    }

    public boolean isDisabled() {
        return user.isDisabled();
    }
}
