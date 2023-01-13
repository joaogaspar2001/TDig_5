%% Inicialização
clearvars;
init_vars;

%% Simulação
out = sim('carriers_ASK_BPSK');

% Dados de interesse
t = squeeze(out.x_unrz.time);

x_unrz = squeeze(out.x_unrz.data);
s_ask = squeeze(out.s_ask.data);

x_pnrz = squeeze(out.x_pnrz.data);
s_bpsk = squeeze(out.s_bpsk.data);

% Densidades espectrais de potência
[px_unrz, fx_unrz] = periodogram(x_unrz, [], length(x_unrz), fs);
[ps_ask,fs_ask] = periodogram(s_ask, [], length(s_ask), fs);

[px_pnrz, fx_pnrz] = periodogram(x_pnrz, [], length(x_pnrz), fs);
[ps_bpsk,fs_bpsk] = periodogram(s_bpsk, [], length(s_bpsk), fs);


%% Gráficos no tempo
% a) unipolar NRZ
figure(1);
clf;
format_fig(900, 200);
hold on;

plot(t * 1e3, x_unrz, 'LineWidth', 2);
plot(t * 1e3, s_ask, 'LineWidth', 2);

xlabel('$t$ [ms]', 'Interpreter', 'latex', 'FontSize', 18);
ylabel('Amplitude [V]', 'Interpreter', 'latex', 'FontSize', 18);
legend('\texttt{x}', '\texttt{s\char`_ask}', 'Interpreter', 'latex', 'FontSize', 14);
xlim([0, 10]);
ylim([-1.5, 1.5]);
grid on
set(gca, 'TickLabelInterpreter', 'latex');
set(gca, "fontsize", 14); 

% d) polar NRZ + Troca de fase
figure(2);
clf;
format_fig(900, 200);
hold on;

plot(t * 1e3, x_pnrz, 'LineWidth', 2);
plot(t * 1e3, s_bpsk, 'LineWidth', 2);

xlabel('$t$ [ms]', 'Interpreter', 'latex', 'FontSize', 18);
ylabel('Amplitude [V]', 'Interpreter', 'latex', 'FontSize', 18);
legend('\texttt{x}', '\texttt{s\char`_psk}', 'Interpreter', 'latex', 'FontSize', 14);
xlim([0, 10]);
ylim([-1.5, 1.5]);
grid on
set(gca, 'TickLabelInterpreter', 'latex');
set(gca, "fontsize", 14); 

figure(3);
clf;
format_fig(900, 200);
hold on;

plot(t * 1e3, x_pnrz, 'LineWidth', 2);
plot(t * 1e3, s_bpsk, 'LineWidth', 2);

xlabel('$t$ [ms]', 'Interpreter', 'latex', 'FontSize', 18);
ylabel('Amplitude [V]', 'Interpreter', 'latex', 'FontSize', 18);
legend('\texttt{x}', '\texttt{s\char`_psk}', 'Interpreter', 'latex', 'FontSize', 14);
xlim([0.9, 2.1]);
ylim([-1.5, 1.5]);
grid on
set(gca, 'TickLabelInterpreter', 'latex');
set(gca, "fontsize", 14); 


%% Gráficos na frequência
% b) unipolar NRZ
figure(4);
clf;
format_fig(1500, 300);

subplot(1, 2, 1);
plot(fx_unrz * 1e-3, 10 * log10(px_unrz));
xlabel('$f$ [kHz]', 'Interpreter', 'latex', 'FontSize', 18);
ylabel('$\mathrm{PSD}_\texttt{x}$($f$) [dB]', 'Interpreter', 'latex', 'FontSize', 18);
grid on
set(gca, 'TickLabelInterpreter', 'latex');
set(gca, "fontsize", 14); 

subplot(1, 2, 2);
plot(fs_ask * 1e-3, 10 * log10(ps_ask));
xlabel('$f$ [kHz]', 'Interpreter', 'latex', 'FontSize', 18);
ylabel('$\mathrm{PSD}_\texttt{s\char`_ask}$($f$) [dB]', 'Interpreter', 'latex', 'FontSize', 18);
ylim([-130, 0]);
grid on
set(gca, 'TickLabelInterpreter', 'latex');
set(gca, "fontsize", 14); 

% e) polar NRZ
figure(5);
clf;
format_fig(1500, 300);

subplot(1, 2, 1);
plot(fx_pnrz * 1e-3, 10 * log10(px_pnrz));
xlabel('$f$ [kHz]', 'Interpreter', 'latex', 'FontSize', 18);
ylabel('$\mathrm{PSD}_\texttt{x}$($f$) [dB]', 'Interpreter', 'latex', 'FontSize', 18);
grid on
set(gca, 'TickLabelInterpreter', 'latex');
set(gca, "fontsize", 14); 

subplot(1, 2, 2);
plot(fs_bpsk*1e-3, 10*log10(ps_bpsk));
xlabel('$f$ [kHz]', 'Interpreter', 'latex', 'FontSize', 18);
ylabel('$\mathrm{PSD}_\texttt{s\char`_psk}$($f$) [dB]', 'Interpreter', 'latex', 'FontSize', 18);
ylim([-130, 0]);
grid on
set(gca, 'TickLabelInterpreter', 'latex');
set(gca, "fontsize", 14); 