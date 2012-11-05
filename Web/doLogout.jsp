<%-- 
    Document   : doLogout
    Created on : 11-gen-2011, 15.11.18
    Author     : Fabio
--%>
<jsp:useBean id="utente" class="it.polito.elite.paw10.minibay.Utente" scope="session" />
<%
            utente.setLogged(false);
            //non basta settare a false
            session.removeAttribute("utente");
%>

<%
            /* uso un redirect anziché un forward perché:
             * 1) così nella URL del browser rimane "index.jsp", e se l'utente fa refresh il browser
             *    non cercar di rifare il logout
             * 2) l'azione di logout è terminata, quindi tutti gli oggetti di request non mi servono più.
             *    Meglio terminare la request ed avviarne una nuova.
             */
            response.sendRedirect("index.jsp");
%>
<%-- <jsp:forward page="index.jsp" /> --%>
