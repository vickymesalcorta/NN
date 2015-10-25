function p = loadPatterns(params,n,actFunct)

	% TODO VER QUE HAY EN ORDERED SAMPLES.
	% NO SE COMO CREAR DESDE OCTAVE ESE ARCHIVO
	% A ESE LO CREAMOS CUANDO TENIA MATLAB
	% POR AHORA LO USO PARA NO PERDER TIEMPO EN ESO
    
    x = orderTemporalSerie(n,params.patterns);
    
      save(['serie.mat'], 'x');
    
    x = normalize(x,actFunct);
    
	params.trainingInput = zeros(n, params.training);
	params.trainingInput = x(1:params.training,1:n)';

	params.trainingExpected = zeros(1, params.training);
	params.trainingExpected = x(1:params.training,n+1)';
    
    %PARA ENSEÑAR ELIMINO EL 90% DE LOS VALORES QUE SE ENCUENTREN EN LA
    %FRANJA MEDIA PARA QUE NO PESEN TANTO
    i = 1;
    while i < params.training;
        exp = abs(params.trainingExpected(:,i));
        if  exp < 0.6
            if rand > 1
                params.trainingExpected(:,i) = [];
                params.trainingInput(:,i)= [];
                params.patterns = params.patterns -1;
                params.training = params.training -1;    
                i = i - 1;
            end 
        end
        i = i + 1;
    end
    
    params.testInput = zeros(n, params.test);
	params.testInput = x(params.training+1:params.patterns-n,1:n)';

	params.testExpected = zeros(1, params.test);
	params.testExpected = x(params.training+1:params.patterns-n,n+1)';
    
	p = params;

end