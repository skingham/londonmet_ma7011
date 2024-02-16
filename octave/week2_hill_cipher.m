
function C = co_factor_matrix(A)
    % Calculate the cofactor matrix of A
    [rows, cols] = size(A);
    C = zeros(rows, cols);
    for r = 1:rows
        for c = 1:cols
            % Minor of A(r, c)
            Minor = A;
            Minor(r, :) = [];
            Minor(:, c) = [];
            % Cofactor of A(r, c)
            C(r, c) = (-1)^(r+c) * det(Minor);
        end
    end
end


function A_adj = adjugate(A)
    % Calculate the matrix of cofactors
    C = co_factor_matrix(A);
    % Transpose the matrix of cofactors to get the adjugate
    A_adj = C';
end


function inv = multiplicative_inverse_mod_m(a, m)
    % Extended Euclidean Algorithm to find the multiplicative inverse of a modulo m
    [g, x, ~] = gcd(a, m);
    if g == 1
        inv = mod(x, m);
    else
        inv = -1; % No inverse exists if gcd(a, m) is not 1
    end
end

function E_inv_mod = inverse_mod_26(E)
    % Calculate the determinant of E and apply modulo 26
    % Todo: test whether determinant is integer, or that E is integer
    detE = int32(mod(det(E), 26));

    % Find the multiplicative inverse of detE modulo 26
    detE_inv = multiplicative_inverse_mod_m(detE, 26);

    % Check if multiplicative inverse exists
    if detE_inv == -1
        error('Inverse does not exist. The determinant has no multiplicative inverse modulo 26.');
    end

    % Calculate the adjugate of E and apply modulo 26
    adjE = mod(adjugate(E), 26);

    % Multiply adjugate of E by the multiplicative inverse of the determinant modulo 26
    E_inv_mod =  double(mod(detE_inv * adjE, 26));
end


function int_array = hill_transform(E, message)
    % Determine the rank of E
    n = rank(E);

    % Pad message with 23 if its length is not divisible by n
    if mod(length(message), n) ~= 0
        paddingSize = n - mod(length(message), n);
        message = [message, repmat(23, 1, paddingSize)];
    end

    % Initialize an empty array for the new list of integers
    newList = [];

    % Process the message in chunks of n and multiply by E
    for i = 1:n:length(message)
        % Extract a sublist of n integers from message
        sublist = message(i:i+n-1)';

        % Multiply by E
        result = mod(E * sublist, 26);

        % Concatenate the result into newList
        newList = [newList; result];
    end

    % Flatten newList to a single row if desired
    int_array = newList(:)';
end

function numeric_vector = convert_string_to_integers(inputString)
    % Convert the input string to uppercase
    upperString = upper(inputString);

    % Keep only characters between 'A' and 'Z'
    filteredString = upperString(isstrprop(upperString, 'alpha'));

    % Convert characters to numbers ('A' to 0, ..., 'Z' to 25)
    numeric_vector = double(filteredString) - double('A');
end

function output_string = convert_integers_to_string(numeric_vector)
    % Since 'A' is represented by 0, we add 65 (ASCII value of 'A') to each .
    charVector = char(numeric_vector + 'A');

    % Convert the array of characters into a string
    output_string = charVector;
end


E = [6, 24, 1; 13, 16, 10; 20, 17, 15];
D = inverse_mod_26(E);
displ(inverse_mod_26(E));

plain_text = 'Hello, Meet me at the toga party!';
message = convert_string_to_integers(plain_text);
disp(message);

disp(plain_text);
disp(message);
disp(hill_transform(E, message));
disp(hill_transform(D, hill_transform(E, message)));

disp(convert_integers_to_string(hill_transform(E, message)));
disp(convert_integers_to_string(hill_transform(D, hill_transform(E, message))));
