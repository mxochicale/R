
@article{uzal2011,
  title = {Optimal reconstruction of dynamical systems: A noise amplification approach},
  author = {Uzal, L. C. and Grinblat, G. L. and Verdes, P. F.},
  journal = {Phys. Rev. E},
  volume = {84},
  issue = {1},
  pages = {016223},
  numpages = {17},
  year = {2011},
  month = {Jul},
  publisher = {American Physical Society},
  doi = {10.1103/PhysRevE.84.016223},
}
  url = {https://link.aps.org/doi/10.1103/PhysRevE.84.016223}


  The program computes
  the global and local cost function for DC, fDC, and Legendre
  coordinates, which are internally implemented. Alternatively,
  it also allows loading reconstructions from external files and
  then computes corresponding local or global cost function
  values. We also provide scripts to reproduce Figs. 1, 2, 15(b),
  and 16.



```
tar -xvzf optimal_embedding.tar.gz
```

```
./configure
make
```

```
make[2]: Entering directory '/home/map479/mxochicale/github/r-code_repository/nonlinearDynamics/uzal2011/optimal_embedding/source_c/routines'
cc -O3   -c -o get_series.o get_series.c
cc -O3   -c -o rescale_data.o rescale_data.c
cc -O3   -c -o make_box.o make_box.c
cc -O3   -c -o find_neighbors.o find_neighbors.c
cc -O3   -c -o scan_help.o scan_help.c
cc -O3   -c -o variance.o variance.c
cc -O3   -c -o get_multi_series.o get_multi_series.c
cc -O3   -c -o search_datafile.o search_datafile.c
cc -O3   -c -o check_option.o check_option.c
cc -O3   -c -o solvele.o solvele.c
cc -O3   -c -o rand.o rand.c
cc -O3   -c -o eigen.o eigen.c
cc -O3   -c -o test_outfile.o test_outfile.c
cc -O3   -c -o invert_matrix.o invert_matrix.c
cc -O3   -c -o exclude_interval.o exclude_interval.c
cc -O3   -c -o make_multi_box.o make_multi_box.c
cc -O3   -c -o find_multi_neighbors.o find_multi_neighbors.c
cc -O3   -c -o check_alloc.o check_alloc.c
cc -O3   -c -o myfgets.o myfgets.c
cc -O3   -c -o what_i_do.o what_i_do.c
cc -O3   -c -o make_multi_index.o make_multi_index.c
cc -O3   -c -o make_multi_box2.o make_multi_box2.c
cc -O3   -c -o rand_arb_dist.o rand_arb_dist.c
ar r libddtsa.a get_series.o rescale_data.o make_box.o find_neighbors.o scan_help.o variance.o get_multi_series.o search_datafile.o check_option.o solvele.o rand.o eigen.o test_outfile.o invert_matrix.o exclude_interval.o make_multi_box.o find_multi_neighbors.o check_alloc.o myfgets.o what_i_do.o make_multi_index.o make_multi_box2.o rand_arb_dist.o
ar: creating libddtsa.a
ranlib libddtsa.a
make[2]: Leaving directory '/home/map479/mxochicale/github/r-code_repository/nonlinearDynamics/uzal2011/optimal_embedding/source_c/routines'
cc -O3  -o costfunc costfunc.c routines/libddtsa.a -lm
costfunc.c: In function ‘main’:
costfunc.c:322:19: warning: too many arguments for format [-Wformat-extra-args]
    fprintf(stderr,"Computing local cost function\n",Nref);
                   ^
make[1]: Leaving directory '/home/map479/mxochicale/github/r-code_repository/nonlinearDynamics/uzal2011/optimal_embedding/source_c'
```
