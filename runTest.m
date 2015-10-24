function ans = runTest(params, w)

<<<<<<< HEAD
	testSize = params.patterns - params.training + 1;
	errorVector = [];
    result = [];
    
	for i=1:testSize-1
		output = runPattern(params, w, params.testInput(:,i));
		val = output.V.(num2char(params.layers));
        result(i) = val;
		errorVector(i) = ((params.testExpected(:,i) - val) ^2);
=======
	testSize = params.patterns - params.training -1;
	errorVector = [];
    
	for i=1:testSize
		output = runPattern(params, w, params.testInput(:,i));
		val = output{2}(params.layers);
        result(i) = val{1};
		errorVector(i) = ((params.testExpected(:,i) - result(i)) ^2);
>>>>>>> patternsTemporales
	end

	ans.meanError = mean(errorVector);
    ans.result = result;
<<<<<<< HEAD
    ans.expected = params.testExpected;
    
    disp('error del test: ');
	disp(ans.meanError);
    
=======
>>>>>>> patternsTemporales
end