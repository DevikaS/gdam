package com.adstream.automate.babylon.JsonObjects.adcost;

import java.io.File;

/**
 * Created by Raja.Gone on 30/05/2017.
 */
public class SupportingDocsWrapper {
    private String costId;
    private String costStageId;
    private String costStageRevisionId ;
    private String supportingDocumentId ;
    private File file;
    private String formName;

    public String getFormName() {
        return formName;
    }

    public File getFile() {
        return file;
    }

    public String getSupportingDocumentId() {
        return supportingDocumentId;
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

    public SupportingDocsWrapper(String costId,String costStageId, String costStageRevisionId, String supportingDocumentId, File file, String formName){
        this.costId=costId;
        this.costStageId=costStageId;
        this.costStageRevisionId=costStageRevisionId;
        this.supportingDocumentId=supportingDocumentId;
        this.file=file;
        this.formName=formName;
    }
}
