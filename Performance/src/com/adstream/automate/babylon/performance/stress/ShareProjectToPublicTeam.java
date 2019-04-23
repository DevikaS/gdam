package com.adstream.automate.babylon.performance.stress;

import com.adstream.automate.babylon.BabylonServiceWrapper;
import com.adstream.automate.babylon.JsonObjects.*;
import com.adstream.automate.babylon.core.BabylonCoreService;
import com.adstream.automate.babylon.performance.helper.ObjectsFactory;
import com.adstream.automate.utils.Gen;
import org.apache.log4j.PropertyConfigurator;

import java.net.URL;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

/**
 * User: ruslan.semerenko
 * Date: 07.10.13 18:14
 */
public class ShareProjectToPublicTeam {
    private static final int USERS_COUNT = 300;
    private static final int THREADS_COUNT = 1;
    private static final int PROJECTS_COUNT = 5;
    private static BabylonServiceWrapper service;

    public static void main(String[] args) throws Exception {
        PropertyConfigurator.configure("log4j.properties");
        service = new BabylonServiceWrapper(new BabylonCoreService(new URL("http://10.0.26.16:8080")), null);
        service.logIn("babylonautotester+agencyadmin@gmail.com", "1");
        List<User> users = createUsers(USERS_COUNT);
        final AgencyProjectTeam team =
                service.createAgencyTeam(getAgencyProjectTeam(users, service.getRoleByName("project.contributor")));
        ExecutorService executor = Executors.newFixedThreadPool(THREADS_COUNT);
        for (int i = 0; i < PROJECTS_COUNT; i++) {
            executor.execute(new Runnable() {
                @Override
                public void run() {
                    Project project = service.createProject(ObjectsFactory.getProject(Gen.getHumanReadableString(6, true)));
                    long start = System.currentTimeMillis();
                    service.addObjectToAgencyProjectTeam(team.getId(), project.getId());
                    System.out.println(String.format("Share project for %d ms" , System.currentTimeMillis() - start));
                }
            });
        }
        executor.shutdown();
    }

    private static List<User> createUsers(int count) {
        List<User> users = new ArrayList<User>();
        Agency agency = service.getCurrentAgency();
        Role guestRole = service.getRoleByName("guest.user");
        for (int i = 0; i < count; i++) {
            if (i % 25 == 24) {
                System.out.println(String.format("Created %d users", i + 1));
            }
            users.add(service.createUser(ObjectsFactory.getUser(agency, guestRole)));
        }
        return users;
    }

    private static AgencyProjectTeam getAgencyProjectTeam(List<User> users, Role role) {
        AgencyProjectTeam agencyProjectTeam = new AgencyProjectTeam();
        agencyProjectTeam.setName(Gen.getHumanReadableString(6, true));
        List<AgencyTeamMember> listOfMembers = new ArrayList<AgencyTeamMember>();
        for (User user : users) {
            AgencyTeamMember membersAgencyProjectTeam = new AgencyTeamMember();
            membersAgencyProjectTeam.setUserId(user.getId());
            membersAgencyProjectTeam.setRoleId(role.getId());
            listOfMembers.add(membersAgencyProjectTeam);
        }
        agencyProjectTeam.setMembers(listOfMembers.toArray(new AgencyTeamMember[listOfMembers.size()]));
        return agencyProjectTeam;
    }
}
