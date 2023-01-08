%% Inicialização
clearvars;
init_vars;

alfa = 0.5;

%% Simulação
out = sim('BPSK_RC');

t = squeeze(out.x.time);
x_pnrz = squeeze(out.x.data);
s_bpsk = squeeze(out.s_psk_rc.data);

[px_pnrz, fx_pnrz] = periodogram(x_pnrz, [], length(x_pnrz), fs);
[ps_bpsk,fs_bpsk] = periodogram(s_bpsk, [], length(s_bpsk), fs);

%% Gráficos na frequência
figure(5);
clf;
format_fig(700, 400);

subplot(2, 1, 1);
plot(fx_pnrz*1e-3, 10*log10(px_pnrz));
xlabel('Frequência [kHz]');
ylabel({'Densidade Espectral ', 'de Potência [dB]'});
title(sprintf('\\textbf{x}, com $\\alpha = %.1f$', alfa), 'interpreter', 'latex');
xlim([0, 15]);

subplot(2, 1, 2);
plot(fs_bpsk*1e-3, 10*log10(ps_bpsk));
grid on;
xlabel('Frequência [kHz]');
ylabel({'Densidade Espectral ', 'de Potência [dB]'});
title(sprintf('\\textbf{s\\_psk\\_rc}, com $\\alpha = %.1f$', alfa), 'interpreter', 'latex');
xlim([0, 15]);
xticks([0, 8, 9, 10, 11, 12, 15]);






