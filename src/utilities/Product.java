package utilities;

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
    private List<Integer> colors;
    private List<String> sizes;
    
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
        this.colors = colors;
        this.sizes = sizes;
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
