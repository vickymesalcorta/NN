function ans = backPropagation(params, oldW, i, trainingInput, trainingExpected, eta, alpha, oldVarW)

	% 2_ Aplicar el pattern a la capa de entrada
	% 3_ Y propagar la salida hacia adelante
    
	trainingOutput = runPattern(params, oldW, trainingInput(:,i));
    
    

	delta = cell(params.layers);

    % 4_ Calculo delta para la capa de salida
    S = trainingExpected(:,i);
    
    H = trainingOutput{1}(params.layers);
    H = H{1};
    V = trainingOutput{2}(params.layers);
    V = V{1};
    
    
    
    % Agrego el 0 al final para que tenga al igual que los otros deltas una unidad de mas
    % que corresponde al umbral, pero sera ignorada.

%     delta{params.layers} = [(params.gp(H)+0.1) .* (S-V); 0];
    delta{params.layers} = [(params.gp(H)) .* (S-V); 0];
    
    disp(params.gp(H));
    disp(S);
    disp(V);
    
    disp('delta');
    disp(delta{params.layers});

    % 5_ Calculo los deltas para las capas anteriores
    for i = (params.layers):-1:2
    	H = trainingOutput{1}(i-1);

    	% Transpongo para poder multiplicar con delta
        w = oldW{i}';
        % Delta calculado en paso previo
        prevDelta = delta{i}(1:end-1);
        % Agrego -1 que seria la entrada a la unidad umbral.
        % Creo que el -1 esta bien, pero preguntar por las dudas
        % Ignoro el 0 que agregue antes        
%         delta{i-1} = [params.gp(H{1}) ; -1] + 0.1 .* (w * prevDelta);
        delta{i-1} = [params.gp(H{1}) ; -1] .* (w * prevDelta);
        
        disp('delta de ');
        disp(i-1);
        disp(delta{i-1});
        
    end

    % 6_ Actualizar todas las conexiones
    newW = cell(params.layers);
    newVarW = cell(params.layers);
    
    for i = (params.layers):-1:1
        % Calculo variacion de conexiones
        % Ignoro el ultimo elemento que corresponde al umbral
        
        if (i==1)
            o = trainingOutput{3};
        else
            o = trainingOutput{2}(i-1);
            o = o{1};
        end
        
 disp(o);
        
        varWAux  = eta .* delta{i}(1:end-1) * [o;-1]';
        
        % Momentum: Termino que pesa el descenso promedio
        % Si alpha vale 0 no tendra efecto
        
        newVarW{i} = varWAux + (alpha .* oldVarW{i});
        
        % Nueva conexion = Conexion anterior + variacion
        newW{i} = oldW{i} + newVarW{i};
        
        
    end

    ans.newVarW = newVarW;
    disp(newW{1});
    disp(newW{2});
    ans.newW = newW;
    ans.V = V;
    
end