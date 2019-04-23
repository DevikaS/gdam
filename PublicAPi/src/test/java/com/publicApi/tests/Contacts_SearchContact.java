package com.publicApi.tests;

import com.publicApi.coreCalls.HeadlessAPICalls;
import com.publicApi.jsonPayLoads.ExpectedData;
import com.publicApi.jsonPayLoads.GsonClasses.Contact;
import com.publicApi.tests.testsBase.BaseTests;
import org.testng.Assert;
import org.testng.annotations.Test;

import java.util.List;


public class Contacts_SearchContact extends BaseTests {

    @Test
    public void searchContactsTest() {

        apiCall = new HeadlessAPICalls();
        //Add contact
        List<Contact> contacts = apiCall.addContact();
        String contactId = contacts.get(0).getId();

        //Search contact
        waitFor(1000);
        contacts = apiCall.searchContact();
        Assert.assertTrue(!contacts.isEmpty());
        Assert.assertTrue(isContactAvailable(contacts, contactId));

        //Delete the added contact
        Contact contact = apiCall.deleteContact(contactId);

        //Search Contact
        waitFor(1000);
        contacts = apiCall.searchContact();
        Assert.assertTrue(!contacts.isEmpty());
        Assert.assertTrue(!isContactAvailable(contacts, contactId));

    }

    private boolean isContactAvailable(List<Contact> contacts, String contactId) {
        boolean isAvailable = false;

        for (Contact contact : contacts) {
            if (contact.getId().equals(contactId))
                return true;
        }

        return isAvailable;
    }
}