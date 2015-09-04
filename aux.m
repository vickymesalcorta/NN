function y = main3(f, expError, eta, alpha, adaptativeI, adaptativeD, adaptativeS)

    % g if 0: exp if:1 tanh
    % gp derivate of G
    % expError expected error
    % maxLimit max quantity of iterations if the error is not riched
    % eta learning rate
    % alpha momentum. If 0, alpha not used
    % noise noise for weight
    % adaptativeI adaptative increment
    % adaptativeD adaptative decrement
    % adaptativeS adaptative steps, If 0, adaptative not used
    % arq architecture of the network
    % w weights
    
    layers = 3;
    
    arq = [2  4 6 1];
    
  w = initWeights(arq);

  load('orderedSamples.mat');

  
  %load trainig data and expected answers
  trainingInput = zeros(2, 350);
  trainingInput = x(1:350,1:2)';
  trainingExpected = x(1:350,3)';
  
  %load test values
  testInput = zeros(2,91);
  testInput = x(351:441,1:2)';
  testExpected = x(351:441,3)';

    if (f == 1)
        % Normalize data
%         trainingInput = trainingInput ./ 4;
%         trainingExpected = trainingExpected ./ 4;
%         testInput = testInput ./ 4;
%         testExpected = testExpected ./ 4;
        g = @tanh;
        gp = @(x)(sech(x).^2);
    else
        % Normalize data
%        trainingInput = (trainingInput + 4) ./ 8;
%         trainingExpected = (trainingExpected + 4) ./ 8;
%         testInput = (testInput + 4) ./ 8;
%         testExpected = (testExpected + 4) ./ 8;
        g = @(x)1./(1 + exp(-2*(x)));
        gp = @(x)(2 * exp(2*(x)))./((exp(2*(x))+1).^2);
    end

    params = struct(...
       'g', g,...
       'f', f,...
       'max', max(trainingExpected),...
       'min', min(trainingExpected),...
       'gp', gp,...
       'arq', arq,...
       'layers',layers, ...
       'expError', expError,...
       'maxLimit', 1500,...
       'eta', eta,...
       'alpha', alpha,...
       'noise', 0.0001,...
       'adaptativeI', adaptativeI,...
       'adaptativeD', adaptativeD,...
       'adaptativeS', adaptativeS, ...
       'w', w, ...
       'trainingInput', trainingInput,...
       'trainingExpected', trainingExpected...
    );
  
     trainedNetwork = trainNetwork(params);
     
     disp('Finalizo luego de iteraciones: ');
     disp(trainedNetwork.iter);
     disp('con un error de: ');
     disp(trainedNetwork.error(trainedNetwork.iter-1));
     disp('el eta vale: ');
     disp(trainedNetwork.eta);
     disp('y las matrices de pesos son A:');
     disp(trainedNetwork.w.A);
     disp('B: ');
     disp(trainedNetwork.w.B);
    
     save(['trainedNetwork_error' num2str(trainedNetwork.error(trainedNetwork.iter-1)) '.mat'] );
     
end

