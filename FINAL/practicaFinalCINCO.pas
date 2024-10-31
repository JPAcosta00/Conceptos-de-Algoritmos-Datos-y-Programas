program ejFInal;
type
  subCamion=1..100;
  cadena=String [45];
  camion=record
    patente:cadena;           //46 bytes
    año:integer;              //6 bytes 
    capacidad:real;           //10 bytes
  end;
  vector=array[1..100]of camion;     //6200
  viaje=record
    codigoViaje:integer;
    codigoCamion:subCamion;
    distancia:real;
    ciudadDestino:cadena;
    año:integer;
    dniChofer:integer;
  end;
  lista=^nodo;
  nodo=record
    dato:viaje;
    sig:lista;
  end;
  info=record
    patente:cadena;            //46 bytes
    km:real;                   //10 bytes
  end;
  contador=array[subCamion]of info;     //5600
  
procedure cargaVector(var vecte:vector);                      //se dispone

procedure inicializa(var vcontador:contador);
var
  i:subCamion;
begin
  for i:=1 to 100 do 
    vcontador[i].km:=0;
end;

procedure cargaInformacion(var lis:lista);

  procedure leeViaje(var v:viaje);
  begin
    readln(v.codigoViaje);
    if(v.codigoViaje <> -1)then begin
      readln(v.codigoCamion);
      readln(v.distancia);
      readln(v.ciudadDestino);
      readln(v.año);
      readln(v.dniChofer);
    end;
  end;

  procedure agregaAdelante(var li:lista; vi:viaje);
  var
    nue:lista;
  begin
    new(nue);
    nue^.dato:=vi;
    nue^sig:=li;
    li:=nue;
  end;
  
var
  via:viaje;
begin
  leeViaje(via);
  while(via.codigoViaje <> -1)do begin
     agregaAdelante(lis,via);
     leeViaje(via);
  end;
end;
procedure procesaInformacion(l:lista;var vec:contador;tabla:vector,var canti:integer);

  function descompone(docu:integer):boolean;
  var
    impar:integer;
    cumple:boolean;
    dig:integer;
    cant:integer;
    control:boolean;
  begin
    control:=true;
    cumple:=false;
    impar:=0;
    while(docu <> 0)and(control = true)do begin
       cant:=cant+1;
       dig:=docu mod 10;
       if(dig mod 2 <> 0)then
         impar:= impar+1
       else
         control:=false;
       docu:= docu div 10;
    end;
    if(impar = cant)then
      cumple:=true;
    descompone:=cumple;
  end;
  
var
   diferencia:integer;
begin
   while(l <> nil)do begin
     vec[l^.dato.codigoCamion].patente:= tabla[l^.dato.codigoCamion].patente;
     vec[l^.dato.codigoCamion].km:=vec[l^.dato.codigoCamion].km + l^.dato.distancia;
     
     diferencia:= l^.dato.año - tabla[l^.dato.codigoCamion].año;
     
     if(tabla[l^.dato.codigoCamion].capacidad > 30.5)and(diferencia > 5)then
       canti:= canti+1;
       
     if(descompone(l^.dato.dniChofer))then 
       writeln('Codigo de viaje realizado por chofer con solo digitos impares en su dni: ' , l^.dato.codigoViaje); 
     l:=l^.sig;
   end;
end;

procedure calculaMasRecorrido(vc:contador; var caMas,caMenos:cadena);
var
  max:integer;
  min:integer;
  i:subCamion;
begin
  max:=-1;
  min:=9999;
  for i:= 1 to 100 do begin
    if(vc[i].km > max)then begin
       caMas:=vc[i].patente;
       max:=vc[i].km;
    end;
    if(vc[i].km < min)then begin
       caMenos:=vc[i].patente;
       min:=vc[i].km;
    end;
  end;
end;
var                                                                       //programa principal
  list:lista;                            //4 bytes
  vecto:vector;                          //6200 bytes
  cont:contador;                         //5600 bytes
  camionMas,camionMenos:cadena;          //92 bytes
  cantidad:integer;                      //6 bytes
begin                                    //MEMORIA ESTATICA = 11902 bytes
  cantidad:=0;
  list:=nil;
  inicializa(cont);
  cargaVector(vecto);                                                         //se dispone
  cargaInformacion(list);
  procesaInformacion(list,cont,vecto,cantidad);                     
  calculaMasRecorrido(cont,camionMas,camionMenos);
  writeln('Patente del camion que mas recorrido posee: ', camionMas);
  writeln('Patente del camion que menos recorrido posee: ', camionMenos);                     
  writeln('Cantidad de viajes con mas de 30.5 toneladas y mayores a 5 años: ', cantidad);   
end.
