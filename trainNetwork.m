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
	% Vector con error de cada iteracion
	trainedNetwork.iterError = [];
  
	% Esto es para usar cuando descarto un w en parametros adaptativos
	lastW = w;
	lastErrorVector = ones(params.training);

	% Empiezo con variacion 0
	varW = struct ();
    
	for i = 1:params.layers
	    varW.(num2char(i)) = zeros(size(params.w.(num2char(i))));
    end
    
    %Para graficar como se va adaptando la función a la esperada
    figure;
    hold on; 
    x = linspace(0,params.training,params.training);
    h_old = plot(0,0);
    %end

	% Lazy and because we only care the error
    while meanError > params.expError &&  epocs <= params.maxEpocs

	    % 1_ SHUFFLE PATTERNS (input and expected) with the same order
	    shuffleOrder = randperm(params.training);
	    trainingInput = shufflePatterns(shuffleOrder, params.trainingInput);
	    trainingExpected = shufflePatterns(shuffleOrder, params.trainingExpected);

	    % 2_ ADD NOISE after badSteps to avoid localMin
	    if params.useNoise == 1 && badSteps >= params.maxBadSteps
            w = addNoise(w,params);
	    	badSteps = 0;
            disp('noise added')
		end

		%3_ BACKPROP
        for i = 1:params.training
            answer = backPropagation(params, w, i, trainingInput, eta, alpha, varW);
            w = answer.newW;
            varW = answer.newVarW;
            result(i) = answer.V;
        end
        % end

		%4_ Run all patterns with last w and calculate the error for each one
		errorVector = [];
	    for i = 1:params.training
	        output = runPattern(params, w, trainingInput(:,i));
            var = output.V.(num2char(params.layers));
            errorVector(i) = ((trainingExpected(:,i) - var ) ^2);
	    end
	    % error after all imputs used once        
	    meanError = mean(errorVector);
	    trainedNetwork.iterError(iter) = meanError;
	    
	    %GRAFICO DE EXPLORACIÃ“N DE LOS ERRORES
        %plot(trainedNetwork.iterError);
        %drawnow
   		%hold on
   		%


        
	    % PREGUNTAR:
	    % En parametros adaptativos, se incrementa luego de K pasos buenos.
	    % Como hay que decrementar? Despues de UN paso malo? o despues de K pasos malos?
	    % PARAMETROS ADAPTATIVOS con adaptStep > 0
	    if params.adaptStep > 0 && iter >= 2
	    	if trainedNetwork.iterError(iter) < trainedNetwork.iterError(iter-1)
	    		% Paso bueno
                disp('PASO BUENO');
                disp('error: ');
                disp(meanError);
                % GRAFICO LA FUNCION APROXIMADA A VECES
%                 h = plot(x,trainingExpected,x,result);
%                 delete(h_old);
%                 h_old = h;
%                 drawnow;
                % end
                
                
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
	% Error vector es el vector con los errores de cada pattern de la ultima iteracion
	% No confundir con iterError
	trainedNetwork.errorVector = errorVector;
    trainedNetwork.eta = eta;
	trainedNetwork.iter = iter-1;
    trainedNetwork.epocs = epocs-1;
     
    trainedNetwork.test = runTest(params,trainedNetwork.w);    
    
    % GRAFICO LA FUNCION APROXIMADA A VECES
    plot(x,trainingExpected,x,result);
    drawnow;
    % end
    
    x = linspace(0,size(trainedNetwork.test.result,2),size(trainedNetwork.test.result,2));
    figure;
    plot(x,trainedNetwork.test.result,x,params.testExpected);
    drawnow;
end