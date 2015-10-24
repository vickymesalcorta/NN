% TESTEADA OK

function trainingOutput = runPattern(params, w, xi)

	trainingOutput = cell(2);

	% Entry for current layer
	v = xi;
    
	% cell with input of current layers after g(h)
	V = cell(params.layers);
	% cell with outputs of current layer
	H = cell(params.layers);
	
	for layer = 1:params.layers
	   h = w{layer} * [v; -1];
 	   H{layer} = h;
	   v = params.g(h);
 	   V{layer} = v;  
    end
   
    % H es 1, V es 2
	trainingOutput{1} = H;
    trainingOutput{2} = V;
    % Como no podemos usar el índice 0, devuelvo el V0=H0 en trainingOutput{3}
    trainingOutput{3} = xi;
    
end