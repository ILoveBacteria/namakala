package utilities;

import database.Database;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import java.io.IOException;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

public class Person implements Serializable {
    private String image = "assets/images/user.png";
    private String firstname;
    private String lastname;
    private String email;
    private String phone;
    private String password;
    private Market market;
    private List<Cart> purchases = new ArrayList<>();
    private List<Product> favorites = new ArrayList<>();
    private Cart cart = new Cart();
    private List<Integer> scores = new ArrayList<>();
    
    public Person(String firstname, String lastname, String email, String phone, String password, Market market) {
        this.firstname = firstname;
        this.lastname = lastname;
        this.email = email;
        this.phone = phone;
        this.password = password;
        this.market = market;
    }
    
    public Person(String firstname, String lastname, String email, String phone, String password, Market market, String image) {
        this.firstname = firstname;
        this.lastname = lastname;
        this.email = email;
        this.phone = phone;
        this.password = password;
        this.market = market;
        this.image = image;
    }
    
    public static Person fromJson(JSONObject jsonObject) throws IOException {
        String firstname = (String) jsonObject.get("firstname");
        String lastname = (String) jsonObject.get("lastname");
        String email = (String) jsonObject.get("email");
        String phone = (String) jsonObject.get("phone");
        String password = (String) jsonObject.get("password");
        String marketName = (String) jsonObject.get("market");
        
        Object obj = jsonObject.get("image");
        if (obj != null) {
            JSONArray joImage = (JSONArray) obj;
            byte[] bytes = new byte[joImage.size()];
            int i = 0;
            for (Object o : joImage) {
                bytes[i] = ((Long) o).byteValue();
                i++;
            }
            return new Person(firstname, lastname, email, phone, password, new Market(marketName), Database.writeImage(bytes, phone));
        }
    
        return new Person(firstname, lastname, email, phone, password, new Market(marketName));
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
    
        JSONArray jaScores = new JSONArray();
        for (Integer i : scores) {
            jaScores.add(i);
        }
        jo.put("scores", jaScores);
    
        JSONArray jsonImage = new JSONArray();
        for (byte b : Database.readImage(image)) {
            jsonImage.add(b);
        }
        jo.put("image", jsonImage);
        
        jo.put("cart", cart.toJson());
        
        return jo;
    }
    
    public String getPhone() {
        return phone;
    }
    
    public Cart getCart() {
        return cart;
    }
    
    public String getPassword() {
        return password;
    }
    
    public List<Product> getFavorites() {
        return favorites;
    }
    
    public void checkout() {
        purchases.add(cart);
        cart = new Cart();
    }
    
    public String getFirstname() {
        return firstname;
    }
    
    public void setFirstname(String firstname) {
        this.firstname = firstname;
    }
    
    public String getLastname() {
        return lastname;
    }
    
    public void setLastname(String lastname) {
        this.lastname = lastname;
    }
    
    public String getEmail() {
        return email;
    }
    
    public void setEmail(String email) {
        this.email = email;
    }
    
    public void setPhone(String phone) {
        this.phone = phone;
    }
    
    public void setPassword(String password) {
        this.password = password;
    }
    
    public Market getMarket() {
        return market;
    }
    
    public void setMarket(Market market) {
        this.market = market;
    }
    
    public List<Integer> getScores() {
        return scores;
    }
    
    public String getImage() {
        return image;
    }
    
    public void setImage(String image) {
        this.image = image;
    }
    
    public void setScores(List<Integer> scores) {
        this.scores = scores;
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
