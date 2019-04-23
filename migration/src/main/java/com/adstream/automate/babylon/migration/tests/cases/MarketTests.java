package com.adstream.automate.babylon.migration.tests.cases;

import com.adstream.automate.babylon.JsonObjects.Content;
import com.adstream.automate.babylon.migration.actions.UsersAction;
import com.adstream.automate.babylon.migration.objects.Asset;
import com.adstream.automate.babylon.migration.tests.BaseTest;
import com.adstream.automate.babylon.migration.tests.data.MigrationDataProvider;
import com.adstream.automate.babylon.migration.utils.FileManager;
import com.adstream.automate.babylon.migration.utils.XMLParser;
import org.testng.annotations.Test;

import java.io.File;
import java.util.HashMap;
import java.util.Map;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.comparesEqualTo;
import static org.hamcrest.Matchers.equalTo;
import static org.hamcrest.Matchers.isIn;

/**
 * Created with IntelliJ IDEA.
 * User: solomin-y
 * Date: 1/13/15
 * Time: 11:35 AM

 */
public class MarketTests extends BaseTest {

    private static Map<Integer, String> marketsMap = new HashMap<>();
    private static Map<Integer, String> marketsFieldsMap = new HashMap<>();

    private static void init() {
        marketsMap.put(50, "Test Grouping");
        marketsMap.put(51, "Test Grouping");
        marketsMap.put(53, "Online");
        marketsMap.put(70, "M&C Saatchi");
        marketsMap.put(133, "FORTA");
        marketsMap.put(136, "Pulsa");
        marketsMap.put(137, "PULSA Media");
        marketsMap.put(138, "Procter and Gamble");
        marketsMap.put(153, "new station");
        marketsMap.put(185, "FORTA");
        marketsMap.put(189, "Sky Selection");
        marketsMap.put(190, "UK send");
        marketsMap.put(323, "Q4 2011");
        marketsMap.put(394, "Pauta Tipo Aire (Cap+Int)");
        marketsMap.put(414, "Disney");
        marketsMap.put(416, "Regular Tesco Playout");
        marketsMap.put(492, "Station Group");
        marketsMap.put(509, "ESI Media");
        marketsMap.put(516, "other countries");
        marketsMap.put(526, "SA_destinations");
        marketsMap.put(527, "Southern Africa");
        marketsMap.put(533, "Disney Nordic");
        marketsMap.put(550, "Pauta Tipo Femenina Cable");
        marketsMap.put(551, "Pauta Tipo Masculina Cable");
        marketsMap.put(1, "other countries");
        marketsMap.put(3, "United Kingdom");
        marketsMap.put(4, "Republic of Ireland");
        marketsMap.put(5, "Australia");
        marketsMap.put(6, "Austria");
        marketsMap.put(7, "Belgium");
        marketsMap.put(8, "Czech Republic");
        marketsMap.put(9, "Denmark");
        marketsMap.put(10, "Estonia");
        marketsMap.put(11, "Finland");
        marketsMap.put(12, "France");
        marketsMap.put(13, "Germany");
        marketsMap.put(14, "Greece");
        marketsMap.put(15, "Hungary");
        marketsMap.put(16, "Sweden");
        marketsMap.put(461, "Music Promo UK");
        marketsMap.put(552, "Disney SA Sponsorship");
        marketsMap.put(17, "Spain");
        marketsMap.put(18, "Switzerland");
        marketsMap.put(19, "India");
        marketsMap.put(20, "Italy Pubblicita'");
        marketsMap.put(21, "Latvia");
        marketsMap.put(22, "Lithuania");
        marketsMap.put(23, "Luxembourg");
        marketsMap.put(24, "Netherlands");
        marketsMap.put(25, "Norway");
        marketsMap.put(26, "Poland");
        marketsMap.put(27, "Portugal");
        marketsMap.put(28, "Russia");
        marketsMap.put(29, "South Africa");
        marketsMap.put(31, "China");
        marketsMap.put(33, "Awards");
        marketsMap.put(34, "Clearcast");
        marketsMap.put(35, "Italy Promos (Internal Use Only)");
        marketsMap.put(37, "Bosnia & Herzegovina");
        marketsMap.put(38, "Croatia");
        marketsMap.put(39, "Romania");
        marketsMap.put(40, "Serbia");
        marketsMap.put(41, "Slovenia");
        marketsMap.put(42, "Turkey");
        marketsMap.put(43, "Italy Sky Backhaul");
        marketsMap.put(57, "Italy Special (Internal Use Only)");
        marketsMap.put(77, "New Zealand");
        marketsMap.put(78, "Cyprus");
        marketsMap.put(96, "In-Flight");
        marketsMap.put(125, "Bulgaria");
        marketsMap.put(146, "Montenegro");
        marketsMap.put(160, "Saudi Arabia");
        marketsMap.put(169, "Kazakhstan");
        marketsMap.put(173, "LatAm - Pan Regional Cable (PRC)");
        marketsMap.put(174, "USA - Broadcast Networks");
        marketsMap.put(175, "USA - Cable Networks");
        marketsMap.put(176, "Canada");
        marketsMap.put(177, "US Hispanic");
        marketsMap.put(182, "Kosovo");
        marketsMap.put(183, "Macedonia, Republic of");
        marketsMap.put(184, "Albania");
        marketsMap.put(187, "Viacom Pan European - MTV");
        marketsMap.put(193, "Italy FOX (Internal Use Only)");
        marketsMap.put(195, "Argentina");
        marketsMap.put(196, "Bolivia");
        marketsMap.put(197, "Brasil");
        marketsMap.put(198, "Chile");
        marketsMap.put(199, "Colombia");
        marketsMap.put(200, "Costa Rica");
        marketsMap.put(201, "Dominican Republic");
        marketsMap.put(202, "Ecuador");
        marketsMap.put(203, "El Salvador");
        marketsMap.put(204, "Guatemala");
        marketsMap.put(205, "Honduras");
        marketsMap.put(206, "Mexico");
        marketsMap.put(207, "Nicaragua");
        marketsMap.put(208, "Panama");
        marketsMap.put(209, "Paraguay");
        marketsMap.put(210, "Peru");
        marketsMap.put(211, "Puerto Rico");
        marketsMap.put(212, "Uruguay");
        marketsMap.put(213, "Venezuela");
        marketsMap.put(216, "Eurosport International Pan Euro");
        marketsMap.put(217, "Armenia");
        marketsMap.put(432, "Italy Iniziative Speciali INFOMERCIALS");
        marketsMap.put(218, "Azerbaijan");
        marketsMap.put(219, "Bangladesh");
        marketsMap.put(220, "Egypt");
        marketsMap.put(221, "Kenya");
        marketsMap.put(222, "Nigeria");
        marketsMap.put(223, "Pakistan");
        marketsMap.put(225, "Ukraine");
        marketsMap.put(226, "Uzbekistan");
        marketsMap.put(228, "Hong Kong");
        marketsMap.put(229, "Indonesia");
        marketsMap.put(230, "South Korea");
        marketsMap.put(231, "Malaysia");
        marketsMap.put(232, "Philippines");
        marketsMap.put(233, "Singapore");
        marketsMap.put(234, "Taiwan");
        marketsMap.put(235, "Vietnam");
        marketsMap.put(239, "Belarus");
        marketsMap.put(240, "Israel");
        marketsMap.put(241, "Mozambique");
        marketsMap.put(242, "Tanzania");
        marketsMap.put(243, "Thailand");
        marketsMap.put(244, "Jordan");
        marketsMap.put(245, "Iran");
        marketsMap.put(248, "Uganda");
        marketsMap.put(249, "Pan International");
        marketsMap.put(322, "Iraq");
        marketsMap.put(335, "Lebanon");
        marketsMap.put(341, "Cambodia");
        marketsMap.put(349, "Japan");
        marketsMap.put(351, "Qatar");
        marketsMap.put(352, "United Arab Emirates");
        marketsMap.put(353, "Malta");
        marketsMap.put(354, "Iceland");
        marketsMap.put(355, "Kuwait");
        marketsMap.put(359, "Bahrain");
        marketsMap.put(378, "Viacom Pan Regional Asia - MTV");
        marketsMap.put(399, "Caribbean");
        marketsMap.put(400, "Pan Regional Asia");
        marketsMap.put(404, "Mauritius");
        marketsMap.put(405, "Ghana");
        marketsMap.put(433, "Oman");
        marketsMap.put(435, "Morocco");
        marketsMap.put(451, "Myanmar");
        marketsMap.put(462, "Music Promo Italy");
        marketsMap.put(464, "Music Promo Greece");
        marketsMap.put(465, "Music Promo Spain");
        marketsMap.put(468, "Namibia");
        marketsMap.put(469, "Botswana");
        marketsMap.put(470, "Lesotho");
        marketsMap.put(471, "Swaziland");
        marketsMap.put(473, "Angola");
        marketsMap.put(477, "Music Promo France");
        marketsMap.put(481, "Slovakia");
        marketsMap.put(482, "Georgia");
        marketsMap.put(486, "Tunisia");
        marketsMap.put(511, "United States & Canada");
        marketsMap.put(513, "Music Promo Australia");
        marketsMap.put(528, "Sri Lanka");
        marketsMap.put(530, "Malawi");
        marketsMap.put(534, "Algeria");
        marketsMap.put(537, "Moldova");
        marketsMap.put(538, "Disney Pan Nordic");
        marketsMap.put(542, "Ethiopia");
        marketsMap.put(544, "Cote D'Ivoire");
        marketsMap.put(545, "Zimbabwe");
        marketsMap.put(546, "Congo");
        marketsMap.put(547, "Mongolia");
        marketsMap.put(553, "Zambia");
        marketsMap.put(554, "Cameroon");
        marketsMap.put(14001, "DACH");
        marketsMap.put(14002, "UK & ROI");
        marketsMap.put(14004, "Czech & Slovakia");
        marketsMap.put(14005, "MENA");

        marketsFieldsMap.put(5, "RegulatoryApproval->_cm.metadata.cadNo");
        marketsFieldsMap.put(6, "RegulatoryApproval->_cm.metadata.sujetAkm");
        marketsFieldsMap.put(7, "RegulatoryApproval->_cm.metadata.mbcidCode");
        marketsFieldsMap.put(8, "RegulatoryApproval->_cm.metadata.akaCode");
        marketsFieldsMap.put(198, "RegulatoryApproval->_cm.metadata.megatimeCode");
        marketsFieldsMap.put(481, "RegulatoryApproval->_cm.metadata.akaCode");
        marketsFieldsMap.put(538, "RegulatoryApproval->_cm.metadata.disneyCode");
        marketsFieldsMap.put(11, "RegulatoryApproval->_cm.metadata.spotgateCode");
        marketsFieldsMap.put(13, "RegulatoryApproval->_cm.metadata.motivnummer");
        marketsFieldsMap.put(231, "RegulatoryApproval->_cm.metadata.mediaAgency");
        marketsFieldsMap.put(206, "RegulatoryApproval->_cm.metadata.televisaId");
        marketsFieldsMap.put(77, "RegulatoryApproval->_cm.metadata.tvCabNo");
        marketsFieldsMap.put(17, "RegulatoryApproval->_cm.metadata.clave");
        marketsFieldsMap.put(18, "RegulatoryApproval->_cm.metadata.suisa");

    }

    @Test(dataProvider = "oneUserOneAsset", dataProviderClass = MigrationDataProvider.class)
    public void marketTests(UsersAction usersAction) {
        String folder = System.getProperty("user.dir");
        String folder3 = folder.concat("\\").concat("market1.info");
        File file3 = new File((folder3));
        getService().logIn(otherAgencyEmail, otherAgencyPassword);
        Asset assetData = usersAction.getOneAssetFromXML();
        String a5id = getA5Id(usersAction.getOneAssetFromXML().getAssetGUID());
        Content assetApp = getService().getAsset(a5id);
        try {
            assertThat(assetData.getMarkets().getMarket().length, equalTo(assetApp.getCm().getStringArray("marketId").length));
            assertThat(assetData.getMarkets().getMarket().length, equalTo(assetApp.getCm().getStringArray("market").length));
        }
        catch (Throwable t) {
            for (Integer counter: assetData.getMarkets().getMarket()) {
                FileManager.saveIntoFile(file3.getName(), "Asset: " + assetData.getUniqueName() + " number: " + counter + "\n");
            }

        }
        for (Integer counter: assetData.getMarkets().getMarket()) {
            assertThat(String.valueOf(counter), isIn(assetApp.getCm().getStringArray("marketId")));
        }
        System.out.println();

    }

    @Test(dataProvider = "oneUserOneAsset", dataProviderClass = MigrationDataProvider.class)
    public void marketsCountryTests(UsersAction usersAction) {
        init();
        String folder = System.getProperty("user.dir");
        String folder3 = folder.concat("\\").concat("market2.info");
        File file3 = new File((folder3));
        getService().logIn(otherAgencyEmail, otherAgencyPassword);
        Asset assetData = usersAction.getOneAssetFromXML();
        String a5id = getA5Id(usersAction.getOneAssetFromXML().getAssetGUID());
        Content assetApp = getService().getAsset(a5id);
        if (assetData.getMarkets() == null) return;
        for (Integer counter: assetData.getMarkets().getMarket()) {
            assertThat(marketsMap.get(counter), isIn(assetApp.getCm().getStringArray("market")));
        }
    }

    @Test
    public void marketsCountrySpecialAssetTest() {
        init();
        String folder = System.getProperty("user.dir");
        String folder3 = folder.concat("\\").concat("market2.info");
        File file3 = new File((folder3));
        getService().logIn(otherAgencyEmail, otherAgencyPassword);
        for (Asset assetData: XMLParser.getNewDataSet().getAsset()) {
            if (!assetData.getUniqueName().equalsIgnoreCase("ICB/BHXM001/030")) continue;
            String a5id = getA5Id(assetData.getAssetGUID());
            Content assetApp = getService().getAsset(a5id);
            if (assetData.getMarkets() == null) return;
            for (Integer counter: assetData.getMarkets().getMarket()) {
                try {
                    assertThat(marketsMap.get(counter), isIn(assetApp.getCm().getStringArray("market")));
                } catch (Throwable t) {
                    System.out.println("id = " + counter + " country = " + marketsMap.get(counter));
                }


            }

        }

    }

    @Test
    public void getAllAudioWithMarkets()  {
        getService().logIn(otherAgencyEmail, otherAgencyPassword);
        //getService().logIn("admin.check.subtitles@adbank.me", "Adstream01");
        //Content assetApp1 = getService().getAsset("54cb9872e4b095a260db54e1");//
        for (Asset asset: XMLParser.getNewDataSet().getAsset()) {
            if (asset.getAssetTypeID().equals("4")) {
                if ((asset.getMarkets()!= null) && (asset.getMarkets().getMarket().length>0) ) {
                    String a5id = getA5Id(asset.getAssetGUID());
                    Content assetApp = getService().getAsset(a5id);
                    if (assetApp.getCm().getOrCreateNode("metadata")!= null && assetApp.getCm().getOrCreateNode("metadata").size() > 0) {
                        System.out.println(asset.getUniqueName());
                    }

                }
            }
        }
    }


    @Test(dataProvider = "oneUserOneAsset", dataProviderClass = MigrationDataProvider.class)
    public void marketsFieldsTest(UsersAction usersAction) {
        init();
        String folder = System.getProperty("user.dir");
        String folder3 = folder.concat("\\").concat("market3.info");
        File file3 = new File((folder3));
        getService().logIn(otherAgencyEmail, otherAgencyPassword);
        Asset assetData = usersAction.getOneAssetFromXML();
        String a5id = getA5Id(usersAction.getOneAssetFromXML().getAssetGUID());
        Content assetApp = getService().getAsset(a5id);
        if (assetData.getMarkets() == null)
            return;
        for (Integer counter: assetData.getMarkets().getMarket()) {
            if (marketsFieldsMap.containsKey(counter)) {
                String value = marketsFieldsMap.get(counter)  ;

                System.out.println();
            }
        }

    }

}
