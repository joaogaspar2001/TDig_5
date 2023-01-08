
%% Parâmetros gerais
clearvars;
init_vars;

N0 = @(sigma_dois) sigma_dois/(fs/2);

%% BPSK     - recetor ótimo         - probabilidades de erro
in_bpsk = Simulink.SimulationInput('BPSK_coerente');

% Energia do bit
Eb_bpsk = Ac^2*(1/rb)/2;

% limiar de decisão para recetor ótimo BPSK
in_bpsk = in_bpsk.setVariable('lim', 0);

% Probabilidade de erro teórica
pe_bpsk_teo = @(Eb, N_0) normcdf(-sqrt(2*Eb/N_0));

% Valores de ruído a testar
sigmas_bpsk = [10, 20, 40, 80];


pe_b_t = zeros(length(sigmas_bpsk), 1);
pe_b_est = zeros(length(sigmas_bpsk), 1);
eb_n0_b = zeros(length(sigmas_bpsk), 1);
for ii = 1:length(sigmas_bpsk)
    
    in_bpsk = in_bpsk.setVariable('sigmaquadrado', sigmas_bpsk(ii));
    out = sim(in_bpsk);
    pe_b_est(ii) = out.pe;
    pe_b_t(ii) = pe_bpsk_teo(Eb_bpsk, N0(sigmas_bpsk(ii)));
    eb_n0_b(ii) = db(Eb_bpsk/N0(sigmas_bpsk(ii)));
end

figure(51);
format_fig(600, 200);
clf;
hold on;
plot(sigmas_bpsk, pe_b_est);
plot(sigmas_bpsk, pe_b_t);
xlabel('Potência do ruído');
ylabel('Probabilidade de Erro');
legend('Probabilidade de Erro Estimada','Probabilidade de Erro Teórica','Location','northwest');
title('Recetor de BPSK ótimo');

%% Energia bit ASK
Eb_ask = Eb_bpsk/2;

%% ASK      - recetor ótimo         - probabilidades de erro
in_ask = Simulink.SimulationInput('ASK_coerente');

% Probabilidade de erro teórica
pe_ask_teo  = @(Eb, N_0) normcdf(-sqrt(Eb/N_0));

% limiar de decisão para recetor ótimo ASK
in_ask = in_ask.setVariable('lim', 0.5/2);

% Valores de ruído a testar
sigmas_ask = [2.5, 5, 10, 20];

pe_a_t = zeros(length(sigmas_ask), 1);
pe_a_est = zeros(length(sigmas_ask), 1);
eb_n0_a = zeros(length(sigmas_ask), 1);
for ii = 1:length(sigmas_ask)
    in_ask = in_ask.setVariable('sigmaquadrado', sigmas_ask(ii));
    out = sim(in_ask);
    pe_a_est(ii) = out.pe;
    pe_a_t(ii) = pe_ask_teo(Eb_ask, N0(sigmas_ask(ii)));
    eb_n0_a(ii) = db(Eb_ask/N0(sigmas_ask(ii)));
end

figure(52);
format_fig(600, 200);
clf;
hold on;
plot(sigmas_ask, pe_a_est);
plot(sigmas_ask, pe_a_t);
xlabel('Potência do ruído');
ylabel('Probabilidade de Erro');
legend('Probabilidade de Erro Estimada','Probabilidade de Erro Teórica','Location','northwest');
title('Recetor de ASK ótimo');

%% ASK      - recetor não-coerente  - probabilidades de erro
in_ask_nc = Simulink.SimulationInput('ASK_nao_coerente');

% Probabilidade de erro teórica
pe_ask_teo_nao_coerente  = @(Eb, N_0) 0.5*exp(-Eb/(4*N_0));

% limiar de decisão para recetor não coerente ASK
in_ask_nc = in_ask_nc.setVariable('lim', 0.5);

% Valores de ruído a testar
sigmas_ask_nc = [1, 2, 4, 8];

pe_a_nc_t = zeros(length(sigmas_ask_nc), 1);
pe_a_nc_est = zeros(length(sigmas_ask_nc), 1);
eb_n0_a_nc = zeros(length(sigmas_ask_nc), 1);
for ii = 1:length(sigmas_ask_nc)
    in_ask_nc = in_ask_nc.setVariable('sigmaquadrado', sigmas_ask_nc(ii));
    out = sim(in_ask_nc);
    pe_a_nc_est(ii) = out.pe;
    pe_a_nc_t(ii) = pe_ask_teo_nao_coerente(Eb_ask, N0(sigmas_ask_nc(ii)));
    eb_n0_a_nc(ii) = db(Eb_ask/N0(sigmas_ask_nc(ii)));
end

figure(53);
format_fig(600, 200);
clf;
hold on;
plot(sigmas_ask_nc, pe_a_nc_est);
plot(sigmas_ask_nc, pe_a_nc_t);
xlabel('Potência do ruído');
ylabel('Probabilidade de Erro');
legend('Probabilidade de Erro Estimada','Probabilidade de Erro Teórica','Location','northwest');
title('Recetor de ASK não coerente');


%% Curvas Pe em função de Eb/N0

figure(54);
format_fig(600, 200);
clf;
hold on;
plot(eb_n0_a, pe_a_t);
plot(eb_n0_b, pe_b_t);
plot(eb_n0_a_nc, pe_a_nc_t);
xlabel('E_b/N_0 [dB]');
ylabel('Probabilidade de Erro');
legend('ASK', 'BPSK', 'ASK (recetor não coerente)');



