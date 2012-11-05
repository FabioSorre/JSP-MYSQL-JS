<%-- 
    Document   : cerca
    Author     : Fabio
--%>
<%@page import="it.polito.elite.paw10.minibay.asta.AstaData"%>
<%@page import="java.util.*" %>
<%@page import="it.polito.elite.paw10.minibay.asta.categoria.Categoria"%>
<%@page import="java.util.HashMap"%>
<jsp:useBean id="ricercaData" class="it.polito.elite.paw10.minibay.RicercaData" scope="request" />

<jsp:useBean id="categorie" class="it.polito.elite.paw10.minibay.asta.categoria.CategoriaBean" scope="request" />
<jsp:useBean id="errs" class="it.polito.elite.paw10.minibay.ErrorMsg" scope="request" />

<div id="menu_ricerca">
    <script type="text/Javascript" src="js/jquery-1.4.4.js"></script>

    <form action="doCerca.jsp" method="get" >
        <INPUT type="hidden" name="azione_cerca" value="personalizzata" />
        <table><tr><td>Titolo</td><td>
     <input type="text" name="titolo" value="${ricercaData.titolo}"/>
            
            </td></tr>
        <tr><td>Descrizione</td><td>  <input type="text" name="descrizione" value="${ricercaData.descrizione}"/></td></tr>
        <tr><td>Range prezzo da </td><td> <input type="text" name="prezzominimo" value="${ricercaData.prezzominimo}"/></td></tr>
        <tr><td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                &nbsp;
                a&nbsp;</td><td>  <input type="text" name="prezzomassimo" value="${ricercaData.prezzomassimo}"/></td></tr>
        <tr><td>Categoria  </td><td><select name="idcategoria">
                <option value="-1" >Qualsiasi categoria</option>
            <%
                for(Categoria categoria:categorie.getElencoCategorie()){
                  %>
                  <option value="<%=categoria.getIdcategoria() %>"
                          <% if(categoria.getIdcategoria()==ricercaData.getIdcategoria()) out.print("selected='selected'");%>
                          >
                      <%=categoria.getNomecategoria() %>
                  </option>
                  <%
                }

            %>

        </select></td></tr></table>
        <p>
            <input type="submit" value="Cerca" />&nbsp; | &nbsp; oppure
            <a href="doCerca.jsp?azione_cerca=ultimecategorie" >ultime aste di ogni categoria</a> </p>
        
           
    </form>
   
            <hr>
</div>

<%
        try
         {
            String prezzo1=request.getParameter("prezzominimo");
            String prezzo2=request.getParameter("prezzomassimo");
            if(!prezzo1.equals("") && !prezzo2.equals(""))
            {
                int p1=Integer.parseInt(prezzo1);
                int p2=Integer.parseInt(prezzo2);
                if(p1>p2)
                {
                    %>
                    <h4><blink>  &nbsp;&nbsp;&nbsp;&nbsp;  Attenzione! Il prezzo minimo non può essere maggiore del prezzo massimo.</blink></h4>
                    <%
                }   
            }
         }
         catch(NullPointerException ie )                                
         {
           //Try Per il controllo delle caselle di testo.
         }
    String azione=request.getParameter("azione_cerca");
    if(azione==null){
        azione="default";
    }

    if(azione.equals("ultimecategorie")){
        HashMap<Categoria,ArrayList<AstaData>> elencoCategorie=(HashMap<Categoria,ArrayList<AstaData>>)request.getAttribute("elencocategorie");
%><h2>Ultime aste attive per categoria</h2><%
        if(elencoCategorie!=null && elencoCategorie.size()>0){
           
         for(Categoria categoria:elencoCategorie.keySet()){
                    ArrayList<AstaData> elencoAste=elencoCategorie.get(categoria);
                    request.setAttribute("elencoaste", elencoAste);
                    %>
                    <h3><%=categoria.getNomecategoria()%></h3>
                    <jsp:include page="../include/tabellaAste.jsp" /> 
     <%   }
    }
        }
    if(azione.equals("personalizzata")){
      %>
       <jsp:include page="../include/tabellaAste.jsp" />
    <%
    }

%>

