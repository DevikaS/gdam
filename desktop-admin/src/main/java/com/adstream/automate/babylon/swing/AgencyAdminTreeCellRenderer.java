package com.adstream.automate.babylon.swing;

import com.adstream.automate.babylon.swing.tree.UserEntry;

import javax.swing.*;
import javax.swing.tree.DefaultMutableTreeNode;
import javax.swing.tree.DefaultTreeCellRenderer;
import java.awt.*;

/**
 * Author: semerenko-r
 * Date: 27.07.2014
 */
public class AgencyAdminTreeCellRenderer extends DefaultTreeCellRenderer {
    private static final Icon AGENCY_ADMIN_ICON =
            new ImageIcon(AgencyAdminTreeCellRenderer.class.getClassLoader().getResource("admin.png"));

    @Override
    public Component getTreeCellRendererComponent(JTree tree, Object value, boolean sel, boolean expanded, boolean leaf, int row, boolean hasFocus) {
        Component component = super.getTreeCellRendererComponent(tree, value, sel, expanded, leaf, row, hasFocus);
        if (value instanceof DefaultMutableTreeNode) {
            Object userObject = ((DefaultMutableTreeNode) value).getUserObject();
            if (userObject instanceof UserEntry) {
                UserEntry entry = (UserEntry) userObject;
                if (entry.getUser().getRoles().length > 0
                        && entry.getUser().getRoles()[0].getId().equals(AgencyCache.AGENCY_ADMIN_ROLE_ID)) {
                    ((JLabel) component).setIcon(AGENCY_ADMIN_ICON);
                }
            }
        }
        return component;
    }
}
