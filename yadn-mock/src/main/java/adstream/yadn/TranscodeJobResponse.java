
package adstream.yadn;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlAttribute;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlType;


/**
 * <p>Java class for anonymous complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType>
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element ref="{urn:adstream:yadn}MessageID"/>
 *         &lt;element ref="{urn:adstream:yadn}Status"/>
 *         &lt;element ref="{urn:adstream:yadn}FileID"/>
 *         &lt;element ref="{urn:adstream:yadn}FileStorage"/>
 *         &lt;element ref="{urn:adstream:yadn}IsDefault"/>
 *         &lt;element ref="{urn:adstream:yadn}TranscodeFiles"/>
 *       &lt;/sequence>
 *       &lt;attribute name="id" type="{http://www.w3.org/2001/XMLSchema}string" />
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "", propOrder = {
    "messageID",
    "status",
    "fileID",
    "fileStorage",
    "isDefault",
    "transcodeFiles"
})
@XmlRootElement(name = "TranscodeJobResponse", namespace = "urn:adstream:yadn")
public class TranscodeJobResponse {

    @XmlElement(name = "MessageID", namespace = "urn:adstream:yadn", required = true)
    protected String messageID;
    @XmlElement(name = "Status", namespace = "urn:adstream:yadn", required = true)
    protected String status;
    @XmlElement(name = "FileID", namespace = "urn:adstream:yadn", required = true)
    protected String fileID;
    @XmlElement(name = "FileStorage", namespace = "urn:adstream:yadn", required = true)
    protected String fileStorage;
    @XmlElement(name = "IsDefault", namespace = "urn:adstream:yadn", required = true)
    protected String isDefault;
    @XmlElement(name = "TranscodeFiles", namespace = "urn:adstream:yadn", required = true)
    protected TranscodeFiles transcodeFiles;
    @XmlAttribute(name = "id")
    protected String id;

    /**
     * Gets the value of the messageID property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getMessageID() {
        return messageID;
    }

    /**
     * Sets the value of the messageID property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setMessageID(String value) {
        this.messageID = value;
    }

    /**
     * Gets the value of the status property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getStatus() {
        return status;
    }

    /**
     * Sets the value of the status property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setStatus(String value) {
        this.status = value;
    }

    /**
     * Gets the value of the fileID property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getFileID() {
        return fileID;
    }

    /**
     * Sets the value of the fileID property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setFileID(String value) {
        this.fileID = value;
    }

    /**
     * Gets the value of the fileStorage property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getFileStorage() {
        return fileStorage;
    }

    /**
     * Sets the value of the fileStorage property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setFileStorage(String value) {
        this.fileStorage = value;
    }

    /**
     * Gets the value of the isDefault property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getIsDefault() {
        return isDefault;
    }

    /**
     * Sets the value of the isDefault property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setIsDefault(String value) {
        this.isDefault = value;
    }

    /**
     * Gets the value of the transcodeFiles property.
     * 
     * @return
     *     possible object is
     *     {@link TranscodeFiles }
     *     
     */
    public TranscodeFiles getTranscodeFiles() {
        return transcodeFiles;
    }

    /**
     * Sets the value of the transcodeFiles property.
     * 
     * @param value
     *     allowed object is
     *     {@link TranscodeFiles }
     *     
     */
    public void setTranscodeFiles(TranscodeFiles value) {
        this.transcodeFiles = value;
    }

    /**
     * Gets the value of the id property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getId() {
        return id;
    }

    /**
     * Sets the value of the id property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setId(String value) {
        this.id = value;
    }

}
