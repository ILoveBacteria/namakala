package utilities;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import java.io.Serializable;
import java.util.List;
import java.util.stream.Collectors;

public class Category implements Serializable {
    private final List<Product> products;
    private String name;
    
    public Category(List<Product> products, String name) {
        this.products = products;
        this.name = name;
    }
    
    public void setName(String name) {
        this.name = name;
    }
    
    public String getName() {
        return name;
    }
    
    public List<Product> getProducts() {
        return products;
    }
    
    public JSONObject toJson() {
        JSONObject jo = new JSONObject();
        JSONArray ja = new JSONArray();
        
        List<JSONObject> jsonProducts = products.stream()
                .parallel()
                .map(Product::toJson)
                .collect(Collectors.toList());
        
        ja.addAll(jsonProducts);
        jo.put("products", ja);
        return jo;
    }
}
