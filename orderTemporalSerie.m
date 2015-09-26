function x = orderTemporalSerie(n,size)

    load('serieTemporal.mat');
    
    % n es la cantidad de pasos anteriores de los
    % cuales depende el paso siguiente. En principio debería ser
    % menor a 4
    % size es el tamaño de la muestra
    
    x = zeros(size-n,n+1);
    for i = 1:size-n
       for j = 0:n
            x(i,j+1) = m(1,j+i);
       end
    end
    
end