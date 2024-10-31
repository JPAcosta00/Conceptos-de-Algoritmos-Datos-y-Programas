program ejFinal;
type
  cadena=string[50];
  subRango=1..35;
  tematicas=array[subRango]of cadena;           //35 x 51 = 1785
  libro=record
    titulo:cadena;
    editorial:cadena;
    cantPaginas:integer;
    edicion:integer;
    cantVendido:integer;
    area:subRango;
  end;
  
  detalle=record
    titulo:cadena;
    area:subRango;
    cantPaginas:integer;
  end;
  lista=^nodo;
  nodo=record
    dato:detalle;
    sig:lista;
  end;

procedure cargaTematicas(var aTema:tematicas);             //se dispone

procedure procesaLibros(var lis:lista;var masVie:integer;var cantidad:integer;var total:integer;tem:tematicas);

  procedure leeLibro(var l:libro);
  begin
    readln(l.titulo);
    readln(l.editorial);
    readln(l.cantPaginas);
    readln(l.edicion);
    readln(l.cantVendido);
    readln(l.area);
  end;
  
  procedure agregaAdelante(var li:lista;titulo:cadena;area:cadena;pag:integer);
  var
    nue:lista;
  begin
    new(nue);
    nue^.dato.titulo:=titulo;
    nue^.dato.area:=area;
    nue^.dato.cantPaginas:=pag;
    nue^.sig:=li;
    li:=nue;
  end;
  
var
  lib:libro;
begin
  repeat 
    leeLibro(lib);
    if(lib.editorial = 'Planeta Libros')then begin
      cantidad:= cantidad + 1;
      if(lib.edicion < masVie)then
        masVie:=lib.edicion;
      if(lib.cantVendido > 250)then
        agregaAdelante(lis,lib.titulo,tem[lib.area],lib.cantPaginas); 
    end;
    total:= total + lib.cantVendido;
  until(lib.titulo = 'Relato de un Naufrago');
end;

var                                                                            //programa principal
  tema:tematicas;                              //1785 bytes
  list:lista;                                  //4 bytes
  masViejo:integer;                            //6 bytes
  cantEditados:integer;                        //6 bytes
  totalVentas:integer;                         //6 bytes
begin                                          //MEMORIA ESTATICA = 1807 bytes.
  totalVentas:=0;
  cantEditados:=0;
  masViejo:=0;
  list:=nil;
  cargaTematicas(tema);                                                         //se dispone
  procesaLibros(list,masViejo,cantEditados,totalVentas,tema);
end.
