<%@page import="it.polito.elite.paw10.minibay.asta.Domanda"%>
<%@page import="it.polito.elite.paw10.minibay.asta.AstaData"%>
<%@page import="java.util.ArrayList"%>
<jsp:useBean id="utente" class="it.polito.elite.paw10.minibay.Utente" scope="session" />
<jsp:useBean id="astaDB" class="it.polito.elite.paw10.minibay.asta.AstaDB" scope="request" />
<% if(!utente.isLogged()){
            %>
            <jsp:include page="errore.jsp">
                <jsp:param name="errore" value="Utente non ha effettuato il login" />

            </jsp:include>
            <%
       } else{
%>
<h1>Benvenuto, ${utente.nome} ${utente.cognome}</h1>

<span class="descrizione"> ${param.messaggio}</span>
<h1>Le tue aste</h1>
<p>Elenco aste da me aperte....</p>
<% ArrayList<AstaData> elencoAste=astaDB.getAsteUtente(utente);
    if(elencoAste.size()>0){
        request.setAttribute("elencoaste", elencoAste);
%>
<jsp:include page="../include/tabellaAste.jsp" >
    <jsp:param name="azione_tabella" value="modifica" />
</jsp:include>

<%    }
       }

%>
<span><a href="masterView.jsp?corpo=vendi.jsp">Gestione vendite</a></span>
<br>
<% ArrayList<AstaData> elencoAste=astaDB.getOfferteAsteUtente(utente);
    if(elencoAste.size()>0)
    {
        request.setAttribute("elencoaste", elencoAste);
%>
<h1>Le tue offerte</h1>
<p>Elenco aste su cui ho fatto offerte....</p>

    <jsp:include page="../include/tabellaAste.jsp"/>
<%}%>

<h1>Ultime novità</h1>
<%
    //Restituisco aste ma gestisco la selezione direttamente dalla query sql tramite due metodi di restituzione
    ArrayList<AstaData> elencoRisposteRicevute=astaDB.getUltimeDomande(5, utente.getIdutente());
    if(elencoRisposteRicevute.size()>0)
    {
        request.setAttribute("elencoaste", elencoRisposteRicevute);
%> 


<p>Elenco ultime <u><i>risposte</i></u> ricevute. </p>

    <jsp:include page="../include/tabellaAste.jsp"/>
<%}
    else
               {%>
               <p>Non hai ricevuto alcuna <u><i>risposta</i></u></p>
               
               <%}%>

<% 
    ArrayList<AstaData> elencoDomandeRicevute=astaDB.getUltimeDomandeRicevute(10, utente.getIdutente());
    if(elencoDomandeRicevute.size()>0)
    {
        request.setAttribute("elencoaste", elencoDomandeRicevute);
%> 

<p>Elenco ultime <u><i>domande</i></u> ricevute.</p>

    <jsp:include page="../include/tabellaAste.jsp"/>
<%}
    else
               {%>
               <p>Non hai ricevuto alcuna <u><i>domanda</i></u></p>
               
               <%}%>