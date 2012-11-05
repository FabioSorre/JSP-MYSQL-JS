<jsp:useBean id="utente" class="it.polito.elite.paw10.minibay.Utente" scope="session" />
<ul>
    <% if(utente.isLogged()) { %>
    <li><a href="masterView.jsp?corpo=loggedHome.jsp">Home</a></li>
    <li><a href="masterView.jsp?corpo=vendi.jsp">Vendi</a></li>
    <li><a href="masterView.jsp?corpo=offerta.jsp">Compra</a></li>
    <li><a href="doCerca.jsp">Cerca</a></li>
    <%}
    if(!utente.isLogged()){ %>
       <li><a href="doCerca.jsp">Cerca</a></li>
       <li><a href="masterView.jsp?corpo=anonymousHome.jsp">Login</a></li>
    <%}%>
    
</ul>