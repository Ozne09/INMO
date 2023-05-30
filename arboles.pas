unit ARBOLES;
{$CODEPAGE UTF8}

interface
uses
  CRT;
type
  T_dato_arbol=RECORD
    clave:string[50]; //La clave sera dni y nombre
    pos:cardinal;
  end;
  T_punt_arbol=^T_nodo_arbol;
  T_nodo_arbol=RECORD
    info:T_dato_arbol;
    sai,sad:t_punt_arbol;
  end;
PROCEDURE CREAR_ARBOL(VAR raiz:T_punt_arbol);
PROCEDURE AGREGAR(VAR raiz:T_punt_arbol; x:T_dato_arbol);
FUNCTION ARBOL_VACIO(VAR raiz:T_punt_arbol):boolean;
FUNCTION ARBOL_LLENO(VAR raiz:T_punt_arbol):boolean;

implementation
PROCEDURE CREAR_ARBOL(VAR raiz:T_punt_arbol);
begin
  raiz:=NIL;
end;
//AGREGAR AL ARBOL
PROCEDURE AGREGAR(VAR raiz:T_punt_arbol; x:T_dato_arbol);
begin
  If raiz=NIL then
  begin
    new(raiz);
    raiz^.info:=x;
    raiz^.sai:=NIL;
    raiz^.sad:=NIL;
  end
  Else
      If raiz^.info.clave > x.clave then
      AGREGAR(raiz^.sai,x)
      Else
        AGREGAR(raiz^.sad,x);
end;
//ARBOL VACIO
FUNCTION ARBOL_VACIO(VAR raiz:T_punt_arbol):boolean;
begin
  ARBOL_VACIO:=raiz=NIL;
end;
//ARBOL LLENO
FUNCTION ARBOL_LLENO(VAR raiz:T_punt_arbol):boolean;
begin
  ARBOL_LLENO:=GETHEAPSTATUS.TOTALFREE<SIZEOF(T_nodo_arbol);
end;

end.
