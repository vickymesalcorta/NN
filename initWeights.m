function w = initWeights(arq)

	% Creates for each level (except the last) a matrix of weights [0,0.5] of the size nextLevelXcurrLevel+1
	% That +1 is for the threshold

	w = struct();
	for layer = 1:(size(arq,2) - 1)
		% Elemento i,j de la matriz es el peso para llegar A i DESDE j.
		% El nombre de la matrix corresponde con los pesos para llegar a esa LAYER
		% Es decir el "1" es para llegar a la primera capa, es decir, pesos desde LEVEL 0 A 1
		% NO confundir LAYER CON LEVEL
    	w.(num2str(layer)) = 0.5 .* rand(arq(layer+1), arq(layer)+1);
  	end

end