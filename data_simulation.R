n_indv=4000
n_loci=1000
n_samp=n_indv/2
n_epis=2
n_rept=100
maf_high=0.1
maf_low=0.01
gt_case=array(0,dim=c(n_samp,n_loci))
gt_cntl=array(0,dim=c(n_samp,n_loci))

for(i in 1:(n_loci/n_epis))
{
  max_int=-1
  saved_gt=array(0,dim=c(n_samp,n_epis))
  saved_maf=array(0,dim=c(n_epis))
  for(t in 1:n_rept)
  {
    mul_gt=array(0,dim=c(n_samp))
    tmp_gt=array(0,dim=c(n_samp,n_epis))
    tmp_maf=array(0,dim=c(n_epis))
    for(j in 1:n_epis)
    {
      maf=runif(1,maf_low,maf_high)
      tmp_maf[j]=maf
      prob_nt1=runif(n_samp)
      prob_nt2=runif(n_samp)
      for(k in 1:n_samp)
      {
        tmp_nt1=0
        tmp_nt2=0
        if(prob_nt1[k]<=maf)
        {
          tmp_nt1=1
        }
        if(prob_nt2[k]<=maf)
        {
          tmp_nt2=1
        }
        tmp_gt[k,j]=tmp_nt1+tmp_nt2
        eff=0
        if(tmp_gt[k,j]==2)
        {
          eff=1
        }
        if(j==1)
        {
          mul_gt[k]=eff
        }
        else
        {
          mul_gt[k]=mul_gt[k]*eff
        }
      }
    }
    total_int=sum(mul_gt)
    if(total_int>max_int)
    {
      max_int=total_int
      saved_gt=tmp_gt
      saved_maf=tmp_maf
    }
  }
  #print(max_int)
  ctl_gt=array(0,dim=c(n_samp,n_epis)) 
  for(j in 1:n_epis)
  {
    maf=saved_maf[j]
    prob_nt1=runif(n_samp)
    prob_nt2=runif(n_samp)
    for(k in 1:n_samp)
    {
      tmp_nt1=0
      tmp_nt2=0
      if(prob_nt1[k]<=maf)
      {
        tmp_nt1=1
      }
      if(prob_nt2[k]<=maf)
      {
        tmp_nt2=1
      }
      ctl_gt[k,j]=tmp_nt1+tmp_nt2
    }
  }
  gt_case[,(((i-1)*n_epis+1):(i*n_epis))]=saved_gt
  gt_cntl[,(((i-1)*n_epis+1):(i*n_epis))]=ctl_gt
}

grs_case=array(0,dim=c(n_samp))
grs_cntl=grs_case
wt=1+runif(n_loci/n_epis)
for(i in 1:n_samp)
{
  for(j in 1:(n_loci/n_epis))
  {
    inc_case=1
    inc_cntl=1
    for(k in 1:n_epis)
    {
      fac_case=0
      fac_cntl=0
      if(gt_case[i,(j-1)*n_epis+k]==2)
      {
        fac_case=1
      }
      inc_case=inc_case*fac_case
      if(gt_cntl[i,(j-1)*n_epis+k]==2)
      {
        fac_cntl=1
      }
      inc_cntl=inc_cntl*fac_cntl
    }
    grs_case[i]=grs_case[i]+wt[j]*inc_case
    grs_cntl[i]=grs_cntl[i]+wt[j]*inc_cntl
  }
}
t.test(grs_case,grs_cntl)
dummy_gt=array(0,dim=c(n_indv,(2*n_loci)))
dummy_out=array(0,dim=c(n_indv,2))
for(i in 1:n_samp)
{
  for(j in 1:n_loci)
  {
    if(gt_case[i,j]==1)
    {
      dummy_gt[i,(2*j-1)]=1
    }
    if(gt_case[i,j]==2)
    {
      dummy_gt[i,(2*j-2)]=1
      dummy_gt[i,(2*j-1)]=1
    }
    if(gt_cntl[i,j]==1)
    {
      dummy_gt[(n_samp+i),(2*j-1)]=1
    }
    if(gt_cntl[i,j]==2)
    {
      dummy_gt[(n_samp+i),(2*j-2)]=1
      dummy_gt[(n_samp+i),(2*j-1)]=1
    }
  }
  dummy_out[i,]=c(1,0)
  dummy_out[n_samp+i,]=c(0,1)
}
write.table(dummy_gt,file="sim.gt.txt",col.names=FALSE,row.names=FALSE,sep="\t")
write.table(dummy_out,file="sim.out.txt",col.names=FALSE,row.names=FALSE,sep="\t")


