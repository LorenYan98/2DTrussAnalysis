%Formula that used to calculate the local stiffness, eg. K1 K2 K3...Kn
function k = local_stiffness(L, E, I, A)

k = E*I/L^3 .* [ A*L^2/I,   0,    0,      -A*L^2/I,  0,     0;
                 0,         12,   6*L,    0,         -12,   6*L;
                 0,         6*L,  4*L^2,  0,         -6*L,  2*L^2;
                 -A*L^2/I,  0,    0,      A*L^2/I,   0,     0;
                 0,         -12,  -6*L,   0,         12,    -6*L;
                 0,         6*L,  2*L^2,  0,         -6*L,  4*L^2];
end

