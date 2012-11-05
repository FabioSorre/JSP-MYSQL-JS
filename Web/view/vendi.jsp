<%@page import="it.polito.elite.paw10.minibay.asta.AstaData"%>
<%@page import="java.util.ArrayList"%>
<%@page import="it.polito.elite.paw10.minibay.asta.categoria.Categoria"%>
<h1>Gestione vendite</h1>

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

<% ArrayList<AstaData> elencoAste=astaDB.getAstaVenditoreStato(utente.getIdutente(), "caricata");
    if(elencoAste.size()>0){
        request.setAttribute("elencoaste", elencoAste);
%><p>Elenco aste caricate</p>
<jsp:include page="../include/tabellaAste.jsp">
    <jsp:param name="azione_tabella" value="modifica"/>
</jsp:include>

<%    } %>


<%  elencoAste=astaDB.getAstaVenditoreStato(utente.getIdutente(), "attiva");
    if(elencoAste.size()>0){
        request.setAttribute("elencoaste", elencoAste);
%>
<p>Elenco aste attive</p>
<jsp:include page="../include/tabellaAste.jsp">
    <jsp:param name="azione_tabella" value="modifica"/>
</jsp:include>

<%    } %>


<%  elencoAste=astaDB.getAstaVenditoreStato(utente.getIdutente(), "aggiudicata");
    if(elencoAste.size()>0){
        request.setAttribute("elencoaste", elencoAste);
%>
<p>Elenco aste aggiudicate in attesa di pagamento</p>
<jsp:include page="../include/tabellaAste.jsp">
    <jsp:param name="azione_tabella" value="modifica"/>
</jsp:include>

<%    } %>

<%  elencoAste=astaDB.getAstaVenditoreStato(utente.getIdutente(), "pagata");
    if(elencoAste.size()>0)
    {
        request.setAttribute("elencoaste", elencoAste);
%>
<h2>Elenco aste pagate in attesa di invio</h2>

<jsp:include page="../include/tabellaAste.jsp">
    <jsp:param name="azione_tabella" value="modifica"/>
</jsp:include>

<%   } %>


<%  elencoAste=astaDB.getAstaVenditoreStato(utente.getIdutente(), "completata");
    if(elencoAste.size()>0){
    {
                  request.setAttribute("elencoaste", elencoAste);
          
    
%>
<h2>Elenco aste concluse</h2>
<jsp:include page="../include/tabellaAste.jsp">
    <jsp:param name="azione_tabella" value="modifica"/>
</jsp:include>

<%   }  
    
} %>

 <!-- non implementato-->
 <div>
 

<form action="doAsta.jsp">
    <table><tr><td><h2>|&nbsp; Nuova Asta </h2></td><td>&nbsp;&nbsp;&nbsp;
    <input type="hidden" name="corpo" value="asta.jsp" />
    <input type="hidden" name="azione_asta" value="nuova" />
    <input type="submit" value="Clicca qui!" /></td><td><h2> &nbsp;&nbsp;|</h2></td></tr>
    </table>
</form>
 </div>
<%}%>