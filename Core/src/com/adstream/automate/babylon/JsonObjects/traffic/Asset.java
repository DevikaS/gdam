package com.adstream.automate.babylon.JsonObjects.traffic;

/**
 * Created by denysb on 27/06/2016.
 */
public class Asset{

    private Integer revisionId;
    private String rootAssetId;
    private String name;
    private Preview [] previews;
    private String _id;
    private String ingestedDateTime;
    private String status;

    public class Preview{
        private Integer fileSize;
        private String _created;
        private Integer sortOrder;
        private String name;
        private String a5_type;
        private String specDbDocID;
        private String fileID;

        public Integer getFileSize() {
            return fileSize;
        }

        public void setFileSize(Integer fileSize) {
            this.fileSize = fileSize;
        }

        public String get_created() {
            return _created;
        }

        public void set_created(String _created) {
            this._created = _created;
        }

        public Integer getSortOrder() {
            return sortOrder;
        }

        public void setSortOrder(Integer sortOrder) {
            this.sortOrder = sortOrder;
        }

        public String getName() {
            return name;
        }

        public void setName(String name) {
            this.name = name;
        }

        public String getA5_type() {
            return a5_type;
        }

        public void setA5_type(String a5_type) {
            this.a5_type = a5_type;
        }

        public String getSpecDbDocID() {
            return specDbDocID;
        }

        public void setSpecDbDocID(String specDbDocID) {
            this.specDbDocID = specDbDocID;
        }

        public String getFileID() {
            return fileID;
        }

        public void setFileID(String fileID) {
            this.fileID = fileID;
        }
    }

    public Integer getRevisionId() {
        return revisionId;
    }

    public void setRevisionId(Integer revisionId) {
        this.revisionId = revisionId;
    }

    public String getRootAssetId() {
        return rootAssetId;
    }

    public void setRootAssetId(String rootAssetId) {
        this.rootAssetId = rootAssetId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Preview[] getPreviews() {
        return previews;
    }

    public void setPreviews(Preview[] previews) {
        this.previews = previews;
    }

    public String get_id() {
        return _id;
    }

    public void set_id(String _id) {
        this._id = _id;
    }

    public String getIngestedDateTime() {
        return ingestedDateTime;
    }

    public void setIngestedDateTime(String ingestedDateTime) {
        this.ingestedDateTime = ingestedDateTime;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}
