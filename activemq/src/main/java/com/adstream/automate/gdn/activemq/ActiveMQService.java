package com.adstream.automate.gdn.activemq;

import org.apache.activemq.ActiveMQConnection;
import org.apache.activemq.ActiveMQConnectionFactory;
import org.apache.activemq.broker.Broker;
import org.apache.activemq.broker.BrokerService;
import org.apache.activemq.pool.PooledConnectionFactory;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import javax.jms.*;
import java.net.URISyntaxException;


/**
 * Created with IntelliJ IDEA.
 * User: savitskiy-a
 * Date: 14.03.13
 * Time: 13:25
 * To change this template use File | Settings | File Templates.
 */
public class ActiveMQService implements ExceptionListener {
    protected final static Logger log = LoggerFactory.getLogger(ActiveMQService.class);
    protected String activemqUrl = null;
    private BrokerService broker = null;
    private ActiveMQConnectionFactory connectionFactory;
    private Connection connection;

    public ActiveMQService(String activemqUrl) {
        this.activemqUrl = activemqUrl;
    }

    public ActiveMQService(BrokerService broker) {
        this.broker = broker;
    }

    protected Connection getConnection() throws JMSException {
        if (connection == null) {
            if (null != activemqUrl)
             this.connectionFactory = new ActiveMQConnectionFactory(activemqUrl);
            if (null != broker)
             this.connectionFactory = new ActiveMQConnectionFactory(String.format("vm://%s", broker.getBrokerName()));
             connection = connectionFactory.createConnection();
             connection.start();
             connection.setExceptionListener(this);
             }
        return connection;
    }

    public void closeConnection() throws JMSException {
        connection.close();
    }

    public synchronized void onException(JMSException ex) {
        log.error("JMS Exception occured.  Shutting down client. " + Thread.currentThread().getName(), ex);
    }

    public Consumer createConsumer(Destination inQ) throws JMSException {
        return new Consumer(getConnection(), inQ);
    }
    public Producer createProducer() throws JMSException {
        return new Producer(getConnection());
    }


}
