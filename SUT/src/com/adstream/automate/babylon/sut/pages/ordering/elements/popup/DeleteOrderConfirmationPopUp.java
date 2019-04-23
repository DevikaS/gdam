package com.adstream.automate.babylon.sut.pages.ordering.elements.popup;

import com.adstream.automate.babylon.sut.pages.ordering.OrderingPage;
import org.openqa.selenium.By;

/**
 * Created with IntelliJ IDEA.
 * User: demidovskiy-r
 * Date: 02.09.13
 * Time: 19:04
 */
public class DeleteOrderConfirmationPopUp extends AbstractPopUp {
    public final static String TITLE = "Are you sure you want to proceed?";
    public final static String TITLE_NODE = generateTitleNode(TITLE);

    public DeleteOrderConfirmationPopUp(OrderingPage parentPage, String title) {
        super(parentPage, title);
    }

    @Override
    protected void loadPopUp() {
        web.waitUntilElementAppearVisible(getPopUpLocator());
    }

    @Override
    protected void unloadPopUp() {
        web.waitUntilElementDisappear(getPopUpLocator());
    }

    public String getContent() {
        return web.findElement(By.cssSelector(parentElement + "+ * .content")).getText()
                                                                          .replaceAll("\n", " ")
                                                                          .replaceAll("\t", " ")
                                                                          .replaceAll("  ", " ")
                                                                          .trim();
    }
}