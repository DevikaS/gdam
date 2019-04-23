package com.publicApi.tests;

import com.publicApi.coreCalls.HeadlessAPICalls;
import com.publicApi.jsonPayLoads.ExpectedData;
import com.publicApi.jsonPayLoads.GsonClasses.Contact;
import com.publicApi.tests.testsBase.BaseTests;
import com.publicApi.tests.testsBase.LibraryBaseTests;
import org.testng.Assert;
import org.testng.annotations.Test;

import java.util.List;


public class Contacts_DeleteContact extends BaseTests {

    @Test
    public void deleteContactTest() {

        apiCall = new HeadlessAPICalls();
        List<Contact> contacts = apiCall.addContact();

        apiCall = new HeadlessAPICalls();
        Contact contact = apiCall.deleteContact(contacts.get(0).getId());

        Assert.assertEquals(contact.getContactUser(),ExpectedData.ADD_CONTACT_USER_ID);
        Assert.assertEquals(contact.getEmail(), ExpectedData.ADD_CONTACT_EMAIL);
    }
}