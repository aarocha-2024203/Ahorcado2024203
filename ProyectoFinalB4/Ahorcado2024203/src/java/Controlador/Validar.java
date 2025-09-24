package Controlador;

import modelo.Usuarios;
import modelo.UsuariosDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/Validar")
public class Validar extends HttpServlet {

    UsuariosDAO usuariosDAO = new UsuariosDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String accion = request.getParameter("accion");

        if ("Ingresar".equalsIgnoreCase(accion)) {
            String correo = request.getParameter("txtCorreo");
            String pass = request.getParameter("txtPassword");

            Usuarios usuarios = usuariosDAO.validar(correo, pass);

            if (usuarios != null && usuarios.getCodigoUsuario() > 0) {
                HttpSession session = request.getSession();
                session.setAttribute("usuario", usuarios);
                response.sendRedirect("Controlador?menu=Ahorcado");
            } else {
                request.setAttribute("error", "Correo o contraseña incorrectos");
                request.getRequestDispatcher("index.jsp").forward(request, response);
            }
        } else if ("Registro".equalsIgnoreCase(accion)) {
            String correoRegistro = request.getParameter("txtCorreoR");
            String contraseñaRegistro = request.getParameter("txtPasswordR");
            String confirmarContraseña = request.getParameter("confirmar");

            if (contraseñaRegistro.equals(confirmarContraseña)) {
                Usuarios nuevoUsuario = new Usuarios();
                nuevoUsuario.setCorreoUsuario(correoRegistro);
                nuevoUsuario.setContraseñaUsuario(contraseñaRegistro);

                int resultado = usuariosDAO.registrarLogin(nuevoUsuario);

                if (resultado > 0) {
                    response.sendRedirect("index.jsp?registro=success");
                } else {
                    request.setAttribute("errorRegistro", "El usuario ya existe o hubo un error al registrarse.");
                    request.getRequestDispatcher("index.jsp").forward(request, response);
                }
            } else {
                request.setAttribute("errorRegistro", "Las contraseñas no coinciden.");
                request.getRequestDispatcher("index.jsp").forward(request, response);
            }
        } else {
            response.sendRedirect("index.jsp");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("index.jsp");
    }
}