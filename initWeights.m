function w = initWeights(arq)

	% Creates for each level (except the last) a matrix of weights [0,1] of the size nextLevelxcurrLevel+1
	% That +1 is for the threshold

	w = struct();
	for level = 1:(size(arq,2) - 1)
		% Elemento i,j de la matriz es el peso para llegar A i DESDE j. Y el from es desde que layer to layer
    w.(strcat("From_",num2str(level),"_to_",num2str(level+1))) = rand(arq(level+1), arq(level)+1);
  end

end