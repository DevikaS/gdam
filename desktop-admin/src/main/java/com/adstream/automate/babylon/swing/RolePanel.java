package com.adstream.automate.babylon.swing;

import com.adstream.automate.babylon.JsonObjects.Role;
import com.adstream.automate.babylon.swing.tree.AgencyChildEntry;

import javax.swing.*;
import java.awt.event.ActionEvent;

/**
 * User: ruslan.semerenko
 * Date: 15.01.13 15:45
 */
public class RolePanel extends AbstractPanel {
    private String agencyId;
    private String roleId;
    private JTextField nameField;
    private JTextField groupField;
    private JCheckBox deleteCheckbox;

    public RolePanel(DesktopAdmin main) {
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
        components.put("Name", nameField = new JTextField(fieldWidth));
        components.put("Group", groupField = new JTextField(fieldWidth));
        components.put(" ", new JLabel());
        components.put("Delete", deleteCheckbox = new JCheckBox());
    }

    public void fill(Role role) {
        deleteCheckbox.setSelected(false);
        actionButton.setEnabled(false);
        agencyId = role.getParents()[0];
        roleId = role.getId();
        nameField.setText(role.getName());
        groupField.setText(role.getGroup());
    }

    @Override
    public void actionPerformed(ActionEvent e) {
        if (e.getSource() == deleteCheckbox)
            actionButton.setEnabled(deleteCheckbox.isSelected());
        if (e.getSource() == actionButton) {
            main.getAgencyCache().deleteRole(agencyId, roleId);
            main.rebuildTree();
            main.selectAgencyChildNode(agencyId, AgencyChildEntry.Type.ROLES);
        }
    }
}
