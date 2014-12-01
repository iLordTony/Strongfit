<%@page import="java.util.HashMap"%>
<%@page import="java.util.*" %>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page session="true" %>
<!DOCTYPE html>
<html>
    <%
        /*esto es temporal debido a que las variables de sesion como usrid y usrname se deben obtener en el momento del login*/
        HttpSession sesion = request.getSession();
        sesion.setAttribute("idUsr", 1);
    %>
    <head>
        <%@include file = "meta.jsp" %>
        <link rel="stylesheet" type="text/css" href="../Estilos/estilo_dietasusr.css">
        <script src = "../js/acciones_dietasPaciente.js"></script>
    </head>
    <body>
        <%
            int usrid = 1; //Provisional
            //Esto es provisional, despues se construira el metodo para extraer las dietas de la base de datos
        %>        
        <%@include file = "barra_menu.jsp" %>
        
        <section class = "Section-dietas">
            <article class = "Article-dietas"  id = "Article-dietas" ondrop="dropDiv(event)" ondragover="allowDrop(event)" >
                <h2>Dietas sugeridas</h2>
                <hr>
                <%
                    conecta.conectar();
                %>
                <form id = "quitarForm">
                    <input type = "hidden" id = "inputQuitar2" name = "quitar" value = "">
                </form>
                <div id = "divDietasPaciente" >
                    <%
                        //llenando el campo de las dietas sugeridas
                        ResultSet rs = conecta.getDietasSugeridas();
                        ResultSet rs2 = conecta.getDietasRegistradas(usrid);
                        ArrayList <Integer> lista = new ArrayList();
                        String nombreD;
                        int idD, contador = 0, contador2 = 0, contador3 = 0, contadorid = 0;
                        
                        while(rs2.next())
                        {
                            contador2 = 1;
                            lista.add(rs2.getInt("idDieta"));
                        }   
                        
                        while(rs.next())
                        {
                            for(int i = 0; i < lista.size(); ++i)
                            {
                                contador3 = 1;
                                if(rs.getInt("idDieta") == lista.get(i))
                                {
                                    contador += 1;
                                }
                                    
                                if(contador == 0 && contador3 == 1)
                                {
                                    nombreD = rs.getString("nombre");
                                    idD = rs.getInt("idDieta");
                    %>
                    <figure class = "Figure-dietas" draggable="true" ondragstart="drag(event)" id = "<%="figure-usr" + contadorid%>">
                        <input type="hidden" name = "idDieta" value = "<%=idD%>" >
                        <figcaption><%=nombreD%></figcaption>
                        <img src = "../Imagenes/imagen-dietas.jpg" class = "img-dietas" draggable="false">
                    </figure>
                    <%
                                    contadorid += 1;
                                }
                            }
                        }
                        
                        if(contador2 == 0)
                        {
                            ResultSet rs4 = conecta.getDietasSugeridas();
                            while(rs4.next())
                            {
                                nombreD = rs4.getString("nombre");
                                idD = rs4.getInt("idDieta");
                                %>
                    <figure class = "Figure-dietas" draggable="true" ondragstart="drag(event)" id = "<%="figure-usr" + contadorid%>">
                        <input type="hidden" name = "idDieta" value = "<%=idD%>" >
                        <figcaption><%=nombreD%></figcaption>
                        <img src = "../Imagenes/imagen-dietas.jpg" class = "img-dietas" draggable="false">
                    </figure>
                                <%
                                contadorid += 1;
                            }
                        }
                    %>
                </div>
            </article>
            <article class = "Article-usr" ondrop="drop(event)" ondragover="allowDrop(event)" id = "Article-user">
                <h2>Tus dietas</h2>
                <hr>
                <div id = "divForm">
                    <%
                        ResultSet rs3 = conecta.getDietasRegistradas(usrid);
                        while(rs3.next())
                        {                            
                            idD = rs3.getInt("idDieta");
                            nombreD = rs3.getString("nombre");
                    %>
                    <figure class = "Figure-dietas" draggable="true" ondragstart="drag(event)" id = "<%="figure-usr" + contadorid%>">
                        <input type="hidden" name = "idDieta" value = "<%=idD%>" >
                        <figcaption><%=nombreD%></figcaption>
                        <img src = "../Imagenes/imagen-dietas.jpg" class = "img-dietas" draggable="false">
                    </figure>
                    <%
                        contadorid += 1;
                        }  
                    %>
                </div>
                <form id = "formularioDietasPaciente">
                    <input type = "hidden" id = "inputQuitar" name = "quitar" value = "">
                </form>
            </article>
        </section>
        
    </body>
</html>
