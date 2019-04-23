package com.adstream.automate.babylon.JsonObjects.gdn;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by Ramababu.Bendalam on 28/04/2016.
 */
public class JsonBase {

    protected static Date extractDate(Map<String,Date> mappedDate){
        return mappedDate.get("$dt");
    }
    protected static Map<String, Date> insertDate(Date date){
        Map<String, Date>result  = new HashMap<String,Date>();
        result.put("$dt",date);
        return result;
    }
}
