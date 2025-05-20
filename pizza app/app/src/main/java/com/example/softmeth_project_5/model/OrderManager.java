package com.example.softmeth_project_5.model;

import java.util.ArrayList;

/**
 * Singleton class to manage orders.
 * Handles the current order and a list of placed orders.
 * @author Jack Lin, Kyungmin Lee
 */
public class OrderManager {
    private static OrderManager instance;
    private Order currentOrder;
    private ArrayList<Order> placedOrders;

    /**
     * A private constructor for the OrderManager object.
     */
    private OrderManager() {
        this.currentOrder = new Order(new ArrayList<Pizza>());
        this.placedOrders = new ArrayList<Order>();
    }

    /**
     * Returns the singleton instance of OrderManager.
     * @return the instance.
     */
    public static synchronized OrderManager getInstance() {
        if (instance == null) instance = new OrderManager();
        return instance;
    }

    /**
     * Places the current order and resets the currentOrder variable.
     * Also moves the order to the placedOrders list.
     */
    public void placeOrder() {
        placedOrders.add(currentOrder);
        this.currentOrder = new Order(new ArrayList<Pizza>());
    }

    /**
     * Retrieves the current order.
     * @return the current order.
     */
    public Order getCurrentOrder() {
        return currentOrder;
    }

    /**
     * Retrieves the placed orders.
     * @return the placed orders.
     */
    public ArrayList<Order> getPlacedOrders() {
        return placedOrders;
    }
}
