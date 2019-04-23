package com.adstream.automate.babylon.data;

import org.apache.commons.io.FileUtils;
import org.apache.commons.io.IOUtils;
import org.apache.commons.codec.binary.Base64;
import javax.activation.MimetypesFileTypeMap;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;

/**
 * User: ruslan.semerenko
 * Date: 21.05.12 14:13
 */
public enum Logo {
    EMPTY("EMPTY", "test-data-default/images/empty.logo.png"),
    EMPTY_PROJECT_LOGO("EMPTY_PROJECT_LOGO", "test-data-default/images/empty.project.logo.png"),
    GIF("GIF", "test-data-default/images/logo.gif"),
    JPG("JPG", "test-data-default/images/logo.jpg"),
    JPEG("JPEG", "test-data-default/images/logo.jpeg"),
    PNG("PNG", "test-data-default/images/logo.png"),
    BMP("BMP", "test-data-default/images/logo.bmp"),
    ADSTREAM("ADSTREAM", "test-data-default/images/adstream.png"),
    BEAM("BEAM", "test-data-default/images/beam.png"),
    OVER10K("OVER10K", "test-data-default/images/big.logo.png"),
    TXT("TXT", "test-data-default/images/text.txt");

    private String fileName;
    private String name;
    private File tmpFile;

    private Logo(String name, String fileName) {
        this.fileName = fileName;
        this.name = name;
    }

    @Override
    public String toString() {
        return name;
    }

    public String getPath() {
        //file can be in jar, so we need to create it
        if (tmpFile == null) {
            try {
                tmpFile = File.createTempFile("logo", fileName.substring(fileName.lastIndexOf(".")));
                FileUtils.writeByteArrayToFile(tmpFile, getBytes());
                tmpFile.deleteOnExit();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        return tmpFile != null ? tmpFile.getPath() : "";
    }

    public byte[] getBytes() {
        InputStream is = this.getClass().getClassLoader().getResourceAsStream(fileName);
        try {
            return IOUtils.toByteArray(is);
        } catch (IOException e) {
            e.printStackTrace();
            return new byte[0];
        }
    }

    public byte[] getBase64() {
        return Base64.encodeBase64(getBytes());
    }

    public String getBase64String() {
        return Base64.encodeBase64String(getBytes());
    }

    public String getMimeType() {
        return new MimetypesFileTypeMap().getContentType(fileName);
    }
}