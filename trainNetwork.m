function trainedNetwork = trainNetwork(params)

	% vars declarations
	trainedNetwork = struct();
	w = params.w;
	alpha = params.alpha;
	eta = params.eta;
	meanError = 1;
	epocs = 1;
	iter = 1;
	badSteps = 0;
	goodSteps = 0;
	trainedNetwork.iterError = [];

	% Esto es para usar cuando descarto un w en parametros adaptativos
	lastW = w;
	lastErrorVector = ones(params.training);

	% Empiezo con variacion 0
	varW = struct ();
	for i = 1:params.layers
	    varW.(num2str(i)) = zeros(size(params.w.(num2str(i))));
	end

	% Lazy and because we only care the error
    while meanError > params.expError &&  epocs < params.maxEpocs

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
		    answer = backPropagation(params, w, i, trainingInput, eta, alpha, varW);
		    w = answer.newW;
		    varW = answer.newVarW;
		end

		%4_ Run all patterns with last w and calculate the error for each one
		errorVector = [];
	    for i = 1:params.training
	        output = runPattern(params, w, trainingInput(:,i));
	        errorVector(i) = 1/2 * ((trainingExpected(:,i) - output.V.(num2str(params.layers))) .^2);
	    end
	    % error after all imputs used once        
	    meanError = mean(errorVector);
	    trainedNetwork.iterError(iter) = meanError;

	    % PREGUNTAR:
	    % En parametros adaptativos, se incrementa luego de K pasos buenos.
	    % Como hay que decrementar? Despues de UN paso malo? o despues de K pasos malos?
	    % PARAMETROS ADAPTATIVOS con adaptStep > 0
	    if params.adaptStep > 0 && iter >= 2
	    	if trainedNetwork.iterError(iter) < trainedNetwork.iterError(iter-1)
	    		% Paso bueno
	    		alpha = params.alpha;
	    		badSteps = 0;
	    		goodSteps = goodSteps + 1;
				% Si es un paso bueno, marco este nuevo peso como el ultimo valido
				lastW = w;
				lastErrorVector = errorVector;
				% Desp de adaptStep modificar eta
				if goodSteps == params.adaptStep
					eta = eta + params.adaptInc;
					goodSteps = 0;
				end
	    	else
	    		% Paso malo
	    		alpha = 0;
    			badSteps = badSteps + 1;
    			goodSteps = 0;
    			% esta bien? o tengo que hacer esto luego de adaptStep malos?
    			eta = (1-params.adaptDec) * eta;
    			iter = iter-1;
    			% Si es un paso malo, tiro los pesos y vuelvo al anterior
    			w = lastW;
    			errorVector = lastErrorVector;
	    	end
	   	end

        iter = iter + 1;
        epocs = epocs + 1;
	end

	trainedNetwork.w = w;
	trainedNetwork.errorVector = errorVector;
    trainedNetwork.eta = eta;
	trainedNetwork.iter = iter;
    trainedNetwork.epocs = epocs;
end