package com.example.softmeth_project_5.model;

/**
 * An interface class that helps to make the pizza object with the crusts and toppings.
 * @author Jack Lin, Kyungmin Lee
 */
public interface PizzaFactory {
    Pizza createDeluxe();
    Pizza createMeatzza();
    Pizza createBBQChicken();
    Pizza createBuildYourOwn();
}
