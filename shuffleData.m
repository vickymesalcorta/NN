function shuffled = shuffleData(x,params)

    shuffleOrder = randperm(params.training+params.test);
    shuffled = shufflePatterns(shuffleOrder,x');
    shuffled  = shuffled';
end

