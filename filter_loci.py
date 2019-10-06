import sys
import numpy as np
from scipy.stats import chi2_contingency
ct={}
ct["AFR"]=661
ct["AMR"]=347
ct["EAS"]=504
ct["EUR"]=503
ct["SAS"]=489
lines=open(sys.argv[1],"r")
with open(sys.argv[2],"w") as of:
  i=0
  for eachLine in lines:
    if i==0:
      word=eachLine.strip().split("\t")
      pop1=word[5]
      pop2=word[6]     
    else:
      word=eachLine.strip().split("\t")
      n=[]
      x=[]
      tmp1=round(ct[pop1]*2*float(word[5]))
      x.append(tmp1)
      tmp2=ct[pop1]*2-tmp1
      x.append(tmp2)
      n.append(x)
      y=[]
      tmp1=round(ct[pop2]*2*float(word[6]))
      y.append(tmp1)
      tmp2=ct[pop2]*2-tmp1
      y.append(tmp2)
      n.append(y)
      m=np.array(n)
      try:
        x=chi2_contingency(m)
      except:
        next
      if x[1]>0.00001 and float(word[5])<0.5 and float(word[6])<0.5 and len(word[3])==1 and len(word[4])==1:
        of.write(eachLine)
    i=i+1
