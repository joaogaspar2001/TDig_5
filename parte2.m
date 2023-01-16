%% Inicialização
clearvars;
init_vars;

% Escolha do alfa desejado
alfa = 0;
tsim = 10;

%% Simulação
t = sim('BPSK_rc');
x_pnrz = squeeze(x.data);
s_bpsk = squeeze(s_psk_rc.data);

[px_pnrz, fx_pnrz] = periodogram(x_pnrz, [], length(x_pnrz), fs);
[ps_bpsk, fs_bpsk] = periodogram(s_bpsk, [], length(s_bpsk), fs);

%% Gráficos na frequência
figure(5);
clf;
format_fig(700, 400);

subplot(2, 1, 1);
plot(fx_pnrz * 1e-3, 10 * log10(px_pnrz));
xlabel('$f$ [kHz]', 'Interpreter', 'latex', 'FontSize', 18);
ylabel('$\mathrm{PSD}_\texttt{x}$($f$) [dB]', 'Interpreter', 'latex', 'FontSize', 18);
legend(sprintf('$\\alpha = %.1f$', alfa), 'Interpreter', 'latex', 'FontSize', 14)
xlim([0, 15]);
grid on
set(gca, 'TickLabelInterpreter', 'latex');
set(gca, "fontsize", 14); 

subplot(2, 1, 2);
plot(fs_bpsk * 1e-3, 10 * log10(ps_bpsk));
xlabel('$f$ [kHz]', 'Interpreter', 'latex', 'FontSize', 18);
ylabel('$\mathrm{PSD}_\texttt{s\char`_psk\char`_rc}$($f$) [dB]', 'Interpreter', 'latex', 'FontSize', 18);
legend(sprintf('$\\alpha = %.1f$', alfa), 'Interpreter', 'latex', 'FontSize', 14)
xlim([5, 15]);
xticks([8, 9, 9.5, 10, 10.5, 11, 12, 15]);
grid on
set(gca, 'TickLabelInterpreter', 'latex');
set(gca, "fontsize", 14); 