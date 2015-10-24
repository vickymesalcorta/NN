function y = loadActivationFunction(params, actFunc, B)
	
	if (actFunc == 1)
		% Tangente hiperbolica
		params.g = @(x)tanh(x);
		params.gp = @(x)(sech(x).^2);
	else
		% Sigmoidea
		params.g = @(x)(1./(1 + exp(x.*(-2*B))));
		params.gp = @(x)(2*B*params.g(1-params.g(x)));
	end
	y = params;
end