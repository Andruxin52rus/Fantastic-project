% CONSTANT PARAMETERS

NUMBER_OF_RAYS = 2;
SEQUENCE_LENGTH = 63;

% MATRIXES INIT

% S - training matrix. S(1:NUMBER_OF_RAYS + SEQUENCE_LENGTH - 1) is a first
% vector and so on
S = zeros(NUMBER_OF_RAYS + SEQUENCE_LENGTH - 1, NUMBER_OF_RAYS); % (8.1.27) and (8.1.28)
sequence = generateZadoffChu(SEQUENCE_LENGTH, 5, 0); % Zadoff-Chu sequence
% look at the (8.1.27) formula to understand that cycle
for i = 1 : NUMBER_OF_RAYS
    for j = i : i + SEQUENCE_LENGTH - 1
        S(j, i) = sequence(j - i + 1); % (8.1.27)
    end
end
% H - channel coefficients (rayleigh distribution)
H = (randn(NUMBER_OF_RAYS, 1) + 1i * randn(NUMBER_OF_RAYS, 1)) / sqrt(2);
% Z - gaussian noise vector
Z = (randn(NUMBER_OF_RAYS + SEQUENCE_LENGTH - 1, 1) + 1i * randn(NUMBER_OF_RAYS + SEQUENCE_LENGTH - 1, 1)) / sqrt(2);
% X - result matrix of received sequence after going through channel
X = S * H + Z; % (8.1.29)
M = S' * S; % p. 314
R = S' * X; % p. 314
H_estimate = M^(-1) * R; % channel estimate
