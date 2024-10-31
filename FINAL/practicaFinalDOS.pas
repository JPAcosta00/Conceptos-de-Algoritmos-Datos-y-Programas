program ejFinal;
type
  subCodigoPoliza = 1..6;
  cadena = string[50];
  
  tabla= array[1..6]of real;      //60 bytes         //se dispone
  
  cliente=record
    codigoCliente:integer;
    dni:integer;
    apellido:cadena;
    nombre:cadena;
    codigoPoliza:subCodigoPoliza;
    monto:real;
  end;
  lista = ^nodo;
  nodo=record
    dato:cliente;
    sig:lista;
  end;

procedure cargaTabla(var tabl:tabla);                            //se dispone.

procedure cargaClientes(var lis:lista);

  procedure leeCliente(var c:cliente);
  begin
    writeln('Ingrese un codigo de cliente');
    readln(c.codigoCliente);
    writeln('Ingrese el dni ');
    readln(c.dni);
    writeln('Ingrese el apellido ');
    readln(c.apellido);
    writeln('Ingrese el nombre ');
    readln(c.nombre);
    writeln('Ingrese el codigo de poliza');
    readln(c.codigoPoliza);
    writeln('Ingrese el monto que paga mensualmente');
    readln(c.monto);
  end;
  
  procedure agregaAdelante(var li:lista; cl:cliente);
  var
    nue:lista;
  begin
    new(nue);
    nue^.dato:=cl;
    nue^.sig:=li;
    li:=nue;
  end;
  
var
  cli:cliente;
begin
  repeat
    leeCliente(cli);
    agregaAdelante(lis,cli);
  until(cli.codigoCliente = 1122);
end;

procedure informaAyB (l:lista;t:tabla);

  function descompone(docu:integer):boolean;
  var
    dig:integer;
    cant:integer;
    cumple:boolean;
  begin
    cumple:=false;
    cant:=0;
    while(docu <> 0)do begin
      dig:= docu mod 10;
      if(dig = 9)then
        cant:= cant+1;
      docu:= docu div 10;
    end;
    if(cant >= 2)then
       cumple:=true;
    descompone:=cumple;
  end;
  
var
  montoCompleto:real;
begin
  while(l <> nil)do begin
     montoCompleto:= (l^.dato.monto + t[l^.dato.codigoPoliza]);
     writeln('DOCUMENTO: ', l^.dato.dni
             'APELLIDO: ', l^.dato.apellido
             'NOMBRE: ' , l^.dato.nombre
             'MONTO COMPLETO: ' , montoCompleto);                      //inciso A
     if(descompone(l^.dato.dni))then
       writeln('APELLIDO: ', l^.dato.apellido
               'NOMBRE: ' , l^.dato.nombre);       
     l:=l^.sig;
  end;
end;

procedure eliminaCliente(cod:integer;var ele:lista);
var
  act,ant:lista;
begin
  ant:=ele;
  act:=ele;
  while(act <> nil)and(act^.dato.codigoCliente)do begin
    ant:=act;
    act:=act^.sig;
  end;
  if(act <> nil)then begin
    if(ant = act)then
      ele:=act^.sig
    else
      ant^.sig:=act^.sig;
    dispose(act);
  end;
end;

var                                   //Programa principal
   tab:tabla;                  //60 bytes
   list:lista;                 //4 bytes
   codigoRandom:integer;       //6 bytes
begin                          //MEMORIA ESTATICA = 70 bytes
  list:=nil;
  cargaTabla(tab);                    //se dispone
  cargaClientes(list);
  informaAyB(list,tab);
  writeln('Ingrese un codigo de cliente a eliminar ');
  readln(codigoRandom);
  eliminaCliente(codigoRandom,list);
end.
