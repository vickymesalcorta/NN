function y = loadActivationFunction(params, B)
	
	if params.actFunct == 1
		% Tangente hiperbolica
		params.g = @(x)tanh(x);
		params.gp = @(x)(sech(x).^2);
	elseif params.actFunct == 0
		% Sigmoidea
		params.g = @(x)(1./(1 + exp(x.*(-2*B))));
		params.gp = @(x)(2*B*params.g(1-params.g(x)));
	else
		disp('Error al cargar la activation function');
	end
	y = params;
end