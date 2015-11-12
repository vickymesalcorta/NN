function ans = runTest(params, w)

    testSize = params.test;
    errorVector = [];
    diez_bad = 0;
    diez_good = 0;
    diezpc = 0.1;
    cinco_bad = 0;
    cinco_good = 0;
    cincopc = 0.05;
    uno_bad = 0;
    uno_good = 0;
    unopc = 0.1;
    
    for i=1:testSize
        output = runPattern(params, w, params.testInput(:,i));
        val = output{2}(params.layers);
        result(i) = val{1};
        dif = params.testExpected(:,i) - result(i);
        errorVector(i) = ((dif) ^2);

        % TOMAMOS COMO PASO BUENO, SI LA DIFERENCIA ES MENOR AL 10% DEL
        % VALOR ESPERADO
        if abs(dif) <= abs((diezpc * params.testExpected(:,i)))
            diez_good = diez_good + 1;
        else
            diez_bad = diez_bad + 1;
        end

        % TOMAMOS COMO PASO BUENO, SI LA DIFERENCIA ES MENOR AL 5% DEL
        % VALOR ESPERADO
        if abs(dif) <= abs((cincopc * params.testExpected(:,i)))
            cinco_good = cinco_good + 1;
        else
            cinco_bad = cinco_bad + 1;
        end

        % TOMAMOS COMO PASO BUENO, SI LA DIFERENCIA ES MENOR AL 10% DEL
        % VALOR ESPERADO
        if abs(dif) <= abs((unopc * params.testExpected(:,i)))
            uno_good = uno_good + 1;
        else
            uno_bad = uno_bad + 1;
        end
    end

    ans.meanError = mean(errorVector);
    ans.result = result;
    ans.diez_good = (diez_good/testSize)*100;
    ans.diez_bad = (diez_bad/testSize)*100;
    ans.cinco_good = (cinco_good/testSize)*100;
    ans.cinco_bad = (cinco_bad/testSize)*100;
    ans.uno_good = (uno_good/testSize)*100;
    ans.uno_bad = (uno_bad/testSize)*100;

    disp('El error en el testeo es de:');
    disp(ans.meanError);
    disp('El porcentaje de aciertos para un 10% de error es:');
    disp(ans.diez_good);
    disp('El porcentaje de aciertos para un 5% de error es:');
    disp(ans.cinco_good);
    disp('El porcentaje de aciertos para un 1% de error es:');
    disp(ans.uno_good);
end