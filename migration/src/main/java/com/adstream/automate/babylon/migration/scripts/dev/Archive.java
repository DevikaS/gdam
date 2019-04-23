package com.adstream.automate.babylon.migration.scripts.dev;

import com.adstream.automate.babylon.migration.scripts.FullMigrationScript;
import org.apache.commons.compress.archivers.ArchiveException;
import org.apache.commons.compress.archivers.ArchiveInputStream;
import org.apache.commons.compress.archivers.ArchiveStreamFactory;
import org.apache.commons.compress.archivers.sevenz.SevenZArchiveEntry;
import org.apache.commons.compress.archivers.sevenz.SevenZFile;
import org.apache.commons.compress.archivers.zip.ZipArchiveEntry;
import org.apache.commons.compress.compressors.CompressorOutputStream;
import org.apache.commons.compress.compressors.CompressorStreamFactory;
import org.apache.commons.io.IOUtils;
import org.apache.log4j.Logger;

import java.io.*;
import java.util.Enumeration;
import java.util.zip.ZipEntry;
import java.util.zip.ZipFile;
import java.util.zip.ZipInputStream;

/**
 * Created with IntelliJ IDEA.
 * User: solomin-y
 * Date: 3/18/15
 * Time: 5:30 PM

 */
public class Archive {

    private static Logger log = Logger.getLogger(Archive.class);

    public static void extract7z(String archiveName) throws IOException {
        File archive = new File(archiveName);
        SevenZFile sevenZFile = new SevenZFile(archive);
        SevenZArchiveEntry entry = sevenZFile.getNextEntry();
        while(entry!=null){
            FileOutputStream out = new FileOutputStream(archive.getParent() + "/" + entry.getName());
            byte[] content = new byte[(int) entry.getSize()];
            sevenZFile.read(content, 0, content.length);
            out.write(content);
            out.close();
            log.info(entry.getName() + " was extracted");
            entry = sevenZFile.getNextEntry();
        }
        sevenZFile.close();
    }

    public static void extractZip(String archiveName) throws Exception {
        final File input=new File(archiveName);
        final InputStream is=new FileInputStream(input);
        final ArchiveInputStream in=new ArchiveStreamFactory().createArchiveInputStream("zip",is);
        //ZipArchiveEntry entry=(ZipArchiveEntry)in.getNextEntry();
        ZipFile zipFile = new ZipFile(archiveName);
        Enumeration entries = zipFile.entries();
        while (entries.hasMoreElements()) {
            ZipEntry zipEntry = (ZipEntry)entries.nextElement();
            if (!zipEntry.getName().contains("/")) {
                File file = new File(input.getParent() + "/" + zipEntry.getName());
                FileOutputStream fos = null;
                try {
                    fos = new FileOutputStream(file);
                    int n;
                    byte[] buf = new byte[(int) zipEntry.getSize()];
                    InputStream entryContent = zipFile.getInputStream(zipEntry);
                    while ((n = entryContent.read(buf)) != -1) {
                        if (n > 0) {
                            fos.write(buf, 0, n);
                        }
                    }
                } finally {
                    if (fos != null) {
                        fos.close();
                    }
                }

            }

        }
        /*while (entry!= null) {
            if (!entry.getName().contains("/")) {
                File file = new File(input.getParent() + "/" + entry.getName());
                FileOutputStream out = new FileOutputStream(file);
                byte[] buf = new byte[(int) entry.getSize()];
                //InputStream entryContent = zipFile.getInputStream(entry);
                out.write(entry.getLocalFileDataExtra());
                /*InputStream entryContent = ;
                int n;
                while ((n = entryContent.read()) != -1) {
                    if (n > 0) {
                        out.write(buf, 0, n);
                    }
                }

                //out.write(content);
                out.close();
            }
            entry=(ZipArchiveEntry)in.getNextEntry();
        }                    */
    }
}
