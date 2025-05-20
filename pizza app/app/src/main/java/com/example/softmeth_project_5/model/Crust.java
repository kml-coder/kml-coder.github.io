package com.example.softmeth_project_5.model;

/**
 * This enum class holds the type of crusts used for pizza.
 * @author Jack Lin, Kyungmin Lee
 */
public enum Crust {
    DEEP_DISH,
    PAN,
    STUFFED,
    BROOKLYN,
    THIN,
    HAND_TOSSED;

    /**
     * Returns a user-friendly string representation of Crust.
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
