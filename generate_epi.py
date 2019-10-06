import sys
import numpy as np
from scipy.stats import chi2_contingency
if len(sys.argv)<4:
  print("input_gt output_prefix case_id")
  quit()
fl=open(sys.argv[1],"r")
line=fl.readlines()
n=len(line)
word=line[0].strip().split("\t")
cls=[int(s) for s in word[1:]]
nindv=len(cls)
nsamp=[0,0]
for s in cls:
  nsamp[int(s)]=nsamp[int(s)]+1
print(nsamp)
gt=[]
tag=[]
for i in range(1,n):
  tmp_gt=[]
  word=line[i].strip().split("\t")
  tag.append(0)
  tmp_gt=[int(s) for s in word[1:]]
  gt.append(tmp_gt)
#print(gt)
nloci=1000
selrows=[0 for i in range(0,nloci)]
nepis=2
nsets=int(nloci/nepis)
case_id=int(sys.argv[3])
m=0
cut=0.01
while m<nsets:
#while m<100000:
  sel=np.random.choice(n-1,2)
  while tag[sel[0]]==1 or tag[sel[1]]==1 or abs(sel[0]-sel[1])<10:
    sel=np.random.choice(n-1,2)
  ninc=[0,0]
  for i in range(0,nindv):
    if gt[sel[0]][i]==2 and gt[sel[1]][i]==2:
      ninc[cls[i]]=ninc[cls[i]]+1
  if ninc[case_id]>ninc[1-case_id]:
    x=np.array([[ninc[0],ninc[1]],[nsamp[0],nsamp[1]]])
    y=chi2_contingency(x)
    if y[1]<cut:
      tag[sel[0]]=1
      tag[sel[1]]=1
      selrows[2*m]=sel[0]
      selrows[2*m+1]=sel[1]
      print(str(m)+" "+str(nloci))
      m=m+1
with open(sys.argv[2]+".gt.txt","w") as of1:
  with open(sys.argv[2]+".epi.txt","w") as of2:
    with open(sys.argv[2]+".out.txt","w") as of3:
      for i in range(0,nindv):
        dummy_cls=[0,0]
        dummy_cls[cls[i]]=1
        of3.write(str(dummy_cls[1])+"\t"+str(dummy_cls[0])+"\n")
        for j in range(0,nsets):
          if gt[selrows[2*j]][i]==2 and gt[selrows[2*j+1]][i]==2:
             otag=1
          else:
             otag=0
          if j==0:
             of2.write(str(otag))
             of1.write(str(gt[selrows[2*j]][i])+"\t"+str(gt[selrows[2*j+1]][i]))
          else:
             of2.write("\t"+str(otag))
             of1.write("\t"+str(gt[selrows[2*j]][i])+"\t"+str(gt[selrows[2*j+1]][i]))
        of1.write("\n")
        of2.write("\n")
               
                       
