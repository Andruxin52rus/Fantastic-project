rad_to_grad = 57.2958;
r = 17;
D = 100;
teta_max = round(asin(r / D), 4);
% theoretical graph
teta = -teta_max + 0.0001:0.0001:teta_max - 0.0001;
p = 1 ./ (pi * cos(abs(teta)) .^ 2 .* sqrt(tan(teta_max) .^ 2 - tan(abs(teta)) .^ 2));
plot(teta * rad_to_grad, p / max(p), '--');
hold on
% experimental graph
phi_pos = 0:0.0001:round(pi, 4);
phi_neg = round(-pi, 4):0.0001:0;
teta_pos = acos((D - r .* cos(phi_pos)) ./ sqrt(r * r - 2 * r .* cos(phi_pos) * D + D * D));
teta_neg = -acos((D - r .* cos(phi_neg)) ./ sqrt(r * r - 2 * r .* cos(phi_neg) * D + D * D));
teta = cat(2, teta_neg, teta_pos);
[m, t] = hist(teta, 1000);
PDF = m; %probability density function
plot(t * rad_to_grad, PDF / max(PDF), '-.');
