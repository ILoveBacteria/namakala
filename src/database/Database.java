package database;

import utilities.Person;

import java.io.IOException;
import java.io.ObjectInputStream;
import java.nio.file.*;

public class Database {
    private static final Path personPath = Paths.get("src/database/person.txt");
    
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
}
