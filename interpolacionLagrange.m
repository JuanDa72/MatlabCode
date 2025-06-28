%Métodos para construir el poinomio de lagrange
format long

function [coeficiente]=li(i,n,p)
    disp("Inicio de función li")
    coeficiente = @(x) 1;
    for j= 0:n-1
        if j~=i
            %disp("if xd")
            f = @(x) (x-p(j+1))/(p(i+1)-p(j+1));
            anterior=coeficiente;
            coeficiente = @(x) anterior(x).*f(x);
        end
    end
end



        
function[polinomio]=pLagrange(p,y)
disp("Inicio de función polinomio de lagrange")
    n=length(p);
    polinomio = @(x) 0;
    for i= 0:n-1
        c=li(i,n,p);
        m = @(x) y(i+1) * c(x); 
        anterior = polinomio;
        polinomio = @(x) m(x) + anterior(x) ;
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
    plot(step, newY, 'ro', 'MarkerSize', 1A, 'MarkerFaceColor', 'r')
    title('Puntos del polinomio')
    xlabel('x')
    ylabel('f(x)')
    grid on
end


polinomio=pLagrange([30,50,70,110,210],[983,1045,1083,1137,1311])
%polinomio(2)
representacion(polinomio)
%graficarFuncion(polinomio, [30,210],[30,50,70,110,210],[983,1045,1083,1137,1311])
graficaPaso(110,210,0.4,polinomio)

