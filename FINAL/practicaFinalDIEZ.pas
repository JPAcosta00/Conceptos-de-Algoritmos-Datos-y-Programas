program ejFInal;
type
  cadena=string[50];
  
  cultivo=record
    tipo:cadena;
    cantH:integer;
    cantM:integer;
  end;
  
  vector=array[1..20]of cultivo;
  
  empresa=record
    codigo:integer;
    nombre:cadena;
    estado:cadena;
    ciudad:cadena;
    veCultivos:vector;
    dimen:integer;
  end;

  lista=^nodo;
  nodo=record
    dato:empresa;
    sig:lista;
  end;

procedure cargaEmpresas(var lis:lista);

  procedure leeEmpresa(var e:empresa);
  
    procedure cargaCultivos (var vec:vector;var dim:integer);
    
      procedure leeCultivo(var c:cultivo);
      begin
        readln(c.cantH);
        if(c.cantH <> 0)then begin
          readln(c.tipo);
          readln(c.cantM);
        end;
      end;
      
    var
      cul:cultivo;
    begin
      leeCultivo(cul);
      while(cul.cantH <> 0)do begin
         vec[dim]:=cul;
         dim:= dim+1;
         leeCultivo(cul);
      end;
    end;
    
  begin
    readln(e.codigo);
    if(e.codigo <> -1)then begin
      readln(e.nombre);
      readln(e.estado);
      readln(e.ciudad);
      e.dimen:=0;
      cargaCultivos(e.veCultivos,e.dimen);
    end;
  end;

  procedure agregaAdelante(var li:lista;empre:empresa);
  var
    nue:lista;
  begin
    new(nue);
    nue^.dato:=empre;
    nue^.sig:=li;
    li:=nue;
  end;
  
var
  em:empresa;
begin
  leeEmpresa(em);
  while(em.codigo <> -1)do begin
     agregaAdelante(lis,em);
     leeEmpresa(em);
  end;
end;

procedure procesaEmpresas(l:lista; var cantS:integer;var porcen:real;var nombreEmpresa:cadena);
  
  function buscaTrigo(v:vector;dl:integer):boolean;
  var
    control:boolean;
    pos:integer;
  begin
    pos:=0;
    control:= false;
    while(pos < dl)and(control = false)do begin
      if(v[pos].tipo = 'TRIGO')then
        control:=true 
      else
        pos:=pos+1; 
    end;
    buscaTrigo:=control;
  end;
  
  function descomponeCodigo(cod:integer):boolean;
  var
    dig:integer;
    cumple:boolean;
    ceros:integer;
  begin
    cumple:=false;
    ceros:=0;
    while(cod <> 0)do begin
      dig:=cod mod 10;
      if(dig = 0)then
        ceros:= ceros+1;
      cod:= cod div 10;
    end;
    if(ceros >= 2)then
      cumple:=true;
    descomponeCodigo:= cumple; 
  end;
  
  procedure calculaIncisoC(vc:vector;diml:integer;var canti:integer;var por:real);
  var
    total:integer;
    i:integer;
  begin
    total:=0;
    for i:= 1 to diml do begin
      if(vc[i].tipo = 'Soja')then 
         canti:= canti + vc[i].cantH;
      total:= total+vc[i].cantH;
    end;
    por:= canti*100/total;
  end;
  
  procedure calculaIncisoD(veC:vector;dimension:integer;nom:cadena;var laEmpresa:cadena);
  var
    i:integer;
    max:integer;
  begin
    max:=-1;
    for i:=1 to dimension do begin
      if(veC[i].tipo = 'MAIZ')then begin
         if(veC[i].cantM > max)then begin
            laEmpresa:=nom;
            max:=veC[i].cantM;
         end;
      end;
    end;
  end;
  
begin
  total:=0;
  while(l <> nil)do begin
    if(l^.dato.ciudad = 'San Miguel del Monte')and(buscaTrigo(l^.dato.veCultivos,l^.dato.dimen))and(descomponeCodigo(l^.dato.codigo))then
      writeln(l^.dato.nombre);
    calculaIncisoC(l^.dato.veCultivos,l^.dato.dimen,cantS,porce);
    calculaIncisoD(l^.dato.veCultivos,l^.dato.dimen,l^.dato.nombre,nombreEmpresa);
    l:=l^.sig;
  end;
end;

procedure incrementaMeses(var lisEmpresas:lista);

  procedure procesaGirasol(var vg:vector; log:integer);
  var
    i:integer;
  begin
    for i:= 1 to log do begin
      if(vg[i].tipo = 'GIRASOL')then begin
        if(vg[i].cantH < 5)then 
          vg[i].cantM:= vg[i].cantM+1;                             //incrementa en un mes.
      end;
    end;
  end;
  
begin
  while(lisEmpresas <> nil)do begin
    if(lisEmpresas^.dato.estado = 'PRIVADA')then 
       procesaGirasol(lisEmpresas^.dato.veCultivos,lisEmpresas^.dato.dimen);
    lisEmpresas:= lisEmpresas^.sig;
  end;
end;

var                                                                                         //programa principal
  list:lista;                                //4 bytes
  cantidadSoja:integer;                      //6 bytes
  porcentajeSoja:real;                       //10 bytes
  nombre:cadena;                             //51 bytes
begin                                   //MEMORIA ESTATICA = 71 bytes
  cantidadSoja:=0;
  porcentajeSoja:=0;
  list:=nil;
  cargaEmpresas(list);                                                                      //INCISO A
  procesaEmpresas(list,cantidadSoja,porcentajeSoja,nombre);                                 //INCISO B
  writeln(cantidadSoja,porcentajeSoja);                                                     //INCISO C
  writeln('Nombre de la empresa que dedica mas tiempo al cultivo de maiz: ', nombre);       //INCISO D
  incrementaMeses(list);                                                                    //INCISO E                                         
end.
