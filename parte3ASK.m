%% Inicialização
clearvars;
init_vars;

% Limiar de decisão
lim = 0.5/2;

out = sim('ASK_c');

t = out.y_ask.time;
y_ask = squeeze(out.y_ask.data);
z_ask = squeeze(out.z_ask.data);

figure(10);
format_fig(900, 200);
clf;
hold on;
plot(t * 1e3, y_ask, 'LineWidth', 1.2);
plot(t * 1e3, z_ask, 'LineWidth', 2);
xlabel('$t$ [ms]', 'Interpreter', 'latex', 'FontSize', 18);
ylabel('Amplitude [V]', 'Interpreter', 'latex', 'FontSize', 18);
legend('\texttt{y\char`_ask}', '\texttt{z\char`_ask}', 'Interpreter', 'latex', 'FontSize', 14);
xlim([0, 10]);
ylim([-0.05, 1]);
grid on
set(gca, 'TickLabelInterpreter', 'latex');
set(gca, "fontsize", 14); 


