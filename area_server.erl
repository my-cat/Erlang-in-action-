-module(area_server).
-export([loop/0, rpc/3]).

rpc(From,Pid, Request) ->
	Pid ! {self(), Request},

	receive 
		{Pid , Response} ->
			From! {Pid,Response}
	end.

loop() ->
	receive
		{From, {rectangle, Width,Ht}} ->
			From ! {self(), Width*Ht},
			loop();
		{From, {circle, R}} ->
			From ! {self(), 3,14159*R*R},
			loop();
		{From, Other} ->
			From ! {self(), {error1, Other}},
			loop()
	end.