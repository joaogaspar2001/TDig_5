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
% Primeiro caso - unipolar NRZ
figure(1);
clf;
format_fig(900, 200);
hold on;

plot(t*1e3, x_unrz,'LineWidth',1.2);
plot(t*1e3, s_ask,'LineWidth',1.2);

xlabel('Tempo [ms]');
ylabel('Tensão [V]');
legend('x', 's\_ask');
xlim([0, 10]);
ylim([-1.1, 1.1]);

% Segundo caso - polar NRZ
figure(2);
clf;
format_fig(900, 200);
hold on;

plot(t*1e3, x_pnrz,'LineWidth',1.2);
plot(t*1e3, s_bpsk,'LineWidth',1.2);

xlabel('Tempo [ms]');
ylabel('Tensão [V]');
legend('x', 's\_bpsk');
xlim([0, 10]);
ylim([-1.1, 1.1]);

% Exemplo trocas de fase
figure(3);
clf;
format_fig(900, 200);
hold on;

plot(t*1e3, x_pnrz,'LineWidth',1.2);
plot(t*1e3, s_bpsk,'LineWidth',1.2);

xlabel('Tempo [ms]');
ylabel('Tensão [V]');
legend('x', 's\_bpsk');
xlim([0.9, 2.1]);
ylim([-1.1, 1.1]);


%% Gráficos na frequência
% Primeiro caso - unipolar NRZ
figure(4);
clf;
format_fig(700, 600);

subplot(2, 1, 1);
plot(fx_unrz*1e-3, 10*log10(px_unrz));
xlabel('Frequência [kHz]');
ylabel({'Densidade Espectral ', 'de Potência [dB]'});
title('x');

subplot(2, 1, 2);
plot(fs_ask*1e-3, 10*log10(ps_ask));
xlabel('Frequência [kHz]');
ylabel({'Densidade Espectral ', 'de Potência [dB]'});
title('s\_ask');
ylim([-130, 0]);
 
% Segundo caso - polar NRZ
figure(5);
clf;
format_fig(700, 600);

subplot(2, 1, 1);
plot(fx_pnrz*1e-3, 10*log10(px_pnrz));
xlabel('Frequência [kHz]');
ylabel({'Densidade Espectral ', 'de Potência [dB]'});
title('x');

subplot(2, 1, 2);
plot(fs_bpsk*1e-3, 10*log10(ps_bpsk));
xlabel('Frequência [kHz]');
ylabel({'Densidade Espectral ', 'de Potência [dB]'});
title('s\_bpsk');
ylim([-130, 0]);
 




