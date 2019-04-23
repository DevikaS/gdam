package com.adstream.automate.babylon.JsonObjects.comparator;

import com.adstream.automate.babylon.JsonObjects.Content;

import java.util.Comparator;

/**
 * User: ruslan.semerenko
 * Date: 19.07.12 17:09
 */
public class ComparatorContentByFileSize implements Comparator<Content> {
    @Override
    public int compare(Content c1, Content c2) {
        long s1 = c1.getLastRevision().getMaster().getFileSize();
        long s2 = c2.getLastRevision().getMaster().getFileSize();
        return (int) Math.signum(s1 - s2);
    }
}
