%Euler original para EDO grado 1
format long
%Método euler mejorado
function [x,y]=eulerEdo(f,a,b,h,y0)
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
        k=f(x(i),y(i));     %Pendiente 
        y(i+1)=y(i)+h*k;    %paso 
    end

end

fi=@(x,y) 980-0.184*y;

[x, y] = eulerEdo(fi, 0, 10, 0.125, 0);

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


%Gráfica
figure; 
plot(x, y, 'r--', t, v_vals, 'b-', 'LineWidth', 1.5);
legend('Euler', 'Exacta');
xlabel('Tiempo (t)');
ylabel('Velocidad (v(t))');
title('Caída libre con resistencia del aire');
grid on;


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
title('Error Absoluto euler');
grid on;
