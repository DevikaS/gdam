package com.adstream.automate.babylon.migration.utils;

import java.io.*;
import java.nio.file.Files;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: solomin-y
 * Date: 11/15/13
 * Time: 2:47 PM

 */
public class FileManager {

    public static void saveIntoFile(String fileName, String content) {
        File file = new File(fileName);
        FileWriter out = null;
        try {
            out = new FileWriter(file, true);
            out.write(content);
        } catch (IOException e) {
            e.printStackTrace();
        }
        finally {
            try {
                out.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

    public static void saveIntoFile(String fileName, String content, boolean isAppend) {
        File file = new File(fileName);
        FileWriter out = null;
        try {
            out = new FileWriter(file, isAppend);
            out.write(content);
        } catch (IOException e) {
            e.printStackTrace();
        }
        finally {
            try {
                out.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

    public static List<String> readTextFile(String fileName) {
        List<String> result = new LinkedList<>();
        try {
            BufferedReader in = new BufferedReader(new FileReader( new File(fileName).getAbsoluteFile()));
            try {
                String s;
                while ((s = in.readLine()) != null) {
                    result.add(s.trim());
                }
            } finally {
                in.close();
            }
        } catch(IOException e) {
            throw new RuntimeException(e);
        }
        return result;
    }

    public static void deleteAllFilesFromFolder(String folderName) {
        File file = new File(folderName);
        if (!file.isDirectory())
            throw new IllegalArgumentException("Path isn't a directory. Please set correct path");
        for (File deleteFile : file.listFiles()) {
            deleteFile.delete();
        }
    }

    public static File[] getFilesByExtension(String filePath, final String extension) {
        FileFilter fileFilter = new FileFilter() {
            @Override
            public boolean accept(File pathname) {
                return pathname.getName().endsWith(extension);  //To change body of implemented methods use File | Settings | File Templates.
            }
        };
        File file = new File(filePath);
        return file.listFiles(fileFilter);

    }

    public static void copyFiles(File source, File dest) throws IOException {
        Files.copy(source.toPath(), dest.toPath());
    }

}
