program ejFinal;
type
  cadena=string[60];
  subCategorias=1..7;
  objeto=record
    codigo:integer;
    categoria:subCategorias;
    nombre:cadena;
    distancia:integer;
    descubridor:cadena;
    año:integer;
  end;
  lista=^nodo;
  nodo=record
    dato:objeto;
    sig:lista;
  end;
  vector=array[subCategorias]of integer;   //42 bytes

procedure inicializa(var vec:vector);
var
  i:subCategorias;
begin
  for i:=1 to 7 do 
    vec[i]:=0;
end;
  
procedure cargaObjetos(var lis:lista);

  procedure leeObjeto(var o:objeto);
  begin
    readln(o.codigo);
    if(o.codigo <> -1)then begin
      readln(o.categoria);
      readln(o.nombre);
      readln(o.distancia);
      readln(o.descubridor);
      readln(o.año);
    end;
  end;
  
  procedure agregaAtras(var li,ult:lista;ob:objeto);
  var
    nue:lista;
  begin
    new(nue);
    nue^.dato:=ob;
    nue^.sig:=nil;
    if(l <> nil)then
      ult^.sig:=nue
    else
      l:=nue;
    ult:=nue;
  end;

var
  obj:objeto;
begin
  leeObjeto(obj);
  while(obj.codigo <> -1)do begin
     agregarAtras(lis,obj);
     leeObjeto(obj);
  end;
end;  

procedure procesaInformacion(l:lista;var cod1,cod2:integer; var cantG:integer;var v:vector);

  procedure calculaMasLejos(dis:integer;codi:integer;var co1,co2:integer;var mas1,mas2:integer);
  begin
    if(dis > mas1)then begin
      co2:=co1;
      co1:=codi;
      mas2:=mas1;
      mas1:=dis;
    end
    else begin
      if(dis > mas2)then begin
        co2:=codi;
        mas2:=dis;
      end;
    end;
  end;
  
  function descompone(co:integer):boolean;
  var
    par:integer;
    impar:integer;
    dig:integer;
    cumple:boolean;
  begin
    cumple:=false;
    par:=0;
    impar:=0;
    while(co <> 0)do begin
      dig:=co mod 10;
      if(dig mod 2 = 0)then 
         par:= par+1
      else 
         impar:= impar+1;
      co:=co div 10;
    end;
    if(par > impar)then
       cumple:=true;
    descompone:=cumple;
  end;
  
var
  max1,max2:integer;
begin
  max1:=-1;
  max2:=-1;
  while(l<>nil)do begin
    calculaMasLejos(l^.dato.distancia,l^.dato.codigo,cod1,cod2,max1,max2);
    if(l^.dato.descubridor = 'Galileo Galilei')and(l^.dato.año < 1600)then
       cantG:= cantG+1;
    v[l^.dato.categoria]:=v[l^.dato.categoria]+1;
    if(l^.dato.categoria = 1)then begin 
      if(descompone(l^.dato.codigo))then
        writeln(l^.dato.nombre);
    end;
    l:=l^.sig;
  end;
end;

procedure imprimeIncisoB3(ve:vector);
var
  i:subCategorias;
begin
  for i:=1 to 100 do 
    writeln('Categoria ', i, ' objetos observados: ', ve[i]);
end;

var                                                                                                            //se dispone
   list:lista;                          //4 bytes 
   vecto:vector;                        //42 bytes
   cantidadGalileo:integer;             //6 bytes
   codigo1,codigo2:integer;             //6 bytes
begin                                  //MEMORIA ESTATICA = 58 bytes
  cantidadGalileo:=0;
  list:=nil;
  inicializa(vecto);
  cargaObjetos(list);                                                                                            //inciso A
  procesaInformacion(list,codigo1,codigo2,cantidadGalileo,vecto);                                                //inciso B4
  writeln('Codigo de los dos objetos mas lejanos de la tierra que se hayan observados: ',codigo1,codigo2);       //inciso B1
  writeln('Cantidad de planetas descubiertos por Galileo Galilei antes del 1600: ', cantidaGalileo);             //inciso B2
  imprimeIncisoB3(vecto);                                                                                        //inciso B3
end.
