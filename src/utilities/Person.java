package utilities;

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
