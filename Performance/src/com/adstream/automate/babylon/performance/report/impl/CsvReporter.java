package com.adstream.automate.babylon.performance.report.impl;

import com.adstream.automate.babylon.performance.report.*;
import org.apache.commons.io.IOUtils;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.*;

/**
 * User: ruslan.semerenko
 * Date: 23.07.12 12:30
 */
public class CsvReporter implements Reporter {
    private List<ReportTest> tests = new ArrayList<>();

    public List<ReportTest> getTests() {
        return tests;
    }

    public void setTests(List<ReportTest> tests) {
        this.tests = tests;
    }

    public void addTest(ReportTest reportTest) {
        tests.add(reportTest);
    }

    public void writeReport() {
        List<List<String>> table = new ArrayList<>();
        for (ReportTest test : tests) {
            table.add(Arrays.asList(test.name()));
            if (!test.enabled()) {
                table.add(Arrays.asList("DISABLED"));
                continue;
            }
            Set<String> additionalColumns = new LinkedHashSet<>();
            for (ReportThreadingTest item : test.javaThreadingTests())
                if (additionalColumns.size() < item.partialTimes().keySet().size())
                    additionalColumns = item.partialTimesJavaKeySet();
            table.addAll(getHeaders(additionalColumns));
            Iterator<ReportThreadingTest> threadingIterator = test.javaThreadingTests().iterator();
            Iterator<Long> degradationIterator = test.javaDegradationTest().keySet().iterator();
            Iterator<ReportComplexTest> complexIterator = test.javaComplexTests().iterator();
            Iterator<ReportVolumeTest> volumeIterator = test.javaVolumeTests().iterator();
            while (threadingIterator.hasNext() || degradationIterator.hasNext() || complexIterator.hasNext() || volumeIterator.hasNext()) {
                List<String> row = new ArrayList<>();
                if (threadingIterator.hasNext()) {
                    ReportThreadingTest threadingTest = threadingIterator.next();
                    row.addAll(Arrays.asList(threadingTest.threadsCount() + "",
                            String.format("%.2f", threadingTest.rps()),
                            threadingTest.hitsCount() + "",
                            threadingTest.errorsCount() + "",
                            String.format("%.3f", threadingTest.responseTime())));
                    for (String additionalColumn : additionalColumns)
                        if (threadingTest.partialTimes().get(additionalColumn).isDefined())
                            row.add(String.format("%.3f", (Long) threadingTest.partialTimes().get(additionalColumn).get() / 1000.0));
                        else
                            row.add("");
                } else {
                    row.addAll(getEmptyItems(5 + additionalColumns.size()));
                }
                row.add("");

                if (volumeIterator.hasNext()) {
                    ReportVolumeTest volumeTest = volumeIterator.next();
                    row.addAll(Arrays.asList(volumeTest.iterationsCount() + "",
                            String.format("%.2f", volumeTest.rps()),
                            volumeTest.hitsCount() + "",
                            volumeTest.errorsCount() + "",
                            String.format("%.3f", volumeTest.responseTime())));
                    for (String additionalColumn : additionalColumns)
                        if (volumeTest.partialTimes().get(additionalColumn).isDefined())
                            row.add(String.format("%.3f", (Long) volumeTest.partialTimes().get(additionalColumn).get() / 1000.0));
                        else
                            row.add("");
                } else {
                    row.addAll(getEmptyItems(5 + additionalColumns.size()));
                }
                row.add("");

                if (degradationIterator.hasNext()) {
                    Long seconds = degradationIterator.next();
                    row.addAll(Arrays.asList(seconds / 60 + "", test.javaDegradationTest().get(seconds) + ""));
                } else {
                    row.addAll(Arrays.asList("", ""));
                }
                row.add("");

                if (complexIterator.hasNext()) {
                    ReportComplexTest complexTest = complexIterator.next();
                    row.addAll(Arrays.asList(String.format("%d", complexTest.requestsPerMinute()),
                            String.format("%.3f", complexTest.responseTime()),
                            complexTest.hitsCount() + "",
                            complexTest.errorsCount() + ""));
                } else {
                    row.addAll(Arrays.asList("", "", "", ""));
                }
                table.add(row);
            }
            table.add(Arrays.asList("", "", "", "", "", "", "", "", "", "", "", "", ""));
        }
        normalizeTable(table);
        try {
            writeToFile(table);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private List<List<String>> getHeaders(Set<String> additionalColumns) {
        List<List<String>> headers = new ArrayList<>();
        List<String> row = new ArrayList<>();
        row.addAll(Arrays.asList("Threading", "", "", "", ""));
        row.addAll(getEmptyItems(additionalColumns.size()));
        row.addAll(Arrays.asList("", "Degradation", "", "", "Complex", "", "", ""));
        headers.add(row);

        row = new ArrayList<>();
        row.addAll(Arrays.asList("Threads", "t/s", "Hits", "Errors", "Time"));
        row.addAll(additionalColumns);
        row.addAll(Arrays.asList("", "Minutes", "Count", "", "t/m", "Latency", "Hits", "Errors"));
        headers.add(row);
        return headers;
    }

    private List<String> getEmptyItems(int count) {
        List<String> items = new ArrayList<>(count);
        for (int i = 0; i < count; i++)
            items.add("");
        return items;
    }

    private void normalizeTable(List<List<String>> table) {
        int max = 0;
        for (List<String> row : table)
            max = Math.max(max, row.size());
        for (int i = 0; i < table.size(); i++) {
            List<String> row = new ArrayList<>();
            row.addAll(table.get(i));
            row.addAll(getEmptyItems(max - row.size()));
            table.set(i, row);
        }
    }

    private void writeToFile(List<List<String>> table) throws IOException {
        BufferedWriter writer = new BufferedWriter(new FileWriter(getReportFileName()));
        Iterator<List<String>> rowIterator = table.iterator();
        while (rowIterator.hasNext()) {
            Iterator<String> iterator = rowIterator.next().iterator();
            while (iterator.hasNext()) {
                writer.write(iterator.next());
                if (iterator.hasNext())
                    writer.write(";");
            }
            if (rowIterator.hasNext())
                writer.write(IOUtils.LINE_SEPARATOR);
        }
        writer.flush();
        writer.close();
    }

    private String getReportFileName() {
        File reportFolder = new File("report");
        if (!reportFolder.exists())
            reportFolder.mkdir();
        StringBuilder reportFileName = new StringBuilder();
        reportFileName.append("report").append(File.separator);
        reportFileName.append(String.format("%1$tY-%1$tm-%1$td %1$tH-%1$tM-%1$tS", new Date())).append(".csv");
        return reportFileName.toString();
    }
}
