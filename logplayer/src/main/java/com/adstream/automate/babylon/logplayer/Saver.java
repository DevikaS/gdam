package com.adstream.automate.babylon.logplayer;

import com.adstream.automate.utils.IO;
import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import org.sqlite.JDBC;

import java.io.File;
import java.io.FileNotFoundException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.List;
import java.util.UUID;

/**
 * User: ruslan.semerenko
 * Date: 03.01.14 15:46
 */
public class Saver {
    private MessageTree messageTree;

    public Saver(MessageTree messageTree) {
        this.messageTree = messageTree;
    }

    public void saveJson(File file) {
        try {
            IO.writeStringToFile(messageTreeToJson(messageTree).toString(), file.getPath());
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        }
    }

    public void saveSQLite(File file) {
        try {
            DriverManager.registerDriver(new JDBC());
            Connection connection = DriverManager.getConnection("jdbc:sqlite:" + file.getPath().replace("\\", "/"));
            Statement stmt = connection.createStatement();
            prepareTables(stmt);
            writeDataIntoDb(stmt, messageTree, null);
            stmt.close();
            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private JsonObject messageTreeToJson(MessageTree tree) {
        JsonObject message = new JsonObject();
        if (tree.getMessage() != null) {
            message.addProperty("type", tree.getMessage().getType().toString());
            message.addProperty("method", tree.getMessage().getMethod());
            message.addProperty("path", tree.getMessage().getPath());
        }

        JsonArray users = new JsonArray();
        for (String userId : tree.getUsers().keySet()) {
            JsonObject user = new JsonObject();
            user.addProperty("id", userId);
            user.addProperty("count", tree.getUsers().get(userId));
            user.add("time", new Gson().toJsonTree(tree.getUserTimes().get(userId)));
            users.add(user);
        }

        JsonArray branches = new JsonArray();
        for (MessageTree subTree : tree.getBranches().keySet()) {
            JsonObject branch = new JsonObject();
            branch.add("branch", messageTreeToJson(subTree));
            branch.addProperty("count", tree.getBranches().get(subTree));
            branches.add(branch);
        }

        JsonObject obj = new JsonObject();
        obj.add("message", message);
        obj.add("users", users);
        if (branches.size() > 0) {
            obj.add("branches", branches);
        }

        return obj;
    }

    private void prepareTables(Statement stmt) throws SQLException {
        stmt.executeUpdate("DROP TABLE IF EXISTS messages");
        stmt.executeUpdate("DROP TABLE IF EXISTS users");
        stmt.executeUpdate("CREATE TABLE messages (id TEXT PRIMARY KEY, parent_id TEXT, type TEXT, method TEXT, path TEXT)");
        stmt.executeUpdate("CREATE TABLE users (id TEXT PRIMARY KEY, user_id TEXT, message_id TEXT, time INTEGER)");
    }

    private void writeDataIntoDb(Statement stmt, MessageTree tree, String parentId) throws SQLException {
        Message message = tree.getMessage();
        String messageId = null;
        if (message != null) {
            messageId = UUID.randomUUID().toString();
            stmt.executeUpdate(String.format("INSERT INTO messages VALUES (\"%s\", \"%s\", \"%s\", \"%s\", \"%s\")",
                    messageId, parentId, message.getType().toString(), message.getMethod(), message.getPath()));
            StringBuilder values = new StringBuilder();
            for (String userId : tree.getUsers().keySet()) {
                for (long time : tree.getUserTimes().get(userId)) {
                    if (values.length() > 0) {
                        values.append("UNION ALL ");
                    }
                    values.append("SELECT \"").append(UUID.randomUUID().toString()).append("\",");
                    values.append("\"").append(userId).append("\",");
                    values.append("\"").append(messageId).append("\",");
                    values.append(time).append(" ");
                    if (values.length() > 50000) {
                        stmt.executeUpdate("INSERT INTO users (id, user_id, message_id, time) " + values.toString());
                        values = new StringBuilder();
                    }
                }
            }
            if (values.length() > 0) {
                stmt.executeUpdate("INSERT INTO users (id, user_id, message_id, time) " + values.toString());
            }
        }
        for (MessageTree subTree : tree.getBranches().keySet()) {
            writeDataIntoDb(stmt, subTree, messageId);
        }
    }
}
