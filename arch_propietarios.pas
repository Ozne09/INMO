unit ARCH_PROPIETARIOS;
{$CODEPAGE UTF8}
interface
USES
  CRT;

CONST
  RUTA='C:\Users\danis\Downloads\UTN\Algoritmos\INMO\arch_propietarios.dat';
TYPE
    t_dato_prop=RECORD
      n_contribuyente:string[20];
      apellido:string[30];
      nombres:string[50];
      direccion:string[50];
      ciudad:string[50];
      dni:string[20];
      fecha_nac:string[10];
      telefono:string[20];
      email:string[50];
      estado:boolean;
      posicion:cardinal;
    end;
    t_archivo1=FILE OF t_dato_prop;
PROCEDURE ABRIR_PROPIETARIOS (VAR a:t_archivo1);
PROCEDURE CERRAR_PROPIETARIOS (VAR a:t_archivo1);

implementation

PROCEDURE ABRIR_PROPIETARIOS (VAR a:t_archivo1);
begin
  assign(a,RUTA);
  {$i-}
  reset(a);
  {$i+}
  If IOResult <> 0 then
     Rewrite(a);
end;

PROCEDURE CERRAR_PROPIETARIOS (VAR a:t_archivo1);
begin
  close(a);
end;
end.

