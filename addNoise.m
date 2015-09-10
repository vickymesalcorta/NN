function noisedW = addNoise(w)

	for i = 1:params.layers
	    wi = params.w.(num2str(i));
	    % Ver bien como vamos a agregar ruido
	    noise = rand(size(wi)) ./ mean(mean(abs(wi))) .* params.noise;
	    noisedW.(num2str(i)) = w + noise;
	end

end