package com.publicApi.tests;

import com.publicApi.coreCalls.HeadlessAPICalls;
import com.publicApi.jsonPayLoads.GsonClasses.BaseOfBase;
import com.publicApi.tests.testsBase.BaseTests;
import com.publicApi.jsonPayLoads.ExpectedData;
import org.testng.Assert;
import org.testng.annotations.Test;

import java.util.Random;

/**
 * Created by Nirmala.Sankaran on 12/02/26e016.
 */
public class Teams_SearchTeams extends BaseTests {

    private String projectTeamName = null;
    private String libraryTeamName = null;
    private BaseOfBase[] response = null;

    public Teams_SearchTeams(){
        apiCall = new HeadlessAPICalls();

    }

    //Search Team with no parameters :By default Only project teams are returned
    @Test
    public void searchTeamsTestWithNoParameters() {
        response = null;

        projectTeamName = "ProjectTeam"+generateRandom();
        libraryTeamName = "LibraryTeam"+generateRandom();

        apiCall.createATeam(projectTeamName, ExpectedData.PROJECTTEAMTYPE);
        apiCall.createATeam(libraryTeamName, ExpectedData.LIBRARYTEAMTYPE);

        //wait until the teams are created
        waitFor(1000);

        //Only project teams are returned
        response = apiCall.searchTeams();

        Boolean projectTeamCreated = false;
        for(int i=0;i<response.length;i++){
            Assert.assertNotEquals(response[i].getDocumentType(), "group", "Library teams are returned");
            if(response[i].getMeta().getCommon().getName().equals(projectTeamName)){
                projectTeamCreated = true;
            }
        }
        Assert.assertTrue(projectTeamCreated, "Newly added project team is not found");

    }

    @Test
    public void searchLibraryTeamsWithTeamTypeTest() {
        response = null;

        projectTeamName = "ProjectTeam"+generateRandom();
        libraryTeamName = "LibraryTeam"+generateRandom();

        apiCall.createATeam(libraryTeamName, ExpectedData.LIBRARYTEAMTYPE);
        apiCall.createATeam(projectTeamName, ExpectedData.PROJECTTEAMTYPE);

        //wait until the teams are created
        waitFor(1000);

        //Only project teams are returned
        response = apiCall.searchTeamsByParameters("onlyTeamType", "", ExpectedData.LIBRARYTEAMTYPE, "", 0, 0, "");

        Boolean libraryTeamCreated = false;
        for(int i=0;i<response.length;i++){
            Assert.assertNotEquals(response[i].getDocumentType(), "agency_team", "Project teams are returned");
            if(response[i].getMeta().getCommon().getName().equals(libraryTeamName)){
                libraryTeamCreated = true;
            }
        }
        Assert.assertTrue(libraryTeamCreated, "Newly added library team is not found");

    }


    //Search project teams by only pagination. pagination does not work for library teams
    @Test
    public void searchProjectTeamsWithPaginationTest() {
        response = null;

        projectTeamName = "ProjectTeam"+generateRandom();
        apiCall.createATeam(projectTeamName, ExpectedData.PROJECTTEAMTYPE);
        projectTeamName = "ProjectTeam"+generateRandom();
        apiCall.createATeam(projectTeamName, ExpectedData.PROJECTTEAMTYPE);

        //wait until the teams are created
        waitFor(1000);

        //Search project teams by pagination
        response = apiCall.searchTeamsByParameters("onlyPagination", "", ExpectedData.PROJECTTEAMTYPE, "",1, 1, "" );
        Assert.assertEquals(response.length, 1);

    }

    //Search project teams by query only
    @Test
    public void searchProjectTeamsWithQueryTest() {
        response = null;
        responsePayLoad = null;

        projectTeamName = "ProjectTeam"+generateRandom();
        //Search project team by query
        responsePayLoad = apiCall.createATeam(projectTeamName, ExpectedData.PROJECTTEAMTYPE);

        //wait until the teams are created
        waitFor(1000);

        //Search project teams by query
        String query = "meta.common.name:" + responsePayLoad.getMeta().getCommon().getName();
        response = apiCall.searchTeamsByParameters("onlyQuery", "", ExpectedData.PROJECTTEAMTYPE, query, 0, 0, "");
        Assert.assertEquals(response[0].getMeta().getCommon().getName(), responsePayLoad.getMeta().getCommon().getName());

    }

    //Search library teams by query only
    @Test
    public void searchLibraryTeamsWithQueryTest() {
        response = null;
        responsePayLoad = null;

        libraryTeamName = "LibraryTeam"+generateRandom();
        //Search library team by query
        responsePayLoad = apiCall.createATeam(libraryTeamName, ExpectedData.LIBRARYTEAMTYPE);

        //wait until the teams are created
        waitFor(1000);

        //Search project team by query
        String query = "meta.common.name:" + responsePayLoad.getMeta().getCommon().getName();
        response = apiCall.searchTeamsByParameters("onlyQuery", "", ExpectedData.LIBRARYTEAMTYPE, query, 0, 0, "");
        Assert.assertEquals(response[0].getMeta().getCommon().getName(), responsePayLoad.getMeta().getCommon().getName());

    }

    //Search project teams with sort by name and order DESC
    @Test
    public void searchProjectTeamsWithSortTest() {
        response = null;

        String projectTeamName1 = "AA"+"ProjectTeam"+generateRandom();
        String projectTeamName2 = "CC"+"ProjectTeam"+generateRandom();
        String projectTeamName3 = "ZZ"+"ProjectTeam"+generateRandom();

       apiCall.createATeam(projectTeamName1, ExpectedData.PROJECTTEAMTYPE);
       apiCall.createATeam(projectTeamName2, ExpectedData.PROJECTTEAMTYPE);
       apiCall.createATeam(projectTeamName3, ExpectedData.PROJECTTEAMTYPE);

        //wait until the teams are created
        waitFor(1000);

        //Below Search returns only project teams
        response = apiCall.searchTeamsByParameters("sorting", "meta.common.name", ExpectedData.PROJECTTEAMTYPE, "", 0, 0, "DESC");

        Assert.assertTrue(response[0].getMeta().getCommon().getName().contains(projectTeamName3.substring(0,13)), "No Sorting for Project teams");
        Assert.assertTrue(response[response.length-1].getMeta().getCommon().getName().contains(projectTeamName1.substring(0,13)), "No Sorting for Project teams");

    }

    //Search library teams with sort by name and order DESC
    //API-558 Search Teams : Sorting does not work for library teams
    @Test(enabled=false)
    public void searchLibraryTeamsWithSortTest() {
        response = null;

        String libTeamName1 = "AA"+"LibraryTeam"+generateRandom();
        String libTeamName2 = "CC"+"LibraryTeam"+generateRandom();
        String libTeamName3 = "ZZ"+"LibraryTeam"+generateRandom();

        apiCall.createATeam(libTeamName1, ExpectedData.LIBRARYTEAMTYPE);
        apiCall.createATeam(libTeamName2, ExpectedData.LIBRARYTEAMTYPE);
        apiCall.createATeam(libTeamName3, ExpectedData.LIBRARYTEAMTYPE);

        //wait until the teams are created
        waitFor(1000);

        //Below Search fails because library teams does not follow the sorting
        response = apiCall.searchTeamsByParameters("sorting", "meta.common.name", ExpectedData.LIBRARYTEAMTYPE, "", 0, 0, "DESC");

        Assert.assertTrue(response[0].getMeta().getCommon().getName().contains(libTeamName3.substring(0,13)), "No Sorting for Library teams");
        Assert.assertTrue(response[response.length-1].getMeta().getCommon().getName().contains(libTeamName1.substring(0,13)), "No Sorting for Library teams");

    }

    private String generateRandom(){
        Random randomGenerator = new Random();
        return Integer.toString(randomGenerator.nextInt(1000000));
    }

}
