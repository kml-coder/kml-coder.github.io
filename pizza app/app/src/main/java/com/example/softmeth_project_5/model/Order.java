package com.example.softmeth_project_5.model;

import java.util.ArrayList;

/**
 * This class represents an order of pizzas.
 * Contains a unique serial number for the order.
 * @author Jack Lin, Kyungmin Lee
 */
public class Order {
    private int number; // order number
    private ArrayList<Pizza> pizzas; // can use List<E> instead of ArrayList<E>
    private static int orderTally = 0; // Assigns the number to the order

    /**
     * Constructor for an order.
     * The number is automatically assigned to the n-th order.
     * @param pizzas the pizzas in the order.
     */
    public Order(ArrayList<Pizza> pizzas) {
        this.number = orderTally++;
        this.pizzas = pizzas;
    }

    /**
     * Adds a pizza to the pizzas ArrayList
     * @param pizza the pizza to be added.
     */
    public void addPizza(Pizza pizza) {
        pizzas.add(pizza);
    }

    /**
     * Retrieves the order number.
     * @return the order number.
     */
    public int getNumber() {
        return number;
    }

    /**
     * Retrieves the pizzas in the order.
     * @return the pizzas in the order in an ArrayList.
     */
    public ArrayList<Pizza> getPizzas() {
        return pizzas;
    }
}
