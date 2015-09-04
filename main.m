function m = main(actFunct, expError, eta, alpha, adaptInc, adaptDec, adaptStep, arq)

  %load all the parameters in a structure
  params.actFunct = actFunct;
  params.expError = expError;
  params.eta = eta;
  params.alpha = alpha;
  params.adaptInc = adaptInc;
  params.adaptDec = adaptDec;
  params.adaptStep = adaptStep;
  params.arq = arq;
  params.layers = size(arq, 2) - 1;
  params.w = initWeights(arq);
  params.points = 10
  params.training = 8;
  params.test = params.points - params.training;

  % 441 puntos
  params = loadPoints(params);
disp(params);

end