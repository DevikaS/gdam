package com.adstream.automate.babylon.sut.pages.ordering.elements.popup;

import com.adstream.automate.babylon.sut.pages.ordering.OrderItemPage;
import org.openqa.selenium.By;

/*
 * Created by demidovskiy-r on 10.11.2014.
 */
public class DeleteServicePopUp extends DeleteDestinationPopUp {
    public final static String TITLE = "Delete service";
    public final static String TITLE_NODE = generateTitleNode(TITLE);

    public DeleteServicePopUp(OrderItemPage parentPage, String title) {
        super(parentPage, title);
    }

    protected By getPopUpLocator() {
        return By.xpath(TITLE_NODE);
    }
}