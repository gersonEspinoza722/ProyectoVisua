--treeDensityGraphic
--Gerson Espinoza Rivera | 2017102719
--Stephanie Delgado Brenes | 2016148541

local theta  
local ROJO
local NARANJA
local AMARILLO
local VERDECLARO
local VERDEOSCURO
local AZUL
local CELESTE
local BLANCO
local CREMA
function datos()
	local data={nombre="Continentes y datos automovilísticos",numero=5,continentes={{nombre="Africa",poblacion=1000000000,numeroPaises=54,combustible=32000000,electricos=128000},
																			{nombre="Asia",poblacion=2140000000,numeroPaises=49,combustible=100000000,electricos=650000},
																			{nombre="Europa",poblacion=743704000 ,numeroPaises=50,combustible=40000000,electricos=343000},
																			{nombre="America",poblacion=1900034000,numeroPaises=35,combustible=95000000,electricos=343000},
																			{nombre="Oceania",poblacion=38889988,numeroPaises=14,combustible=10543000,electricos=200430},
																			}}
	return data
end


function setup() 
	size(8000, 600);
	datos=datos()
	local f = loadFont("data/Vera.ttf",34)
	textFont(f)
	ROJO={255,0,0}
	NARANJA={244, 113, 65}
	AMARILLO={244, 235, 65}
	VERDECLARO={178, 244, 65}
	VERDEOSCURO={29, 132, 29}
	AZUL={29, 101, 132}
	CELESTE={45, 226, 202}
	BLANCO={255,255,255}
	CREMA={237, 231, 192}
end

function draw() 
--CONFIGURACIÓN INICIAL DEL PROGRAMA
	COLORTALLO=AZUL
	COLORFRUTO1=VERDEOSCURO
	COLORFRUTO2=CELESTE
	COLORFONDO=CREMA
	ANCHOMAX=4
	ITERACIONESMAX=12
	FRUTOSMAX=7
	ALTURA=75
-------------------------------	
	
	
	nombre=datos.nombre
	continentes=datos.continentes
	numero=datos.numero
	background(COLORFONDO[1], COLORFONDO[2], COLORFONDO[3]);
	
	text("Ancho : numero paises",1500,70)
	fill(COLORTALLO[1],COLORTALLO[2],COLORTALLO[3])
	ellipse(1490,65,10,10)
	
	text("Numero de ramas : poblacion",1500,100)
	fill(COLORTALLO[1],COLORTALLO[2],COLORTALLO[3])
	ellipse(1490,95,10,10)
	
	text("Fruto 1 : autos combustible",1500,130)
	fill(COLORFRUTO1[1],COLORFRUTO1[2],COLORFRUTO1[3])
	ellipse(1490,125,10,10)
	
	text("Fruto 1 : autos combustible",1500,160)
	fill(COLORFRUTO2[1],COLORFRUTO2[2],COLORFRUTO2[3])
	ellipse(1490,155,10,10)
	
	text(nombre,100,100)
	frameRate(4);
	stroke(255);
-- angulo el primero
	local a = (230 / 640) * 90;
	theta = math.rad(a);
	x=200
	y=500
	poblacionMayor=0
	electricosMayor=0
	combustibleMayor=0
	paisesMayor=0
	for o=1,#continentes,1
	do
		if(continentes[o].poblacion>poblacionMayor) then poblacionMayor=continentes[o].poblacion end
		if(continentes[o].electricos>electricosMayor) then electricosMayor=continentes[o].electricos end
		if(continentes[o].combustible>combustibleMayor) then combustibleMayor=continentes[o].combustible end
		if(continentes[o].numeroPaises>paisesMayor) then paisesMayor=continentes[o].numeroPaises end
	  end
  
	  for i=1,#continentes,1
	  do
		poblacion=ITERACIONESMAX*(((100*continentes[i].poblacion)/poblacionMayor)/100)
		electricos=FRUTOSMAX*(((100*continentes[i].electricos)/electricosMayor)/100)
		combustible=FRUTOSMAX*(((100*continentes[i].electricos)/electricosMayor)/100)

		pushMatrix(); 
	--ANCHO GENERAL
		local ancho=ANCHOMAX*(((100*continentes[i].numeroPaises)/paisesMayor)/100)

	  --tallo
	  strokeWeight(ancho)
	  translate(x,y);
	  stroke(COLORTALLO[1],COLORTALLO[2],COLORTALLO[3])
	  line(0,0,0,-120)
	  text(continentes[i].nombre,0,0) 
	  translate(0,-120);
	 -- altura el primero
	 
	  treeDensityGraphic(ALTURA, poblacion, ancho,combustible,electricos,COLORTALLO,COLORFRUTO1,COLORFRUTO2);
	  popMatrix();
	--Separación de cada iteracion  
	  x=x+width()/datos.numero
	  end
end

function treeDensityGraphic(largo,iteraciones,ancho,combustible,electricidad,COLORTALLO,COLOR1,COLOR2) 
 
  strokeWeight(ancho)
  largo = largo * 0.8;
  
  if (iteraciones>= 1) then
    pushMatrix();    
    rotate(theta);   
    line(0, 0, 0, -largo); 
    translate(0, -largo);
    treeDensityGraphic(largo,iteraciones-1,ancho,combustible-1,electricidad-1,COLORARBOL,COLOR1,COLOR2,ANCHOMAXIMO,ITERACIONESMAXIMAS,FRUTOSMAXIMOS);   
	--COMBUSTIBLE
	if(combustible>0)then
	fill(COLOR1[1],COLOR1[2],COLOR1[3])
	strokeWeight(0)
	ellipse(0,0,10,10)
	end	
    popMatrix();     
    strokeWeight(ancho)
    pushMatrix();
    rotate(-theta);
    line(0, 0, 0, -largo);
    translate(0, -largo);
    treeDensityGraphic(largo,iteraciones-1,ancho,combustible-1,electricidad-1,COLORARBOL,COLOR1,COLOR2,ANCHOMAXIMO,ITERACIONESMAXIMAS,FRUTOSMAXIMOS);   
	--ELECTRICOS
	if(electricidad>0)then
	fill(COLOR2[1],COLOR2[2],COLOR2[3])
	strokeWeight(0)
	ellipse(0,0,10,10)
	end	
    popMatrix();
  end
  
end