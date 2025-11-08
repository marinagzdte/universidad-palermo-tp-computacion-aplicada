#!/bin/bash

# Verificar si como argumento se pasa la palabra “help”
if [ "$1" == "help" ]; then
	if [ -e "/opt/scripts/help" ]; then
	   cat /opt/scripts/help
# En el archivo help se encontraría todo el texto de ayuda
		exit 0
	else
		echo "No hay ayuda."
		exit 1
	fi
# Valida si hay dos argumentos.
elif [ $# -ne 2 ]; then
	echo "El número de argumentos es incorrecto. Se deben pasar dos argumentos: la ruta de origen y la de destino del backup."
 	exit 1
fi

# # Validar que directorios de origen y destino estén disponibles
if [ ! -d "$1" ]; then
	echo "No existe el directorio de origen $1."
	exit 1
elif [ ! -d "$2" ]; then
 	echo "No existe el directorio de destino $2."
 	exit 1
fi

# # Fecha en formato ANSI (YYYYMMDD)
FECHA=$(date +%Y%m%d)

# # Nombre del archivo de backup
BACKUP=$(basename "$1")_bkp_$FECHA.tar.gz

# # Crear el backup
tar -czf "$2/$BACKUP" -C "$1" .
# tar herramienta de compresión y descompresión de archivos
# -c crea el archivo
# -z comprime
# -f especifica el nombre del archivo de salida
# -C cambia el directorio indicado antes de crear el archivo

# # Verificar si el backup se creó correctamente
if [ -f "$2/$BACKUP" ]; then
 	echo "Backup realizado correctamente."
	exit 0
else
 	echo "Hubo un error al realizar el backup."
 	exit 1
fi
