function ans = backPropagation(params, wOld, i, trainingInput, eta, alpha, varOld)

	% 2_ Aplicar el pattern a la capa de entrada
	% 3_ Y propagar la salida hacia adelante
	trainingOutput = runPattern(params, wOld, trainingInput(:,i));

	delta = struct();

    % 4_ Calculo delta para la capa de salida
    S = params.trainingExpected(:,i);
    V = trainingOutput.V.(num2str(params.layers));
    H = trainingOutput.H.(num2str(params.layers));
    % Agrego el 0 al final para que tenga al igual que los otros deltas una unidad de mas
    % que corresponde al umbral, pero sera ignorada.
    delta.(num2str(params.layers)) = [params.gp(H) .* (S-V); 0];

    % 5_ Calculo los deltas para las capas anteriores
    for i = (params.layers):-1:2
    	H = trainingOutput.H.(num2str(i-1));
    	% Transpongo para poder multiplicar con delta
        w = wOld.(num2str(i))';
        % Delta calculado en paso previo
        prevDelta = delta.(num2str(i));
        % Agrego -1 que seria la entrada a la unidad umbral.
        % Creo que el -1 esta bien, pero preguntar por las dudas
        % Ignoro el 0 que agregue antes
        delta.(num2str(i-1)) = [params.gp(H) ; -1] .* (w * prevDelta(1:end-1));
    end

    % 6_ Actualizar todas las conexiones
    wNew = struct();
    varW = struct();
    for i = (params.layers):-1:1
        % Calculo variacion de conexiones
        % Ignoro el ultimo elemento que corresponde al umbral
        varW.(num2str(i))  = eta .* delta.(num2str(i))(1:end-1) * [trainingOutput.V.(num2str(i-1));-1]';
        % Nueva conexion = Conexion anterior + variacion
        wNew.(num2str(i)) = wOld.(num2str(i)) + varW.(num2str(i));
    end

    ans.varW = varW;
    ans.wNew = wNew;

end