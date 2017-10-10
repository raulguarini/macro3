% Lista 1 - Macroeconomia III 2017
% Alunos: Alexandre Machado e Raul Guarini
% Quest?o 2 - Crescimento Neocl?ssico

clear all; close all; clc

%% Inicializando parametros e funcoes
alpha = 0.7;
beta = 0.98;
gamma = 2;
delta = 0.1;
f = @(k) (k.^alpha);
u = @(c) ((c.^(1-gamma))/(1-gamma));
kss = (1/(alpha)*(1/beta-1+delta))^(1/(alpha-1)); % Resultado analitico
 
% Criando grids
n = 1000;
kgrid = linspace(0.01*kss, 1.25*kss, n);
kprimegrid = kgrid;

% Parametros de iteracao
epsilon = 1e-4;
maxit = 2000;
it = 0;
diff = 1;
V = zeros(n,1); % Chute inicial para V e para sua imagem por T
TV = zeros(n,1);
index = zeros(n,1); % Indexador de kgrid para g

%% Iterando a funcao valor

% Calculando consumos
K = repmat(kgrid',1,n);
Kprime = repmat(kgrid, n,1);

C = max(f(K) + (1-delta)*K - Kprime, 0); % Todos os consumos possiveis
U= u(C); % Todas as utilidades possiveis

while diff > epsilon && it < maxit
    D = U + beta*repmat(V', n, 1);
    [TV, index] = max(D, [], 2); % Procurando o maximo linha por linha
    diff = max(abs(TV - V));
    disp(diff)
    it = it + 1;
    V = TV;
end

g = kgrid(index);

%% Plotando resultados
figure; 
subplot(2,1,1); 
plot(kgrid, V);
grid on;
ylabel('V(k)');
xlabel('k');
title('Funcao Valor')

subplot(2,1,2); 
plot(kgrid, g);
grid on;
ylabel('g(k)');
xlabel('k');
title('Funcao Politica')

%% Simulando trajetoria do capital
k0 = 250;
d = kgrid - k0*ones(size(kgrid));
[value, start] = min(d, [], 2);

knovo = 
    