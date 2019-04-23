package com.adstream.automate.babylon.sut.pages.ordering.elements.forms.subForms;

import com.adstream.automate.babylon.sut.pages.admin.metadata.MetadataPage;
import com.adstream.automate.babylon.sut.pages.ordering.elements.forms.AdCodeManager;
import com.adstream.automate.page.controls.*;
import org.openqa.selenium.By;
import org.openqa.selenium.NoSuchElementException;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.ui.ExpectedCondition;
import java.lang.StringBuilder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/*
 * Created by demidovskiy-r on 19.06.2014.
 */
public class AdCodeContainer extends AdCodeManager {
    public static final String CONTAINER_NODE = ROOT_NODE + " [data-role='adCodeContainer']";
    private Edit customCodeName;
    private DojoTextBox market;
    private String preview;
    private String formatResult;
    private Checkbox date;
    private DojoSelect dateFormat;
    private DojoSelect sequenceCharacters;
    private Checkbox metadataElements;
    private Checkbox freeText;

    public AdCodeContainer(MetadataPage parent) {
        super(parent);
        preview = getDriver().findElement(generateElementLocatorByDataRole("previewResult")).getText();
        formatResult = getDriver().findElement(generateElementLocator("#formatResult")).getText();
    }

    @Override
    protected void initControls() {
        controls.put(Control.CODE_NAME.toString(), customCodeName = new Edit(parent, generateElementLocatorByDataRole("adCodeName")));
        controls.put(Control.MARKET.toString(), market = new DojoTextBox(parent, generateElementLocator("[id*='Markets']")));
        controls.put(Control.DATE.toString(), date = new Checkbox(parent, generateElementLocatorByDataRole("date")));
        controls.put(Control.DATE_FORMAT.toString(), dateFormat = new DojoSelect(parent, generateElementLocatorByDataRole("dateFormat")));
        controls.put(Control.SEQUENCE_CHARACTERS.toString(), sequenceCharacters = new DojoSelect(parent, generateElementLocatorByDataRole("sequenceCharacters")));
        controls.put(Control.METADATA_ELEMENTS.toString(), metadataElements = new Checkbox(parent, generateElementLocatorByDataRole("field")));
        controls.put(Control.FREE_TEXT.toString(), freeText = new Checkbox(parent, generateElementLocatorByDataRole("freeText")));
    }

    @Override
    protected void loadForm() {
        super.loadForm();
        getDriver().waitUntilElementAppearVisible(getFormLocator());
    }

    @Override
    protected void unloadForm() {
        super.unloadForm();
        getDriver().waitUntilElementDisappear(getFormLocator());
    }

    @Override
    protected String getRootNode() {
        return CONTAINER_NODE;
    }

    @Override
    public void fill(Map<String, String> fields) {
        List<Map<String, String>> metadataNames = new ArrayList<>();
        List<Map<String, String>> metadataCharacters = new ArrayList<>();
        List<Map<String, String>> customTextSeparators = new ArrayList<>();
        if (fields.containsKey(Control.METADATA_NAME.toString())) {
            for (String name : fields.get(Control.METADATA_NAME.toString()).split(",")) {
                Map<String, String> names = new HashMap<>();
                names.put(Control.METADATA_NAME.toString(), name);
                metadataNames.add(names);
            }
            fields.remove(Control.METADATA_NAME.toString());
        }
        if (fields.containsKey(Control.METADATA_CHARACTERS.toString())) {
            for (String character: fields.get(Control.METADATA_CHARACTERS.toString()).split(",")) {
                Map<String, String> characters = new HashMap<>();
                characters.put(Control.METADATA_CHARACTERS.toString(), character);
                metadataCharacters.add(characters);
            }
            fields.remove(Control.METADATA_CHARACTERS.toString());
        }
        if (fields.containsKey(Control.SEPARATOR.toString())) {
            for (String separator : fields.get(Control.SEPARATOR.toString()).split(",")) {
                Map<String,String> separators = new HashMap<>();
                separators.put(Control.SEPARATOR.toString(), separator);
                customTextSeparators.add(separators);
            }
            fields.remove(Control.SEPARATOR.toString());
        }
        super.fill(fields);
        if (!metadataNames.isEmpty() && !metadataCharacters.isEmpty()) {
            if (metadataNames.size() != metadataCharacters.size()) throw new IllegalArgumentException("Metadata names size should be equals metadata characters size!");
            for (int i = 0; i < metadataNames.size(); i++) {
                MetadataElement metadataElement = getMetadataElements().get(i);
                metadataElement.fill(metadataNames.get(i));
                metadataElement.fill(metadataCharacters.get(i));
                if (i != metadataNames.size() - 1) metadataElement.addItem();
            }
        }
        if (!customTextSeparators.isEmpty()) {
            for (int i = 0; i < customTextSeparators.size(); i++) {
                CustomText customText = getCustomTextElements().get(i);
                customText.fill(customTextSeparators.get(i));
                if (i != customTextSeparators.size() - 1) customText.addItem();
            }
        }
    }

    @Override
    public String getFieldValue(String fieldName) {
        if (Control.findByName(fieldName).equals(Control.PREVIEW)) return getPreview();
        if (Control.findByName(fieldName).equals(Control.CUSTOM_CODE_FORMAT)) return getFormatResult();
        if (Control.findByName(fieldName).equals(Control.METADATA_NAME)) {
            StringBuilder metadataNames = new StringBuilder();
            List<MetadataElement> metadataElements = getMetadataElements();
            for (int i = 0; i < metadataElements.size(); i++) {
                metadataNames.append(metadataElements.get(i).getFieldValue(Control.METADATA_NAME.toString()));
                if (i != metadataElements.size() - 1) metadataNames.append(",");
            }
            return metadataNames.toString();
        }
        if (Control.findByName(fieldName).equals(Control.METADATA_CHARACTERS)) {
            StringBuilder metadataCharacters = new StringBuilder();
            List<MetadataElement> metadataElements = getMetadataElements();
            for (int i = 0; i < metadataElements.size(); i++) {
                metadataCharacters.append(metadataElements.get(i).getFieldValue(Control.METADATA_CHARACTERS.toString()));
                if (i != metadataElements.size() - 1) metadataCharacters.append(",");
            }
            return metadataCharacters.toString();
        }
        if (Control.findByName(fieldName).equals(Control.SEPARATOR)) {
            StringBuilder separators = new StringBuilder();
            List<CustomText> customTexts = getCustomTextElements();
            for (int i = 0; i < customTexts.size(); i++) {
                separators.append(customTexts.get(i).getFieldValue(Control.SEPARATOR.toString()));
                if (i != customTexts.size() - 1) separators.append(",");
            }
            return separators.toString();
        }
        return super.getFieldValue(fieldName);
    }

    public String getPreview() {
        return preview;
    }

    public String getFormatResult() {
        return formatResult;
    }

    public int getAdCodeMetadataElementsCount() {
        return getAdCodeMetadataElements().size();
    }

    public int getAdCodeCustomTextElementsCount() {
        return getAdCodeCustomTextElements().size();
    }

    public MetadataElement getMetadataElement(String metadataName, String characters) {
        for (MetadataElement metadataElement : getMetadataElements())
            if (metadataElement.getFieldValue(Control.METADATA_NAME.toString()).equals(metadataName)
                    && metadataElement.getFieldValue(Control.METADATA_CHARACTERS.toString()).equals(characters))
                return metadataElement;
        throw new IllegalArgumentException("There is no metadata element with name: " + metadataName + " and characters: " + characters);
    }

    public MetadataElement getMetadataElement(String metadataName, String characters, List<MetadataElement> metadataElements) {
        for (MetadataElement metadataElement : metadataElements)
            if (metadataElement.getFieldValue(Control.METADATA_NAME.toString()).equals(metadataName)
                    && metadataElement.getFieldValue(Control.METADATA_CHARACTERS.toString()).equals(characters))
                return metadataElement;
        throw new IllegalArgumentException("There is no metadata element with name: " + metadataName + " and characters: " + characters);
    }

    public CustomText getCustomText(String separator) {
        for (CustomText customText : getCustomTextElements())
            if (customText.getFieldValue(Control.SEPARATOR.toString()).equals(separator))
                return customText;
        throw new IllegalArgumentException("There is no custom text with separator: " + separator);
    }

    public CustomText getCustomText(String separator, List<CustomText> customTexts) {
        for (CustomText customText : customTexts)
            if (customText.getFieldValue(Control.SEPARATOR.toString()).equals(separator))
                return customText;
        throw new IllegalArgumentException("There is no custom text with separator: " + separator);
    }

    public List<String> getAvailableMetadataNames() {
        return getMetadataElements().get(0).getAvailableNames();
    }

    public int getAvailableMetadataNamesCount() {
        return getAvailableMetadataNames().size();
    }

    public static class MetadataElement extends AdCodeManager {
        private WebElement metadata;
        private String position;
        private DojoSelect metadataName;
        private DojoSelect metadataCharacters;
        private Span removeItemBtn;
        private Span addItemBtn;

        public MetadataElement(MetadataPage parent, WebElement metadata) {
            super(parent);
            this.metadata = metadata;
            position = metadata.findElement(generateElementLocatorByDataRole("position")).getText();
            removeItemBtn = new Span(parent, metadata.findElement(getRemoveItemBtnLocator()));
            addItemBtn = new Span(parent, metadata.findElement(getAddItemBtnLocator()));
        }

        @Override
        protected void initControls() {
            controls.put(Control.METADATA_NAME.toString(), metadataName = new DojoSelect(parent, metadata.findElement(generateElementLocatorByDataRole("metadataField"))));
            controls.put(Control.METADATA_CHARACTERS.toString(), metadataCharacters = new DojoSelect(parent, metadata.findElement(generateElementLocatorByDataRole("metadataCharsNum"))));
        }

        @Override
        protected String getRootNode() {
            return CONTAINER_NODE;
        }

        public String getPosition() {
            return position;
        }

        public void addItem() {
            int metadataItemsCount = getDriver().findElements(getAdCodeMetadataRowLocator()).size();
            clickAddItemBtn();
            waitUntilMetadataItemWillBeAdded(metadataItemsCount);
        }

        public void removeItem() {
            int metadataItemsCount = getDriver().findElements(getAdCodeMetadataRowLocator()).size();
            clickRemoveItemBtn();
            waitUntilMetadataItemWillBeRemoved(metadataItemsCount);
        }

        public List<String> getAvailableNames() {
            getControls();
            return metadataName.getLabels();
        }

        private void waitUntilMetadataItemWillBeAdded(final int metadataItemsCount) {
            getDriver().waitUntil(new ExpectedCondition<Boolean>() {
                public Boolean apply(WebDriver webDriver) {
                    return webDriver.findElements(getAdCodeMetadataRowLocator()).size() == (metadataItemsCount + 1);
                }
            });
        }

        private void waitUntilMetadataItemWillBeRemoved(final int metadataItemsCount) {
            getDriver().waitUntil(new ExpectedCondition<Boolean>() {
                public Boolean apply(WebDriver webDriver) {
                    return webDriver.findElements(getAdCodeMetadataRowLocator()).size() == (metadataItemsCount - 1);
                }
            });
        }

        private void clickAddItemBtn() {
            addItemBtn.click();
        }

        private void clickRemoveItemBtn() {
            removeItemBtn.click();
        }
    }

    public static class CustomText extends AdCodeManager {
        private WebElement customText;
        private String position;
        private Edit separator;
        private Span removeItemBtn;
        private Span addItemBtn;

        public CustomText(MetadataPage parent, WebElement customText) {
            super(parent);
            this.customText = customText;
            position = customText.findElement(generateElementLocatorByDataRole("position")).getText();
            removeItemBtn = new Span(parent, customText.findElement(getRemoveItemBtnLocator()));
            addItemBtn = new Span(parent, customText.findElement(getAddItemBtnLocator()));
        }

        @Override
        protected void initControls() {
            controls.put(Control.SEPARATOR.toString(), separator = new Edit(parent, customText.findElement(generateElementLocatorByDataRole("freeTextField"))));
        }

        @Override
        protected String getRootNode() {
            return CONTAINER_NODE;
        }

        public String getPosition() {
            return position;
        }

        public void addItem() {
            int customTextItemsCount = getDriver().findElements(getAdCodeCustomTextRowLocator()).size();
            clickAddItemBtn();
            waitUntilCustomTextItemWillBeAdded(customTextItemsCount);
        }

        public void removeItem() {
            int customTextItemsCount = getDriver().findElements(getAdCodeCustomTextRowLocator()).size();
            clickRemoveItemBtn();
            waitUntilCustomTextItemWillBeRemoved(customTextItemsCount);
        }

        private void waitUntilCustomTextItemWillBeAdded(final int customTextItemsCount) {
            getDriver().waitUntil(new ExpectedCondition<Boolean>() {
                public Boolean apply(WebDriver webDriver) {
                    return webDriver.findElements(getAdCodeCustomTextRowLocator()).size() == (customTextItemsCount + 1);
                }
            });
        }

        private void waitUntilCustomTextItemWillBeRemoved(final int customTextItemsCount) {
            getDriver().waitUntil(new ExpectedCondition<Boolean>() {
                public Boolean apply(WebDriver webDriver) {
                    return webDriver.findElements(getAdCodeCustomTextRowLocator()).size() == (customTextItemsCount - 1);
                }
            });
        }

        private void clickAddItemBtn() {
            addItemBtn.click();
        }

        private void clickRemoveItemBtn() {
            removeItemBtn.click();
        }
    }

    public List<MetadataElement> getMetadataElements() {
        if (!getDriver().isElementVisible(getAdCodeMetadataRowLocator()))
            throw new NoSuchElementException("There is no any metadata elements on AdCode container form!");
        List<WebElement> rows = getAdCodeMetadataElements();
        List<MetadataElement> metadatas = new ArrayList<>();
        for (WebElement row : rows)
            metadatas.add(new MetadataElement((MetadataPage)parent, row));
        return metadatas;
    }

    public List<CustomText> getCustomTextElements() {
        if (!getDriver().isElementVisible(getAdCodeCustomTextRowLocator()))
            throw new NoSuchElementException("There is no any custom texts on AdCode container form!");
        List<WebElement> rows = getAdCodeCustomTextElements();
        List<CustomText> customTexts = new ArrayList<>();
        for (WebElement row : rows)
            customTexts.add(new CustomText((MetadataPage)parent, row));
        return customTexts;
    }

    private enum Control {
        CODE_NAME("Code Name"),
        MARKET("Market"),
        PREVIEW("Preview"),
        CUSTOM_CODE_FORMAT("Custom Code Format"),
        DATE("Date"),
        DATE_FORMAT("Date Format"),
        SEQUENCE_CHARACTERS("Sequence Characters"),
        METADATA_ELEMENTS("Metadata Elements"),
        METADATA_NAME("Metadata Name"),
        METADATA_CHARACTERS("Metadata Characters"),
        FREE_TEXT("Free Text"),
        SEPARATOR("Separator");

        private String name;

        private Control(String name) {
            this.name = name;
        }


        @Override
        public String toString() {
            return name;
        }

        public static Control findByName(String name) {
            for (Control control: values())
                if (control.toString().equals(name))
                    return control;
            throw new IllegalArgumentException("Unknown control: " + name);
        }
    }

    protected static By getAdCodeMetadataRowLocator() {
        return By.cssSelector(CONTAINER_NODE + " .adcode-metadata-row");
    }

    protected static By getAdCodeCustomTextRowLocator() {
        return By.cssSelector(CONTAINER_NODE + " .adcode-free-text-row");
    }

    protected static By getRemoveItemBtnLocator() {
        return By.className("removeItem");
    }

    protected static By getAddItemBtnLocator() {
        return By.className("addItem");
    }

    private List<WebElement> getAdCodeMetadataElements() {
        return getDriver().findElements(getAdCodeMetadataRowLocator());
    }

    private List<WebElement> getAdCodeCustomTextElements() {
        return getDriver().findElements(getAdCodeCustomTextRowLocator());
    }

    private By getFormLocator() {
        return By.cssSelector(getRootNode());
    }
}