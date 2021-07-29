
load('Hypermatrix_Algebra_tst.sage')

generate_supgraph_unlabeled_listing_script(3, [])

load('Unlabeled_supgraph_Listing_of_Directed_Graphs_on_3_vertices.sage')

print(L)

# Below will fail because of exponents in L[0] !
Monomial2DiGraph(L[0], HM(3, 3, 'a_a').list(), 3).plot()

Lall = L

generate_unlabeled_functional_listing_script(3)

load('Unlabeled_Listing_of_Functional_Graphs_on_3_vertices.sage')

print(L)

# Below will still fail because of exponents in L[0] !
Monomial2DiGraph(L[0], HM(3, 3, 'a_h').list(), 3).plot()

Monomial2DiGraph(a_l02*a_l10*a_l21,HM(3,3,'a_l').list(), 3).plot()

Monomial2DiGraph(a_b01*a_b10*a_b20,HM(3,3,'a_b').list(), 3).plot()

len(L)



generate_unlabeled_functional_listing_script(4)

load('Unlabeled_Listing_of_Functional_Graphs_on_4_vertices.sage')

print(L)

len(L)