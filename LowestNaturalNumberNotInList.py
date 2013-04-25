# by Wit Chitrapongse, https://github.com/wchitra
#
# Algorithm to find lower natural number contained in a set with linear runtime
# -- Go thru the input array and find the max value
# -- then create another array of size of the max value, O(n)
# -- go thru the input array and assign it to the new array at the index of it's number, O(n)
# -- loop thru the new array and return the first index where the value is null/empty, O(n - # of iteration)
# -- O(n) + O(n) + O(n - # of iterations) => O(n)
#

import sys

input = [8, 23, 9, 0, 12, 11, 1, 10, 13, 7, 41, 4, 14, 21, 5, 17, 3, 19, 2, 6]
#input = [8, 23, 9, 0, 12, 11, 1, 10, 13, 7, 41, 4, 14, 21, 5, 17, 3, 19, 2, 6, 15, 16]
#input = [8, 23, 'B', 0, 12, 11, 1, 10, 13, 7, 41, 4, 14, 21, 5, 17, 3, 19, 2, 6, 15, 16]

# check if the input consist of all natural numbers
isNaturalNumber = True
for i in input:
	if not isinstance(i, int) and i >= 0:
		isNaturalNumber = False

if not isNaturalNumber:
	sys.exit("Some values in the input is not a not a natural number")

# find the max value of input, so that an array size can be determined.
max = input[0]
for i in range(len(input)):
	if max < input[i]:
		max = input[i];

# create an array of size of max of the input set
output = [None] * max;
for i in input:
	output[i-1] = i

# loop thru the new array and return the first index where the value is null/empty
lowest_natural = None
for i in range(len(output)):
	if output[i] is None:
		lowest_natural = i + 1;
		break

print lowest_natural
