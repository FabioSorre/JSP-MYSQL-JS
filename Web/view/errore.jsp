<%@page import="it.polito.elite.paw10.minibay.asta.categoria.Categoria"%>
<%@page  isErrorPage="false" %>
<h1>Errore </h1>
<jsp:useBean id="errs" class="it.polito.elite.paw10.minibay.ErrorMsg" scope="request" />

<% if(request.getParameter("errore")!=null){%>

<p>Siamo spiacenti, ma si è verificato il seguente errore:</p>
<pre class="errormessage">
${param.errore}
</pre>

<%}%>

