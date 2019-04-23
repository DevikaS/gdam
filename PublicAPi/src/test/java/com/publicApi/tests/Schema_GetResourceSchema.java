package com.publicApi.tests;

import com.publicApi.coreCalls.HeadlessAPICalls;
import com.publicApi.tests.testsBase.BaseTests;
import org.testng.Assert;
import org.testng.annotations.Test;

/**
 * Created by Nirmala.Sankaran on 26/01/2016.
 */
public class Schema_GetResourceSchema extends BaseTests {

    @Test
    public void resourceSchema_Assets_CreateTest() {

        apiCall = new HeadlessAPICalls();

        Assert.assertTrue(apiCall.resourceSchema("assets","create"),
                "Schema_GetResourceSchema - End point failed. Check 'Assets' resource for 'Create' method");
    }

    @Test
    public void resourceSchema_Assets_UpdateTest() {

        apiCall = new HeadlessAPICalls();

        Assert.assertTrue(apiCall.resourceSchema("assets","update"),
                "Schema_GetResourceSchema - End point failed. Check 'Assets' resource for 'Update' method");
    }

    @Test
    public void resourceSchema_Rights_CreateTest() {

        apiCall = new HeadlessAPICalls();

        Assert.assertTrue(apiCall.resourceSchema("rights","create"),
                "Schema_GetResourceSchema - End point failed. Check 'Rights' resource for 'Create' method");
    }

    @Test
    public void resourceSchema_Rights_UpdateTest() {

        apiCall = new HeadlessAPICalls();

        Assert.assertTrue(apiCall.resourceSchema("rights","update"),
                "Schema_GetResourceSchema - End point failed. Check 'Rights' resource for 'Update' method");
    }

    @Test
    public void resourceSchema_Projects_CreateTest() {

        apiCall = new HeadlessAPICalls();

        Assert.assertTrue(apiCall.resourceSchema("projects","create"),
                "Schema_GetResourceSchema - End point failed. Check 'projects' resource for 'Create' method");
    }

    @Test
    public void resourceSchema_projects_UpdateTest() {

        apiCall = new HeadlessAPICalls();

        Assert.assertTrue(apiCall.resourceSchema("projects","update"),
                "Schema_GetResourceSchema - End point failed. Check 'projects' resource for 'Update' method");
    }

    @Test
    public void resourceSchema_Folders_CreateTest() {

        apiCall = new HeadlessAPICalls();

        Assert.assertTrue(apiCall.resourceSchema("folders","create"),
                "Schema_GetResourceSchema - End point failed. Check 'Folders' resource for 'Create' method");
    }

    @Test
    public void resourceSchema_Folders_UpdateTest() {

        apiCall = new HeadlessAPICalls();

        Assert.assertTrue(apiCall.resourceSchema("folders","update"),
                "Schema_GetResourceSchema - End point failed. Check 'Folders' resource for 'Update' method");
    }

    @Test
    public void resourceSchema_Orders_CreateTest() {

        apiCall = new HeadlessAPICalls();

        Assert.assertTrue(apiCall.resourceSchema("orders","create"),
                "Schema_GetResourceSchema - End point failed. Check 'Orders' resource for 'Create' method");
    }

    @Test
    public void resourceSchema_Orders_UpdateTest() {

        apiCall = new HeadlessAPICalls();

        Assert.assertTrue(apiCall.resourceSchema("orders","update"),
                "Schema_GetResourceSchema - End point failed. Check 'Orders' resource for 'Update' method");
    }

    @Test
    public void resourceSchema_Presentations_CreateTest() {

        apiCall = new HeadlessAPICalls();

        Assert.assertTrue(apiCall.resourceSchema("presentations","create"),
                "Schema_GetResourceSchema - End point failed. Check 'Presentations' resource for 'Create' method");
    }

    @Test
    public void resourceSchema_Presentations_UpdateTest() {

        apiCall = new HeadlessAPICalls();

        Assert.assertTrue(apiCall.resourceSchema("presentations","update"),
                "Schema_GetResourceSchema - End point failed. Check 'Presentations' resource for 'Update' method");
    }

    @Test
    public void resourceSchema_Roles_CreateTest() {

        apiCall = new HeadlessAPICalls();

        Assert.assertTrue(apiCall.resourceSchema("roles","create"),
                "Schema_GetResourceSchema - End point failed. Check 'Roles' resource for 'Create' method");
    }

    @Test
    public void resourceSchema_Roles_UpdateTest() {

        apiCall = new HeadlessAPICalls();

        Assert.assertTrue(apiCall.resourceSchema("roles","update"),
                "Schema_GetResourceSchema - End point failed. Check 'Roles' resource for 'Update' method");
    }

    @Test
    public void resourceSchema_Teams_CreateTest() {

        apiCall = new HeadlessAPICalls();

        Assert.assertTrue(apiCall.resourceSchema("teams","create"),
                "Schema_GetResourceSchema - End point failed. Check 'Teams' resource for 'Create' method");
    }

    @Test
    public void resourceSchema_Teams_UpdateTest() {

        apiCall = new HeadlessAPICalls();

        Assert.assertTrue(apiCall.resourceSchema("teams","update"),
                "Schema_GetResourceSchema - End point failed. Check 'Teams' resource for 'Update' method");
    }

    @Test
    public void resourceSchema_Element_CreateTest() {

        apiCall = new HeadlessAPICalls();

        Assert.assertTrue(apiCall.resourceSchema("element","create"),
                "Schema_GetResourceSchema - End point failed. Check 'Element' resource for 'Create' method");
    }

    @Test
    public void resourceSchema_Element_UpdateTest() {

        apiCall = new HeadlessAPICalls();

        Assert.assertTrue(apiCall.resourceSchema("element","update"),
                "Schema_GetResourceSchema - End point failed. Check 'Element' resource for 'Update' method");
    }
}