package com.example.softmeth_project_5.model;

import java.util.ArrayList;

/**
 * This abstract class contains the Pizza object.
 * Pizza has four subclasses: Deluxe, BBQChicken, Meatzza, and BuildYourOwn.
 * @author Jack Lin, Kyungmin Lee
 */
public abstract class Pizza {
    private ArrayList<Topping> toppings; // Topping is a Enum class
    private Crust crust; // Crust is a Enum class
    private Size size; // Size is a Enum class

    /**
     * Constructor for a pizza object.
     * @param toppings the list of toppings on the pizza.
     * @param crust the type of crust for the pizza.
     */
    public Pizza(ArrayList<Topping> toppings, Crust crust) {
        this.toppings = toppings;
        this.crust = crust;
        this.size = Size.MEDIUM;
    }

    /**
     * Gets the list of toppings.
     * @return the toppings list.
     */
    public ArrayList<Topping> getToppings() {
        return toppings;
    }

    /**
     * Sets the list of toppings.
     * @param toppings the list of the toppings.
     */
    public void setToppings(ArrayList<Topping> toppings) {
        this.toppings = toppings;
    }

    /**
     * Gets the type of the crust.
     * @return the type of the crust.
     */
    public Crust getCrust() {
        return crust;
    }

    /**
     * Sets the type of crust.
     * @param crust the type of crust.
     */
    public void setCrust(Crust crust) {
        this.crust = crust;
    }

    /**
     * Gets the size of the pizza.
     * @return the size of the pizza.
     */
    public Size getSize() {
        return size;
    }

    /**
     * Sets the size of the pizza.
     * @param size the size of the pizza.
     */
    public void setSize(Size size) {
        this.size = size;
    }

    /**
     * Determines the price of the pizza.
     * @return the price as a double.
     */
    public abstract double price();

    /**
     * Returns a user-friendly string representation of the pizza.
     * @return the string.
     */
    @Override
    public String toString() {
        StringBuilder description = new StringBuilder();
        description.append("Style: ").append(getCrust().toString()).append("\n") // Use Crust's toString()
                .append("Size: ").append(getSize().toString()).append("\n")   // Use Size's toString()
                .append("Toppings: ");
        for (Topping topping : getToppings()) {
            description.append(topping.toString()).append(", "); // Use Topping's toString()
        }
        // Remove trailing comma and space
        if (description.toString().endsWith(", ")) {
            description = new StringBuilder(description.substring(0, description.length() - 2));
        }
        return description.toString();
    }
}
