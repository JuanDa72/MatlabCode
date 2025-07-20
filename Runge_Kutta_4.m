function [x, y] = Runge_KuttaC(f, a, b, N, y0)
    % Método de Runge-Kutta de orden 4 para sistemas de EDO de primer orden
    % f  : función del sistema f(x,y)
    % a  : valor inicial de x
    % b  : valor final de x
    % N  : número de subintervalos
    % y0 : vector de condiciones iniciales

    h = (b - a) / N;      
    x = a:h:b;             
    x = x(:);             

    n = length(y0);      
    y = zeros(N+1, n);       
    y(1, :) = y0;             

    for k = 1:N
        k1 = feval(f, x(k), y(k, :))';
        k2 = feval(f, x(k) + h/2, y(k, :) + h/2 * k1)';
        k3 = feval(f, x(k) + h/2, y(k, :) + h/2 * k2)';
        k4 = feval(f, x(k) + h, y(k, :) + h * k3)';
        
        y(k + 1, :) = y(k, :) + h/6 * (k1 + 2*k2 + 2*k3 + k4);
    end
end


%Cambio de variables
function z = ejemplo_sistema(t, y)
    z(1) = y(2);                     % y1' = y2
    z(2) = -6 * y(2) - 9 * y(1);     % y2' = -6*y2 - 9*y1
    z = z(:);                        % Asegura columna
end

[x,y]=Runge_KuttaC(@ejemplo_sistema, 0.5,2.5,40,[4,-4])




% Solución exacta
x_exacta = x;
y_exacta = 4 * exp(-3 * x_exacta) + 8 * x_exacta .* exp(-3 * x_exacta);

% Graficar solución numérica y exacta
figure;
plot(x, y(:,1), 'b', 'LineWidth', 2); hold on;
plot(x_exacta, y_exacta, 'r--', 'LineWidth', 2);
legend('Solución RK4', 'Solución Exacta');
xlabel('t');
ylabel('x(t)');
title('Comparación entre RK4 y Solución Analítica');
grid on;