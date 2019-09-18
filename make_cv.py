import sys,os
import numpy as np
from sklearn.utils import shuffle

if len(sys.argv)<5:
  print("input_x input_y output_prefix fold")
  quit()

Xall=np.loadtxt(sys.argv[1])
Yall=np.loadtxt(sys.argv[2])
Xall,Yall=shuffle(Xall,Yall)
n=Xall.shape[0]
fold=int(sys.argv[4])
unit=round(n/fold)
for i in range(0,fold):
  v_start=i*unit
  v_end=i*unit+unit
  #print(str(v_start)+" "+str(v_end))
  of1=open(sys.argv[3]+"."+str(i)+".X.trn","w")
  of2=open(sys.argv[3]+"."+str(i)+".X.tst","w")
  of3=open(sys.argv[3]+"."+str(i)+".Y.trn","w")
  of4=open(sys.argv[3]+"."+str(i)+".Y.tst","w")
  for j in range(0,n):
    rowx=[str(x) for x in list(Xall[j,:])]
    rowy=[str(y) for y in list(Yall[j,:])]
    if j>=v_start and j<v_end:
      of2.write('\t'.join(rowx)+"\n")
      of4.write('\t'.join(rowy)+"\n")
    else:
      of1.write('\t'.join(rowx)+"\n")
      of3.write('\t'.join(rowy)+"\n")

        

