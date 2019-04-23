package com.adstream.automate.babylon.migration.ui;

import org.apache.log4j.WriterAppender;
import org.apache.log4j.spi.LoggingEvent;

import javax.swing.*;

/**
 * Created with IntelliJ IDEA.
 * User: solomin-y
 * Date: 3/20/15
 * Time: 2:43 PM

 */
public class TextAreaAppender extends WriterAppender {
    private static JTextArea textArea;

    public static void setTextArea(JTextArea textArea) {
        TextAreaAppender.textArea = textArea;
    }

    @Override
    public void append(LoggingEvent loggingEvent) {
        final String message = layout.format(loggingEvent);

        SwingUtilities.invokeLater(new Runnable() {
            public void run() {
                textArea.append(message);
            }
        });
    }
}
