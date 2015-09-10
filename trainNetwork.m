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

	wOld = struct ();
	for layer = 1:params.layers
		wOld.(num2str(layer)) = zeros(size(params.w.(num2str(layer))));
	end

    % 1_ SHUFFLE PATTERNS (input and expected) with the same order
    shuffleOrder = randperm(params.training);
    trainingInput = shufflePatterns(shuffleOrder, params.trainingInput);
    trainingExpected = shufflePatterns(shuffleOrder, params.trainingExpected);

    % 2_ ADD NOISE after badSteps to avoid localMin
    if badSteps >= params.maxBadSteps
    	w = addNoise(params);
    	badSteps = 0;
	end

	%3_ BACKPROP
     totalError = [];
	 for i = 1:size(params.training)

	    answer = backPropagation(params, w, i, trainingInput, eta, alpha);
	    % answer = backPropagation(params,i,trainingOutput,w,varOld,eta,alpha);
	    % w = answer.w;
	     %varOld = answer.var;          
	%            totalError(i) = (1/2 * ((trainingExpected(:,i)-trainingOutput.V.(char('@' + params.layers+1))).^2));           
	 end
end