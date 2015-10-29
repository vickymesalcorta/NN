function m = main(actFunct, eta, alpha, arq, epocs, training, n, adaptInc, adaptDec, adaptStep, rollback)

    % n is the ammount of previous values we are taking into account to
    % predic the next one
    
    % load all the parameters in a structure
    m = [];
    % beta: beta con el que se define g(x)
    % params.patterns: cantidad de patterns totales
    % params.training: cantidad de pattern para entrenar
    gBeta = 1;
    params.patterns = 1000;
    params.training = training;
    params.test = params.patterns - params.training - n;
    params.n = n;    
    params.eta = eta;
    params.alpha = alpha;
    params.arq = arq;
    params.maxEpocs = epocs;
    params.adaptInc = adaptInc;
    params.adaptDec = adaptDec;
    params.adaptStep = adaptStep;
    params.rollback = rollback;

    % Ej: Arq = [2,4,5,1] layers = 3
    params.layers = size(arq, 2) - 1;
    % Load weights, patterns and activation function
    params.w = initWeights(arq);

    
    params = loadPatterns(params,n,actFunct);
    
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

    
    m.trainedNetwork = trainedNetwork;
    m.params = params;
    
    
end