package utilities;

import java.io.Serializable;
import java.util.Objects;

public class SelectedProduct implements Serializable {
    private Product product;
    private int color;
    private String size;
    
    public SelectedProduct(Product product, int color, String size) {
        this.product = product;
        this.color = color;
        this.size = size;
    }
    
    public Product getProduct() {
        return product;
    }
    
    public int getColor() {
        return color;
    }
    
    public String getSize() {
        return size;
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
        result = 31 * result + color;
        result = 31 * result + (size != null ? size.hashCode() : 0);
        return result;
    }
}
