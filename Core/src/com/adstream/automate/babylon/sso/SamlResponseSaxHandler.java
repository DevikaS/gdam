package com.adstream.automate.babylon.sso;

import org.xml.sax.Attributes;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.DefaultHandler;

/**
 * User: ruslan.semerenko
 * Date: 23.10.12 11:41
 */
public class SamlResponseSaxHandler extends DefaultHandler {
    private SSOProfile profile = new SSOProfile();
    private String currentElement;
    private String value;

    public SSOProfile getResult() {
        return profile;
    }

    @Override
    public void startElement(String uri, String localName, String qName, Attributes attributes) throws SAXException {
        String name = attributes.getValue("Name");
        if (name != null) {
            currentElement = name.substring(name.lastIndexOf("/") + 1);
            value = "";
        }
    }

    @Override
    public void endElement(String uri, String localName, String qName) throws SAXException {
        if (currentElement != null) {
            if (currentElement.equals("agencyName"))
                profile.setAgencyName(value);
            else if (currentElement.equals("authenticationToken"))
                profile.setAuthenticationToken(value);
            else if (currentElement.equals("userFirstName"))
                profile.setUserFirstName(value);
            else if (currentElement.equals("userLocale"))
                profile.setUserLocale(value);
            else if (currentElement.equals("userEmail"))
                profile.setUserEmail(value);
            else if (currentElement.equals("userGroup"))
                profile.setUserGroup(value);
            else if (currentElement.equals("isAdmin"))
                profile.setIsAdmin(value);
            else if (currentElement.equals("userLastName"))
                profile.setUserLastName(value);
            currentElement = null;
        }
    }

    @Override
    public void characters(char[] ch, int start, int length) throws SAXException {
        if (currentElement != null) {
            value += new String(ch, start, length);
        }
    }
}
