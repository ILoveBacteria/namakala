package server;

import database.Database;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import utilities.Person;
import utilities.Product;
import utilities.SelectedProduct;

import java.io.IOException;
import java.nio.charset.StandardCharsets;

public class Command {
    private String command;
    private String[] data;
    private Person sender;
    
    private Command() {}
    
    public static Command parseCommand(String value) {
        Command obj = new Command();
        
        String[] splitCommand = value.split(" ", 3);
        
        if (!splitCommand[0].equals("null")) {
            obj.sender = Database.findByPhone(splitCommand[0]);
        }
        
        obj.command = splitCommand[1];
        if (splitCommand.length >= 3)
            obj.data = splitCommand[2].split(";");
    
        return obj;
    }
    
    /**
     * Executes the received command
     * @return The response to the received command
     */
    public byte[] runCommand() {
        System.out.println(command);
        switch (command) {
            case "signIn":
                return signInCommand();
            case "checkoutCart":
                return checkoutCartCommand();
            case "signUp":
                return signUpCommand();
            case "profile":
                return profileCommand();
            case "cart":
                return cartCommand();
            case "category":
                return categoryCommand();
            case "addFavorites":
                return addFavorites();
            case "removeFavorites":
                return removeFavorites();
            case "addCart":
                return addCart();
        }
        
        return null;
    }
    
    /**
     * Executes the signIn command. Searches for a person with this provided data
     * @return The validity of the Phone and Password
     */
    private byte[] signInCommand() {
        Person person = Database.findByPhone(data[0]);
        if (person == null) {
            return "false;false".getBytes(StandardCharsets.UTF_8);
        }
        
        if (person.getPassword().equals(data[1])) {
            return "true;true".getBytes(StandardCharsets.UTF_8);
        }
        
        return "true;false".getBytes(StandardCharsets.UTF_8);
    }
    
    /**
     * Executes the checkoutCart command. Checkouts all the products in the sender cart
     * @return The success of checkout
     */
    private byte[] checkoutCartCommand() {
        sender.checkout();
        boolean result =  Database.saveEditedPerson(sender);
        return String.valueOf(result).getBytes(StandardCharsets.UTF_8);
    }
    
    /**
     * Executes the signUp command. Creates a new person then writes in the database
     * @return The success of creating a new account
     */
    private byte[] signUpCommand() {
        try {
            Person person = jsonToPerson();
            boolean result = Database.saveNewPerson(person);
            return String.valueOf(result).getBytes(StandardCharsets.UTF_8);
            
        } catch (ParseException e) {
            e.printStackTrace();
        }
        
        return "false".getBytes(StandardCharsets.UTF_8);
    }
    
    /**
     * Executes the profile command. Converts sender to json
     * @return a person json string object in bytes
     */
    private byte[] profileCommand() {
        try {
            return sender.toJson().toJSONString().getBytes(StandardCharsets.UTF_8);
        } catch (NullPointerException e) {
            e.printStackTrace();
        }
        return "null".getBytes(StandardCharsets.UTF_8);
    }
    
    /**
     * Executes the cart command. Gets the cart object of sender
     * @return a cart json string object in bytes
     */
    private byte[] cartCommand() {
        try {
            return sender.getCart().toJson().toJSONString().getBytes(StandardCharsets.UTF_8);
        } catch (NullPointerException e) {
            e.printStackTrace();
        }
        return "null".getBytes(StandardCharsets.UTF_8);
    }
    
    /**
     * Executes the category command. Reads the category object from database
     * @return a category json string object in bytes
     */
    private byte[] categoryCommand() {
        try {
            return Database.readCategory(data[0]).toJson().toJSONString().getBytes(StandardCharsets.UTF_8);
        } catch (IOException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return "null".getBytes(StandardCharsets.UTF_8);
    }
    
    /**
     * Executes the addFavorite command. Finds the product in database and adds it to favorite list
     * @return The success of adding product in bytes
     */
    private byte[] addFavorites() {
        try {
            Product product = Database.readProduct(jsonToIncompleteProduct());
            sender.getFavorites().add(product);
            Database.saveEditedPerson(sender);
            return "true".getBytes(StandardCharsets.UTF_8);
    
        } catch (ParseException | IOException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        
        return "false".getBytes(StandardCharsets.UTF_8);
    }
    
    /**
     * Executes the removeFavorite command. Finds the product in database and removes it from favorite list
     * @return The success of removing product in bytes
     */
    private byte[] removeFavorites() {
        try {
            Product product = Database.readProduct(jsonToIncompleteProduct());
            sender.getFavorites().remove(product);
            Database.saveEditedPerson(sender);
            return "true".getBytes(StandardCharsets.UTF_8);
    
        } catch (ParseException | IOException | ClassNotFoundException e) {
            e.printStackTrace();
        }
    
        return "false".getBytes(StandardCharsets.UTF_8);
    }
    
    private byte[] addCart() {
        try {
            SelectedProduct selectedProduct = jsonToIncompleteSelectedProduct();
            selectedProduct.setProduct(Database.readProduct(selectedProduct.getProduct()));
            
            if (selectedProduct.getProduct().purchase()) {
                sender.getCart().add(selectedProduct);
                Database.saveEditedPerson(sender);
                Database.writeEditedProduct(selectedProduct.getProduct());
                return ("true;" + selectedProduct.getProduct().getCount()).getBytes(StandardCharsets.UTF_8);
            }
            return ("false;" + selectedProduct.getProduct().getCount()).getBytes(StandardCharsets.UTF_8);
    
        } catch (ParseException | ClassNotFoundException | IOException e) {
            e.printStackTrace();
        }
        
        return "false".getBytes(StandardCharsets.UTF_8);
    }
    
    private Person jsonToPerson() throws ParseException {
        Object obj = new JSONParser().parse(data[0]);
        JSONObject jsonObject = (JSONObject) obj;
        return Person.fromJson(jsonObject);
    }
    
    private Product jsonToIncompleteProduct() throws ParseException {
        Object obj = new JSONParser().parse(data[0]);
        JSONObject jsonObject = (JSONObject) obj;
        return Product.fromJson(jsonObject);
    }
    
    private SelectedProduct jsonToIncompleteSelectedProduct() throws ParseException {
        Object obj = new JSONParser().parse(data[0]);
        JSONObject jsonObject = (JSONObject) obj;
        return SelectedProduct.fromJson(jsonObject);
    }
}
