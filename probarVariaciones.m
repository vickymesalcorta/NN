        
    params = struct(...
        'actFunct', 1, ...
        'eta', 0.05, ...
        'alpha', 0.9, ...
        'arq', [2,13,9,1], ...
        'epocs', 10000, ...
        'training', 700 ,...
        'n', 2 ...
    );

    m = main(params.actFunct,params.eta,params.alpha, params.arq, params.epocs, params.training,params.n);
save(['1arq' num2str(params.arq) 'act func' num2str(params.actFunct) 'result.mat'], 'm');

 params = struct(...
        'actFunct', 1, ...
        'eta', 0.05, ...
        'alpha', 0.9, ...
        'arq', [2,7,5,1], ...
        'epocs', 10000, ...
        'training', 700 ,...
        'n', 2 ...
    );

    m = main(params.actFunct,params.eta,params.alpha, params.arq, params.epocs, params.training,params.n);
save(['1arq' num2str(params.arq) 'act func' num2str(params.actFunct) 'result.mat'], 'm');


 params = struct(...
        'actFunct', 1, ...
        'eta', 0.05, ...
        'alpha', 0.9, ...
        'arq', [2,6,1], ...
        'epocs', 10000, ...
        'training', 700 ,...
        'n', 2 ...
    );

    m = main(params.actFunct,params.eta,params.alpha, params.arq, params.epocs, params.training,params.n);
save(['1arq' num2str(params.arq) 'act func' num2str(params.actFunct) 'result.mat'], 'm');
