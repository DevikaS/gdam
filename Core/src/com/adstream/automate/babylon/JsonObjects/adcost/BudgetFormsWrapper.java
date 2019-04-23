package com.adstream.automate.babylon.JsonObjects.adcost;

import java.io.File;

/**
 * Created by Arti.Sharma on 1/12/2017.
 */
public class BudgetFormsWrapper {
    private String costId;
    private String costStageId;
    private String costStageRevisionId ;
    private String budgetFormTemplateId ;
    private File file;
    private String formName;

    public String getFormName() {
        return formName;
    }

    public File getFile() {
        return file;
    }

    public String getBudgetFormTemplateId() {
        return budgetFormTemplateId;
    }

    public String getCostStageRevisionId() {
        return costStageRevisionId;
    }

    public String getCostStageId() {
        return costStageId;
    }

    public String getCostId() {
        return costId;
    }

    public BudgetFormsWrapper(String costId,String costStageId, String costStageRevisionId, File file, String formName){
        this.costId=costId;
        this.costStageId=costStageId;
        this.costStageRevisionId=costStageRevisionId;
        this.file=file;
        this.formName=formName;
    }

    public BudgetFormsWrapper(String budgetFormTemplateId, File file, String formName){
        this.budgetFormTemplateId=budgetFormTemplateId;
        this.file=file;
        this.formName=formName;
    }

    public BudgetFormsWrapper(File file, String formName){
        this.file=file;
        this.formName=formName;
    }
}
