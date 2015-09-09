function ans = backPropagation(params, wOld, i, trainingInput)

	% 2_ Aplicar el pattern a la capa de entrada
	% 3_ Y propagar la salida hacia adelante
	trainingOutput = runPattern(params, wOld, trainingInput(:,i));

	delta = struct();

    % 4_ Calculo delta para la capa de salida
    S = params.trainingExpected(:,i);
    V = trainingOutput.V.(num2str(params.layers));
    H = trainingOutput.H.(num2str(params.layers));
    % POR QUE ANTES AGREGABAMOS UN 0?? [params.gp(H) .* (S-V);0]
    % NO RECUERDO Y ME PARECE QUE ESTABA MAL
    delta.(num2str(params.layers)) = [params.gp(H) .* (S-V)];

    % 5_ Calculo los deltas para las capas anteriores
    for i = (params.layers):-1:2
    	H = trainingOutput.H.(num2str(i-1));
    	% Transpongo para poder multiplicar con delta
        w = wOld.(num2str(i))';
        % delta previo
        prevDelta = delta.(num2str(i));
        % Agrego -1 que seria la entrada a la unidad umbral.
        % Creo que el -1 esta bien, pero preguntar por las dudas
        delta.(num2str(i-1)) = [params.gp(H) ; -1] .* (w * prevDelta);
    end
    
%    disp('DELTA');
%    disp(delta);

    % 6_ Actualizar todas las conexiones
    


    ans = w;
end