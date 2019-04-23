package com.adstream.automate.babylon.performance;

import org.apache.log4j.FileAppender;

import java.util.Date;

/**
 * User: ruslan.semerenko
 * Date: 17.07.12 11:39
 */
public class NewFileRollingAppender extends FileAppender {
    @Override
    public void setFile(String file) {
        int index = file.lastIndexOf(".");
        String name = file.substring(0, index);
        String ext = file.substring(index + 1);
        file = name + String.format(".%1$tY-%1$tm-%1$td %1$tH-%1$tM-%1$tS.", new Date()) + ext;
        super.setFile(file);
    }
}
