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
    
    %Para graficar como se va adaptando la funci�n a la esperada
    figure;
    hold on; 
    h_old = plot(0,0);
    %end
    
    
    
    
	% Lazy and because we only care the error
    while meanError > params.expError &&  epocs <= params.maxEpocs

	    % 1_ SHUFFLE PATTERNS (input and expected) with the same order
  	    shuffleOrder = randperm(params.training);
  	    trainingInput = shufflePatterns(shuffleOrder, params.trainingInput);
  	    trainingExpected = shufflePatterns(shuffleOrder, params.trainingExpected);
        
%         disp('W');
%         disp(w.(num2char(1)));
        
        %2_ BACKPROP
        errorVector = [];
        for i = 1:params.training
            answer = backPropagation(params, w, i, trainingInput , trainingExpected, eta, alpha, varW);
            w = answer.newW;
            varW = answer.newVarW; 
            toprint(i) = answer.V;
            errors(i) = norm(answer.V - trainingExpected(i));
        end
        
%         disp('Wnew');
%         disp(w.(num2char(1)));
        
        % end

	    % Test error after all inputs used once 
        test = runTest(params,w);    
        trainedNetwork.iterError(iter) = test.meanError;   
        %trainedNetwork.iterError(iter) = mean(errors);   

	    
   		
	    % PARAMETROS ADAPTATIVOS con adaptStep > 0
	    if(params.adaptStep > 0 && iter >= 2)
	    	if trainedNetwork.iterError(iter) < trainedNetwork.iterError(iter-1)
	    		% Paso bueno
                %if mod(epocs,2) == 0   
                  x = linspace(0,size(toprint,2),size(toprint,2));
                  h = plot(x,trainingExpected,x,toprint);
                  delete(h_old);
                  h_old = h;
                  drawnow;
                %end
                % GRAFICO EL OUTPUT DEL TEST VS EL ESPERADO DEL TEST
%                  if mod(epocs,2) == 0   
%                      x = linspace(0,size(test.result,2),size(test.result,2));
%                      h = plot(x,test.result,x,params.testExpected);
%                      delete(h_old);
%                      h_old = h;
%                      drawnow;
%                  end
              %  END
                %disp('PASO BUENO');
                disp('error: ');
                disp(trainedNetwork.iterError(iter));
                % disp('EPOCA');
                % disp(epocs);
                % disp('ETA');
                % disp(eta);
         
    %            alpha = params.alpha;
  	    		badSteps = 0;
  	    		goodSteps = goodSteps + 1;
% 				% Si es un paso bueno, marco este nuevo peso como el ultimo valido
                lastLastW = lastW;
                lastW = w;
  				lastErrorVector = errorVector;
                
 				% Desp de adaptStep modificar eta
%   				if goodSteps == params.adaptStep
%   					eta = eta + params.adaptInc;
%   					goodSteps = 0;
%   				end

	    	else
	    		% Paso malo   
 	 %   		alpha = 0;
      			badSteps = badSteps + 1;
     			goodSteps = 0;
%        			eta = (1-params.adaptDec) * eta;
     			iter = iter-1;
%     			
%               % Si es un paso malo, tiro los pesos y vuelvo al anterior
                w = lastW;
                lastW = lastW;
                errorVector = lastErrorVector;
            end
        else
           lastLastW = lastW;
           lastW = w;
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