unit ARCH_PROPIETARIOS_2;
{$CODEPAGE UTF8}
interface

uses
  CRT, ARCH_PROPIETARIOS, ARBOLES, ARBOLES2, VERIFICACIONES;

PROCEDURE INICIALIZAR(VAR x:t_dato_prop);
PROCEDURE INGRESAR_DATOS (VAR x:t_dato_prop);
PROCEDURE CARGAR_DATOS (VAR a:t_archivo1; VAR raiz1,raiz2:T_punt_arbol);
PROCEDURE MOSTRAR_DATOS (x:t_dato_prop);
PROCEDURE MODIFICAR_ESTADO (VAR a:t_archivo1;pos:byte);
PROCEDURE MODIFICACION_PERSONAS (VAR a:t_archivo1; pos:T_punt_arbol);

PROCEDURE ALTA_BAJA(VAR A:t_archivo1; VAR raiz1,raiz2:T_punt_arbol);
PROCEDURE BUSQUEDA_EN_ARBOL(VAR a:t_archivo1; resp:byte;VAR pos,raiz1,raiz2:T_punt_arbol);
PROCEDURE ALTA_BAJA_LOGICA(VAR a:t_archivo1;pos:T_punt_arbol);

//PROCEDURE MODIFICAR_PROPIETARIOS
//PROCEDURE CONSULTA_PROPIETARIOS
implementation
{1 - CARGA CONTRIBUYENTES}
//INICIALIZAR CARGA
PROCEDURE INICIALIZAR(VAR x:t_dato_prop);
begin
  x.n_contribuyente:='';
  x.apellido:='';
  x.nombres:='';
  x.direccion:='';
  x.ciudad:='';
  x.dni:='';
  x.fecha_nac:='';
  x.telefono:='';
  x.email:='';
end;

//INGRESAR DATOS DE NUEVOS PROPIETARIOS
PROCEDURE INGRESAR_DATOS (VAR x:t_dato_prop);
var
  codigo,codigo2:byte;
begin
  INICIALIZAR(x);
  Repeat
  GOTOXY(35,6);
  Write('Ingrese numero de contribuyente: ');
  Readln(x.n_contribuyente);
  VERIFICACION_NUMEROS(x.n_contribuyente, codigo2);
  Until codigo2 = 0;

  Repeat
  GOTOXY(35,7);
  Write('Ingrese apellido: ');
  Readln(x.apellido);
  VERIFICACION_CADENA(x.apellido,codigo);
  Until codigo = 0;

  Repeat
  GOTOXY(35,8);
  Write('Ingrese nombre/s: ');
  Readln(x.nombres);
  VERIFICACION_CADENA(x.nombres,codigo);
  Until codigo = 0;

  GOTOXY(35,9);
  Write('Ingrese direccion: ');
  Readln(x.direccion);

  Repeat
  GOTOXY(35,10);
  Write('Ingrese ciudad: ');
  Readln(x.ciudad);
  VERIFICACION_CADENA(x.ciudad, codigo);
  Until codigo = 0;

  GOTOXY(35,12);
  Write('Ingrese fecha de nacimiento: ');
  Readln(x.fecha_nac);

  Repeat
  GOTOXY(35,13);
  Write('Ingrese numero de telefono: ');
  Readln(x.telefono);
  VERIFICACION_NUMEROS(x.telefono,codigo2);
  Until codigo2 = 0;

  GOTOXY(35,14);
  Write('Ingrese correo electronico: ');
  Readln(x.email);

end;

//CARGAR LOS DATOS INGRESADOS EN ARBOL
PROCEDURE CARGAR_DATOS (VAR a:t_archivo1; VAR raiz1,raiz2:T_punt_arbol);
var
  resp:char;
  x:t_dato_prop;
  resp1:string;
  num,codigo2:byte;
  pos:T_punt_arbol;
  y:T_dato_arbol;
begin
  clrscr;
  GOTOXY(35,6);
  Write('¿Desea cargar datos? (s/n): ');
  Readln(resp);
  VERIFICACION_RESPUESTA(resp);
  While (resp = 's') or (resp = 'S') do
  begin
    clrscr;
    Repeat
    GOTOXY(35,6);
    Write('Ingrese DNI: ');
    Readln(x.dni);
    VERIFICACION_NUMEROS(x.dni,codigo2);
    Until codigo2 = 0;
    BUSCAR(raiz1,x.dni,pos);
    If pos=nil then
       begin
         If (NOT ARBOL_LLENO(raiz1)) and (NOT ARBOL_LLENO(raiz2)) then
            begin
              ABRIR_PROPIETARIOS(a);
              INGRESAR_DATOS(x);
              x.estado:=true;
              x.posicion:=FILESIZE(a);
              y.clave:=x.dni;
              y.pos:=x.posicion;
              Seek(a,filesize(a));
              Write(a,x);
              AGREGAR(raiz1,y);
              y.clave:=x.apellido+x.nombres;
              AGREGAR(raiz2,y);
              clrscr;
              GOTOXY(35,6);
              Write ('¿Desea seguir cargando datos? (s/n): ');
              Readln(resp);
              VERIFICACION_RESPUESTA(resp);
              CERRAR_PROPIETARIOS(a);
            end;
       end
    Else
        begin
          clrscr;
          ABRIR_PROPIETARIOS(a);
          Seek(a,pos^.info.posicion);
          Read(a,x);
          GOTOXY(35,6);
          Write('La persona ya se encuentra cargada');
          MOSTRAR_DATOS(x);
          GOTOXT(35,18);
          Write('¿Que desea realizar?');
          If x.estado=true then
             begin
             GOTOXY(35,19);
             Write('1 - BAJA');
             end
          Else
            begin
            GOTOXY(35,19);
            Write('2 - ALTA');
            end;
          GOTOXY(35,20);
          Write('2 - MODIFICAR DATOS');
          GOTOXY(35,21);
          Write('3 - CARGAR NUEVO PROPIETARIO');
          GOTOXY(35,22);
          Write('0 - VOLVER');
          GOTOXY(35,23);
          Write('Ingrese opcion: ');
          Readln(resp1);
          VERIFICACION_RESPUESTA_2(resp1,num);
          CERRAR_PROPIETARIOS(a);
          Case num of
          1:MODIFICAR_ESTADO (a,pos);
          2:MODIFICACION_PERSONAS (a,pos);
          3:resp:='s';
          end;
        end;
  end;
end;

//MOSTRAR DATOS
PROCEDURE MOSTRAR_DATOS (x:t_dato_prop);
begin
  GOTOXY(35,7);
  Write('Numero de contribuyente: ', x.n_contribuyente);
  GOTOXY(35,8);
  Write('Apellido: ', x.apellido);
  GOTOXY(35,9);
  Write('Nombres: ', x.nombres);
  GOTOXY(35,10);
  Write('Direccion: ', x.direccion);
  GOTOXY(35,11);
  Write('Ciudad: ', x.ciudad);
  GOTOXY(35,12);
  Write('DNI: ',x.dni);
  GOTOXY(35,13);
  Write('Fecha de nacimiento: ', x.fecha_nac);
  GOTOXY(35,14);
  Write('Telefono: ', x.telefono);
  GOTOXY(35,15);
  Write('Correo electronico: ', x.email);
  GOTOXY(35,16);
  Write('Estado: ' x.estado);
end;

//MODIFICACION ESTADO (ALTA/BAJA) CUANDO SE ESTA CARGANDO DATOS
PROCEDURE MODIFICAR_ESTADO (VAR a:t_archivo1;pos:T_punt_arbol);
var
  x:t_dato_prop;
  resp:char;
begin
  clrscr;
  ABRIR_PROPIETARIOS(a);
  Seek(a,pos^.info.posicion);
  Read(a,x);
  If x.estado = true then
     begin
     MOSTRAR_DATOS(x);
     GOTOXY(35,18);
     Write('¿Confirma la baja? (s/n): ');
     Readln(resp);
     VERIFICACION_RESP_ALTA_BAJA(resp);
     If (resp = 's') or (resp = 'S') then
        begin
        x.estado:=false;
        Seek(a,pos^.info.posicion);
        Write(a,x);
        end;
     end
  Else
      begin
        MOSTRAR_DATOS(x);
        GOTOXY(35,18);
        Write('¿Confirma el alta? (s/n): ');
        Readln(resp);
        VERIFICACION_RESP_ALTA_BAJA(resp);
        If (resp = 's') or (resp = 'S') then
           begin
           x.estado:=true;
           Seek(a,pos^.info.posicion);
           Write(a,x);
           end;
      end;
      CERRAR_PROPIETARIOS(x);
end;

//MODIFICAR DATOS PROPIETARIOS CUANDO SE ESTA CARGANDO DATOS
PROCEDURE MODIFICACION_PERSONAS (VAR a:t_archivo1; pos:T_punt_arbol);
var
  cancelar:boolean
  resp:string;
  num,codigo:byte;
  x:t_dato_prop;
  resp1:char;
begin
  clrscr;
  cancelar:=false;
  GOTOXY(35,6);
  Write('1 - NUMERO DE CONTRIBUYENTE');
  GOTOXY(35,7);
  Write('2 - APELLIDO');
  GOTOXY(35,8);
  Write('3 - NOMBRE/S');
  GOTOXY(35,9);
  Write('4 - DIRECCION');
  GOTOXY(35,10);
  Write('5 - CIUDAD');
  GOTOXY(35,11);
  Write('6 - FECHA DE NACIMIENTO');
  GOTOXY(35,12);
  Write('7 - TELEFONO');
  GOTOXY(35,13);
  Write('8 - CORREO ELECTRONICO');
  GOTOXY(35,14);
  Write('0 - SALIR');
  GOTOXY(35,15);
  Write('Ingrese opcion: ');
  Readln(resp);
  VERIFICACION_RESP_MODIFICACION (resp,num);
  ABRIR_PROPIETARIOS(a);
  Seek(a,pos^.info.posicion);
  Read(a,x);
  clrscr;
  Case num of
  0:cancelar:=true;
  1:begin
    Repeat
      GOTOXY(35,6);
      Write('Ingrese nuevo numero de contribuyente: ');
      Readln(x.n_contribuyente);
      VERIFICACION_NUMEROS(x.n_contribuyente,codigo);
    Until codigo = 0;
  end;
  2:begin
    Repeat
      GOTOXY(35,6);
      Write('Ingrese nuevo apellido: ');
      Readln(x.apellido);
      VERIFICACION_CADENA(x.apellido,codigo);
    Until codigo = 0;
  end;
  3:begin
    Repeat
      GOTOXY(35,6);
      Write('Ingrese nuevo/s nombre/s: ');
      Readln(x.nombres);
      VERIFICACION_CADENA(x.nombres,codigo);
    Until codigo = 0;
  end;
  4:begin
    GOTOXY(35,6);
    Write('Ingrese nueva direccion: ');
    Readln(x.direccion);
  end;
  5:begin
    Repeat
    GOTOXY(35,6);
    Write('Ingrese nueva ciudad: ');
    Readln(x.ciudad);
    VERIFICACION_CADENA(x.ciudad, codigo);
    Until codigo = 0;
  end;
  6:begin
    GOTOXY(35,6)
    Write('Ingrese nueva fecha de nacimiento: ');
    Readln(x.fecha_nac);
  end;
  7:begin
    Repeat
    GOTOXY(35,6);
    Write('Ingrese nuevo numero de telefono: ');
    Readln(x.telefono);
    VERIFICACION_NUMEROS(x.telefono, codigo);
    Until codigo = 0;
  end;
  8:begin
    GOTOXY(35,6);
    Write('Ingrese nuevo correo electronico: ');
    Readln(x.email);
  end;
  end;

  If cancelar = false then
     begin
       clrscr;
       MOSTRAR_DATOS(x);
       GOTOXY(35,18);
       Write('¿Confirma las modificaciones realizadas? (s/n): ');
       Readln(resp1);
       VERIFICACION_RESPUESTA(resp1);
       If (resp1 = 's') or (resp1 = 'S') then
          begin
            Seek(a,pos^.info.posicion);
            Write(a,x);
          end;
     end;

  CERRAR_PROPIETARIOS(a);
end;

{2 - ALTA/BAJA}
//PROCEDIMIENTO BAJA/ALTA
PROCEDURE ALTA_BAJA(VAR A:t_archivo1; VAR raiz1,raiz2:T_punt_arbol);
var
  pos:T_punt_arbol;
  resp:string;
  num:byte;

begin
  clrscr;
  pos:= NIL;
  GOTOXY(35,6);
  Write('1 - ALTA/BAJA POR DNI');
  GOTOXY(35,6);
  Write('2 - ALTA/BAJA POR APELLIDO Y NOMBRE');
  GOTOXY(35,7);
  Write('0 - SALIR');
  GOTOXY(35,8);
  Write('Ingrese opcion: ');
  Readln(resp);
  VERIFICACION_RESPUESTA_3(resp,num);

  If num <> 0 then
     begin
       BUSQUEDA_EN_ARBOL(a,resp,pos,raiz1,raiz2)
       If pos = NIL then
          begin
            clrscr;
            GOTOXY(35,6);
            Write('No se encontro propietario');
            Readkey;
          end
       Else
           ALTA_BAJA_LOGICA(a,pos)
     end;
end;

//PROCEDIMIENTO BUSQUEDA PARA DAR DE ALTA/BAJA
PROCEDURE BUSQUEDA_EN_ARBOL(VAR a:t_archivo1; resp:byte;VAR pos,raiz1,raiz2:T_punt_arbol);
var
  codigo:byte;
  clave:string;
begin
  clrscr;
  If resp = 1 then
     begin
       Repeat
       GOTOXY(35,6);
       Write('Ingrese DNI: ');
       Readln(clave);
       VERIFICACION_NUMEROS(clave,codigo);
       Until codigo = 0;
       BUSCAR(raiz1,clave,pos)
     end
  Else
      begin
        Repeat
        GOTOXY(35,6);
        Write('Ingrese apellido: ');
        Readln(apellido);
        VERIFICACION_CADENA(apellido,codigo)
        Until codigo = 0;
        Repeat
        Write('Ingrese nombre/s: ');
        Readln(nom);
        VERIFICACION_CADENA(nom,codigo);
        Until codigo = 0;
        clave:=apellido+nom;
        BUSCAR(raiz2,clave,pos);
      end;
end;
--------------------------------------------------------------------------------
//PROCEDIMIENTO ALTA/BAJA LOGICA
PROCEDURE ALTA_BAJA_LOGICA(VAR a:t_archivo1;pos:T_punt_arbol);
var
  resp:string;
  num:byte;
  x:t_dato_prop;
  resp1:char;
begin
  clrscr;
  GOTOXY(35,6);
  Write('1 - ALTA');
  GOTOXY(35,7);
  Write('2 - BAJA');
  GOTOXY(35,8);
  Write('0 - SALIR');
  GOTOXY(35,9);
  Write('Ingrese opcion: ');
  Readln(resp);
  VERIFICACION_RESPUESTA_3(resp,num);
  ABRIR_PROPIETARIOS(a);
  Seek(a,pos);
  Read(a,x);
  clrscr;
  Case num of
  1:begin
    If x.estado = false then
       begin
       MOSTRAR_DATOS(x);
       GOTOXY(35,18);
       Write('¿Confirma el alta? (s/n): ');
       Readln(resp1);
       VERIFICACION_RESPUESTA(resp1);
       If (resp1 = 's') or (resp1 = 'S') do
          begin
           x.estado:=true;
           Seek(a,pos^.info.posicion);
           Write(a,x);
           end;
       end
    Else
      begin
        GOTOXY(35,6);
        Write('Este propietario ya se encuentra dado de alta');
        Readkey;
      end;
    end;

  2:begin
    If x.estado = false then
       begin
       MOSTRAR_DATOS(x);
       GOTOXY(35,18);
       Write('¿Confirma la baja? (s/n): ');
       Readln(resp1);
       VERIFICACION_RESPUESTA(resp1);
       If (resp1 = 's') or (resp1 = 'S') then
          begin
          x.estado:=false;
          Seek(a,pos^.info.posicion);
          Write(a,x);
          end;
       end
    Else
        begin
          GOTOXY(35,6);
          Write('Este propietario ya se encuentra dado de baja');
          Readkey;
        end;
    end;
  end;

  CERRAR_PROPIETARIOS(a);
end;

{3 - MODIFICAR CONTRIBUYENTES}

end.

