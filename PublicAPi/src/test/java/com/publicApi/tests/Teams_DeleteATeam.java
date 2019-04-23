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
 * Delete a "Library Team" or "Public Project Team Template"
 */
public class Teams_DeleteATeam extends BaseTests {

    @Test
    public void deleteAPublicProjectTeamTemplateTest() {
        apiCall = new HeadlessAPICalls();
        responsePayLoad = null;
        String teamName = "ProjectTeam"+System.currentTimeMillis();

        responsePayLoad = apiCall.createATeam(teamName, ExpectedData.PROJECTTEAMTYPE);
        Assert.assertNotNull(responsePayLoad.getId());

        apiCall.deleteATeam(responsePayLoad.getId(), ExpectedData.PROJECTTEAMTYPE );

        waitFor(1000); // Wait for Team to be deleted
        String query = "meta.common.name:"+teamName;
        BaseOfBase[] response  = apiCall.searchTeamsByParameters("onlyQuery", "", ExpectedData.PROJECTTEAMTYPE, query, 0, 0 ,"");
        Assert.assertEquals(response.length, 0, "Project team is not deleted");


    }

    @Test
    public void deleteALibraryTeamTest() {
        apiCall = new HeadlessAPICalls();
        responsePayLoad = null;
        String teamName = "LibraryTeam"+System.currentTimeMillis();

        responsePayLoad = apiCall.createATeam(teamName, ExpectedData.LIBRARYTEAMTYPE);
        Assert.assertNotNull(responsePayLoad.getId());

        apiCall.deleteATeam(responsePayLoad.getId(), ExpectedData.LIBRARYTEAMTYPE );

        waitFor(1000); // Wait for Team to be deleted
        String query = "meta.common.name:"+teamName;
        BaseOfBase[] response  = apiCall.searchTeamsByParameters("onlyQuery", "", ExpectedData.LIBRARYTEAMTYPE, query, 0, 0 ,"");
        Assert.assertEquals(response.length, 0, "Library team is not deleted");
    }
}
