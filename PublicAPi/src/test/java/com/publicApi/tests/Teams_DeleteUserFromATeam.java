package com.publicApi.tests;

import com.publicApi.coreCalls.HeadlessAPICalls;
import com.publicApi.jsonPayLoads.ExpectedData;
import com.publicApi.jsonPayLoads.GsonClasses.BaseOfBase;
import com.publicApi.tests.testsBase.BaseTests;
import org.testng.Assert;
import org.testng.annotations.Test;

/**
 * Created by Saritha.Dhanala on 06/01/2017.
 *
 * Delete a user from a "Library Team" or "Public Project Team Template"
 */
public class Teams_DeleteUserFromATeam extends BaseTests {
    @Test
    public void deleteUserFromPublicProjectTeamTemplateTest() {
        apiCall = new HeadlessAPICalls();
        responsePayLoad = null;
        String teamName = "ProjectTeam"+System.currentTimeMillis();
        String roleId = ExpectedData.ProjectRoles.ProjectContributor.getProjectRoles();

        responsePayLoad = apiCall.createATeam(teamName, ExpectedData.PROJECTTEAMTYPE);
        Assert.assertNotNull(responsePayLoad.getId());

        apiCall.addUserToTeam(ExpectedData.TEAM_USERID_1, responsePayLoad.getId(), roleId, ExpectedData.PROJECTTEAMTYPE);

        Boolean deletedUser = apiCall.deleteUserFromATeam(responsePayLoad.getId(), ExpectedData.TEAM_USERID_1, ExpectedData.PROJECTTEAMTYPE );
        Assert.assertTrue(deletedUser , "User is not deleted");

        //wait for deletion
        waitFor(1000);

        //Search teams with query
        String query = "meta.common.name:"+teamName;
        BaseOfBase[] response = apiCall.searchTeamsByParameters("onlyQuery", "", ExpectedData.PROJECTTEAMTYPE, query, 0, 0 ,"");

        Assert.assertEquals(response[0].getMeta().getCommon().getMembers().length, 0, "User is not deleted");

    }

    @Test
    public void deleteUserFromLibraryTeamTest() {
        apiCall = new HeadlessAPICalls();
        responsePayLoad = null;
        String teamName = "LibraryTeam"+System.currentTimeMillis();

        responsePayLoad = apiCall.createATeam(teamName, ExpectedData.LIBRARYTEAMTYPE);
        Assert.assertNotNull(responsePayLoad.getId());

        apiCall.addUserToTeam(ExpectedData.TEAM_USERID_2, responsePayLoad.getId(), "", ExpectedData.LIBRARYTEAMTYPE);

        Boolean deletedUser = apiCall.deleteUserFromATeam(responsePayLoad.getId(), ExpectedData.TEAM_USERID_2, ExpectedData.LIBRARYTEAMTYPE );
        Assert.assertTrue(deletedUser , "User is not deleted");

        //wait for deletion
        waitFor(1000);

        //Search teams with query
        String query = "meta.common.name:"+teamName;
        BaseOfBase[] response  = apiCall.searchTeamsByParameters("onlyQuery", "", ExpectedData.LIBRARYTEAMTYPE, query, 0, 0 ,"");

        Assert.assertEquals(response[0].getMeta().getCommon().getMembers().length, 0, "User is not deleted");

     }
}
