package com.example.softmeth_project_5.model;

/**
 * This enum class represents the available sizes for a pizza.
 * @author Jack Lin, Kyungmin Lee
 */
public enum Size {
    SMALL,
    MEDIUM,
    LARGE;

    /**
     * Returns a user-friendly representation of the size.
     * @return the string.
     */
    @Override
    public String toString() {
        String name = this.name().toLowerCase();
        return Character.toUpperCase(name.charAt(0)) + name.substring(1);
    }
}
