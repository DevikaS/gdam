package com.adstream.automate.babylon.JsonObjects.gdn;

import com.adstream.automate.babylon.JsonObjects.MultiPartUploadCompleteData;
import org.joda.time.DateTime;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by Ramababu.Bendalam on 27/04/2016.
 */
public class IngestDoc extends JsonBase {

    String _s;
    String _documentType;
    String type;
    String _id;
    Integer _version;
    String status;
   //Map<String, Date> _created = new HashMap<String, Date>();
   //Map<String, Date> _modified = new HashMap<String, Date>();
    //IngestMetadata[] metadata;
    DateTime _created;
    DateTime _modified;
    IngestAgency  agency;
    IngestAsset asset;
    IngestOrder order;
    String comment;

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }
    MultiPartUploadCompleteData multiPartUploadCompleteData;

    public String get_s() {
        return _s;
    }

    public void set_s(String _s) {
        this._s = _s;
    }

    public String get_documentType() {
        return _documentType;
    }

    public void set_documentType(String _documentType) {
        this._documentType = _documentType;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String get_id() {
        return _id;
    }

    public void set_id(String _id) {
        this._id = _id;
    }

    public Integer get_version() {
        return _version;
    }

    public void set_version(Integer _version) {
        this._version = _version;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public DateTime get_created() {
        return _created;
    }

    public void set_created(DateTime _created) {
        this._created = _created;
    }

    public DateTime get_modified() {
        return _modified;
    }

    public void set_modified(DateTime _modified) {
        this._modified = _modified;
    }

    public IngestAgency getAgency() {
        return agency;
    }

    public void setAgency(IngestAgency agency) {
        this.agency = agency;
    }

    public IngestAsset getAsset() {
        return asset;
    }

    public void setAsset(IngestAsset asset) {
        this.asset = asset;
    }

    public IngestOrder getOrder() {
        return order;
    }

    public void setOrder(IngestOrder order) {
        this.order = order;
    }

    public MultiPartUploadCompleteData getMultiPartUploadCompleteData() {
        return multiPartUploadCompleteData;
    }

    public void setMultiPartUploadCompleteData(MultiPartUploadCompleteData multiPartUploadCompleteData) {
        this.multiPartUploadCompleteData = multiPartUploadCompleteData;
    }
}
