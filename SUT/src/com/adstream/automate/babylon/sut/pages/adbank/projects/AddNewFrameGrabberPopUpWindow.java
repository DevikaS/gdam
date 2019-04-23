package com.adstream.automate.babylon.sut.pages.adbank.projects;

import com.adstream.automate.babylon.sut.elements.controls.complex.PopUpWindow;
import com.adstream.automate.page.Page;
import com.adstream.automate.utils.Common;
import org.openqa.selenium.By;

/**
 * Created with IntelliJ IDEA.
 * User: solomin-y
 * Date: 11.10.12
 * Time: 17:46

 */
public class AddNewFrameGrabberPopUpWindow extends PopUpWindow {

    public AddNewFrameGrabberPopUpWindow(Page parentPage) {
        super(parentPage);
    }

    public void grabFrame(int grabCount){
        play();
    for(int i=0;i<grabCount;i++) {
        Common.sleep(1000);
        web.click(By.cssSelector("#grabFrame [tooltip=\"Capture Frame\"]"));
    }

    }
    public void close() {
       close.click();
    }


    public void play() {
     web.click(By.xpath(".//*[@id='controls-container']/button[3]"));
     }

    private By getPopUpWindowLocator() {
        return generateLocator("div[contains(title='Frame Grabber:')])");
    }
}