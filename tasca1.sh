#!/bin/bash

function MostrarDades {

	Titulo=`head -$i HBBQ0 | tail -1 | cut -d "," -f1` 
	Clasificacion=`head -$i HBBQ0 | tail -1 | cut -d "," -f2` 
	descripcion=`head -$i HBBQ0 | tail -1 | cut -d "," -f3` 
	ano=`head -$i HBBQ0 | tail -1 | cut -d "," -f4` 
	valoracionUsuarios=`head -$i HBBQ0 | tail -1 | cut -d "," -f5` 
	tamanoMuestra=`head -$i HBBQ0 | tail -1 | cut -d "," -f6`
	
	echo "*****************************************************************************"
	echo "*Títol:	"$Titulo
	echo "*Any: "$ano "	*Nivell de classificació:	"$Clasificacion
	echo "*Descripció:	"$descripcion
	echo "*Valoració dels usuaris: "$valoracionUsuarios"	*Mida de la mostra: "$tamanoMuestra
	echo "****************************************************************************"
}

liniesarxiu=`cut -d: -f1 HBBQO.csv | wc -l`

echo "--------------------------------------------------"
echo "1 - Listados de las películas del catálogo."
echo "--------------------------------------------------"
echo "1-1 Mostrar catálogo alfabético."
echo "1-2 Mostrar catálogo cronológico."
echo "1-3 Mostrar catálogo por valoración."
echo "0 Volver al menú anterior."

read -p "Selecciona una opción: " opcion

case $opcion in
	1)
		echo "" 
		cat HBBQO.csv | tail +3 | sort -t "," >> HBBQ0 
		liniesbones=`wc -l < HBBQO.csv` 
		i=1
		echo "*************** HBBQO: El Nostre catàleg alfabètic es: ********************"
		while [ $i -le $liniesbones ] 
		do 
			MostrarDades 
			let i=$i+1 
		done 
		echo "" 
		echo "Prem una tecla per continuar" 
		read tecla 
		rm HBBQ0;; 

esac
