package com.adstream.automate.babylon.core;

import com.adstream.automate.babylon.JsonObjects.Content;
import com.adstream.automate.babylon.JsonObjects.FileRevision;
import com.adstream.automate.utils.Common;

import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: savitskiy-a
 * Date: 23.07.13
 * Time: 18:54
 */
public abstract class AbstractTranscodingChecker {
    private long timeLimit = 5 * 60 * 1000; // 5 minutes
    private long checkInterval = 3 * 1000; // 3 seconds

    public abstract List<Content> getFiles();

    public void doActionWhileWaiting() { }

    public void process(boolean waitForPreview) {
        process(waitForPreview, -1);
    }

    public void process(boolean waitForPreview, int revision) {
        long deadline = System.currentTimeMillis() + getTimeLimit();
        while (!isSpecOrPreviewAvailable(waitForPreview, revision)) {
            if (System.currentTimeMillis() > deadline) {
                throw new Error("Timeout while waiting for " + (waitForPreview ? "preview" : "spec"));
            } else {
                doActionWhileWaiting();
            }
        }
    }

    public AbstractTranscodingChecker withTimeLimit(long timeLimit) {
        this.timeLimit = timeLimit;
        return this;
    }

    public long getTimeLimit() {
        return timeLimit;
    }

    public AbstractTranscodingChecker withCheckInterval(long checkInterval) {
        this.checkInterval = checkInterval;
        return this;
    }

    public long getCheckInterval() {
        return checkInterval;
    }

    private boolean isSpecOrPreviewAvailable(boolean waitForPreview, int revision) {
        for (Content file : getFiles()) {
            FileRevision fileRevision = revision > 0 ? file.getRevisions()[revision - 1] : file.getLastRevision();
            if (fileRevision.getMaster() == null
                    || (waitForPreview && couldBeTranscoded(fileRevision) && fileRevision.getPreview() == null)) {
                Common.sleep(getCheckInterval());
                return false;
            }
        }
        return true;
    }

    private boolean couldBeTranscoded(FileRevision revision)    {
        if(revision == null || !revision.getMaster().getSpecDbDocID().equals("f2:unknown-file-type")) {
            if (!revision.getMaster().getMetadata().get("fileName").toString().contains(".txt")) {
                if (!revision.getMaster().getMetadata().get("fileType").equals("SVG")) { return true; }
                else return false;
            }}
        return false;
    }
}
