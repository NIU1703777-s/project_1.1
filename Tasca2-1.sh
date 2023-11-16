#!/bin/bash

function MostrarDades {

	Titulo=`head -$i output.txt | tail -1 | cut -d "," -f1` 
	Clasificacion=`head -$i output.txt | tail -1 | cut -d "," -f2` 
	descripcion=`head -$i output.txt | tail -1 | cut -d "," -f3` 
	ano=`head -$i output.txt | tail -1 | cut -d "," -f4` 
	valoracionUsuarios=`head -$i output.txt | tail -1 | cut -d "," -f5` 
	tamanoMuestra=`head -$i output.txt | tail -1 | cut -d "," -f6`
	
	echo "*****************************************************************************"
	echo "*Títol:	"$Titulo
	echo "*Any: "$ano "	*Nivell de classificació:	"$Clasificacion
	echo "*Descripció:	"$descripcion
	echo "*Valoració dels usuaris: "$valoracionUsuarios"	*Mida de la mostra: "$tamanoMuestra
	echo "****************************************************************************"
}

lletra1="$2"
lletra2="$3"

while true
	do
		if [[ "$lletra1" > "$lletra2" ]]; then
			echo "Lletres no vàlides. La segona lletra ha de ser igual o superior a la primera."
			echo "Prem una tecla per tornar"
			read tecla
		else
			# Buscar el rango de títulos basado en las dos letras proporcionadas
			rang_titols=$(cat $1 | awk -F, '{print $1}' | grep -iE "^[$lletra1-$lletra2]")

			if [ -z "$rang_titols" ]; then
				echo "No s'han trobat pel·lícules en el rang de títols proporcionat."
				read -p "Prem una tecla per tornar"
			else
				echo "$rang_titols" | sort > titols.txt

				# Recorre las líneas y muestra aquellas que cumplen con el rango de títulos.
				i=1
				linies=$(wc -l < titols.txt)
				while [ "$i" -le "$linies" ]; do
				    titol=$(head -$i titols.txt | tail -1)
				    grep -i "^$titol" $1 >> output.txt
				    i=$((i + 1))
				done
				
				clear
				liniesbones=`wc -l < output.txt` 
				i=1
				echo "*************** HBBQO: El Nostre catàleg alfabètic es: ********************"
				while [ $i -le $liniesbones ] 
				do 
					MostrarDades 
					let i=$i+1 
				done 
				echo ""  
				rm output.txt titols.txt
			fi
		fi
		
		echo "Vols continuar cercant? (s/n)"
		read continuar

		if [ "$continuar" != "s" ]; then
			break
			
		else
			echo "Introdueix dues lletres (en ordre alfabètic):"
			read lletra1
			read lletra2
		fi		
done
