package com.adstream.automate.babylon.swing.tree;

import com.adstream.automate.babylon.JsonObjects.Role;

/**
 * User: ruslan.semerenko
 * Date: 15.01.13 15:42
 */
public class RoleEntry {
    private Role role;

    public RoleEntry(Role role) {
        this.role = role;
    }

    public Role getRole() {
        return role;
    }

    @Override
    public String toString() {
        return role.getName();
    }
}
