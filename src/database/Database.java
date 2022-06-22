package database;

import utilities.Person;

import javax.xml.crypto.Data;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
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
            
           return writeAllPersons(personList);
            
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
        }
        
        return personList;
    }
    
    public static boolean saveNewPerson(Person person) {
        try {
            List<Person>personList = readAllPersons();
            personList.add(person);
            
            return writeAllPersons(personList);
    
        } catch (IOException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        
        return false;
    }
    
    private static boolean writeAllPersons(List<Person> personList) {
        try (ObjectOutputStream out = new ObjectOutputStream(Files.newOutputStream(personPath))) {
            for (Person p : personList) {
                out.writeObject(p);
            }
            return true;
        
        } catch (IOException e) {
            e.printStackTrace();
        }
    
        return false;
    }
}
