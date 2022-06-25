package database;

import utilities.Market;
import utilities.Product;

import java.util.ArrayList;
import java.util.Arrays;

public class SampleData {
    public static void main(String[] args) {
        Product p1 = new Product("iPhone 13 pro max", "assets/images/iphone.png", "This product is in Test!", 999, "Mobiles", new Market("Digikala"), 3, new ArrayList<>(Arrays.asList(0xFF2196F3, 0xFFFFEB3B)), new ArrayList<>(Arrays.asList("128GB", "256GB", "512GB")));
        Product p2 = new Product("iPhone 13", "assets/images/iphone13.png", "This product is in Test!", 899, "Mobiles", new Market("Digikala"), 2, new ArrayList<>(Arrays.asList(0xFF2196F3, 0xFF000000)), new ArrayList<>(Arrays.asList("128GB", "256GB")));
        Product p3 = new Product("iPhone 13 pro", "assets/images/iphone.png", "This product is in Test!", 999, "Mobiles", new Market("Digikala"), 1, new ArrayList<>(Arrays.asList(0xFF2196F3, 0xFF000000)), new ArrayList<>(Arrays.asList("128GB", "256GB")));
        Product p4 = new Product("iPhone 13 mini", "assets/images/iphone13.png", "This product is in Test!", 899, "Mobiles", new Market("Digikala"), 0, new ArrayList<>(Arrays.asList(0xFF2196F3)), new ArrayList<>(Arrays.asList("128GB", "256GB")));
        Product p5 = new Product("Macbook Air", "assets/images/macbook.png", "This product is in Test!", 999, "Laptops", new Market("Digikala"), 3, new ArrayList<>(Arrays.asList(0xFF9E9E9E)), new ArrayList<>(Arrays.asList("default")));
        Product p6 = new Product("Macbook Pro M1", "assets/images/macbook.png", "This product is in Test!", 1199, "Laptops", new Market("Digikala"), 2, new ArrayList<>(Arrays.asList(0xFF9E9E9E)), new ArrayList<>(Arrays.asList("default")));
        
        Database.saveNewProduct(p1);
        Database.saveNewProduct(p2);
        Database.saveNewProduct(p3);
        Database.saveNewProduct(p4);
        Database.saveNewProduct(p5);
        Database.saveNewProduct(p6);
    }
}
