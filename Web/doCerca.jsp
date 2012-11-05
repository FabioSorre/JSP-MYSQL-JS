<%-- TODO: rifare secondo la nuova architettura, e poi eliminare! --%>

<%@page import="it.polito.elite.paw10.minibay.asta.AstaData"%>
<%@page import="it.polito.elite.paw10.minibay.asta.categoria.Categoria"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%-- 
    Document   : doVendi
    Created on : 4-dic-2010, 23.31.43
    Author     : Fabio
--%>
<jsp:useBean id="ricercaData" class="it.polito.elite.paw10.minibay.RicercaData" scope="request" />
<jsp:useBean id="astaDB" class="it.polito.elite.paw10.minibay.asta.AstaDB" scope="request" />
<%
        //a secondo del tipo di ricerca, aggiungo attributi all'oggetto request
     String azione=request.getParameter("azione_cerca");
    if(azione==null){
        azione="default";
    }

    if(azione.equals("ultimecategorie")){
        HashMap<Categoria,ArrayList<AstaData>> elencoCategorie=astaDB.getUltimeAsteAttivePerCategoria(10);
        request.setAttribute("elencocategorie", elencoCategorie);
     }
     if(azione.equals("personalizzata")){%>
     <jsp:setProperty name="ricercaData" property="*" />
    <%
        ArrayList<AstaData> elencoCategorie=astaDB.ricercaAste(ricercaData);
        request.setAttribute("elencoaste", elencoCategorie);
     }



%>
<jsp:forward page="masterView.jsp">
<jsp:param name="corpo" value="cerca.jsp" />
</jsp:forward>



