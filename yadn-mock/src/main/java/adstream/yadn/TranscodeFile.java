
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
 *         &lt;element ref="{urn:adstream:yadn}FileID"/>
 *         &lt;element ref="{urn:adstream:yadn}FileDirectory"/>
 *         &lt;element ref="{urn:adstream:yadn}FileName"/>
 *         &lt;element ref="{urn:adstream:yadn}FileSize"/>
 *         &lt;element ref="{urn:adstream:yadn}SpecDBDocID"/>
 *         &lt;element ref="{urn:adstream:yadn}TranscodeProperties"/>
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
    "fileID",
    "fileDirectory",
    "fileName",
    "fileSize",
    "specDBDocID",
    "transcodeProperties"
})
@XmlRootElement(name = "TranscodeFile", namespace = "urn:adstream:yadn")
public class TranscodeFile {

    @XmlElement(name = "FileID", namespace = "urn:adstream:yadn", required = true)
    protected String fileID;
    @XmlElement(name = "FileDirectory", namespace = "urn:adstream:yadn", required = true)
    protected String fileDirectory;
    @XmlElement(name = "FileName", namespace = "urn:adstream:yadn", required = true)
    protected String fileName;
    @XmlElement(name = "FileSize", namespace = "urn:adstream:yadn")
    protected long fileSize;
    @XmlElement(name = "SpecDBDocID", namespace = "urn:adstream:yadn", required = true)
    protected String specDBDocID;
    @XmlElement(name = "properties", namespace = "urn:adstream:yadn", required = true)
    protected TranscodeProperties transcodeProperties;
    @XmlAttribute(name = "id")
    protected String id;

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
     * Gets the value of the fileDirectory property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getFileDirectory() {
        return fileDirectory;
    }

    /**
     * Sets the value of the fileDirectory property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setFileDirectory(String value) {
        this.fileDirectory = value;
    }

    /**
     * Gets the value of the fileName property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getFileName() {
        return fileName;
    }

    /**
     * Sets the value of the fileName property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setFileName(String value) {
        this.fileName = value;
    }

    /**
     * Gets the value of the fileSize property.
     * 
     */
    public long getFileSize() {
        return fileSize;
    }

    /**
     * Sets the value of the fileSize property.
     * 
     */
    public void setFileSize(long value) {
        this.fileSize = value;
    }

    /**
     * Gets the value of the specDBDocID property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getSpecDBDocID() {
        return specDBDocID;
    }

    /**
     * Sets the value of the specDBDocID property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setSpecDBDocID(String value) {
        this.specDBDocID = value;
    }

    /**
     * Gets the value of the transcodeProperties property.
     * 
     * @return
     *     possible object is
     *     {@link TranscodeProperties }
     *     
     */
    public TranscodeProperties getTranscodeProperties() {
        return transcodeProperties;
    }

    /**
     * Sets the value of the transcodeProperties property.
     * 
     * @param value
     *     allowed object is
     *     {@link TranscodeProperties }
     *     
     */
    public void setTranscodeProperties(TranscodeProperties value) {
        this.transcodeProperties = value;
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
