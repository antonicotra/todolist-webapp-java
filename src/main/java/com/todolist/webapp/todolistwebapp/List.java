package com.todolist.webapp.todolistwebapp;
import java.sql.SQLException;
import java.util.ArrayList;

public class List {

    private ArrayList<Task> lista = new ArrayList<>();

    public List(Connector database) throws SQLException {
        this.lista = Connector.showQuery(database);
    }

    public static void add (String description, String dateString) throws SQLException, IllegalArgumentException {
            Task task = new Task(description, dateString);
            String query = "INSERT INTO task (description, expiredate) VALUES (" + "'" + task.getDescription() + "'" + ", " + "'" + task.getOriginalDate() + "'" +");";
            Connector.createQuery(query);
    }

    public static void remove (int index) {
        String query = "DELETE FROM task WHERE id = " + index;
        try {
            Connector.removeQuery(query);
        }
        catch(Exception e) {
            System.out.println(e);
        }
    }

    public static void modifyDescription (int index, String description) {
        String query = "UPDATE task SET description = " + "'" + description + "'" + " WHERE id = " + index;
        try {
            Connector.updateQuery(query);
        }
        catch(Exception e) {
            System.out.println(e);
        }
    }

    public static void modifyExpireDate (int index, String dateString) {
        Task task = new Task();
        task.setDate(dateString);
        String query = "UPDATE task SET expiredate = " + "'" + task.getOriginalDate() + "'" + " WHERE id = " + index;
        try {
            Connector.updateQuery(query);
        }
        catch(Exception e) {
            System.out.println(e);
        }
    }

    public static void modifyChecked (int index) {
        String query = "UPDATE task SET checked = NOT checked WHERE id = " + index;
        try {
            Connector.updateQuery(query);
        }
        catch(Exception e) {
            System.out.println(e);
        }
    }

    public ArrayList<Task> getLista() {
        return lista;
    }
}
    

