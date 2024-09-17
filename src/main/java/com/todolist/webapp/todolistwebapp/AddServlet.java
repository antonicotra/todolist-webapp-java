package com.todolist.webapp.todolistwebapp;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet(name = "addServlet", value = "/add")
public class AddServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {

        String description = request.getParameter("description");
        String date = request.getParameter("date");

        try {
            List.add(description, date);
            response.sendRedirect("/");
        } catch (SQLException e) {
            request.setAttribute("errordb", "Si è verificato un errore nel database!");
            request.getRequestDispatcher("/").forward(request, response);
        } catch(Exception e) {
            request.setAttribute("error", "Non hai fornito tutti i campi oppure hai inserito una data con formato non valido!");
            request.getRequestDispatcher("/").forward(request, response);
        }
    }
}
