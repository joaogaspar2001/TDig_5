% Seed para gerador de números aleatório
rng_seed = 5;

% Dados transmitidos
n_bits = 1000;

% Débito binário
rb = 1e3;

% Amplitude e frequência da portadora
Ac = 1;
fc = 10e3;

% Dados de amostragem
spb = 100;
fs = spb * rb;

% Tempo de simulação
tsim = n_bits / rb;

% Largura de banda - código unipolar NRZ (= polar NRZ)
B = rb;

ganho_int = rb;

% Por defeito, ruído nulo
sigmaquadrado = 0;



