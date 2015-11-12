function m = main(actFunct, eta, alpha, arq, epocs, training, delta, adaptInc, adaptDec, adaptStep, adaptM)

    % n is the ammount of previous values we are taking into account to
    % predic the next one
    
    % load all the parameters in a structure
    m = [];
    % Cantidad de pasos de los que depende la serie
    n = arq(1);
    % beta: beta con el que se define g(x)
    % params.patterns: cantidad de patterns totales
    % params.training: cantidad de pattern para entrenar
    gBeta = 0.5;
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
    params.adaptM = adaptM;
    params.actFunct = actFunct;
    params.delta = delta;

    % Ej: Arq = [2,4,5,1] layers = 3
    params.layers = size(arq, 2) - 1;
    % Load weights, patterns and activation function
    params.w = initWeights(arq);

    
    params = loadPatterns(params,n);
    
    params = loadActivationFunction(params, gBeta);

    trainedNetwork = trainNetworkNew(params);

    m = [m trainedNetwork];

    disp('Finalizo luego de epocas: ');
    disp(trainedNetwork.epocs);
    disp('con un error de: ');
    disp(mean(trainedNetwork.errorVector));
    disp('el eta vale: ');
    disp(trainedNetwork.eta);
    disp('Arquitectura');
    disp(arq);
    disp('Uso Delta??');
    disp(delta);
    
    m.trainedNetwork = trainedNetwork;
    m.params = params;
    
    disp('W_1');
    disp(trainedNetwork.w{1});
    disp('W_2');
    disp(trainedNetwork.w{2});
    disp('W_3');
    disp(trainedNetwork.w{3});
    
end