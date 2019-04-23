package com.adstream.automate.babylon.migration.ui;

import com.adstream.automate.babylon.migration.scripts.FullMigrationScript;
import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.File;
import java.util.List;
import java.util.Properties;

/**
 * Created with IntelliJ IDEA.
 * User: solomin-y
 * Date: 3/20/15
 * Time: 1:52 PM

 */
public class MigrationAdmin extends JFrame implements ActionListener {

    // Должна содержать: файл диалоговое окно, для выбора ХМЛ и/или архива.
    // Список выбранных файлов с возможностью удаления
    // Окно для ввода номера ишью
    // Радиобаттоны с выбором - с какого степа выполнять таск
    // Окно с отображением лога
    // Еще одну информационную форму - с результатами миграции (сводный репорт)

    private Logger log = Logger.getLogger(FullMigrationScript.class);

    private JScrollPane logScrollPane;

    private JTextArea logArea;
    private JLabel hintIssue;
    private JTextField issueNum;
    private JButton startButton;

    private List<JPanel> panels;
    private JPanel mainPanel = new JPanel();
    private JPanel controlPanel;


    public static void main(String[] args) {
        MigrationAdmin migrationAdmin = new MigrationAdmin();
    }

    public MigrationAdmin() {
        super("Migration A4 -> A5");
        setLayout(null);
        setDefaultCloseOperation(WindowConstants.DISPOSE_ON_CLOSE);
       // setResizable(false);
        setMinimumSize(new Dimension(900, 600));
        setSize(900, 600);
        drawLogArea();
        drawControlPanel();
        initLog4j();

        pack();
        setVisible(true);

    }

    private void drawFrame() {

    }

    private void drawControlPanel() {
        controlPanel = new JPanel();
        controlPanel.setSize(900, 100);
        controlPanel.setVisible(true);



        hintIssue = new JLabel("Set issue key please.");
        hintIssue.setVisible(true);
        hintIssue.setLocation(0, 0);
        hintIssue.setPreferredSize(new Dimension(100, 0));

        controlPanel.add(hintIssue);

        issueNum = new JTextField("", 10);
        issueNum.setLocation(hintIssue.getX() + (int) hintIssue.getSize().getWidth() + 10, 0);
        controlPanel.add(issueNum);

        startButton = new JButton("Start");
        startButton.addActionListener(this);
        controlPanel.add(startButton);
        add(controlPanel);

    }

    private void setPanels() {
        mainPanel.setLayout(new BorderLayout());

        controlPanel = new JPanel();
        controlPanel.setVisible(true);
        controlPanel.setLocation(0, 100);


        mainPanel.add(controlPanel);

        //pack();
        setLocationRelativeTo(null);

//        panels.add(controlPanel);
        add(controlPanel);

    }

    private void drawLogArea() {
        logArea = new JTextArea();
        logArea.setEditable(false);

        logScrollPane = new JScrollPane(logArea);
        logScrollPane.setVerticalScrollBarPolicy(ScrollPaneConstants.VERTICAL_SCROLLBAR_ALWAYS);
        logScrollPane.setHorizontalScrollBarPolicy(ScrollPaneConstants.HORIZONTAL_SCROLLBAR_ALWAYS);
        logScrollPane.setLocation(0, 200);
        logScrollPane.setSize(880, 500);
        add(logScrollPane);
    }


    @Override
    public void actionPerformed(ActionEvent e) {
        Object source = e.getSource();
        if (source == startButton) {
            executeScript();
        }
    }

    private void initLog4j() {
        TextAreaAppender.setTextArea(logArea);
        Properties props = new Properties();
        props.put("log4j.rootLogger", "INFO, console, textarea");
        props.put("log4j.appender.console", "org.apache.log4j.ConsoleAppender");
        props.put("log4j.appender.console.layout", "org.apache.log4j.PatternLayout");
        props.put("log4j.appender.console.layout.ConversionPattern", "%d %-5p %m%n");
        props.put("log4j.appender.textarea", "com.adstream.automate.babylon.migration.ui.TextAreaAppender");
        props.put("log4j.appender.textarea.layout", "org.apache.log4j.PatternLayout");
        props.put("log4j.appender.textarea.layout.ConversionPattern", "%d %-5p %m%n");
        props.put("log4j.appender.textarea.Threshold", "INFO");
        props.put("log4j.logger.com.adstream.automate.babylon.BabylonService", "DEBUG");
        PropertyConfigurator.configure(props);
    }

    public void executeScript() {
        new Thread() {
            public void run() {
                FullMigrationScript ms = new FullMigrationScript("MIG-" + issueNum.getText());
                try {
                    ms.getDataFromGoogleTable();
                    ms.getAttacheLink();
                } catch (Exception e) {
                    e.printStackTrace();  //To change body of catch statement use File | Settings | File Templates.
                }
            }
        }.start();
    }

}