package com.adstream.automate.babylon.tests.performance;

import com.adstream.automate.utils.Common;
import org.apache.log4j.PropertyConfigurator;

import java.net.URL;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.Callable;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.Future;

/**
 * User: ruslan.semerenko
 * Date: 16.07.13 21:07
 */
public class WorkflowRunner {
    private static URL appUrl;
    private static URL coreUrl;
    private static String login;
    private static String password;
    private static int threadsCount;
    private static int workflowIterations;

    public static void main(String[] args) throws Exception {
        PropertyConfigurator.configure("Tests\\resources\\log4j.properties");
        parseArgs(args);
        List<Future<WorkflowActionStats>> futures = new ArrayList<Future<WorkflowActionStats>>();
        ExecutorService executor = Executors.newFixedThreadPool(threadsCount);
        for (int i = 0; i < workflowIterations; i++) {
            futures.add(executor.submit(new Callable<WorkflowActionStats>() {
                @Override
                public WorkflowActionStats call() throws Exception {
//                    Workflow workflow = new WBSearchWorkflow(appUrl, coreUrl, login, password);
                    Workflow workflow = new CreateProjectWithManyFoldersWorkflow(appUrl, coreUrl, login, password);
                    WorkflowActionStats stats = workflow.perform();
                    workflow.quit();
                    return stats;
                }
            }));
        }
        executor.shutdown();
        while (!executor.isTerminated()) {
            Common.sleep(1000);
        }
        writeResult(futures);
    }

    private static void parseArgs(String[] args) throws Exception {
//        appUrl = new URL("http://perfa5.adstream.com");
//        coreUrl = new URL("http://10.64.130.10:8080");
        appUrl = new URL("http://10.0.26.17");
        coreUrl = new URL("http://10.0.26.17:8080");
        login = "agencyadmin@test.com";
        password = "1";
        threadsCount = 4;
        workflowIterations = 1;
    }

    private static void writeResult(List<Future<WorkflowActionStats>> futures) throws Exception {
        Map<String, List<WorkflowActionPageStats>> result = prepareResult(futures);
        StringBuilder out = new StringBuilder("Page\t\tRequests\tTime\r\n");
        for (Map.Entry<String, List<WorkflowActionPageStats>> entry : result.entrySet()) {
            out.append(entry.getKey());
            for (WorkflowActionPageStats stat : entry.getValue()) {
                out.append("\t\t").append(stat.getRequestsCount());
                out.append("\t").append(stat.getLoadTime());
            }
            out.append("\r\n");
        }
        System.out.println(out.toString());
    }

    private static Map<String, List<WorkflowActionPageStats>> prepareResult(List<Future<WorkflowActionStats>> futures) throws Exception {
        Map<String, List<WorkflowActionPageStats>> result = new LinkedHashMap<String, List<WorkflowActionPageStats>>();
        for (Future<WorkflowActionStats> future : futures) {
            WorkflowActionStats stats = future.get();
            for (String page : stats.getPages()) {
                List<WorkflowActionPageStats> list = result.get(page);
                if (list == null) {
                    list = new ArrayList<WorkflowActionPageStats>();
                    result.put(page, list);
                }
                list.add(stats.getForPage(page));
            }
        }
        return result;
    }
}
