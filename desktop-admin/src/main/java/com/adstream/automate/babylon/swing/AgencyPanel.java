package com.adstream.automate.babylon.swing;

import com.adstream.automate.babylon.JsonObjects.Agency;
import com.adstream.automate.babylon.JsonObjects.FileStorage;
import com.adstream.automate.utils.Common;

import javax.swing.*;
import java.awt.event.ActionEvent;
import java.awt.event.ItemEvent;
import java.awt.event.ItemListener;

/**
 * User: ruslan.semerenko
 * Date: 24.11.12 23:16
 */
public class AgencyPanel extends AbstractPanel implements ItemListener {
    private String agencyId;
    private JTextField nameField;
    private JTextField descriptionField;
    private JTextField pinField;
    private JComboBox typeCombo;
    private JComboBox timeZoneCombo;
    private JComboBox countryCombo;
    private JComboBox storageCombo;
    private JTextField a4AgencyField;
    private JTextField a4UserField;
    private JTextField a4PasswordField;
    private JCheckBox a4AssetCheckbox;

    public AgencyPanel(DesktopAdmin main) {
        super(main);
    }

    @Override
    protected void initComponents() {
        final int fieldWidth = 25;
        components.put("Name",             nameField        = new JTextField(fieldWidth));
        components.put("Description",      descriptionField = new JTextField(fieldWidth));
        components.put("Pin",              pinField         = new JTextField(fieldWidth));
        components.put("Type",             typeCombo        = new JComboBox());
        components.put("Time Zone",        timeZoneCombo    = new JComboBox());
        components.put("Country",          countryCombo     = new JComboBox());
        components.put("Storage",          storageCombo     = new JComboBox());
        components.put("A4 Agency ID",     a4AgencyField    = new JTextField(fieldWidth));
        components.put("A4 User Email",    a4UserField      = new JTextField(fieldWidth));
        components.put("A4 User Password", a4PasswordField  = new JTextField(fieldWidth));
        components.put("A4 Create Asset",  a4AssetCheckbox  = new JCheckBox());
        storageCombo.addItemListener(this);
    }

    public void fill(Agency agency) {
        loadCombos();
        agencyId = agency.getId();
        nameField.setText(agency.getName());
        descriptionField.setText(agency.getDescription());
        pinField.setText(agency.getPin());
        typeCombo.setSelectedItem(getAgencyType(agency.getAgencyType()));
        timeZoneCombo.setSelectedItem(getStringNullCheck(agency.getTimeZone()));
        countryCombo.setSelectedItem(
                getStringNullCheck(main.getAgencyCache().getCountryName(getStringNullCheck(agency.getCountry()))));
        if (agency.getStorageId() != null) {
            storageCombo.setSelectedItem(main.getAgencyCache().getStorageById(agency.getStorageId()));
        } else {
            selectDefaultStorage();
        }
        a4AgencyField.setText(getStringNullCheck(agency.getA4AgencyId()));
        a4UserField.setText(getStringNullCheck(agency.getA4User()));
        a4PasswordField.setText(getStringNullCheck(agency.getA4Password()));
        a4AssetCheckbox.setSelected(getBooleanNullCheck(agency.getCreateAssetInA4()));
    }

    private void selectDefaultStorage() {
        for (int i = 0; i < storageCombo.getItemCount(); i++) {
            String storageName = ((FileStorage) storageCombo.getItemAt(i)).getFileStorageName();
            if (storageName.startsWith("A5") || storageName.equals("Adbank5")) {
                storageCombo.setSelectedIndex(i);
                break;
            }
        }
    }

    private void loadCombos() {
        reInitCombo(typeCombo, main.getAgencyCache().getOrganisationTypes());
        reInitCombo(timeZoneCombo, main.getAgencyCache().getTimeZones());
        reInitCombo(countryCombo, main.getAgencyCache().getCountries());
        reInitCombo(storageCombo, main.getAgencyCache().getStorages());
    }

    private String getAgencyType(String[] type) {
        if (type == null || type.length == 0) {
            return "";
        }
        return type[0];
    }

    @Override
    public void actionPerformed(ActionEvent e) {
        FileStorage storage = (FileStorage) storageCombo.getSelectedItem();
        Agency agency = isNew() ? new Agency() : main.getAgencyCache().getAgencyById(agencyId);
        agency.setName(nameField.getText().trim());
        agency.setDescription(descriptionField.getText().trim());
        agency.setPin(pinField.getText().trim());
        agency.setAgencyType((String) typeCombo.getSelectedItem());
        agency.setTimeZone((String) timeZoneCombo.getSelectedItem());
        agency.setCountry(main.getAgencyCache().getCountryCode((String) countryCombo.getSelectedItem()));
        agency.setStorageId(storage.getFileStorageId());
        agency.setA4AgencyId(getNullIfEmpty(a4AgencyField.getText().trim()));
        agency.setA4User(getNullIfEmpty(a4UserField.getText().trim()));
        agency.setA4Password(getNullIfEmpty(a4PasswordField.getText().trim()));
        agency.setCreateAssetInA4(a4AssetCheckbox.isSelected());
        if (checkAgency(agency)) {
            sendRequest(agency);
        }
    }

    private boolean checkAgency(Agency agency) {
        if (agency.getName().isEmpty()) {
            log.error("Agency name is empty");
            return false;
        }
        if (agency.getA4AgencyId() != null
                && !agency.getA4AgencyId().matches("(?i)[\\da-f]{8}-[\\da-f]{4}-[\\da-f]{4}-[\\da-f]{4}-[\\da-f]{12}")) {
            log.error("Invalid a4 agency id");
            return false;
        }
        Agency lookupAgency = main.getAgencyCache().getAgencyByName(agency.getName());
        if (lookupAgency != null && !lookupAgency.getId().equals(agencyId)) {
            log.error("Agency already exists");
            return false;
        }
        return true;
    }

    private void sendRequest(Agency agency) {
        Agency newAgency;
        if (isNew()) {
            log.info("Create agency");
            newAgency = main.getService().createAgency(agency);
            long deadline = System.currentTimeMillis() + 5000;
            do {
                if (main.getService().getAgencyById(newAgency.getId()) != null) {
                    break;
                }
                Common.sleep(1000);
            } while (System.currentTimeMillis() < deadline);
        } else {
            agency.setId(agencyId);
            log.info("Update agency");
            newAgency = main.getService().getWrappedService().updateAgency(agency);
        }
        checkResult(newAgency);
    }

    private void checkResult(Agency newAgency) {
        if (newAgency != null) {
            log.info("Success!");
            main.getAgencyCache().clearAgenciesCache();
            main.rebuildTree();
            fill(newAgency);
            main.selectAgencyNode(agencyId);
        } else {
            log.error("Error! See details in log.");
        }
    }

    private boolean isNew() {
        return agencyId == null;
    }

    @Override
    public void itemStateChanged(ItemEvent e) {
        if (e.getStateChange() == ItemEvent.DESELECTED)
            return;
        storageCombo.setToolTipText(((FileStorage) e.getItem()).getFileStorageId());
    }
}
