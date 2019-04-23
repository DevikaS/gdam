package com.adstream.automate.babylon;

import com.adstream.automate.babylon.JsonObjects.traffic.TrafficOrder;
import org.apache.log4j.Logger;

import java.io.UnsupportedEncodingException;
import java.net.URL;
import java.util.concurrent.atomic.AtomicInteger;

/**
 * Created by denysb on 23/06/2016.
 */
public class TrafficServiceWrapper {
    private static AtomicInteger uploadedFilesCount = new AtomicInteger(0);
    private Logger log = Logger.getLogger(this.getClass());
    private boolean loggedIn;
    private String loggedUserEmail;
    private TrafficService service;


    public TrafficServiceWrapper(TrafficService service) {
        this.service = service;
    }

    public String getVersion(){
        return service.getVersion();
    }

    public TrafficOrder getOrderItemByA4DeliveryId(String orderItemA4DeliveryId){
       return service.getOrderItemByA4DeliveryId(orderItemA4DeliveryId);
    }

    public boolean logIn(String email, String password, URL coreUrl) {
        loggedIn = service.auth(email, password, coreUrl) != null;
        loggedUserEmail = loggedIn ? email : null;
        return isLoggedIn();
    }

    public boolean isLoggedIn() {
        return loggedIn;
    }

    public String getLoggedUserEmail() {
        return loggedUserEmail;
    }

    public String setCommentTraffic(String orderId, String userId) throws UnsupportedEncodingException {
        return service.setCommentTraffic(orderId,userId);
    }


}
