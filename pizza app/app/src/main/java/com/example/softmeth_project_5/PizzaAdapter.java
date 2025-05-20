package com.example.softmeth_project_5;

import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;
import androidx.annotation.NonNull;
import androidx.recyclerview.widget.RecyclerView;
import com.example.softmeth_project_5.R;
import com.example.softmeth_project_5.model.Pizza;

import java.util.List;

public class PizzaAdapter extends RecyclerView.Adapter<PizzaAdapter.PizzaViewHolder> {

    private final List<Pizza> pizzaList;

    public PizzaAdapter(List<Pizza> pizzaList) {
        this.pizzaList = pizzaList;
    }

    @NonNull
    @Override
    public PizzaViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(parent.getContext()).inflate(R.layout.item_pizza, parent, false);
        return new PizzaViewHolder(view);
    }

    @Override
    public void onBindViewHolder(@NonNull PizzaViewHolder holder, int position) {
        Pizza pizza = pizzaList.get(position);
        holder.pizzaDescriptionTextView.setText(pizza.toString()); // Assume Pizza has a meaningful toString()
        holder.pizzaPriceTextView.setText(String.format("$%.2f", pizza.price()));
    }

    @Override
    public int getItemCount() {
        return pizzaList.size();
    }

    public static class PizzaViewHolder extends RecyclerView.ViewHolder {
        TextView pizzaDescriptionTextView;
        TextView pizzaPriceTextView;

        public PizzaViewHolder(@NonNull View itemView) {
            super(itemView);
            pizzaDescriptionTextView = itemView.findViewById(R.id.pizzaDescriptionTextView);
            pizzaPriceTextView = itemView.findViewById(R.id.pizzaPriceTextView);
        }
    }
}
