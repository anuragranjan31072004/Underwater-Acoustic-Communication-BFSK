function [bit_decision, energy_f0, energy_f1, decision_valid] = goertzel_fsk_detector(input_sample)
% Goertzel-based FSK detector for underwater acoustic communication
% Works sample-by-sample, no external Buffer or ZOH required.
%
% Input:
%   input_sample - one sample at a time (double)
%
% Output:
%   bit_decision   - 0 or 1 when decision is valid, last value otherwise
%   energy_f0      - energy at 600 Hz (normalized)
%   energy_f1      - energy at 1100 Hz (normalized)
%   decision_valid - 1 when a new bit decision is available, 0 otherwise

% ---------------- System parameters ----------------
fs = 100000;          % Sample rate (100 kHz)
f0 = 600;             % Frequency for bit 0
f1 = 1100;            % Frequency for bit 1
bit_duration = 0.004; % Bit duration (4 ms)
N = round(bit_duration * fs); % Samples per bit = 400

% ---------------- Persistent state ----------------
persistent buffer sample_count last_decision

if isempty(buffer)
    buffer = zeros(N,1);
    sample_count = 0;
    last_decision = 0;
end

% ---------------- Fill buffer ----------------
sample_count = sample_count + 1;
buffer(sample_count) = input_sample;

% ---------------- Default outputs ----------------
bit_decision   = last_decision;
energy_f0      = 0;
energy_f1      = 0;
decision_valid = 0;

% ---------------- Process when buffer is full ----------------
if sample_count >= N
    % Frequency bins
    k0 = round(N * f0 / fs);
    k1 = round(N * f1 / fs);

    % Goertzel coefficients
    omega0 = 2 * pi * k0 / N;
    omega1 = 2 * pi * k1 / N;
    coeff0 = 2 * cos(omega0);
    coeff1 = 2 * cos(omega1);

    % --- Energy at f0 ---
    q0_prev2 = 0;
    q0_prev1 = 0;
    for i = 1:N
        q0_curr = coeff0 * q0_prev1 - q0_prev2 + buffer(i);
        q0_prev2 = q0_prev1;
        q0_prev1 = q0_curr;
    end
    energy_f0 = (q0_prev1^2 + q0_prev2^2 - coeff0*q0_prev1*q0_prev2) / N;

    % --- Energy at f1 ---
    q1_prev2 = 0;
    q1_prev1 = 0;
    for i = 1:N
        q1_curr = coeff1 * q1_prev1 - q1_prev2 + buffer(i);
        q1_prev2 = q1_prev1;
        q1_prev1 = q1_curr;
    end
    energy_f1 = (q1_prev1^2 + q1_prev2^2 - coeff1*q1_prev1*q1_prev2) / N;

    % Decision
    if energy_f1 > energy_f0
        bit_decision = 1;
    else
        bit_decision = 0;
    end

    % Update persistent last decision
    last_decision = bit_decision;

    % Reset buffer
    sample_count = 0;
    buffer(:) = 0;

    % Mark that this sample produced a valid decision
    decision_valid = 1;
end

% Ensure outputs are doubles
bit_decision   = double(bit_decision);
energy_f0      = double(energy_f0);
energy_f1      = double(energy_f1);
decision_valid = double(decision_valid);

end
