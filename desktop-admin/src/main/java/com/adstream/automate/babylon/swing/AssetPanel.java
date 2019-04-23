package com.adstream.automate.babylon.swing;

import com.adstream.automate.babylon.JsonObjects.Content;
import com.adstream.automate.babylon.swing.tree.AgencyChildEntry;

import javax.swing.*;
import java.awt.event.ActionEvent;

/**
 * User: ruslan.semerenko
 * Date: 07.12.12 16:22
 */
public class AssetPanel extends AbstractPanel {
    private String internalAssetId;
    private String agencyId;
    private JTextField titleField;
    private JCheckBox deleteCheckbox;

    public AssetPanel(DesktopAdmin main) {
        super(main);
        for (String key : components.keySet())
            if (components.get(key) instanceof JTextField)
                ((JTextField) components.get(key)).setEditable(false);
        deleteCheckbox.addActionListener(this);
        actionButton.setEnabled(false);
        actionButton.setText("Delete");
        actionButton.setSize(actionButton.getPreferredSize());
    }

    @Override
    protected void initComponents() {
        final int fieldWidth = 25;
        components.put("Name", titleField = new JTextField(fieldWidth));
        components.put(" ", new JLabel());
        components.put("Delete", deleteCheckbox = new JCheckBox());
    }

    public void fill(Content asset) {
        deleteCheckbox.setSelected(false);
        actionButton.setEnabled(false);
        internalAssetId = asset.getId();
        agencyId = asset.getAgency().getId();
        titleField.setText(asset.getName());
    }

    @Override
    public void actionPerformed(ActionEvent e) {
        if (e.getSource() == deleteCheckbox)
            actionButton.setEnabled(deleteCheckbox.isSelected());
        if (e.getSource() == actionButton) {
            main.getAgencyCache().deleteAsset(agencyId, internalAssetId);
            main.rebuildTree();
            main.selectAgencyChildNode(agencyId, AgencyChildEntry.Type.ASSETS);
        }
    }
}
