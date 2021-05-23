var _id = http_get("http://www.google.com/");
DoLaterAsync("HTTP", ["id", _id], function() { show_message(json_encode(async_load)) }, undefined);
printTeste = function(){
	show_debug_message("TESTE");	
}

struct = DoLaterListen("Teste", printTeste, noone, false);
struct2 = DoLaterListen("Teste", printTeste, noone, false);

DoLaterBroadcast("Teste", noone);
DoLaterListerRemove(struct2);
