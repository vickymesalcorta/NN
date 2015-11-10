function x = normalize(x,params)
	if params.actFunct == 1
		% Tangente hiperbolica
		x = x/4;
	else
		% Sigmoidea
		% También vamos a normalizar de -1 a 1 a las entradas.
		% Y a la salida le aplicaremos una funcion tanh que lleve de -1 a 1
		x = x/4;
	end
end