unit VERIFICACIONES;
{$CODEPAGE UTF8}
interface
USES
CRT, ARCH_PROPIETARIOS;

PROCEDURE VERIFICACION_CADENA (texto:string; VAR codigo:byte);
PROCEDURE VERIFICACION_NUMEROS (numero:string; VAR codigo2:byte);
PROCEDURE VERIFICACION_RESPUESTA (VAR resp:char);
PROCEDURE VERIFICACION_RESPUESTA_2(resp:string; VAR num:byte);
PROCEDURE VERIFICACION_RESP_ALTA_BAJA(VAR resp:char);
PROCEDURE VERIFICACION_RESP_MODIFICACION (resp:string; VAR num:byte);
PROCEDURE VERIFICACION_RESPUESTA_3(resp:string; VAR num:byte);

implementation
PROCEDURE VERIFICACION_CADENA (texto:string; VAR codigo:byte);
var
pos:byte;
cod,num:integer;
begin
  codigo:=0;
  pos:=1;
  cod:=0;
  while (pos <> length(texto)+1) or (codigo=0) do;
  begin
       val(texto[pos],num,cod);
          If cod=0 then
             codigo:=1;
       pos:= pos + 1;
  end;
end;

PROCEDURE VERIFICACION_NUMEROS (numero:string; VAR codigo2:byte);
var
num:integer;
begin
  codigo2:=0;
  val(numero,num,codigo2);{SE DESARROLLA DE MANERA DISTINTA PORQUE EL PROCEDIMIENTO VAL ES PARA VERIFICAR QUE
                           NO SE ENCUENTREN LETRAS EN NUMEROS}
end;

PROCEDURE VERIFICACION_RESPUESTA (VAR resp:char);
begin
  while (resp <> 's') and (resp <> 'S') and (resp <> 'n') and (resp <> 'N') do
  begin
    GOTOXY(35,6);
    Write ('La respuesta ingresada es incorrecta');
    GOTOXY(35,7);
    Write ('Intente nuevamente: ');
    Readln(resp);
  end;
end;

PROCEDURE VERIFICACION_RESPUESTA_2(resp:string; VAR num:byte);
var
codigo:byte;
begin
  codigo:=0;
  val(resp,num,codigo);
  While (num>3) or (codigo <> 0) do
  begin
    GOTOXY(35,27);
    Write('La respuesta ingresada es incorrecta');
    GOTOXY(35,28);
    Write('Intente nuevamente: ');
    Readln(resp);
    codigo:=0;
    val(resp,num,codigo);
  end;
end;

PROCEDURE VERIFICACION_RESP_ALTA_BAJA(VAR resp:char);
begin
  While (resp <> 's') and (resp <> 'S') and (resp <> 'n') and (resp <> 'N') do
  begin
    GOTOXY(35,20);
    Write('La respuesta ingresada es incorrecta');
    GOTOXY(35,21);
    Write('Intente nuevamente: ');
    Readln(resp);
  end;
end;

PROCEDURE VERIFICACION_RESP_MODIFICACION (resp:string; VAR num:byte);
var
   codigo:byte;
begin
   codigo:=0;
   val(resp,num,codigo);
   While (num > 8) or (codigo <> 0) do
   begin
     GOTOXY(35,16);
     Write('La respuesta ingresada es incorrecta');
     GOTOXY(35,17);
     Write('Intente nuevamente: ');
     Readln(resp);
     codigo:=0;
     val(resp,num,codigo);
   end;
end;

PROCEDURE VERIFICACION_RESPUESTA_3(resp:string; VAR num:byte);
var
   codigo:byte;
begin
  codigo:=0;
  val(resp,num,codigo);
  While (num > 2) or (codigo <> 0) do
  begin
    GOTOXY(35,9);
    Write('La respuesta ingresada es incorrecta');
    GOTOXY(35,10);
    Write('Intente nuevamente: ');
    Readln(resp);
    codigo:=0;
    val(resp,num,codigo);
  end;
end;

end.

