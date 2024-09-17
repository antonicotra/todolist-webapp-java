package com.todolist.webapp.todolistwebapp;
import java.io.*;
import java.sql.SQLException;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

@WebServlet(name = "mainServlet", value = "/")
public class MainServlet extends HttpServlet {

    List lista;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String error = (String) request.getAttribute("error");
        if (error != null) {
            request.setAttribute("error", error);
        }
        System.out.println(error);
        doGet(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            Connector database = new Connector();
            lista = new List(database);
            request.setAttribute("lista", lista.getLista());
            RequestDispatcher dispatcher = request.getRequestDispatcher("/main.jsp");
            dispatcher.forward(request, response);
        }
        catch (ServletException | SQLException e) {
            System.out.println(e.getMessage());
        }
    }
}