% Sistemas de ecuaciones lineales
format long

%Esta función es la que realiza el pivoteo parcial
function [newMatrix,endColumn]=change(matrix,columnIndex)
disp("Inicio de función change")
  [n,m]=size(matrix);
  column=matrix(:,columnIndex);
  correction=columnIndex+1
  column=column(correction-1:end)
  [value,idx]=max(abs(column))
  idx=idx+correction-2

  %intercambio de filas
  newMatrix=matrix
  newRow=matrix(idx,:);
  oldRow=matrix(columnIndex,:);
  newMatrix(columnIndex,:)=newRow;
  newMatrix(idx,:)=oldRow;
  disp(newMatrix)
  endColumn=newMatrix(:,end);
end


%Gauss normal, devuelve la matriz
function solution=gauss(matrix)
  disp("Inicio de función gauss")
  [n,m]=size(matrix);
  %intercambio de filas
  for i =1:m-2
      %matrix=change(matrix,i);
      [matrix,~]=change(matrix,i);
      for j =i+1:n
          inverse=(matrix(j,i)/matrix(i,i));
          matrix(j,:)=matrix(j,:)-matrix(i,:)*inverse;
      end
      matrix(i,:)=matrix(i,:)/matrix(i,i);
      
  end
  matrix(m-1,:)=matrix(m-1,:)/matrix(m-1,m-1);
  solution=matrix
end

%gauss([2,8,7,3,9;9,1,9,8,5;6,1,8,9,1;4,9,7,8,8])



%Gauss Jordan, retorna tanto la matriz como los valores de las variables en
%vector
function [solution,vector]=gaussJordan(matrix)
    matrix=gauss(matrix)
    disp("Inicio de gauss Jordan")
    [n,m]=size(matrix)
    for i =m-1:-1:2
        %value=matrix(i,i)
        for j=i:-1:2
            value=matrix(j-1,i)
            matrix(j-1,:)=matrix(j-1,:)-matrix(i,:)*value
        end
    end
    solution=matrix
    vector=solution(:,end)
end

%gaussJordan([2,6,5,2,6;7,5,5,2,0;7,2,6,1,2;3,1,0,7,5])



%Obtiene la matriz u necesaria para la factorización triangular, inverses y
%value son utilizados en la función l y factorización triangular
%respectivamente
function [solution,inverses,values]=u(matrix)
  disp("Obtenienndo u")
  [n,m]=size(matrix);
  inverses=[];
  %intercambio de filas
  for i =1:m-2
      [matrix,endColumn]=change(matrix,i);
      %variables=matrix(:,end)
      %matrix(:,end)=[]
      for j =i+1:n
          inverse=(matrix(j,i)/matrix(i,i))
          inverses(end+1)=inverse
          matrix(j,:)=matrix(j,:)-matrix(i,:)*inverse
          matrix(:,end)=endColumn
      end
      %matrix(i,:)=matrix(i,:)/matrix(i,i)
      
  end
  %matrix(m-1,:)=matrix(m-1,:)/matrix(m-1,m-1)
  values=matrix(:,end)
  matrix(:,end)=[]
  disp("Solucion u")
  solution=matrix
end

%u([4,1,1,10;2,2,1,10;8,1,1,14])



%Crea una matriz de 1 y 0 utilizada en l para que quede como triangular
%inferior
function result=gMatrix(n)
    matrix = zeros(n); 
    for i = 1:n
        for j = 1:i
            matrix(i,j) = 1;
        end
    end
    disp("Matrices de 1 y 0")
    result=matrix
end

%gMatrix(2)

        

%Obtiene la matriz l necesaria para la factorización triangular
function solution=l(matrix)
    [matrixU,inverses]=u(matrix);
    matrixL=matrixU;
    [n,m]=size(matrix);
    counter=1;
    for i=1:m-1
        matrixL(i,i)=1;
        for j=i+1:n
            matrixL(j,i)=inverses(counter);
            counter=counter+1;
        end
    end
    %correction=gMatrix(n)
    disp("Matriz de 1 y 0")
    m10=gMatrix(n)
    matrixL=matrixL.*m10;
    solution=matrixL
end

%l([2,0,2;5,2,0])



%Factorización triangular, usa varios metodos creados previamente
function solution=factorizacionTriangular(matrix)
    disp("Inicio de triangulación triangular")
    [matrixU,~,b]=u(matrix);
    matrixL=l(matrix);
    %b=matrix(:,end);
    newMatrixL=[matrixL,b];
    [~,vector]=gaussJordan(newMatrixL)
    newMatrixU=[matrixU,vector]
    [~,vector2]=gaussJordan(newMatrixU)
    solution=vector2
end


factorizacionTriangular([4,1,1,10;2,2,1,10;8,1,1,14])







    