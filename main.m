function m = main(actFunct, expError, eta, alpha, adaptInc, adaptDec, adaptStep, arq)

  %load all the parameters in a structure


  % DEFINES:
  % params.points: cantidad de puntos totales
  % params.training: cantidad de puntos para entrenar
  % beta: beta con el que se define g(x)
  gBeta = 1;
  % 441 puntos totales, uso menos para poder debuggear
  params.points = 10;
  params.training = 8;  
  % END_DEFINES
  params.test = params.points - params.training;
  params.expError = expError;
  params.eta = eta;
  params.alpha = alpha;
  params.adaptInc = adaptInc;
  params.adaptDec = adaptDec;
  params.adaptStep = adaptStep;
  params.arq = arq;
  params.layers = size(arq, 2) - 1;
  % Load weights, points and activation function
  params.w = initWeights(arq);
  params = loadPoints(params);
  params = loadActivationFunction(params, actFunct, gBeta);
disp(params);

end