<%@page import="it.polito.elite.paw10.minibay.asta.AstaData"%>
<%@page import="java.util.ArrayList"%>
<%@page import="it.polito.elite.paw10.minibay.asta.categoria.Categoria"%>
<h1>Offerte effettuate</h1>

<jsp:useBean id="utente" class="it.polito.elite.paw10.minibay.Utente" scope="session" />
<jsp:useBean id="errs" class="it.polito.elite.paw10.minibay.ErrorMsg" scope="request" />
<jsp:useBean id="astaDB" class="it.polito.elite.paw10.minibay.asta.AstaDB" scope="request" />

<% if(!utente.isLogged()){
            %>
            <jsp:include page="errore.jsp">
                <jsp:param name="errore" value="Utente non ha effettuato il login" />         
            </jsp:include>
            <%
       } else{
%>

<span class="descrizione"> ${param.messaggio}</span>

<%

    ArrayList<AstaData> elencoAste=astaDB.getOfferteAsteUtente(utente);
    if(elencoAste.size()>0){
        %><h2>Le  aste a cui hai effettuato un'offerta</h2><%
        request.setAttribute("elencoaste", elencoAste);
%>
<jsp:include page="../include/tabellaAste.jsp"/>
<%}
    else
        {
            %><h4>Non sono presenti aste a cui hai fatto un'offerta</h4>
            <br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><%
            }
    %>

      
       <% elencoAste=astaDB.getAstaCompratoreStato(utente.getIdutente(), "aggiudicata");
    if(elencoAste.size()>0){
        %><h2>Le  aste aggiudicate, ancora da pagare</h2><%
        request.setAttribute("elencoaste", elencoAste);
%>
    <jsp:include page="../include/tabellaAste.jsp"/>
<%} %>
     
       <% elencoAste=astaDB.getAstaCompratoreStato(utente.getIdutente(), "pagata");
    if(elencoAste.size()>0){
        %><h2>Le  aste aggiudicate, in attesa di essere spedite</h2><%
        request.setAttribute("elencoaste", elencoAste);
%>
    <jsp:include page="../include/tabellaAste.jsp"/>
<%} %>
     
       <% elencoAste=astaDB.getAstaCompratoreStato(utente.getIdutente(), "spedita");
    if(elencoAste.size()>0){
        %><h2>Le  aste aggiudicate, in arrivo....</h2><%
        request.setAttribute("elencoaste", elencoAste);
%>
    <jsp:include page="../include/tabellaAste.jsp"/>
<%} %>
    
       <% elencoAste=astaDB.getAstaCompratoreStato(utente.getIdutente(), "completata");
    if(elencoAste.size()>0){
        %><h2>Le  aste completate</h2><%
        request.setAttribute("elencoaste", elencoAste);
%>
    <jsp:include page="../include/tabellaAste.jsp"/>
<%} %>
      <% }%>