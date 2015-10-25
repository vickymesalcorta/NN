function ans = runTest(params, w)

	testSize = params.patterns - params.training -params.n;
	errorVector = [];
    
	for i=1:testSize
		output = runPattern(params, w, params.testInput(:,i));
		val = output{2}(params.layers);
        result(i) = val{1};
		errorVector(i) = ((params.testExpected(:,i) - result(i)) ^2);
	end

	ans.meanError = mean(errorVector);
    ans.result = result;
    
    disp('El error en el testeo es de:');
    disp(meanError);

end