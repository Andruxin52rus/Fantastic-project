% look for details in BSS_LTE.pdf at 59 slide
function sequence = generateZadoffChu(length, u, cyclic_shift)
    % returns Zadoff-Chu sequence
    sequence = zeros(1, length); % preallocating memory for sequence vector
    for index = cyclic_shift : cyclic_shift + length - 1;    
        sequence(index - cyclic_shift + 1) = exp(-1i*2*pi*u*(index - cyclic_shift)*(index - cyclic_shift + 1)/2/length);
        % plot(real(sequence(index - cyclic_shift + 1)), imag(sequence(index - cyclic_shift + 1)), '*');
        % hold on
    end
    % grid on
end
