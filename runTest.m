function ans = runTest(params, w)

	testSize = params.patterns - params.training + 1;
	errorVector = [];
    result = [];
    
	for i=1:testSize-1
		output = runPattern(params, w, params.testInput(:,i));
		val = output.V.(num2char(params.layers));
        result(i) = val;
		errorVector(i) = ((params.testExpected(:,i) - val) ^2);
	end

	ans.meanError = mean(errorVector);
    ans.result = result;
    ans.expected = params.testExpected;
    
    disp('error del test: ');
	disp(ans.meanError);
    
end