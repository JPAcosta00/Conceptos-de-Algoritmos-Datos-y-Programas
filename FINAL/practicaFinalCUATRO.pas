program ejFinal;
type
  cadena= string[50];

  tabla=array[1..42]of real;
  embarazada=record
    nombre:cadena;
    apellido:cadena;
    pesos:tabla;
    diml:integer;
  end;
  
  lista=^nodo;
  nodo=record
    dato:embarazada;
    sig:lista;
  end;
  
procedure cargaInfoMaternidad(var ele:lista);                                                  //se dispone
 
procedure procesaMaternidad(var lis:lista);

  procedure calculaMasAumento(pes:tabla,dimen:integer; var week:integer);
  var
    max:real;
    i:integer;
    aumento:real;
  begin
    max:=-1;
    for i:=1 to dimen do begin
      aumento:=pes[i+1]-pes[i];
      if(aumento > max)then begin
         week:=i;
         max:=aumento;
      end;
    end;
  end;
  
var
  semana:integer;
  aumentoTotal:real;
begin
  while(lis <> nil)do begin
     calculaMasAumento(lis^.dato.pesos,lis^.dato.diml,semana);
     writeln('Semana con mayor aumento: ', semana);                                  //Inciso A
     aumentoTotal:= lis^.dato.pesos[lis^.dato.diml] - lis^.dato.pesos[1];
     writeln('Aumento total durante todo el embarazo: ', aumentoTotal);              //Inciso B
     lis:=lis^.sig;
  end;
end;

var                                                                               //Programa Principal.
  list:lista;            // 4 bytes (puntero)
begin                    //MEMORIA ESTATICA = 4 bytes
  list:=nil;
  cargaInfoMaternidad(list);                                                        //se dispone
  procesaMaternidad(list);
end.
