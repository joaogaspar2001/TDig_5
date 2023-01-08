%% Inicialização
clearvars;
init_vars;

% Limiar de decisão
lim = 0.5/2;

out = sim('ASK_coerente');

t = out.y_ask.time;
y_ask = squeeze(out.y_ask.data);
z_ask = squeeze(out.z_ask.data);

figure(10);
format_fig(900, 200);
clf;
hold on;
plot(t*1e3, y_ask);
plot(t*1e3, z_ask);
xlim([0, 10]);
ylim([-0.05, 1]);
xlabel('Tempo [ms]');
ylabel('Tensão [V]');
legend('y\_ask', 'z\_ask');

% npontos = 10;
% limiares = linspace(0, 1, npontos);
% pe = zeros(length(limiares), 1);
% 
% % variância do ruido
% sigmaquadrado = 1e2;
% 
% f = waitbar(0, sprintf('Simulando transmissão de %d bits a %d bits/s com %d samples por bit.\nVariância do ruído:%.2e. Número de pontos: %d.', n_bits, rb, spb, sigmaquadrado, npontos));
% %% Simulação
% for ii = 1:length(limiares)
%     lim = limiares (ii);
%     out = sim('ASK_coerente');
%     pe(ii) = out.pe;
%     waitbar(ii/length(limiares),f);
% end
% close(f);
% 
% figure(2);
% clf;
% plot(limiares, pe);
% xlabel('Limiar de Decisão');
% ylabel('Probabilidade de Erro');
% 



