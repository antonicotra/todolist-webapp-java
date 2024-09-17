package com.todolist.webapp.todolistwebapp;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "modifyServlet", value = "/modifytask")

public class ModifyServlet extends HttpServlet {


    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {

        if(request.getParameter("idtask").isEmpty()) {
            request.setAttribute("error", "Seleziona una task prima di poter eseguire l'azione!");
            request.getRequestDispatcher("/").forward(request, response);
            return;
        }

        if(request.getParameter("description").isEmpty() || request.getParameter("date").isEmpty()) {
            request.setAttribute("error", "Non hai fornito tutti i campi oppure hai inserito una data con formato non valido!");
            request.getRequestDispatcher("/").forward(request, response);
            return;
        }

        int idtask = Integer.parseInt(request.getParameter("idtask"));
        String description = request.getParameter("description");
        String date = request.getParameter("date");
        System.out.println(description);
        System.out.println(date);

        List.modifyDescription(idtask, description);
        List.modifyExpireDate(idtask, date);

        response.sendRedirect("/");
    }

}
