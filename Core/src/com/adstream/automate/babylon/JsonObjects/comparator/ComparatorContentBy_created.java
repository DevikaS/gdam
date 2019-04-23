package com.adstream.automate.babylon.JsonObjects.comparator;

import com.adstream.automate.babylon.JsonObjects.Content;
import org.joda.time.DateTime;

import java.util.Comparator;

/**
 * Created with IntelliJ IDEA.
 * User: solomin-y
 * Date: 28.09.12
 * Time: 10:00
 */
public class ComparatorContentBy_created implements Comparator<Content> {
    public int compare(Content o1, Content o2) {
        DateTime d1 = getCreated(o1);
        DateTime d2 = getCreated(o2);
        return d1.compareTo(d2);
    }

    private DateTime getCreated(Content content) {
        DateTime created = content.getLastRevision().getMaster().getCreated();
        if (created == null) {
            created = content.getCreated();
        }
        return created;
    }
}
