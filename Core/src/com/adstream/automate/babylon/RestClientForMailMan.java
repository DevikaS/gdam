package com.adstream.automate.babylon;

import com.adstream.automate.utils.EmailMessage;
import com.adstream.automate.utils.ImapClientInterface;
import com.google.gson.reflect.TypeToken;
import org.apache.http.client.methods.HttpDelete;
import org.apache.http.client.methods.HttpGet;

import java.lang.reflect.Type;
import java.net.URL;
import java.util.*;

/**
 * User: savitskiy-a
 * Date: 08.11.12 13:13
 */
public class RestClientForMailMan extends BabylonMessageSender implements ImapClientInterface {
    public RestClientForMailMan(URL baseUrl) {
        super(baseUrl);
    }

    public EmailMessage getLastUnreadMailBySubject(String subject) {
        HashMap<String, String> request = new HashMap<>();
        request.put("subject", subject);
        return getLastMessage(request);
    }

    public EmailMessage getLastUnreadMailBySubjectWithoutDeleting(String subject) {
        return getLastUnreadMailBySubject(subject);
    }

    public EmailMessage getLastUnreadMailByBody(String body) {
        HashMap<String, String> request = new HashMap<>();
        request.put("body", body);
        return getLastMessage(request);
    }

    public EmailMessage getLastUnreadMailByHeader(String headerName, String pattern) {
        HashMap<String, String> request = new HashMap<>();
        request.put(headerName, pattern);
        return getLastMessage(request);
    }

    public List<EmailMessage> getUnreadMailsByHeaderAndSubject(String headerName, String pattern, String subject) {
        HashMap<String, String> request = new HashMap<>();
        request.put(headerName, pattern);
        request.put("subject", subject);
        return getAllMessages(request);
    }

    public List<EmailMessage> getUnreadMailsBySubjectWithoutDeleting(String headerName, String pattern, String subject) {
        return getUnreadMailsByHeaderAndSubject(headerName, pattern, subject);
    }

    public EmailMessage getLastUnreadMailByHeaderAndSubject(String headerName, String pattern, String subject) {
        HashMap<String, String> request = new HashMap<>();
        request.put(headerName, pattern);
        request.put("subject", subject);
        return getLastMessage(request);
    }

    public EmailMessage getLastUnreadMailBySubjectWithoutDeleting(String headerName, String pattern, String subject) {
        return getLastUnreadMailByHeaderAndSubject(headerName, pattern, subject);
    }

    public EmailMessage getLastUnreadMailByHeaderSubjectAndBody(
            String headerName, String pattern, String subject, String body) {
        HashMap<String, String> request = new HashMap<>();
        request.put(headerName, pattern);
        request.put("subject", subject);
        request.put("body", body);
        return getLastMessage(request);
    }

    public synchronized void deleteAllMessages() {
        HttpDelete request = new HttpDelete(baseUrl + "mailman/emails");
        sendRequest(request);
    }

    private synchronized EmailMessage getLastMessage() {
        HttpGet request = new HttpGet(baseUrl + "mailman/emails/last");
        return sendRequest(request, EmailMessage.class);
    }

    private synchronized EmailMessage getLastMessage(HashMap<String, String> params) {
      List <EmailMessage> emails = getAllMessages(params);
      return emails.isEmpty() ? null : emails.get(emails.size()- 1);
    }

    private synchronized List<EmailMessage> getAllMessages(HashMap<String, String> params) {
        HttpGet request = new HttpGet(baseUrl + "mailman/emails?" + createQueryString(params));
        Type returnType = new TypeToken<Vector<EmailMessage>>() {
        }.getType();
        return sendRequest(request, returnType);
    }
}