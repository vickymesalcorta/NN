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
    figure;
    hold on; 
    h_old = plot(0,0);


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
                  
            if params.adaptStep > 0 && mod(i, params.adaptM) == 0
                % Calculo el error que produjeron los últimos adaptM backprop
                for j = 1:params.training
                   output = runPattern(params, w, trainingInput(:,j));
                   outputVe = output{2}(params.layers);
                   errorVector(j) = ((trainingExpected(:,j) - outputVe{1} ) ^2);
                end
                
                trainedNetwork.iterError(iter) = mean(errorVector);
                if iter >= 2
                    
                    if trainedNetwork.iterError(iter) < trainedNetwork.iterError(iter-1)
                        disp('ETA');
                        disp(eta)
                        disp('ERROR');
                        disp(trainedNetwork.iterError(iter));
                     
                        % PASO BUENO
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
                        % PASO MALO
                        alpha = 0;
                        badSteps = badSteps + 1;
                        goodSteps = 0;
                        % Si es un paso malo, tiro los pesos y vuelvo al anterior
                        w = lastW;
                        errorVector = lastErrorVector;
                        iter = iter-1;
                        % eta adaptativo decrementar
                        if eta < 0.01
                            eta = 0.1;
                        else
                            eta = (1-params.adaptDec) * eta;
                        end
                    end
                end
                iter = iter + 1;
            end
        end
        
        % Esto se usa para backprop basico sin eta adapt
        if params.adaptStep == 0
            for i = 1:params.training
               lastW = w;
               output = runPattern(params, w, trainingInput(:,i));
               outputVe = output{2}(params.layers);
               result(i) = outputVe{1};
               errorVector(i) = ((trainingExpected(:,i) - outputVe{1} ) ^2);
            end

            % x = linspace(0,size(result,2),size(result,2));
            % h = plot(x,result,'*',x,params.trainingExpected,'+');
            % delete(h_old);
            % h_old = h;
            % drawnow;
                    
    	    % error after all imputs used once
            trainedNetwork.iterError(iter) = mean(errorVector);
    	    meanError = mean(errorVector);
            disp(meanError);
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
    % h = plot(x,trainedNetwork.test.result,'*',x,params.testExpected,'+');
    % drawnow;
end