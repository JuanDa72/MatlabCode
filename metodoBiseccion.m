function [raiz,iteraciones]=metodoBiseccion(f,a,b,error)
    li=a;
    ls=b;
    iteraciones=0
    punto_medio=(a+b)/2
    while abs(b-a)>error
        signo=f(a)*f(punto_medio)
        if signo<0
            b=punto_medio
        else
            a=punto_medio
        end
        iteraciones=iteraciones+1
        punto_medio=(a+b)/2
    end
    raiz=(a+b)/2
end

f=@(x) exp(1)^(-x)-x
[raiz,iteraciones]=metodoBiseccion(f,0,1,10^(-1))
disp(['Raíz: ', num2str(raiz)]);
disp(['Iteraciones: ', num2str(iteraciones)]);


