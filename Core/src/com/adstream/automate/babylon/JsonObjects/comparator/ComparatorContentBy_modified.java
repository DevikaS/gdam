package com.adstream.automate.babylon.JsonObjects.comparator;

import com.adstream.automate.babylon.JsonObjects.Content;
import org.joda.time.DateTime;

import java.util.Comparator;

/**
 * Created by janaki.kamat on 26/06/2017.
 */
public class ComparatorContentBy_modified implements Comparator<Content> {
    public int compare(Content o1, Content o2) {
        DateTime d1 = getModified(o1);
        DateTime d2 = getModified(o2);
        return d1.compareTo(d2);
    }

    private DateTime getModified(Content content) {
        DateTime modifed = content.getModified();
        if (modifed == null) {
            modifed = content.getModified();
        }
        return modifed;
    }
}

