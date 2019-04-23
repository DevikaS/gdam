package com.adstream.automate.babylon.migration.scripts;

import com.sun.star.beans.PropertyValue;
import com.sun.star.comp.helper.Bootstrap;
import com.sun.star.connection.XConnector;
import com.sun.star.frame.XComponentLoader;
import com.sun.star.lang.XComponent;
import com.sun.star.lang.XMultiComponentFactory;
import com.sun.star.sheet.XSpreadsheet;
import com.sun.star.sheet.XSpreadsheetDocument;
import com.sun.star.sheet.XSpreadsheets;
import com.sun.star.table.XCell;
import com.sun.star.table.XCellRange;
import com.sun.star.uno.UnoRuntime;
import com.sun.star.uno.XComponentContext;
import com.sun.star.util.CloseVetoException;
import com.sun.star.util.XCloseable;
import com.sun.star.frame.XDesktop;
import org.jdom.Namespace;
import org.jopendocument.dom.spreadsheet.Sheet;
import org.jopendocument.dom.spreadsheet.SpreadSheet;

import java.io.File;
import java.util.HashMap;
import java.util.Map;


/**
 * Created with IntelliJ IDEA.
 * User: solomin-y
 * Date: 3/3/15
 * Time: 8:57 AM

 */
public class OpenOfficeUtils {
    private XComponent xComponent = null;
    private XMultiComponentFactory xServiceManager = null;
    private XComponentContext xContext = null;


    public static void main(String[] args) {
        OpenOfficeUtils ooUtils = new OpenOfficeUtils();
        ooUtils.openDocument("test_migration.xlsx");
        ooUtils.getTextFromCellByName("BU Form", "A3");

    }

    /**
     * В конструкторе класса соединяемся с работающим экземпляром OpenOffice.org
     * и получаем менеджер сервисов
     * исполняемые файлы OpenOffice.org, а именно файл <i>soffice</i> или <i>soffice.exe</i>
     */

    public OpenOfficeUtils()
    {
        try
        {
            final Map<String,Integer> result=new HashMap<String,Integer>();
            File file = new File("test_migration.xlsx");
            final SpreadSheet spreadSheet= SpreadSheet.createFromFile(file);
            final Sheet sheet=spreadSheet.getSheet(0);
            final Namespace ns=sheet.getElement().getNamespace("table");
            final String sheetName=sheet.getElement().getAttributeValue("name",ns);
            XComponentContext xContext = Bootstrap.bootstrap();
            //выводим сообщениеSystem.out.println("Соединяемся с работающим экземпляром OOffice... ");
            //создаем основную фабрику объектов
            XMultiComponentFactory xMCF = xContext.getServiceManager();
            //проверяем, получилось ли создать?
            String avaiable = (xMCF != null ? "доступен":"не доступен");
            //и сообщаем о результате
            System.out.println("удаленный ServiceManager " + avaiable);

            //получаем компонентный контекст
            /*xContext = Bootstrap.createInitialComponentContext(null);
            //xContext = Bootstrap.bootstrap();
            //получаем менеджер сервисов
            xServiceManager = xContext.getServiceManager();*/
        }
        catch (com.sun.star.comp.helper.BootstrapException e){
            e.printStackTrace();
        }
        catch (Exception n) {
            n.printStackTrace();
        }
    }

    public void openDocument(String docURL)
    {
        try
        {
            //создание экземпляра объекта рабочего стола
            xServiceManager.getAvailableServiceNames();
            Object oDesktop = xServiceManager.createInstanceWithContext("com.sun.star.frame.Desktop", xContext);
            //приведением типов получаем объект загрузчика компонентов
            XComponentLoader xCompLoader = (XComponentLoader)UnoRuntime.queryInterface(XComponentLoader.class, oDesktop);

            java.io.File sourceFile = new java.io.File(docURL);

            StringBuffer sbTmp = new StringBuffer("file:///");

            sbTmp.append(sourceFile.getCanonicalPath().replace('\\', '/'));
            docURL = sbTmp.toString();

            //создаем компонент-лист

            xComponent = xCompLoader.loadComponentFromURL( docURL, "_blank", 0, new PropertyValue[0]);
        }
        catch (java.io.IOException e)
        {
            e.printStackTrace();
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }
    }

    /**
     * Закрытие документа
     */
    public void closeDocument()
    {
        XCloseable xCloseable = (XCloseable) UnoRuntime.queryInterface(XCloseable.class, xComponent);

        try
        {
            xCloseable.close(false);
        }
        catch (CloseVetoException e)
        {
            e.printStackTrace();
        }
    }

    public String getTextFromCellByName(String pageName, String cellName)
    {
        String res = "";
        try
        {
            //создаем документ-лист (образуется запросом интерфейса и приведением типа)
            XSpreadsheetDocument xSpreadsheetDocument=(XSpreadsheetDocument)UnoRuntime.queryInterface(XSpreadsheetDocument.class, xComponent);

            //получаем набор листов документа
            XSpreadsheets xSpreadsheets=xSpreadsheetDocument.getSheets();

            //получаем объект-лист типа Object
            Object sheet=xSpreadsheets.getByName(pageName);
            //и приводим его к нужному типу
            XSpreadsheet xSpreadsheet=(XSpreadsheet)UnoRuntime.queryInterface(XSpreadsheet.class, sheet);

            //выделяем ячейку cellName
            XCellRange xCellRange = xSpreadsheet.getCellRangeByName(cellName+":"+cellName);
            //получаем объект ячейка
            XCell xCell = xCellRange.getCellByPosition(0, 0);
            //Беру данные из ячейки
            com.sun.star.text.XText xCellText =
                    (com.sun.star.text.XText) UnoRuntime.queryInterface( com.sun.star.text.XText.class, xCell );
            res = xCellText.getString();
        }
        catch(Exception e)
        {

        }
        return res;
    }

}
