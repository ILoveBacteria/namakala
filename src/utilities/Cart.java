package utilities;

import java.io.Serializable;
import java.util.HashMap;
import java.util.Map;

public class Cart implements Serializable {
    private Map<SelectedProduct, Integer> products = new HashMap<>();
    
    public Map<SelectedProduct, Integer> getProducts() {
        return products;
    }
    
    public void add(SelectedProduct p) {
        if (products.containsKey(p)) {
            products.replace(p, products.get(p) + 1);
        } else {
            products.put(p, 1);
        }
    }
    
    public void remove(SelectedProduct p) {
        products.replace(p, products.get(p) - 1);
    }
    
    public void removeAll(SelectedProduct p) {
        products.remove(p);
    }
    
    public int sumOfPrice() {
        int sum = 0;
        for (SelectedProduct p : products.keySet()) {
            sum += products.get(p) * p.getProduct().getPrice();
        }
        
        return sum;
    }
}
