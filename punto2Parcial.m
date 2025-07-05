format long
function approach = derivadaAproximada(f, x, ecuation, h)
    % Aproximación de la derivada según el valor de ecuacion
    if (ecuation == 1)
        approach = (f(x) - f(x - h)) / h;  % Aproximación regresiva
    elseif (ecuation == 2)
        approach = (f(x + h) - f(x)) / h;  % Aproximación progresiva
    elseif (ecuation == 3)
        approach = (f(x + h) - f(x - h)) / (2 * h);  % Aproximación centrada
    elseif (ecuation == 4)
        approach = (3 * f(x) - 4 * f(x - h) + f(x - 2 * h)) / (2 * h);  % Segunda derivada, forma A
    elseif (ecuation == 5)
        approach = (f(x) - 2 * f(x - h) + f(x - 2 * h)) / (h^2);  % Segunda derivada, forma B
    end
end

function result = relativeError(app, f, x)
    % app: aproximación de la derivada
    % f: función anónima que devuelve la derivada exacta
    % x: el valor en el que calculamos la derivada
    result = abs((app - f(x)) / f(x));  % Error relativo
end


function matriz = matrizConstructor(f, exact_f, x, ecuacion)
    % Los valores de h fijos
    h_values = [0.1, 0.05, 0.025];
   
    matriz = zeros(length(h_values), 3); 
    
    % Calcular los resultados para cada h
    for i = 1:length(h_values)
        h = h_values(i);
        
        % Aproximación de la derivada
        aprox = derivadaAproximada(f, x, ecuacion, h);
        
        % Calcular el error relativo
        error = relativeError(aprox, exact_f, x);
        
        % Guardar los resultados en la matriz
        matriz(i, 2) = aprox;    
        matriz(i, 3) = error;    
        matriz(i, 1) = h;       
    end
end



f = @(x) tan(x);  % Función original
exact_first_deriv = @(x) sec(x)^2;  % Derivada exacta de tan(x)
exact_second_deriv=@(x) 2*sec(x)^2*tan(x);  %Segunda derivada exacta de tan(x)

x = 1;
disp('-------------------------------------------------------------------------------------')

for i = 1:5

    if i < 4
        matriz = matrizConstructor(f, exact_first_deriv, x, i); 
        fprintf('Matriz de resultados para la primera derivada usando la ecuación %d\n', i);
    elseif(i==4)
        matriz = matrizConstructor(f, exact_second_deriv, x, i); 
        fprintf('Matriz de resultados para la segunda derivada usando la ecuación A %d\n');
    else
        matriz = matrizConstructor(f, exact_second_deriv, x, i); 
        fprintf('Matriz de resultados para la segunda derivada usando la ecuación B %d\n');
    end
    
    fprintf('\n');
   
    fprintf('           h            Aproximación         Error Relativo\n');
    disp(matriz);
   
    fprintf('\n');
end


%matriz = matrizConstructor(f, exact_first_deriv, x, ecuation);

% Mostrar la matriz de resultados
%disp('Matriz de resultados para la primera derivada usando la ecuación 1');
%fprintf('\n')
%disp('           h            Aproximación         Error Relativo');
%disp(matriz);  
