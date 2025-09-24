package Controlador;

import modelo.Palabras;
import modelo.PalabrasDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "Controlador", urlPatterns = {"/Controlador"})
public class Controlador extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String menu = request.getParameter("menu");

        if (menu == null) {
            response.sendRedirect("index.jsp");
            return;
        }

        if (menu.equals("Ahorcado")) {
            request.getRequestDispatcher("/Index/Ahorcado.jsp").forward(request, response);
        } else if (menu.equals("PalabrasJuego")) {
            PalabrasDAO dao = new PalabrasDAO();
            List<Palabras> lista = dao.listarParaJuego();

            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");

            try (PrintWriter out = response.getWriter()) {
                if (lista == null || lista.isEmpty()) {
                    out.print("[]"); // Enviar un arreglo JSON vacío si no hay palabras
                } else {
                    StringBuilder sb = new StringBuilder();
                    sb.append("[");
                    for (int i = 0; i < lista.size(); i++) {
                        Palabras p = lista.get(i);
                        // Asegurarse de que los valores no sean nulos antes de usar
                        String palabra = (p.getPalabra() != null) ? p.getPalabra() : "";
                        String pista = (p.getPista() != null) ? p.getPista() : "";
                        
                        sb.append("{\"palabra\":\"").append(palabra)
                                .append("\",\"pista\":\"").append(pista).append("\"}");
                        if (i < lista.size() - 1) {
                            sb.append(",");
                        }
                    }
                    sb.append("]");
                    out.print(sb.toString());
                }
            }
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Controlador para el Ahorcado";
    }
}