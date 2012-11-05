<%-- 
    Document   : provalayout
    Created on : 13-dic-2010, 16.31.20
    Author     : Fabio
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<jsp:useBean id="utente" class="it.polito.elite.paw10.minibay.Utente" scope="session" />

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>${!empty param.pagetitle ? param.pagetitle : " miniBay - Sito di Aste Online"}</title>
        <link rel="stylesheet" type="text/css" href="css/minibay.css">
        <link rel="shortcut icon" href="images/favicon.ico">
    </head>
    <body >
        <div id="testa">
            <h1><img id="logo" src="images/logo-minibay_1.png" alt="Logo mini-bay"/></h1>
                
            <% if (utente.isLogged()) {%>
            <div id="nomeutente"><i>Welcome,</i> <b>${utente.nome} ${utente.cognome}</b>&nbsp;|&nbsp;
               <a href="doLogout.jsp">Logout</a> </div>
          <% } %>
            <hr size="1" />
        </div>
            
        <div id="centro">
            <div id="pagina">
                <div id="menu">
                    <jsp:include page="include/menu.jsp" />
                </div>
                <div id="corpo">
                    <% if (request.getParameter("corpo") != null) {%>
                    <jsp:include page="view/${param.corpo}" />
                    <% } else {%>
                    <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed sit amet mi ac leo fringilla ultrices. Nulla facilisi. Aliquam mattis, nisl eget venenatis dignissim, est lorem luctus enim, vel vehicula justo nisl id purus. Sed fermentum molestie ipsum in convallis. Integer ante ipsum, blandit pulvinar pharetra non, rutrum a mi. Duis faucibus condimentum dolor, et tristique massa tempus ac. Suspendisse enim mauris, facilisis consectetur convallis vitae, commodo vel felis. Nunc a leo lorem, id euismod est. Nulla facilisi. Duis malesuada orci at leo placerat sit amet imperdiet turpis rutrum. Suspendisse potenti. In congue condimentum ornare. Mauris sed velit magna, vitae congue est. Phasellus condimentum mattis dui sit amet consequat. Proin cursus pulvinar euismod. Nullam aliquet viverra aliquet. Donec tortor nisl, iaculis sed hendrerit vitae, pulvinar eu lacus. Aenean pretium urna at enim tincidunt convallis rutrum in libero.</p>
                    <p>Nulla facilisi. Nunc sed iaculis ante. Sed mauris ligula, posuere ac ullamcorper sit amet, placerat vitae quam. Vestibulum tristique, nulla at varius tincidunt, felis erat pellentesque nibh, id accumsan lacus dolor sed sapien. Nulla nunc est, vestibulum sed volutpat sit amet, ultrices eget urna. Praesent gravida risus ut augue sollicitudin at feugiat arcu auctor. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Nulla ut eros sem, ac ultrices felis. Sed tempor ante at tellus malesuada nec sollicitudin mi adipiscing. Nunc eu nulla vel nunc pellentesque faucibus. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis non leo nec elit pretium aliquam quis in est. Cras ut lectus lacus. Morbi sit amet risus ut urna suscipit vestibulum. Donec sit amet nisl ante. Morbi aliquam leo vitae elit sodales eget condimentum nulla dapibus. In at orci sem, quis lobortis diam. Maecenas vel sapien in lorem malesuada tempus. </p>
                    <% }%>
                </div>
            </div>
            <div class="break" id="finepagina" > </div>
        </div>

        <div id="piede">
            <a href="http://elite.polito.it/teaching-mainmenu-69/laurea-i-livello-mainmenu-82/55-01kpsbf">Progettazione di Applicazioni Web</a> - A.A. 2010/2011 - <a href="http://www.facebook.com/fabiosor">Fabio Sorrentino</a> (147304)
        </div>
    </body>
</html>
