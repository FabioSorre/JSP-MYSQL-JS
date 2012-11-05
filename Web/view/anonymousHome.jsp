<%@page import="it.polito.elite.paw10.minibay.asta.AstaData"%>
<%@page import="java.util.ArrayList, it.polito.elite.paw10.minibay.asta.categoria.Categoria"%>
<jsp:useBean id="errormsg" class="it.polito.elite.paw10.minibay.ErrorMsg" scope="request" />
<jsp:useBean id="logindata" class="it.polito.elite.paw10.minibay.LoginData" scope="request" />
<jsp:useBean id="aste" class="it.polito.elite.paw10.minibay.asta.AstaDB" scope="request" />
<h1>Login</h1>

<%
            if (!errormsg.isEmpty()) {
                for (String msg : errormsg.getOtherErrs()) {
                    out.println("<p class='errormessage'>" + msg + "</p>");
                }
            }
%>
<script type="text/Javascript" src="js/jquery1.js"></script>
                 <script type="text/Javascript" src="js/jquery.validate1.js"></script>
                 <script>
                     $(document).ready(function(){$("#log").validate(); });

                 </script>
<form action="doLogin.jsp" method="post" id="log">
    <p><label>Username: <input type="text" name="username" value="${logindata.username}" class="required" onClick="value=''"/></label> </p>
    <p><label>Password: <input type="password" name="password" class="required" value="" onClick="value=''" /></label> </p>
    <p>
       &nbsp;&nbsp;|&nbsp;&nbsp;<input type="submit" value="Accedi"/>


    &nbsp;|&nbsp;&nbsp;Non sei un utente miniBay? <a href="doFormRegistrazione.jsp">Registrati!</a></p>
</form></br>

<% ArrayList<AstaData> elencoAste=aste.getUltimeAsteAttive(10);
 if(elencoAste.size()>0){
     request.setAttribute("elencoaste", elencoAste);
%>
<h1>In evidenza</h1>
<p>Ultime <%=elencoAste.size()%> inserite...</p>
<jsp:include page="../include/tabellaAste.jsp"/>
<%} else {%>
<p><h1> Non ci sono ancora aste aperte!</h1></p>

<% }%>
