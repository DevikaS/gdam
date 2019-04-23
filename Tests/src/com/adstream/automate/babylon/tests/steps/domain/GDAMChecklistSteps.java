package com.adstream.automate.babylon.tests.steps.domain;

import com.adstream.automate.babylon.TestsContext;
import com.adstream.automate.babylon.sut.pages.BasePage;
import com.adstream.automate.babylon.sut.pages.elements.ImpersonateMePopup;
import org.jbehave.core.annotations.Given;
import org.jbehave.core.annotations.Then;
import org.jbehave.core.annotations.When;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.is;
/**
 * Created with IntelliJ IDEA.
 * User: Geethanjali.K
 * Date: 20/05/2016
 * Time: 15:36
 */
public class GDAMChecklistSteps extends BabylonSteps {

    @Given("{I |}access client '$clientName' url")
    @When("{I |}access client '$clientName' url")
    public void accessClenUrl(String clientName) {
        if (clientName.equalsIgnoreCase("Beam")) {
            getSut().getWebDriver().get("http://application.beam.tv");
        }else if(clientName.equalsIgnoreCase("Schawk")){
            getSut().getWebDriver().get("http://schawk.adstream.com");
        }else if(clientName.equalsIgnoreCase("ElizabethArden")){
            getSut().getWebDriver().get("http://elizabeth-arden.adstream.com");
        }else if(clientName.equalsIgnoreCase("CustomBranding")) {
            getSut().getWebDriver().get(String.valueOf(TestsContext.getInstance().customBrandingUrl));
        }else if(clientName.equalsIgnoreCase("CustomBeamBranding")){
            getSut().getWebDriver().get(String.valueOf(TestsContext.getInstance().customBeamBrandingUrl));
        }else if(clientName.equalsIgnoreCase("AppleBeam")){
            getSut().getWebDriver().get("http://apple.beam.tv");
        }
                }


    @Then("{I |}'$condition' see Client Logo in '$clientName' login page")
    public void checkIsItClientLoginPage(String condition,String clientName) {
        boolean expectedState = condition.equalsIgnoreCase("should");
        boolean actualState = false;
        try {
            if(clientName.equalsIgnoreCase("Beam")||clientName.equalsIgnoreCase("CustomBeamBranding")) {
                actualState=  getSut().getPageCreator().getLoginPage().isBeamBackground();
            }else if(clientName.equalsIgnoreCase("Schawk")){
            if(getSut().getPageCreator().getLoginPage().isSchawkBackground()&& getSut().getPageCreator().getLoginPage().isSchawkLogoPresent()){
                actualState= true;
            }else{
                actualState= false;
            }
            }else if(clientName.equalsIgnoreCase("ElizabethArden")){
            actualState = getSut().getPageCreator().getElizabethArdenLoginPage().isClientBackground();
            } else if(clientName.equalsIgnoreCase("CustomBranding")){
            actualState = getSut().getPageCreator().getLoginPage().isCustomBrandingBackground();
            }else if((clientName.equalsIgnoreCase("AppleBeam"))){
                actualState =   getSut().getPageCreator().getLoginPage().isAppleBeamLogo();
            }
        } catch (Exception e) {
            actualState = false;
        }
        assertThat(actualState, is(expectedState));
    }

    @Then("{I |}'$condition' see BeemReels section on Dashboard page")
    public void checkBeemReels(String condition) {
        boolean expectedState = condition.equalsIgnoreCase("should");
        boolean actualState = getSut().getPageCreator().getDashboardPage().isBeemReelsExist();
        assertThat(actualState, is(expectedState));
    }

    @Then("{I |}'$condition' see Custom Logo for '$client' on Dashboard page")
    public void checkCustomLOgo(String condition,String client) {
        boolean expectedState = condition.equalsIgnoreCase("should");
        if(!getSut().getPageUrl().contains("/home"))
            if(client.equalsIgnoreCase("CustomBranding")) {
                getSut().getWebDriver().get(String.valueOf(TestsContext.getInstance().customBrandingUrl)+"/projects#/home");
            }else if(client.equalsIgnoreCase("CustomBeamBranding")) {
                getSut().getWebDriver().get(String.valueOf(TestsContext.getInstance().customBeamBrandingUrl)+"/projects#/home");
            }else {
                getSut().getPageNavigator().getDashboardPage();
            }
        boolean actualState = getSut().getPageCreator().getDashboardPage().isCustomLogoExist(client);
        assertThat(actualState, is(expectedState));
    }

    @Then("{I |}'$condition' see Client Header color in '$clientName' Dashboard page")
    public void checkIsItClientDashboardPageHeader(String condition,String clientName) {
        boolean expectedState = condition.equalsIgnoreCase("should");
        boolean actualState = false;
        try {
            if(clientName.equalsIgnoreCase("CustomBranding")){
                actualState = getSut().getPageCreator().getDashboardPage().isCustomBrandingHeader();
            }else if(clientName.equalsIgnoreCase("CustomBeamBranding")){
                actualState = getSut().getPageCreator().getDashboardPage().isCustomBeamBrandingHeader();
            }
        } catch (Exception e) {
            actualState = false;
        }
        assertThat(actualState, is(expectedState));
    }

    @Then("{I |}'$condition' see Client Footer color and text in '$clientName' Dashboard page")
    public void checkIsItClientDashboardPageFooter(String condition,String clientName) {
        boolean expectedState = condition.equalsIgnoreCase("should");
        boolean actualState = false;
        try {
            if(clientName.equalsIgnoreCase("CustomBranding")){
                actualState = getSut().getPageCreator().getDashboardPage().isCustomBrandingFooter();
            }else if(clientName.equalsIgnoreCase("CustomBeamBranding")){
                actualState = getSut().getPageCreator().getDashboardPage().isCustomBeamBrandingFooter();
            }
        } catch (Exception e) {
            actualState = false;
        }
        assertThat(actualState, is(expectedState));
    }
    @Given("{I |}impersonated as Client user '$userName' on opened page")
    @When("{I |}impersonated as Client user '$userName' on opened page")
    public void impersonateMeAsUser(String userName) {
        BasePage page = getSut().getPageCreator().getBasePage();
        page.expandAccountMenu();
        page.selectAccountMenuItemByName("Impersonate");
        ImpersonateMePopup popup = new ImpersonateMePopup(page);
        if(userName.equalsIgnoreCase("new"))
        {
            userName="qatbabylonautotester+" + wrapVariableWithTestSession(userName) +"@gmail.com";
        }
        popup.typeEmail(userName);
        popup.typeComment("automated test");
        popup.clickAction();
    }

}

