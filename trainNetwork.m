function trainedNetwork = trainNetwork(params)

	% vars declarations
	trainedNetwork = struct();
    
	w = params.w;
	alpha = params.alpha;
	eta = params.eta;
% 	meanError = 1;
    badSteps = 0;
    goodSteps = 0;
	epocs = 1;
	iter = 1;
	
    % Vector con error de cada iteracion
	trainedNetwork.iterError = [];
  
	% Esto es para usar cuando descarto un w en parametros adaptativos
	lastW = w;
	lastErrorVector = ones(params.training);
	% Empiezo con variacion 0
	
    varW = cell(params.layers);
	for i = 1:params.layers

	    varW{i}= zeros(size(w{i}));
    end
    
    %Para graficar como se va adaptando la función a la esperada
    figure;
    hold on; 
    h_old = plot(0,0);
    %end
     
    while epocs <= params.maxEpocs

	    % 1_ SHUFFLE PATTERNS (input and expected) with the same orderç
        
        % FALTA TESTEAR TODO EL SHUFFLE
  	    shuffleOrder = randperm(params.training);
  	    trainingInput = shufflePatterns(shuffleOrder, params.trainingInput);
  	    trainingExpected = shufflePatterns(shuffleOrder, params.trainingExpected);
        
        %2_ BACKPROP
        errorVector = [];
        for i = 1:params.training
            answer = backPropagation(params, w, i, trainingInput , trainingExpected, eta, alpha, varW);
            w = answer.newW;
            varW = answer.newVarW; 
            result(i) = answer.V;
        end
        %test = runTest(params,w);    
        %trainedNetwork.iterError(iter) = test.meanError;   
        
	    for i = 1:params.training
	        output = runPattern(params, w, trainingInput(:,i));
            var = output{2}(params.layers);
            errorVector(i) = ((trainingExpected(:,i) - var{1} ) ^2);
	    end
	    % error after all imputs used once        
	    meanError = mean(errorVector);
	    trainedNetwork.iterError(iter) = meanError;
        
	    if(iter >= 2)
	    	if trainedNetwork.iterError(iter) < trainedNetwork.iterError(iter-1)
	    		% Paso bueno
                disp('PASO BUENO');
                disp('error: ');
                disp(trainedNetwork.iterError(iter));
                
%                 if mod(epocs,2) == 0   
%                       x = linspace(0,size(test.result,2),size(test.result,2));
%                       h = plot(x,test.result,x,params.testExpected);
%                       delete(h_old);
%                       h_old = h;
%                       drawnow;
%                 end
                if mod(epocs,10) == 0   
                      x = linspace(0,size(result,2),size(result,2));
                      h = plot(x,result,'*',x,params.trainingExpected,'+');
                      delete(h_old);
                      h_old = h;
                      drawnow;
                end
                
                
                badSteps = 0;
                goodSteps = goodSteps + 1;
                lastW = w;
                lastErrorVector = errorVector;

            else
                
	    	%Paso malo      
            badSteps = badSteps + 1;
            goodSteps = 0;
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
    if badSteps > 0
        w = lastW;
    end
    
    
    test = runTest(params,w);
    
    
    % GRAFICO EL OUTPUT DEL TEST VS EL ESPERADO DEL TEST
    x = linspace(0,size(test.result,2),size(test.result,2));
    h = plot(x,test.result,x,params.testExpected);
    delete(h_old);
    drawnow;
    % END
end