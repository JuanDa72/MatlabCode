%Método euler mejorado
format long
function [x,y]=eulerM(f,a,b,h,y0)
    disp("Inicio de función Euler mejorado")
    %f: Función que permite calcular la pendiente
    %a: Inicio del intervalo
    %b: fin del intervalo
    %h: Paso
    %y0: Punto inicial.
    x=a:h:b;
    y=x;
    y(1)=y0;
    n=length(x);
    for i= 1:n-1
        k1=f(x(i),y(i)); %primera pendiente 
        xhalf=x(i+1);
        yhalf=y(i)+h*k1;
     
        k2=f(xhalf, yhalf);  %segunda pendiente

        kd=(k1+k2)/2;       %pendiente definitiva

        y(i+1)=y(i)+h*kd;    %paso definitivo 

    end

end

fi=@(x,y) 980-0.184*y;
[x, y] = eulerM(fi, 0, 10, 0.125, 0);

x = x(:)';   % convierte a fila
y = y(:)';   % convierte a fila

T = table(x', y', 'VariableNames', {'x', 'y'});
disp(T)
       
       
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



%Grafica
figure;
hold on;  % Permite graficar ambas curvas en la misma figura


plot(x, y, 'ro', 'LineWidth', 1.5, 'MarkerSize', 6); 

% Solución exacta 
plot(t, v_vals, 'b-', 'LineWidth', 2); 

legend('Euler mejorado', 'Exacta', 'Location', 'Best');
xlabel('Tiempo (t)', 'FontSize', 12);
ylabel('Velocidad (v(t))', 'FontSize', 12);
title('Caída libre con resistencia del aire', 'FontSize', 14);


grid on;
ax = gca;
ax.XGrid = 'on';
ax.YGrid = 'on';
ax.GridLineStyle = '--'; 
hold off;

%Gráfica para evaluación del error
error_absoluto = abs(v_vals - y);

% Mostrar el error en cada paso
T_error = table(t', y',v_vals',error_absoluto', 'VariableNames', {'t', 'y','Valor exacto','Error Absoluto'});
disp(T_error);

% Graficar el error absoluto
figure;
plot(t, error_absoluto, 'k-', 'LineWidth', 1.5);
xlabel('Tiempo (t)');
ylabel('Error Absoluto');
title('Error Absoluto Euler mejorado');
grid on;

