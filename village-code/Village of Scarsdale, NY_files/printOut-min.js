(function(){var c=YAHOO.util.Dom,a=YAHOO.util.Event,e=YAHOO.lang,d=YAHOO.widget;var b=function(i,j,p){var o=p||window.document;var q=o.getElementsByTagName(i);while(q.length){var n=q[0];var m=document.createElement(j);for(var l=0;l<n.attributes.length;l++){var g=n.attributes[l].name;if(g!="href"){var h=n.attributes[l].value;m.setAttribute(g,h)}}m.innerHTML=n.innerHTML;n.parentNode.insertBefore(m,n);n.parentNode.removeChild(n)}};var f=function(){try{var p=c.get("printButtonArea");if(YAHOO.env.ua.ie==8){var r=document.createElement("div");r.innerHTML="&nbsp;";c.insertAfter(r,p)}var s=document.createElement("button");c.addClass(s,"printButton");s.appendChild(document.createTextNode("Print"));p.appendChild(s);a.addListener(s,"click",function(u){a.stopEvent(u);print()});var h=c.get("closeButton");a.addListener(h,"click",function(u){window.close()});var q=document.createElement("div");c.addClass(q,"sliderContainer");q.appendChild(document.createTextNode("Text Size:"));var m=document.createElement("div");c.addClass(m,"yui-h-slider");var i=document.createElement("div");c.addClass(i,"yui-slider-thumb");var t=document.createElement("img");c.setAttribute(t,"src","http://yui.yahooapis.com/2.9.0/build/slider/assets/thumb-n.gif");i.appendChild(t);c.setStyle(i,"left","100px");m.appendChild(i);q.appendChild(m);p.appendChild(q);var j=100,k=100,l=1;var g=YAHOO.widget.Slider.getHorizSlider(m,i,j,k,l);g.animate=true;var o=c.get("content");g.subscribe("change",function(w){try{var u=g.getValue();if(u<0){u/=4}else{u/=2.5}u+=108;c.setStyle(o,"font-size",u+"%")}catch(v){alert("got slider error: "+v.message)}});b("a","span",o)}catch(n){console.dir(n);alert("eCode360 error: "+n.message)}};YAHOO.util.Event.onDOMReady(f)})();