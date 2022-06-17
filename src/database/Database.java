package database;

import utilities.Person;

import javax.xml.crypto.Data;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.nio.file.*;

public class Database {
    private static Database instance = new Database();
    private long countPerson = 0;
    private long countProduct = 0;
    private final Path personPath = Paths.get("src/database/person.txt");
    
    public static Database getInstance() {
        return instance;
    }
    
    public long getCountPerson() {
        return countPerson;
    }
    
    public void setCountPerson(long countPerson) {
        this.countPerson = countPerson;
    }
    
    public long getCountProduct() {
        return countProduct;
    }
    
    public void setCountProduct(long countProduct) {
        this.countProduct = countProduct;
    }
    
    /**
     * This method takes a phone number and searches for a {@link Person} in the database and returns it if present
     *
     * @param phone A phone to find a person
     * @return A {@link Person} if found else returns null
     */
    public Person findByPhone(String phone) {
        try (ObjectInputStream in = new ObjectInputStream(Files.newInputStream(personPath))) {
            while (in.available() != 0) {
                Person person = (Person) in.readObject();
                if (person.getPhone().equals(phone)) {
                    return person;
                }
            }
        } catch (IOException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return null;
    }
}
