<%-- TODO: rifare secondo la nuova architettura, e poi eliminare! --%>
<%-- 
    Document   : doVendi
    Created on : 4-dic-2010, 23.31.43
    Author     : Fabio
--%>
<jsp:useBean id="asta" class="it.polito.elite.paw10.minibay.asta.AstaData" scope="request" />
<jsp:useBean id="errs" class="it.polito.elite.paw10.minibay.ErrorMsg" scope="request" />

<jsp:setProperty name="asta" property="*" />

<% if (asta.checkErrors(errs)) {%>
<%-- Tutto OK - stampa riepilogo --%>
<jsp:forward page="doAsta.jsp" />
<% } else {%>
<%-- Ci sono errori, bisogna correggere --%>
<jsp:forward page="masterView.jsp" >
    <jsp:param name="corpo" value="vendi.jsp" />
</jsp:forward>
<% }%>