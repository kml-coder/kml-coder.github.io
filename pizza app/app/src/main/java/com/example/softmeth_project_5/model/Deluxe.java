package com.example.softmeth_project_5.model;

import java.util.ArrayList;
import java.util.Arrays;

/**
 * This class represents a Deluxe Pizza.
 * Characterized by toppings which are sausage, pepperoni, green peppers, onions, and mushrooms.
 * For Chicago style, the crust is Deep Dish.
 * For NY style, the crust is Brooklyn.
 * @author Jack Lin, Kyungmin Lee
 */
public class Deluxe extends Pizza {

    /**
     * A constructor for a deluxe pizza.
     * The toppings are already predetermined.
     * @param crust the type of crust for the pizza.
     */
    public Deluxe(Crust crust) {
        super(new ArrayList<Topping>(Arrays.asList(
                Topping.SAUSAGE,
                Topping.PEPPERONI,
                Topping.GREEN_PEPPER,
                Topping.ONION,
                Topping.MUSHROOM
        )), crust);
    }

    /**
     * Determines the price of a Deluxe Pizza.
     * @return the price of a Deluxe Pizza.
     */
    @Override
    public double price() {
        if (getSize() == Size.SMALL) {
            return 16.99;
        } else if (getSize() == Size.MEDIUM) {
            return 18.99;
        } else {
            return 20.99;
        }
    }
}
