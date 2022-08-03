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
    private static final Path personPath = Paths.get("database/person.txt");
    private static final Path mobilesPath = Paths.get("database/mobiles.txt");
    private static final Path laptopsPath = Paths.get("database/laptops.txt");
    private static final Path cameraPath = Paths.get("database/camera.txt");
    private static final Path tabletsPath = Paths.get("database/tablets.txt");
    private static final Path menPath = Paths.get("database/men.txt");
    private static final Path womenPath = Paths.get("database/women.txt");
    private static final Path kidsPath = Paths.get("database/kids.txt");
    private static final Path athleticClothingsPath = Paths.get("database/athleticClothings.txt");
    private static final Path sportsEquipmentsPath = Paths.get("database/sportsEquipments.txt");
    private static final Path campingPath = Paths.get("database/camping.txt");
    
    /**
     * This method takes a phone number and searches for a {@link Person} in the database and returns it if present
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
    
    /**
     * Reads all {@link Person} objects from file and replaces the edited person object to the list
     * @param person Edited person data
     * @throws IOException if an I/O error occurs while reading stream header
     * @throws ClassNotFoundException Class of a serialized object cannot be found
     */
    public static void saveEditedPerson(Person person) throws IOException, ClassNotFoundException {
        List<Person> personList = readAllPersons();
        personList.remove(person);
        personList.add(person);
        writeAllPersons(personList);
    }
    
    /**
     * Reads all {@link Person} objects from file
     * @return All {@link Person} objects as {@link List}
     * @throws IOException if an I/O error occurs while reading stream header
     * @throws ClassNotFoundException Class of a serialized object cannot be found
     */
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
    
    /**
     * Reads all {@link Person} objects from file and adds the new person object to the list
     * @param person new person object
     * @return The success of writing the new data to file
     */
    public static boolean saveNewPerson(Person person) {
        try {
            List<Person> personList = readAllPersons();
            personList.add(person);
            writeAllPersons(personList);
            return true;
    
        } catch (IOException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        
        return false;
    }
    
    /**
     * Writes all person objects to file
     * @param personList List of {@link Person} that will be written to file
     * @throws IOException if an I/O error occurs while reading stream header
     */
    private static void writeAllPersons(List<Person> personList) throws IOException {
        try (ObjectOutputStream out = new ObjectOutputStream(Files.newOutputStream(personPath))) {
            for (Person p : personList) {
                out.writeObject(p);
            }
        }
    }
    
    /**
     * Reads an image file as bytes
     * @param path The path of the image
     * @return Byte array of the image
     */
    public static byte[] readImage(String path) {
        try (FileInputStream in = new FileInputStream(path)) {
            byte[] file = new byte[in.available()];
            int CountBytesRead = in.read(file);
            if (CountBytesRead < file.length) {
                throw new IOException("Cannot read all image files");
            }
            return file;
        } catch (IOException e) {
            e.printStackTrace();
        }
        
        return "null".getBytes(StandardCharsets.UTF_8);
    }
    
    /**
     * Writes an image file
     * @param bytes byte array of image
     * @param id The product's id
     * @return The full path name of image file
     * @throws IOException if an I/O error occurs while reading stream header
     */
    public static String writeImage(byte[] bytes, String id) throws IOException {
        String name = "src/database/data/" + id + ".png";
        try (FileOutputStream out = new FileOutputStream(name)) {
            out.write(bytes);
        }
        return name;
    }
    
    /**
     * Reads the category object from file
     * @param name The category name
     * @return The category object
     * @throws IOException if an I/O error occurs while reading stream header
     * @throws ClassNotFoundException Class of a serialized object cannot be found
     */
    public static Category readCategory(String name) throws IOException, ClassNotFoundException {
        Path path = getCategoryPath(name);
        try (ObjectInputStream in = new ObjectInputStream(Files.newInputStream(path))) {
            return (Category) in.readObject();
        } catch (NoSuchFileException e) {
            e.printStackTrace();
            Category newCategory = new Category(new ArrayList<>(), name);
            writeCategory(newCategory);
            return newCategory;
        }
    }
    
    /**
     * Writes a category object after modified
     * @param category The category object that will be written in file
     * @throws IOException if an I/O error occurs while reading stream header
     */
    public static void writeCategory(Category category) throws IOException {
        Path path = getCategoryPath(category.getName());
        try (ObjectOutputStream out = new ObjectOutputStream(Files.newOutputStream(path))) {
            out.writeObject(category);
        }
    }
    
    /**
     * Finds a product after reads the category object from file
     * @param product The products that will be read from file
     * @return The product with all data
     * @throws IOException if an I/O error occurs while reading stream header
     * @throws ClassNotFoundException Class of a serialized object cannot be found
     */
    public static Product readProduct(Product product) throws IOException, ClassNotFoundException {
        Category category = readCategory(product.getCategory());
        for (Product p : category.getProducts()) {
            if (p.equals(product)) {
                return p;
            }
        }
        throw new IOException("Product not found");
    }
    
    /**
     * Reads the category and replaces the new product to list
     * @param newProduct The edited product
     * @throws IOException if an I/O error occurs while reading stream header
     * @throws ClassNotFoundException Class of a serialized object cannot be found
     */
    public static void writeEditedProduct(Product newProduct) throws IOException, ClassNotFoundException {
        Category category = readCategory(newProduct.getCategory());
        category.getProducts().remove(newProduct);
        category.getProducts().add(newProduct);
        writeCategory(category);
    }
    
    /**
     * Reads the category object and adds the new product object to category list
     * @param newProduct The new product object
     * @throws IOException if an I/O error occurs while reading stream header
     * @throws ClassNotFoundException Class of a serialized object cannot be found
     */
    public static void writeProduct(Product newProduct) throws IOException, ClassNotFoundException {
        Category category = readCategory(newProduct.getCategory());
        category.getProducts().add(newProduct);
        writeCategory(category);
    }
    
    /**
     * Reads the category object and removes the product from list
     * @param product The product that should be removes
     * @throws IOException if an I/O error occurs while reading stream header
     * @throws ClassNotFoundException Class of a serialized object cannot be found
     */
    public static void removeProduct(Product product) throws IOException, ClassNotFoundException {
        Category category = readCategory(product.getCategory());
        category.getProducts().remove(product);
        writeCategory(category);
    }
    
    /**
     * @param name The category name
     * @return The path of where the category object is saved in a file
     * @throws IOException Category path file cannot be found
     */
    private static Path getCategoryPath(String name) throws IOException {
        switch (name) {
            case "Mobiles":
                return mobilesPath;
            case "Laptops":
                return laptopsPath;
            case "Camera":
                return cameraPath;
            case "Tablets":
                return tabletsPath;
            case "Men":
                return menPath;
            case "Women":
                return womenPath;
            case "Kids & Baby":
                return kidsPath;
            case "Athletic Clothings":
                return athleticClothingsPath;
            case "Sports Equipments":
                return sportsEquipmentsPath;
            case "Camping":
                return campingPath;
            default:
                throw new IOException("Can't find the path of category");
        }
    }
    
    /**
     * Before the server starts, creates directory if not exist
     * @throws IOException Directory path cannot be found
     */
    public static void createDirectory() throws IOException {
        Path database = Paths.get("database");
        if (Files.notExists(database)) {
            Files.createDirectory(database);
        }
    }
}
