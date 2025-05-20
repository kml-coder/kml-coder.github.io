package com.example.softmeth_project_5.model;

/**
 * This enum class holds the choice of toppings for the pizzeria.
 * @author Jack Lin, Kyungmin Lee
 */
public enum Topping {
    SAUSAGE,
    PEPPERONI,
    GREEN_PEPPER,
    ONION,
    MUSHROOM,
    BBQ_CHICKEN,
    PROVOLONE,
    CHEDDAR,
    BEEF,
    HAM,
    PINEAPPLE,
    JALAPENO,
    CHICKEN;

    /**
     * Returns a user-friendly representation of the toppings.
     * @return the string.
     */
    @Override
    public String toString() {
        StringBuilder stringBuilder = new StringBuilder();
        String[] words = this.name().toLowerCase().split("_");
        for (String word : words) {
            stringBuilder.append(Character.toUpperCase(word.charAt(0)))
                    .append(word.substring(1))
                    .append(" ");
        }
        return stringBuilder.toString().trim();
    }
}
