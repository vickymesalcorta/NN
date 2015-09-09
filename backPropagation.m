function ans = backPropagation(params, wOld, i, trainingOutput)

	disp('W');
	disp(wOld);

	delta = struct();

    % Delta for last layer
    S = params.trainingExpected(:,i);
    V = trainingOutput.V.(num2str(params.layers));
    H = trainingOutput.H.(num2str(params.layers));

    % POR QUE ANTES AGREGABAMOS UN 0?? [params.gp(H) .* (S-V);0]
    % NO RECUERDO Y ME PARECE QUE ESTABA MAL
    delta.(num2str(params.layers)) = [params.gp(H) .* (S-V)];

    disp(wOld);
    for i = (params.layers):-1:2

    	H = trainingOutput.H.(num2str(i-1));
    	% Transpongo para poder multiplicar con delta
        w = wOld.(num2str(i))';
        % delta previo
        prevDelta = delta.(num2str(i));

        disp('PROX');
        disp([params.gp(H) ; 1]);
        disp('W');
        disp(w);
        disp('prevDelta');
        disp(prevDelta);

        % Agrego -1 a la unidad umbral que seria la entrada.
        delta.(num2str(i-1)) = [params.gp(H) ; -11] .* (w * prevDelta);
    end


    ans = 1;
end