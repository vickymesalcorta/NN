function trainedNetwork = trainNetwork(params)

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

	% Esto es para usar cuando descarto un w en parametros adaptativos
	lastW = w;

    % ESTO ESTA COMO EL ORTO!! CREA UNA MATRIZ DE N X N EN VEZ DE UN VECTOR!!
    % Le agregue el "1," para arreglarlo, capaz por eso no nos andaba el eta adapt
	lastErrorVector = ones(1,params.training);
	
    % Empiezo con variacion 0
    varW = cell(params.layers);
    for i = 1:params.layers
        varW{i}= zeros(size(w{i}));
    end

    % Para graficar como se va adaptando la función a la esperada
    figure;
    hold on; 
    h_old = plot(0,0);
    % end

    while epocs <= params.maxEpocs

	    % 1_ SHUFFLE PATTERNS (input and expected) with the same orderç
        shuffleOrder = randperm(params.training);
        trainingInput = shufflePatterns(shuffleOrder, params.trainingInput);
        trainingExpected = shufflePatterns(shuffleOrder, params.trainingExpected);
        
        %2_ BACKPROP
        errorVector = [];
        for i = 1:params.training
            answer = backPropagation(params, w, i, trainingInput, trainingExpected, eta, alpha, varW);
            w = answer.newW;
            varW = answer.newVarW; 
            result(i) = answer.V;
        end
        
        for i = 1:params.training
           output = runPattern(params, w, trainingInput(:,i));
           outputVe = output{2}(params.layers);
           errorVector(i) = ((trainingExpected(:,i) - outputVe{1} ) ^2);
        end
	    % error after all imputs used once        
	    meanError = mean(errorVector);
	    trainedNetwork.iterError(iter) = meanError;
        
        
        if iter >= 2 && trainedNetwork.iterError(iter) < trainedNetwork.iterError(iter-1)
           
            disp(meanError);

%             if mod(epocs,100) == 0   
%               x = linspace(0,size(result,2),size(result,2));
%               h = plot(x,result,'*',x,params.trainingExpected,'+');
%               delete(h_old);
%               h_old = h;
%               drawnow;
%             end
        end
        
        
        
        
	    if adaptStep > 0 && iter >= 2
	    	if trainedNetwork.iterError(iter) < trainedNetwork.iterError(iter-1)
                
                disp(meanError);
                
                if mod(epocs,100) == 0   
                  x = linspace(0,size(result,2),size(result,2));
                  h = plot(x,result,'*',x,params.trainingExpected,'+');
                  delete(h_old);
                  h_old = h;
                  drawnow;
                end

                alpha = params.alpha;
                badSteps = 0;
                goodSteps = goodSteps + 1;
                lastW = w;
                lastErrorVector = errorVector;

                % eta adaptativo incrementar
                if params.adaptStep > 0 && goodSteps == params.adaptStep
                   eta = eta + params.adaptInc;
                   goodSteps = 0;
                end
           else
                % Paso malo
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
        iter = iter + 1;
        epocs = epocs + 1;
    end

    trainedNetwork.iter = iter-1;
    trainedNetwork.epocs = epocs-1;
    trainedNetwork.eta = eta;
	% Error vector es el vector con los errores de cada pattern de la ultima iteracion buena
	% No confundir con iterError
    if badSteps > 0
        w = lastW;
        errorVector = lastErrorVector;
    end
    trainedNetwork.w = w;
    trainedNetwork.errorVector = errorVector;
    
    trainedNetwork.test = runTest(params,w);
    
    
    % GRAFICO EL OUTPUT DEL TEST VS EL ESPERADO DEL TEST
    x = linspace(0,size(trainedNetwork.test.result,2),size(trainedNetwork.test.result,2));
    h = plot(x,trainedNetwork.test.result,x,params.testExpected);
    drawnow;
    % END
end