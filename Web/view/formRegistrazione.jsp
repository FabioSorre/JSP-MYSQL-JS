<%-- 
    Document   : formRegistrazione
    Created on : 11-gen-2011, 15.32.34
    Author     : Fabio
--%>
<jsp:useBean id="utente" class="it.polito.elite.paw10.minibay.Utente" scope="session" />
<jsp:useBean id="registrationdata" class="it.polito.elite.paw10.minibay.RegistrationData" scope="request" />
<jsp:useBean id="errs" class="it.polito.elite.paw10.minibay.ErrorMsg" scope="request" />

<script type="text/Javascript" src="js/jquery1.js"></script>
<script type="text/Javascript" src="js/jquery.validate1.js"></script>
<script>
    $(document).ready(function(){$("#reg").validate(); });
</script>

<%
            if (!errs.isEmpty()) {
                //out.println("<h3 class='errormessage'>Errori nella compilazione</h3>");
                for (String msg : errs.getOtherErrs()) {
                    out.println("<p class='errormessage'>" + msg + "</p>");
                }
            }
%>

<h1>Registrazione nuovo utente</h1>

<form action="doFormRegistrazione.jsp" method="post" id="reg" >
    <p>Nome: <input type="text" name="nome" class="required" value="${registrationdata.nome}" />&nbsp;&nbsp; &nbsp;  </p>
    <p>Cognome: <input type="text" name="cognome" class="required" value="${registrationdata.cognome}"  /> </p>
    <p>Indirizzo e-Mail: <input type="text" name="email" class="email required" value="${registrationdata.email}" /> </p>
    <p>Indirizzo postale (esclusivo per compratori): </p>
    <textarea cols="60" rows="3" name="indirizzo">${registrationdata.indirizzo}</textarea>
    <p>Username: <input type="text" name="username" class="required" value="${registrationdata.username}" minlength="3" onClick="value=''"  /> </p>
    <p>Password: <input type="password" name="password1" id="password1" class="required" value="" onClick="value=''" minlength="3"/></p>
    <p>Ripeti password: <input type="password" class=" required" equalTo="#password1" id="password2" name="password2" value="" minlength="3"/> </p>
    <p><input type="submit" value="Registra utente" /></p>
</form>
