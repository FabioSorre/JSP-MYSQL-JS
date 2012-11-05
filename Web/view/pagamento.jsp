<%@page import="java.util.ArrayList"%>
<%@page import="it.polito.elite.paw10.minibay.asta.categoria.Categoria"%>
<h1>Gestione vendite</h1>

<jsp:useBean id="utente" class="it.polito.elite.paw10.minibay.Utente" scope="session" />
<jsp:useBean id="errs" class="it.polito.elite.paw10.minibay.ErrorMsg" scope="request" />
<jsp:useBean id="astaDB" class="it.polito.elite.paw10.minibay.asta.AstaDB" scope="request" />
<jsp:useBean id="asta" class="it.polito.elite.paw10.minibay.asta.AstaData" scope="request" />
<% if(!utente.isLogged()){
            %>
            <jsp:include page="errore.jsp">
                <jsp:param name="errore" value="Utente non ha effettuato il login" />         
            </jsp:include>
            <%
       } else{
%>
<div id="pagamento">
    <p>${param.valore} &euro;  per ${asta.titolo}</p>
     <img src="images/visa_big.jpg" id="vi_alogo" alt="logo carta di credito" />
     <p> <a href="doPagamento.jsp?azione_pagamento=conferma&idasta=${param.idasta}"> Procedi con il pagamento</a> </p>
</div>

<%}%>