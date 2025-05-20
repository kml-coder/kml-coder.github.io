package com.example.softmeth_project_5;

import android.content.Intent;
import android.os.Bundle;
import android.util.SparseBooleanArray;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.ListView;
import android.widget.Spinner;
import android.widget.Toast;

import androidx.activity.EdgeToEdge;
import androidx.appcompat.app.AppCompatActivity;
import androidx.core.graphics.Insets;
import androidx.core.view.ViewCompat;
import androidx.core.view.WindowInsetsCompat;

import com.example.softmeth_project_5.model.*;

import java.util.ArrayList;

public class OrderActivity extends AppCompatActivity {

    private String selectedStyle; // Style of pizza
    private String selectedSize; // Size of pizza
    private String selectedType; // Type of pizza

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        EdgeToEdge.enable(this);
        setContentView(R.layout.activity_order);

        // initialize OrderManager instance
        OrderManager orderManager = OrderManager.getInstance();
        // selectedStyle and selectedSize default value
        selectedStyle = "Chicago";
        selectedSize = "Medium";
        selectedType = "Deluxe";
        // Setup Spinner functionality
        setupStyleSpinner();
        setupSizeSpinner();
        setupTypeSpinnerAndToppingsList();
        // Setup button listeners
        Button addPizzaButton = findViewById(R.id.addPizzaButton);
        addPizzaButton.setOnClickListener(v -> buildPizzaAndAddToOrder());

        Button reviewOrderButton = findViewById(R.id.reviewOrderButton);
        reviewOrderButton.setOnClickListener(v -> {
            Intent intent = new Intent(OrderActivity.this, SummaryActivity.class);
            startActivity(intent);
        });

        ViewCompat.setOnApplyWindowInsetsListener(findViewById(R.id.main), (v, insets) -> {
            Insets systemBars = insets.getInsets(WindowInsetsCompat.Type.systemBars());
            v.setPadding(systemBars.left, systemBars.top, systemBars.right, systemBars.bottom);
            return insets;
        });
    }

    private void buildPizzaAndAddToOrder() {
        // Get current order from OrderManager
        OrderManager orderManager = OrderManager.getInstance();
        Order currentOrder = orderManager.getCurrentOrder();

        // Retrieve selected options from the UI
        String style = selectedStyle; // Already updated from Spinner
        String type = selectedType; // Already updated from Spinner
        String size = selectedSize; // Already updated from Spinner

        // Get selected toppings from the ListView
        ListView toppingsListView = findViewById(R.id.toppingsListView);
        SparseBooleanArray checkedItems = toppingsListView.getCheckedItemPositions();
        ArrayList<Topping> selectedToppings = new ArrayList<>();
        String[] toppingsArray = getResources().getStringArray(R.array.toppings);

        for (int i = 0; i < toppingsArray.length; i++) {
            if (checkedItems.get(i)) {
                selectedToppings.add(Topping.valueOf(toppingsArray[i].toUpperCase().replace(" ", "_")));
            }
        }

        // Create the pizza using the factory
        Pizza pizza;
        if ("Chicago".equals(style)) {
            ChicagoPizza chicagoFactory = new ChicagoPizza();
            pizza = createPizzaFromFactory(chicagoFactory, type, selectedToppings);
        } else {
            NYPizza nyFactory = new NYPizza();
            pizza = createPizzaFromFactory(nyFactory, type, selectedToppings);
        }

        // Set the size of the pizza
        if ("Small".equals(size)) {
            pizza.setSize(Size.SMALL);
        } else if ("Medium".equals(size)) {
            pizza.setSize(Size.MEDIUM);
        } else if ("Large".equals(size)) {
            pizza.setSize(Size.LARGE);
        }

        // Add pizza to the current order
        currentOrder.addPizza(pizza);

        // Notify the user
        Toast.makeText(this, "Pizza added to your order!", Toast.LENGTH_SHORT).show();
    }

    /**
     * Helper method for creating a pizza.
     * @param factory the PizzaFactory object.
     * @param type the type of the pizza.
     * @param toppings the toppings on the pizza.
     * @return the pizza.
     */
    private Pizza createPizzaFromFactory(PizzaFactory factory, String type, ArrayList<Topping> toppings) {
        switch (type) {
            case "Deluxe":
                return factory.createDeluxe();
            case "BBQ Chicken":
                return factory.createBBQChicken();
            case "Meatzza":
                return factory.createMeatzza();
            case "Build Your Own":
                BuildYourOwn byoPizza = (BuildYourOwn) factory.createBuildYourOwn();
                byoPizza.setToppings(toppings);
                return byoPizza;
            default:
                throw new IllegalArgumentException("Invalid pizza type: " + type);
        }
    }

    /**
     * Sets up and defines the behavior for the spinner.
     * Handles the selectedStyle variable.
     */
    private void setupStyleSpinner() {
        Spinner styleSpinner = findViewById(R.id.styleSpinner);
        ArrayAdapter<CharSequence> adapter = ArrayAdapter.createFromResource(
                this,
                R.array.pizza_styles,
                android.R.layout.simple_spinner_item
        );
        adapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
        styleSpinner.setAdapter(adapter);

        styleSpinner.setOnItemSelectedListener(new AdapterView.OnItemSelectedListener() {
            @Override
            public void onItemSelected(AdapterView<?> parent, View view, int position, long id) {
                selectedStyle = parent.getItemAtPosition(position).toString();
                updatePizzaImage();
            }

            @Override
            public void onNothingSelected(AdapterView<?> parent) {
                // Nothing required because default value is selected as "Chicago"
            }
        });
    }

    /**
     * Sets up and defines the behavior for the size spinner.
     * Handles the selectedSize variable.
     */
    private void setupSizeSpinner () {
        Spinner sizeSpinner = findViewById(R.id.sizeSpinner);
        ArrayAdapter<CharSequence> adapter = ArrayAdapter.createFromResource(
                this,
                R.array.sizes,
                android.R.layout.simple_spinner_item
        );
        adapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
        sizeSpinner.setAdapter(adapter);

        sizeSpinner.setSelection(1); // Default value: Medium

        sizeSpinner.setOnItemSelectedListener(new AdapterView.OnItemSelectedListener() {
            @Override
            public void onItemSelected(AdapterView<?> parent, View view, int position, long id) {
                selectedSize = parent.getItemAtPosition(position).toString();
            }

            @Override
            public void onNothingSelected(AdapterView<?> parent) {
                // Nothing required because default value is selected as "Chicago"
            }
        });
    }

    /**
     * Sets up the type spinner and toppings list interactions and behavior.
     */
    private void setupTypeSpinnerAndToppingsList() {
        Spinner typeSpinner = findViewById(R.id.typesSpinner);
        ListView toppingsListView = findViewById(R.id.toppingsListView);
        ArrayAdapter<CharSequence> typeAdapter = ArrayAdapter.createFromResource(
                this,
                R.array.pizza_types,
                android.R.layout.simple_spinner_item
        );
        typeAdapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
        typeSpinner.setAdapter(typeAdapter);
        typeSpinner.setSelection(0); // Default: "Deluxe"
        ArrayAdapter<CharSequence> toppingsAdapter = ArrayAdapter.createFromResource(
                this,
                R.array.toppings,
                android.R.layout.simple_list_item_multiple_choice
        );
        toppingsListView.setAdapter(toppingsAdapter);
        updateToppingsListViewState("Deluxe", toppingsListView);
        typeSpinner.setOnItemSelectedListener(new AdapterView.OnItemSelectedListener() {
            @Override
            public void onItemSelected(AdapterView<?> parent, View view, int position, long id) {
                selectedType = parent.getItemAtPosition(position).toString();
                updateToppingsListViewState(selectedType, toppingsListView);
                updatePizzaImage();
            }

            @Override
            public void onNothingSelected(AdapterView<?> parent) { }
        });
        toppingsListView.setOnItemClickListener((parent, view, position, id) -> {
            SparseBooleanArray checkedItems = toppingsListView.getCheckedItemPositions();
            int selectedCount = 0;
            for (int i = 0; i < checkedItems.size(); i++) {
                if (checkedItems.valueAt(i)) selectedCount++;
            }
            if (selectedCount > 7) {
                toppingsListView.setItemChecked(position, false); // Deselect the last selection
                Toast.makeText(this, "You can only select up to 7 toppings.", Toast.LENGTH_SHORT).show();
            }
        });
    }

    /**
     * Updates the state of the toppings ListView based on the selected pizza type.
     * @param selectedType The currently selected pizza type.
     * @param toppingsListView The toppings ListView to update.
     */
    private void updateToppingsListViewState(String selectedType, ListView toppingsListView) {
        if ("Build Your Own".equals(selectedType)) {
            toppingsListView.setEnabled(true); // Enable ListView
            toppingsListView.setAlpha(1.0f); // Restore full opacity
        } else {
            toppingsListView.setEnabled(false); // Disable ListView
            toppingsListView.setAlpha(0.5f); // Dim ListView
        }
    }

    /**
     * Handles updating the pizza image.
     */
    private void updatePizzaImage() {
        ImageView pizzaImageView = findViewById(R.id.pizzaImageView);
        int imageResId;
        if ("Chicago".equals(selectedStyle)) {
            switch (selectedType) {
                case "Deluxe":
                    imageResId = R.drawable.chicago_deluxe;
                    break;
                case "BBQ Chicken":
                    imageResId = R.drawable.chicago_bbq;
                    break;
                case "Meatzza":
                    imageResId = R.drawable.chicago_meatzza;
                    break;
                case "Build Your Own":
                    imageResId = R.drawable.chicago_byo;
                    break;
                default:
                    imageResId = R.drawable.chicago_deluxe; // Fallback image
            }
        } else if ("NYC".equals(selectedStyle)) {
            switch (selectedType) {
                case "Deluxe":
                    imageResId = R.drawable.ny_deluxe;
                    break;
                case "BBQ Chicken":
                    imageResId = R.drawable.ny_bbq;
                    break;
                case "Meatzza":
                    imageResId = R.drawable.ny_meatzza;
                    break;
                case "Build Your Own":
                    imageResId = R.drawable.ny_byo;
                    break;
                default:
                    imageResId = R.drawable.ny_deluxe; // Fallback image
            }
        } else {
            imageResId = R.drawable.chicago_deluxe; // Fallback image
        }
        pizzaImageView.setImageResource(imageResId);
    }
}