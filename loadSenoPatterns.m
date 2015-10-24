%OK. TESTEADA
function p = loadSenoPatterns(params,n)

    x = load('seno.mat');
    x = x.ans;
    
%     ACA VA LA NORMALIZACI�N CUANDO LA USEMOS
    
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