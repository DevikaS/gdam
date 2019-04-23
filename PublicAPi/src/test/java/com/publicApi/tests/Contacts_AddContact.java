package com.publicApi.tests;

import com.publicApi.coreCalls.HeadlessAPICalls;
import com.publicApi.jsonPayLoads.ExpectedData;
import com.publicApi.jsonPayLoads.GsonClasses.Contact;
import com.publicApi.tests.testsBase.BaseTests;
import org.testng.Assert;
import org.testng.annotations.Test;

import java.util.List;


public class Contacts_AddContact extends BaseTests {

    @Test
    public void createContactTest() {

        apiCall = new HeadlessAPICalls();
        List<Contact> contacts = apiCall.addContact();

        Assert.assertEquals(contacts.get(0).getContactUser(),ExpectedData.ADD_CONTACT_USER_ID);
        Assert.assertEquals(contacts.get(0).getEmail(), ExpectedData.ADD_CONTACT_EMAIL);
    }
}