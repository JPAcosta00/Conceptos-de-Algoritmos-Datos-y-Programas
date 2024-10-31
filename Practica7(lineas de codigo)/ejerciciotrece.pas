program trece;
type 
  tematica=array[1..35]of string;       //se dispone
  libro=record
    titulo:string;
    nombreEdit:string;
    cantPages:integer;
    anio:integer;
    cantVendido:integer;
    codArea:tematica;
  end;
  lista2=^nodo2;
  nodo2=record
    dato:libro;
    sig:lista2;
  end;
  lista=^nodo;
  nodo=record
    dato:libro;
    sig:lista;
  end; 
procedure crearNodo(var nueva:lista);
var
  nue:lista;
begin
  new(nue);
  nue^.dato:=nil;
  nue^.sig:=nueva;
end;
procedure AnioMasAntiguo(anio:integer;var Anti:integer);
var
  min:integer;
begin
  min:=9999;
  if(anio<min)then 
    min:=anio;
  Anti:=min;
end;
procedure leerLibros (var li:lista;var te:lista2);
var
  aux:lista;
  antiguo,cant,cantTotal:integer;
begin
  cantTotal:=0; 
  cant:=0;
  antiguO:=0;
  aux:=li;
  crearNodo(te);
  while(aux<>nil)do begin
    repeat
      if(li^.dato.nombreEdit='planeta libros')then begin
         te^.dato:=li^.dato.nombreEdit;
         AnioMasAntiguo(li^.dato.anio,antiguo);
         te^.dato:=antiguo;
         cant:=cant+1;
         cantTotal:=cantTotal+li^.dato.cantVendido;
      end;
    until (li^.dato.titulo='Relato de un naufrago');
    te^.dato:=cant;
    te^.dato:=cantTotal;
    te:=te^.sig;
    aux:=aux^.sig;
  end;
end;
procedure imprimir (es:lista);
begin
   while(es<>nil)and(es^.dato.cantPages>250)do begin
     writeln(es^.dato.nombreEdit);
     wirteln(es^.dato.titulo);
   end;
end;
var
  l:lista;
  t:lista2;
begin
  l:=nil;                      //se dispone
  t:=nil;
  leerLibros(l,t);             //inciso A
  imprimir(t);                 //inciso B
end.
  
  // falta el ultimo punto de inciso A
