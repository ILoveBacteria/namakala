package utilities;

import database.Database;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import java.io.IOException;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

public class Product implements Serializable {
    private long id;
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
    
    public Product(long id, String category) {
        this.id = id;
        this.category = category;
    }
    
    public Product(long id, String name, String image, String detail, int price, String category, Market market,
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
        jo.put("score", score);
        
        JSONArray jsonImage = new JSONArray();
        for (byte b : Database.readImage(image)) {
            jsonImage.add(b);
        }
        jo.put("image", jsonImage);
        
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
    
    public static Product fromJson(JSONObject jsonObject) {
        String category = (String) jsonObject.get("category");
        long id = (Long) jsonObject.get("id");
        
        return new Product(id, category);
    }
    
    public static Product fromJsonComplete(JSONObject jsonObject) throws IOException {
        String category = (String) jsonObject.get("category");
        String name = (String) jsonObject.get("name");
        String detail = (String) jsonObject.get("detail");
        long price = (Long) jsonObject.get("price");
        String market = (String) jsonObject.get("market");
        long count = (Long) jsonObject.get("count");
        
        JSONArray joSizes = (JSONArray) jsonObject.get("size");
        List<String> sizeList = new ArrayList<>();
        for (Object o : joSizes) {
            sizeList.add((String) o);
        }
    
        JSONArray joColors = (JSONArray) jsonObject.get("color");
        List<Integer> colorList = new ArrayList<>();
        for (Object o : joColors) {
            Long l = (Long) o;
            colorList.add(l.intValue());
        }
        
        JSONArray joImage = (JSONArray) jsonObject.get("image");
        byte[] bytes = new byte[joImage.size()];
        int i = 0;
        for (Object o : joImage) {
            Long l = (Long) o;
            bytes[i] = l.byteValue();
            i++;
        }
        
        long id = ++Database.countProduct;
        return new Product(id, name, Database.writeImage(bytes, id), detail, (int) price, category, new Market(market), (int) count, colorList, sizeList);
    }
    
    public boolean purchase() {
        if (count >= 1) {
            --count;
            return true;
        }
        return false;
    }
    
    public double addNewRate(double newScore) {
        ++countVoters;
        this.score = ((countVoters - 1) * this.score + newScore) / countVoters;
        return this.score;
    }
    
    public void setCount(int count) {
        this.count = count;
    }
    
    public int getPrice() {
        return price;
    }
    
    public String getCategory() {
        return category;
    }
    
    public String getImage() {
        return image;
    }
    
    public int getCount() {
        return count;
    }
    
    public long getId() {
        return id;
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
        return (int) (id ^ (id >>> 32));
    }
}
