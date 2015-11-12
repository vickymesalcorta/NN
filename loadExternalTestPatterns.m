function p = loadExternalTestPatterns(params, n, fileName)

    x = orderTemporalSerie(n,params.patterns, fileName);
    x = normalize(x,params);
    
    save(['dataOrdenadaExternalTest.mat'], 'x');

    params.testInput = zeros(n, params.test);
    params.testInput = x(1:params.patterns-n,1:n)';

    params.testExpected = zeros(1, params.test);
    params.testExpected = x(1:params.patterns-n,n+1)';
    
    p = params;

end