package server;

import database.Database;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import utilities.Person;

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
    public String runCommand() {
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
        }
        
        return null;
    }
    
    /**
     * Executes the signIn command
     * @return The validity of the Phone and Password
     */
    private String signInCommand() {
        Person person = Database.findByPhone(data[0]);
        if (person == null) {
            return "false;false";
        }
        
        if (person.getPassword().equals(data[1])) {
            return "true;true";
        }
        
        return "true;false";
    }
    
    /**
     * Executes the checkoutCart command
     * @return The success of checkout
     */
    private String checkoutCartCommand() {
        sender.checkout();
        boolean result =  Database.saveEditedPerson(sender);
        return String.valueOf(result);
    }
    
    /**
     * Executes the signUp command
     * @return The success of creating a new account
     */
    private String signUpCommand() {
        try {
            Object obj = new JSONParser().parse(data[0]);
            JSONObject jsonObject = (JSONObject) obj;
            Person person = Person.fromJson(jsonObject);
            boolean result = Database.saveNewPerson(person);
            return String.valueOf(result);
            
        } catch (ParseException e) {
            e.printStackTrace();
        }
        
        return "false";
    }
    
    /**
     * Executes the profile command
     * @return a person object as json
     */
    private String profileCommand() {
        try {
            return sender.toJson().toJSONString();
        } catch (NullPointerException e) {
            e.printStackTrace();
        }
        
        return "null";
    }
    
    private String cartCommand() {
        try {
            return sender.getCart().toJson().toJSONString();
        } catch (NullPointerException e) {
            e.printStackTrace();
        }
        
        return "null";
    }
}
