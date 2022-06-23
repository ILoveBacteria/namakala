package server;

import java.io.IOException;
import java.net.Socket;
import java.util.Formatter;
import java.util.Scanner;

public class AcceptClient implements Runnable {
    Socket socket;
    
    public AcceptClient(Socket socket) {
        this.socket = socket;
    }
    
    @Override
    public void run() {
        try (Scanner in = new Scanner(socket.getInputStream(), "UTF-8");
             Formatter out = new Formatter(socket.getOutputStream(), "UTF-8")) {
            
            String input = in.nextLine();
            Command inputCommand = Command.parseCommand(input);
            String response = inputCommand.runCommand();
            out.format(response);
            
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
