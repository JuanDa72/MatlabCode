format long

function approach=simpson(f,n,a,b)
    %f: función anonima
    %n: número de intervalos (puntos -1)
    %a: limite inferior intervalo completo
    %b: limite superior intervalo completo
    odd=0;
    q=abs(b-a);
    h=q/n;
    for i= 1:2:n-1
        odd=odd+f(a+h*i);
    end
    even=0;
    for j= 2:2:n-2
        even=even+f(a+h*j);
    end
    %disp(odd)
    %disp(even)
    approach=(h/3)*(f(a)+4*odd+2*even+f(b));
    %disp("Resultado usando simpson")
end

%Definir funcion antes
%f=@(x) x^2/(x^3+1);
%simpson(f,10,0,3)


R=@(x) 4*sin((x*pi)/18);  %Función R
y=@(x,z) sqrt(R^2-z^2);     %Función y(x,z)
xb=18;                    %Fin del intervalo de x
xa=0;                     %Inicio del intervalo de x
zc=@(x) -1*R(x);          %Inicio de intervalo de z
zd=@(x) R(x);             %Fin del intervalo de z

%Elegimos un número de subintervalos par para el intervalo de x [0,18]
nx=10;
h=18/nx;
xi=xa:h:xb;

Fi=xi;   %Array que utilizaremos para guardar el resultado de la aproximación usando simpson
%para cada xi.

%disp(zeros)
for i=1:nx+1
    znc=zc(xi(i));   %Nuevo limite inferior para la integral de adentro.
    znd=zd(xi(i));   %Nuevo limite superior para la integral de adentro.
    nz=10;            %Cantidad de subintervalos que aplicaremos en simpson para la integral de adentro.
    y_z =@(z) sqrt(R(xi(i))^2-z^2);
    v=simpson(y_z,nz,znc,znd);
    Fi(i)=v;

end
%disp("Valores de Fi");
%disp(Fi);
    
%Sumar cada aproximación de Fi usando simpson
p=nx+1;
r=0;
for i=1:p
    if (i==1 || i==p)
        r=r+1*Fi(i);
    elseif(mod(i,2)~=0)
        r=r+4*Fi(i);
    else
        r=r+2*Fi(i);
    end
end

disp(h);
disp("APROXIMACIÓN FINAL")
approach=(h/3)*(r)


%Error relativo
syms x z;
R = 4 * sin((x * pi) / 18);

y = sqrt(R^2 - z^2);

zc = -R;  
zd = R; 

%valor exacto
ve= int(int(y, z, zc, zd), x, xa, xb);

disp("Error relativo")
ErrorRelativo=abs((approach-double(ve))/double(ve))



% Definir los intervalos de x, z
x = 0:0.5:18;  % Intervalo para x
z = -4:0.25:4; % Intervalo para z


[X, Z] = meshgrid(x, z);


R = @(x) 4 * sin((x * pi) / 18);  % Función R(x)
Y = sqrt(max(0, (R(X).^2 - Z.^2)));  


figure;
surf(X, Z, Y); 
title('Gráfica 3D');
xlabel('Eje x');
ylabel('Eje z');
zlabel('Altura sobre y');
colormap jet;
colorbar;  
