package com.adstream.automate.babylon.migration.scripts;

import jxl.Workbook;
import jxl.read.biff.BiffException;
import jxl.write.WritableWorkbook;

import java.io.File;
import java.io.IOException;

/**
 * Created with IntelliJ IDEA.
 * User: solomin-y
 * Date: 3/4/15
 * Time: 5:58 PM

 */
public class ExcelUtils {


    public static void main(String[] args) throws IOException, BiffException {
        File file = new File("test_migration.xls");
        Workbook wb = Workbook.getWorkbook(file);
        wb.getSheet(0);
        System.out.println();
    }


}
