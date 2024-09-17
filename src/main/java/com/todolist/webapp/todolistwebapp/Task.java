package com.todolist.webapp.todolistwebapp;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

public class Task {
    private String description;
    private LocalDate expireDate;
    private boolean checked;
    private int id;
    private final DateTimeFormatter dateFormat = DateTimeFormatter.ofPattern("dd/MM/yyyy");
    private final DateTimeFormatter dateFormatDatabase = DateTimeFormatter.ofPattern("yyyy-MM-dd");


    /* COSTRUTTORE CHE MI PERMETTE DI MODIFICARE LA DATA */
    public Task() {
        expireDate = LocalDate.now();
    }

    /* IL COSTRUTTORE CHE PERMETTE DI CREARE UNA NUOVA TASK */
    public Task(String description, String dateString) throws SQLException {
        setid();
        setDescription(description);
        setDate(dateString);
        setChecked();
    }

    /* IL COSTRUTTORE CHE PERMETTE DI VISUALIZZARE TUTTE LE TASK */
    public Task(int id, String description, String dateString, boolean checked) {
        this.id = id;
        this.description = description;
        this.expireDate = LocalDate.parse(dateString, dateFormatDatabase);
        this.checked = checked;
    }


    public void setDescription(String description) {
        if(description.isEmpty()) {
            throw new IllegalArgumentException("Description cannot be empty");
        }
        this.description = description;
    }

    public String getDescription() {
        return description;
    }

    public void setDate(String date) {
        if(!date.matches("^(19|20)\\d{2}-(0[1-9]|1[0-2])-(0[1-9]|[12][0-9]|3[01])$") || date.isEmpty()) {
           throw new IllegalArgumentException("Invalid date format or empty field");
        }
        this.expireDate = LocalDate.parse(date, dateFormatDatabase);
    }

    public String getDate() {
        return expireDate.format(dateFormat);
    }

    public String getOriginalDate() {
        return expireDate.format(dateFormatDatabase);
    }

    public void setChecked(boolean checked) {
        this.checked = checked;
    }

    public void setChecked() {
        this.checked = false;
    }

    public boolean getChecked() {

        return checked;
    }

    public void setid() throws SQLException {
        this.id = Connector.getLastIndex();
    }

    public int getid() {
        return id;
    }
}