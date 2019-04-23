package com.adstream.automate.babylon.JsonObjects.gdn;

/**
 * Created by Ramababu.Bendalam on 02/11/2016.
 */
public enum GDNStatus {

    GDN_STATUS_INITIAL ("[GDN] New", "[GDN] Transfer In Progress", "[GDN] Awaiting station release","[GDN] Delivery in Progress"),
    GDN_STATUS_COMPLETED ("[GDN] Transfer Complete"),
    GDN_STATUS_FAILED ("[GDN] Transfer Failed"),
    INGEST_STATUS_INITIAL("New"),
    INGEST_STATUS_INTERMEDIATE("Tape Received - Awaiting Ingestion"),
    INGEST_STATUS_COMPLETED("TVC Ingested OK");


    private String[] gdnStatus;

    GDNStatus(String... gdnStatus) {

        this.gdnStatus = gdnStatus;
    }

    public String toString() {
        return gdnStatus[0];
    }



    public String[] getgdnStatus() {
        return gdnStatus;
    }

    public String convertStatusToString() {
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < getgdnStatus().length; i++) {
            sb.append(getgdnStatus()[i]);
            if (i != getgdnStatus().length - 1) sb.append(",");
        }
        return sb.toString();
    }
}

