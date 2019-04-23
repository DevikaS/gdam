package com.adstream.automate.babylon.logplayer;

import com.adstream.automate.utils.Common;
import org.joda.time.DateTime;
import org.joda.time.format.DateTimeFormat;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

/**
 * User: ruslan.semerenko
 * Date: 31.10.13 11:54
 */
public class LogPlayer {
    private static final String DATE_FORMAT = "YYYY-MM-dd HH:mm:ss";
    private static File mergedLogFile;
    private static File[] logFiles;
    private static int queueSize;
    private static int threadPoolSize;
    private static String desiredHost;
    private static DateTime dateTimeStart;
    private static DateTime executeFromDate;
    private static DateTime executeToDate;
    private static int factor = 1;
    private BufferedReader messagesReader;
    private ExecutorService executor;
    private DateTime firstMessageDate;

    /**
     *  vm args
     * -DqueueSize=100      optional, default 100. http requests queue size
     * -DthreadPoolSize=10  optional, default 10. thread pool for executing http requests
     * -DdesiredHost=       core host where logs should be played
     * -DdateTimeStart=     when to start playing logs
     * -DexecuteFromDate=   first message in log
     * -DexecuteToDate=     last message in log
     * -DmergedLogFile=     log file for merging several log files
     * -DlogFiles=          frontend log files. comma delimited
     * -Dfactor=            optional, default 1. how fast should be replay
     */
    public static void main(String[] args) throws Exception {
        readProperties();
        System.out.println("Merge log files");
        new LogParser().merge(mergedLogFile, logFiles);
        System.out.println("Start log player");
        new LogPlayer(mergedLogFile).play(executeFromDate, executeToDate);
    }

    private static void readProperties() {
        queueSize = Integer.parseInt(System.getProperty("queueSize", "100"));
        threadPoolSize = Integer.parseInt(System.getProperty("threadPoolSize", "10"));
        desiredHost = System.getProperty("desiredHost");
        if (desiredHost == null) {
            throw new RuntimeException("Please define system property 'desiredHost'");
        }

        String dateTimeStart = System.getProperty("dateTimeStart");
        if (dateTimeStart == null) {
            LogPlayer.dateTimeStart = new DateTime();
        } else {
            try {
                LogPlayer.dateTimeStart = DateTimeFormat.forPattern(DATE_FORMAT).parseDateTime(dateTimeStart);
            } catch (Exception e) {
                throw new RuntimeException("Please define system property 'dateTimeStart' in following format '" + DATE_FORMAT + "'");
            }
        }

        String executeFromDate = System.getProperty("executeFromDate");
        if (executeFromDate != null) {
            try {
                LogPlayer.executeFromDate = DateTimeFormat.forPattern(DATE_FORMAT).parseDateTime(executeFromDate);
            } catch (Exception e) {
                throw new RuntimeException("Please define system property 'executeFromDate' in following format '" + DATE_FORMAT + "'");
            }
        }

        String executeToDate = System.getProperty("executeToDate");
        if (executeToDate != null) {
            try {
                LogPlayer.executeToDate = DateTimeFormat.forPattern(DATE_FORMAT).parseDateTime(executeToDate);
            } catch (Exception e) {
                throw new RuntimeException("Please define system property 'executeToDate' in following format '" + DATE_FORMAT + "'");
            }
        }

        String mergedLogFile = System.getProperty("mergedLogFile");
        if (mergedLogFile == null) {
            throw new RuntimeException("Please define system property 'mergedLogFile'");
        } else {
            LogPlayer.mergedLogFile = new File(mergedLogFile);
        }

        String logFiles = System.getProperty("logFiles");
        if (logFiles == null) {
            throw new RuntimeException("Please define system property 'logFiles'");
        } else {
            String[] strings = logFiles.split(",");
            LogPlayer.logFiles = new File[strings.length];
            for (int i = 0; i < strings.length; i++) {
                LogPlayer.logFiles[i] = new File(strings[i]);
            }
        }

        String strFactor = System.getProperty("factor");
        if (strFactor != null) {
            try {
                int factor = Integer.parseInt(strFactor);
                if (factor < 1) {
                    factor = 1;
                }
                LogPlayer.factor = factor;
            } catch (NumberFormatException e) {
                throw new RuntimeException("System property 'factor' should be a digit");
            }
        }
    }

    public LogPlayer(File messagesFile) throws FileNotFoundException {
        messagesReader = new BufferedReader(new FileReader(messagesFile));
        executor = Executors.newFixedThreadPool(threadPoolSize);
        ExecutorJob.setPoolSize(threadPoolSize);
    }

    public void play() throws Exception {
        play(null, null);
    }

    public void play(DateTime fromDate, DateTime toDate) throws Exception {
        boolean hasMessages = true;
        do {
            while (hasMessages && queueSize - ExecutorJob.getEnqueuedJobsCount() > 0) {
                String strMessage = messagesReader.readLine();
                if (strMessage == null) {
                    hasMessages = false;
                } else {
                    Message message = LogParser.parseMessage(strMessage);
                    if (isPassedToDateInterval(message, fromDate, toDate)) {
                        message.setUrlHost(desiredHost);
                        executor.execute(new ExecutorJob(message, getDateStart(message)));
                    }
                }
            }
            Common.sleep(1000);
        } while(hasMessages);
        executor.shutdown();
        while (!executor.isTerminated()) {
            Common.sleep(1000);
        }
    }

    private boolean isPassedToDateInterval(Message message, DateTime fromDate, DateTime toDate) {
        return (fromDate == null || message.getDateTime().isAfter(fromDate))
                && (toDate == null || message.getDateTime().isBefore(toDate));
    }

    private DateTime getDateStart(Message message) {
        if (firstMessageDate == null) {
            firstMessageDate = message.getDateTime();
        }
        long timeDelta = (long) ((1 - 1.0 / factor) * (message.getDateTime().getMillis() - firstMessageDate.getMillis()));
        long timeShift = dateTimeStart.getMillis() - firstMessageDate.getMillis() - timeDelta;
        return message.getDateTime().plus(timeShift);
    }
}