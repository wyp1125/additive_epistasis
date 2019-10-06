import os,sys
import numpy as np
from sklearn import metrics
if len(sys.argv)<2:
  print("input_epi input_out") 
  exit
data=np.loadtxt(sys.argv[1],delimiter='\t')
cls=np.loadtxt(sys.argv[2],delimiter='\t')
data_epi=np.sum(data,1)
#print(data_epi.shape)
#print(cls[:,0].shape)
fpr,tpr,thresholds=metrics.roc_curve(cls[:,0],data_epi)
auc=metrics.auc(fpr, tpr)
print(auc)

