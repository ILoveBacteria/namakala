package database;

import utilities.Category;
import utilities.Person;
import utilities.Product;

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
    
    public static void saveEditedPerson(Person person) throws IOException, ClassNotFoundException {
        List<Person> personList = readAllPersons();
        personList.remove(person);
        personList.add(person);
        writeAllPersons(personList);
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
    
    public static byte[] readImage(String path) {
        try (FileInputStream in = new FileInputStream(path)) {
            byte[] file = new byte[in.available()];
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
    
    public static void writeCategory(Category category) throws IOException {
        Path path = getCategoryPath(category.getName());
        try (ObjectOutputStream out = new ObjectOutputStream(Files.newOutputStream(path))) {
            out.writeObject(category);
        }
    }
    
    public static Product readProduct(Product product) throws IOException, ClassNotFoundException {
        Category category = readCategory(product.getCategory());
        for (Product p : category.getProducts()) {
            if (p.equals(product)) {
                return p;
            }
        }
        
        return null;
    }
    
    public static void writeEditedProduct(Product newProduct) throws IOException, ClassNotFoundException {
        Category category = readCategory(newProduct.getCategory());
        category.getProducts().remove(newProduct);
        category.getProducts().add(newProduct);
        writeCategory(category);
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
