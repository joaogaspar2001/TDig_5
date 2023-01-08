%% Inicialização
clearvars;
init_vars;

sigmaquadrado = 1;
lim = 0.5;
out = sim('ASK_nao_coerente');

t = out.y_ask2.time;
s_ask2 = squeeze(out.s_ask2.data);
y_ask2 = squeeze(out.y_ask2.data);
z_ask2 = squeeze(out.z_ask2.data);

figure(12);
format_fig(900, 200);
clf;
hold on;
plot(t*1e3, s_ask2);
plot(t*1e3, y_ask2);
plot(t*1e3, z_ask2, 'Linewidth', 1.8);
xlim([0, 10]);
ylim([-1.05, 1.05]);
xlabel('Tempo [ms]');
ylabel('Tensão [V]');
legend('s\_ask2','y\_ask2', 'z\_ask2');
title(sprintf('pe = %.3f', out.pe));

