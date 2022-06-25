package utilities;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import java.io.Serializable;
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
    
    public Product(String name, String image, String detail, int price, String category, Market market,
                   int count, List<Integer> colors, List<String> sizes) {
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
        // TODO: handle image
        jo.put("detail", detail);
        jo.put("price", price);
        jo.put("category", category);
        jo.put("market", market.toJson());
        jo.put("size", new JSONArray().addAll(size));
        jo.put("color", new JSONArray().addAll(color));
        
        return jo;
    }
    
    public void setId(int id) {
        this.id = id;
    }
    
    public int getPrice() {
        return price;
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
