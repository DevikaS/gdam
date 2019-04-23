package com.adstream.automate.babylon.sut.pages.traffic.element;
import com.adstream.automate.babylon.sut.elements.controls.complex.PopUpWindow;
import com.adstream.automate.page.Page;
import com.adstream.automate.page.controls.Span;
import org.openqa.selenium.By;


/**
 * Created by Janaki.Kamat on 18/01/2017.
 */
public class TrafficWalkMePopup extends PopUpWindow {

    private static final By popupId = By.cssSelector("[id='walkme-overlay-all']");
    private static final By closeButtonId= By.cssSelector("[class^='wm-close-button']");
    private Span popup;
    private Span closeButton;

    public TrafficWalkMePopup(Page parentPage) {
        super(parentPage);
        popup = new Span(parentPage, popupId);
        closeButton= new Span(parentPage,closeButtonId);
      }

    public boolean presenceOfPopup(){
        return popup.isVisible();
    }
    protected By generateLocator() {
        return popupId;
    }
    public void clickClose(){
        closeButton.click();
    }

}
