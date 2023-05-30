unit ARCH_TERRENOS;
{$CODEPAGE UTF8}

interface
USES
  CRT;

CONST
  ruta='C:\Users\danis\Downloads\UTN\Algoritmos\INMO\ARCH_TERRENOS.dat';
TYPE
    t_dato_terrenos=RECORD
        n_contribuyente:string[50];
        n_plano:string[50];
        avaluo:real;
        fec_inscripcion:string[20];
        dom_parcelario:string[100];
        sup_terreno:real;
        zona:byte;
        tip_edificacion:byte;
      end;
t_archivo2=FILE OF t_dato_terrenos;

PROCEDURE ABRIR_TERRENOS (VAR arch: t_archivo2);
PROCEDURE CERRAR_TERRENOS (VAR arch: t_archivo2);
implementation
PROCEDURE ABRIR_TERRENOS (VAR arch: t_archivo2);
begin
  assign(arch,ruta);
  {$i-}
  reset(arch);
  {$i+}
  If IOResult <> 0 then
     Rewrite(arch);
end;

PROCEDURE CERRAR_TERRENOS (VAR arch:t_archivo2);
begin
  close(arch);
end;

end.

