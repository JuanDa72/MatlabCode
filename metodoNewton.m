g = @(x) x^3 - 6*x^2 + 11*x - 6;
f = @(x) 3*x^2 - 12*x + 11;

function [raiz, iteraciones, resultados] = metodoN(f, fd, x0, error)
    iteraciones = 0;
    xn = x0;
    resultados = [];

    while abs(f(xn)) > error
        fxn = f(xn);
        fdxn = fd(xn);
        x1 = xn - fxn/fdxn;
        iteraciones = iteraciones + 1;
        resultados = [resultados; iteraciones, xn, fxn, fdxn, x1];
        xn = x1;
    end

    raiz = xn;
end

% Llamar la función y capturar también la matriz de resultados
[raiz, iteraciones, resultados] = metodoN(g, f, 2.3, 1e-3);

% Imprimir resultados
fprintf('Iteración     xn        f(x)      f''(x)     xn+1\n');
disp(resultados);
fprintf('Raíz: %.6f\n', raiz);
fprintf('Iteraciones: %d\n', iteraciones);
