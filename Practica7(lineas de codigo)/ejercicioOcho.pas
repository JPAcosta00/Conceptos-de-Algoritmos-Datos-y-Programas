program Ocho;
type
  subrango=1..7; 
  vector=array[1..7]of subrango;
  transferencias=record
    nOrigen:integer;
    dniOrigen:integer;
    nDestino:integer;
    dniDestino:integer;
    fecha:string;
    hora:integer;
    monto:real;
    motivo:vector;
  end;
  lista:^nodo;
  nodo=record
    dato:transferencias;
    sig:lista;
  end;
procedure insertarOrdenado (var nueva:lista;lis:lista);
var 
 nue,act,ant:lista;
begin
  new(nue);
  nue^.dato:=lis;
  nue^.sig:=nueva;
  act:=nueva;
  ant:=nueva
  while(act<>nil)and(ant^.dato.nOrigen<act^.dato.nOrigen)do begin
    act:=ant;
    act:=act^.sig;
  end;
  if(act=ant)then begin
    nueva:=nue;
  end;
  else
    ant^.sig:=nue;
    nue^.sig:=act;
end;
procedure CargarNueva(var nuev:lista;li:lista);
begin
  while (li<>nil)do begin
     if(nOrigen<>nDestino)then 
        insertarOrdenado(nuev,li);
     li:=li^.sig;
  end;
end;
function descomponeNum(numeroD:integer):boolean;
var 
 cumple:boolean;
 pares,impares:integer;
begin
  cumple:=false;
  pares:=0;
  impares:=0;
  while(numeroD<>0)do begin
    if(numeroD mod 10=0)then begin
      pares:=pares+1;
    end;
    else
      impares:=impares+1;
    numeroD:=numeroD div 10;
  end;
  if(impares>pares)then begin
    cumple:=true;
  end;
  descomponeNum:=cumple;
end;
procedure calcularMaxMotivo(var max:integer;v:vector);
var
  i:integer;
begin
  max:=-1;
  for i:=1 to 7 do begin
    if(v[i]>max)then
      max:=v[I];
  end;
end;
procedure procesarNueva(nuev:lista);
var
 mTotal:real;
 max:integer;
 cant:integer;
begin
  max:=-1;
  mTotal:=0;
  cant:=0;
  while(nuev<>nil)do begin
    mTotal:=mTotal+monto;
    calcularMaxMotivo(max,nuev^.dato.motivo);
    if((nuev^.dato.fecha='junio')and(descomponeNum(nuev^.dato.nDestino)=true))then begin
       cant:=cant+1;
    end;
    writeln(mTotal);            //inciso B
    mTotal:=0; 
    nuev:=nuev^.sig;
  end;
  writeln(cant);                //inciso  D
  writeln(max);                 //inciso C
end;
var 
 l,n:lista;
begin
  l:=nil;
  n:=nil;
  CargarNueva(n,l);             //inciso A
  procesarNueva(n);
end;
