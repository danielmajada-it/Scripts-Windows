
INSTALADOR AUTOMÁTICO DE APLICACIONES
=====================================

Este script automatiza la instalación de múltiples aplicaciones en un sistema Windows. Solo necesitas colocar los instaladores en la ruta C:\scripts\instalador_apps\apps, y ejecutar el script. Recuerda que es el archivo acabado en .ps1

---

REQUISITOS PREVIOS
------------------
1. Windows PowerShell:
  

2. Permitir ejecución de scripts:
   	# En caso de tener bloqueado el uso de script, utilizar el siguiente comando como adinistrador del terminal.
  
   	Set-ExecutionPolicy -Scope CurrentUser RemoteSigned
   

3. Estructura de carpetas:
   	# Al descomprimir en el disco C, ya debería estar todo en los directorios correctos. De no ser así, es necesario seguir la siguiente estructura:
   
   - Coloca los instaladores `.exe` dentro de esta ruta:
     C:\scripts\instalador_apps\apps
   
   - Coloca el script en:
     C:\scripts\instalador_apps


CÓMO UTILIZAR
---------
1. Preparar losinstaladores:

   - Coloca los instaladores (*.exe) en la carpeta `apps`(C:\scripts\instalador_apps\apps).
   - No es necesario renombrar los archivos; el script detectará todos los `.exe` automáticamente.

2. Ejecutar el script:
   
   - Abre PowerShell y navega a la carpeta donde está el script:
     
     cd C:\scripts\instalador_apps
     
   - Ejecuta el script:
     
     .\InstalarAplicaciones.ps1
     

3. Seguimiento:
   
   # El script realiza las siguientes acciones:
   
   - Busca todos los archivos `.exe` en la carpeta `apps`.
   - Ejecuta cada instalador en modo silencioso (`/quiet`). Deno existir tal funcion en el instalador, lanzará la interfaz de instalación.
   - Monitorea cada proceso y verifica si finaliza correctamente o si supera el tiempo límite (30 minutos).



CARACTERÍSTICAS
---------------

- Instalaciones concurrentes: Ejecuta múltiples instaladores al mismo tiempo.
- Monitoreo automático: Cada instalador es monitoreado por hasta 30 minutos. Si no finaliza, se informa del fallo.
- Sin renombrar: No necesitas renombrar los archivos; el script detecta cualquier instalador `.exe` en la carpeta.



CONFIGURACIÓN AVANZADA
----------------------

# Para personalizar el comportamiento del script, puedes modificar estas variables dentro del código:

- `instaladoresRuta`: Cambia la ruta donde se buscan los instaladores.
- `timeout`: Modifica el tiempo máximo (en segundos) permitido para que un instalador termine. Ten encuenta que instaladores como el de Office pueden tardar bastante tiempo. Si el timeout llega a 0, se cortara la instalación aunque esta este funcionando. Es más bien una medida para evitar que instalaciones fallidas se queden indefinidamente comiendo recurso del sistema.
- `Start-Sleep`: Cambia el tiempo entre comprobaciones (por defecto, cada 5 segundos).


ERRORES COMUNES
---------------

1. Error: "Execution of scripts is disabled"
   
   # No esta permitido ejecutar scripts
   
   - Solución, siendo administrador, configura la política de ejecución con:
     
     Set-ExecutionPolicy -Scope CurrentUser RemoteSigned
     

2. El instalador no finaliza dentro del tiempo límite
   
   - Razón: Algunos instaladores pueden requerir interacción manual o exceder el tiempo límite.
   - Solución: Intenta ejecutar manualmente el instalador afectado.

3. No se encontraron instaladores en la ruta especificada
   
   - Razón: No hay archivos `.exe` en la carpeta `apps`.
   - Solución: Verifica que los instaladores estén en la carpeta correcta y no se haya modificado el nombre para no incluir .exe



DETALLES TÉCNICOS
-----------------

1. Tecnologías Usadas:
   
   - PowerShell: Herramienta de automatización de Microsoft.

2. Comandos Clave y terminología:
 
  # Get-ChildItem : para buscar. Al utilizar *.exe, le indicamos que busque todos los archivos que acaben en .exe
  # $archivosInstaladores.Count -gt 0 : para comprobar que el numero de instaladores sea mayor a 0
    # $archivosInstaladores : variable que almacena el resultado de Get-ChildItem
    # $archivosInstaladores.Count : .Count se utiliza en arrays, listas y colecciones. En este caso una coleeción de archivos .exe
    # -gt : significa mayor que. En este caso mayor que 0
  # Start-Process : para ejecutar el instalador.
    # Al usar -ArgumentList, podremos utilizar otros argumentos junto a Star-Process
      # -PassThru : asigna al instalador un objeto que contiene información acerca del proceso en ejecución
      # /quiet : para hacer la instalación en modo silencioso
      # -Wait : para esperar a que termine el proceso
  # Start-Sleep -Seconds : Tiempo entre cada comprobación del estado del script. En este caso es de 5 segundos. Sirve para no saturar
  # Test-Path : verifica que el archivo exista antes de ejecutarlo
  # Write-Host : para dirigir el OutPut al terminal

AUTOR
-----
Creado por Daniel Majada. Este script es un recurso para automatizar instalaciones en entornos Windows.

---

NOTAS
-----
Este script está diseñado para simplificar el proceso de instalación. Sin embargo, revisa siempre los instaladores antes de ejecutarlos para evitar problemas de seguridad.
