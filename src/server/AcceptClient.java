package server;

import java.io.DataOutputStream;
import java.io.IOException;
import java.net.Socket;
import java.util.Scanner;

public class AcceptClient implements Runnable {
    Socket socket;
    
    public AcceptClient(Socket socket) {
        this.socket = socket;
    }
    
    @Override
    public void run() {
        try (Scanner in = new Scanner(socket.getInputStream(), "UTF-8");
             DataOutputStream outputStream = new DataOutputStream(socket.getOutputStream())) {
            
            String input = in.nextLine();
            Command inputCommand = Command.parseCommand(input);
            byte[] response = inputCommand.runCommand();
            outputStream.write(response);
            outputStream.flush();
            Thread.sleep(5000);
            
        } catch (IOException | InterruptedException e) {
            e.printStackTrace();
        }
    }
}
