#! /bin/bash
#
#   Este script realiza la actualización de uno o más 
# equipos de forma remota mediante una conexión SSH.
# 
#   Para ejecutarlo de forma exitosa se deben configurar
# previamente las máquinas para que un usuario no root
# llamado "actualizacion" tenga permisos de ejecucion 
# para /usr/bin/apt-get.
#   Además dicho usuario no necesitará password para 
# ejecutar sudo.
#
#
# AUTORAS: Laura Sánchez - Alicia Santana
# GRUPO: Jacarandá
# Mayo 2013
#
#
# Tomamos el primer campo
# del archivo proporcionado como parámetro, que
# corresponde al nombre de host.
#
CONTADOR1=0
for variable in `cut -f1 -d: < $1` 
do
# Obtenemos el segundo campo, que corresponde a la IPV4
# 
CONTADOR2=0
for variable2 in `cut -f2 -d: < $1` 
do
# nos aseguramos de que ambas pertenezcan a la misma línea del archivo
#
if [ $CONTADOR1 =  $CONTADOR2 ]
then
# intentamos realizar la conexión ssh con el usuario que hemos configurado
# en el archivo sudoers, para realizar esta tarea en todos los equipos,
# y le pasamos el comando a ejecutar 
# la opcion -t activa un seudo terminal para este proceso
# 
# primero intentamos con dominio
#
ssh -t actualizacion@$variable sudo apt-get update
#
# si no es exitosa la ejecución...
if [ $? != 0 ]
then
# intentamos acceder por la ip proporcionada
#
ssh -t actualizacion@$variable2 sudo apt-get update
fi
# una vez actualizado se cierra automáticamente la conexión
#
fi
CONTADOR2=`expr $CONTADOR2 + 1`
done
CONTADOR1=`expr $CONTADOR1 + 1`
done
#finalizamos la ejecución del script
exit
