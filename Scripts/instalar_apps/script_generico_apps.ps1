# Ruta de la carpeta donde se encuentran los instaladores .exe
$instaladoresRuta = "C:\scripts\instalador_apps\apps"

# Buscar todos los instaladores .exe en la carpeta
$instaladores = Get-ChildItem -Path $instaladoresRuta -Filter "*.exe"

# Si hay instaladores, ejecutar cada uno de manera concurrente
if ($instaladores.Count -gt 0) {
    $procesos = @()  # Array para almacenar los procesos de instalación
    $timeout = 1800  # Tiempo máximo en segundos (30 minutos)
    
    # Ejecutar cada instalador en segundo plano
    foreach ($Instalador in $instaladores) {
        Write-Host "Iniciando instalación de $($Instalador.Name)..."
        
        # Ejecutar el instalador de manera silenciosa
        $proceso = Start-Process -FilePath $Instalador.FullName -ArgumentList "/quiet" -PassThru
        $procesos += $proceso
    }

    # Monitorear la ejecución de todos los instaladores con timeout
    foreach ($proceso in $procesos) {
        $elapsedTime = 0  # Tiempo transcurrido en segundos

        while (-not $proceso.HasExited -and $elapsedTime -lt $timeout) {
            Start-Sleep -Seconds 5
            $elapsedTime++
        }

        # Verificar si el proceso ha terminado o ha excedido el tiempo
        if ($proceso.HasExited) {
            Write-Host "$($proceso.ProcessName) ha finalizado."
        } else {
            Write-Host "El proceso $($proceso.ProcessName) no terminó dentro del tiempo esperado de 30 minutos."
            # Puedes agregar acciones adicionales aquí, como registrar un error o notificar al usuario
        }
    }

    Write-Host "Todas las instalaciones se han completado o alcanzaron el tiempo límite."
} else {
    Write-Host "No se encontraron instaladores en la ruta especificada."
}

# Terminología
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
