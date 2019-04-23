package com.adstream.automate.babylon.yadn;

import adstream.yadn.ObjectFactory;
import adstream.yadn.Property;
import com.google.common.collect.ImmutableMap;
import java.util.List;
import java.util.Map;

import static java.util.Arrays.asList;

/**
 * Created with IntelliJ IDEA.
 * User: savitskiy-a
 * Date: 06.08.13
 * Time: 17:33
 * To change this template use File | Settings | File Templates.
 */
public class SpecMap {
    protected static ImmutableMap<String, List<Property>> map =  ImmutableMap.of(
                    "image",generateImageProperty(),
                    "pdf",generatePdfProperty(),
                    "video",generateVideoProperty()
            );

    public static Map<String, List<Property>> getMap(){
        return map;
    }

    protected  static List<Property> generateVideoProperty(){
        Property exifProperty = new ObjectFactory().createProperty();
        exifProperty.setName("evaluation_exiftool");
        exifProperty.setValue("<rdf:RDF xmlns:rdf=\"http://www.w3.org/1999/02/22-rdf-syntax-ns#\">\n" +
                "\n" +
                "<rdf:Description xmlns:et=\"http://ns.exiftool.ca/1.0/\" xmlns:ExifTool=\"http://ns.exiftool.ca/ExifTool/1.0/\" xmlns:System=\"http://ns.exiftool.ca/File/System/1.0/\" xmlns:File=\"http://ns.exiftool.ca/File/1.0/\" xmlns:MPEG=\"http://ns.exiftool.ca/MPEG/MPEG/1.0/\" xmlns:Composite=\"http://ns.exiftool.ca/Composite/1.0/\" rdf:about=\"/media/yadn/input/20120921/505c0407e4b0ac262b6abf13/1348209301531/c39f740d-2b42-ba3b-eefa-e945042754f5.mpg\" et:toolkit=\"Image::ExifTool 8.93\">\n" +
                " <ExifTool:ExifToolVersion>8.93</ExifTool:ExifToolVersion>\n" +
                " <System:FileName>c39f740d-2b42-ba3b-eefa-e945042754f5.mpg</System:FileName>\n" +
                " <System:Directory>/media/yadn/input/20120921/505c0407e4b0ac262b6abf13/1348209301531</System:Directory>\n" +
                " <System:FileSize>15 MB</System:FileSize>\n" +
                " <System:FileModifyDate>2010:09:28 20:35:34+03:00</System:FileModifyDate>\n" +
                " <System:FilePermissions>rwxrwxrwx</System:FilePermissions>\n" +
                " <File:FileType>MPEG</File:FileType>\n" +
                " <File:MIMEType>video/mpeg</File:MIMEType>\n" +
                " <MPEG:MPEGAudioVersion>1</MPEG:MPEGAudioVersion>\n" +
                " <MPEG:AudioLayer>1</MPEG:AudioLayer>\n" +
                " <MPEG:AudioBitrate>96 kbps</MPEG:AudioBitrate>\n" +
                " <MPEG:SampleRate>44100</MPEG:SampleRate>\n" +
                " <MPEG:ChannelMode>Stereo</MPEG:ChannelMode>\n" +
                " <MPEG:ModeExtension>Bands 4-31</MPEG:ModeExtension>\n" +
                " <MPEG:CopyrightFlag>False</MPEG:CopyrightFlag>\n" +
                " <MPEG:OriginalMedia>False</MPEG:OriginalMedia>\n" +
                " <MPEG:Emphasis>None</MPEG:Emphasis>\n" +
                " <MPEG:ImageWidth>352</MPEG:ImageWidth>\n" +
                " <MPEG:ImageHeight>288</MPEG:ImageHeight>\n" +
                " <MPEG:AspectRatio>4:3, 625 line, PAL, CCIR601</MPEG:AspectRatio>\n" +
                " <MPEG:FrameRate>25 fps</MPEG:FrameRate>\n" +
                " <MPEG:VideoBitrate>1.15 Mbps</MPEG:VideoBitrate>\n" +
                " <Composite:Duration>0:01:42 (approx)</Composite:Duration>\n" +
                " <Composite:ImageSize>352x288</Composite:ImageSize>\n" +
                "</rdf:Description>\n" +
                "</rdf:RDF>");
        Property mediaInfoProperty = new ObjectFactory().createProperty();
        mediaInfoProperty.setName("evaluation_MediaInfo");
        mediaInfoProperty.setValue("<Mediainfo xmlns=\"\" version=\"0.7.58\">\n" +
                "<File>\n" +
                "<track type=\"General\">\n" +
                "<Complete_name>/media/yadn/input/20120921/505c0407e4b0ac262b6abf13/1348209301531/c39f740d-2b42-ba3b-eefa-e945042754f5.mpg</Complete_name>\n" +
                "<Format>MPEG-PS</Format>\n" +
                "<File_size>15.3 MiB</File_size>\n" +
                "<Duration>1mn 34s</Duration>\n" +
                "<Overall_bit_rate>1 362 Kbps</Overall_bit_rate>\n" +
                "</track>\n" +
                "\n" +
                "<track type=\"Video\">\n" +
                "<ID>224 (0xE0)</ID>\n" +
                "<Format>MPEG Video</Format>\n" +
                "<Format_version>Version 1</Format_version>\n" +
                "<Format_settings__BVOP>Yes</Format_settings__BVOP>\n" +
                "<Format_settings__Matrix>Default</Format_settings__Matrix>\n" +
                "<Duration>1mn 34s</Duration>\n" +
                "<Bit_rate>1 150 Kbps</Bit_rate>\n" +
                "<Width>352 pixels</Width>\n" +
                "<Height>288 pixels</Height>\n" +
                "<Display_aspect_ratio>4:3</Display_aspect_ratio>\n" +
                "<Frame_rate>25.000 fps</Frame_rate>\n" +
                "<Standard>PAL</Standard>\n" +
                "<Color_space>YUV</Color_space>\n" +
                "<Bit_depth>8 bits</Bit_depth>\n" +
                "<Scan_type>Progressive</Scan_type>\n" +
                "<Compression_mode>Lossy</Compression_mode>\n" +
                "<Bits__Pixel_Frame_>0.454</Bits__Pixel_Frame_>\n" +
                "<Stream_size>12.8 MiB (84%)</Stream_size>\n" +
                "</track>\n" +
                "\n" +
                "<track type=\"Audio\">\n" +
                "<ID>192 (0xC0)</ID>\n" +
                "<Format>MPEG Audio</Format>\n" +
                "<Format_version>Version 1</Format_version>\n" +
                "<Format_profile>Layer 2</Format_profile>\n" +
                "<Duration>1mn 33s</Duration>\n" +
                "<Bit_rate_mode>Constant</Bit_rate_mode>\n" +
                "<Bit_rate>192 Kbps</Bit_rate>\n" +
                "<Channel_s_>2 channels</Channel_s_>\n" +
                "<Sampling_rate>44.1 KHz</Sampling_rate>\n" +
                "<Compression_mode>Lossy</Compression_mode>\n" +
                "<Delay_relative_to_video>-80ms</Delay_relative_to_video>\n" +
                "<Stream_size>2.15 MiB (14%)</Stream_size>\n" +
                "</track>\n" +
                "\n" +
                "</File>\n" +
                "</Mediainfo>");
        return asList(exifProperty, mediaInfoProperty);
    }
    protected  static List<Property> generatePdfProperty(){
        Property exifProperty = new ObjectFactory().createProperty();
        exifProperty.setName("evaluation_exiftool");
        exifProperty.setValue("<rdf:RDF xmlns:rdf=\"http://www.w3.org/1999/02/22-rdf-syntax-ns#\">\n" +
                "\n" +
                "<rdf:Description xmlns:et=\"http://ns.exiftool.ca/1.0/\" xmlns:ExifTool=\"http://ns.exiftool.ca/ExifTool/1.0/\" xmlns:System=\"http://ns.exiftool.ca/File/System/1.0/\" xmlns:File=\"http://ns.exiftool.ca/File/1.0/\" xmlns:PDF=\"http://ns.exiftool.ca/PDF/PDF/1.0/\" xmlns:XMP-x=\"http://ns.exiftool.ca/XMP/XMP-x/1.0/\" xmlns:XMP-rdf=\"http://ns.exiftool.ca/XMP/XMP-rdf/1.0/\" xmlns:XMP-pdf=\"http://ns.exiftool.ca/XMP/XMP-pdf/1.0/\" xmlns:XMP-xmp=\"http://ns.exiftool.ca/XMP/XMP-xmp/1.0/\" xmlns:XMP-xmpMM=\"http://ns.exiftool.ca/XMP/XMP-xmpMM/1.0/\" xmlns:XMP-dc=\"http://ns.exiftool.ca/XMP/XMP-dc/1.0/\" rdf:about=\"/media/yadn/input/20120719/5007b5eee4b009d3f110f37a/1342690888439/a35ade15-dc03-5cb2-3ace-c8bdf2d6ff1a.pdf\" et:toolkit=\"Image::ExifTool 8.93\">\n" +
                " <ExifTool:ExifToolVersion>8.93</ExifTool:ExifToolVersion>\n" +
                " <System:FileName>a35ade15-dc03-5cb2-3ace-c8bdf2d6ff1a.pdf</System:FileName>\n" +
                " <System:Directory>/media/yadn/input/20120719/5007b5eee4b009d3f110f37a/1342690888439</System:Directory>\n" +
                " <System:FileSize>218 kB</System:FileSize>\n" +
                " <System:FileModifyDate>2011:11:18 14:23:20+02:00</System:FileModifyDate>\n" +
                " <System:FilePermissions>rwxrwxrwx</System:FilePermissions>\n" +
                " <File:FileType>PDF</File:FileType>\n" +
                " <File:MIMEType>application/pdf</File:MIMEType>\n" +
                " <PDF:PDFVersion>1.5</PDF:PDFVersion>\n" +
                " <PDF:Linearized>No</PDF:Linearized>\n" +
                " <PDF:PageCount>31</PDF:PageCount>\n" +
                " <PDF:ModifyDate>2006:07:05 14:46:03+02:00</PDF:ModifyDate>\n" +
                " <PDF:CreateDate>22 April 1999 15:34</PDF:CreateDate>\n" +
                " <PDF:Title>EBU Tech 3264-1991 EBU subtitling data exchange format</PDF:Title>\n" +
                " <PDF:Creator>Microsoft Word </PDF:Creator>\n" +
                " <PDF:Author>EBU</PDF:Author>\n" +
                " <PDF:Keywords>\n" +
                "  <rdf:Bag>\n" +
                "   <rdf:li>EBU</rdf:li>\n" +
                "   <rdf:li>Tech</rdf:li>\n" +
                "   <rdf:li>3264-1991</rdf:li>\n" +
                "   <rdf:li>Specification</rdf:li>\n" +
                "   <rdf:li>of</rdf:li>\n" +
                "   <rdf:li>the</rdf:li>\n" +
                "   <rdf:li>EBU</rdf:li>\n" +
                "   <rdf:li>subtitling</rdf:li>\n" +
                "   <rdf:li>data</rdf:li>\n" +
                "   <rdf:li>exchange</rdf:li>\n" +
                "   <rdf:li>format</rdf:li>\n" +
                "  </rdf:Bag>\n" +
                " </PDF:Keywords>\n" +
                " <PDF:Subject>Specification of the EBU subtitling data exchange format</PDF:Subject>\n" +
                " <PDF:Producer>Acrobat PDFWriter 3.0 for Windows</PDF:Producer>\n" +
                " <PDF:CreationDate--Text>22 April 1999 15:34</PDF:CreationDate--Text>\n" +
                " <XMP-x:XMPToolkit>XMP toolkit 2.9.1-13, framework 1.6</XMP-x:XMPToolkit>\n" +
                " <XMP-rdf:About>uuid:218c57f0-347f-42f8-9f8c-2006a2ee7075</XMP-rdf:About>\n" +
                " <XMP-pdf:CreationDate--Text>22 April 1999 15:34</XMP-pdf:CreationDate--Text>\n" +
                " <XMP-pdf:Producer>Acrobat PDFWriter 3.0 for Windows</XMP-pdf:Producer>\n" +
                " <XMP-pdf:Keywords>EBU Tech 3264-1991 Specification of the EBU subtitling data exchange format</XMP-pdf:Keywords>\n" +
                " <XMP-xmp:ModifyDate>2006:07:05 14:46:03+02:00</XMP-xmp:ModifyDate>\n" +
                " <XMP-xmp:CreatorTool>Microsoft Word </XMP-xmp:CreatorTool>\n" +
                " <XMP-xmp:MetadataDate>2006:07:05 14:46:03+02:00</XMP-xmp:MetadataDate>\n" +
                " <XMP-xmpMM:DocumentID>uuid:b04e1948-5283-4e50-94f2-4cafd1904c25</XMP-xmpMM:DocumentID>\n" +
                " <XMP-dc:Format>application/pdf</XMP-dc:Format>\n" +
                " <XMP-dc:Title>EBU Tech 3264-1991 EBU subtitling data exchange format</XMP-dc:Title>\n" +
                " <XMP-dc:Creator>EBU</XMP-dc:Creator>\n" +
                " <XMP-dc:Description>Specification of the EBU subtitling data exchange format</XMP-dc:Description>\n" +
                "</rdf:Description>\n" +
                "</rdf:RDF>");
        Property pdfDimentionsProperty = new ObjectFactory().createProperty();
        pdfDimentionsProperty.setName("evaluation_pdfdimensions");
        pdfDimentionsProperty.setValue("<pdfdimensions xmlns=\"\">\n" +
                " <page number=\"1\">\n" +
                "  <width>595</width>\n" +
                "  <height>842</height>\n" +
                "  <x_resolution>72 Undefined</x_resolution>\n" +
                "  <y_resolution>72 Undefined</y_resolution>\n" +
                "  <canvas_width>595</canvas_width>\n" +
                "  <canvas_height>842</canvas_height>\n" +
                "  <canvas_offset_x>+0</canvas_offset_x>\n" +
                "  <canvas_offset_y>+0</canvas_offset_y>\n" +
                " </page>\n" +
                " <page number=\"2\">\n" +
                "  <width>595</width>\n" +
                "  <height>842</height>\n" +
                "  <x_resolution>72 Undefined</x_resolution>\n" +
                "  <y_resolution>72 Undefined</y_resolution>\n" +
                "  <canvas_width>595</canvas_width>\n" +
                "  <canvas_height>842</canvas_height>\n" +
                "  <canvas_offset_x>+0</canvas_offset_x>\n" +
                "  <canvas_offset_y>+0</canvas_offset_y>\n" +
                " </page>\n" +
                " <page number=\"3\">\n" +
                "  <width>595</width>\n" +
                "  <height>842</height>\n" +
                "  <x_resolution>72 Undefined</x_resolution>\n" +
                "  <y_resolution>72 Undefined</y_resolution>\n" +
                "  <canvas_width>595</canvas_width>\n" +
                "  <canvas_height>842</canvas_height>\n" +
                "  <canvas_offset_x>+0</canvas_offset_x>\n" +
                "  <canvas_offset_y>+0</canvas_offset_y>\n" +
                " </page>\n" +
                "</pdfdimensions>");
        return asList(exifProperty, pdfDimentionsProperty);
    }
    protected  static List<Property> generateImageProperty(){
        Property exifProperty = new ObjectFactory().createProperty();
        exifProperty.setName("evaluation_exiftool");
        exifProperty.setValue("<rdf:RDF xmlns:rdf=\"http://www.w3.org/1999/02/22-rdf-syntax-ns#\">\n" +
                "<rdf:Description xmlns:et=\"http://ns.exiftool.ca/1.0/\" xmlns:ExifTool=\"http://ns.exiftool.ca/ExifTool/1.0/\" xmlns:System=\"http://ns.exiftool.ca/File/System/1.0/\" xmlns:File=\"http://ns.exiftool.ca/File/1.0/\" xmlns:JFIF=\"http://ns.exiftool.ca/JFIF/JFIF/1.0/\" xmlns:Composite=\"http://ns.exiftool.ca/Composite/1.0/\" rdf:about=\"/media/yadn/input/20120724/500e6936e4b00e34ff5b6ebf/1343138974152/4ab6bf25-f99b-56f8-8b28-da7aee0efe57.jpg\" et:toolkit=\"Image::ExifTool 8.93\">\n" +
                " <ExifTool:ExifToolVersion>8.93</ExifTool:ExifToolVersion>\n" +
                " <System:FileName>4ab6bf25-f99b-56f8-8b28-da7aee0efe57.jpg</System:FileName>\n" +
                " <System:Directory>/media/yadn/input/20120724/500e6936e4b00e34ff5b6ebf/1343138974152</System:Directory>\n" +
                " <System:FileSize>110 kB</System:FileSize>\n" +
                " <System:FileModifyDate>2012:03:07 14:48:10+02:00</System:FileModifyDate>\n" +
                " <System:FilePermissions>rwxrwxrwx</System:FilePermissions>\n" +
                " <File:FileType>JPEG</File:FileType>\n" +
                " <File:MIMEType>image/jpeg</File:MIMEType>\n" +
                " <File:ImageWidth>562</File:ImageWidth>\n" +
                " <File:ImageHeight>618</File:ImageHeight>\n" +
                " <File:EncodingProcess>Baseline DCT, Huffman coding</File:EncodingProcess>\n" +
                " <File:BitsPerSample>8</File:BitsPerSample>\n" +
                " <File:ColorComponents>3</File:ColorComponents>\n" +
                " <File:YCbCrSubSampling>YCbCr4:2:0 (2 2)</File:YCbCrSubSampling>\n" +
                " <JFIF:JFIFVersion>1.01</JFIF:JFIFVersion>\n" +
                " <JFIF:ResolutionUnit>None</JFIF:ResolutionUnit>\n" +
                " <JFIF:XResolution>300</JFIF:XResolution>\n" +
                " <JFIF:YResolution>300</JFIF:YResolution>\n" +
                " <Composite:ImageSize>562x618</Composite:ImageSize>\n" +
                "</rdf:Description>\n" +
                "</rdf:RDF>");
        return asList(exifProperty);
    }


}
