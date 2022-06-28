package utilities;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import java.io.Serializable;
import java.util.*;

public class Cart implements Serializable {
    private final List<SelectedProduct> products = new ArrayList<>();
    
    public JSONObject toJson() {
        JSONObject jo = new JSONObject();
        JSONArray ja = new JSONArray();
        
        products.stream().map(SelectedProduct::toJson).forEach(ja::add);
        jo.put("products", ja);
        return jo;
    }
    
    public List<SelectedProduct> getProducts() {
        return products;
    }
    
    public void add(SelectedProduct p) {
        if (products.contains(p)) {
            products.stream().filter(x -> x.equals(p)).forEach(x -> x.setCount(x.getCount() + 1));
        } else {
            products.add(p);
        }
    }
    
    public void remove(SelectedProduct p) {
        products.stream().filter(x -> x.equals(p)).forEach(x -> x.setCount(x.getCount() - 1));
    }
    
    public void removeAll(SelectedProduct p) {
        products.remove(p);
    }
    
    public int sumOfPrice() {
        Optional<Integer> sum = products.stream().map(x -> x.getProduct().getPrice() * x.getCount()).reduce(Integer::sum);
        return sum.orElse(0);
    }
}
