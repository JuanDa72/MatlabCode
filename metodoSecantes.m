function [aproximacion, iteraciones, resultados] = mSecantes(f, a, b, error)
    iteraciones = 0;
    resultados = [];  % Inicializa la matriz de resultados
    while abs(f(b)) > error
        difference = a - b;
        fa = f(a);
        fb = f(b);
        differenceF = fa - fb;
        n = b - (fb * (difference / differenceF));
        
        % Guarda los resultados de cada iteración
        iteraciones = iteraciones + 1;
        resultados = [resultados; iteraciones, a, b, f(a), f(b), n];
        
        a = b;
        b = n;
    end
    aproximacion = b;
end

f = @(x) x^3 - 6*x^2 + 11*x - 6;
[raiz, iteraciones, resultados] = mSecantes(f, 1.5, 2.8, 10^(-3));

% Imprimir la matriz de resultados
disp('Iteración     a         b         f(a)       f(b)         n');
disp(resultados);
disp(['Raíz: ', num2str(raiz)]);
disp(['Iteraciones: ', num2str(iteraciones)]);
