program adicional16;
type
  corredor=record
    nombre:string;
    apellido:string;
    distancia:integer;
    tiempo:integer;
    pais:string;
    ciuPartida:string;
    ciuFinal:string;
  end;
  lista:^nodo;
  nodo=record
    dato:corredor;
    sig:lista;
  end;
procedure crearNodo(var lis:lista;co:corredor);
var
  nue:lista;
begin
  new(nue);
  nue^.dato:=co;
  nue^.sig:=lis;
end;
procedure leerCorredor(l:lista);
var
  c:corredor;
begin
  read(c.distancia);
  if(c.distancia<>-1)then
     readln(c.nombre);
     readln(c.apellido);
     readln(c.tiempo);
     readln(c.pais);
     readln(c.ciuPartida);
     readln(c.ciuFinal);
     readln(c.distancia);
  end;
  crearNodo(l,c);
end;
procedure minsxkm(list:lista;promedio:integer);
var
  suma,cant:integer;
begin
  suma:=0;
  cant:=0;
  if(list^.dato.ciuPartida='Boston')then begin
    suma:=suma+li^.dato.tiempo;
    cant:=cant+1;
  end;
  promedio:=suma div cant;
end;
procedure procesarInformacion(li:lista);
var
 suma,pasoPromedio,cantPartida,totalCorre,totalDis,timeTotal,canti,prome:integer;
begin
  cantPartida:=0;
  canti:=0;
  suma:=0;
  totalCorre:=0;
  totalDis:=0;
  timeTotal:=0;
  while(li<>nil)do begin
    totalCorre:=totalCorre+1;
    totalDis:=totalDis+li^.dato.distancia;
    timeTotal:=timeTotal+li^.dato.tiempo;
    if(li^.dato.ciuPartida='brasil')then begin
      suma:=suma+li^.dato.distancia;
      canti:=canti+1;
    if(li^.dato.ciuPartida<>li^.dato.ciuFinal)then
      cantPartida:=cantPartida+1;
    end;
    minsxkm(li,pasoPromedio);
    li:=li^.sig;
  end;
  prome:=suma div canti;
  writeln(prome);                               //Inciso C
  writeln(totalCorre,totalDis,timeTotal);       //Inciso A
  writeln(cantPartida);                         //Inciso D
  writeln(pasoPromedio);                        //Inciso E
end;
var
  l:lista;
begin
  l:=nil;
  leerCorredor(l);
  while(l^.dato.distancia<>-1)do begin
    procesarInformacion(l);
  end;
end;
   // falta inciso B de la ciudad que convoco mas corredores y demas... 
    
