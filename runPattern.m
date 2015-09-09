function trainingOutput = runPattern(params, w, xi)

	trainingOutput = struct();

	% Entry for current layer
	v = xi;
	% struct with input of current layers after g(h)
	V = struct();
	V.(num2str(0)) = v;
	% struct with outputs of current layer
	H = struct();
	H.(num2str(0)) = v;

	for layer = 1:params.layers
	   h = w.(num2str(layer)) * [v; -1];
	   H.(num2str(layer)) = h;
	   v = params.g(h);
	   V.(num2str(layer)) = v;	   
	end

	trainingOutput.V = V;
	trainingOutput.H = H;

%	disp(trainingOutput);
end