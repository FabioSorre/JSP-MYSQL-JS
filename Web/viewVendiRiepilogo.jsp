<%-- TODO: rifare secondo la nuova architettura, e poi eliminare! --%>

<%-- 
    Document   : viewVendiRiepilogo
    Created on : 4-dic-2010, 23.44.07
    Author     : Fabio
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Riepilogo prodotto in vendita</h1>

        <jsp:useBean id="asta" class="it.polito.elite.paw10.minibay.asta.AstaData" scope="request" />

        <h2>Grazie della tua offerta</h2>
        <p>Titolo: ${asta.titolo}</p>
      
        <p>Prezzo minimo: ${asta.prezzobase}</p>

        <p>Categoria: ${asta.idcategoria}</p>
        <p>Data inizio ${asta.stamp_creazione}</p>
        <p>Data scadenza ${asta.stamp_scadenza}</p>
        <p>Descrizione:</p>
        <pre>${asta.descrizione}</pre>

    </body>
</html>
