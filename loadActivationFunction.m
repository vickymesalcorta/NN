function y = loadActivationFunction(params, actFunc, B)
	% TESTEADAS PERO ESTARIA BUENO VERIFICAR DE NUEVO!!
	% TODO NORMALIZAR!!!
	if (actFunc == 1)
		% Tangente hiperbolica
		params.g = @(x)tanh(x.*B);
		params.gp = @(x)((1-(params.g(x).^2)).*B);
	else
		% Sigmoidea
		params.g = @(x)(1./(1 + exp(x.*(-2*B))));
		params.gp = @(x)(2*B*params.g(1-params.g(x)));
	end
	y = params;
end