package com.adstream.automate.babylon.sut.pages.ordering.elements.lists;

import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;
import java.util.ArrayList;
import java.util.List;
import static com.thoughtworks.selenium.SeleneseTestBase.assertTrue;

/**
 * Created with IntelliJ IDEA.
 * User: demidovskiy-r
 * Date: 16.09.13
 * Time: 21:20
 */
public class ClockDeliveryNestedList extends AbstractList {

    public ClockDeliveryNestedList(ExtendedWebDriver web) {
        super(web);
    }

    @Override
    public void load() {
        super.load();
        web.waitUntilElementAppearVisible(generateNestedListLocator());
    }

    @Override
    public void isLoaded() throws Error {
        super.isLoaded();
        assertTrue(web.isElementVisible(generateNestedListLocator()));
    }

    public static class Destination {
        private String destination;
        List<String> statuses;
        private String selectedStatus;
        private String timeDelivery;
        private String priority;
        private String statusCancelled;

        public Destination(ExtendedWebDriver web, WebElement row) {
            List<WebElement> cells = row.findElements(By.className("cell"));
            if(cells.get(0).findElement(By.cssSelector(".pl35")).getAttribute("class").contains("lightgrey")){
                destination = cells.get(0).findElement(By.className("pl35")).getText();
                statusCancelled = cells.get(1).findElement(By.className("pl35")).getText();
            }else{
                destination = cells.get(0).findElement(By.className("pl35")).getText();
                statuses = getStatuses(cells.get(1).findElements(By.className("plxs")));
                selectedStatus = statuses.get(0);
                timeDelivery = cells.get(2).findElement(By.className("size1of1")).getText();
                priority = cells.get(3).findElement(By.tagName("div")).getText();
            }
        }

        public String getDestination() {
            return destination;
        }

        public String getSelectedStatus() {
            return selectedStatus;
        }

        public String getTimeDelivery() {
            return timeDelivery;
        }

        public String getPriority() {
            return priority;
        }

        public List<String> getStatuses() {
            return statuses;
        }
        public String getStatusCancelled() {
            return statusCancelled;
        }

        private List<String> getStatuses(List<WebElement> cells) {
            List<String> statuses = new ArrayList<String>();
            for (WebElement cell : cells)
                statuses.add(cell.getText());
            return statuses;
        }
    }

    public Destination getDestinationByName(String name) {
        for (Destination destination : getDestinations())
            if (destination.getDestination().equals(name))
                return destination;
        return null;
    }

    public List<String> getVisibleDestinations() {
        List<String> destinationNames = new ArrayList<String>();
        List<Destination> destinations = getDestinations();
        if (destinations == null) return destinationNames;
        for (Destination destination : destinations)
            destinationNames.add(destination.getDestination());
        return destinationNames;
    }

    private List<Destination> getDestinations() {
        if (!web.isElementVisible(getClockDeliveryRowLocator())) return null;
        List<WebElement> rows = web.findElements(getClockDeliveryRowLocator());
        List<Destination> destinations = new ArrayList<Destination>();
        for (WebElement row : rows)
            destinations.add(new Destination(web, row));
        return destinations;
    }

    private By getClockDeliveryRowLocator() {
        return generateNestedListLocator(".row");
    }

    public List<String> getStatusForDestination(String dest){
        List<String> status= new ArrayList<>();
        for(Destination d:getDestinations()){
            if(dest.equalsIgnoreCase(d.getDestination())){
                status=d.getStatuses();
            }
        }
        return status;
    }
}