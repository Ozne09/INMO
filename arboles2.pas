unit ARBOLES2;
{$CODEPAGE UTF8}
interface
uses
  CRT, ARBOLES;

FUNCTION PREORDEN(VAR raiz:T_punt_arbol; buscado:string):T_punt_arbol;
PROCEDURE BUSCAR (VAR raiz:T_punt_arbol;buscado:string; VAR pos:T_punt_arbol);

implementation
FUNCTION PREORDEN (VAR raiz:T_punt_arbol; buscado:string):T_punt_arbol;
begin
  If (raiz=NIL) then
     PREORDEN:= NIL
     Else
       If (raiz^.info.clave = buscado)then
          PREORDEN:=raiz
          Else
            If raiz^.info.clave > buscado then
               PREORDEN:=PREORDEN(raiz^.sai,buscado)
               Else
                 PREORDEN:=PREORDEN(raiz^.sad,buscado);
end;

PROCEDURE BUSCAR (VAR raiz:T_punt_arbol; buscado:string; VAR pos:T_punt_arbol);
begin
  pos:= preorden(raiz,buscado);
end;


end.

