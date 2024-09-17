package com.todolist.webapp.todolistwebapp;

import java.sql.*;
import java.util.ArrayList;

public class Connector {

    Connection connection = null;
    static Statement statement = null;

    public Connector() {
        String url = "jdbc:mysql://localhost/todolistdatabase";
        String username = "root";
        String password = "";
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection(url, username, password);
            statement = connection.createStatement();
        }
        catch(Exception e) {
            System.out.println(e);
        }
    }

    public static void createQuery(String query) throws SQLException {
        statement.executeUpdate(query);
    }

    public static ArrayList<Task> showQuery(Connector database) throws SQLException {
        ResultSet resultset = statement.executeQuery("SELECT * FROM task ORDER BY expiredate ASC");
        ArrayList<Task> lista = new ArrayList<>();
        while(resultset.next()) {
            int id = resultset.getInt("id");
            String description = resultset.getString("description");
            String expiredate = resultset.getString("expiredate");
            boolean checked = resultset.getBoolean("checked");
            lista.add(new Task(id,description,expiredate,checked));
        }
        return lista;
    }

    public static void removeQuery (String query) throws SQLException {
        statement.executeUpdate(query);
    }

    public static void updateQuery (String query) throws SQLException {
        statement.executeUpdate(query);
    }

    public static int getLastIndex() throws SQLException {
        int numero = 0;
        ResultSet result =  statement.executeQuery("SELECT LAST_INSERT_ID()");
        if (result.next()){
            numero = result.getInt(1) + 1;
        }
        result.close();
        return numero;
    }

}
