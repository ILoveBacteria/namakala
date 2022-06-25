package database;

import utilities.Person;

import javax.xml.crypto.Data;
import java.io.*;
import java.nio.file.*;
import java.util.ArrayList;
import java.util.List;

public class Database {
    public static long countPerson = 0;
    public static long countProduct = 0;
    private static final Path personPath = Paths.get("src/database/person.txt");
    
    /**
     * This method takes a phone number and searches for a {@link Person} in the database and returns it if present
     *
     * @param phone A phone to find a person
     * @return A {@link Person} if found else returns null
     */
    public static Person findByPhone(String phone) {
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
    
    public static boolean saveEditedPerson(Person person) {
        try {
            List<Person> personList = readAllPersons();
            personList.remove(person);
            personList.add(person);
            writeAllPersons(personList);
            return true;
            
        } catch (IOException | ClassNotFoundException e) {
            e.printStackTrace();
        }
    
        return false;
    }
    
    private static List<Person> readAllPersons() throws IOException, ClassNotFoundException {
        List<Person> personList = new ArrayList<>();
        try (ObjectInputStream in = new ObjectInputStream(Files.newInputStream(personPath))) {
            while (in.available() != 0) {
                personList.add((Person) in.readObject());
            }
        } catch (EOFException e) {
            e.printStackTrace();
        }
        
        return personList;
    }
    
    public static boolean saveNewPerson(Person person) {
        try {
            List<Person>personList = readAllPersons();
            personList.add(person);
            writeAllPersons(personList);
            return true;
    
        } catch (IOException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        
        return false;
    }
    
    private static void writeAllPersons(List<Person> personList) throws IOException {
        try (ObjectOutputStream out = new ObjectOutputStream(Files.newOutputStream(personPath))) {
            for (Person p : personList) {
                out.writeObject(p);
            }
        }
    }
    
    private static void writeAllProducts(List<Product> productList) throws IOException {
        try (ObjectOutputStream out = new ObjectOutputStream(Files.newOutputStream(productPath))) {
            for (Product p : productList) {
                out.writeObject(p);
            }
        }
    }
    
    private static List<Product> readAllProducts() throws IOException, ClassNotFoundException {
        List<Product> productList = new ArrayList<>();
        try (ObjectInputStream in = new ObjectInputStream(Files.newInputStream(productPath))) {
            while (in.available() != 0) {
                productList.add((Product) in.readObject());
            }
        } catch (EOFException e) {
            e.printStackTrace();
        }
        
        return productList;
    }
    
    public static boolean saveNewProduct(Product product) {
        product.setId(++countProduct);
        
        try {
            List<Product> productList = readAllProducts();
            productList.add(product);
            writeAllProducts(productList);
            return true;
            
        } catch (IOException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        
        return false;
    }
    
    public static boolean saveEditedProduct(Product product) {
        try {
            List<Product> productList = readAllProducts();
            productList.remove(product);
            productList.add(product);
            writeAllProducts(productList);
            return true;
            
        } catch (IOException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        
        return false;
    }
    
    public static byte[] readImage() {
        try (FileInputStream in = new FileInputStream("assets/images/iphone.png")) {
            byte[] file = new byte[in.available()];
            in.read(file);
            return file;
        } catch (FileNotFoundException e) {
            throw new RuntimeException(e);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }
}
