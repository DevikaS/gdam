package com.adstream.automate.babylon.utils;

import com.adstream.automate.babylon.TestsContext;
import org.apache.commons.codec.binary.Base64;
import org.apache.commons.io.IOUtils;
import java.security.KeyFactory;
import java.security.PrivateKey;
import java.security.Signature;
import java.security.spec.PKCS8EncodedKeySpec;

//read key from external file and create signature = SamlRequest&RelayState&SignAlg signed with privateKey
public class SignatureCreator {

    public static PrivateKey getPrivateKey(String filename) throws Exception {
        ClassLoader classLoader = SignatureCreator.class.getClassLoader();
        byte[] keyBytes = IOUtils.toByteArray(classLoader.getResourceAsStream(filename));

        PKCS8EncodedKeySpec spec = new PKCS8EncodedKeySpec(keyBytes);
        KeyFactory kf = KeyFactory.getInstance("RSA");
        return kf.generatePrivate(spec);
    }

    public static String sign(String unsignedObject) {
        try {
            //get Private key for perfa5 and preprod machine
            PrivateKey privateKey = getPrivateKey(TestsContext.getInstance().testSSOKeyFile);
            Signature signature = Signature.getInstance("SHA1withRSA");
            signature.initSign(privateKey);

            signature.update(unsignedObject.getBytes());
            byte[] signatureBytes = signature.sign();
            String signatureBase64 = new String(Base64.encodeBase64(signatureBytes, false));
            return signatureBase64;
        }
        catch (Exception e) {
            return e.getMessage();
        }
    }
}