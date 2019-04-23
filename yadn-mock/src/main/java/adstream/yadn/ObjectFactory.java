
package adstream.yadn;

import javax.xml.bind.JAXBElement;
import javax.xml.bind.annotation.XmlElementDecl;
import javax.xml.bind.annotation.XmlRegistry;
import javax.xml.namespace.QName;


/**
 * This object contains factory methods for each 
 * Java content interface and Java element interface 
 * generated in the adstream.yadn2 package. 
 * <p>An ObjectFactory allows you to programatically 
 * construct new instances of the Java representation 
 * for XML content. The Java representation of XML 
 * content can consist of schema derived interfaces 
 * and classes representing the binding of schema 
 * type definitions, element declarations and model 
 * groups.  Factory methods for each of these are 
 * provided in this class.
 * 
 */
@XmlRegistry
public class ObjectFactory {

    private final static QName _ExternalID_QNAME = new QName("urn:adstream:yadn", "ExternalID");
    private final static QName _File_QNAME = new QName("urn:adstream:yadn", "File");
    private final static QName _IsDefault_QNAME = new QName("urn:adstream:yadn", "IsDefault");
    private final static QName _Archive_QNAME = new QName("urn:adstream:yadn", "Archive");
    private final static QName _Value_QNAME = new QName("urn:adstream:yadn", "Value");
    private final static QName _SpecDBDocID_QNAME = new QName("urn:adstream:yadn", "SpecDBDocID");
    private final static QName _FileID_QNAME = new QName("urn:adstream:yadn", "FileID");
    private final static QName _Node_QNAME = new QName("urn:adstream:yadn", "Node");
    private final static QName _FileStorage_QNAME = new QName("urn:adstream:yadn", "FileStorage");
    private final static QName _MessageID_QNAME = new QName("urn:adstream:yadn", "MessageID");
    private final static QName _FileName_QNAME = new QName("urn:adstream:yadn", "FileName");
    private final static QName _Status_QNAME = new QName("urn:adstream:yadn", "Status");
    private final static QName _FileDirectory_QNAME = new QName("urn:adstream:yadn", "FileDirectory");
    private final static QName _FileSize_QNAME = new QName("urn:adstream:yadn", "FileSize");
    private final static QName _System_QNAME = new QName("urn:adstream:yadn", "System");

    /**
     * Create a new ObjectFactory that can be used to create new instances of schema derived classes for package: adstream.yadn2
     * 
     */
    public ObjectFactory() {
    }

    /**
     * Create an instance of {@link TranscodeFiles }
     * 
     */
    public TranscodeFiles createTranscodeFiles() {
        return new TranscodeFiles();
    }

    /**
     * Create an instance of {@link TranscodeFile }
     * 
     */
    public TranscodeFile createTranscodeFile() {
        return new TranscodeFile();
    }

    /**
     * Create an instance of {@link Properties }
     * 
     */
    public Properties createProperties() {
        return new Properties();
    }

    /**
     * Create an instance of {@link adstream.yadn.TranscodeProperties }
     *
     */
    public TranscodeProperties createTranscodeProperties() {
        return new TranscodeProperties();
    }

    /**
     * Create an instance of {@link adstream.yadn.TranscodeProperty }
     *
     */
    public TranscodeProperty createTranscodeProperty() {
        return new TranscodeProperty();
    }

    /**
     * Create an instance of {@link Property }
     * 
     */
    public Property createProperty() {
        return new Property();
    }

    /**
     * Create an instance of {@link Upload }
     * 
     */
    public Upload createUpload() {
        return new Upload();
    }

    /**
     * Create an instance of {@link Metadata }
     * 
     */
    public Metadata createMetadata() {
        return new Metadata();
    }

    /**
     * Create an instance of {@link TranscodeJobResponse }
     * 
     */
    public TranscodeJobResponse createTranscodeJobResponse() {
        return new TranscodeJobResponse();
    }

    /**
     * Create an instance of {@link UploadJobResponse }
     *
     */
    public UploadJobResponse createUploadJobResponse() {
        return new UploadJobResponse();
    }

    /**
     * Create an instance of {@link PropertyType }
     *
     */
    public PropertyType createPropertyType() {
        return new PropertyType();
    }

    /**
     * Create an instance of {@link MetadataType }
     *
     */
    public MetadataType createMetadataType() {
        return new MetadataType();
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link String }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "urn:adstream:yadn", name = "ExternalID")
    public JAXBElement<String> createExternalID(String value) {
        return new JAXBElement<String>(_ExternalID_QNAME, String.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link String }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "urn:adstream:yadn", name = "File")
    public JAXBElement<String> createFile(String value) {
        return new JAXBElement<String>(_File_QNAME, String.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link String }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "urn:adstream:yadn", name = "IsDefault")
    public JAXBElement<String> createIsDefault(String value) {
        return new JAXBElement<String>(_IsDefault_QNAME, String.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link String }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "urn:adstream:yadn", name = "Archive")
    public JAXBElement<String> createArchive(String value) {
        return new JAXBElement<String>(_Archive_QNAME, String.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link String }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "urn:adstream:yadn", name = "Value")
    public JAXBElement<String> createValue(String value) {
        return new JAXBElement<String>(_Value_QNAME, String.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link String }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "urn:adstream:yadn", name = "SpecDBDocID")
    public JAXBElement<String> createSpecDBDocID(String value) {
        return new JAXBElement<String>(_SpecDBDocID_QNAME, String.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link String }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "urn:adstream:yadn", name = "FileID")
    public JAXBElement<String> createFileID(String value) {
        return new JAXBElement<String>(_FileID_QNAME, String.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link String }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "urn:adstream:yadn", name = "Node")
    public JAXBElement<String> createNode(String value) {
        return new JAXBElement<String>(_Node_QNAME, String.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link String }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "urn:adstream:yadn", name = "FileStorage")
    public JAXBElement<String> createFileStorage(String value) {
        return new JAXBElement<String>(_FileStorage_QNAME, String.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link String }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "urn:adstream:yadn", name = "MessageID")
    public JAXBElement<String> createMessageID(String value) {
        return new JAXBElement<String>(_MessageID_QNAME, String.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link String }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "urn:adstream:yadn", name = "FileName")
    public JAXBElement<String> createFileName(String value) {
        return new JAXBElement<String>(_FileName_QNAME, String.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link String }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "urn:adstream:yadn", name = "Status")
    public JAXBElement<String> createStatus(String value) {
        return new JAXBElement<String>(_Status_QNAME, String.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link String }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "urn:adstream:yadn", name = "FileDirectory")
    public JAXBElement<String> createFileDirectory(String value) {
        return new JAXBElement<String>(_FileDirectory_QNAME, String.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link Long }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "urn:adstream:yadn", name = "FileSize")
    public JAXBElement<Long> createFileSize(Long value) {
        return new JAXBElement<Long>(_FileSize_QNAME, Long.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link String }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "urn:adstream:yadn", name = "System")
    public JAXBElement<String> createSystem(String value) {
        return new JAXBElement<String>(_System_QNAME, String.class, null, value);
    }

}
