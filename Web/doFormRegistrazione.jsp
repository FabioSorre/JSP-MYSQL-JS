<%-- 
    Document   : doFormRegistrazione
    Created on : 11-gen-2011, 15.30.57
    Author     : Fabio
--%>
<jsp:useBean id="utente" class="it.polito.elite.paw10.minibay.Utente" scope="session" />
<jsp:useBean id="registrationdata" class="it.polito.elite.paw10.minibay.RegistrationData" scope="request" />
<jsp:useBean id="errs" class="it.polito.elite.paw10.minibay.ErrorMsg" scope="request" />

<%
            /* Questa pagina è accessibile SOLO da utenti non registrati! */
            if (utente.isLogged()) {
                response.sendRedirect("index.jsp");
            }
%>

<%
            // se ci sono parametri, significa che è la prima volta, devi fare i controlli
            if (request.getParameter("username") != null) {
%>

<jsp:setProperty name="registrationdata" property="*" />

<%
               
                    if (utente.creaNuovoUtente(registrationdata, errs)) {
                        // utente creato nel DB, allora aggiorna la sessione
                        utente.forceLogin(registrationdata) ;

                        response.sendRedirect("index.jsp");
                        return ;
                    } else {
                        // utente duplicato... devi rigenerare il form (vai al forward)
                    }

                
            }
%>
<%-- registration data invalid --OR-- first time: regenerate form --%>
<jsp:forward page="masterView.jsp">
    <jsp:param name="corpo"  value="formRegistrazione.jsp" />
</jsp:forward>
