program dos;
type
  rango=1..6;
  cliente=record
    codigoCliente:integer;
    Dni:integer;
    apellido:string;
    nombre:string;
    codigoPoliza:rango;
    montoBasico:integer;
  end;
  lista=^nodo;
  nodo=record
    dato:cliente;
    sig:lista;
  end;
procedure crearNodo (cli:cliente;var list:lista);
var
  nuevo:lista;
begin
  new(nuevo);
  nuevo^.dato:=cli;
  nuevo^.sig:=list;
end;
procedure LeerCliente (var lis:lista);
var
  c:cliente;
begin
  readln(c.codigoCliente);
  repeat
    readln(c.Dni);
    readln(c.apellido);
    readln(c.nombre);
    readln(c.codigoPoliza);
    readln(c.montoBasico);
    readln(c.codigoCliente);
  until(c.codigoCliente<>1122);
  crearNodo(c,lis);
end;
function descomponerDni(var lh:lista):boolean;
var
 cumple:boolean;
 cant:integer;
begin 
 cumple:=false;
 cant:=0;
 while (lh^.dato.Dni<>0)do begin
  if (lh^.dato.Dni mod 10=9)then begin
     cant:=cant+1;
  end;
  lh^.dato.Dni:=lh^.dato.Dni div 10;
  if(cant>=2)then
    cumple:=true;
 end;
 descomponerDni:=cumple;
end;
procedure procesarInformacion(var listita:lista;montoC:integer);
var 
  aux:lista;
  montoA:integer;
begin
  aux:=listita;
  while(aux<>nil)do
  begin
   writeln('ingrese un valor que represente el monto adicional');
   readln(montoA);
   montoC:=aux^.dato.montoBasico+montoA;
   writeln(aux^.dato.Dni,aux^.dato.apellido,aux^.dato.nombre,montoC);  //inciso A
   if(descomponerDni(aux)=true)then begin
     writeln('nombre y apellido cuyo DNI tiene al menos dos digitos 9:',aux^.dato.nombre,aux^.dato.apellido);      //inciso B
   end;
   aux:=aux^.sig;
  end;
end;
procedure eliminarCliente(var lis:lista);
var 
  codigo:integer;
  act,ant:lista;
begin
  act:=lis;
  ant:=lis;
  writeln('ingrese un codigo de cliente');
  readln(codigo);
  while((act<>nil)and(act^.dato.codigoCliente<>codigo))do begin
    ant:=act;
    act:=act^.sig;
  end;
  if(act=ant)then begin
    lis:=act^.sig;
    dispose(act)
  else
    if(act^dato.codigoCliente=codigo)then begin
      ant^sig:=act^sig;
      dispose(act);
    end; 
  end;
end;
var
  L:lista;
  montoCompleto:integer;
begin 
  l:=nil;
  LeerCliente(l);
  while(l^.dato.codigoCliente<>1122)do begin
     procesarInformacion(l,montoCompleto);
     eliminarCliente(l);
  end;
end.
