package utilities;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

public class Market implements Serializable {
    private Person owner;
    private String name;
    private List<Product> products = new ArrayList<>();
    
    public Market(Person owner, String name) {
        this.owner = owner;
        this.name = name;
    }
    
    public Person getOwner() {
        return owner;
    }
    
    public String getName() {
        return name;
    }
    
    public List<Product> getProducts() {
        return products;
    }
}
