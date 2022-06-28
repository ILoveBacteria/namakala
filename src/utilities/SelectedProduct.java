package utilities;

import org.json.simple.JSONObject;

import java.io.Serializable;
import java.util.Map;
import java.util.Objects;

public class SelectedProduct implements Serializable {
    private Product product;
    private long color;
    private String size;
    
    public SelectedProduct(Product product, long color, String size) {
        this.product = product;
        this.color = color;
        this.size = size;
    }
    
    public static SelectedProduct fromJson(JSONObject jsonObject) {
        Product product = Product.fromJson(new JSONObject((Map) jsonObject.get("product")));
        long color = (Long) jsonObject.get("color");
        String size = (String) jsonObject.get("size");
        return new SelectedProduct(product, color, size);
    }
    
    public JSONObject toJson() {
        JSONObject jo = new JSONObject();
        jo.put("product", product);
        jo.put("color", color);
        jo.put("size", size);
        return jo;
    }
    
    public Product getProduct() {
        return product;
    }
    
    public long getColor() {
        return color;
    }
    
    public String getSize() {
        return size;
    }
    
    public void setProduct(Product product) {
        this.product = product;
    }
    
    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        
        SelectedProduct that = (SelectedProduct) o;
        
        if (color != that.color) return false;
        if (!Objects.equals(product, that.product)) return false;
        return Objects.equals(size, that.size);
    }
    
    @Override
    public int hashCode() {
        int result = product != null ? product.hashCode() : 0;
        result = 31 * result + (int) (color ^ (color >>> 32));
        result = 31 * result + (size != null ? size.hashCode() : 0);
        return result;
    }
}
