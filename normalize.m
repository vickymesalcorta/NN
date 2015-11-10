function x = normalize(x,actFunc)
	if (actFunc == 1)
		% Tangente hiperbolica
		x = x/4;
	else
		% Sigmoidea
		% También vamos a normalizar de -1 a 1 a las entradas.
		% Y al aplicar tanh a la capa de salida las salidas iran de -1 a 1
		x = x/4;
		x(:,end) = (x(:,end) + 1)/2;
		
        % Esto hacíamos antes y normalizabamos de 0 a 1
		%x = (x + 4)/8;
	end
end