% TESTEADA OK

function trainingOutput = runPattern(params, w, xi)

	trainingOutput = cell(2);

	% Entry for current layer
	v = xi;
	% cell with input of current layers after g(h)
	V = cell(params.layers);
	V{1} = v;
	% cell with outputs of current layer
	H = cell(params.layers);
	H{1} = v;
     
	for layer = 1:params.layers
	   h = w{layer} * [v; -1];
 	   H{layer} = h;
	   v = params.g(h);
 	   V{layer} = v;  
    end
   
 	trainingOutput{1} = V;
	trainingOutput{2} = H;
end