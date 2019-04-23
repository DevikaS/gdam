package com.adstream.automate.babylon.swing;

import com.adstream.automate.babylon.JsonObjects.Agency;

import javax.swing.*;
import java.awt.event.ActionEvent;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

/**
 * User: ruslan.semerenko
 * Date: 30.08.13 16:24
 */
public class RebuildIndexPanel extends AbstractPanel {
    private JComboBox agencyCombo;
    private JComboBox indexTypeCombo;
    private JCheckBox rebuildCheckbox;

    public RebuildIndexPanel(DesktopAdmin main) {
        super(main);
        rebuildCheckbox.addActionListener(this);
        actionButton.setEnabled(false);
        actionButton.setText("Rebuild");
        actionButton.setSize(actionButton.getPreferredSize());
    }

    @Override
    protected void initComponents() {
        components.put("Agency", agencyCombo = new JComboBox());
        components.put("Index Type", indexTypeCombo = new JComboBox());
        components.put(" ", new JLabel());
        components.put("Rebuild", rebuildCheckbox = new JCheckBox());
    }

    public void fill(String agencyName) {
        rebuildCheckbox.setSelected(false);
        actionButton.setEnabled(false);
        reInitAgencies();
        reInitIndexes();
        if (agencyName != null) {
            agencyCombo.setSelectedItem(agencyName);
        }
    }

    private void reInitAgencies() {
        List<String> agenciesNames = new ArrayList<String>();
        agenciesNames.add("all");
        Agency[] agencies = main.getAgencyCache().getAgencies();
        for (Agency agency : agencies) {
            agenciesNames.add(agency.getName());
        }
        reInitCombo(agencyCombo, agenciesNames);
    }

    private void reInitIndexes() {
        List<String> indexes = Arrays.asList(
                "all",
                "activity",
                "adkit",
                "agency",
                "agency_team",
                "asset",
                "asset_filter",
                "destination",
                "element",
                "folder",
                "group",
                "market",
                "presentation",
                "project",
                "role",
                "tv_order",
                "user"
        );
        reInitCombo(indexTypeCombo, indexes);
    }

    @Override
    public void actionPerformed(ActionEvent e) {
        if (e.getSource() == rebuildCheckbox)
            actionButton.setEnabled(rebuildCheckbox.isSelected());
        if (e.getSource() == actionButton) {
            Agency agency = main.getAgencyCache().getAgencyByName((String) agencyCombo.getSelectedItem());
            String index = (String) indexTypeCombo.getSelectedItem();
            String agencyId = agency == null ? null : agency.getId();
            String indexType = index.equals("all") ? null : index;
            if (agencyId != null && indexType == null) {
                log.error("NGN-7910. Please select index type for selected agency.");
            } else {
                main.getAgencyCache().rebuildIndex(agencyId, indexType);
            }
        }
    }
}
