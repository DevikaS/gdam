package com.adstream.automate.babylon.tests.steps.domain.ingest;

import com.mongodb.BasicDBObject;

import java.util.*;
import com.mongodb.DBCollection;

/**
 * Created by Ramababu.Bendalam on 16/08/2016.
 */
public class MongoDestinationCollection {

    public void setMongoDoc(Map<String,String> row, DBCollection schemaCollection){
        BasicDBObject query = new BasicDBObject();
        query.put("name", row.get("DestinationName"));
        BasicDBObject filter = new BasicDBObject();
        if (row.containsKey("statusID")) {
            filter.append("$set", new BasicDBObject().append("statusID", Integer.parseInt(row.get("statusID"))));
            schemaCollection.update(query,filter);}
        if(row.containsKey("HoldForApproval")){
            filter.append("$set", new BasicDBObject().append("holdForApproval",Boolean.parseBoolean(row.get("HoldForApproval"))));
            schemaCollection.update(query,filter);}
        if(row.containsKey("HouseNumberMandatory")){
            filter.append("$set", new BasicDBObject().append("houseNumberMandatory", Boolean.parseBoolean(row.get("HouseNumberMandatory"))));
            schemaCollection.update(query,filter);}
        if(row.containsKey("ProxyApprove")){
            filter.append("$set", new BasicDBObject().append("proxyApprove", Boolean.parseBoolean(row.get("ProxyApprove"))));
            schemaCollection.update(query,filter);}
        if(row.containsKey("ApprovalOnly")){
            filter.append("$set", new BasicDBObject().append("approvalOnly", Boolean.parseBoolean(row.get("ApprovalOnly"))));
            schemaCollection.update(query,filter);}
        }
}
