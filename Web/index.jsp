<%-- 
    Document   : index
    Created on : 11-gen-2011, 9.05.30
    Author     : Fabio
    This is the home page of the minibay website
--%>
<jsp:useBean id="utente" class="it.polito.elite.paw10.minibay.Utente"  scope="session" />

<%
            if (utente.isLogged()) {
%>
<jsp:forward page="masterView.jsp">
    <jsp:param name="corpo" value="loggedHome.jsp" />
</jsp:forward>
<%            } else {
%>
<jsp:forward page="masterView.jsp">
    <jsp:param name="corpo" value="anonymousHome.jsp" />
</jsp:forward>
<%            }
%>
