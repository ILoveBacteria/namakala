package server;

import database.Database;

import java.io.IOException;
import java.net.ServerSocket;
import java.net.Socket;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

public class Server {
    public static void main(String[] args) {
        try {
            Database.createDirectory();
        } catch (IOException e) {
            e.printStackTrace();
            System.exit(1);
        }
        ExecutorService executorService = Executors.newFixedThreadPool(4);
    
        try (ServerSocket serverSocket = new ServerSocket(5000)) {
            while (true) {
                Socket socket = serverSocket.accept();
                executorService.execute(new AcceptClient(socket));
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
