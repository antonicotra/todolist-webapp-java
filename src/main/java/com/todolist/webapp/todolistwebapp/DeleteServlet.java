package com.todolist.webapp.todolistwebapp;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "deleteServlet", value = "/delete")
public class DeleteServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if(request.getParameter("idtask").isEmpty()) {
            request.setAttribute("error", "Seleziona una task prima di poter eseguire l'azione!");
            request.getRequestDispatcher("/").forward(request, response);
            return;
        }
        int idtask = Integer.parseInt(request.getParameter("idtask"));
        List.remove(idtask);
        response.sendRedirect("/");


    }
}
