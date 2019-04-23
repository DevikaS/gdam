package com.adstream.automate.babylon;

import com.adstream.automate.babylon.JsonObjects.traffic.TrafficOrder;

import java.io.UnsupportedEncodingException;
import java.net.URL;
import java.util.Map;

/**
 * Created by denysb on 23/06/2016.
 */
public interface TrafficService {

    public String getVersion();
    public String auth(String email, String password,URL coreUrl);
    public TrafficOrder getOrderItemByA4DeliveryId(String orderItemA4ID);
    public String setCommentTraffic(String orderId, String userId) throws UnsupportedEncodingException;


}
