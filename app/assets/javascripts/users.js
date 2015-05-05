$(document).ready(function(){
	var client = new ZeroClipboard( document.getElementById("copy-link") );
	console.log('executing script');
	console.log(client);
	
	client.on( "ready", function( readyEvent ) {
	// alert( "ZeroClipboard SWF is ready!" );

		client.on( "aftercopy", function( event ) {
	  	// `this` === `client`
	  	// `event.target` === the element that was clicked
	  	event.target.style.display = "none";
		});
	});
});
