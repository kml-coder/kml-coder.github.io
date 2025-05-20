package com.example.softmeth_project_5.model;

import java.util.ArrayList;

/**
 * This class helps in creating the base for Chicago-style pizza.
 * Implements the PizzaFactory interface.
 * @author Jack Lin, Kyungmin Lee
 */
public class ChicagoPizza implements PizzaFactory {

    /**
     * Creates a chicago-style deluxe pizza.
     * @return a chicago-style deluxe pizza object.
     */
    @Override
    public Pizza createDeluxe() {
        return new Deluxe(Crust.DEEP_DISH);
    }

    /**
     * Creates a chicago-style Meatzza pizza.
     * @return a chicago-style Meatzza pizza object.
     */
    @Override
    public Pizza createMeatzza() {
        return new Meatzza(Crust.STUFFED);
    }

    /**
     * Creates a chicago-style BBQ Chicken pizza.
     * @return a chicago-style BBQ Chicken pizza object.
     */
    @Override
    public Pizza createBBQChicken() {
        return new BBQChicken(Crust.PAN);
    }

    /**
     * Creates a chicago-style BuildYourOwn pizza.
     * @return a chicago-style BuildYourOwn pizza object.
     */
    @Override
    public Pizza createBuildYourOwn() {
        return new BuildYourOwn(new ArrayList<Topping>(), Crust.PAN);
    }
}
