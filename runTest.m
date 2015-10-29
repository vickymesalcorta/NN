function ans = runTest(params, w)

	testSize = params.test;
	errorVector = [];
    bad = 0;
    good = 0;
    
    for i=1:testSize
        output = runPattern(params, w, params.testInput(:,i));
        val = output{2}(params.layers);
        result(i) = val{1};
        dif = params.testExpected(:,i) - result(i);
        errorVector(i) = ((dif) ^2);

        % TOMAMOS COMO PASO BUENO, SI LA DIFERENCIA ES MENOR AL 10% DEL
        % VALOR ESPERADO
        if abs(dif) <= abs((0.1 * params.testExpected(:,i)))
            good = good + 1;
        else
            bad = bad + 1;
        end
    end

    ans.meanError = mean(errorVector);
    ans.result = result;
    ans.good = (good/testSize)*100;
    ans.bad = (bad/testSize)*100;
    
    disp('El error en el testeo es de:');
    disp(ans.meanError);
    disp('El porcentaje de aciertos es:');
    disp(ans.good);

end