<%-- 
    Document   : doVendi
    Created on : 4-dic-2010, 23.31.43
    Author     : Fabio
--%>
<jsp:useBean id="offerta" class="it.polito.elite.paw10.minibay.asta.offerta.OffertaData" scope="request" />
<jsp:useBean id="astaDB" class="it.polito.elite.paw10.minibay.asta.AstaDB" scope="application" />
<jsp:useBean id="errs" class="it.polito.elite.paw10.minibay.ErrorMsg" scope="request" />
<jsp:useBean id="utente" class="it.polito.elite.paw10.minibay.Utente" scope="session" />

<% 
//messaggio di errore
String messaggioErrore="";
boolean modificata=false;
String messaggioInfo="";

String azione=request.getParameter("azione_offerta");
 if(azione==null){
    azione="nuova";
 }
 if(azione.equals("nuova")){
    if(!utente.isLogged()){
        messaggioErrore="Utente non loggato, impossibile creare un'offerta ";

    } else{%>
    <jsp:setProperty name="offerta" property="*"  />
       <% 
       
       //CONTROLLO SE OFFERTA é CORRETTA
       
                astaDB.inserisciOfferta(offerta);
                modificata=true;
                messaggioInfo="Creata nuova offerta";
    }
 } else if(azione.equals("annulla")){
     //idasta da visualizzare
     String idAsta=request.getParameter("idasta");
     String idUtenteOfferente=request.getParameter("idutenteofferente");
     if( idAsta!=null && idUtenteOfferente!=null ){
       
        if(idUtenteOfferente.equals(""+utente.getIdutente())){
           offerta=astaDB.getOffertaAsta(utente.getIdutente(), idAsta);
            astaDB.annullaOfferta(offerta);
          modificata=true;
          messaggioInfo="L'offerta è stata cancellata";
        } else {
        messaggioErrore="Utente "+utente.getUsername()+" non ha i diritti di modificare l'asta";
        }
     } else {
        messaggioErrore="Mancano parametri";
     }
 }

if(messaggioErrore.isEmpty() && !modificata){
%>
        <jsp:forward page="masterView.jsp">
        <jsp:param name="corpo" value="offerta.jsp" />
        </jsp:forward>
        <%

} else if(modificata) { //inserimento o modifica corretta %>
    <jsp:forward page="masterView.jsp">
        <jsp:param name="corpo" value="loggedHome.jsp" />
        <jsp:param name="messaggio" value="<%=messaggioInfo%>" />
        </jsp:forward>

<%}

else {
%>
   <jsp:forward page="masterView.jsp">
        <jsp:param name="corpo" value="errore.jsp" />
         <jsp:param name="errore" value="<%=messaggioErrore%>" />
    </jsp:forward>
 <%}


 
%>


