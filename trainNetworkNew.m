function trainedNetwork = trainNetworkNew(params)

	% vars declarations
	trainedNetwork = struct();

	w = params.w;
	alpha = params.alpha;
	eta = params.eta;
    badSteps = 0;
    goodSteps = 0;
    epocs = 1;
    iter = 1;
    % Este valor es la cantidad de patterns que se usaran para el eta adapt.
    m = 1;

    % Vector con error CM de cada iteracion
    trainedNetwork.iterError = [];
    % Vector con error CM de cada epoca
    trainedNetwork.epocsError = [];

	% Esto es para usar cuando descarto un w en parametros adaptativos
    lastW = w;
	lastErrorVector = ones(1, params.training);
	
    % Empiezo con variacion 0
    % varW = cell(params.layers);
    for i = 1:params.layers
        varW{i}= zeros(size(w{i}));
    end

    % Para graficar como se va adaptando la función a la esperada
    % figure;
    % hold on; 
    % h_old = plot(0,0);
    % end

    while epocs <= params.maxEpocs
	    % 1_ SHUFFLE PATTERNS (input and expected) with the same orderç
        shuffleOrder = randperm(params.training);
        trainingInput = shufflePatterns(shuffleOrder, params.trainingInput);
        trainingExpected = shufflePatterns(shuffleOrder, params.trainingExpected);
        
        %2_ BACKPROP
        errorVector = [];
        for i = 1:params.training

            % Backprop para el pattern i:
            answer = backPropagation(params, w, i, trainingInput, trainingExpected, eta, alpha, varW);
            w = answer.newW;
            varW = answer.newVarW;

            if params.adaptStep > 0 && m == params.adaptM                
                % Calculo el error que produjeron los últimos m pasos
                for j = 1:params.training
                   output = runPattern(params, w, trainingInput(:,j));
                   outputVe = output{2}(params.layers);
                   errorVector(j) = ((trainingExpected(:,j) - outputVe{1} ) ^2);
                end

                trainedNetwork.iterError(iter) = mean(errorVector);

                if iter >= 2
                    if trainedNetwork.iterError(iter) < trainedNetwork.iterError(iter-1)
                        alpha = params.alpha;
                        badSteps = 0;
                        goodSteps = goodSteps + 1;
                        lastW = w;
                        lastErrorVector = errorVector;

                        % eta adaptativo incrementar
                        if goodSteps == params.adaptStep
                           eta = eta + params.adaptInc;
                           goodSteps = 0;
                        end
                    else
                        alpha = 0;
                        badSteps = badSteps + 1;
                        goodSteps = 0;
                        % Si es un paso malo, tiro los pesos y vuelvo al anterior
                        w = lastW;
                        iter = iter-1;  
                        errorVector = lastErrorVector;
                        
                        % eta adaptativo decrementar
                        if params.adaptStep > 0
                            eta = (1-params.adaptDec) * eta;
                        end
                    end
                end
                m = 0;
                iter = iter + 1;
            end
            m = m + 1;
        end
        
        if params.adaptStep == 0
            for i = 1:params.training
               output = runPattern(params, w, trainingInput(:,i));
               outputVe = output{2}(params.layers);
               errorVector(i) = ((trainingExpected(:,i) - outputVe{1} ) ^2);
            end
    	      
    	    meanError = mean(errorVector);
            printf(num2str(meanError));
            printf('\n');
            fflush(stdout);
    	    trainedNetwork.epocsError(epocs) = meanError;
        end
        epocs = epocs + 1;
    end

    trainedNetwork.iter = iter-1;
    trainedNetwork.epocs = epocs-1;
    trainedNetwork.eta = eta;
    trainedNetwork.w = w;
    trainedNetwork.errorVector = errorVector;
    
    trainedNetwork.test = runTest(params,w);
    
    
    % GRAFICO EL OUTPUT DEL TEST VS EL ESPERADO DEL TEST
    % x = linspace(0,size(trainedNetwork.test.result,2),size(trainedNetwork.test.result,2));
    % h = plot(x,trainedNetwork.test.result,x,params.testExpected);
    % drawnow;
    % END
end