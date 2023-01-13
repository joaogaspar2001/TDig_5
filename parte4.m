%% Inicialização
clearvars;
init_vars;

lim = 0.25;
out = sim('ASK_nc');

t = out.y_ask2.time;
s_ask2 = squeeze(out.s_ask2.data);
y_ask2 = squeeze(out.y_ask2.data);
z_ask2 = squeeze(out.z_ask2.data);

figure(12);
format_fig(900, 200);
clf;
hold on;
plot(t * 1e3, s_ask2, 'LineWidth', 2);
plot(t * 1e3, y_ask2, 'LineWidth', 2);
plot(t * 1e3, z_ask2, 'LineWidth', 2);
xlim([0, 10]);
ylim([-1.05, 1.05]);
xlabel('$t$ [ms]', 'Interpreter', 'latex', 'FontSize', 18);
ylabel('Amplitude [V]', 'Interpreter', 'latex', 'FontSize', 18);
legend('\texttt{s\char`_ask2}', '\texttt{y\char`_ask2}', '\texttt{z\char`_ask2}', 'Interpreter', 'latex', 'FontSize', 14);
grid on
set(gca, 'TickLabelInterpreter', 'latex');
set(gca, "fontsize", 14); 

