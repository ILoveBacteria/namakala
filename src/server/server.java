package server;

import java.io.IOException;
import java.net.ServerSocket;
import java.net.Socket;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

public class server {
    public static void main(String[] args) {
        ExecutorService executorService = Executors.newFixedThreadPool(4);
        
        while (true) {
            try {
                ServerSocket serverSocket = new ServerSocket(5000);
                Socket socket = serverSocket.accept();
                executorService.execute(new AcceptClient(socket));
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }
}
