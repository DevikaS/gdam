package com.adstream.automate.babylon.JsonObjects.ordering.enums;

/*
 * Created by demidovskiy-r on 02.12.2014.
 */
public enum ViewDeliveryReport {
    DRAFT_ORDER(AccountType.ADSTREAM, "draft_order"),
    DRAFT_ORDER_BEAM(AccountType.BEAM, "draft_order_beam");

    private AccountType accountType;
    private String reportType;

    private ViewDeliveryReport(AccountType accountType, String reportType) {
        this.accountType = accountType;
        this.reportType = reportType;
    }

    @Override
    public String toString() {
        return reportType;
    }

    public AccountType getAccountType() {
        return accountType;
    }

    public static ViewDeliveryReport findByAccountType(AccountType accountType) {
        for (ViewDeliveryReport viewDeliveryReport: values())
            if (viewDeliveryReport.getAccountType().equals(accountType))
                return viewDeliveryReport;
        throw new IllegalArgumentException("Unknown Account type: " + accountType.toString());
    }
}