package database;

import utilities.Market;
import utilities.Product;

import java.util.ArrayList;
import java.util.Arrays;

public class SampleData {
    public static void main(String[] args) {
        Product p1 = new Product("iPhone 13 pro max", "assets/images/iphone.png", "This product is in Test!", 999, "Mobiles", new Market("Digikala"), 3, new ArrayList<>(Arrays.asList(0xFF2196F3, 0xFFFFEB3B)), new ArrayList<>(Arrays.asList("128GB", "256GB", "512GB")));
    }
}
