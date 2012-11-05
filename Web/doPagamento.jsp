<%-- 
    Document   : doVendi
    Created on : 4-dic-2010, 23.31.43
    Author     : Fabio
--%>
<%@page import="it.polito.elite.paw10.minibay.asta.AstaData"%>
<jsp:useBean id="offerta" class="it.polito.elite.paw10.minibay.asta.offerta.OffertaData" scope="request" />
<jsp:useBean id="astaDB" class="it.polito.elite.paw10.minibay.asta.AstaDB" scope="application" />
<jsp:useBean id="errs" class="it.polito.elite.paw10.minibay.ErrorMsg" scope="request" />
<jsp:useBean id="utente" class="it.polito.elite.paw10.minibay.Utente" scope="session" />

<% 
//messaggio di errore
String messaggioErrore="";
boolean modificata=false;
String messaggioInfo="";
String azione=request.getParameter("azione_pagamento");
 if(azione==null){
    azione="inviapagamento";
 }
 
    if(!utente.isLogged()){
        
        messaggioErrore="Utente non loggato, impossibile creare un'offerta ";
        %>
          <jsp:forward page="masterView.jsp">
        <jsp:param name="corpo" value="errore.jsp" />
         <jsp:param name="errore" value="<%=messaggioErrore%>" />
         </jsp:forward>
        <%
    } else if(azione.equals("inviapagamento")){
        String idAsta=request.getParameter("idasta");
        if(idAsta!=null){
            AstaData asta=astaDB.getAsta(idAsta);
            request.setAttribute("asta", asta);
         }
        %>
        <jsp:forward page="masterView.jsp">
        <jsp:param name="corpo" value="pagamento.jsp" />
        </jsp:forward>
        <%
    
    }else if(azione.equals("conferma")){
    String idAsta=request.getParameter("idasta");
        if(idAsta!=null){
            astaDB.pagaAsta(idAsta);
            %>
            <jsp:forward page="doAsta.jsp">
        <jsp:param name="azione_asta" value="visualizza" />
        </jsp:forward>
            <%}

    }

%>