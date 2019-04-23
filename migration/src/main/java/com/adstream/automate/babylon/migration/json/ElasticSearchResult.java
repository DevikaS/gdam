package com.adstream.automate.babylon.migration.json;

import com.adstream.automate.babylon.JsonObjects.BaseObject;

/**
 * Created with IntelliJ IDEA.
 * User: solomin-y
 * Date: 7/7/14
 * Time: 12:49 PM

 */
public class ElasticSearchResult {
    Hits hits;

    /*BaseObject[] getResult() {
        return hits.getHits();
    } */

    public Hits getHits() {
        return hits;
    }

    public void setHits(Hits hits) {
        this.hits = hits;
    }
}
