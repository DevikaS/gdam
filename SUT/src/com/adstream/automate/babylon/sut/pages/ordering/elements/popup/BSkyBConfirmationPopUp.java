package com.adstream.automate.babylon.sut.pages.ordering.elements.popup;

import com.adstream.automate.babylon.sut.pages.ordering.OrderItemPage;
import com.adstream.automate.page.controls.Checkbox;
import com.adstream.automate.page.controls.Link;
import org.openqa.selenium.By;

/*
 * Created by demidovskiy-r on 03.02.2015.
 */
public class BSkyBConfirmationPopUp extends AbstractPopUp {
    public final static String TITLE = "Alert";
    public final static String TITLE_NODE = generateTitleNode(TITLE);
    private Checkbox agree;

    public BSkyBConfirmationPopUp(OrderItemPage parentPage, String title) {
        super(parentPage, title);
        cancel = new Link(parentPage, generateLocator("+ * [data-id='no']"));
        agree = new Checkbox(parentPage, By.name("agree"));
    }

    @Override
    protected void loadPopUp() {
        web.waitUntilElementAppearVisible(getPopUpLocator());
    }

    @Override
    protected void unloadPopUp() {
        web.waitUntilElementDisappear(getPopUpLocator());
    }

    public void confirmReading(boolean isConfirmed) {
        agree.setSelected(isConfirmed);
    }

    protected By getPopUpLocator() {
        return By.xpath(TITLE_NODE);
    }
}