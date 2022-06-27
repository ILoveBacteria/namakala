package server;

import database.Database;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import utilities.Person;
import utilities.Product;

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
            case "image":
                return imageCommand();
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
            Object obj = new JSONParser().parse(data[0]);
            JSONObject jsonObject = (JSONObject) obj;
            Person person = Person.fromJson(jsonObject);
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
     * Executes the image command. Finds the product in category then reads its image
     * @return an image in bytes
     */
    private byte[] imageCommand() {
        try {
            Object obj = new JSONParser().parse(data[0]);
            JSONObject jsonObject = (JSONObject) obj;
            Product product = Database.readProduct((Long) jsonObject.get("id"), (String) jsonObject.get("category"));
            return Database.readImage(product.getImage());
        } catch (ParseException | IOException | ClassNotFoundException e) {
            e.printStackTrace();
        }
    
        return "null".getBytes(StandardCharsets.UTF_8);
    }
}
