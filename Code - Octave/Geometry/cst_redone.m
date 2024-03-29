% Intuito: checar se implementei direito o CST em c�digo
clc,clear,fclose('all');

% Notas:
% Sendo n o grau do polinomio, temos n+1 vari�veis de design
% Fixemos o polin�mio em grau 4.
n = 4;

% Imprimir coordenadas?
op = 0;

%v_ex = [2.7000, 1.9000, 3.3000, 3.8000, 70.0000, 0.1000, 0.0000];
%v_in = [0.7000, 0.4000, 0.5000, 0.7000, -8.0000, 0.1000, -0.0000];

% Alguns par�metros
np = 80; % N�mero de pontos
c = 1; % Comprimento da corda
x = cosspace_half(0,c,np); 
y1 = zeros(1,length(x)); y2 = y1;
N1 = 0.5;
N2 = 1;

% Informa��es do extradorso
Rle1 = 1;
beta1 = 40;
Dz1 = 0;
    
A1 = zeros(n+1);
A1(1) = sqrt(2*Rle1/c);
A1(2) = 1;
A1(3) = 1;
A1(4) = 1;
A1(5) = tand(beta1) + Dz1/c;
f1 = 0.1;

% Informa��es do intradorso
Rle2 = 1;
beta2 = 0;
Dz2 = 0;

A2 = zeros(n+1);
A2(1) = sqrt(2*Rle2/c);
A2(2) = 0;
A2(3) = 0;
A2(4) = 0;
A2(5) = tand(beta2) + Dz2/c;
f2 = 0.1;

disp(sum(A1(2:4)))
disp(sum(A2(2:4)))

%% Extradorso ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
for p = 1:np
    
    % Calcular o polin�mio de Bernstein
    sum = 0;
    for r = 0:n
        K = factorial(n)/(factorial(r)*factorial(n-r));
        sum = sum + A1(r+1)*K*x(p)^r*(1-x(p))^(n-r);
    end
    
    % Calcular a ordenada com as fun��es class e shape ao mesmo tempo
    y1(p) = (x(p)^N1*(1-x(p))^N2*sum + x(p)*Dz1/c)*f1;
    
end

figure(1),clf
%plot(x,y1),grid on,hold on,axis equal



%% Intradorso ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
for p = 1:np
    
    % Calcular o polin�mio de Bernstein
    sum = 0;
    for r = 0:n
        K = factorial(n)/(factorial(r)*factorial(n-r));
        sum = sum + A2(r+1)*K*x(p)^r*(1-x(p))^(n-r);
    end
    
    % Calcular a ordenada com as fun��es class e shape ao mesmo tempo
    y2(p) = -(x(p)^N1*(1-x(p))^N2*sum + x(p)*Dz2/c)*f2;
    
    
end


%plot(x,y2)

coo = [flip(x') flip(y1');
       x(2:end)' y2(2:end)'];
plot(coo(:,1),coo(:,2)),grid on,axis equal,hold on
%scatter(coo(:,1),coo(:,2))

camber = (y1+y2)/2;
plot(x,camber)

%legend('Aerof�lio','Linha de curvatura')


if op == 1
    ID = fopen('coordenadas.txt','w');
    fprintf(ID,'%f %f\n',coo');
    fclose(ID);
end

disp(quality(coo,np,c))


% Testar com a fun��o que eu achei na internets
uuh = 0;
if uuh == 1
% Input  : wl = CST weight of lower surface
%          wu = CST weight of upper surface
%          dz = trailing edge thickness
% Output : coord = set of x-y coordinates of airfoil generated by CST

    wl = 1;
    wu = 1;
    dz = 0;
    N = 100;
    [coord] = CST_airfoil(wl,wu,dz,N);
    scatter(coord(:,1),coord(:,2)*f1)
    
endif



