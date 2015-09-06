function t = trainNetwork(params)

	% vars declarations
	t = struct();
	errorVector = [];
	error = 1;
	iter = 1;
	epocs = 1;
	alpha = params.alpha;
	badSteps = 0;


	wOld = struct ();
	for layer = 1:params.layers
		wOld.(num2str(layer)) = zeros(size(params.w.(num2str(layer))));
	end

end