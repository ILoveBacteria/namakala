package server;

import database.Database;
import utilities.Person;

import java.io.ObjectInputStream;

public class Command {
    private String command;
    private String[] action;
    private Person sender;
    
    private Command() {}
    
    public static Command parseCommand(String value) {
        Command obj = new Command();
        
        String[] splitCommand = value.split(" ", 3);
        obj.sender = Database.findByPhone(splitCommand[0]);
        obj.command = splitCommand[1];
        obj.action = splitCommand[2].split(";");
        
        return obj;
    }
    
    /**
     * Executes the received command
     *
     * @return The response to the received command
     */
    public String runCommand() {
        if (command.equals("sign-in")) {
            return signInCommand();
        }
        
        return null;
    }
    
    /**
     * Executes the sign-in command
     *
     * @return The validity of the Phone and Password
     */
    private String signInCommand() {
        Person person = Database.findByPhone(action[0]);
        if (person == null) {
            return "false;false";
        }
        
        if (person.getPassword().equals(action[1])) {
            return "true;true";
        }
        
        return "true;false";
    }
    
    private String checkoutCartCommand() {
        sender.checkout();
        boolean result =  Database.saveEditedPerson(sender);
        return String.valueOf(result);
    }
}
