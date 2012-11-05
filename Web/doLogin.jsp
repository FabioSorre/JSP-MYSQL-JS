<%-- 
    Document   : doLogin
    Created on : 11-gen-2011, 9.28.34
    Author     : Fabio

    Acquisisce i dati del login utente e li valida.
    In caso di login valido, inizializza la sessione ed invia nella home page loggata.
    In caso di login non valido, ripropone il form (anonymousHome).
--%>
<jsp:useBean id="utente" class="it.polito.elite.paw10.minibay.Utente" scope="session" />
<jsp:useBean id="errormsg" class="it.polito.elite.paw10.minibay.ErrorMsg" scope="request" />
<jsp:useBean id="logindata" class="it.polito.elite.paw10.minibay.LoginData" scope="request" />

<jsp:setProperty name="logindata" property="*" />

<%
            if (logindata.isValid(errormsg)) {
                // dati validi, occorre controllare il database
                if (utente.checkLogin(logindata, errormsg)) {
                    // Perfetto! utente loggato!! => vai a index.jsp e troverai la home page loggata
                    /** usa redirect anziché forward **/
                    response.sendRedirect("index.jsp");
                    return;
                } else {
                    // ahiahiahi, utente non loggato => vai a index.jsp e troverai il form con gli errori
                }
            }
%>
<jsp:forward page="index.jsp" />
