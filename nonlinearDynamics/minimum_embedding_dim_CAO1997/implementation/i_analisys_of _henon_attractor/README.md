USAGE
---

Fortran with  "open(9,file='henon_xn_N1000.dat')"
```
$ gfortran dimensionLiangyueCao1997_f.f
./a.out 
```
which creates: file='E1_f_N1000.dat' and file='E2_f_N1000.dat'

Then 
```  
R 
> source(paste(getwd(),"/ploting_E1E2_fotran_values.R", sep=""), echo=TRUE)
```




# ISSUES

* Running "dimensionLiangyueCao1997_R.R" take a while to compute the values to which I suggest to avoid to run such script.
* when runnging  gfortran dimensionLiangyueCao1997_f.f with     ndp=10000:
Program received signal SIGSEGV: Segmentation fault - invalid memory reference.




