function x = normalize(x,actFunc)
	if (actFunc == 1)
		% Tangente hiperbolica
		x = x/4;
	else
		% Sigmoidea
		x = (x + 4)/8;
	end
end