package com.example.softmeth_project_5.model;

import java.util.ArrayList;
import java.util.Arrays;

/**
 * This class represents a Meatzza Pizza.
 * Characterized by toppings which are sausage, pepperoni, beef, and ham.
 * For Chicago style, the crust is Stuffed.
 * For NY style, the crust is Hand-tossed.
 * @author Jack Lin, Kyungmin Lee
 */
public class Meatzza extends Pizza {

    /**
     * A constructor for a Meatzza Pizza.
     * The toppings are already predetermined.
     * @param crust the type of crust for the pizza.
     */
    public Meatzza(Crust crust) {
        super(new ArrayList<Topping>(Arrays.asList(
                Topping.SAUSAGE,
                Topping.PEPPERONI,
                Topping.BEEF,
                Topping.HAM
        )), crust);
    }

    /**
     * Determines the price of a Meatzza Pizza.
     * @return the price of a Meatzza Pizza.
     */
    @Override
    public double price() {
        if (getSize() == Size.SMALL) {
            return 17.99;
        } else if (getSize() == Size.MEDIUM) {
            return 19.99;
        } else {
            return 21.99;
        }
    }
}
