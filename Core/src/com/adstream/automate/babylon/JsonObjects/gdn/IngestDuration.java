package com.adstream.automate.babylon.JsonObjects.gdn;

/**
 * Created by Ramababu.Bendalam on 27/04/2016.
 */
public class IngestDuration {

    private int adDurationInFrames;
    private int fullDurationInFrames;
    private int firstActiveFrame;

    public int getAdDurationInFrames() {
        return adDurationInFrames;
    }

    public void setAdDurationInFrames(int adDurationInFrames) {
        this.adDurationInFrames = adDurationInFrames;
    }

    public int getFullDurationInFrames() {
        return fullDurationInFrames;
    }

    public void setFullDurationInFrames(int fullDurationInFrames) {
        this.fullDurationInFrames = fullDurationInFrames;
    }

    public int getFirstActiveFrame() {
        return firstActiveFrame;
    }

    public void setFirstActiveFrame(int firstActiveFrame) {
        this.firstActiveFrame = firstActiveFrame;
    }
}
