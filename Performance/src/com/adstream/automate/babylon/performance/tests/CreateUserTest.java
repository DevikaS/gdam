package com.adstream.automate.babylon.performance.tests;

import com.adstream.automate.babylon.JsonObjects.BaseObject;
import com.adstream.automate.babylon.JsonObjects.Role;
import com.adstream.automate.babylon.JsonObjects.User;
import com.adstream.automate.utils.Gen;

/**
 * User: ruslan.semerenko
 * Date: 16.07.12 19:46
 */
public class CreateUserTest extends AbstractPerformanceTestServiceWrapper {
    private User defaultUser;

    @Override
    public void runOnce() {
    }

    @Override
    public void beforeStart() {
        logIn(getParam("login"), getParam("password"));
        getCurrentAgency();
        getGuestRole();
    }

    @Override
    public void start() {
        User user = getService().createUser(getCurrentAgency().getId(), getUser());
        if (user == null)
            fail("Can not create user");
    }

    @Override
    public void afterRun() {
    }

    protected User getUser() {
        if (defaultUser == null) {
            defaultUser = new User();
            defaultUser.setAgency(getCurrentAgency());
            defaultUser.setPhoneNumber("1234567890");
            defaultUser.setMobileNumber("1234567890");
            defaultUser.setSkypeNumber("1234567890");
            defaultUser.setGoogleTalkContact("1234567890");
            defaultUser.setAdvertiser(getCurrentAgency().getId());
            defaultUser.setPassword("abcdefghA1");
            defaultUser.setAccess();
            defaultUser.setJobTitle("1234567890");
            defaultUser.setRoles(new BaseObject[] {getGuestRole()});
        }
        defaultUser.setFirstName(Gen.getHumanReadableString(6, true));
        defaultUser.setLastName(Gen.getHumanReadableString(6, true));
        defaultUser.setEmail((defaultUser.getFirstName() + "." + defaultUser.getLastName() + "@test.com").toLowerCase());
        return defaultUser;
    }

    protected Role getGuestRole() {
        return getRoleById("4fba0ec37fec91f70b5a0917");
    }
}
