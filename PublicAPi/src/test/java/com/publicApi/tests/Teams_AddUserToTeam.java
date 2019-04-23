package com.publicApi.tests;

import com.publicApi.coreCalls.HeadlessAPICalls;
import com.publicApi.jsonPayLoads.ExpectedData;
import com.publicApi.jsonPayLoads.GsonClasses.BaseOfBase;
import com.publicApi.tests.testsBase.BaseTests;
import org.testng.Assert;
import org.testng.annotations.Test;

/**
 * Created by Saritha.Dhanala on 05/01/2017.
 *
 * Teams - Add User to Team
 * Add a user to an existing "Library Team" or "Public Project Team Template". Check the search roles endpoint
 * to get the list of available roles. Due to the nature of this call, it might take a few seconds to properly
 * settle the information. Because of this, the call returns a 204 Empty response. Search the team for the newly
 * created user.
 *
 */
public class Teams_AddUserToTeam extends BaseTests {

    @Test
    public void addUserToPublicProjectTeamTemplateTest() {
        String roleId = ExpectedData.ProjectRoles.ProjectContributor.getProjectRoles();

        apiCall = new HeadlessAPICalls();
        responsePayLoad = null;
        String teamName = "ProjectTeam"+System.currentTimeMillis();

        responsePayLoad = apiCall.createATeam(teamName, ExpectedData.PROJECTTEAMTYPE);
        Assert.assertNotNull(responsePayLoad.getId());

        Boolean userAdded = apiCall.addUserToTeam(ExpectedData.TEAM_USERID_1, responsePayLoad.getId(), roleId, ExpectedData.PROJECTTEAMTYPE);

        Assert.assertTrue(userAdded, "Unable to add the user to project team");

        waitFor(1000); // Wait for user to be added
        //Search teams with query
        String query = "meta.common.name:"+teamName;
        BaseOfBase[] response = apiCall.searchTeamsByParameters("onlyQuery", "", ExpectedData.PROJECTTEAMTYPE, query, 0, 0 ,"");
        Assert.assertEquals(response[0].getMeta().getCommon().getMembers()[0].getUserId(), ExpectedData.TEAM_USERID_1 , "User is not added to project team");

    }

    @Test
    public void addUserToLibraryTeamTest() {

        apiCall = new HeadlessAPICalls();
        responsePayLoad = null;
        String teamName = "LibraryTeam"+System.currentTimeMillis();

        responsePayLoad = apiCall.createATeam(teamName, ExpectedData.LIBRARYTEAMTYPE);
        Assert.assertNotNull(responsePayLoad.getId());

        //roleId = ""
        Boolean userAdded = apiCall.addUserToTeam(ExpectedData.TEAM_USERID_2, responsePayLoad.getId(), "" , ExpectedData.LIBRARYTEAMTYPE);

        Assert.assertTrue(userAdded, "Unable to add the user to library team");

        waitFor(1000); // Wait for user to be added
        //Search teams with query
        String query = "meta.common.name:"+teamName;
        BaseOfBase[] response = apiCall.searchTeamsByParameters("onlyQuery", "", ExpectedData.LIBRARYTEAMTYPE, query, 0, 0 ,"");
        Assert.assertEquals(response[0].getMeta().getCommon().getMembers()[0].getUserId(), ExpectedData.TEAM_USERID_2, "User is not added to library team");

        }
}


