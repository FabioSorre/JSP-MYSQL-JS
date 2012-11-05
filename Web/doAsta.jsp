<%-- TODO: rifare secondo la nuova architettura, e poi eliminare! --%>

<%@page import="it.polito.elite.paw10.minibay.asta.AstaData.stato_asta"%>
<%@page import="it.polito.elite.paw10.minibay.asta.offerta.OffertaData"%>
<%-- 
    Document   : doVendi
    Created on : 4-dic-2010, 23.31.43
    Author     : Fabio
--%>
<%@page import="it.polito.elite.paw10.minibay.asta.categoria.Categoria"%>
<jsp:useBean id="asta" class="it.polito.elite.paw10.minibay.asta.AstaData" scope="request" />
<jsp:useBean id="astaDB" class="it.polito.elite.paw10.minibay.asta.AstaDB" scope="request" />
<jsp:useBean id="errs" class="it.polito.elite.paw10.minibay.ErrorMsg" scope="request" />
<jsp:useBean id="utente" class="it.polito.elite.paw10.minibay.Utente" scope="session" />
<jsp:useBean id="categorie" class="it.polito.elite.paw10.minibay.asta.categoria.CategoriaBean" scope="request" />

<% 
//messaggio di errore
String messaggioErrore="";
boolean modificata=false;
String messaggioInfo="";
String azione=request.getParameter("azione_asta");
 if(azione==null){
    azione="nuova";
 }
 ///Richiesta creazione di una nuova asta
 if(azione.equals("nuova") && !utente.isLogged()){
    messaggioErrore=" Per creare una nuova asta, devi effettuare il login";
   //errore login mecessario 
 }else if(azione.equals("visualizza")){
     //idasta da visualizzare
     String domanda=request.getParameter("domanda");
     String idasta=request.getParameter("idasta");
     String risposta=request.getParameter("risposta");
     String idutenteofferente=request.getParameter("idutenteofferente");
     String idutenterisposta=request.getParameter("idutenterisposta");
     String idDomanda=request.getParameter("idDomanda");
     String valuta=request.getParameter("valu");
     String cancella=request.getParameter("cancella");
     
     //In base a che parametri ricevo da asta, gestisco le Query sql
       if(domanda!=null){
           astaDB.inserisciDomanda(utente.getIdutente(), Integer.parseInt(idasta), domanda);
       }
       else if(risposta!=null){
           astaDB.inserisciRisposta(Integer.parseInt(idutenterisposta), Integer.parseInt(idasta), risposta, Integer.parseInt(idDomanda));
       }
       else if(valuta!=null){
           astaDB.inserisciValutazione(Integer.parseInt(idutenterisposta), Integer.parseInt(idasta), Integer.parseInt(idDomanda), Integer.parseInt(valuta));
       }
       else if(cancella!=null){
           astaDB.cancellaDomanda(Integer.parseInt(idDomanda));
       } 
     
     
     
     if(idasta!=null){
        request.setAttribute("asta",astaDB.getAsta(idasta));
        OffertaData offerta=astaDB.getOffertaAsta(utente.getIdutente(), idasta);
        if(offerta!=null){
            request.setAttribute("offerta", offerta);
        }
     } else {
        messaggioErrore="Impossibile visualizzare l'asta. Asta non trovata";
     }
 }else if(azione.equals("inserisci")){
    if(!utente.isLogged()){
        messaggioErrore="Utente non loggato, proabilmente è scaduta la sessione";

    } else{%>
    
        <jsp:setProperty name="asta" property="*"  />
    
    
       <% 

            astaDB.inserisciAsta(utente, asta);

            modificata=true;
            messaggioInfo="Inserita l'asta: <b>"+asta.getTitolo()+"</b> l'asta è nello stato 'caricata', bisogna <I>ATTIVARLA</I> ";
       
        
    }


 } else if(azione.equals("inviaprodotto")){
     String idasta=request.getParameter("idasta");
     if(idasta!=null){
        modificata=true;
        astaDB.spedisciProdotto(idasta);
         asta=astaDB.getAsta(idasta);
        request.setAttribute("asta", asta);

     } else {
        messaggioErrore="Impossibile visualizzare l'asta: Asta non trovata";
     }
    }else if(azione.equals("completata")){
     String idasta=request.getParameter("idasta");
     if(idasta!=null){
        modificata=true;
        astaDB.completaAsta(idasta);
         asta=astaDB.getAsta(idasta);
        request.setAttribute("asta", asta);

     } else {
        messaggioErrore="Impossibile visualizzare l'asta: Asta non trovata";
     }
    }else if(azione.equals("aggiorna")){
    if(!utente.isLogged()){
        messaggioErrore="Utente non loggato, proabilmente è scaduta la sessione";

    } else{%>
    <jsp:setProperty name="asta" property="*"  />

       <% 
            astaDB.aggiornaAsta(asta);
           modificata=true;
           messaggioInfo="Aggiornata l'asta : <b>"+asta.getTitolo()+"</b>";
        
    }


 } else if(azione.equals("modifica")){
     //idasta da visualizzare
     String idasta=request.getParameter("idasta");
     if(idasta!=null){
        asta=astaDB.getAsta(idasta);
        if(asta.getIdutentevenditore()==utente.getIdutente()){
           request.setAttribute("asta", asta);
           if(asta.getStato()==stato_asta.aggiudicata ||asta.getStato()==stato_asta.pagata || asta.getStato()==stato_asta.completata){
                OffertaData offerta=astaDB.getOffertaAsta(asta.getIdutenteaggiudicatario(), idasta);
                request.setAttribute("offerta", offerta);
           }

        } else {
        messaggioErrore="Utente "+utente.getUsername()+" non ha i diritti di modificare l'asta";
        }
     } else {
        messaggioErrore="Impossibile visualizzare l'asta: Asta non trovata";
     }
 } else if(azione.equals("attiva")){
     //idasta da visualizzare
     String idasta=request.getParameter("idasta");
     if(idasta!=null){
        asta=astaDB.getAsta(idasta);
        if(asta.getIdutentevenditore()==utente.getIdutente()){
          astaDB.attivaAsta(asta.getIdasta());
          asta=astaDB.getAsta(idasta);
          request.setAttribute("asta", asta);
        } else {
        messaggioErrore="Utente "+utente.getUsername()+" non ha i diritti di modificare l'asta";
        }
     } else {
        messaggioErrore="Impossibile visualizzare l'asta: Asta non trovata";
     }
 }else if(azione.equals("annulla")){
     //idasta da visualizzare
     String idasta=request.getParameter("idasta");
     if(idasta!=null){
        asta=astaDB.getAsta(idasta);
        if(asta.getIdutentevenditore()==utente.getIdutente()){
          astaDB.annullaAsta(asta.getIdasta());
          astaDB.annullaOfferteAsta(asta.getIdasta());
          modificata=true;
          messaggioInfo="L'asta: "+asta.getTitolo()+" è stata cancellata";
        } else {
        messaggioErrore="Utente "+utente.getUsername()+" non ha i diritti di modificare l'asta";
        }
     } else {
        messaggioErrore="Impossibile visualizzare asta Asta non trovata.";
     }
 }

if(messaggioErrore.isEmpty() && !modificata){
%>
        <jsp:forward page="masterView.jsp">
        <jsp:param name="corpo" value="asta.jsp" />
        </jsp:forward>
        <%

} else if(modificata) { //inserimento o modifica corretta %>
    <jsp:forward page="masterView.jsp">
        <jsp:param name="corpo" value="vendi.jsp" />
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


