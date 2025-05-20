package com.example.softmeth_project_5.model;

import java.util.ArrayList;

/**
 * This class represents a BuildYourOwn Pizza.
 * Toppings are chosen by the customer.
 * For Chicago style, the crust is Pan.
 * For NY style, the crust is Hand-tossed.
 * @author Jack Lin, Kyungmin Lee
 */
public class BuildYourOwn extends Pizza {

    /**
     * A constructor for a BuildYourOwn Pizza.
     * @param toppings the toppings chosen.
     * @param crust the type of crust.
     */
    public BuildYourOwn(ArrayList<Topping> toppings, Crust crust) {
        super(toppings, crust);
    }

    /**
     * Determines the price of a BuildYourOwn pizza.
     * The price scales with the number of the toppings up to 7.
     * @return the price of a BuildYourOwn pizza.
     */
    @Override
    public double price() {
        double base;
        if (getSize() == Size.SMALL) {
            base = 8.99;
        } else if (getSize() == Size.MEDIUM) {
            base = 10.99;
        } else {
            base = 12.99;
        }
        double extra = 1.69 * getToppings().size();
        return base + extra;
    }
}
