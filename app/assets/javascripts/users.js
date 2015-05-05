//= require zeroclipboard

$(document).ready(function(){
	var client = new ZeroClipboard( document.getElementById("copylinkbutton") );
	console.log('executing script');
	console.log(client);

	client.on( "ready", function( readyEvent ) {
	// alert( "ZeroClipboard SWF is ready!" );
		console.log("ready");

		client.on( "aftercopy", function( event ) {
			console.log('text copied: ' + event.data["text/plain"]);
		});
	});
});
