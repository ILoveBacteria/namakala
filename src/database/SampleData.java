package database;

import utilities.Category;
import utilities.Market;
import utilities.Product;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;

public class SampleData {
    public static void main(String[] args) {
        Product p1 = new Product(++Database.countProduct,"iPhone 13 pro max", "assets/images/iphone.png", "This product is in Test!", 999, "Mobiles", new Market("Digikala"), 3, new ArrayList<>(Arrays.asList(0xFF2196F3, 0xFFFFEB3B)), new ArrayList<>(Arrays.asList("128GB", "256GB", "512GB")));
        Product p2 = new Product(++Database.countProduct, "iPhone 13", "assets/images/iphone13.png", "This product is in Test!", 899, "Mobiles", new Market("Digikala"), 2, new ArrayList<>(Arrays.asList(0xFF2196F3, 0xFF000000)), new ArrayList<>(Arrays.asList("128GB", "256GB")));
        Product p3 = new Product(++Database.countProduct, "iPhone 13 pro", "assets/images/iphone.png", "This product is in Test!", 999, "Mobiles", new Market("Digikala"), 1, new ArrayList<>(Arrays.asList(0xFF2196F3, 0xFF000000)), new ArrayList<>(Arrays.asList("128GB", "256GB")));
        Product p4 = new Product(++Database.countProduct, "iPhone 13 mini", "assets/images/iphone13.png", "This product is in Test!", 899, "Mobiles", new Market("Digikala"), 0, new ArrayList<>(Arrays.asList(0xFF2196F3)), new ArrayList<>(Arrays.asList("128GB", "256GB")));
        Product p5 = new Product(++Database.countProduct, "Macbook Air", "assets/images/macbook.png", "This product is in Test!", 999, "Laptops", new Market("Digikala"), 3, new ArrayList<>(Arrays.asList(0xFF9E9E9E)), new ArrayList<>(Arrays.asList("default")));
        Product p6 = new Product(++Database.countProduct, "Macbook Pro M1", "assets/images/macbook.png", "This product is in Test!", 1199, "Laptops", new Market("Digikala"), 2, new ArrayList<>(Arrays.asList(0xFF9E9E9E)), new ArrayList<>(Arrays.asList("default")));
    
        Category category1 = new Category(new ArrayList<>(Arrays.asList(p1, p2, p3, p4)), "Mobiles");
        Category category2 = new Category(new ArrayList<>(Arrays.asList(p5, p6)), "Laptops");
    
        try {
            Database.writeCategory(category1);
            Database.writeCategory(category2);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
