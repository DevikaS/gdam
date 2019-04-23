package com.adstream.automate.babylon.sut.pages.flowplayer;

import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.page.flowplayer.FlowPlayerProxy;

/**
 * Created by Geethanjali.Raja on 23/03/2016.
 */
public class FlowAutoPlayer extends FlowPlayerProxy {
    private Boolean html5;

    public FlowAutoPlayer(ExtendedWebDriver webDriver) {

        super(webDriver);
    }

    public boolean isPlaying() {
        if(this.getState() == 3) {
            return true;
        }else{
            return false ;
        }
    }

    private boolean isHtml5() {
        if(this.html5 == null) {
            this.html5 = Boolean.valueOf(this.doCustomCommand("html5_element", new Object[0]) != null);
        }

        return this.html5.booleanValue();
    }
    private int getState() {
        return ((Long)this.doCommand("getState", new Object[0])).intValue();
    }
}
