package utilities;

import database.Database;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import java.io.Serializable;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;

public class Product implements Serializable {
    private int id;
    private String name;
    private String image;
    private String detail;
    private int price;
    private String category;
    private Market market;
    private int count;
    private double score = 0.0;
    private int countVoters = 0;
    private List<Integer> color;
    private List<String> size;
    
    public Product(int id, String name, String image, String detail, int price, String category, Market market,
                   int count, List<Integer> colors, List<String> sizes) {
        this.id = id;
        this.name = name;
        this.image = image;
        this.detail = detail;
        this.price = price;
        this.category = category;
        this.market = market;
        this.count = count;
        this.color = colors;
        this.size = sizes;
    }
    
    public JSONObject toJson() {
        JSONObject jo = new JSONObject();
        jo.put("id", id);
        jo.put("name", name);
        jo.put("detail", detail);
        jo.put("price", price);
        jo.put("category", category);
        jo.put("count", count);
        jo.put("market", market.toJson());
        
        JSONArray jsonSize = new JSONArray();
        for (String s : size) {
            jsonSize.add(s);
        }
        jo.put("size", jsonSize);
        
        JSONArray jsonColor = new JSONArray();
        for (Integer i : color) {
            jsonColor.add(i);
        }
        jo.put("color", jsonColor);
        
        return jo;
    }
    
    public void setId(int id) {
        this.id = id;
    }
    
    public int getPrice() {
        return price;
    }
    
    public String getCategory() {
        return category;
    }
    
    public int getId() {
        return id;
    }
    
    public String getImage() {
        return image;
    }
    
    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        
        Product product = (Product) o;
    
        return id == product.id;
    }
    
    @Override
    public int hashCode() {
        return id;
    }
}
