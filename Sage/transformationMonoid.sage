
load('Hypermatrix_Algebra_tst.sage')

sz = 3; A = HM(sz, sz, 'a')

A.printHM()

transMonoid = prod(sum(A[i,j] for j in range(sz)) for i in range(sz)).expand()

for graph in transMonoid.operands():
	print(graph)
	Monomial2DiGraph(graph, A.list(), sz).plot()