function [U, S, V] = mySVD(A)
%A function to compute the Singular Value
%Decoposition of a Matrix A
%By finding the Eigen Vectors of A^TA and AA^T
[m, n] = size(A);

%for U which is the matrix of eigen vectors for AA^T
B = A*A';
[U, eU] = eig(B);

%For V which is the matrix of eigen vectors for A^TA
C = A'*A;
[V, eV] = eig(C);

%eU and eV are diaginal matrices of (the same) real eigen values
%Real since the matrices B and C are symmetric

%Reorder both and then pick S
% Take square root to get singular values
% Square root will eithe rbe purely real or purely imaginary
eU = eU.^(1/2);
% In case the eigen value was negative,
eU = abs(eU);
[dU, Uorder] = sort(diag(eU), 'descend');
eU = diag(dU);

eV = eV.^(1/2);
eV = abs(eV);
[dV, Vorder] = sort(diag(eV), 'descend');
eV = diag(dV);

if(n > m)
    S = eV(1:m,:);
else 
    S = eU(:,1:n);
end

%Reorder U and V in accordance with eigen values
U = U(:, Uorder);
V = V(:, Vorder);

%Modify V to make sure that AV = US is satisfied with modified S
%Check sign consistency for every column, if not invert sign of V

k = min(m ,n);

for i = 1:k
    %A times ith column of V
    a = A*V(:,i);
    b = U(:,i);
    %If inconsitent sign, then invert
    if(dot(a, b) < 0)
        V(:,i) = -V(:,i);
    end 
end

end