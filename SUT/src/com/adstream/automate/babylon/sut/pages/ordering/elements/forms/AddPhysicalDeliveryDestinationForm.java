package com.adstream.automate.babylon.sut.pages.ordering.elements.forms;

import com.adstream.automate.babylon.sut.pages.ordering.OrderItemPage;
import com.adstream.automate.page.controls.Edit;

/*
 * Created by demidovskiy-r on 12.02.14.
 */
public class AddPhysicalDeliveryDestinationForm extends DestinationForm {
    private Edit destinationName;
    private Edit contactName;
    private Edit contactDetails;
    private Edit streetAddress;
    private Edit city;
    private Edit postCode;
    private Edit country;

    public AddPhysicalDeliveryDestinationForm(OrderItemPage parent) {
        super(parent);
    }

    @Override
    protected void initControls() {
        controls.put("Destination Name", destinationName = new Edit(parent, getControlLocatorByName("name")));
        controls.put("Contact Name", contactName = new Edit(parent, getControlLocatorByName("contactName")));
        controls.put("Contact Details", contactDetails = new Edit(parent, getControlLocatorByName("contactDetails")));
        controls.put("Street Address", streetAddress = new Edit(parent, getControlLocatorByName("streetAddress")));
        controls.put("City", city = new Edit(parent, getControlLocatorByName("city")));
        controls.put("Post Code", postCode = new Edit(parent, getControlLocatorByName("postCode")));
        controls.put("Country", country = new Edit(parent, getControlLocatorByName("country")));
    }
}