function w = initWeights(arq)

	% Creates for each level (except the last) a matrix of weights [0,1] of the size nextLevel*currLevel+1
	% That +1 is for the threshold

	w = struct();
	for level = 1:(size(arq,2) - 1)        
    w.(num2str(level)) = -1 + 2 .* rand(arq(level+1), arq(level)+1);
  end

end


