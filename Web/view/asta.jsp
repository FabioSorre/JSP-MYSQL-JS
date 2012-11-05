<%@page import="it.polito.elite.paw10.minibay.asta.Domanda"%>
<%@page import="org.omg.CosNaming.NamingContextPackage.NotEmpty"%>
<%@page import="it.polito.elite.paw10.minibay.asta.offerta.OffertaData"%>
<%@page import="it.polito.elite.paw10.minibay.asta.AstaData.stato_asta"%>
<%@page import="it.polito.elite.paw10.minibay.asta.categoria.Categoria"%>

<jsp:useBean id="asta" class="it.polito.elite.paw10.minibay.asta.AstaData" scope="request" />
<jsp:useBean id="astaDB" class="it.polito.elite.paw10.minibay.asta.AstaDB" scope="request" />
<jsp:useBean id="categorie" class="it.polito.elite.paw10.minibay.asta.categoria.CategoriaBean" scope="request" />
<jsp:useBean id="utente" class="it.polito.elite.paw10.minibay.Utente" scope="session" />
<jsp:useBean id="errs" class="it.polito.elite.paw10.minibay.ErrorMsg" scope="request" />
 <jsp:useBean id="offerta" class="it.polito.elite.paw10.minibay.asta.offerta.OffertaData" scope="request"/>
        
 
<script type="text/Javascript" src="js/jquery1.js"></script>
<script type="text/Javascript" src="js/jquery.validate1.js"></script>
<script type="text/Javascript" src="js/suggest.js"></script>

<script  type="text/javascript">
                     
     $(document).ready(function(){$("#dom").validate(); });
     $(document).ready(function(){$("#ris").validate(); });
     $(document).ready(function(){$("#ven").validate(); });
     $(document).ready(function(){$("#off").validate(); });
                 
</script>

<script type="text/javascript">

var i = 0;
var j = 0;
var a = false;
var b = false;

function visualizzaTArea(t) 
{
    if(i==0)
    {		
    	var tr = document.createElement('tr');
    	tr.setAttribute('id', 'tendina-' + t);
    	var td = document.createElement('td'); 
    	td.innerHTML = '<textarea cols="40" rows="4" name="risposta" class="required"></textarea>&nbsp;&nbsp;<input type="submit" value="Rispondi !"/><span onclick="rimuoviTArea(\'tendina-' + t + '\')" style="cursor:pointer;"><i>  (Nascondi)</i></span><input type="hidden" name="idDomanda" value="' + t + '" />';
    	tr.appendChild(td);
    	document.getElementById('tablemodifica' + t).appendChild(tr);
	i++; a=true;
    }
}

function visualizzaTAreaValuta(t) 
{
    if(j==0)
    {		
        
                        
    	var tr = document.createElement('tr');
    	tr.setAttribute('id', 'valuta-' + t);
    	var td = document.createElement('td'); 
    	td.innerHTML = '<input type="radio" name="valu" value="1" checked> 1 |<input type="radio" name="valu" value="2" > 2 |<input type="radio" name="valu" value="3"> 3 |<input type="radio" name="valu" value="4"> 4 |<input type="radio" name="valu" value="5" > 5 &nbsp;&nbsp;<input type="submit" value="Valuta la risposta!"/><span onclick="rimuoviTArea(\'valuta-' + t + '\')" style="cursor:pointer;"><i>  (Nascondi)</i></span><input type="hidden" name="idDomanda" value="' + t + '" />';
    	tr.appendChild(td);
    	document.getElementById('tablevaluta' + t).appendChild(tr);
	j++;
        b=true;
    }
}

function rimuoviTArea(tendina) 
{
    var obj = document.getElementById(tendina);
    obj.parentNode.removeChild(obj);
    if(a)
    {
        i=0;
        a=false;
    } 
    
    if(b)
    {
        j=0;
        b=false;
    } 
}

</script>


<h1>Vendita prodotto: ${asta.titolo}</h1>
<%
            if (!errs.isEmpty()) {
                //out.println("<h3 class='errormessage'>Errori nella compilazione</h3>") ;
                for (String msg : errs.getErrs()) {
                    //out.println("<p class='errormessage'>"+msg+"</p>") ;
                }
            }
%>



<%  //cosa devo fare con l'asta? Crearla, Modificarla o visualizzare solo le informazioni
   String azione=request.getParameter("azione_asta");
   //per comodità memorizzo lo stato dell'asta in una variabile locale
   stato_asta stato=asta.getStato();
   boolean caricamento=false;
   if(azione==null){
    azione="nuova";
   }
   if(!azione.equals("visualizza")){
        //controllo login
       if(!utente.isLogged()){
            %>
            <jsp:forward page="masterView.jsp">
                <jsp:param name="errore" value="Utente non ha effettuato il login" />
            </jsp:forward>
            <%
       } 

   }else{  //azione visualizza
       //se l'utente è loggato ed è l'aggiudicatario dell'asta
       if(utente.isLogged() &&utente.getIdutente()==asta.getIdutenteaggiudicatario()){
           //si distinguono due casi:
           //lo stato dell'asta è aggiudicato quindi si deve pagare
           if(stato==stato_asta.aggiudicata){
           %>
           <h2>Complimenti hai vinto l'asta offrendo ${offerta.valoreOfferta} &euro;</h2>
           <form action="doPagamento.jsp">
            <input type="hidden" name="idasta" value="<%=asta.getIdasta()%>" />
            <input type="hidden" name="azione_pagamento" value="inviapagamento" />
            <input type="hidden" name="valore" value="${offerta.valoreOfferta}" />
            <input type="submit" value="Paga" />
        </form>
           <%
           } else if (stato==stato_asta.pagata){%>
           <h2>Pagamento avvenuto con successo in attesa di spedizione.</h2>
           <%}else if(stato==stato_asta.spedita){
           %>
           <h2>Il prodotto è stato inviato</h2>
           <form action="doAsta.jsp">
            <input type="hidden" name="idasta" value="<%=asta.getIdasta()%>" />
            <input type="hidden" name="azione_asta" value="completata" />
            <input type="submit" value="Conferma ricezione" />
        </form>
           <%
           }

       }

    }
%>
<%
    // se l'utente richiede di modificare la pagina si deve verificare lo stato
    if(azione.equals("modifica")){
        if(stato!=stato_asta.completata && stato!=stato_asta.spedita && stato!=stato_asta.aggiudicata ){
        %>
        <form action="doAsta.jsp">
            <input type="hidden" name="idasta" value="<%=asta.getIdasta()%>" />
            <input type="hidden" name="azione_asta" value="annulla" />
            <input type="submit" value="Annulla Asta" />
        </form></br>
        <%
        }
        if(stato==stato_asta.caricata){
        %>
        <form action="doAsta.jsp">
            <input type="hidden" name="idasta" value="<%=asta.getIdasta()%>" />
            <input type="hidden" name="azione_asta" value="attiva" />
            <input type="submit" value="Attiva Asta" />
        </form>
        <%}else if(stato==stato_asta.aggiudicata){
            %>
            <h2>L'asta è stata aggiudicata a <%=offerta.getUtente().getUsername() %> per <%=offerta.getValoreOfferta() %>&euro;</h2>
            <h3>In attesa di pagamento</h3>
        <%
        }
        else if(stato==stato_asta.pagata){
            %>
              <h2>L'asta aggiudicata a <%=offerta.getUtente().getUsername() %> è stata pagata</h2>
              <h3>Puoi inviare la merce</h3>
        <form action="doAsta.jsp">
            <input type="hidden" name="idasta" value="<%=asta.getIdasta()%>" />
            <input type="hidden" name="azione_asta" value="inviaprodotto" />
            <input type="submit" value="inviaprodotto" />
        </form>
        <%
        }


    }

%>
<% //Se si l'azione non è di visualizzazione, creo il form
    if(!azione.equals("visualizza") && stato==stato_asta.caricata){    
        //Form Nuova Asta
  
%>

                 
                
<form action="doAsta.jsp" method="get" id="ven">
<% //Form vendita
    if(azione.equals("nuova")||azione.equals("inserisci")){
        %>
        <input type="hidden" name="azione_asta" value="inserisci" />
    <%
    } else if(azione.equals("modifica")||azione.equals("aggiorna")){
         %>
        <input type="hidden" name="azione_asta" value="aggiorna" />
        <input type="hidden" name="idasta" value="${asta.idasta}" />
    <%
    }
    } //Creazione o visuoalizzazione dettagli asta
%>
<div id="menu_ricerca">
<table>
    <tr><td>Titolo dell'asta (o "Nome del prodotto")&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td><td>
        <%
        if(!azione.equals("visualizza") && !azione.equals("inseriscidomanda") && stato==stato_asta.caricata){%>
        <input type="text" name="titolo" class="required" value="${asta.titolo}" />
        
        <% } else { %>
            ${asta.titolo}
        <%}%>
        </td></tr>


    <tr><td>Prezzo base d'asta (in &euro;)</td><td>
        <% if(!azione.equals("visualizza")&& !azione.equals("inseriscidomanda") && stato==stato_asta.caricata){%>
        <input type="text" name="prezzobase"  class="required number" value="${asta.prezzobase}" onClick="value=''" />
        
     <% } else {%>
        <td> ${asta.prezzobase}  &euro;
     <%}%></td></tr>
    
    
    
    <tr><td>Categoria prodotto </td><td>
         <% if(!azione.equals("visualizza")&& !azione.equals("inseriscidomanda") &&  stato==stato_asta.caricata){%>
        <select name="idcategoria">
            <%
                for(Categoria categoria:categorie.getElencoCategorie()){
                  %>
                  <option value="<%=categoria.getIdcategoria() %>"
                          <% if(categoria.getIdcategoria()==asta.getIdcategoria()) out.print("selected='selected'"); %>
                   >
                      <%=categoria.getNomecategoria() %>
                  </option>
                  <%
                }

            %>

        </select>
              <% } else { %>
              ${asta.nomecategoria}
        <%}%></td></tr>
         
    
    
    <tr><td>Data inizio asta &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;<% if(!azione.equals("visualizza")&& !azione.equals("inseriscidomanda") && stato==stato_asta.caricata){%>
        </td><td><input type="text" name="stamp_creazione" id="stamp_creazione" class="required date" value="${asta.stamp_creazione}"/></td>
    <% } else { %>
        <td>  ${asta.stamp_creazione} </td>
        <%}%>
 </tr>
    
    
    
    <tr><td>Data fine asta <% if(!azione.equals("visualizza")&& !azione.equals("inseriscidomanda") && stato==stato_asta.caricata){%>
        </td><td><input type="text" id="stamp_scadenza" name="stamp_scadenza"  class="required date" value="${asta.stamp_scadenza}"/> </td></tr>
     <% } else { %>
    <td> ${asta.stamp_scadenza} </td></tr>
        <%}%>
    
</table><table>
    <tr><td colspan="2" style="padding-top: 5px; padding-bottom: 0px">Descrizione asta completa</p><% if(!azione.equals("visualizza")&& !azione.equals("inseriscidomanda") && stato==stato_asta.caricata){%>
    <tr><td colspan="2"><textarea cols="80" rows="10" name="descrizione">${asta.descrizione}</textarea>
     <% caricamento=true; %>
        </td></tr>
    
    <tr><td><input type="submit" value="<% if(azione.equals("nuova") || azione.equals("inserisci")) out.print("Crea "); else out.print("Modifica "); %> asta" />
    <% }else { 
       
   %> <pre>
    ${asta.descrizione}
    <%}%></pre>
        </td></tr>
    <tr><td colspan="2"> Stato dell'asta: 
        
       <% if(caricamento) 
          { out.print("Caricamento in corso"); }
            else { %>
            
            ${asta.stato}
        <% }     
   %>
    
    </td></tr>
    </table>
   </div>
</form>
   
   <form id="ris" action="doAsta.jsp" method="get">
<%   //Form di risposta e valutazione
        //Variabili booleane per evitare di riscrivere righe di codice identiche.
        boolean entrato=false;
        boolean entrato1=false;

        //Non esiste un'alternativa else, essa corrisponderebbe a "non sono presenti domande".
        if(astaDB.getDomande(utente.getIdutente(), asta.getIdasta()).size()>0 && utente.isLogged())
        {   
            out.print("<br><hr><b><i>Domande e Risposte</i></b><br><ul type='disc'>");
            for(int i=0; i<astaDB.getDomande(utente.getIdutente(), asta.getIdasta()).size(); i++)
            {
               Domanda item= astaDB.getDomande(utente.getIdutente(), asta.getIdasta()).get(i);
               out.print("<li>");

               //Se l'utente cloggato coincide con l'utente della domanda evidenzia in grassetto, per una ricerca velocizzata
               if(utente.getIdutente()==item.getIdutentedomanda())
                    out.print("<b>"+item.getDomandaScritta()+"</b>");
               else
                    out.print(item.getDomandaScritta());
               
               //Cancella
               if(utente.getIdutente()==item.getIdutenterisposta())
                    out.print("&nbsp;&nbsp;<a href='doAsta.jsp?cancella=1&azione_asta=visualizza&idasta="+asta.getIdasta()+"&idDomanda="+item.getIdDomanda()+"'><font size='2'>Cancella</font></a>");    
                    
               out.print("</li><br><ul><li>" + item.getRispostaScritta() + "</li></ul><br>");

                  //Domanda - Crea submit con le funzioni Javascript con assegnato l'idDomanda
                  //Può valutare la domanda solo chi ha fatto la domanda!
                  //Ovviamente l'utente risposta coincide con l'utente asta
                  //Si fanno i controlli sulla valutazione memorizzata
                  if(utente.getIdutente()!=item.getIdutenterisposta() && utente.getIdutente()==item.getIdutentedomanda() && item.getValutazione()==0) 
                  {
                      //nel database inizializzo la risposta scritta in "nessuna risposta"
                      if(!item.getRispostaScritta().equals("Nessuna risposta"))
                      { 
                          entrato1=true; %>
                        
                        <table id="tablevaluta<%out.print(item.getIdDomanda());%>">
                            <tr><td><span onclick="visualizzaTAreaValuta(<%out.print(item.getIdDomanda());%>)" style="cursor:pointer;"><i><u>Valuta questa risposta</u> </i></span></td></tr>
                        </table><br></br>         
                        
                        <%    
                      }
                  }
                  else if(utente.getIdutente()!=item.getIdutenterisposta() && item.getValutazione()!=0)
                  {
                        out.print("<i>Valutazione risposta: </i>");

                        //Stampo le stelline
                        for(int k=0; k<item.getValutazione(); k++)
                        {
                            %><img id="stella" src="images/star.jpg" width="20" heigth="20" alt="Stellina Valutazione"/>&nbsp;<%
                        }
                        out.print("<br><br>   ");
                  }
                  
                  //Risposte - Crea sumbit con assegnato l'idDomanda
                  //Se l'utente loggato coincide con quello dell'asta visualizza il form di risposta
                  //Inserisce due form praticamente identici, cambia solo la tipologia di Inserimento o modifica a livello concettuale
                  if(utente.getIdutente()==item.getIdutenterisposta() && item.getRispostaScritta().equals("Nessuna risposta"))
                  { 
                    entrato=true;
                %>
                      <table id="tablemodifica<%out.print(item.getIdDomanda());%>">
                        <tr><td><span onclick="visualizzaTArea(<%out.print(item.getIdDomanda());%>)" style="cursor:pointer;"><i><u>Inserisci una risposta</u> </i></span></td></tr>
                    </table><br></br>
                <%}
                 else if(utente.getIdutente()==item.getIdutenterisposta() && !item.getRispostaScritta().equals("Nessuna risposta"))
                 { 
                    entrato=true;
               %>
                    
                    <table id="tablemodifica<%out.print(item.getIdDomanda());%>">
                        <tr><td><span onclick="visualizzaTArea(<%out.print(item.getIdDomanda());%>)" style="cursor:pointer;"><i><u>Modifica la risposta</u> </i></span></td></tr>
                    </table><br></br> 
                   <%}
           }
            out.print("</ul>");
            
        }
        //nel caso volessi avere parametri aggiuntivi per funzionalità da implementare, ho due sezioni differenti.
        if(entrato) //Se è loggato!
        { 
%>                  <input type="hidden" name="idasta" value="${asta.idasta}" />
                    <input type="hidden" name="idutenterisposta" value="${utente.idutente}" />
                    <input type="hidden" name="azione_asta" value="visualizza" />                 
      <%}
        if(entrato1) //Se è loggato!
        { 
%>               
                        <input type="hidden" name="idasta" value="${asta.idasta}" />
                        <input type="hidden" name="idutenterisposta" value="${utente.idutente}" />
                        <input type="hidden" name="azione_asta" value="visualizza" />                       
      <%}
        
   %></form><br><%

   //Tutti possono fare una domanda tranne il venditore stesso dell'asta.
   if(utente.isLogged() && utente.getIdutente()!=asta.getIdutentevenditore() && asta.getStato()==stato_asta.attiva)
   {
       %>
       
   <br><hr><br><form id="dom" action="doAsta.jsp" method="get">
             <input type="hidden" name="idasta" value="${asta.idasta}" />
             <input type="hidden" name="idutenteofferente" value="${utente.idutente}" />
             <input type="hidden" name="azione_asta" value="visualizza" />
             <table><tr><td><textarea cols="40" rows="4" name="domanda" class="required"></textarea></td></tr>
                 <tr><td>&nbsp;&nbsp;<input type="submit" value="Inserisci domanda"/></td></tr></table>
      </form><br><hr>
   
   <%     
   }   

   if(utente.isLogged() && utente.getIdutente()!=asta.getIdutentevenditore() && azione.equals("visualizza")&& asta.getStato()==stato_asta.attiva ) {
     %>
     
     <div id="offerta">
         <% if(offerta.getIdofferta()!=-1 ) {%>
         <table><tr><td><span> Il hai già effettuato un'offerta di <i><%=offerta.getValoreOfferta() %> </i>&euro; per quest'asta.
                     &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></td>
             <td>
             <form action="doOfferta.jsp">
             <input type="hidden" name="idasta" value="${asta.idasta}" />
             <input type="hidden" name="idutenteofferente" value="${utente.idutente}" />
             <input type="hidden" name="azione_offerta" value="annulla" />
             <input type="submit" value="Annullare l'offerta"/>
         </form></td></tr></table>
             <hr>
        <%}%><br>
         </div>
         

         <form action="doOfferta.jsp" method="post" id="off">
             <input type="hidden" name="idasta" value="${asta.idasta}" />
             <input type="hidden" name="idutenteofferente" value="${utente.idutente}" />
         <table><tr><td><b>&euro;</b>&nbsp;<input type="text" class="number required" name="offerta" min="${offerta.valoreOfferta}" value="${offerta.valoreOfferta}" />   </td></tr>
         <tr><td>&nbsp;&nbsp;<input type="submit" value="Fai offerta!"/></td></tr></table>
             
         </form>
             <br><hr><br>
     
     <%}%>