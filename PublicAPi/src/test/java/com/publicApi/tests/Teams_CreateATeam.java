package com.publicApi.tests;

import com.publicApi.coreCalls.HeadlessAPICalls;
import com.publicApi.jsonPayLoads.ExpectedData;
import com.publicApi.tests.testsBase.BaseTests;
import org.testng.Assert;
import org.testng.annotations.Test;

/**
 * Created by Saritha.Dhanala on 04/01/2017.
 *
 * Create a "Library Team" or "Public Project Team Template"
 */
public class Teams_CreateATeam extends BaseTests {

    @Test
    public void createAPublicProjectTeamTemplateTest() {
        apiCall = new HeadlessAPICalls();
        responsePayLoad = null;
        String teamName = "ProjectTeam"+System.currentTimeMillis();

        responsePayLoad = apiCall.createATeam(teamName, ExpectedData.PROJECTTEAMTYPE);

        actual_list.add(responsePayLoad.getDocumentType());
        actual_list.add(responsePayLoad.getMeta().getCommon().getName()); // Team name

        expected_list.add("agency_team");
        expected_list.add(teamName);

        Assert.assertEquals(actual_list, expected_list,
                this.getClass().getSimpleName().toUpperCase()+": End Point Failed due to, ");

    }

    @Test
    public void createALibraryTeamTest() {
        apiCall = new HeadlessAPICalls();
        responsePayLoad = null;
        String teamName = "LibraryTeam"+System.currentTimeMillis();

        responsePayLoad = apiCall.createATeam(teamName,ExpectedData.LIBRARYTEAMTYPE);

        actual_list.add(responsePayLoad.getDocumentType());
        actual_list.add(responsePayLoad.getMeta().getCommon().getName()); // Team name
        actual_list.add(responsePayLoad.getMeta().getCommon().getDescription()); // Team description (Library teams only)

        expected_list.add("group");
        expected_list.add(teamName);
        expected_list.add(ExpectedData.LIBRARYTEAMDESCRIPTION);

        Assert.assertEquals(actual_list, expected_list,
                this.getClass().getSimpleName().toUpperCase()+": End Point Failed due to, ");

    }

}
