%% Inicialização
clearvars;
init_vars;

% Limiar de decisão
lim = 0;

out = sim('BPSK_c');

t = out.y_psk.time;
y_psk = squeeze(out.y_psk.data);
z_psk = squeeze(out.z_psk.data);

figure(11);
format_fig(900, 200);
clf;
hold on;
plot(t * 1e3, y_psk, 'LineWidth', 1.2);
plot(t * 1e3, z_psk, 'LineWidth', 2);
xlabel('$t$ [ms]', 'Interpreter', 'latex', 'FontSize', 18);
ylabel('Amplitude [V]', 'Interpreter', 'latex', 'FontSize', 18);
legend('\texttt{y\char`_psk}', '\texttt{z\char`_psk}', 'Interpreter', 'latex', 'FontSize', 14);
xlim([0, 10]);
ylim([-1.05, 1.05]);
grid on
set(gca, 'TickLabelInterpreter', 'latex');
set(gca, "fontsize", 14);  