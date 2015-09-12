function noisedW = addNoise(w)

	for i = 1:params.layers
	    wi = params.w.(num2char(i));
	    % Ver bien como vamos a agregar ruido
	    noise = rand(size(wi)) ./ mean(mean(abs(wi))) .* params.noise;
	    noisedW.(num2char(i)) = w + noise;
	end

end