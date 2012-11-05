<%@page import="java.util.ArrayList"%>
<%
/*
 * Questa frammento di pagina jsp, stampa una tabella contente un elenco di aste
 * Richiede un parametro nomelenco che indica il nome dell'attributo di richiesta in cui è memorizzato l'elenco delle aste 
*/
%>
<%@page import="it.polito.elite.paw10.minibay.asta.AstaData"%>
    <table border="2" bordercolor="#3fe6ff">
    <tr>
        <th  style="padding-left: 10px; padding-right: 10px;">Data creazione</th>
        <th  style="padding-left: 10px; padding-right: 10px;">Titolo</th>
        <th  style="padding-left: 10px; padding-right: 10px;">Venditore</th>
        <th  style="padding-left: 10px; padding-right: 10px;">Scadenza</th>
        <th  style="padding-left: 10px; padding-right: 10px;">Categoria</th>
        <th  style="padding-left: 10px; padding-right: 10px;">Prezzo Base</th>
        <th  style="padding-left: 10px; padding-right: 10px;">Dettagli</th>
    </tr>
<%
String azione_tabella=request.getParameter("azione_tabella");
if(azione_tabella==null){
    azione_tabella="visualizza";
}
int i=0;
ArrayList<AstaData> elencoAste=(ArrayList<AstaData>)request.getAttribute("elencoaste");
 for(AstaData asta:elencoAste){
    i=1; %>
    <tr> 
         <td style="padding: 10px;"><%=asta.getStamp_creazione()%></td>
         <td style="padding: 10px;"><%=asta.getTitolo()%></td>
         <td style="padding: 10px;"><%=asta.getUtenteVenditore().getUsername()%></td>
         <td style="padding: 10px;"><%=asta.getStamp_scadenza()%></td>
         <td style="padding: 10px;"><%=asta.getCategoria().getNomecategoria()%></td>
         <td style="padding: 10px;"><%=asta.getPrezzobase()%> &euro;</td>
         <td style="padding: 10px;">
             <% if(azione_tabella.equals("visualizza")){%>
             <a href="doAsta.jsp?azione_asta=visualizza&idasta=<%=asta.getIdasta()%>"> Dettagli</a>
            <%} else if(azione_tabella.equals("modifica")){%>
                 <a href="doAsta.jsp?azione_asta=modifica&idasta=<%=asta.getIdasta()%>"> Modifica</a>
            <%}%>
         </td>
    </tr>
    <%
  }

if(i==0)
{%>
<tr><td colspan="7" style="padding: 10px;"><p align="center">Nessuna asta presente in questa categoria!</p></td></tr>
<%}%>
</table>
<br></br>