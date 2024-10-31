program seis;
type 
  categoria=0..7;
  vector=array[1..7] of categoria;
  objeto=record
    codigoObjeto:integer;
    categoriaObjeto:categoria;
    nombreObjeto:string;
    distancia:integer;
    nombreD:string;
    anioDescubrimiento:integer;
  end;
  lista=^nodo;
  nodo=record
    dato:objeto;
    sig:lista;
  end;
procedure crearLista (ob:objeto;var list:lista);
var
 nue:lista;
begin
  new(nue);
  nue^.dato:=ob;
  nue^.sig:=list;
end;
procedure LeeyCarga(var lis:lista);
var
 o:objeto;
begin
  readln(o.codigoObjeto);
  while(o.codigoObjeto<>-1)do begin
    readln(o.categoriaObjeto);
    readln(o.nombreObjeto);
    readln(o.distancia);
    readln(o.nombreD);
    readln(o.anioDescubrimiento);
  end;
  crearLista(o,lis);
end;
procedure inicializar(var vec:vector);
var
  i:integer;
begin
  for i:=1 to 7 do begin
    vec[i]:=0;
  end;
end;
function descomponerObj(var li:lista):boolean;
var
  pares,impares:integer;
  cumple:boolean;
begin
  cumple:=false;
  pares:=0;
  impares:=0;
  while(li^.dato.codigoObjeto<>0)do begin
    li^.dato.codigoObjeto:=li^.dato.codigoObjeto mod 10;
    if(li^.dato.codigoObjeto=0)then
      pares:=pares+1
    else
      impares:=impares+1;
    li^.dato.codigoObjeto:=li^.dato.codigoObjeto div 10;
  end;
  if(pares>impares)then begin
    cumple:=true;
  end;
  descomponerObj:=cumple;
end;
procedure objxCategoria(vect:vector;est:string;li:lista);
var
  num:categoria;
begin
  inicializar(vect);
  repeat
      readln(num);
      vect[num]:=vect[num]+1;
      if((descomponerObj(li)=true)and(vect[num]=2))then
         est:=li^.dato.nombreObjeto;
  until(num=0);
end;
procedure masLejanos(liste:lista;masCod1,masCod2:integer);
var
  max1,max2:integer;
begin
  max1:=-1;
  max2:=-1;
  masCod1:=0;
  masCod2:=0;
  if(liste^.dato.distancia>max1)then begin
    max2:=max1;
    max1:=liste^.dato.distancia;
    masCod2:=masCod1;
    masCod1:=liste^.dato.codigoObjeto;
  end;
  if(liste^.dato.distancia>max2) then begin
    max1:=max2;
    max2:=liste^.dato.distancia;
    masCod1:=masCod2;
    masCod2:=liste^.dato.distancia;
  end;
end;
procedure Galileo(listo:lista;cant:integer);
begin
  cant:=0;
  if((listo^.dato.categoriaObjeto=2)and(listo^.dato.nombreD='Galileo Galilei')and(listo^.dato.aniodescubrimiento<1600))then
     cant:=cant+1;
end;
procedure imprimir(vecto:vector);
var
 i:integer;
begin
  for i:=1 to 7 do begin
    writeln(vecto[i]);
  end;
end;
procedure estrellasPares(listi:lista;estrellas:string);
var
  vec:vector;
begin
  inicializar(vec);
  objxCategoria(vec,estrellas,listi);
  writeln('Nombre de estrella que posee mas digitos pares que impares en su codigo de objeto:',estrellas);
end;
procedure reporte(lis:lista;maxCOD1,maxCOD2,Cantidad:integer);
var
  vecto:vector;
  nombreEstrella:string;
begin
  inicializar(vecto);
  while(lis<>nil)do begin
    masLejanos(lis,maxCOD1,maxCOD2);              //inciso A
    Galileo(lis,Cantidad);                              //inciso B
    objxCategoria(vecto,nombreEstrella,lis);  
    imprimir(vecto);                                        //inciso C
    estrellasPares(lis,nombreEstrella);                          //inciso D
    lis:=lis^.sig;
  end;
end;
var
  l:lista;
  CODmaximo1,CODmaximo2,Cantidad:integer;
begin
  l:=nil;
  CODmaximo1:=0;
  CODmaximo2:=0;
  Cantidad:=0;
  LeeyCarga(l);
  reporte(l,CODmaximo1,CODmaximo2,Cantidad);
  Writeln('codigos de los dos objetos mas lejanos de la tierra que se han observado:',CODmaximo1,CODmaximo2);
  writeln('cantidad de planetas descubiertos por Galileo Galilei antes del 1600:',Cantidad);
end.
