package utilities;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

public class Market implements Serializable {
    private String name;
    private List<Product> products = new ArrayList<>();
    
    public Market(String name) {
        this.name = name;
    }
    
    public JSONObject toJson() {
        JSONObject jo = new JSONObject();
        jo.put("name", name);
    
        JSONArray ja = new JSONArray();
        for (Product p: products) {
            ja.add(p.toJson());
        }
        jo.put("products", ja);
        
        return jo;
    }
    
    public String getName() {
        return name;
    }
    
    public void setName(String name) {
        this.name = name;
    }
    
    public List<Product> getProducts() {
        return products;
    }
}
