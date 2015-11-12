function z = runBest(patterns, fileName)

	params.arq = [2, 9, 13, 1];
	% Cantidad de pasos de los que depende la serie
    params.n = arq(1);
    params.layers = size(arq, 2) - 1;
    params.actFunct = 1;
    params.g = @(x)tanh(x);
    % Cantidad de valores de la serie que nos dan
    params.patterns = patterns;
    params.test = patterns - n;
    % Cargar input
    params = loadExternalTestPatterns(params,n, fileName);
    
    % Cargar pesos
    % w = 

    % RunTest:
    runTest(params, w);

    % Imprimir y graficar resultados
    
end