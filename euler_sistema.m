function [x, y] = euler_sistema(f, a, b, y0, N)
    % f: función que representa el sistema (función anónima)
    % a: valor inicial de x
    % b: valor final de x
    % y0: condiciones iniciales (puede ser un vector)
    % N: número de pasos

    h = (b - a) / N;           
    x = a:h:b;                  

    n = length(y0);         
    y = zeros(N+1, n);          
    y(1, :) = y0;               

    for i = 1:N
        y(i+1, :) = y(i, :) + h * f(x(i), y(i, :));
    end
end


%Obtener solución analitica
syms v(t)
ode = diff(v, t) == 980 - 0.184 * v;
cond = v(0) == 0;
sol = dsolve(ode, cond);
disp('Solución analítica:')
pretty(sol)
v_exacta = matlabFunction(sol);
t = 0:0.125:10;           
v_vals = v_exacta(t);   


%grafica
