Proceso Ferreteria_el_tornillo_loco
	
	Definir i,j,k,l Como Entero 							// variables para for
	Definir ferreteria,ferr_aux Como Caracter 			// arreglos
	
	Definir long,valido,cant_art,suma Como Entero 		// validar que no sea letra
	Definir valor_pedido,letra,cantidad_articulos,code,descripcion Como Caracter
	
	Definir INICIO Como caracter
	
	Definir bool Como Logico
	Definir bool_stock Como Logico
	bool_stock = Falso
	bool = Falso
	i = 0
	j = 0
	k = 0
	
	Escribir "BIENVENIDO AL PROGRAMA DE"
	Escribir "   EL TORNILLO LOCO"
	Escribir ""
	
	Escribir "1. CARGAR ARREGLO FERRETERIA"
	Escribir "2. VER ARREGLO YA CARGADO"
	
	Repetir
		leer INICIO
		long = Longitud(INICIO)
		
		si (long == 1) Entonces
			
			valido = 1
			Para i=0 Hasta long-1 Con Paso 1 Hacer
				
				letra = Subcadena(INICIO,i,i)
				si (letra <> "1") y (letra <> "2") Entonces
					Escribir "CARACTER INCORRECTO [ ", letra," ]"
					valido = 0
					i = long-1
				FinSi
			Fin Para
		SiNo
			Escribir "OPCION INCORRECTA"
			valido = 0
		FinSi
	Mientras Que valido = 0
	
	si inicio == "1" Entonces
		
		// PEDIR CANTIDAD DE ARTICULOS VALIDAD SIN LETRAS
		Repetir
			
			Escribir "Cuantos articulos tiene la ferreteria: "
			leer cantidad_articulos
			
			long = Longitud(cantidad_articulos)
			si (long > 0) Entonces
				
				valido = 1
				Para i=0 Hasta long-1 Con Paso 1 Hacer
					
					letra = Subcadena(cantidad_articulos,i,i)
					si (letra < "0") o (letra > "9") Entonces
						Escribir "CARACTER INCORRECTO [ ", letra," ]"
						valido = 0
						i= long-1
					FinSi
				Fin Para
				
			SiNo
				Escribir "OPCION INCORRECTA"
				valido = 0
			FinSi
			
		Mientras Que valido = 0
		cant_art = ConvertirANumero(cantidad_articulos)
		
		// si o si 5 articulos 1 para cada rubro
		
		Dimension ferreteria[cant_art,6]
		dimension ferr_aux[cant_art,6]
		
		// CARGAR ARREGLO FERRETRIA VALIDANDO CADA DATO
		Para i=0 Hasta ConvertirANumero(cantidad_articulos)-1 Con Paso 1 Hacer
			Para j=0 Hasta 5 Con Paso 1 Hacer
				Segun j Hacer
					0: 
						Escribir "INGRESE EL CODIGO DEL ARTICULO ", i+1
						code = validar_codigo(i)
						ferreteria[i,0] = code 		// validar que el codigo tenga el rubro correcto
					1:
						Escribir "INGRESE LA DESCRIPCION DEL ARTICULO ", i+1
						Leer descripcion 			// falta la descripcion no puede ser vacio
						ferreteria[i,1] = descripcion
					2:
						Escribir "INGRESE EL PRECIO DEL ARTICULO ", i+1
						code = validarFerreteria(i) 	// validar que el precio no sea 0
						ferreteria[i,2] = code
					3:
						Escribir "INGRESE LA CANTIDAD EXISTENTE DEL ARTICULO ", i+1
						code = validarFerreteria(i)
						ferreteria[i,3] = code
					4:
						Escribir "INGRESE LAS VENTAS DE LA Q1 DEL ARTICULO ", i+1
						code = validarFerreteria(i)
						Repetir
							si ConvertirANumero(code) >= ConvertirANumero(ferreteria[i,3]) Entonces
								Escribir "LA Q1 SUPERA EL STOCK DISPONIBLE"
								code = validarFerreteria(i)
							SiNo
								bool_stock = Verdadero
							FinSi
						Mientras Que bool_stock = falso
						ferreteria[i,4] = code
					5:
						bool_stock = falso
						Escribir "INGRESE LAS VENTAS DE LA Q2 DEL ARTICULO ", i+1
						code = validarFerreteria(i)
						Repetir
							suma = ConvertirANumero(ferreteria[i,4]) + ConvertirANumero(code)
							si suma > ConvertirANumero(ferreteria[i,3]) Entonces
								Escribir "LA Q1 Y Q2 SUPERAN EL STOCK DISPONIBLE"
								code = validarFerreteria(i)
							SiNo
								bool_stock = Verdadero
							FinSi
						Mientras Que bool_stock = falso
						ferreteria[i,5] = code
				Fin Segun
			Fin Para
		Fin Para
		
	SiNo
		
		cantidad_articulos = "11"
		cant_art = ConvertirANumero(cantidad_articulos)
		
		Dimension ferreteria[cant_art,6]
		dimension ferr_aux[cant_art,6]
		
		Cargar(ferreteria,ferr_aux)
	FinSi
	
	copiaOriginal(ferreteria,ferr_aux,i,j,cant_art) // COPIA DEL ARREGLO ORIGINAL
	OrdenCodigo(ferreteria,ferr_aux,i,j,k,cant_art) // ORDEN PREDEFINIDO PARA NO ROMPER EL PROGRAMA
	
	
	// MENU
	Repetir // 	MUESTRA EL MENU DESPUES DE CADA OPCION
		Repetir
			Escribir ""
			Escribir "1. Mostrar lista de articulos ordenada por descripcion"
			Escribir "2. Mostrar lista de artículos ordenada por cantidad vendida"
			Escribir "3. Mostrar stock actual de artículos"
			Escribir "4. Buscar artículo por código"
			Escribir "5. Mostrar estadísticas"
			Escribir "6. SALIR"
			Escribir ""
			Escribir "Ingrese una opcion"
			
			Leer valor_pedido 	// VALIDAMOS QUE NO INGRESE LETRAS Y SOLO LAS OPCIONES DISPONIBLES
			long = Longitud(valor_pedido)
			si (long = 1) Entonces
				
				valido = 1
				Para i=0 Hasta long-1 Con Paso 1 Hacer
					
					letra = Subcadena(valor_pedido,i,i)
					si (letra < "1") o (letra > "7") Entonces
						Escribir "CARACTER INCORRECTO [ ", letra," ]"
						valido = 0
					FinSi
				Fin Para
				
			SiNo
				Escribir "OPCION INCORRECTA"
				valido = 0
			FinSi
		Mientras Que valido = 0
		
		// INSTRUCCIONES A REALIZAR PARA CADA OPCION
		// ORDENCODIGO PARA NO ROMPER EL PROGRAMA
		
		Segun valor_pedido Hacer
			"1":
				OrdenCodigo(ferreteria,ferr_aux,i,j,k,cant_art) 
				OrdenDescripcion(ferreteria,ferr_aux,i,j,k,cant_art)
				MostrarDescrip(ferreteria,ferr_aux,i,j,k,cant_art)
			"2":
				OrdenCodigo(ferreteria,ferr_aux,i,j,k,cant_art)
				CantidadVentas(ferreteria,ferr_aux,i,j,k,cant_art) 		// calcular Q1+Q2 e Importe total
				OrdenVentas(ferr_aux,i,j,k,cant_art)			  		// ordenar
				MostrarCantidaddeVentas(ferr_aux,ferreteria,i,cant_art)	// mostrar
			"3":
				OrdenCodigo(ferreteria,ferr_aux,i,j,k,cant_art)
				OrdenStock(ferreteria,ferr_aux,i,j,cant_art)			// calcular stock restante
				MostrarStock(ferreteria,ferr_aux,i,cant_art)
			"4":
				OrdenCodigo(ferreteria,ferr_aux,i,j,k,cant_art)
				CantidadVentas(ferreteria,ferr_aux,i,j,k,cant_art) 		// llamar al 2 para cargar columna 4 y 5
				OrdenVentas(ferr_aux,i,j,k,cant_art)
				
				OrdenCodigo(ferreteria,ferr_aux,i,j,k,cant_art)
				OrdenStock(ferreteria,ferr_aux,i,j,cant_art) 			// llamar al 3 para que cargue columna 3
				
				BuscarArticulo(ferreteria,ferr_aux,i,j,k,cant_art)
			"5":
				OrdenCodigo(ferreteria,ferr_aux,i,j,k,cant_art)
				EstadisticasFinal(ferreteria,ferr_aux,i,j,k,cant_art)
			"7":
				OrdenCodigo(ferreteria,ferr_aux,i,j,k,cant_art)
				para i=0 Hasta cant_art-1 Con Paso 1 Hacer
					Escribir ferreteria[i,0],"   ",ferreteria[i,1],"    P:",ferreteria[i,2],"    S:",ferreteria[i,3],"    Q1:",ferreteria[i,4],"    Q2:",ferreteria[i,5]
				Fin Para
				
				Escribir ""
				
				para i=0 Hasta cant_art-1 Con Paso 1 Hacer
					Escribir ferr_aux[i,0],"   ",ferr_aux[i,1],"    P:",ferr_aux[i,2],"    S:",ferr_aux[i,3],"    CV:",ferr_aux[i,4],"    CI:",ferr_aux[i,5]
				Fin Para
			De Otro Modo:
				bool = Verdadero
		Fin Segun
	Mientras Que bool = Falso
	
	Escribir "GRACIAS POR USAR EL PROGRAMA DEL GRUPO 3"
FinProceso

// OPCION 1

SubProceso OrdenDescripcion(ferreteria,ferr_aux,i,j,k,cant_art)
	Definir menor Como Entero
	Definir aux Como Caracter
	
	Para i=0 Hasta cant_art-2 Con Paso 1 Hacer
		menor = i
		Para j=i+1 Hasta cant_art-1 Con Paso 1 Hacer
			si ferr_aux[j,1] < ferr_aux[menor,1] Entonces
				menor = j
			FinSi
		Fin Para
		
		Para k=0 Hasta 5 Con Paso 1 Hacer
			aux = ferr_aux[i,k] 				// aux guarda el pivote
			ferr_aux[i,k] = ferr_aux[menor,k] 	// en el pivote sobreescribimos el menor
			ferr_aux[menor,k] = aux 			// en el menor guardamos el pivote
		Fin Para
		
	Fin Para
FinSubProceso

SubProceso MostrarDescrip(ferreteria,ferr_aux,i,j,k,cant_art)
	Para i=0 Hasta cant_art-1 Con Paso 1 Hacer
		Escribir ferr_aux[i,0]," ",ferr_aux[i,1]," $",ferr_aux[i,2]
	Fin Para
FinSubProceso

// OPCION 3

SubProceso OrdenStock(ferreteria,ferr_aux,i,j,cant_art)
	Definir resta Como Entero
	Para i=0 Hasta cant_art-1 Con Paso 1 Hacer
		resta = ConvertirANumero(ferreteria[i,3]) - ConvertirANumero(ferreteria[i,4]) - ConvertirANumero(ferreteria[i,5])
		ferr_aux[i,3] = ConvertirATexto(resta)
	Fin Para
FinSubProceso

SubProceso MostrarStock(ferreteria,ferr_aux,i,cant_art)
	Para i=0 Hasta cant_art-1 Con Paso 1 Hacer
		Escribir ferr_aux[i,0]," ",ferr_aux[i,1],"  S:",ferr_aux[i,3]
	Fin Para
FinSubProceso

// OPCION 2

SubProceso CantidadVentas(ferreteria,ferr_aux,i,j,k,cant_art)
	Definir total_venta, total_importe,menor Como entero
	Definir aux Como Caracter
	
	Para i=0 Hasta cant_art-1 Con Paso 1 Hacer
		total_venta = ConvertirANumero(ferreteria[i,4]) + ConvertirANumero(ferreteria[i,5])
		total_importe = total_venta * ConvertirANumero(ferreteria[i,2])
		ferr_aux[i,4] = ConvertirATexto(total_venta)
		ferr_aux[i,5] = ConvertirATexto(total_importe)
	Fin Para
FinSubProceso

SubProceso OrdenVentas(ferr_aux,i,j,k,cant_art)
	Definir arreglo Como Caracter
	Dimension arreglo[cant_art,4]
	Definir mayor Como Entero
	Definir aux Como Caracter
	
	Para i=0 Hasta cant_art-2 Con Paso 1 Hacer
		mayor = i
		Para j=i+1 Hasta cant_art-1 Con Paso 1 Hacer
			Si ConvertirANumero(ferr_aux[j,4]) > ConvertirANumero(ferr_aux[mayor,4])Entonces
				mayor = j
			Fin Si
		Fin Para
		
		para k=0 Hasta 5 Con Paso 1 hacer
			aux = ferr_aux[i,k]
			ferr_aux[i,k] = ferr_aux[mayor,k]
			ferr_aux[mayor,k] = aux
		FinPara
	Fin Para
FinSubProceso

SubProceso MostrarCantidaddeVentas(ferr_aux,ferreteria,i,cant_art)	
	Definir suma Como Entero
	suma = 0
	Para i=0 Hasta cant_art-1 Con Paso 1 Hacer // muestra ferretria ordenada por cant vendida
		Escribir ferr_aux[i,0]," ",ferr_aux[i,1],"  V:",ferr_aux[i,4]," $",ferr_aux[i,5]
	Fin Para
	
	Escribir " "
	
	Para i=0 Hasta cant_art-1 Con Paso 1 Hacer // muestra ganancia total
		suma = suma + ConvertirANumero(ferr_aux[i,5])
	Fin Para
	Escribir "El Monto Total de ventas es: $", suma
	Escribir " "
	
FinSubProceso

// OPCION 4

SubProceso BuscarArticulo(ferreteria,ferr_aux,i,j,k,cant_art)
	Definir code Como Caracter
	Definir pos Como Entero
	
	Definir long,valido Como Entero
	Definir valor_pedido,letra Como Caracter
	
	Escribir "Ingrese el codigo del articulo que quiere buscar: "
	Leer code
	long = Longitud(code)
	
	si (long == 8) Entonces
		
		Para i=0 Hasta long-1 Con Paso 1 Hacer
			
			letra = Subcadena(code,i,i)
			si (letra < "0") o (letra > "9") Entonces
				Escribir "CARACTER INCORRECTO [ ", letra," ]"
				i = long - 1 // para cortar el para cuando encuentra un caracter incorrecto
			FinSi
		Fin Para
		
	SiNo
		Escribir "LARGO INCORRECTA - EL CODIGO DEBE TENER 8 CARACTERES"
	FinSi
	
	Para i=0 Hasta cant_art-1 Con Paso 1 Hacer
		si ferreteria[i,0] == code Entonces
			pos = i
			i=10
			Escribir " "
			Escribir ferreteria[pos,0]," ",ferreteria[pos,1],"   S:",ferr_aux[pos,3],"   Q1:",ferreteria[pos,4],"   Q2:", ferreteria[pos,5], "   $", ferr_aux[pos,5]
			
		SiNo
			si i==cant_art-1 Entonces
				Escribir "NO EXISTE EL ARTICULO CON ESE CODIGO"
			FinSi
		FinSi
	Fin Para
FinSubProceso

// OPCION 5

SubProceso EstadisticasFinal(ferreteria,ferr_aux,i,j,k,cant_art)
	
	Definir rubro_100,rubro_300,rubro_450,rubro_680,rubro_720,total_de_ventas Como real // A)
	
	Definir total_quin1_100,total_quin1_300,total_quin1_450,total_quin1_680,total_quin1_720 Como Real	// B) 1
	Definir porc_quin1_100,porc_quin1_300,porc_quin1_450,porc_quin1_680,porc_quin1_720 Como Real
	
	definir total_quin2_100,total_quin2_300,total_quin2_450,total_quin2_680,total_quin2_720 Como Real // B) 2
	Definir porcentaje_quin2_100,porcentaje_quin2_300,porcentaje_quin2_450,porcentaje_quin2_680,porcentaje_quin2_720 Como Real
	
	Definir rubro_mas_vendido Como real // C)
	Definir mayor,pos1,pos2 Como Entero
	Definir rubro_100_q2,rubro_300_q2,rubro_450_q2,rubro_680_q2,rubro_720_q2 Como Entero
	
	Definir palabra,rubro Como caracter // A) B)
	
	total_de_ventas = 0	// A) y C)
	rubro_100 = 0 
	rubro_300 = 0
	rubro_450 = 0
	rubro_680 = 0
	rubro_720 = 0
	
	porc_quin1_100 = 0 // B) Q1
	porc_quin1_300 = 0
	porc_quin1_450 = 0
	porc_quin1_680 = 0
	porc_quin1_720 = 0
	
	total_quin1_100 = 0	
	total_quin1_300 = 0
	total_quin1_450 = 0
	total_quin1_680 = 0
	total_quin1_720 = 0
	
	porc_quin2_100 = 0// B) Q2
	porc_quin2_300 = 0
	porc_quin2_450 = 0
	porc_quin2_680 = 0
	porc_quin2_720 = 0
	
	total_quin2_100 = 0	
	total_quin2_300 = 0
	total_quin2_450 = 0
	total_quin2_680 = 0
	total_quin2_720 = 0
	
	rubro_100_q2 = 0 // C)
	rubro_300_q2 = 0
	rubro_450_q2 = 0
	rubro_680_q2 = 0
	rubro_720_q2 = 0
	
	// A)
	
	Para i=0 Hasta cant_art-1 Con Paso 1 Hacer
		total_de_ventas = total_de_ventas + ConvertirANumero(ferreteria[i,4]) + ConvertirANumero(ferreteria[i,5])
		
		palabra = ferreteria[i,0]
		rubro = SubCadena(palabra,0,2)
		
		Segun rubro Hacer
			"100":
				rubro_100 = rubro_100 + ConvertirANumero(ferreteria[i,4]) + ConvertirANumero(ferreteria[i,5])
			"300":
				rubro_300 = rubro_300 + ConvertirANumero(ferreteria[i,4]) + ConvertirANumero(ferreteria[i,5])
			"450":
				rubro_450 = rubro_450 + ConvertirANumero(ferreteria[i,4]) + ConvertirANumero(ferreteria[i,5])
			"680":
				rubro_680 = rubro_680 + ConvertirANumero(ferreteria[i,4]) + ConvertirANumero(ferreteria[i,5])
			"720":
				rubro_720 = rubro_720 + ConvertirANumero(ferreteria[i,4]) + ConvertirANumero(ferreteria[i,5])
		Fin Segun
	Fin Para
	
	rubro_100 = rubro_100 / total_de_ventas * 100
	rubro_300 = rubro_300 / total_de_ventas * 100
	rubro_450 = rubro_450 / total_de_ventas * 100
	rubro_680 = rubro_680 / total_de_ventas * 100
	rubro_720 = rubro_720 / total_de_ventas * 100
	
	Escribir "A)"
	Escribir "El porcentaje del rubro 100 :   ", redon(rubro_100), " % "
	Escribir "El porcentaje del rubro 300 :   ", redon(rubro_300), " % "
	Escribir "El porcentaje del rubro 450 :   ", redon(rubro_450), " % "
	Escribir "El porcentaje del rubro 680 :   ", redon(rubro_680), " % "
	Escribir "El porcentaje del rubro 720 :   ", redon(rubro_720), " % "
	
	// B)
	
	Para i=0 Hasta cant_art-1 Con Paso 1 Hacer
		palabra = ferreteria[i,0]
		rubro = SubCadena(palabra,0,2)
		
		Segun rubro Hacer
			"100":
				total_quin1_100 = total_quin1_100 + ConvertirANumero(ferreteria[i,4])
				total_quin2_100 = total_quin2_100 + ConvertirANumero(ferreteria[i,5])
				
				porc_quin1_100 = total_quin1_100 / total_de_ventas * 100
				porc_quin2_100 = total_quin2_100 / total_de_ventas * 100
				
			"300":
				total_quin1_300 = total_quin1_300 + ConvertirANumero(ferreteria[i,4])
				total_quin2_300 = total_quin2_300 + ConvertirANumero(ferreteria[i,5])
				
				porc_quin1_300 = total_quin1_300 / total_de_ventas * 100
				porc_quin2_300 = total_quin2_300 / total_de_ventas * 100
				
			"450":
				total_quin1_450 = total_quin1_450 + ConvertirANumero(ferreteria[i,4])
				total_quin2_450 = total_quin2_450 + ConvertirANumero(ferreteria[i,5])
				
				porc_quin1_450 = total_quin1_450 / total_de_ventas * 100
				porc_quin2_450 = total_quin2_450 / total_de_ventas * 100
				
			"680":
				total_quin1_680 = total_quin1_680 + ConvertirANumero(ferreteria[i,4])
				total_quin2_680 = total_quin2_680 + ConvertirANumero(ferreteria[i,5])
				
				porc_quin1_680 = total_quin1_680 / total_de_ventas * 100
				porc_quin2_680 = total_quin2_680 / total_de_ventas * 100
				
			"720":
				total_quin1_720 = total_quin1_720 + ConvertirANumero(ferreteria[i,4])
				total_quin2_720 = total_quin2_720 + ConvertirANumero(ferreteria[i,5])
				
				porc_quin1_720 = total_quin1_720 / total_de_ventas * 100
				porc_quin2_720 = total_quin2_720 / total_de_ventas * 100
				
		Fin Segun
	Fin Para
	
	Escribir " "
	Escribir "B)"
	Escribir "RUBRO 100     Q1: ",redon(porc_quin1_100), " %", "     Q2: ",redon(porc_quin2_100), " %"
	Escribir "RUBRO 300     Q1: ",redon(porc_quin1_300), " %", "      Q2: ",redon(porc_quin2_300), " %"
	Escribir "RUBRO 450     Q1: ",redon(porc_quin1_450), " %", "      Q2: ",redon(porc_quin2_450), " %"
	Escribir "RUBRO 680     Q1: ",redon(porc_quin1_680), " %", "      Q2: ",redon(porc_quin2_680), " %"
	Escribir "RUBRO 720     Q1: ",redon(porc_quin1_720), " %", "     Q2: ",redon(porc_quin2_720), " %"
	
	rubro_100 = 0 
	rubro_300 = 0
	rubro_450 = 0
	rubro_680 = 0
	rubro_720 = 0
	
	Definir opcion_c,mas_vendido Como Entero
	Dimension opcion_c[5,3]
	
	opcion_c[0,0] = 100
	opcion_c[1,0] = 300
	opcion_c[2,0] = 450
	opcion_c[3,0] = 680
	opcion_c[4,0] = 720
	
	rubro_100 = 0 
	rubro_300 = 0
	rubro_450 = 0
	rubro_680 = 0
	rubro_720 = 0
	
	// C)
	
	Para i=0 Hasta cant_art-1 Con Paso 1 Hacer
		
		palabra = ferreteria[i,0]
		rubro = SubCadena(palabra,0,2)
		
		Segun rubro Hacer
			"100":
				rubro_100 = rubro_100 + (ConvertirANumero(ferreteria[i,2]) * ConvertirANumero(ferreteria[i,4]))
				opcion_c[0,1] = rubro_100
				
				rubro_100_q2 = rubro_100_q2 + (ConvertirANumero(ferreteria[i,2]) * ConvertirANumero(ferreteria[i,5]))
				opcion_c[0,2] = rubro_100_q2
			"300":
				rubro_300 = rubro_300 + (ConvertirANumero(ferreteria[i,2]) * ConvertirANumero(ferreteria[i,4]))
				opcion_c[1,1] = rubro_300
				
				rubro_300_q2 = rubro_300_q2 + (ConvertirANumero(ferreteria[i,2]) * ConvertirANumero(ferreteria[i,5]))
				opcion_c[1,2] = rubro_300_q2
			"450":
				rubro_450 = rubro_450 + (ConvertirANumero(ferreteria[i,2]) * ConvertirANumero(ferreteria[i,4]))
				opcion_c[2,1] = rubro_450
				
				rubro_450_q2 = rubro_450_q2 + (ConvertirANumero(ferreteria[i,2]) * ConvertirANumero(ferreteria[i,5]))
				opcion_c[2,2] = rubro_450_q2
			"680":
				rubro_680 = rubro_680 + (ConvertirANumero(ferreteria[i,2]) * ConvertirANumero(ferreteria[i,4]))
				opcion_c[3,1] = rubro_680
				
				rubro_680_q2 = rubro_680_q2 + (ConvertirANumero(ferreteria[i,2]) * ConvertirANumero(ferreteria[i,5]))
				opcion_c[3,2] = rubro_680_q2
			"720":
				rubro_720 = rubro_720 + (ConvertirANumero(ferreteria[i,2]) * ConvertirANumero(ferreteria[i,4]))
				opcion_c[4,1] = rubro_720
				
				rubro_720_q2 = rubro_720_q2 + (ConvertirANumero(ferreteria[i,2]) * ConvertirANumero(ferreteria[i,5]))
				opcion_c[4,2] = rubro_720_q2
		Fin Segun
	Fin Para
	
	Para i=0 Hasta 4 Con Paso 1 Hacer
		si i == 0 Entonces
			mas_vendido = opcion_c[i,1]
			pos1 = i
		SiNo
			si opcion_c[i,1] > mas_vendido Entonces
				mas_vendido = opcion_c[i,1]
				pos1 = i
			FinSi
		FinSi
	Fin Para
	
	Para i=0 Hasta 5-1 Con Paso 1 Hacer
		si i == 0 Entonces
			mas_vendido = opcion_c[i,2]
			pos2 = i
		SiNo
			si opcion_c[i,2] > mas_vendido Entonces
				mas_vendido = opcion_c[i,2]
				pos2 = i
			FinSi
		FinSi
	Fin Para
	
	Escribir ""
	Escribir "C)"
	Escribir "El rubro mas vendido en Q1 es el: ",opcion_c[pos1,0]," con $",opcion_c[pos1,1]
	Escribir "El rubro mas vendido en Q2 es el: ",opcion_c[pos2,0]," con $",opcion_c[pos2,2]
	
FinSubProceso

SubProceso copiaOriginal(ferreteria,ferr_aux,i,j,cant_art)
	Para i=0 Hasta cant_art-1 Con Paso 1 Hacer
		Para j=0 Hasta 5 Con Paso 1 Hacer
			ferr_aux[i,j] = ferreteria[i,j]
		Fin Para
	Fin Para
FinSubProceso

SubProceso OrdenCodigo(ferreteria,ferr_aux,i,j,k,cant_art)
	Definir menor Como Entero
	Definir aux Como Caracter
	
	Para i=0 Hasta cant_art-2 Con Paso 1 Hacer
		menor = i
		Para j=i+1 Hasta cant_art-1 Con Paso 1 Hacer
			si ConvertirANumero(ferr_aux[j,0]) < ConvertirANumero(ferr_aux[menor,0]) Entonces
				menor = j
			FinSi
		Fin Para
		
		Para k=0 Hasta 5 Con Paso 1 Hacer
			aux = ferr_aux[i,k]
			ferr_aux[i,k] = ferr_aux[menor,k]
			ferr_aux[menor,k] = aux
		Fin Para
	Fin Para
	
	//
	
	Para i=0 Hasta cant_art-2 Con Paso 1 Hacer
		menor = i
		Para j=i+1 Hasta cant_art-1 Con Paso 1 Hacer
			si ConvertirANumero(ferreteria[j,0]) < ConvertirANumero(ferreteria[menor,0]) Entonces
				menor = j
			FinSi
		Fin Para
		
		Para k=0 Hasta 5 Con Paso 1 Hacer
			aux = ferreteria[i,k]
			ferreteria[i,k] = ferreteria[menor,k]
			ferreteria[menor,k] = aux
		Fin Para
	Fin Para
FinSubProceso

Funcion x = validar_codigo(i)
	Definir long,valido Como Entero
	Definir valor_pedido,letra,x Como Caracter
	
	Repetir
		leer x
		long = longitud(x)
		si long = 8 Entonces
			valido = 1
			
			Para i=0 Hasta long-1 Con Paso 1 Hacer
				
				letra = Subcadena(x,i,i)
				
				si (letra < "0") o (letra > "9") Entonces
					Escribir "CARACTER INCORRECTO [ ",letra," ]"
					Escribir "SOLO SE PERMITEN NUMEROS"
					valido = 0
				FinSi
			Fin Para
		SiNo
			Escribir "LOGITUD INCORRECTA"
			Escribir "EL CODIGO DEBE TENER 8 DIGITOS"
			valido = 0
		FinSi
	Mientras Que valido = 0
FinFuncion

Funcion x = validarFerreteria(i)
	Definir long,valido Como Entero
	Definir valor_pedido,letra,x Como Caracter
	
	Repetir
		leer x
		long = longitud(x)
		si long > 0 Entonces
			valido = 1
			
			Para i=0 Hasta long-1 Con Paso 1 Hacer
				
				letra = Subcadena(x,i,i)
				
				si (letra < "1") o (letra > "9") Entonces
					Escribir "CARACTER INCORRECTO [ ",letra," ]"
					valido = 0
				FinSi
			Fin Para
		SiNo
			Escribir "LOGITUD INCORRECTA"
			valido = 0
		FinSi
	Mientras Que valido = 0
FinFuncion

SubProceso Cargar(ferreteria,ferr_aux)
	ferreteria[0,0] = "10019041"
	ferreteria[0,1] = "Tornillo de titanio"
	ferreteria[0,2] = "25"
	ferreteria[0,3] = "1000"
	ferreteria[0,4] = "75"
	ferreteria[0,5] = "34"
	
	ferreteria[1,0] = "10019042"
	ferreteria[1,1] = "Tuerca Hexagonal"
	ferreteria[1,2] = "15"
	ferreteria[1,3] = "1500"
	ferreteria[1,4] = "66"
	ferreteria[1,5] = "51"
	
	ferreteria[2,0] = "30012300"
	ferreteria[2,1] = "Cinta"
	ferreteria[2,2] = "150"
	ferreteria[2,3] = "200"
	ferreteria[2,4] = "10"
	ferreteria[2,5] = "18"
	
	ferreteria[3,0] = "30012301"
	ferreteria[3,1] = "Adhesivo para madera"
	ferreteria[3,2] = "500"
	ferreteria[3,3] = "100"
	ferreteria[3,4] = "4"
	ferreteria[3,5] = "8"
	
	ferreteria[4,0] = "45017687"
	ferreteria[4,1] = "Bisagras"
	ferreteria[4,2] = "300"
	ferreteria[4,3] = "600"
	ferreteria[4,4] = "22"
	ferreteria[4,5] = "24"
	
	ferreteria[5,0] = "45017688"
	ferreteria[5,1] = "Cerrojo"
	ferreteria[5,2] = "250"
	ferreteria[5,3] = "300"
	ferreteria[5,4] = "17"
	ferreteria[5,5] = "15"
	
	ferreteria[6,0] = "68015100"
	ferreteria[6,1] = "Pintura latex 10 L"
	ferreteria[6,2] = "7000"
	ferreteria[6,3] = "20"
	ferreteria[6,4] = "5"
	ferreteria[6,5] = "7"
	
	ferreteria[7,0] = "68015101"
	ferreteria[7,1] = "Barniz para madera 2 L"
	ferreteria[7,2] = "2000"
	ferreteria[7,3] = "50"
	ferreteria[7,4] = "9"
	ferreteria[7,5] = "2"
	
	ferreteria[8,0] = "72019865"
	ferreteria[8,1] = "Adaptador Macho"
	ferreteria[8,2] = "700"
	ferreteria[8,3] = "500"
	ferreteria[8,4] = "50"
	ferreteria[8,5] = "33"
	
	ferreteria[9,0] = "72019866"
	ferreteria[9,1] = "Adaptador Hembra"
	ferreteria[9,2] = "700"
	ferreteria[9,3] = "500"
	ferreteria[9,4] = "50"
	ferreteria[9,5] = "33"
	
	ferreteria[10,0] = "72019867"
	ferreteria[10,1] = "Zapatillas"
	ferreteria[10,2] = "2000"
	ferreteria[10,3] = "30"
	ferreteria[10,4] = "4"
	ferreteria[10,5] = "6"
	
	// copia de la original
	Para i=0 Hasta 10 Con Paso 1 Hacer
		Para j=0 Hasta 5 Con Paso 1 Hacer
			ferr_aux[i,j] = ferreteria[i,j] 
		Fin Para
	Fin Para
	
FinSubProceso