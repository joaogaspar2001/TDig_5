%% Parâmetros gerais
clearvars;
init_vars;
n_bits = 10e3;

% Potência de Ruído
Ts = 1 / fs;
N0 = @(sigma_dois) 2 * Ts * sigma_dois;

% Energia de bit BPSK e ASK
Tb = 1 / rb;
Eb_bpsk = Ac^2 * Tb / 2;
Eb_ask = Eb_bpsk / 2;

% Probabilidade de erro teórica BPSK
pe_bpsk_teo = @(Eb, N_0) qfunc(sqrt(2 * Eb / N_0));

% Probabilidade de erro teórica ASK coerente
pe_ask_teo  = @(Eb, N_0) qfunc(sqrt(Eb / N_0));

% Probabilidade de erro teórica ASK não-coerente
pe_ask_teo_nao_coerente = @(Eb, N_0) 1 / 2 * exp(-Eb / (4 * N_0));


%% BPSK - recetor ótimo
in_bpsk = Simulink.SimulationInput('BPSK_c');

% Limiar de decisão para recetor ótimo BPSK
in_bpsk = in_bpsk.setVariable('lim', 0);

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


%% ASK - recetor ótimo
in_ask = Simulink.SimulationInput('ASK_c');

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


%% ASK - recetor não-coerente
in_ask_nc = Simulink.SimulationInput('ASK_nc');

% limiar de decisão para recetor não-coerente ASK
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


%% Apresentação de Resultados

% BPSK
fprintf('%-30s', 'σ²', 'Eb/N0 [dB]', 'Pe,PSK (teórica)', 'Pe,PSK (estimada)');
fprintf('\n');
for i = 1:4
    fprintf('%-30f', sigmas_bpsk(i));
    fprintf('%-30f', eb_n0_b(i));
    fprintf('%-30f', pe_b_t(i));
    fprintf('%-30f', pe_b_est(i));
    fprintf('\n');
end

% ASK
fprintf('\n');
fprintf('%-30s', 'σ²', 'Eb/N0 [dB]', 'Pe,ASK (teórica)', 'Pe,ASK (estimada)');
fprintf('\n');
for i = 1:4
    fprintf('%-30f', sigmas_ask(i));
    fprintf('%-30f', eb_n0_a(i));
    fprintf('%-30f', pe_a_t(i));
    fprintf('%-30f', pe_a_est(i));
    fprintf('\n');
end

% ASK não-coerente
fprintf('\n');
fprintf('%-30s', 'σ²', 'Eb/N0 [dB]', 'Pe,ASK (teórica, não-coerente)', 'Pe,ASK (estimada, não-coerente)');
fprintf('\n');
for i = 1:4
    fprintf('%-30f', sigmas_ask_nc(i));
    fprintf('%-30f', eb_n0_a_nc(i));
    fprintf('%-30f', pe_a_nc_t(i));
    fprintf('%-30f', pe_a_nc_est(i));
    fprintf('\n');
end


%% Curvas Pe em função de Eb/N0
figure(1);
format_fig(600, 400);
clf;
hold on;
plot(eb_n0_b, pe_b_t, 'LineWidth', 2);
plot(eb_n0_a, pe_a_t, 'LineWidth', 2);
plot(eb_n0_a_nc, pe_a_nc_t, 'LineWidth', 2);
ylim([1e-3, 1]);
xlabel('$E_b/N_0$ [dB]', 'Interpreter', 'latex', 'FontSize', 18);
ylabel('$P_e$', 'Interpreter', 'latex', 'FontSize', 18);
legend('BPSK', 'ASK', 'ASK n\~ao-coerente', 'Interpreter', 'latex', 'FontSize', 14);
grid on
set(gca, 'TickLabelInterpreter', 'latex');
set(gca, "fontsize", 14); 
set(gca, 'YScale', 'log')