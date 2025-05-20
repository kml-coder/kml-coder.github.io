package com.example.softmeth_project_5;

import android.os.Bundle;
import android.widget.TextView;

import androidx.activity.EdgeToEdge;
import androidx.appcompat.app.AppCompatActivity;
import androidx.core.graphics.Insets;
import androidx.core.view.ViewCompat;
import androidx.core.view.WindowInsetsCompat;
import androidx.recyclerview.widget.DividerItemDecoration;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import com.example.softmeth_project_5.model.*;

import java.util.ArrayList;

public class SummaryActivity extends AppCompatActivity {
    private static final double TAX_RATE = 0.06625;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        EdgeToEdge.enable(this);
        setContentView(R.layout.activity_summary);

        ArrayList<Pizza> pizzaList = OrderManager.getInstance().getCurrentOrder().getPizzas();

        // Set up RecyclerView
        RecyclerView orderRecyclerView = findViewById(R.id.orderRecyclerView);
        orderRecyclerView.setLayoutManager(new LinearLayoutManager(this));
        orderRecyclerView.setAdapter(new PizzaAdapter(pizzaList));
        DividerItemDecoration dividerItemDecoration = new DividerItemDecoration(
                orderRecyclerView.getContext(),
                LinearLayoutManager.VERTICAL
        );
        orderRecyclerView.addItemDecoration(dividerItemDecoration);

        // Calculate and display the subtotal and total
        TextView subtotalTextView = findViewById(R.id.subtotalTextView);
        TextView totalTextView = findViewById(R.id.totalTextView);

        double subtotal = calculateSubtotal(pizzaList);
        double total = calculateTotal(subtotal);

        subtotalTextView.setText(String.format("Subtotal: $%.2f", subtotal));
        totalTextView.setText(String.format("Total (incl. tax): $%.2f", total));

        ViewCompat.setOnApplyWindowInsetsListener(findViewById(R.id.main), (v, insets) -> {
            Insets systemBars = insets.getInsets(WindowInsetsCompat.Type.systemBars());
            v.setPadding(systemBars.left, systemBars.top, systemBars.right, systemBars.bottom);
            return insets;
        });
    }

    /**
     * Calculates the subtotal of all pizzas in the order.
     * @param pizzaList the list of pizzas in the order.
     * @return the subtotal amount.
     */
    private double calculateSubtotal(ArrayList<Pizza> pizzaList) {
        double subtotal = 0.0;
        for (Pizza pizza : pizzaList) {
            subtotal += pizza.price();
        }
        return subtotal;
    }

    /**
     * Calculates the total with tax.
     * @param subtotal the subtotal amount.
     * @return the total amount including tax.
     */
    private double calculateTotal(double subtotal) {
        return subtotal + (subtotal * TAX_RATE);
    }
}