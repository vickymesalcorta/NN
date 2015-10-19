function ans = backPropagation(params, oldW, i, trainingInput, eta, alpha, oldVarW)

	% 2_ Aplicar el pattern a la capa de entrada
	% 3_ Y propagar la salida hacia adelante
	trainingOutput = runPattern(params, oldW, trainingInput(:,i));

	delta = struct();

    % 4_ Calculo delta para la capa de salida
    S = params.trainingExpected(:,i);
    V = trainingOutput.V.(num2char(params.layers));
    H = trainingOutput.H.(num2char(params.layers));
    % Agrego el 0 al final para que tenga al igual que los otros deltas una unidad de mas
    % que corresponde al umbral, pero sera ignorada.
    delta.(num2char(params.layers)) = [params.gp(H) .* (S-V); 0];

    % 5_ Calculo los deltas para las capas anteriores
    for i = (params.layers):-1:2
    	H = trainingOutput.H.(num2char(i-1));
    	% Transpongo para poder multiplicar con delta
        w = oldW.(num2char(i))';
        % Delta calculado en paso previo
        prevDelta = delta.(num2char(i));
        % Agrego -1 que seria la entrada a la unidad umbral.
        % Creo que el -1 esta bien, pero preguntar por las dudas
        % Ignoro el 0 que agregue antes
        delta.(num2char(i-1)) = [params.gp(H) ; -1] .* (w * prevDelta(1:end-1));
    end

    % 6_ Actualizar todas las conexiones
    newW = struct();
    newVarW = struct();
    for i = (params.layers):-1:1
        % Calculo variacion de conexiones
        % Ignoro el ultimo elemento que corresponde al umbral
        varWAux  = eta .* delta.(num2char(i))(1:end-1) * [trainingOutput.V.(num2char(i-1));-1]';

        % Momentum: Termino que pesa el descenso promedio
        % Si alpha vale 0 no tendra efecto
        newVarW.(num2char(i)) = varWAux + (alpha .* oldVarW.(num2char(i)));

        % Nueva conexion = Conexion anterior + variacion
        newW.(num2char(i)) = oldW.(num2char(i)) + newVarW.(num2char(i));
    end

    ans.newVarW = newVarW;
    ans.newW = newW;
    ans.V = V;
end