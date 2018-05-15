
# problem
Finding a matching pair that is equal to a sum which in this case is 8.
[1,2,3,9], sum=8, no
[1,2,4,4], sum=8, yes



** first approach is to use brute force using two force to scan
all the arrays, but this method might be computational heavy
which is a fair reason to not take this approach

(-) two for loops is a  N^2 quadratic operation 



** second approach is using binary search, where
for example, scan the array value and then serach for a 
match until it finish the array

(+) binary search is a log algorighth which better than quadratic
(-) binary serach is unidirectional  
(-) n log operations, where n is the number of elements of the array

** third approach (recommendations
using [1,2,3,9]
range between 1 9 which is nothing that can be largerst than 1+9 or smaller than 1+9
if 1+9 >= 8 either stop or discard 9 and move the value to 3
if 1+3 is smaller than 8 then discar 1 and move the value to 2

move the higher lower if the pair is too large
move the lower higher if the pair is too small

it ends whenever it find a pair 
or whenever the pair sum is cross

(+) linear solution


return 

bool - true/false
pair - (4,4)/(3,4)


 
# References
* Edgar Duenez Guzman - http://duenez.evolicious.org/
* [how did Edgar get recruited to Google](https://www.quora.com/How-did-Edgar-A-Duenez-Guzman-get-recruited-to-Google)
* [:link:](https://www.youtube.com/watch?v=XKu_SEDAykw)



