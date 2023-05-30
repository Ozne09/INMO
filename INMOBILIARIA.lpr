program INMOBILIARIA;
{$CODEPAGE UTF8}
USES
    CRT, ARCH_PROPIETARIOS, ARCH_TERRENOS, ARBOLES, ARBOLES2,
    ARCH_PROPIETARIOS_2, VERIFICACIONES;
CONST
     RUTA='C:\Facu\1er año facu\Algoritmos\Trabajo Final Algoritmos\INMO';

VAR
  a:t_archivo1;       //a simboliza propietarios
  arch:t_archivo2;    //t_dato de terrenos
  raiz:T_punt_arbol;
  x:t_dato_prop;      //datos de los propietarios
begin
  CARGAR_PROPIETARIOS(x);
  readkey;
end.

