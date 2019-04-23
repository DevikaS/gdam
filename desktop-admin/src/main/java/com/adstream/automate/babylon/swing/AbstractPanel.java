package com.adstream.automate.babylon.swing;

import org.apache.log4j.Logger;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionListener;
import java.util.*;
import java.util.List;

/**
 * User: ruslan.semerenko
 * Date: 25.11.12 13:26
 */
public abstract class AbstractPanel extends JPanel implements ActionListener {
    protected Logger log = Logger.getLogger(this.getClass());
    private static final int linesInterval = 26;
    protected DesktopAdmin main;
    protected Map<String, JComponent> components = new LinkedHashMap<String, javax.swing.JComponent>();
    protected JButton actionButton;

    public AbstractPanel(DesktopAdmin main) {
        this.main = main;
        setLayout(null);
        initComponents();
        int left = drawLabels();
        drawElements(left);
    }

    private int drawLabels() {
        List<JLabel> labels = new ArrayList<JLabel>();
        Dimension commonDim = new Dimension(0, 0);
        Set<String> keys = components.keySet();
        Iterator<String> it = keys.iterator();
        for (int i = 0; i < keys.size(); i++) {
            JLabel label = new JLabel(it.next());
            label.setLocation(0, i * linesInterval);
            add(label);
            labels.add(label);
            Dimension dim = label.getPreferredSize();
            if (dim.getWidth() > commonDim.getWidth())
                commonDim = dim;
        }
        for (JLabel label : labels)
            label.setSize(commonDim);
        return (int) commonDim.getWidth();
    }

    private void drawElements(int left) {
        actionButton = new JButton("Save");
        actionButton.addActionListener(this);
        components.put("", actionButton);
        Collection<JComponent> elements = components.values();
        Iterator<JComponent> it = elements.iterator();
        for (int i = 0; i < elements.size(); i++) {
            JComponent comp = it.next();
            comp.setLocation(left + 5, i * linesInterval);
            comp.setSize(comp.getPreferredSize());
            add(comp);
        }
    }

    protected abstract void initComponents();

    protected String getStringNullCheck(String str) {
        if (str == null)
            return "";
        return str;
    }

    protected boolean getBooleanNullCheck(Boolean bool) {
        if (bool == null)
            return false;
        return bool;
    }

    protected String getNullIfEmpty(String str) {
        if (str.isEmpty())
            return null;
        return str;
    }

    protected void reInitCombo(JComboBox combo, List elements) {
        combo.removeAllItems();
        combo.setModel(new DefaultComboBoxModel(elements.toArray()));
        combo.setSize(combo.getPreferredSize());
    }
}
