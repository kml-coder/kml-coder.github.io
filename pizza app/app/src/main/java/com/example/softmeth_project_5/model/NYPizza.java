package com.example.softmeth_project_5.model;

import java.util.ArrayList;

/**
 * This class helps in creating the base for NY-style pizza.
 * Implements the PizzaFactory interface.
 * @author Jack Lin, Kyungmin Lee
 */
public class NYPizza implements PizzaFactory {

    /**
     * Creates a NY-style deluxe pizza.
     * @return a NY-style deluxe pizza object.
     */
    @Override
    public Pizza createDeluxe() {
        return new Deluxe(Crust.BROOKLYN);
    }

    /**
     * Creates a NY-style Meatzza pizza.
     * @return a NY-style Meatzza pizza object.
     */
    @Override
    public Pizza createMeatzza() {
        return new Meatzza(Crust.HAND_TOSSED);
    }

    /**
     * Creates a NY-style BBQ Chicken pizza
     * @return a NY-style BBQ Chicken pizza
     */
    @Override
    public Pizza createBBQChicken() {
        return new BBQChicken(Crust.THIN);
    }

    /**
     * Creates a NY-style BuildYourOwn pizza
     * @return a NY-style BuildYourOwn pizza
     */
    @Override
    public Pizza createBuildYourOwn() {
        return new BuildYourOwn(new ArrayList<Topping>(), Crust.HAND_TOSSED);
    }
}