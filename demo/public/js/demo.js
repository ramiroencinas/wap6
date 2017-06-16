$(document).ready(function () {
  // click on Send GET button for webservice1
  $("#btSendGET-ws1").click(function() {
    var inget = $("#iget-ws1").val();
    sendAjax(inget, "GET", "ws1");
  });

  // click on Send GET button for webservice2
  $("#btSendGET-ws2").click(function() {
    var inget = $("#iget-ws2").val();
    sendAjax(inget, "GET", "ws2");
  });

  // click on Send POST button for webservice1
  $("#btSendPOST-ws1").click(function() {
    var inpost = $("#ipost-ws1").val();
    sendAjax(inpost, "POST", "ws1");
  });

  // click on Send POST button for webservice2
  $("#btSendPOST-ws2").click(function() {
    var inpost = $("#ipost-ws2").val();
    sendAjax(inpost, "POST", "ws2");
  });
});

function sendAjax (value, method, webservice_url) {
  // send GET or POST
  $.ajax({
    type: method,
    url: webservice_url,
    data: value,
    success: function(data){write_return(data, method, webservice_url);},
    failure: function(err) {alert(err);}
  });
}

function write_return (data, method, webservice_url) {
  // response from webservice1
  if ( ( method == "GET" )  && ( webservice_url == "ws1" ) ) { $("#get-returned-ws1").html(data); }
  if ( ( method == "POST" ) && ( webservice_url == "ws1") )  { $("#post-returned-ws1").html(data); }

  // response from webservice2
  if ( ( method == "GET" )  && ( webservice_url == "ws2" ) ) { $("#get-returned-ws2").html(data); }
  if ( ( method == "POST" ) && ( webservice_url == "ws2") )  { $("#post-returned-ws2").html(data); }
}
