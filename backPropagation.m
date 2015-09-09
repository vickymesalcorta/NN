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

    disp(S);
    disp(V);
    disp(params.gp(H));
    disp(delta);

    disp(wOld);
    for i = (params.layers):-1:2

%    	H = trainingOutput.H.(num2str(i-1));

%        w = wOld.(num2str(i-1))';
        % delta previo
%        prevDelta = delta.(num2str(i));
        %1 added for the umbral node
        % El prevDelta(1:end-1) ya no es necesario por haber sacado el 0
%        delta.(num2str(i-1)) = [params.gp(H) ; 1] .* (w * prevDelta);

    end
end