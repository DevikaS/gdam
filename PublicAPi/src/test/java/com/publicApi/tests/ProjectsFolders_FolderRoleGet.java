package com.publicApi.tests;

import com.publicApi.coreCalls.HeadlessAPICalls;
import com.publicApi.jsonPayLoads.ExpectedData;
import com.publicApi.jsonPayLoads.GsonClasses.Users;
import com.publicApi.tests.testsBase.ProjectsBaseTest;
import org.testng.Assert;
import org.testng.annotations.Test;


public class ProjectsFolders_FolderRoleGet extends ProjectsBaseTest {

    @Test
    public void projectsFolders_FolderRolesGet() {
        String subFolder = "";

        apiCall = new HeadlessAPICalls();

        responsePayLoad = apiCall.createProject();
        setProjectId(responsePayLoad.getId());

        responsePayLoad = apiCall.searchProjectFolderId(getProjectId());
        setParentFileId(responsePayLoad.getId());

        responsePayLoad = apiCall.createFolder(getParentFileId());
        setFolderId(responsePayLoad.getId());

        //Call Folder Role Create with inheritance
        Boolean result = apiCall.folderRoleCreate(getFolderId());
        Assert.assertTrue(result, this.getClass().getSimpleName().toUpperCase() + ": End Point Failed due to, ");

        //Call Folder Role Create without inheritance
        result = apiCall.folderRoleCreate(ExpectedData.TEAM_USERID_1, getFolderId(), false);
        Assert.assertTrue(result, this.getClass().getSimpleName().toUpperCase() + ": End Point Failed due to, ");

        //Create sub folder inside folder
        responsePayLoad = apiCall.createFolder(getFolderId());
        subFolder = responsePayLoad.getId();

        //Call Folder Role Create without inheritance
        result = apiCall.folderRoleCreate(ExpectedData.TEAM_USERID_2, subFolder, false);
        Assert.assertTrue(result, this.getClass().getSimpleName().toUpperCase() + ": End Point Failed due to, ");

        // For folder with recursive false
        Users[] users = apiCall.getFolderRoles(getFolderId(), false);
        expected_list.clear();
        expected_list.add("numberOfUsers:" + 2);
        expected_list.add("Role1 Inheritance:" + true);
        expected_list.add("Role1 Parent:" + false); // always returned by core as false
        expected_list.add("Role2 Inheritance:" + false);
        expected_list.add("Role2 Parent:" + false); // always returned by core as false

        actual_list.clear();
        actual_list.add("numberOfUsers:" + users.length);
        actual_list.add("Role1 Inheritance:" + users[0].getRoles()[0].isInheritance());
        actual_list.add("Role1 Parent:" + users[0].getRoles()[0].isParent());
        actual_list.add("Role2 Inheritance:" + users[1].getRoles()[0].isInheritance());
        actual_list.add("Role2 Parent:" + users[1].getRoles()[0].isParent());

        Assert.assertEquals(actual_list, expected_list,
                this.getClass().getSimpleName().toUpperCase() + ": End Point Failed due to, ");

        //For folder with recursive true
        users = apiCall.getFolderRoles(getFolderId(), true);

        expected_list.clear();
        expected_list.add("numberOfUsers:" + 3);
        expected_list.add("User1 Role1 Inheritance:" + true);
        expected_list.add("User1 Role1 Parent:" + false);
        /*expected_list.add("User1 Role2 Inheritance:" + true);
        expected_list.add("User1 Role2 Parent:" + true);*/
        expected_list.add("User2 Role1 Inheritance:" + false);
        expected_list.add("User2 Role1 Parent:" + false); // always returned by core as false
        expected_list.add("User3 Role1 Inheritance:" + false);
        expected_list.add("User3 Role1 Parent:" + false); // always returned by core as false

        actual_list.clear();
        actual_list.add("numberOfUsers:" + users.length);
        actual_list.add("User1 Role1 Inheritance:" + users[0].getRoles()[0].isInheritance());
        actual_list.add("User1 Role1 Parent:" + users[0].getRoles()[0].isParent());
       /* actual_list.add("User1 Role2 Inheritance:" + users[0].getRoles()[1].isInheritance());
        actual_list.add("User1 Role2 Parent:" + users[0].getRoles()[1].isParent());*/
        actual_list.add("User2 Role1 Inheritance:" + users[1].getRoles()[0].isInheritance());
        actual_list.add("User2 Role1 Parent:" + users[1].getRoles()[0].isParent());
        actual_list.add("User3 Role1 Inheritance:" + users[2].getRoles()[0].isInheritance());
        actual_list.add("User3 Role1 Parent:" + users[2].getRoles()[0].isParent());

        Assert.assertEquals(actual_list, expected_list,
                this.getClass().getSimpleName().toUpperCase() + ": End Point Failed due to, ");

        users = apiCall.getFolderRoles(subFolder, true);

        expected_list.clear();
        expected_list.add("numberOfUsers:" + 2);
        expected_list.add("User1 Role1 Inheritance:" + true);
        expected_list.add("User1 Role1 Parent:" + false);
        expected_list.add("User2 Role1 Inheritance:" + false);
        expected_list.add("User2 Role1 Parent:" + false); // always returned by core as false

        actual_list.clear();
        actual_list.add("numberOfUsers:" + users.length);
        actual_list.add("User1 Role1 Inheritance:" + users[0].getRoles()[0].isInheritance());
        actual_list.add("User1 Role1 Parent:" + users[0].getRoles()[0].isParent());
        actual_list.add("User2 Role1 Inheritance:" + users[1].getRoles()[0].isInheritance());
        actual_list.add("User2 Role1 Parent:" + users[1].getRoles()[0].isParent());

        Assert.assertEquals(actual_list, expected_list,
                this.getClass().getSimpleName().toUpperCase() + ": End Point Failed due to, ");
    }
}