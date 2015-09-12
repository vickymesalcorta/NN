function m = main(actFunct, expError, eta, alpha, adaptInc, adaptDec, adaptStep, arq)

    %load all the parameters in a structure

    % DEFINES:
    % params.patterns: cantidad de patterns totales
    % params.training: cantidad de pattern para entrenar
    % beta: beta con el que se define g(x)
    % maxEpocs
    % noise
    gBeta = 1;
    params.maxEpocs = 10;
    params.maxBadSteps = 10;
    params.useNoise = 0;
    params.noise = 0.0001;
    % 441 patterns totales, uso menos para poder debuggear
    params.patterns = 10;
    params.training = 8;  
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
    params = loadPatterns(params);
    params = loadActivationFunction(params, actFunct, gBeta);

    trainedNetwork = trainNetwork(params);

    disp('Finalizo luego de epocas: ');
    disp(trainedNetwork.epocs);
    disp('con un error de: ');
    disp(trainedNetwork.iterError(trainedNetwork.iter-1));
    disp('el eta vale: ');
    disp(trainedNetwork.eta);

    % Agregar porcentajes de acierto etc.
end