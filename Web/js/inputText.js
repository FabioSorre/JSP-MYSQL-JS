
function fileFields() {
	 var x = document.getElementById('inputTxt');
	 x.onclick = function() {
  		var i = parseFloat(this.lastChild.id)+1;
  		if(i<4)
                    {
                        input = document.createElement("input");

                        input.setAttribute("type", "text");
                        input.setAttribute("name", 'idcategoria_' + i);
                        input.setAttribute("id", i);

                       this.appendChild(input);
                }
	 }
}

function addLoadEvent(func) {
  var oldonload = window.onload;
  if (typeof window.onload != 'function') {
    window.onload = func;
  } else {
    window.onload = function() {
      if (oldonload) {
        oldonload();
      }
      func();
    }
  }
}

addLoadEvent(function() {
  fileFields();
});

