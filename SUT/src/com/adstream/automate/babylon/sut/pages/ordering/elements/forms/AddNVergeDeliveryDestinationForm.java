package com.adstream.automate.babylon.sut.pages.ordering.elements.forms;

import com.adstream.automate.babylon.sut.pages.ordering.OrderItemPage;
import com.adstream.automate.page.controls.Edit;

/*
 * Created by demidovskiy-r on 06.03.14.
 */
public class AddNVergeDeliveryDestinationForm extends DestinationForm {
    private Edit email;

    public AddNVergeDeliveryDestinationForm(OrderItemPage parent) {
        super(parent);
    }

    @Override
    protected void initControls() {
        controls.put("Email", email = new Edit(parent, getControlLocatorByName("name")));
    }
}