package com.publicApi.tests;

import com.publicApi.jsonPayLoads.ExpectedData;
import com.publicApi.jsonPayLoads.GsonClasses.Users;
import com.publicApi.tests.testsBase.ProjectsBaseTest;
import org.testng.Assert;
import com.publicApi.coreCalls.HeadlessAPICalls;
import org.testng.annotations.AfterMethod;
import org.testng.annotations.BeforeMethod;
import org.testng.annotations.Test;



/**
 * Created by Saritha.Dhanala on 11/01/2017.
 *
 * A Project with a folder and 2 subfolders is created
 * A Team with 2 users is created
 * Team is assigned with inheritance false and true
 *
 * Team is deleted after every method because the roles of the users increases if I use the same team again.
 * Project is deleted after every method because even the team is deleted the added users are not deleted from the project
 */
public class ProjectsFolders_AssignTeamToFolder extends ProjectsBaseTest {

    private String teamId = null;
    private String roleId = ExpectedData.ProjectRoles.ProjectContributor.getProjectRoles();


    @BeforeMethod
    public void setData() {
        responsePayLoad = null;
        teamId = null;

        apiCall = new HeadlessAPICalls();
        responsePayLoad = apiCall.createProject();
        setProjectId(responsePayLoad.getId());

        Assert.assertNotNull(getProjectId());

        responsePayLoad = apiCall.searchProjectFolderId(getProjectId());
        setParentFileId(responsePayLoad.getId());

        Assert.assertNotNull(getParentFileId());

        responsePayLoad = apiCall.createFolder(getParentFileId());
        setFolderId(responsePayLoad.getId());

        Assert.assertNotNull(getFolderId());

        apiCall.createFolder(getFolderId());
        apiCall.createFolder(getFolderId());

        //Create a team
        responsePayLoad = apiCall.createATeam("NewAssignTeam", ExpectedData.PROJECTTEAMTYPE);
        teamId = responsePayLoad.getId();

        Assert.assertNotNull(teamId);

        //Add 2 users to team, the role used is Project User
        Boolean userAdded = apiCall.addUserToTeam(ExpectedData.TEAM_USERID_1, teamId, roleId, ExpectedData.PROJECTTEAMTYPE);
        Assert.assertTrue(userAdded, "User is not added to Team "+teamId);

        userAdded = apiCall.addUserToTeam(ExpectedData.TEAM_USERID_2, teamId, roleId, ExpectedData.PROJECTTEAMTYPE);
        Assert.assertTrue(userAdded, "User is not added to Team "+teamId);

    }

    @Test
    public void assignTeamToFolderWithNoInheritanceTest() {

        //Inheritance is set to false
        boolean inheritance = false;

            Users[] response = apiCall.assignTeamToFolder(getFolderId(), teamId, roleId, inheritance, ExpectedData.NEWASSIGNTEAM_EXPIRATION);

            //Check response of both the users
            for (int i = 0; i < response.length; i++) {
                Assert.assertEquals(response[i].getRoles()[0].getRole(), roleId);
                Assert.assertEquals(response[i].getRoles()[0].isInheritance(), inheritance);
            }
    }

    @Test
    public void assignTeamToFolderWithInheritanceTest() {

        //Inheritance is set to true
        boolean inheritance = true;

            Users[] response = apiCall.assignTeamToFolder(getFolderId(), teamId, roleId, inheritance, ExpectedData.NEWASSIGNTEAM_EXPIRATION);

            //Check response of both the users
            for(int i=0;i<response.length;i++){
                Assert.assertEquals(response[i].getRoles()[0].getRole(), roleId);
                Assert.assertEquals(response[i].getRoles()[0].isInheritance(), inheritance);
            }

           /* for (int i = 0; i < response.length; i++) {
                for (int j = 0; j < response[i].getRoles().length; j++) {
                    Assert.assertEquals(response[i].getRoles()[j].getRole(), roleId);
                    if (response[i].getRoles()[j].isInheritance() || response[i].getRoles()[j].isParent()) {
                        Assert.assertTrue(true, "Valid cases - inheritance = " + response[i].getRoles()[j].isInheritance() + " and parent = " + response[i].getRoles()[j].isParent());
                    } else {
                        Assert.assertTrue(false, "Invalid case- inheritance = " + response[i].getRoles()[j].isInheritance() + " and parent = " + response[i].getRoles()[j].isParent());

                    }
                }
            }*/
    }


    @Test
    public void assignTeamToFolderWithRequiredParametersTest() {

        //Inheritance is set to false
        boolean inheritance = false;

        Users[] response = apiCall.assignTeamToFolder(getFolderId(), teamId, roleId, inheritance, "");

        //Check response of both the users
        for(int i=0;i<response.length;i++){
            Assert.assertEquals(response[i].getRoles()[0].getRole(), roleId);
            Assert.assertEquals(response[i].getRoles()[0].isInheritance(), inheritance);
        }
    }

    @AfterMethod
    public void deleteProjectAndTeam() {

        if(teamId!=null) {
            apiCall.deleteATeam(teamId, ExpectedData.PROJECTTEAMTYPE);
        }

        if(getProjectId()!=null){
            apiCall.deleteProject(getProjectId());
        }

    }
}
