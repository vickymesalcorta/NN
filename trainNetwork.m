function t = trainNetwork(params)

	% vars declarations
	t = struct();
	w = params.w;
	alpha = params.alpha;
	eta = params.eta;
	meanError = 1;
	epocs = 1;
	iter = 1;
	badSteps = 0;

	% Empiezo con variacion 0
	varOld = struct ();
	for i = 1:params.layers
	    varOld.(num2str(i)) = zeros(size(params.w.(num2str(i))));
	end

	% Lazy and because we only care the error
    while meanError > params.expError &&  epocs < params.maxLimit

	    % 1_ SHUFFLE PATTERNS (input and expected) with the same order
	    shuffleOrder = randperm(params.training);
	    trainingInput = shufflePatterns(shuffleOrder, params.trainingInput);
	    trainingExpected = shufflePatterns(shuffleOrder, params.trainingExpected);

	    % 2_ ADD NOISE after badSteps to avoid localMin
	    if badSteps >= params.maxBadSteps
	    	w = addNoise(w);
	    	badSteps = 0;
		end

		%3_ BACKPROP
		for i = 1:params.training
		    answer = backPropagation(params, w, i, trainingInput, eta, alpha, varOld);
		    w = answer.wNew;
		    varOld = answer.varW;
		end

		%4_ Run all patterns with last w and calculate the error for each one
		totalError = [];
	    for i = 1:params.training
	        output = runPattern(params, w, trainingInput(:,i));
	        totalError(i) = 1/2 * ((trainingExpected(:,i) - output.V.(num2str(params.layers))) .^2);
	    end

	    %error after all imputs used once        
	    meanError = mean(totalError);
	end
end