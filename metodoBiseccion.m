function [raiz,iteraciones, resultados]=metodoB(f,a,b,error)
    iteraciones=1;
    punto_medio=(a+b)/2;
    resultados=[iteraciones,a,b,punto_medio];
    while abs(f(punto_medio))>error
        signo=f(a)*f(punto_medio);
        if signo<0
            b=punto_medio;
        else
            a=punto_medio;
        end
        iteraciones=iteraciones+1;
        punto_medio=(a+b)/2;
        resultados=[resultados; iteraciones,a,b,punto_medio];
    end
    raiz=(a+b)/2;
end


f=@(x) x^3-6*x^2+11*x-6;
[raiz,iteraciones,resultados]=metodoB(f,1.5,2.8,10^(-3));

disp('')
% Imprimir la matriz de resultados
disp('Iteración     a         b       punto medio');
disp(resultados);
disp(['Raíz: ', num2str(raiz)]);
disp(['Iteraciones: ', num2str(iteraciones)]);

