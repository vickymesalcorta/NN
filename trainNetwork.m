function t = trainNetwork(params)

	% vars declarations
	t = struct();
	errorVector = [];
	error = 1;
	iter = 1;
	epocs = 1;
	w = params.w;
	alpha = params.alpha;
	eta = params.eta;
	badSteps = 0;

	% Empiezo con variacion 0
	varOld = struct ();
	for i = 1:params.layers
	    varOld.(num2str(i)) = zeros(size(params.w.(num2str(i))));
	end

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
     totalError = [];
	for i = 1:size(params.training)
	    answer = backPropagation(params, w, i, trainingInput, eta, alpha, varOld);
	    w = answer.wNew;
	    varOld = answer.varW;
	 end
end