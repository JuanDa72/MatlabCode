%Códigos interpolación de newton
format long

function coeficiente=coeficienteNewton(x,y,i,k)
    %disp("Inicio de funcion coeficiente newton")
    if(i==k)
        coeficiente=y(i+1);
    else 
       num=coeficienteNewton(x,y,i+1,k)-coeficienteNewton(x,y,i,k-1);
       den=x(k+1)-x(i+1);
       d=num/den ;
       coeficiente=d;
    end

end


function p=factoresPolinomio(v,k)
    %disp("Inicio de función factores polinomio")
    p= @(x) 1 ;
    for i= 0:k-1
        factor= @(x) (x-v(i+1));
        anterior=p;
        p= @(x) anterior(x).*factor(x);
    end
end


function polinomio=polinomioNewton(v,y)
    %disp("Inicio de función final");
    n=length(v);
    polinomio = @(x) 0;
    for i= 0:n-1
        anterior=polinomio;
        c = factoresPolinomio(v,i);
        polinomio = @(x) anterior(x) + coeficienteNewton(v, y, 0, i) * c(x);
    end
end

     
function f_sym = representacion(f)
    syms x
    f_sym = f(x);           % Evaluar la función anónima simbólicamente
    f_sym = expand(f_sym);  % Expandir productos y simplificar
    f_sym = collect(f_sym, x);  % Ordenar por potencias de x
    disp("Representación simbólica del polinomio (ordenada por grado descendente):")
    disp(f_sym)
end



function graficarFuncion(f_handle, intervalo, puntosX, puntosY)
    fplot(f_handle, intervalo, 'LineWidth', 2)
    hold on
    plot(puntosX, puntosY, 'ro', 'MarkerSize', 8, 'MarkerFaceColor', 'r')
    legend('Polinomio', 'Puntos originales', 'Location', 'best')
    title('Gráfica del polinomio')
    xlabel('x')
    ylabel('f(x)')
    grid on
    hold off
end

function graficaPaso(xmin,xmax,paso,polinomio)
    step=xmin:paso:xmax;
    newY=arrayfun(polinomio,step);
    plot(step, newY, 'ro', 'MarkerSize', 8, 'MarkerFaceColor', 'r')
    title('Puntos del polinomio')
    xlabel('x')
    ylabel('f(x)')
    grid on
end

x = [13, 14, 15, 16, 17];
y = [1.00000, 1.23607, 1.44949, 1.64575, 1.82843];

polinomio = polinomioNewton(x, y);
%(polinomio);
%graficarFuncion(polinomio, [10, 20], [13, 14, 15, 16, 17],[1.00000, 1.23607, 1.44949, 1.64575, 1.82843])
representacion(polinomio)
graficaPaso(13,17,0.3,polinomio)