%% ===== Extract Signals from logsout =====
Vout_sig = out.logsout.get('Vout').Values;
Iout_sig = out.logsout.get('Iout').Values;

% Extract time & data
t  = Vout_sig.Time(:);
Vout = Vout_sig.Data(:);
Iout = Iout_sig.Data(:);
Vref_const = out.logsout.get('Vref').Values.Data(end); % constant value

%% ===== Graph 1: Vout & Vref vs Time =====
figure;
plot(t, Vout, 'b', 'LineWidth', 1.5); hold on;
plot([t(1) t(end)], [Vref_const Vref_const], '--r', 'LineWidth', 3);

grid on;
xlabel('Time (s)');
ylabel('Voltage (V)');
title('PSFB Converter Output Voltage Response');

legend('V_{out}', 'V_{ref}', 'Location', 'best');
ylim([0 max(Vout)*1.1]);

% Annotation (final values)

text(0.01, Vref_const+20, ...
    sprintf('Vref = %.0f V', Vref_const), ...
    'Color','r', 'FontWeight','bold');

idx_label = round(length(t)*0.75);

text(t(idx_label), Vout(idx_label)-1, ...
    sprintf('Vout = %.1f V', Vout(end)), ...
    'Color','b', 'FontWeight','bold');
