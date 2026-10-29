import sys
current, count = None, 0 
for line in sys.stdin:
    key, value = line.rstrip('\n').split('\t')
    if key != current:
        if current is not None:
            print(f'{current}\t{count}')
        current, count = key, 0
    count += int(value)
if current is not None:
   print(f'{current}\t{count}') 