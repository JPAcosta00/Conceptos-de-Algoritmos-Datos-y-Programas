program ejFinal;
type
  subRango=1..4;
  cadena=string[50];
  tabla=array[subRango]of real;              //bytes
  
  cliente=record
    nombre:cadena;
    dni:integer;
    edad:integer;
    sub:subRango;
  end;

  lista=^nodo;
  nodo=record
    dato:cliente;
    sig:lista;
  end;
  
  vector=array[1..4]of integer;             //24 bytes
  
  info=record
    dni:integer;
    nombre:cadena;
  end;
  
  listado=^nodo1;
  nodo1=record
    dato:info;
    sig:listado;
  end;

procedure cargaTabla(var tabl:tabla);         //se dispone

procedure inicializaVector(var vect:vector);
var 
  i:subRango;
begin
  for i:= 1 to 4 do 
    vect[i]:=0;
end;

procedure cargaClientes(var lis:lista);

  procedure leeCliente(var c:cliente);
  begin
    readln(c.dni);
    if(c.dni <> 0)then begin
       readln(c.nombre);
       readln(c.edad);
       readln(c.sub);
    end;
  end;
  
  procedure agregaNodo(var li:lista;cl:cliente);
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
  leeCliente(cli);
  while(cli.dni <> 0)do begin
    agregaNodo(lis,cli);
    leeCliente(cli);
  end;
end;

procedure procesaClientes(l:lista;ta:tabla;var ganancia:real;var su1,su2:subRango;var ve:vector;var lisN:listado);

  procedure calculaMasClientes(v:vector;var s1,s2:subRango);
  var
    i:subRango;
    max1,max2:integer;
  begin
    max1:=-1;
    max2:=-1;
    for i:= 1 to 4 do begin
      if(v[i] > max1)then begin
        s2:=s1;
        s1:=i;
        max2:=max1;
        max1:=v[i];
      end
      else begin
        if(v[i] > max2)then begin
          s2:=i;
          max2:=v[i];
        end;
      end;
    end;
  end;
  
  procedure agregaInformacion(var ln:listado;nombre:cadena;dni:integer);
  var
    ant,act:listado;
    aux:listado;
  begin
    ant:=ln;
    act:=ln;
    new(aux);
    aux^.dato.nombre:=nombre;
    aux^.dato.dni:=dni;
    aux^.sig:=nil;
    while(act <> nil)and(act^.dato.dni < dni)do begin
      ant:=act;
      act:=act^.sig;
    end; 
    if(act = ant)then
      ln:=aux
    else
      ant^.sig:=aux;
    aux^.sig:=act;
  end;
  
begin
  while(l <> nil)do begin
    ganancia:= ganancia + ta[l^.dato.sub];
    ve[l^.dato.sub]:= ve[l^.dato.sub] +1;
    if(l^.dato.edad > 40)and(l^.dato.sub = 3)then 
      agregaInformacion(lisN,l^.dato.nombre,l^.dato.dni);
    l:=l^.sig;
  end;
  calculaMasClientes(ve,su1,su2);
end;

var                                                                //programa principal
  list:lista;                            //4 bytes
  tab:tabla;                             //40 bytes
  gananciaTotal:real;                    //10 bytes
  sub1,sub2:subRango;                    //12 bytes
  vecto:vector;                          //23 bytes
  listaNueva:listado;                    //4 bytes
begin                                    //MEMORIA ESTATICA = 93 bytes
  listaNueva:=nil;
  gananciaTotal:=0;
  list:=nil;
  inicializaVector(vecto);
  cargaTabla(tab);                                                     //se dispone
  cargaClientes(list);
  procesaClientes(list,tab,gananciaTotal,sub1,sub2,vecto,listaNueva);
  writeln(gananciaTotal);
  writeln(sub1,sub2);
end.
