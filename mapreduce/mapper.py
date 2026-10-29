import sys 

for line in sys.stdin:
    fields = line.rstrip('\n').split(',')
    if fields[0] == 'user_id':
        continue
    print(f'{fields[3]}\t1')