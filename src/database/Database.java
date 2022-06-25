package database;

import utilities.Category;
import utilities.Person;
import utilities.Product;

import javax.xml.crypto.Data;
import java.io.*;
import java.nio.charset.StandardCharsets;
import java.nio.file.*;
import java.util.ArrayList;
import java.util.List;

public class Database {
    public static int countProduct = 0;
    private static final Path personPath = Paths.get("src/database/data/person.txt");
    private static final Path mobilesPath = Paths.get("src/database/data/mobiles.txt");
    private static final Path laptopsPath = Paths.get("src/database/data/laptops.txt");
    
    /**
     * This method takes a phone number and searches for a {@link Person} in the database and returns it if present
     *
     * @param phone A phone to find a person
     * @return A {@link Person} if found else returns null
     */
    public static Person findByPhone(String phone) {
        try (ObjectInputStream in = new ObjectInputStream(Files.newInputStream(personPath))) {
            while (in.available() >= 0) {
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
    
    /*private static void writeAllProducts(List<Product> productList) throws IOException {
        try (ObjectOutputStream out = new ObjectOutputStream(Files.newOutputStream(productPath))) {
            for (Product p : productList) {
                out.writeObject(p);
            }
        }
    }

    public static List<Product> readAllProducts() throws IOException, ClassNotFoundException {
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
    }*/
    
    public static byte[] readImage(String path) {
        try (FileInputStream in = new FileInputStream(path)) {
            byte[] file = new byte[in.available() * 2];
            in.read(file);
            return file;
        } catch (IOException e) {
            e.printStackTrace();
        }
        
        return "null".getBytes(StandardCharsets.UTF_8);
    }
    
    public static Category readCategory(String name) throws IOException, ClassNotFoundException {
        Path path = getCategoryPath(name);
        try (ObjectInputStream in = new ObjectInputStream(Files.newInputStream(path))) {
            return (Category) in.readObject();
        }
    }
    
    private static Path getCategoryPath(String name) {
        switch (name) {
            case "Mobiles":
                return mobilesPath;
            case "Laptops":
                return laptopsPath;
            default:
                return null;
        }
    }
}
