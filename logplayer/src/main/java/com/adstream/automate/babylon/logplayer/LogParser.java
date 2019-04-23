package com.adstream.automate.babylon.logplayer;

import com.adstream.automate.babylon.JsonObjects.CustomMetadata;
import com.adstream.automate.utils.Common;
import com.google.gson.Gson;
import org.joda.time.DateTime;
import org.joda.time.format.DateTimeFormat;

import java.io.*;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * User: ruslan.semerenko
 * Date: 21.10.13 13:10
 */
public class LogParser {
    public static void main(String[] args) throws Exception {
        LogParser parser = new LogParser();
        File mergedFile = new File("C:\\Work\\Downloads\\logs\\merged.log");
        parser.merge(mergedFile,
                new File("C:\\Work\\Downloads\\logs\\babylon.log-1-20131103"),
                new File("C:\\Work\\Downloads\\logs\\babylon.log-20131103")
        );
        MessagesList messages = parser.parse(mergedFile);
        new Analyzer(messages).analyze();
        System.out.println("");
    }

    private static final Pattern DATE_PATTERN = Pattern.compile("^(\\d{4}-\\d{2}-\\d{2}) \\d{2}:\\d{2}:\\d{2}");
    private static final String DATE_FORMAT = "YYYY-MM-dd HH:mm:ss";
    private static Gson gson = new Gson();

    public void merge(File result, File... files) throws IOException {
        if (result.exists()) {
            return;
        }

        BufferedWriter writer = new BufferedWriter(new FileWriter(result));

        List<BufferedReader> readers = new ArrayList<>();
        for (File file : files) {
            readers.add(new BufferedReader(new FileReader(file)));
        }

        List<Message> currentMessages = new ArrayList<>();
        for (BufferedReader reader : readers) {
            String line;
            while ((line = reader.readLine()) != null) {
                Message message = parseMessage(line);
                if (message != null) {
                    currentMessages.add(message);
                    break;
                }
            }
        }

        int currentReaderIndex = getOldestMessageIndex(currentMessages);
        while (readers.size() > 0) {
            String line = readers.get(currentReaderIndex).readLine();
            Message message = parseMessage(line);
            if (line == null || message != null) {
                writer.write(currentMessages.get(currentReaderIndex).getOriginalMessage());
                writer.newLine();
                if (line == null) {
                    currentMessages.remove(currentReaderIndex);
                    readers.remove(currentReaderIndex).close();
                } else {
                    currentMessages.set(currentReaderIndex, message);
                }
                currentReaderIndex = getOldestMessageIndex(currentMessages);
            }
        }
        writer.flush();
        writer.close();
    }

    public MessagesList parse(File... files) throws Exception {
        MessagesList messages = new MessagesList();
        for (File file : files) {
            BufferedReader reader = new BufferedReader(new FileReader(file));
            String line;
            while ((line = reader.readLine()) != null) {
                Matcher matcher = DATE_PATTERN.matcher(line);
                if (matcher.find()) {
                    if (matcher.group(1).equals("2013-11-01")) {
                        Message message = parseMessage(line);
                        if (message != null
                                && !message.getPath().equals("/activity/notification/count")
                                && !message.getPath().startsWith("/fs/gdn/url/")) {
                            messages.add(message);
                            message.setType(guessMessageType(message));
                        }
                    }
                }
            }
        }
        Collections.sort(messages, new Comparator<Message>() {
            @Override
            public int compare(Message o1, Message o2) {
                return o1.getDateTime().compareTo(o2.getDateTime());
            }
        });
        return messages;
    }

    private int getOldestMessageIndex(List<Message> messages) {
        if (messages.isEmpty()) {
            return -1;
        }
        int oldest = 0;
        for (int i = 1; i < messages.size(); i++) {
            if (messages.get(i).getDateTime().isBefore(messages.get(oldest).getDateTime())) {
                oldest = i;
            }
        }
        return oldest;
    }

    protected static Message parseMessage(String strMessage) {
        try {
            return _parseMessage(strMessage);
        } catch (MalformedURLException e) {
            return null;
        }
    }

    private static Message _parseMessage(String strMessage) throws MalformedURLException {
        if (strMessage == null) {
            return null;
        }

        if (strMessage.contains("SAML")) {
            return null;
        }

        Matcher matcher = DATE_PATTERN.matcher(strMessage);
        if (!matcher.find()) {
            return null;
        }
        DateTime dateTime = DateTimeFormat.forPattern(DATE_FORMAT).parseDateTime(matcher.group(0));
        strMessage = strMessage.replaceAll("\\u001B\\[\\d{2}m", "");

        int start = strMessage.indexOf(" - ") + " - ".length();
        int end = strMessage.indexOf(":", start);
        String severity = strMessage.substring(start, end);
        if (!severity.matches("info|warning")) {
            return null;
        }

        if (severity.equals("warning")) {
            if (strMessage.contains("slowlog")) {
                return parseSlowLogMessage(strMessage, dateTime);
            } else {
                return null;
            }
        }

        if (strMessage.contains("info: core url:") && strMessage.contains("/fs/file/")) {
            return parseFsMessage(strMessage, dateTime);
        }

        start = strMessage.indexOf(" ", end) + 1;
        end = strMessage.indexOf(" ", start);
        String method = strMessage.substring(start, end);
        if (!method.matches("get|post|put|delete")) {
            return null;
        }

        start = end + 1;
        end = strMessage.indexOf(" ", start);
        String url = strMessage.substring(start, end);
        //todo: logged different. implement it
        if (url.endsWith("/logo/exists?")) {
            return null;
        }
        if (!url.startsWith("http")) {
            url = "http://dummy-host" + url;
        }

        start = strMessage.indexOf("body=", end) + "body=".length();
        String body = null;
        if (strMessage.charAt(start) == '{') {
            end = getJsonEnd(strMessage, start);
            body = strMessage.substring(start, end);
        }

        start = strMessage.indexOf("params=", end) + "params=".length();
        end = getJsonEnd(strMessage, start);
        String params;
        if (end < start) {
            if (strMessage.substring(start, start + 2).equals("[]")) {
                params = "{}";
            } else {
                return null;
            }
        } else {
            params = strMessage.substring(start, end);
        }

        Message message = new Message();
        message.setOriginalMessage(strMessage);
        message.setDateTime(dateTime);
        message.setSeverity(severity);
        message.setMethod(method);
        message.setUrl(new URL(Common.urlDecode(url).replace(" ", "%20")));
        message.setBody(gson.fromJson(body, CustomMetadata.class));
        message.setParams(gson.fromJson(params, CustomMetadata.class));
        return message;
    }

    private static Message parseSlowLogMessage(String strMessage, DateTime dateTime) throws MalformedURLException {
        int start = strMessage.indexOf(" - ") + " - ".length();
        int end = strMessage.indexOf(":", start);
        String severity = strMessage.substring(start, end);

        start = strMessage.indexOf("(slowlog): ", end) + "(slowlog): ".length();
        end = strMessage.indexOf(" ", start);
        String method = strMessage.substring(start, end);
        if (method.equals("Core")) {
            return null;
        }

        start = strMessage.indexOf("on ", end) + "on ".length();
        end = strMessage.indexOf(" ", start);
        String url = strMessage.substring(start, end);
        //todo: logged different. implement it
        if (url.endsWith("/logo/exists?")) {
            return null;
        }
        if (!url.startsWith("http")) {
            url = "http://dummy-host" + url;
        }

        start = strMessage.indexOf("params=", end) + "params=".length();
        end = getJsonEnd(strMessage, start);
        String params = strMessage.substring(start, end);

        start = strMessage.indexOf("requestBody=", end) + "requestBody=".length();
        String body = null;
        if (strMessage.charAt(start) == '{') {
            end = getJsonEnd(strMessage, start);
            body = strMessage.substring(start, end);
        }

        Message message = new Message();
        message.setOriginalMessage(strMessage);
        message.setDateTime(dateTime);
        message.setSeverity(severity);
        message.setMethod(method);
        message.setUrl(new URL(Common.urlDecode(url).replace(" ", "%20")));
        message.setBody(gson.fromJson(body, CustomMetadata.class));
        message.setParams(gson.fromJson(params, CustomMetadata.class));
        return message;
    }

    private static Message parseFsMessage(String strMessage, DateTime dateTime) throws MalformedURLException {
        int start = strMessage.indexOf(" - ") + " - ".length();
        int end = strMessage.indexOf(":", start);
        String severity = strMessage.substring(start, end);

        start = strMessage.indexOf("core url:  ", end) + "core url:  ".length();
        String url = strMessage.substring(start);

        CustomMetadata params = new CustomMetadata();
        for (String pair : url.split("\\?")[1].split("&")) {
            String[] keyValue = pair.split("=");
            params.put(keyValue[0], keyValue[1]);
        }

        Message message = new Message();
        message.setOriginalMessage(strMessage);
        message.setDateTime(dateTime);
        message.setSeverity(severity);
        message.setMethod("get");
        message.setUrl(new URL(Common.urlDecode(url).replace(" ", "%20")));
        message.setBody(null);
        message.setParams(params);
        return message;
    }

    private static int getJsonEnd(String strMessage, int start) {
        int end = start + 1;
        for (int brackets = 1; brackets > 0; end++) {
            if (end >= strMessage.length()) {
                return -1;
            }
            char c = strMessage.charAt(end);
            if (c == '{') {
                brackets++;
            } else if (c == '}') {
                brackets--;
            }
        }
        return end;
    }

    private MessageType guessMessageType(Message message) {
        String method = message.getMethod();
        switch (method) {
            case "get":
                return guessGetMessage(message);
            case "post":
                return guessPostMessage(message);
            case "delete":
                return guessDeleteMessage(message);
            case "put":
                return guessPutMessage(message);
            default:
                return MessageType.UNKNOWN;
        }
    }

    private MessageType guessGetMessage(Message message) {
        String path = message.getPath();
        if (path.equals("/project/find")) {
            return MessageType.FIND_PROJECTS;
        } else if (path.equals("/activity/find")) {
            return MessageType.FIND_ACTIVITY;
        } else if (path.equals("/activity/notification") || path.equals("/activity/file/uploaded")) {
            return MessageType.GET_ACTIVITIES;
        } else if (path.equals("/activity/notification/count")) {
            return MessageType.ACTIVITIES_COUNT;
        } else if (path.equals("/agency/find")) {
            return MessageType.FIND_AGENCY;
        } else if (path.equals("/agency/current")) {
            return MessageType.CURRENT_AGENCY;
        } else if (path.equals("/agency/team/find")) {
            return MessageType.FIND_AGENCY_TEAM;
        } else if (path.equals("/asset/filter/find")) {
            String with = message.getParams().getString("with");
            String type = message.getParams().getString("type");
            if (with == null) {
                return MessageType.GET_ASSET_FILTERS_DASHBOARD;
            } else if (type != null && type.equals("asset_filter_category")) {
                return MessageType.GET_ASSET_FILTERS_ADMIN;
            } else if (with.equals("permissions")) {
                return MessageType.GET_ASSET_FILTERS_LIBRARY;
            } else {
                return MessageType.UNKNOWN;
            }
        } else if (path.matches("/asset/filter/findby/groups/\\w+")) {
            return MessageType.FIND_ASSET_FILTER_BY_GROUP;
        } else if (path.matches("/asset/filter/findby/subject/\\w+")) {
            return MessageType.FIND_ASSET_FILTER_BY_SUBJECT;
        } else if (path.matches("/agency/team/project/\\w+")) {
            return MessageType.FIND_AGENCY_PROJECT_TEAM;
        } else if (path.matches("/agency/team/\\w+")) {
            return MessageType.GET_AGENCY_TEAM;
        } else if (path.matches("/asset/filter/\\w+/agencies")) {
            return MessageType.GET_ASSET_FILTER_AGENCIES;
        } else if (path.matches("/asset/filter/\\w+/subjects")) {
            return MessageType.GET_ASSET_FILTER_SUBJECTS;
        } else if (path.matches("/asset/filter/\\w+/groups")) {
            return MessageType.GET_ASSET_FILTER_GROUPS;
        } else if (path.matches("/agency/\\w+/fs")) {
            return MessageType.GET_AGENCY_FS;
        } else if (path.matches("/asset/find/\\w+")) {
            return MessageType.FIND_COLLECTION_ASSETS;
        } else if (path.matches("/asset/\\w+")) {
            return MessageType.OPEN_ASSET;
        } else if (path.matches("/dictionary/\\w+")) {
            return MessageType.GET_DICTIONARY;
        } else if (path.equals("/cluster/http/binding")) {
            return MessageType.GET_CLUSTER_HTTP_BINDING;
        } else if (path.equals("/comment/find")) {
            return MessageType.FIND_COMMENTS;
        } else if (path.equals("/comment/findByUser")) {
            return MessageType.FIND_COMMENTS_BY_USER;
        } else if (path.equals("/contact")) {
            return MessageType.GET_CONTACTS;
        } else if (path.matches("/easysharing/asset/find/\\w+")) {
            return MessageType.FIND_ASSET_EASYSHARE;
        } else if (path.matches("/easysharing/element/find/\\w+")) {
            return MessageType.FIND_ELEMENT_EASYSHARE;
        } else if (path.matches("/folder/\\w+/fs")) {
            return MessageType.GET_FOLDER_FS;
        } else if (path.equals("/fs/gdn/storages")) {
            return MessageType.GET_STORAGES;
        } else if (path.equals("/group/head")) {
            return MessageType.GROUP_HEAD;
        } else if (path.matches("/group/\\w+/children")) {
            String type = message.getParams().getString("type");
            if (type.equals("user_group")) {
                return MessageType.GET_USER_GROUP;
            } else if (type.equals("user")) {
                return MessageType.GET_TEAM_USERS;
            } else {
                return MessageType.UNKNOWN;
            }
        } else if (path.matches("/group/\\w+")) {
            return MessageType.GET_GROUP;
        } else if (path.equals("/gdam.net/api/approval/templates")) {
            return MessageType.GET_APPROVAL_TEMPLATES;
        } else if (path.equals("/gdam.net/api/approval/find")) {
            return MessageType.FIND_APPROVAL;
        } else if (path.matches("/gdam.net/api/annotation/[\\w-]+/\\w+/list")) {
            return MessageType.GET_ANNOTATION_LIST;
        } else if (path.matches("/gdam.net/api/approval/\\w+/[\\w-]+/check")) {
            return MessageType.CHECK_APPROVALS;
        } else if (path.matches("/gdam.net/api/approval/\\w+/revisions")) {
            return MessageType.GET_APPROVAL_REVISIONS;
        } else if (path.matches("/gdam.net/api/approval/\\w+/[\\w-]+(/\\w+)?")) {
            return MessageType.GET_APPROVAL;
        } else if (path.matches("/gdam.net/api/annotation/\\w+")) {
            return MessageType.GET_ANNOTATION;
        } else if (path.matches("/notification/user/\\w+/subscriptions")) {
            return MessageType.GET_USER_SUBSCRIPTIONS;
        } else if (path.equals("/project/template/find")) {
            return MessageType.FIND_TEMPLATES;
        } else if (path.equals("/project/undefined/content/find") || path.equals("/project/undefined/team/find")) {
            return MessageType.INVALID;
        } else if (path.matches("/project/\\w+/team/objects/\\w+")) {
            return MessageType.GET_PROJECT_TEAM_OBJECTS;
        } else if (path.matches("/project/\\w+/team")) {
            return MessageType.GET_PROJECT_TEAM;
        } else if (path.matches("/project/\\w+/team/owners")) {
            return MessageType.GET_PROJECT_OWNERS;
        } else if (path.matches("/project/\\w+/trash/files")) {
            return MessageType.GET_PROJECT_TRASH_FILES;
        } else if (path.matches("/project/\\w+/trash/folders")) {
            return MessageType.GET_PROJECT_TRASH_FOLDERS;
        } else if (path.matches("/project/content(/\\w+)?(/find/?)?")) {
            return MessageType.FIND_FOLDER_CONTENT;
        } else if (path.matches("/project/\\w+")) {
            return MessageType.OPEN_PROJECT;
        } else if (path.equals("/reel/find")) {
            long size = message.getParams().getLong("size");
            if (size == 5) {
                return MessageType.FIND_REELS_DASHBOARD;
            } else if (size == 999) {
                return MessageType.FIND_REELS_LIBRARY;
            } else {
                return MessageType.UNKNOWN;
            }
        } else if (path.equals("/role/find")) {
            return MessageType.FIND_ROLE;
        } else if (path.matches("/reel/\\w+/inccounter")) {
            return MessageType.GET_REEL_COUNTER;
        } else if (path.matches("/reel/\\w+/subjects")) {
            return MessageType.GET_REEL_SUBJECTS;
        } else if (path.matches("/reel/\\w+")) {
            return MessageType.OPEN_REEL;
        } else if (path.matches("/role/\\w+/acl/subjects") || path.matches("/role/acl/subjects/\\w+")) {
            return MessageType.GET_ROLE_SUBJECTS;
        } else if (path.matches("/schema/[\\w-]+")) {
            return MessageType.GET_SCHEMA;
        } else if (path.equals("/search")) {
            return MessageType.SEARCH;
        } else if (path.matches("/usage_rights/\\w+")) {
            return MessageType.GET_USAGE_RIGHTS;
        } else if (path.equals("/user/find")) {
            return MessageType.FIND_USER;
        } else if (path.equals("/user/current")) {
            return MessageType.CURRENT_USER;
        } else if (path.equals("/user/current/session")) {
            return MessageType.CURRENT_USER_SESSION;
        } else if (path.equals("/user/impersonate")) {
            return MessageType.IMPERSONATE;
        } else if (path.matches("/user/\\w+")) {
            return MessageType.GET_USER;
        } else {
            return MessageType.UNKNOWN;
        }
    }

    private MessageType guessPostMessage(Message message) {
        String path = message.getPath();
        if (path.equals("/user/auth")) {
            return MessageType.AUTH;
        } else if (path.matches("/agency/\\w+/roles/user/\\w+")) {
            return MessageType.SET_USER_ROLE;
        } else if (path.matches("/agency/\\w+/update")) {
            return MessageType.UPDATE_AGENCY;
        } else if (path.equals("/asset/easy")) {
            return MessageType.CREATE_ASSET;
        } else if (path.equals("/asset/filter")) {
            return MessageType.CREATE_ASSET_FILTER;
        } else if (path.matches("/asset/filter/\\w+/share")) {
            return MessageType.SHARE_ASSET_FILTER;
        } else if (path.equals("/asset/find")) {
            return MessageType.FIND_ASSET;
        } else if (path.equals("/comment")) {
            return MessageType.CREATE_COMMENT;
        } else if (path.equals("/contact")) {
            return MessageType.CREATE_CONTACT;
        } else if (path.equals("/easysharing/asset/share")) {
            return MessageType.SHARE_ASSET;
        } else if (path.equals("/easysharing/element/share")) {
            return MessageType.CREATE_EASYSHARE;
        } else if (path.matches("/gdam.net/api/annotation/[\\w-]+/save")) {
            return MessageType.CREATE_ANNOTATION;
        } else if (path.equals("/gdam.net/api/approval")) {
            return MessageType.CREATE_APPROVAL;
        } else if (path.matches("/gdam.net/api/approval/\\w+/stage")) {
            return MessageType.CREATE_APPROVAL_STAGE;
        } else if (path.matches("/group/\\w+/children")) {
            return MessageType.ADD_USER_TO_TEAM;
        } else if (path.equals("/plugins/nverge/download")) {
            return MessageType.DOWNLOAD_BY_NVERGE;
        } else if (path.equals("/project")) {
            return MessageType.CREATE_PROJECT;
        } else if (path.matches("/project/clone/\\w+")) {
            return MessageType.CLONE_PROJECT;
        } else if (path.matches("/project/content/easy/\\w+")) {
            return MessageType.CREATE_FILE;
        } else if (path.matches("/project/content/element/\\w+/file")) {
            return MessageType.CREATE_FILE_REVISION;
        } else if (path.matches("/project/content/\\w+")) {
            return MessageType.CREATE_FOLDER;
        } else if (path.equals("/reel")) {
            return MessageType.CREATE_REEL;
        } else if (path.equals("/reel/reelbyurl")) {
            return MessageType.SET_REEL_PUBLIC_URL;
        } else if (path.matches("/reel/\\w+/share")) {
            return MessageType.SHARE_REEL;
        } else if (path.matches("/reel/\\w+/urlgenerate")) {
            return MessageType.GENERATE_REEL_URL;
        } else if (path.matches("/user/into/\\w+")) {
            return MessageType.CREATE_USER;
        } else if (path.equals("/user/resetpassword")) {
            return MessageType.RESET_PASSWORD;
        } else {
            return MessageType.UNKNOWN;
        }
    }

    private MessageType guessDeleteMessage(Message message) {
        String path = message.getPath();
        if (path.matches("/activity/notification/\\w+")) {
            return MessageType.DELETE_ACTIVITY;
        } else if (path.matches("/agency/team/\\w+")) {
            return MessageType.DELETE_AGENCY_TEAM;
        } else if (path.matches("/asset/filter/\\w+")) {
            return MessageType.DELETE_ASSET_FILTER;
        } else if (path.matches("/asset/\\w+")) {
            return MessageType.DELETE_ASSET;
        } else if (path.matches("/contact/\\w+(/[\\w\\s]+)?")) {
            return MessageType.DELETE_CONTACT;
        } else if (path.matches("/group/\\w+")) {
            return MessageType.DELETE_GROUP;
        } else if (path.matches("/project/content/\\w+")) {
            return MessageType.DELETE_CONTENT;
        } else if (path.matches("/project/\\w+/team/users/\\w+")) {
            return MessageType.DELETE_PROJECT_TEAM_USERS;
        } else if (path.matches("/project/\\w+")) {
            return MessageType.DELETE_PROJECT;
        } else {
            return MessageType.UNKNOWN;
        }
    }

    private MessageType guessPutMessage(Message message) {
        String path = message.getPath();
        if (path.matches("/activity/notification/hasRead/\\w+")) {
            return MessageType.UPDATE_ACTIVITY;
        } else if (path.equals("/activity/log")) {
            return MessageType.CREATE_ACTIVITY;
        } else if (path.matches("/agency/team/\\w+")) {
            return MessageType.UPDATE_AGENCY_TEAM;
        } else if (path.matches("/asset/filter/\\w+")) {
            return MessageType.UPDATE_ASSET_FILTER;
        } else if (path.matches("/asset/\\w+/element/move")) {
            return MessageType.MOVE_ASSET_TO_PROJECT;
        } else if (path.matches("/asset/\\w+")) {
            return MessageType.UPDATE_ASSET;
        } else if (path.matches("/dictionary/\\w+")) {
            return MessageType.UPDATE_DICTIONARY;
        } else if (path.matches("/gdam.net/api/approval/\\w+/status")) {
            return MessageType.UPDATE_APPROVAL_STATUS;
        } else if (path.matches("/gdam.net/api/approval/\\w+/stage/\\w+/member/status")) {
            return MessageType.UPDATE_APPROVAL_STAGE_MEMBER_STATUS;
        } else if (path.matches("/notification/user/\\w+/subscriptions")) {
            return MessageType.UPDATE_USER_SUBSCRIPTIONS;
        } else if (path.matches("/project/content/\\w+/copy")) {
            return MessageType.COPY_FILE;
        } else if (path.matches("/project/content/\\w+/move")) {
            return MessageType.MOVE_FILE;
        } else if (path.matches("/project/content/\\w+")) {
            return MessageType.UPDATE_FILE;
        } else if (path.matches("/project/\\w+")) {
            return MessageType.UPDATE_PROJECT;
        } else if (path.equals("/project/team")) {
            return MessageType.UPDATE_PROJECT_TEAM;
        } else if (path.matches("/reel/\\w+/add")) {
            return MessageType.ADD_ASSET_TO_REEL;
        } else if (path.matches("/reel/\\w+/reorder")) {
            return MessageType.REORDER_REEL;
        } else if (path.matches("/reel/\\w+")) {
            return MessageType.UPDATE_REEL;
        } else if (path.matches("/schema/\\w+")) {
            return MessageType.UPDATE_SCHEMA;
        } else if (path.equals("/user/current/session")) {
            return MessageType.UPDATE_CURRENT_USER_SESSION;
        } else if (path.matches("/user/\\w+")) {
            return MessageType.UPDATE_USER;
        } else {
            return MessageType.UNKNOWN;
        }
    }
}

