package com.example.softmeth_project_5.model;

import java.util.ArrayList;
import java.util.Arrays;

/**
 * This class represents a BBQ Chicken Pizza.
 * Characterized by toppings which include BBQ chicken, green peppers, provolone, and cheddar.
 * For Chicago style, the crust is Pan.
 * For NY style, the crust is Thin.
 * @author Jack Lin, Kyungmin Lee
 */
public class BBQChicken extends Pizza {

    /**
     * A constructor for a BBQ Chicken pizza.
     * The toppings are already predetermined.
     * @param crust the type of crust for the pizza.
     */
    public BBQChicken(Crust crust) {
        super(new ArrayList<Topping>(Arrays.asList(
                Topping.BBQ_CHICKEN,
                Topping.GREEN_PEPPER,
                Topping.PROVOLONE,
                Topping.CHEDDAR
        )), crust);
    }

    /**
     * Determines the price of a BBQ Chicken Pizza.
     * @return the price of a BBQ Chicken Pizza.
     */
    @Override
    public double price() {
        if (getSize() == Size.SMALL) {
            return 14.99;
        } else if (getSize() == Size.MEDIUM) {
            return 16.99;
        } else {
            return 19.99;
        }
    }
}
