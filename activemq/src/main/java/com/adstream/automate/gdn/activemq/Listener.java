package com.adstream.automate.gdn.activemq;

import javax.jms.*;
import java.util.concurrent.BlockingQueue;

/**
 * Created with IntelliJ IDEA.
 * User: savitskiy-a
 * Date: 19.03.13
 * Time: 12:58
 * To change this template use File | Settings | File Templates.
 */
public abstract class Listener extends LoggingListener {
    private final BlockingQueue<TextMessage> drop;

    protected Listener(BlockingQueue<TextMessage> q) {
        this.drop = q;
    }

    public void onMessage(TextMessage message) {
        try {
            drop.put(message);
        } catch (InterruptedException e) {
            log.error(e.toString());
        }

    }
}
