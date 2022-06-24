package utilities;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

public class Person implements Serializable {
    private String firstname;
    private String lastname;
    private String email;
    private String phone;
    private String password;
    private Market market;
    private List<Cart> purchases = new ArrayList<>();
    private List<Product> favorites = new ArrayList<>();
    private Cart cart = new Cart();
    
    public Person(String firstname, String lastname, String email, String phone, String password) {
        this.firstname = firstname;
        this.lastname = lastname;
        this.email = email;
        this.phone = phone;
        this.password = password;
        this.market = new Market(this, String.format("%s %s", firstname, lastname));
    }
    
    public static Person fromJson(JSONObject jsonObject) {
        String firstname = (String) jsonObject.get("firstname");
        String lastname = (String) jsonObject.get("lastname");
        String email = (String) jsonObject.get("email");
        String phone = (String) jsonObject.get("phone");
        String password = (String) jsonObject.get("password");
    
        return new Person(firstname, lastname, email, phone, password);
    }
    
    public JSONObject toJson() {
        JSONObject jo = new JSONObject();
        
        jo.put("firstname", firstname);
        jo.put("lastname", lastname);
        jo.put("email", email);
        jo.put("phone", phone);
        jo.put("password", password);
        jo.put("market", market.toJson());
        
        JSONArray jaCart = new JSONArray();
        for (Cart c : purchases) {
            jaCart.add(c.toJson());
        }
        jo.put("purchases", jaCart);
        
        JSONArray jaFavorites = new JSONArray();
        for (Product p : favorites) {
            jaFavorites.add(p.toJson());
        }
        jo.put("favorites", jaFavorites);
        jo.put("cart", cart.toJson());
        
        return jo;
    }
    
    public String getPhone() {
        return phone;
    }
    
    public void setPhone(String phone) {
        this.phone = phone;
    }
    
    public String getPassword() {
        return password;
    }
    
    public void checkout() {
        purchases.add(cart);
        cart = new Cart();
    }
    
    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        
        Person person = (Person) o;
    
        return Objects.equals(phone, person.phone);
    }
    
    @Override
    public int hashCode() {
        return phone != null ? phone.hashCode() : 0;
    }
}
