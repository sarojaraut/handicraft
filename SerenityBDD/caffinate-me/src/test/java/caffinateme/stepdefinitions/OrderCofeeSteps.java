package caffinateme.stepdefinitions;

import io.cucumber.java.en.And;
import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;

public class OrderCofeeSteps {

    Customer cathy = new Customer();


    @Given("Cathy is {int} meters away from the coffee shop")
    public void cathy_is_n_meters_away_from_the_coffee_shop(Integer distanceInMeters) {
        // Write code here that turns the phrase above into concrete actions
        cathy.setDistanceFromShop(distanceInMeters);
    }
    @When("^Cathy orders a (.*)$")
    public void cathy_orders_a(String order) {
        // Write code here that turns the phrase above into concrete actions
        cathy.placeOrderFor(order);
    }
    @Then("^Barry should receive the order$")
    public void barry_should_receive_the_order() {
        // Write code here that turns the phrase above into concrete actions
        throw new io.cucumber.java.PendingException();
    }
    @And("^Barry should know that the coffee is urgent$")
    public void barry_should_know_that_the_cofee_is_urgent() {
        // Write code here that turns the phrase above into concrete actions
        throw new io.cucumber.java.PendingException();
    }
}
