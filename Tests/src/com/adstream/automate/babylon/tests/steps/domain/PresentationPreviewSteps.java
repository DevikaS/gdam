package com.adstream.automate.babylon.tests.steps.domain;


import com.adstream.automate.babylon.BabylonServiceWrapper;
import com.adstream.automate.babylon.JsonObjects.*;
import com.adstream.automate.babylon.JsonObjects.Reel;
import com.adstream.automate.babylon.JsonObjects.User;
import com.adstream.automate.babylon.TestsContext;
import com.adstream.automate.babylon.sut.data.MetadataItem;
import com.adstream.automate.babylon.sut.pages.library.elements.DownloadPresentationPopUpWindow;
import com.adstream.automate.babylon.sut.pages.library.presentations.AdbankPresentationPreviewPage;
import com.adstream.automate.babylon.sut.pages.library.presentations.AdbankPresentationViewPage;
import com.adstream.automate.babylon.tests.steps.core.BaseStep;
import com.adstream.automate.page.flowplayer.Clip;
import com.adstream.automate.page.flowplayer.FlowPlayerProxy;
import com.adstream.automate.utils.Common;
import org.jbehave.core.annotations.*;
import org.jbehave.core.model.ExamplesTable;
import org.junit.Assert;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.*;

/**
 * Created with IntelliJ IDEA.
 * User: solomin-y
 * Date: 29.10.12
 * Time: 18:34
 */
public class PresentationPreviewSteps extends BaseStep {

    @Given("{I |}am on the presentation '$presentationName' preview page")
    @When("{I |}go to the presentation '$presentationName' preview page")
    @Alias("{I |}go to the shared presentation '$presentationName' preview page")
    public AdbankPresentationPreviewPage openPresentationByPreviewLink(String presentationName) {
        User buAdminUser = getData().getUserByType("AgencyAdmin");
        String presentationId = getCoreApi(buAdminUser).getReelByName(wrapVariableWithTestSession(presentationName)).getId();
        return getSut().getPageNavigator().getPresentationPreviewPage(presentationId);
    }

    @When("{I |}go to the presentation '$presentationName' view page by public url")
    public AdbankPresentationViewPage openPresentationByPublicLink(String presentationName) {
        User buAdminUser = getData().getUserByType("AgencyAdmin");
        String presentationId = getCoreApi(buAdminUser).getReelByName(wrapVariableWithTestSession(presentationName)).getId();
        String publicLinkToken =  getCoreApi(buAdminUser).getPresentationPublicToken(presentationId);
        return getSut().getPageNavigator().getPresentationViewPage(publicLinkToken);
    }

    @Given("{I |}am on preview presentation '$presentationName' page under user '$userType'")
    @When("{I |}go to preview presentation '$presentationName' page under user '$userType'")
    public void openPresentationPreviewPage(String presentationName, String userType) {
        String presentationId = getCoreApi(getData().getUserByType(userType)).getReelByName(wrapVariableWithTestSession(presentationName)).getId();
        getSut().getWebDriver().get(String.format("%s/presentation#preview/%s", TestsContext.getInstance().applicationUrl, presentationId));
    }

    @Given("{I |}am on preview presentation '$presentationName' page")
    @When("{I |}go to preview presentation '$presentationName' page")
    @Then("{I |}go to preview presentation '$presentationName' page")
    public AdbankPresentationPreviewPage openPresentationPreviewPage(String presentationName) {
        String presentationId = getCoreApi().getReelByName(wrapVariableWithTestSession(presentationName)).getId();
        return getSut().getPageNavigator().getPresentationPreviewPage(presentationId);
    }

    private AdbankPresentationPreviewPage getPresentationPreviewPage() {
        return getSut().getPageCreator().getPresentationPreviewPage();
    }

    @When("{I |}open url '$variablePart' for presentation preview")
    public void openPresentationPreviewPageByUrl(String variablePart) {
        String url = TestsContext.getInstance().applicationUrl + "/presentation/".concat(wrapVariableWithTestSession(variablePart).toLowerCase()).concat("/");
        getSut().getWebDriver().get(url);
        //getSut().getPageNavigator().getPresentationViewPage(wrapVariableWithTestSession(variablePart.toLowerCase()));
    }


    @When("I click by '$num' asset on the current presentation preview page")
    public void clickByAssetOnThePreviewPage(String num) {
        getSut().getPageCreator().getPresentationViewPage().clickOnAssetByNum(Integer.parseInt(num));
    }


    @When("{I |}play presentation on presentation preview page")
    public void playPresentation() {
        AdbankPresentationViewPage presentationViewPage = getSut().getPageCreator().getPresentationViewPage();
        FlowPlayerProxy player = presentationViewPage.getFlowPlayer();
        Common.sleep(2000);
        player.play();
        Common.sleep(1000);
        long startTime = System.currentTimeMillis();
        while (!player.isPaused()) {
            Common.sleep(1000);
            if (System.currentTimeMillis() - startTime > 120000) {
                Assert.fail("Your clip is very long");
            }
        }
    }

    @Then("{I |}'$condition' see warning message '$message' on presentation '$presentationName' preview page")
    public void checkWarningMessageOn(String condition, String message, String presentationName) {
        openPresentationByPublicLink(presentationName);
        BabylonSteps.checkWarningMessage(condition, message);
    }

    @Then("{I |}'$condition' be on presentation preview page")
    public void checkLibraryPageOpened(String condition) {
        boolean expectedState = condition.equalsIgnoreCase("should");
        boolean actualState = true;
        try {
            getSut().getPageCreator().getPresentationViewPage();
        } catch (Exception e) {
            actualState = false;
        }

        assertThat(actualState, is(expectedState));
    }

    @Then("I '$condition' see uploaded logo '$fileName' on the preview page for preview")
    public void checkUploadedLogo(String condition, String fileName) {
        AdbankPresentationPreviewPage presentationViewPage = getSut().getPageCreator().getPresentationPreviewPage();
        boolean shouldState = condition.equalsIgnoreCase("should");
        assertThat(presentationViewPage.isNoneDefaultLogo(), equalTo(shouldState));
    }

    @Then("I '$condition' see uploaded background '$fileName' on the preview page for preview")
    public void checkUploadedBackground(String condition, String fileName) {
        AdbankPresentationPreviewPage presentationViewPage = getSut().getPageCreator().getPresentationPreviewPage();
        boolean shouldState = condition.equalsIgnoreCase("should");
        assertThat(presentationViewPage.isNoneDefaultBackground(), equalTo(shouldState));
    }

    @Then("I '$condition' see background on the presentation preview page according to style '$style'")
    public void checkVisibilityAccordingToStyle(String condition, String style) {
        AdbankPresentationPreviewPage presentationViewPage = getSut().getPageCreator().getPresentationPreviewPage();
        boolean shouldState = condition.equalsIgnoreCase("should");
        if (style.toLowerCase().contains("scale")) assertThat(presentationViewPage.isBackgroundScaleToFit(), equalTo(shouldState));
        else if (style.toLowerCase().contains("tile")) assertThat(presentationViewPage.isBackgroundTile(), equalTo(shouldState));
        else Assert.fail(String.format("Parameter style = %s is incorrect. It must contains 'tile' or 'scale'", style));
    }

    @Then("{I |}'$should' see playable preview on presentation preview page")
    public void isPlayserAvailable(String should) {
        boolean shouldState = should.equalsIgnoreCase("should");
        boolean actualState = getSut().getPageCreator().getPresentationPreviewPage().isPlayerAvailable();

        assertThat("Video player are not available", shouldState == actualState);
    }

    @Then("{I |}should see that player in the playing state on the presentation '$presentationName' preview page for all assets")
    public void checkStateOfPlayer(String presentationName) {
        AdbankPresentationViewPage presentationViewPage = getSut().getPageCreator().getPresentationViewPage();
        FlowPlayerProxy player = presentationViewPage.getFlowPlayer();
        String reelId = getCoreApiAdmin().getReelByName(wrapVariableWithTestSession(presentationName)).getId();
        Reel reel = getCoreApiAdmin().getReel(reelId);
        List<String> listAssetsFileIdFromApi = new ArrayList<>();
        List<String> listFileIdFromPlayer = new ArrayList<>();
        for (Asset asset: reel.getAssetsList()) {
            listAssetsFileIdFromApi.add(getFileIdFromAssetForPresentation(asset));
        }
        Common.sleep(2000);
        player.play();
        Common.sleep(1000);
        for (String fileIdFromApi : listAssetsFileIdFromApi) {
            Clip clip = player.getClip();
            String url = clip.getUrl();
            // http://10.0.26.17/media/preview/52c685c4e4b056c5fdb94ddc/52c67edae4b0d21d2fb909a1/cdn
            //                                 reelId                   proxyId
            int start = url.indexOf(reelId) + reelId.length() + 1;
            int end = url.indexOf("/", start);
            listFileIdFromPlayer.add(url.substring(start, end));
            long startTime = System.currentTimeMillis();
            while (!player.isPaused()) {
                if (System.currentTimeMillis() - startTime > 120000) {
                    Assert.fail("Your clip is very long");
                }
            }
        }
        for (String str: listFileIdFromPlayer) {
            assertThat(str, isIn(listAssetsFileIdFromApi));
        }
    }

    @Then("{I |}should see for user '$userPlan' that player in the playing state on the presentation '$presentationName' preview page for all assets")
    public void checkStateOfPlayer(String userPlan, String presentationName) {
        AdbankPresentationViewPage presentationViewPage = getSut().getPageCreator().getPresentationViewPage();
        FlowPlayerProxy player = presentationViewPage.getFlowPlayer();
        String reelId = getCoreApiAdmin().getReelByName(wrapVariableWithTestSession(presentationName)).getId();
        User user = getData().getUserByType(userPlan);
        Reel reel = getCoreApi(user).getReel(reelId);
        List<String> listAssetsFileIdFromApi = new ArrayList<>();
        List<String> listFileIdFromPlayer = new ArrayList<>();
        for (Asset asset: reel.getAssetsList()) {
            listAssetsFileIdFromApi.add(getFileIdFromAssetForPresentation(asset));
        }
        Common.sleep(2000);
        player.play();
        for (String aListAssetsFileIdFromApi : listAssetsFileIdFromApi) {
            Common.sleep(1000);
            Clip clip = player.getClip();
            String regexp = "(\\w{24})/cdn";
            Matcher matcher = Pattern.compile(regexp, Pattern.CASE_INSENSITIVE).matcher(clip.getUrl());
            listFileIdFromPlayer.add(matcher.find() ? matcher.group(1) : "");
            long startTime = System.currentTimeMillis();
            while (!player.isPaused()) {
                Common.sleep(1000);
                if (System.currentTimeMillis() - startTime > 120000) {
                    Assert.fail("Your clip is very long");
                }
            }
        }
        for (String str: listFileIdFromPlayer) {
            assertThat(str, isIn(listAssetsFileIdFromApi));
        }
    }

    @Then("I '$condition' see presentation name '$presentationName' for current preview")
    public void checkPresentationNameOnThePreview(String condition, String presentationName) {
        AdbankPresentationViewPage presentationViewPage = getSut().getPageCreator().getPresentationViewPage();
        boolean shouldState = condition.equalsIgnoreCase("should");
        assertThat(presentationViewPage.getPresentationName(), shouldState ? equalTo(wrapVariableWithTestSession(presentationName)) : not(equalTo(wrapVariableWithTestSession(presentationName))));
        String reelId = getCoreApi().getReelByName(wrapVariableWithTestSession(presentationName)).getId();
        getCoreApi().getReel(reelId);
        //reel.getAssets()[0].getRevisions()[0].getMaster().getFileID()
        //SearchResult<Reel> reel = getCoreApi().findReelsById(reelId, true);
    }

    @Then("I '$condition' see presentation preview")
    public void checkPresentationOnThePreview(String condition) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        boolean isPreviewLoaded = true;

        try {
            getSut().getPageCreator().getPresentationPreviewPage();
        } catch (Exception e) {
            isPreviewLoaded = false;
        } finally {
            assertThat(isPreviewLoaded, is(shouldState));
        }
    }

    @Then("I '$condition' see for user '$userPlan' presentation name '$presentationName' for current preview")
    public void checkPresentationNameOnThePreview(String condition, String userPlan, String presentationName) {
        AdbankPresentationViewPage presentationViewPage = getSut().getPageCreator().getPresentationViewPage();
        boolean shouldState = condition.equalsIgnoreCase("should");
        assertThat(presentationViewPage.getPresentationName(), shouldState ? equalTo(wrapVariableWithTestSession(presentationName)) : not(equalTo(wrapVariableWithTestSession(presentationName))));
    }


    @Then("{I |}should see count '$count' of assets on the current preview page")
    public void checkCountOfAssetsOnPreviewPresentationPage(String count) {
        AdbankPresentationViewPage presentationViewPage = getSut().getPageCreator().getPresentationViewPage();
        assertThat(presentationViewPage.getCountOfAssets(), equalTo(Integer.parseInt(count)));
    }

    // | Name | Should |
    @Then("I should see following assets for presentation '$presentationName' on the preview page: $assetsName")
    public void checkAssetsVisibility(String presentationName, ExamplesTable data) {
        AdbankPresentationViewPage page = getSut().getPageCreator().getPresentationViewPage();
        Asset[] assets = getCoreApiAdmin().getReelByName(wrapVariableWithTestSession(presentationName)).getAssetsList();

        for (Map<String, String> row : parametrizeTableRows(data)) {
            if (row.get("Name") != null) {
                boolean shouldState = row.get("Should") != null && row.get("Should").equalsIgnoreCase("should");
                String thumbnailId = null;
                for (Asset asset : assets) {
                    if (asset.getName().equals(row.get("Name"))) {
                        thumbnailId = getThumbnailIdFromAsset(asset);
                    }
                }
                assertThat(page.isAssetVisible(thumbnailId), equalTo(shouldState));
            }
        }
    }

    // | Name | Duration |
    @Then("{I |}'$condition' see following assets with duration on presentation preview page: $data")
    public void checkClipDuration(String condition, ExamplesTable data) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        AdbankPresentationViewPage page = getSut().getPageCreator().getPresentationViewPage();
        List<Map<String,String>> expectedData = parametrizeTableRows(data);
        List<Map<String,String>> actualData = new ArrayList<>();

        for (Map<String,String> expectedDataRow : expectedData) {
            AssetFilter collection = getCoreApi().getAssetsFilterByName("Everything", "", 0);
            if (collection == null) collection = getCoreApi().getAssetsFilterByName("My Assets", "", 0);
            List<Content> listContent = getCoreApi().getAllAssetByName(collection.getId(), expectedDataRow.get("Name"));
            page.clickOnAssetById(getThumbnailIdFromContent(listContent.get(listContent.size() - 1)));
            Map<String,String> actualDataRow = new HashMap<>();
            actualDataRow.put("Name", expectedDataRow.get("Name"));
            actualDataRow.put("Duration", page.getFlowPlayer().getClip().getDuration().toString());
            actualData.add(actualDataRow);
        }

        assertThat(actualData, shouldState ? equalTo(expectedData) : not(equalTo(expectedData)));
    }

    @Then("{I |}'$condition' see seconds of black '$seconds' between each asset on presentation preview page")
    public void checkClipDuration(String condition, String seconds) {
        Assert.fail("Step is not implemented yet");
    }

    // | Name | Duration |
    @Then("{I |}'$condition' see for user '$userPlan' following assets with duration on presentation preview page: $data")
    public void checkClipDuration(String condition, String userPlan, ExamplesTable data) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        AdbankPresentationViewPage page = getSut().getPageCreator().getPresentationViewPage();
        User user = getData().getUserByType(userPlan);
        List<Map<String,String>> expectedData = parametrizeTableRows(data);
        List<Map<String,String>> actualData = new ArrayList<>();

        for (Map<String,String> expectedDataRow : expectedData) {
            AssetFilter collection = getCoreApi(user).getAssetsFilterByName("Everything", "", 0);
            if (collection == null) collection = getCoreApi(user).getAssetsFilterByName("My Assets", "", 0);
            List<Content> listContent = getCoreApi(user).getAllAssetByName(collection.getId(), expectedDataRow.get("Name"));
            page.clickOnAssetById(getThumbnailIdFromContent(listContent.get(listContent.size() - 1)));
            Map<String,String> actualDataRow = new HashMap<>();
            actualDataRow.put("Name", expectedDataRow.get("Name"));
            actualDataRow.put("Duration", page.getFlowPlayer().getClip().getDuration().toString());
            actualData.add(actualDataRow);
        }

        assertThat(actualData, shouldState ? equalTo(expectedData) : not(equalTo(expectedData)));
    }

    // | Name | Should |
    @Then("{I |}should see for user '$userPlan' following assets for presentation '$presentationName' on the preview page: $assetsName")
    public void checkAssetsVisibility(String userPlan, String presentationName, ExamplesTable assetsName) {
        AdbankPresentationViewPage presentationViewPage = getSut().getPageCreator().getPresentationViewPage();
        User user = getData().getUserByType(userPlan);
        AssetFilter myAssets = getCoreApi(user).getAssetsFilterByName("My Assets", "", 0);

        for (Map<String, String> row : parametrizeTableRows(assetsName)) {
            if (row.get("Name") != null) {
                boolean shouldState = row.get("Should") != null && row.get("Should").equalsIgnoreCase("should");

                List<Content> listContent = getCoreApi(user).getAllAssetByName(myAssets.getId(), row.get("Name"));
                String fileId = getThumbnailIdFromContent(listContent.get(listContent.size() - 1));

                assertThat("Is " + row.get("Name") + " visible",
                        presentationViewPage.isAssetVisible(fileId), equalTo(shouldState));
            }
        }
    }

    // | Name | Should |
    @Then("{I |}should see for user plan '$userPlan' following assets uploaded by user '$uploader' into collection '$collectionName' on the opened presentation preview page: $data")
    public void checkAssetsVisibilityUploadedByUser(String userPlan, String uploader, String collectionName, ExamplesTable data) {
        User user = getCoreApi(getData().getUserByType(userPlan)).getUserByEmail(wrapUserEmailWithTestSession(uploader));
        BabylonServiceWrapper coreApi = getCoreApi(user);
        String userId = user.getId();
        String collectionId = coreApi.getAssetsFilterByName(wrapCollectionName(collectionName), "").getId();
        List<String> actualAssetsIdsList = getSut().getPageCreator().getPresentationViewPage().getAllAssetsPreviewIds();

        for (Map<String, String> row : parametrizeTableRows(data)) {
            if (row.get("Name") != null && !row.get("Name").isEmpty()) {
                boolean shouldState = row.get("Should") != null && !row.get("Should").isEmpty() && row.get("Should").equalsIgnoreCase("should");
                String expectedAssetId = getThumbnailIdFromContent(coreApi.getLastUploadedUserAssetById(collectionId, userId, row.get("Name")));

                assertThat(actualAssetsIdsList, shouldState ? hasItem(expectedAssetId) : not(hasItem(expectedAssetId)));
            }
        }
    }

    @Then("{I |}should see count '$count' of standard audio thumbnails")
    public void checkCountOfStandardAudioThumbnails(String count) {
        AdbankPresentationViewPage presentationViewPage = getSut().getPageCreator().getPresentationViewPage();
        assertThat(presentationViewPage.getCountOfStandardAudioThumbnails(), equalTo(Integer.parseInt(count)));
    }

    // | Name | Should |
    @Deprecated
    @Then("I should see on the presentation '$presentationName' preview page following assets: $assetName")
    public void checkPreviewPresentationAssets(String presentationName, ExamplesTable assetsName) {
        AdbankPresentationPreviewPage page = openPresentationPreviewPage(presentationName);

        for (Map<String, String> row : parametrizeTableRows(assetsName)) {
            boolean expectedState = row.get("Should") != null && !row.get("Should").isEmpty() && row.get("Should").equalsIgnoreCase("should");
            boolean actualState = false;
            String errorMessage = String.format("Preview for asset %s is on presentation page", row.get("Name"));

            if (row.get("Name") != null)
                for(Content asset : getCoreApi().getAllAssetByName(getCoreApi().getAssetsFilterByName("Everything","").getId(), row.get("Name")))
                    if(actualState = page.isAssetVisible(getThumbnailIdFromContent(asset))) break;

            assertThat(errorMessage, actualState, is(expectedState));
        }
    }

    @Then("{I |}should see on the presentation '$presentation' oreview page count previews '$count' of assets")
    public void checkCountPreviewsOnPresentationAssets(String presentationName, int count) {
        AdbankPresentationPreviewPage page = openPresentationPreviewPage(presentationName);

        for (int i = 1; i < count; i++) {
            Common.sleep(2000);
            assertThat("Preview is not visible", page.isPreviewAssetVisible());
            page.nextItem();
        }

        assertThat("Preview is not visible", page.isPreviewAssetVisible());
    }

    // should not - the same as default logo or background
    @Then("I '$condition' see '$elementType' on the current presentation preview page")
    public void checkElementsVisibility(String condition, String elementType) {
        AdbankPresentationPreviewPage presentationPreviewPage = getSut().getPageCreator().getPresentationPreviewPage();
        boolean shouldState = condition.equalsIgnoreCase("should");
        if (elementType.equalsIgnoreCase("Logo")) {
            assertThat(presentationPreviewPage.isNoneDefaultLogo(), equalTo(shouldState));
        } else if (elementType.equalsIgnoreCase("Background")) {
            assertThat(presentationPreviewPage.isNoneDefaultBackground(), equalTo(shouldState));
        }
    }

    @Then("I '$condition' see metadata field '$fieldName' with value '$value'")
    public void checkVisibilityOfMetadataFieldsOnPresentationPreviewPage(String condition, String fieldName, String value) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        AdbankPresentationPreviewPage presentationPreviewPage = getSut().getPageCreator().getPresentationPreviewPage();
        List<String> listOfAssets = presentationPreviewPage.getInfoAboutAssets();
        String[] fieldNames = fieldName.split(",");
        String[] values = value.split(",");
        int counter= 0;
        String value1 = null;
        if (listOfAssets.size()< fieldNames.length) Assert.fail("Not enough results on the page");
        if (shouldState) {
            for (String pageValue : listOfAssets) {
                String[] check = pageValue.split(":");
                if (fieldNames[counter].equals("Brand") || fieldNames[counter].equals("Product") || fieldNames[counter].equals("Campaign")) {
                    assertThat("", equalTo(check[0].trim()));
                    return;     // due to Brand , Product, Campaign are not implemented in tests as custom metadata
                }
                assertThat(fieldNames[counter], equalTo(check[0].trim()));
                if (fieldNames[counter].equals("Agency")) {
                    value1 = getData().getAgencyByName(values[counter]).getName();
                } else if (fieldNames[counter].equals("Title")) {
                    value1 = values[counter];
                }
                assertThat(value1, equalTo(check[1].trim()));
                counter++;
            }
        } else {
            List<String> convertListOfAssets = convertAssetsList(listOfAssets);
            for (String notIn: fieldNames) {
                assertThat(notIn, not(isIn(convertListOfAssets)));
            }
        }
    }

    @Then("I should see assets on the preview presentation page with following style '$style'")
    public void checkAssetsStyleOfPresentationPreviewPage(String style) {
        AdbankPresentationPreviewPage presentationPreviewPage = getSut().getPageCreator().getPresentationPreviewPage();
        if (style.equalsIgnoreCase("horizontal")) {
            assertThat(presentationPreviewPage.isAssetsLineVisible(), equalTo(true));
            assertThat(presentationPreviewPage.isNextItemArrowVisible(), equalTo(false));
            assertThat(presentationPreviewPage.isGridIconsVisible(), equalTo(false));
        }
        else if (style.equalsIgnoreCase("slider")) {
            assertThat(presentationPreviewPage.isAssetsLineVisible(), equalTo(true));
            assertThat(presentationPreviewPage.isNextItemArrowVisible(), equalTo(true));
            assertThat(presentationPreviewPage.isGridIconsVisible(), equalTo(false));
        }
        else if (style.equalsIgnoreCase("grid")) {
            assertThat(presentationPreviewPage.isAssetsLineVisible(), equalTo(false));
            assertThat(presentationPreviewPage.isNextItemArrowVisible(), equalTo(false));
            assertThat(presentationPreviewPage.isGridIconsVisible(), equalTo(true));
        }
        else {
            Assert.fail("Parameters style is undefine");
        }
    }

    @Then("I should see current presentation preview page with scheme '$scheme'")
    public void checkSchemeOnPreviewPage(String scheme) {
        AdbankPresentationPreviewPage presentationPreviewPage = getSut().getPageCreator().getPresentationPreviewPage();
        if (scheme.equalsIgnoreCase("light")) assertThat(presentationPreviewPage.isLightTheme(), equalTo(true));
        else if (scheme.equalsIgnoreCase("dark")) assertThat(presentationPreviewPage.isDarkTheme(), equalTo(true));
        else Assert.fail("Parameter scheme is undefine");
    }

    @Then("{I |}'$shouldState' see Download button on presentation preview page")
    public void checkVisibilityDownloadButton(String shouldState) {
        AdbankPresentationPreviewPage presentationPreviewPage = getPresentationPreviewPage();
        boolean should = shouldState.equals("should");
        assertThat("Check visibility Download button :", presentationPreviewPage.isDownloadButtonVisible(), equalTo(should));
    }

    @Then("{I |}'$shouldState' see Original files (ZIP) button on Download popup of presentation preview page")
    public void checkVisibilityOriginalFilesButton(String shouldState) {
        AdbankPresentationPreviewPage presentationPreviewPage = getPresentationPreviewPage();
        DownloadPresentationPopUpWindow popUpWindow = presentationPreviewPage.openDownloadPresentationPopUp();
        boolean should = shouldState.equals("should");
        assertThat("Check visibility Original files (ZIP) button :", popUpWindow.isOriginalFilesButtonVisible(), equalTo(should));
    }

    // original, proxy
    @When("{I |}click '$button' button on presentation preview page popup")
    public void clickButtonOnPopup(String button) {
        AdbankPresentationPreviewPage presentationPreviewPage = getPresentationPreviewPage();
        DownloadPresentationPopUpWindow popUpWindow = presentationPreviewPage.openDownloadPresentationPopUp();
        if (button.equalsIgnoreCase("original")) {
            popUpWindow.clickDownloadOriginalButton();
        } else if (button.equalsIgnoreCase("proxy")) {
            popUpWindow.clickProxyFileButton();
            Common.sleep(3000);

        } else {
            throw new IllegalArgumentException(String.format("Wrong button '%s'", button));
        }
    }

    @Then("{I |}'$shouldState' see Proxy files (ZIP) button on Download popup of presentation preview page")
    public void checkVisibilityProxyFilesButton(String shouldState) {
        AdbankPresentationPreviewPage presentationPreviewPage = getPresentationPreviewPage();
        DownloadPresentationPopUpWindow popUpWindow = presentationPreviewPage.openDownloadPresentationPopUp();
        boolean should = shouldState.equals("should");
        assertThat("Check visibility Proxy files (ZIP) button :", popUpWindow.isProxyFilesButtonVisible(), equalTo(should));
    }

    // Name
    @Then("I '$condition' see for user '$userType' the following assets ordering on the preview page: $assetsTable")
    public void checkThatAssetPreviewIsOrderedCorrectly(String condition, String userType, ExamplesTable assetsTable) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        AdbankPresentationViewPage presentationViewPage = getSut().getPageCreator().getPresentationViewPage();
        List<String> actualAssetsPreviewOrdering = presentationViewPage.getAllAssetsPreviewIds();
        List<String> expectedAssetsPreviewOrdering = new ArrayList<>();
        User user = getData().getUserByType(userType);
        AssetFilter collection = getCoreApi(user).getAssetsFilterByName("Everything", "", 0);
        if (collection == null) collection = getCoreApi(user).getAssetsFilterByName("My Assets", "", 0);
        for(Map<String, String> asset : assetsTable.getRows()) {
            List<Content> assetsList = getCoreApi(user).getAllAssetByName(collection.getId(), asset.get("Name"));
            expectedAssetsPreviewOrdering.add(getThumbnailIdFromContent(assetsList.get(assetsList.size() - 1)));
        }
        assertThat(actualAssetsPreviewOrdering, shouldState ? equalTo(expectedAssetsPreviewOrdering) : not(equalTo(expectedAssetsPreviewOrdering)));
    }

    // | Name |
    @Then("{I |}'$condition' see in left bottom corner drop down menu with the following presentations: $reelTable")
    public void checkThatLeftBottomCornerDropDownHasPresentations(String condition, ExamplesTable reelTable) {
        boolean shouldState = condition.equals("should");
        List<String> actualReelList = getPresentationPreviewPage().getAvailableToPreviewPresentationList();
        List<String> expectedReelList = getParametrizedTableColumn(reelTable, "Name");
        Collections.sort(actualReelList, String.CASE_INSENSITIVE_ORDER);
        Collections.sort(expectedReelList, String.CASE_INSENSITIVE_ORDER);

        assertThat(actualReelList, shouldState ? equalTo(expectedReelList) : not(equalTo(expectedReelList)));
    }

    // | FieldName | FieldValue |
    @Then("{I |}'$condition' see following metadata fields for asset '$assetName' added from collection '$collectionName' on presentation '$presentationName' preview page: $data")
    public void checkMetadataFieldsOnPresentationPreview(String condition, String assetName, String collectionName, String presentationName, ExamplesTable data) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        AdbankPresentationPreviewPage page = openPresentationPreviewPage(presentationName);

        Content asset = getCoreApi().getAssetByName(getCoreApi().getAssetsFilterByName(wrapCollectionName(collectionName),"").getId(), assetName);
        List<MetadataItem> actualFieldsList = page.getMetadataFieldsMapByPreviewId(getThumbnailIdFromContent(asset));

        for (MetadataItem expectedField : wrapMetadataFields(data, "FieldName", "FieldValue")) {
            assertThat(actualFieldsList, shouldState ? hasItem(expectedField) : not(hasItem(expectedField)));
        }
    }

    private String getFileIdFromAssetForPresentation(Asset asset) {
        for (FilePreview filePreview: asset.getRevisions()[0].getPreview()) {
            if (filePreview.getA5Type().toLowerCase().contains("proxy")) {
                return filePreview.getFileID();
            }
        }
        return "";
    }

    private String getThumbnailIdFromContent(Content content) {
        for (FilePreview filePreview : content.getLastRevision().getPreview()) {
            if (filePreview.getA5Type().toLowerCase().contains("thumbnail")) {
                return filePreview.getFileID();
            }
        }
        return "";
    }

    private String getThumbnailIdFromAsset(Asset asset) {
        for (FilePreview filePreview : asset.getRevisions()[0].getPreview()) {
            if (filePreview.getA5Type().toLowerCase().contains("thumbnail")) {
                return filePreview.getFileID();
            }
        }
        return "";
    }

    private List<String> convertAssetsList(List<String> list) {
        if (list.size()==0) return new ArrayList<>();
        List<String> result = new ArrayList<>();
        for (String str: list) {
            if (!str.isEmpty()) {
                result.add(str.split(":")[0].trim());
                result.add(str.split(":")[1].trim());
            }
        }
        return result;
    }
}