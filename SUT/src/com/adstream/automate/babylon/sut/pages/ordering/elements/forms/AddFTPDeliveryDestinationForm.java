package com.adstream.automate.babylon.sut.pages.ordering.elements.forms;

import com.adstream.automate.babylon.sut.pages.ordering.OrderItemPage;
import com.adstream.automate.page.controls.Edit;

/*
 * Created by demidovskiy-r on 12.02.14.
 */
public class AddFTPDeliveryDestinationForm extends DestinationForm {
    private Edit ftpDestinationName;
    private Edit contactDetails;
    private Edit ftpHostName;
    private Edit ftpUserName;
    private Edit ftpPassword;
    private Edit ftpPath;

    public AddFTPDeliveryDestinationForm(OrderItemPage parent) {
        super(parent);
    }

    @Override
    protected void initControls() {
        controls.put("FTP Destination Name", ftpDestinationName = new Edit(parent, getControlLocatorByName("name")));
        controls.put("Contact Details", contactDetails = new Edit(parent, getControlLocatorByName("contactDetails")));
        controls.put("FTP Host Name", ftpHostName = new Edit(parent, getControlLocatorByName("hostName")));
        controls.put("FTP User Name", ftpUserName = new Edit(parent, getControlLocatorByName("userName")));
        controls.put("FTP Password", ftpPassword = new Edit(parent, getControlLocatorByName("pass")));
        controls.put("FTP Path", ftpPath = new Edit(parent, getControlLocatorByName("path")));
    }
}