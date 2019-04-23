package com.adstream.automate.babylon.swing;

import org.apache.log4j.WriterAppender;
import org.apache.log4j.spi.LoggingEvent;

import javax.swing.*;

/**
 * User: ruslan.semerenko
 * Date: 24.11.12 14:15
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
