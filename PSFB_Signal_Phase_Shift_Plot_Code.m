
%% ===== Extract Signals =====
S1 = out.logsout.get('S1').Values;
S2 = out.logsout.get('S2').Values;
S3 = out.logsout.get('S3').Values;
S4 = out.logsout.get('S4').Values;

Q1 = out.logsout.get('Q1').Values;
Q2 = out.logsout.get('Q2').Values;
Q3 = out.logsout.get('Q3').Values;
Q4 = out.logsout.get('Q4').Values;

t = S1.Time(:);

%% ===== Zoom Window: 0.1 ± 1e-3 =====
t_start = 0.1 - 1e-4;
t_end   = 0.1 + 1e-4;

idx = (t >= t_start) & (t <= t_end);

t_zoom = t(idx);

S1 = S1.Data(idx);
S2 = S2.Data(idx);
S3 = S3.Data(idx);
S4 = S4.Data(idx);

Q1 = Q1.Data(idx);
Q2 = Q2.Data(idx);
Q3 = Q3.Data(idx);
Q4 = Q4.Data(idx);

%% ===== Plot =====
figure;

% -------- S1 & S4 --------
subplot(2,1,1);
stairs(t_zoom, S1, 'b', 'LineWidth', 1.8); hold on;
stairs(t_zoom, S4, 'r--', 'LineWidth', 1.8);

ylim([-0.2 1.2]);
grid on;

title('Primary Switch Gate Pulses (S1–S4)');
ylabel('Gate Signal');

legend('S1', 'S4', 'Location', 'best');

%% Phase shift indication (PRIMARY)
[~, i1] = max(diff(S1));   % rising edge S1
[~, i2] = max(diff(S4));   % rising edge S4

if i1>0 && i2>0
    t1 = t_zoom(i1);
    t2 = t_zoom(i2);

    plot([t1 t2], [1.1 1.1], 'k', 'LineWidth', 1.5);
    text(mean([t1 t2]), 1.12, ...
        sprintf('Phase Shift = %.2e s', abs(t2-t1)), ...
        'HorizontalAlignment','center');
end

%% -------- Q1 & Q4 --------
subplot(2,1,2);
stairs(t_zoom, Q1, 'm', 'LineWidth', 1.8); hold on;
stairs(t_zoom, Q4, 'k--', 'LineWidth', 1.8);

ylim([-0.2 1.2]);
grid on;

title('Secondary Switch Gate Pulses (Q1–Q4)');
xlabel('Time (s)');
ylabel('Gate Signal');

legend('Q1', 'Q4', 'Location', 'best');

%% Phase shift indication (SECONDARY)
[~, i3] = max(diff(Q1));
[~, i4] = max(diff(Q4));

if i3>0 && i4>0
    t3 = t_zoom(i3);
    t4 = t_zoom(i4);

    plot([t3 t4], [1.1 1.1], 'k', 'LineWidth', 1.5);
    text(mean([t3 t4]), 1.12, ...
        sprintf('Phase Shift = %.2e s', abs(t4-t3)), ...
        'HorizontalAlignment','center');
end