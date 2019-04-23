package com.adstream.automate.babylon.logplayer;

import com.adstream.automate.babylon.JsonObjects.CustomMetadata;
import org.joda.time.DateTime;

import java.net.MalformedURLException;
import java.net.URL;

/**
 * User: ruslan.semerenko
 * Date: 23.10.13 11:43
 */
class Message {
    private String originalMessage;
    private MessageType type;
    private DateTime dateTime;
    private String severity;
    private String method;
    private URL url;
    private CustomMetadata body;
    private CustomMetadata params;

    public String getOriginalMessage() {
        return originalMessage;
    }

    public void setOriginalMessage(String originalMessage) {
        this.originalMessage = originalMessage;
    }

    public MessageType getType() {
        return type;
    }

    public void setType(MessageType type) {
        this.type = type;
    }

    public DateTime getDateTime() {
        return dateTime;
    }

    public void setDateTime(DateTime dateTime) {
        this.dateTime = dateTime;
    }

    public String getSeverity() {
        return severity;
    }

    public void setSeverity(String severity) {
        this.severity = severity;
    }

    public String getMethod() {
        return method;
    }

    public void setMethod(String method) {
        this.method = method;
    }

    public URL getUrl() {
        return url;
    }

    public void setUrl(URL url) {
        this.url = url;
    }

    public void setUrlHost(String host) {
        StringBuilder newUrl = new StringBuilder();
        newUrl.append(url.getProtocol()).append("://").append(host);
        if (url.getPort() != -1) {
            newUrl.append(":").append(url.getPort());
        }
        newUrl.append(url.getFile());
        try {
            setUrl(new URL(newUrl.toString()));
        } catch(MalformedURLException e) {
            e.printStackTrace();
        }
    }

    public String getPath() {
        return getUrl().getPath();
    }

    public CustomMetadata getBody() {
        return body;
    }

    public void setBody(CustomMetadata body) {
        this.body = body;
    }

    public CustomMetadata getParams() {
        return params;
    }

    public void setParams(CustomMetadata params) {
        this.params = params;
    }

    public String getUserId() {
        return getParams().getString("$id$");
    }

    @Override
    public String toString() {
        return getType() + " (" + getMethod() + " " + getPath() + ")";
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof Message)) return false;

        Message message = (Message) o;

        if (!method.equals(message.method)) return false;
        if (!getPath().equals(message.getPath())) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = method.hashCode();
        result = 31 * result + getPath().hashCode();
        return result;
    }
}
