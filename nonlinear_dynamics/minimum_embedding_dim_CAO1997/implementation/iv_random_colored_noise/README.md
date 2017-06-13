USAGE
---

Run Fortran with 
```
        open(9,file='randomcolorednoise_xn_N10000.dat')       ! Data file       
        open(10,file='E1_f_N10000.dat')
        open(11,file='E2_f_N10000.dat')
```


```
$ gfortran dimensionLiangyueCao1997_f.f
./a.out 
```
which creates: file='E1_f_N10000.dat' and file='E2_f_N10000.dat'

Then 
```  
R 
> source(paste(getwd(),"/ploting_comparing_E1E2_fotran_values.R", sep=""), echo=TRUE)
```


