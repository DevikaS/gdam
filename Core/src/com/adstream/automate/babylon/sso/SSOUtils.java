package com.adstream.automate.babylon.sso;

import com.adstream.automate.utils.IO;
import com.adstream.automate.utils.Xml;
import org.apache.commons.codec.binary.Base64;
import org.w3c.dom.Document;
import org.xml.sax.InputSource;

import javax.xml.crypto.MarshalException;
import javax.xml.crypto.dsig.*;
import javax.xml.crypto.dsig.dom.DOMSignContext;
import javax.xml.crypto.dsig.keyinfo.KeyInfo;
import javax.xml.crypto.dsig.keyinfo.KeyInfoFactory;
import javax.xml.crypto.dsig.keyinfo.KeyValue;
import javax.xml.crypto.dsig.spec.C14NMethodParameterSpec;
import javax.xml.crypto.dsig.spec.TransformParameterSpec;
import javax.xml.parsers.SAXParser;
import javax.xml.parsers.SAXParserFactory;
import java.io.File;
import java.io.StringReader;
import java.net.URL;
import java.security.*;
import java.security.interfaces.RSAPrivateCrtKey;
import java.security.spec.InvalidKeySpecException;
import java.security.spec.PKCS8EncodedKeySpec;
import java.security.spec.RSAPublicKeySpec;
import java.util.Arrays;
import java.util.Collections;
import java.util.Date;
import java.util.zip.DataFormatException;
import java.util.zip.Deflater;
import java.util.zip.Inflater;

/**
 * User: ruslan.semerenko
 * Date: 23.10.12 11:13
 */
public class SSOUtils {
    public static String decodeSamlMessage(String message) {
        byte[] binary = Base64.decodeBase64(message);
        Inflater inf = new Inflater();
        inf.setInput(binary);
        byte[] buffer = new byte[4096];
        int length;
        StringBuilder out = new StringBuilder();
        try {
            while ((length = inf.inflate(buffer)) > 0) {
                out.append(new String(buffer, 0, length));
            }
        } catch (DataFormatException e) {
            e.printStackTrace();
            return null;
        }
        return out.toString();
    }

    public static SSOProfile parseProfile(String xmlMessage) {
        try {
            SAXParserFactory factory = SAXParserFactory.newInstance();
            SAXParser parser = factory.newSAXParser();
            SamlResponseSaxHandler handler = new SamlResponseSaxHandler();
            parser.parse(new InputSource(new StringReader(xmlMessage)), handler);
            return handler.getResult();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public static String generateSamlRequest(URL ssoUrl, URL applicationUrl, File privateKeyFile) {
        String xml = String.format("<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"no\"?>\n" +
                "<!DOCTYPE AuthnRequest [\n" +
                "<!ELEMENT AuthnRequest (#PCDATA)>\n" +
                "<!ATTLIST AuthnRequest ID ID #IMPLIED>\n" +
                "]>\n" +
                "<AuthnRequest xmlns=\"urn:oasis:names:tc:SAML:2.0:protocol\" ID=\"login\" Destination=\"%1$s\" IssueInstant=\"%2$tY-%2$tm-%2$tdT%2$tH:%2$tM:%2$tSZ\" Version=\"2.0\">\n" +
                "\t<Issuer xmlns=\"urn:oasis:names:tc:SAML:2.0:assertion\">%3$s/ssoRequest</Issuer>\n" +
                "</AuthnRequest>", ssoUrl.toString(), new Date(), applicationUrl.toString().replace(applicationUrl.getPath(), ""));

        String signedXml;
        try {
            KeyPair kp = extractKeys(privateKeyFile);
            Document xmlDoc = Xml.parseXml(xml);
            signDocument(xmlDoc, kp);
            signedXml = Xml.documentToString(xmlDoc);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }

        byte[] data = new byte[4096];
        Deflater def = new Deflater();
        def.setInput(signedXml.getBytes());
        def.finish();
        int length = def.deflate(data);
        return Base64.encodeBase64String(Arrays.copyOf(data, length)).replace("\r\n", "");
    }

    private static KeyPair extractKeys(File privateKeyFile) throws NoSuchAlgorithmException, InvalidKeySpecException {
        byte[] privateKeyBytes = IO.readFile(privateKeyFile);
        PKCS8EncodedKeySpec keySpec = new PKCS8EncodedKeySpec(privateKeyBytes);
        KeyFactory kf = KeyFactory.getInstance("RSA");
        RSAPrivateCrtKey privateKey = (RSAPrivateCrtKey) kf.generatePrivate(keySpec);
        RSAPublicKeySpec publicKeySpec = new RSAPublicKeySpec(privateKey.getModulus(), privateKey.getPublicExponent());
        PublicKey publicKey = kf.generatePublic(publicKeySpec);
        return new KeyPair(publicKey, privateKey);
    }

    private static void signDocument(Document xmlDoc, KeyPair kp) throws NoSuchAlgorithmException, InvalidAlgorithmParameterException, KeyException, MarshalException, XMLSignatureException {
        DOMSignContext dsc = new DOMSignContext(kp.getPrivate(), xmlDoc.getDocumentElement());
        XMLSignatureFactory xsf = XMLSignatureFactory.getInstance("DOM");
        Reference ref = xsf.newReference("", xsf.newDigestMethod(DigestMethod.SHA1, null),
                Collections.singletonList(xsf.newTransform(Transform.ENVELOPED, (TransformParameterSpec) null)),
                null, null);
        SignedInfo si = xsf.newSignedInfo(
                xsf.newCanonicalizationMethod(
                        CanonicalizationMethod.INCLUSIVE_WITH_COMMENTS,
                        (C14NMethodParameterSpec) null),
                xsf.newSignatureMethod(SignatureMethod.RSA_SHA1, null),
                Collections.singletonList(ref));
        KeyInfoFactory kif = xsf.getKeyInfoFactory();
        KeyValue kv = kif.newKeyValue(kp.getPublic());
        KeyInfo ki = kif.newKeyInfo(Collections.singletonList(kv));
        XMLSignature signature = xsf.newXMLSignature(si, ki);
        signature.sign(dsc);
    }
}
