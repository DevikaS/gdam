package com.adstream.automate.babylon.swing;

import com.adstream.automate.babylon.JsonObjects.ApplicationAccess;
import com.adstream.automate.babylon.JsonObjects.BaseObject;
import com.adstream.automate.babylon.JsonObjects.User;

import javax.swing.*;
import java.awt.event.ActionEvent;
import java.util.ArrayList;
import java.util.List;

/**
 * User: ruslan.semerenko
 * Date: 25.11.12 12:11
 */
public class UserPanel extends AbstractPanel {
    private String agencyId;
    private String userId;
    private JTextField firstNameField;
    private JTextField lastNameField;
    private JTextField emailField;
    private JTextField passwordField;
    private JCheckBox libraryCheckBox;
    private JCheckBox deliveryCheckBox;
    private JCheckBox trafficCheckBox;
    private JCheckBox foldersCheckBox;
    private JCheckBox workRequestsCheckBox;
    private JCheckBox approvalCheckBox;
    private JCheckBox annotationsCheckBox;
    private JCheckBox presentationsCheckBox;
    private JCheckBox dashboardCheckBox;
    private JComboBox roleCombo;

    public UserPanel(DesktopAdmin main) {
        super(main);
    }

    @Override
    protected void initComponents() {
        final int fieldWidth = 25;
        components.put("First Name"   , firstNameField        = new JTextField(fieldWidth));
        components.put("Last Name"    , lastNameField         = new JTextField(fieldWidth));
        components.put("Email"        , emailField            = new JTextField(fieldWidth));
        components.put("Password"     , passwordField         = new JTextField(fieldWidth));
        components.put("Folders"      , foldersCheckBox       = new JCheckBox());
        components.put("Work Requests", workRequestsCheckBox  = new JCheckBox());
        components.put("Library"      , libraryCheckBox       = new JCheckBox());
        components.put("Delivery"     , deliveryCheckBox      = new JCheckBox());
        components.put("Traffic"      , trafficCheckBox       = new JCheckBox());
        components.put("Approvals"    , approvalCheckBox      = new JCheckBox());
        components.put("Annotations"  , annotationsCheckBox   = new JCheckBox());
        components.put("Presentations", presentationsCheckBox = new JCheckBox());
        components.put("Dashboard"    , dashboardCheckBox     = new JCheckBox());
        components.put("Role"         , roleCombo             = new JComboBox());

    }

    public void fill(User user) {
        agencyId = user.getAgency().getId();
        userId = user.getId();
        reInitCombo(roleCombo, main.getAgencyCache().getGlobalRoles(agencyId));
        firstNameField.setText(user.getFirstName());
        lastNameField.setText(user.getLastName());
        emailField.setText(user.getEmail());
        passwordField.setText(isNewUser() ? "" : "***");
        passwordField.setEditable(isNewUser());
        libraryCheckBox.setSelected(user.hasLibraryAccess());
        deliveryCheckBox.setSelected(user.hasDeliveryAccess());
        trafficCheckBox.setSelected(user.hasTrafficAccess());
        foldersCheckBox.setSelected(user.hasFoldersAccess());
        workRequestsCheckBox.setSelected(user.hasWorkRequestsAccess());
        approvalCheckBox.setSelected(user.hasApprovalsAccess());
        annotationsCheckBox.setSelected(user.hasAnnotationsAccess());
        presentationsCheckBox.setSelected(user.hasPresentationsAccess());
        dashboardCheckBox.setSelected(user.hasDashboardAccess());
        roleCombo.setSelectedItem(getRoleName(user.getRoles()));
    }

    private String getRoleName(BaseObject[] roles) {
        if (roles == null || roles.length == 0) {
            return "";
        }
        return roles[0].getName();
    }

    @Override
    public void actionPerformed(ActionEvent e) {
        User user = isNewUser() ? new User() : main.getService().getUser(userId);
        user.setAgency(main.getAgencyCache().getAgencyById(agencyId));
        user.setFirstName(firstNameField.getText().trim());
        user.setLastName(lastNameField.getText().trim());
        user.setEmail(emailField.getText().trim());
        if (isNewUser()) {
            user.setPassword(passwordField.getText().trim());
        }
        List<ApplicationAccess> access = new ArrayList<>();
        if (libraryCheckBox.isSelected()) {
            access.add(ApplicationAccess.LIBRARY);
        }
        if (deliveryCheckBox.isSelected()) {
            access.add(ApplicationAccess.DELIVERY);
        }
        if (trafficCheckBox.isSelected()) {
            access.add(ApplicationAccess.TRAFFIC);
        }
        if (foldersCheckBox.isSelected()) {
            access.add(ApplicationAccess.FOLDERS);
        }
        if (workRequestsCheckBox.isSelected()) {
            access.add(ApplicationAccess.WORK_REQUESTS);
        }
        if (approvalCheckBox.isSelected()) {
            access.add(ApplicationAccess.APPROVALS);
        }
        if (annotationsCheckBox.isSelected()) {
            access.add(ApplicationAccess.ANNOTATIONS);
        }
        if (presentationsCheckBox.isSelected()) {
            access.add(ApplicationAccess.PRESENTATIONS);
        }
        if(dashboardCheckBox.isSelected()) {
            access.add(ApplicationAccess.DASHBOARD);
        }
        user.setAccess(access.toArray(new ApplicationAccess[access.size()]));
        BaseObject role = main.getAgencyCache().getRoleByName(((String) roleCombo.getSelectedItem()), agencyId);
        if (role != null) {
            user.setRoles(new BaseObject[] {role});
        }
        if (checkUser(user)) {
            sendRequest(user);
        }
    }

    private boolean checkUser(User user) {
        if (user.getFirstName().isEmpty()) {
            log.error("User first name is empty");
            return false;
        }
        if (user.getLastName().isEmpty()) {
            log.error("User last name is empty");
            return false;
        }
        if (user.getEmail().isEmpty()) {
            log.error("User email is empty");
            return false;
        }
        if (isNewUser() && user.getPassword().isEmpty()) {
            log.error("User password is empty");
            return false;
        }
        return true;
    }

    private void sendRequest(User user) {
        User newUser;
        if (isNewUser()) {
            log.info("Create user");
            newUser = main.getService().createUser(user);
        } else {
            log.info("Update user");
            newUser = main.getService().updateUser(userId, user);
        }
        checkResult(newUser);
    }

    private void checkResult(User newUser) {
        if (newUser != null) {
            log.info("Success!");
            main.getAgencyCache().updateUsersCache(newUser.getAgency().getId(), newUser);
            main.rebuildTree();
            fill(newUser);
            main.selectUserNode(agencyId, userId);
        } else {
            log.error("Error! See details in log.");
        }
    }

    private boolean isNewUser() {
        return userId == null;
    }
}
