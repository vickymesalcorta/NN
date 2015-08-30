funtion y = main(actFunct, expError, eta, alpha, adaptInc, adaptDec, adaptStep, arq)

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

  disp('arq');
  disp(params.arq);
  disp('layers');
  disp(params.layers);