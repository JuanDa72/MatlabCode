function [aproximacion,iteraciones]=mSecantes(f,a,b,error)
    iteraciones=0
    while abs(b-a)>error
        n = b - (f(b) * (b - a)) / (f(b) - f(a));
        a=b
        b=n
        iteraciones=iteraciones+1
    end
    aproximacion=b
end

f=@(x) exp(1)^(-x)-x
[raiz,iteraciones]=mSecantes(f,0,1,10^(-1))
disp(['Raíz: ', num2str(raiz)]);
disp(['Iteraciones: ', num2str(iteraciones)]);