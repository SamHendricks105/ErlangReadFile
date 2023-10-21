-module(calculator_server).

-export([start/0,loop/0,rpc/2,get_add/0]).



start() ->
    spawn(?MODULE, loop, []).

% without rpc(Remote procedure call I need to use receive X -> X end. to get my message
rpc(Pid,Message)->
    Pid ! {self(),Message},
    receive
        Response ->
            Response
        end.

get_add()->
    {ok,File} =file:open("src//text.dat",read),
    io:get_line(File,'').
loop()->
    
    % Add
    receive
    {Client, {Num1, Num2, "add"} }->
            Client ! Num1+Num2;
       
    %  Subtract 
    
    {Client, {Num1, Num2, "sub"}}->
            Client ! Num1-Num2;
    
    {Client, {Num1, Num2, "subtract"}}->
            Client ! Num1-Num2;
    
    % multiply 
    {Client, {Num1, Num2, "mul"}}->
        Client ! Num1*Num2;
    
    {Client, {Num1, Num2, "multiply"}}->
        Client ! Num1*Num2;
    % divide 
    {Client, {Num1, Num2, "divide"}}->
        Client ! Num1/Num2;
    
    {Client, {Num1, Num2, "divi"}}->
        Client ! Num1/Num2;
    
    % 
    {Client, {R1, R2, "voltage"}}->
        Client ! R1/(R1+R2)
    
    end,
    
    loop().


 


