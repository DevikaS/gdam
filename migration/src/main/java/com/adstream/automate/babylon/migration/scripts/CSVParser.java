package com.adstream.automate.babylon.migration.scripts;

import org.apache.commons.csv.CSVFormat;
import org.apache.commons.csv.CSVRecord;

import java.io.IOException;
import java.io.Reader;
import java.io.StringReader;
import java.util.ArrayList;
import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: solomin-y
 * Date: 3/10/15
 * Time: 8:39 AM

 */
public class CSVParser {

    private String csv;
    private List<DataForBatchMigration> preparedData;

    public CSVParser() {}

    public CSVParser(String csv) {
        this.csv = csv;
    }

    public String getCsv() {
        return csv;
    }

    public void setCsv(String csv) {
        this.csv = csv;
    }

    public List<DataForBatchMigration> prepareData() throws IOException {
        if (csv.isEmpty())
            throw new IllegalArgumentException("There isn't source with data. ");
        List<DataForBatchMigration> result = new ArrayList<>();
        Reader in = new StringReader(csv);
        org.apache.commons.csv.CSVParser parser = new org.apache.commons.csv.CSVParser(in, CSVFormat.EXCEL);
        List<CSVRecord> listCSV = parser.getRecords();
        for (CSVRecord csvRecord: listCSV) {
            //String[] values = csvRecord.values();
            if (!csvRecord.get(1).isEmpty() && !csvRecord.get(1).equalsIgnoreCase("A5 Name to call*")) {
                DataForBatchMigration dataForBatchMigration = new DataForBatchMigration();
                dataForBatchMigration.setA4BuName(csvRecord.get(0));
                dataForBatchMigration.setA5BuName(csvRecord.get(1));
                dataForBatchMigration.setA4UserEmail(csvRecord.get(7));
                result.add(dataForBatchMigration);
            }
        }
        return result;
    }

}
