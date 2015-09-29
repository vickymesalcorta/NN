function p = loadPatterns(params,n,actFunct)

	% TODO VER QUE HAY EN ORDERED SAMPLES.
	% NO SE COMO CREAR DESDE OCTAVE ESE ARCHIVO
	% A ESE LO CREAMOS CUANDO TENIA MATLAB
	% POR AHORA LO USO PARA NO PERDER TIEMPO EN ESO
    
    x = orderTemporalSerie(n,params.patterns);
    x = normalize(x,actFunct);
    
	params.trainingInput = zeros(n, params.training);
	params.trainingInput = x(1:params.training,1:n)';

	params.trainingExpected = zeros(1, params.training);
	params.trainingExpected = x(1:params.training,n+1)';
    
	params.testInput = zeros(n, params.test);
	params.testInput = x(params.training+1:params.patterns-n,1:n)';

	params.testExpected = zeros(1, params.test);
	params.testExpected = x(params.training+1:params.patterns-n,n+1)';

	p = params;

end