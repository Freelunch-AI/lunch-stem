# Usage
## Info
N = log(max number analyzed - 1)
## Commands (from root)
>> cd c_program 
>> gcc -o prime_numbers prime_numbers.c
>> ./prime_numbers.exe <N>
# Benchmarking with time or hyperfine 
See installation here: https:github.com/sharkdp/hyperfine
## Commands (from root)
### C
>> cd c_program 
>> time ./prime_numbers.exe <N>
>> hyperfine --min-runs 5 --parameter-scan N 24 26 --export-markdown ./prime_numbers.exe {N}
### Python
>> pip install bitarray
>> cd python_program
>> time python ./prime_numbers.py <N>
>> hyperfine --min-runs 5 --parameter-scan N 24 26 --export-markdown python ./prime_numbers.py {N}