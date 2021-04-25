
load('Hypermatrix_Algebra_tst.sage')

sz = 7; La = var_list('a', sz); P = sum(La[i]*x**i for i in range(sz))

print(P)

print(ModuloII(P, [x], [x-var('b')]))

Lc = var_list('c', floor(sz/2)); Q = prod(x-Lc[k] for k in rg(floor(sz/2)))

print(Q)

print(ModuloII(P, [x], [Q]))