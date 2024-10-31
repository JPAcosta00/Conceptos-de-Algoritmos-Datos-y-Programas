program ejFinal;
type
  cadena=string[50];
  subRango=1..100;
  subTipo=1..5;
  
  evento=record               
    nombre:cadena;            //51
    tipo:subTipo;             //6
    lugar:cadena;             //51
    cantidad:integer;         //6
    costo:real;               //10
  end;
  vector=array[subRango]of evento;    //1240  

  ventas=record
    codigo:integer;
    evento:subRango;
    dni:integer;
    cantEntradas:integer;
  end;
  lista=^nodo;
  nodo=record
    dato:ventas;
    sig:lista;
  end;
  
  vec=array[subRango]of real;       //1000 

procedure cargaEventos(var vectoEventos:vector);            //Se dispone

procedure inicializa(var vect:vec);
var
  i:subRango;
begin
  for i:= 1 to 100 do 
    vect[i]:=0;
end;

procedure cargaVentas(var lis:lista);

  procedure leeVenta(var v:ventas);
  begin
    readln(v.codigo);
    if(v.codigo <> -1)then begin
      readln(v.evento);
      readln(v.dni);
      readln(v.cantEntradas);
    end;
  end;
  
  procedure agregaNodo(var li:lista;ve:ventas);
  var
    nue:lista;
  begin
    new(nue);
    nue^.dato:=ve;
    nue^.sig:=li;
    li:=nue;
  end;
  
var
  ven:ventas;
begin
  leeVenta(ven);
  while(ven.codigo <> -1)do begin
    agregaNodo(lis,ven);
    leeVenta(ven);
  end;
end;

procedure procesaInformacion(l:lista;ev:vector;var contador:vec;var cant:integer);

  function descompone(docu:integer):boolean;
  var
    dig:integer;
    cumple:boolean;
    par:integer;
    impar:integer;
  begin
    cumple:=false;
    par:=0;
    impar:=0;
    while(docu <> 0)do begin
      dig:= docu mod 10;
      if(dig mod 2 = 0)then 
         par:= par+1
      else
         impar:= impar+1;
      docu:= docu div 10;
    end;
    if(par > impar)then
      cumple:= true;
    descompone:=cumple;
  end;
  
var
  cuenta:integer;
begin
  cuenta:=0;
  while(l <> nil)do begin
    contador[l^.dato.evento]:= contador[l^.dato.evento] + (l^.dato.cantEntradas * ev[l^.dato.evento].costo);
    if(descompone(l^.dato.dni))and(ev[l^.dato.evento].tipo = 3)then 
      cant:= cant+1;
    if(l^.dato.evento = 50)then
      cuenta:= cuenta + l^.dato.cantEntradas; 
    l:=l^.sig; 
  end;
  if(cuenta = ev[50].cantidad)then
     writeln('La cantidad de entradas vendidas para el evento 50 alcanzo la cantidad maxima de personas permitidas.');
end;

procedure calculaIncisoA(v:vec;e:vector;var no1,no2,lu1,lu2:cadena);
var
  min1:real;
  min2:real;
  i:subRango;
begin
  min1:=9999;
  min2:=9999;
  for i:= 1 to 100 do begin
    if(v[i] < min1)then begin
      no2:=no1;
      no1:=e[i].nombre;
      lu2:=lu1;
      lu1:=e[i].lugar;
      min2:=min1;
      min1:=v[i];
    end
    else
      if(v[i] < min2)then begin
        no2:=e[i].nombre;
        lu2:=e[i].lugar;
        min2:=v[i];
      end;
  end;
end;

var                                                      //programa principal
  list:lista;                    //4 bytes
  eve:vector;                    //1240 bytes
  cantidad:integer;              //6 bytes
  nom1,nom2:cadena;              //51 bytes
  lug1,lug2:cadena;              //51 bytes
  vecto:vec;                     //1000 bytes
begin                            //MEMORIA ESTATICA = 2352 bytes
  cantidad:=0;
  list:=nil;
  inicializa(vecto);
  cargaEventos(eve);                                      //se dispone
  cargaVentas(list);                                      //INCISO 1
  procesaInformacion(list,eve,vecto,cantidad);            //INCISO 2C
  writeln(cantidad);                                      //INCISO 2B
  calculaIncisoA(vecto,eve,nom1,nom2,lug1,lug2); 
  writeln(nom1,lug1,nom2,lug2);                           //INCISO 2A
end.
