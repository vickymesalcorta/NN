function m = main(actFunct, expError, eta, alpha, adaptInc, adaptDec, adaptStep, arq, n)
    
    % n is the ammount of previous values we are taking into account to
    % predic the next one
    
    % load all the parameters in a structure
    m = []
    % DEFINES:
    % params.patterns: cantidad de patterns totales
    % params.training: cantidad de pattern para entrenar
    % beta: beta con el que se define g(x)
    % maxEpocs
    % noise
    gBeta = 1;
    params.maxEpocs = 1000;
    % cada cuantos pasos se pone ruido
    params.maxBadSteps = 8;
    params.useNoise = 1;
    params.noise = 0.01;
    % 441 patterns totales, uso menos para poder debuggear
    params.patterns = 1000;
    params.training = 800;  
    % END_DEFINES

    params.test = params.patterns - params.training;
    params.expError = expError;
    params.eta = eta;
    params.alpha = alpha;
    params.adaptInc = adaptInc;
    params.adaptDec = adaptDec;
    params.adaptStep = adaptStep;
    params.arq = arq;
    % Ej: Arq = [2,4,5,1] layers = 3
    params.layers = size(arq, 2) - 1;
    % Load weights, patterns and activation function
    params.w = initWeights(arq);
    
    params = loadPatterns(params,n,actFunct);
    params = loadActivationFunction(params, actFunct, gBeta);
    
    trainedNetwork = trainNetwork(params);

    m = [m trainedNetwork]
    
    disp('Finalizo luego de epocas: ');
    disp(trainedNetwork.epocs);
    disp('con un error de: ');
    disp(trainedNetwork.iterError(trainedNetwork.iter));
    disp('el eta vale: ');
    disp(trainedNetwork.eta);

    % Agregar porcentajes de acierto etc.
end