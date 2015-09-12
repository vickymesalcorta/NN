function trainingOutput = runPattern(params, w, xi)

	trainingOutput = struct();

	% Entry for current layer
	v = xi;
	% struct with input of current layers after g(h)
	V = struct();
	V.(num2char(0)) = v;
	% struct with outputs of current layer
	H = struct();
	H.(num2char(0)) = v;

	for layer = 1:params.layers
	   h = w.(num2char(layer)) * [v; -1];
	   H.(num2char(layer)) = h;
	   v = params.g(h);
	   V.(num2char(layer)) = v;	   
	end

	trainingOutput.V = V;
	trainingOutput.H = H;

%	disp(trainingOutput);
end