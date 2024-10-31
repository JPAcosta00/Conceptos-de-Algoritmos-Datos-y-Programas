program diez;
type
  culti=record 
    tipo:string;
    cantH:integer;
    cantM:integer;
  end;
  vector=array[1..20]of culti;
  empresa=record
    codigo:integer;
    nombre:string;
    EstoPriv:string;
    nCiudad:string;
    cultivos:vector;
    diml:integer;
   end;
  lista=^nodo;
  nodo=record
    dato:empresa;
    sig:lista;
  end;
procedure inicializa (var vec:vector);
var
  i:integer;
begin
  for i:=1 to 20 do 
    vec[i]:=0;
end;
procedure carga(var vecto:vector);
var
  i:integer;
  c:culti;
begin
  repeat
   readln(c.cantH);
   readln(c.tipo);
   readln(c.cantM);
  until(c.cantH=0);
  for i:=1 to 20 do 
    vecto[i]:=c;
end;
procedure lectura (var e:vector;dim:integer);
var 
  i:integer;
begin
  inicializa(e);
  carga(e);
  for i:=1 to dim do begin
    readln(e[i]);
  end;
end;
procedure leeInfo (var empre:empresa);
begin
  writeln('ingrese un codigo');
  readln(empre.codigo);
  while(empre.codigo<>-1) do begin
    writeln('ingrese un nombre');
    readln(empre.nombre);
    writeln('ingrese si es privada o estatal');
    readln(empre.EstoPriv);
    writeln('ingrese el nombre de la ciudad donde esta radicada');
    readln(empre.nCiudad);
    readln(empre.diml);
    lectura(empre.cultivos,empre.diml);
  end;
end;
procedure cargarLista (var lis:lista);
var
  em:empresa;
  nue:lista;
begin
  leeInfo(em);
  new(nue);
  nue^.dato:=em;
  nue^.sig:=lis;
end;
function posee(var cod:integer):boolean;
var 
  cumple:boolean;
  cant:integer;
begin
  cant:=0;
  cumple:=false;
  while(cod<>0)do begin
    if(cod mod 10=0)then
      cant:=cant+1;
    cod:=cod div 10;
  end;
  if(cant>=2)then 
     cumple:=true;
  posee:=cumple;
end;
procedure nombres(li:lista);
var
  nombresEmp:string;
begin
  if((li^.dato.nCiudad='San Miguel del Monte')and(li^.dato.cultivos='trigo')and(posee(li^.dato.codigo)=true))then
     nombresEmp:=li^.dato.nombre;
  writeln(nombresEmp);
end;
procedure masTiempo (ve:vector;le:lista;var nombreMaiz:string);
var 
  max,i:integer;
  nombreMaiz:string;
begin
  max:=-1;
  for i:=1 to 20 do begin
    if((ve[i].tipo='maiz')and(ve[i]>max))then begin
      max:=ve[i];
      nombreMaiz:=le^.dato.nombre;
    end;
  end;
end;
procedure procesarInformacion(var lis:lista);
var
  nomMaiz:string;
  vec:vector;
  cant,totalH,porcentaje:integer;
  aux:lista;
begin
  aux:=lis;
  cant:=0;
  totalH:=0;
  while(aux<>nil)do begin
    nombres(lis);                       //inciso B
    if(aux^.dato.cultivos='soja')then 
      cant:=cant+1;
    totalH:=totalH+1;
    lis:=lis^.sig;
    masTiempo(v,lis,nomMaiz);
    Incrementar(lis,v);                  //inciso E
  end;
  porcentaje:=cant*100 div totalH;
  writeln(cant,porcentaje);            //inciso C
  writeln(nomMaiz);                     //inciso D
end;
procedure Incrementar (var liste:lista;var vet:vector);
var 
  i:integer;
begin
  for i:=1 to 20 do begin
    if((vet[i].tipo='girasol')and(vet[i].cantH<5)and(liste^.dato.EstoPriv='privada'))then 
        vet[i].cantM:=vet[i].cantM+1;
end;
var
  l:lista;
begin
  l:nil;
  cargarLista(l);                          //inciso A
  procesarInformacion(l);
end.
