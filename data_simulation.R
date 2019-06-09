n_indv=2000
n_loci=2000
n_samp=n_indv/2
n_epis=2
n_rept=5000
maf_high=0.5
maf_low=0.025
gt_case=array(0,dim=c(n_samp,n_loci))
gt_cntl=array(0,dim=c(n_samp,n_loci))

for(i in 1:(n_loci/n_epis))
{
  print(i)
  max_inc=-1
  saved_case_gt=array(0,dim=c(n_samp,n_epis))
  saved_cntl_gt=array(0,dim=c(n_samp,n_epis))
  maf=runif(n_epis,maf_low,maf_high)
  for(t in 1:(n_rept+1))
  {
    mul_gt=array(0,dim=c(n_samp))
    tmp_gt=array(0,dim=c(n_samp,n_epis))
    for(j in 1:n_epis)
    {
      prob_nt1=runif(n_samp)
      prob_nt2=runif(n_samp)
      for(k in 1:n_samp)
      {
        tmp_nt1=0
        tmp_nt2=0
        if(prob_nt1[k]<=maf[j])
        {
          tmp_nt1=1
        }
        if(prob_nt2[k]<=maf[j])
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
    if(t==n_rept+1)
    {
      saved_cntl_gt=tmp_gt
    }
    else
    {
      total_inc=sum(mul_gt)
      if(total_inc>max_inc)
      {
        max_inc=total_inc
        saved_case_gt=tmp_gt
      }
    }
  }
  gt_case[,(((i-1)*n_epis+1):(i*n_epis))]=saved_case_gt
  gt_cntl[,(((i-1)*n_epis+1):(i*n_epis))]=saved_cntl_gt
}

epi_case=array(0,dim=c(n_samp,(n_loci/n_epis)))
epi_cntl=epi_case
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
    epi_case[i,j]=inc_case
    epi_cntl[i,j]=inc_cntl
  }
}

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
num_gt=rbind(gt_case,gt_cntl)
epi_gt=rbind(epi_case,epi_cntl)
write.table(num_gt,file="sim.numgt.txt",col.names=FALSE,row.names=FALSE,sep="\t")
write.table(dummy_gt,file="sim.gt.txt",col.names=FALSE,row.names=FALSE,sep="\t")
write.table(epi_gt,file="sim.epi.txt",col.names=FALSE,row.names=FALSE,sep="\t")
write.table(dummy_out,file="sim.out.txt",col.names=FALSE,row.names=FALSE,sep="\t")
xx=apply(epi_gt,1,sum)
t.test(xx[1:n_samp],xx[(n_samp+1):n_indv])
save(n_indv,n_loci,n_samp,n_epis,epi_case,epi_cntl,gt_case,gt_cntl, file = "for_offspring.RData")
max_val=ceiling(max(xx))
dstn1=table(cut(xx[1:n_samp],breaks=(0:max_val)))/n_samp
dstn2=table(cut(xx[(n_samp+1):n_indv],breaks=(0:max_val)))/n_samp
max_y=ceiling(max(c(dstn1,dstn2))*100)
interval=ceiling(max_y/5)
max_y=interval*5
tick_pos=seq(0,max_y,interval)/100
max_y=max_y/100
x=(1:max_val)-0.5
plot(x,dstn2,type="o",col="black",pch=16,xlim=range(0,max_val),ylim=range(0,max_y),xlab="Genetic risk score",ylab="Density",yaxt='n')
lines(x,dstn1,type="o",col="blue",pch=16)
axis(2,labels=TRUE,at=tick_pos) 
