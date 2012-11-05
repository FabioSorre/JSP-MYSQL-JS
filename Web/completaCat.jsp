<%-- 
    Document   : cercasuggerimenti
    Created on : 1-gen-2002, 22.02.43
    Author     : Fabio
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%><%--
--%><jsp:useBean id="cat" class="it.polito.elite.paw10.minibay.CompletaCatBean" scope="page" /><%--
--%><%
            String testo = request.getParameter("testo");
            cat.resetNomi();
            if (cat.caricaCategorie(testo)) 
            {
                if(!(cat.getNomi()).isEmpty())
                {
                     for( String s: cat.getNomi() )
                    {
                        out.println("<li>"+s+"</li>");
                    }
                }
            }
            
            


%>