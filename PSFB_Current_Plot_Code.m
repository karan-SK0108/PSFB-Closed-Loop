%% ===== Extract Signals =====
Iout_sig = out.logsout.get('Iout').Values;

t    = Iout_sig.Time(:);
Iout = Iout_sig.Data(:);

%% ===== Plot =====
figure;
plot(t, Iout, 'm', 'LineWidth', 1.8); hold on;

grid on;
xlabel('Time (s)');
ylabel('Current (A)');
title('PSFB Converter Output Current Response');

legend('I_{out}', 'Location', 'southeast');

%% ===== Find Maximum Current =====
[Imax, idx_max] = max(Iout);

%% Mark Peak Point
plot(t(idx_max), Imax, 'ko', ...
    'MarkerFaceColor', 'k', ...
    'MarkerSize', 7);

hold on;

%% Adjusted Label Position (FIXED)
y_offset = 0.15;   % vertical spacing
x_offset = 0.002;  % horizontal spacing

text(t(idx_max) + x_offset, Imax - y_offset, ...
    sprintf('I_{max} = %.2f A', Imax), ...
    'FontWeight','bold', ...
    'FontSize', 11, ...
    'Color','k');