function m = main(actFunct, eta, alpha, arq, epocs, training)
    
    % n is the ammount of previous values we are taking into account to
    % predic the next one
    
    % load all the parameters in a structure
    m = [];
    % DEFINES:
    % params.patterns: cantidad de patterns totales
    % params.training: cantidad de pattern para entrenar
    % beta: beta con el que se define g(x)
    % maxEpocs
    % noise
    gBeta = 1;
    params.maxEpocs = epocs;
    % cada cuantos pasos se pone ruido
    params.maxBadSteps = 15;
    % 441 patterns totales, uso menos para poder debuggear
    params.patterns = 1000;
    params.training = training;  
    % END_DEFINES
    params.test = params.patterns - params.training;
    params.eta = eta;
    params.alpha = alpha;
    params.arq = arq;
    % Ej: Arq = [2,4,5,1] layers = 3
    params.layers = size(arq, 2) - 1;
    % Load weights, patterns and activation function
    params.w = initWeights(arq);
    
    params = loadSenoPatterns(params,1);
    
    % FALTA TESTEAR
    params = loadActivationFunction(params, actFunct, gBeta);
     
    trainedNetwork = trainNetwork(params);
 
     m = [m trainedNetwork];
     
     disp('Finalizo luego de epocas: ');
     disp(trainedNetwork.epocs);
     disp('con un error de: ');
     disp(trainedNetwork.iterError(trainedNetwork.iter));
     disp('el eta vale: ');
     disp(trainedNetwork.eta);

    % Agregar porcentajes de acierto etc.
end