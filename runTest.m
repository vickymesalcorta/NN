function ans = runTest(params, w)

	testSize = params.patterns - params.training - params.n;
	errorVector = [];
    
	for i=1:testSize
		output = runPattern(params, w, params.testInput(:,i));
		val = output.V.(num2char(params.layers));
        result(i) = val;
		errorVector(i) = ((params.testExpected(:,i) - result(i)) ^2);
	end

	ans.meanError = mean(errorVector);
    ans.result = result;
end