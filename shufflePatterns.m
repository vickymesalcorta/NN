function vector = shufflePatterns(order, toShuffle)

% TESTEADA!
	vector = zeros(size(toShuffle,1),size(toShuffle,2));

	for pos = 1:size(order,2)
	    vector(:,pos) = toShuffle(:,order(pos));
	end

end