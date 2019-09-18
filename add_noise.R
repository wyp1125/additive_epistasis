lnames = load(file = "for_offspring.RData")
lnames

maf_high=0.5
maf_low=0.01
noise_ratio=0.25

n_loci_noise=n_loci*noise_ratio
gt_case_noise=array(0,dim=c(n_samp,n_loci_noise))
gt_cntl_noise=array(0,dim=c(n_samp,n_loci_noise))

for(i in 1:(n_loci_noise/n_epis))
{
  print(i)
  saved_case_gt=array(0,dim=c(n_samp,n_epis))
  saved_cntl_gt=array(0,dim=c(n_samp,n_epis))
  maf=runif(n_epis,maf_low,maf_high)
  for(t in 1:2)
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
    if(t==1)
    {
      saved_cntl_gt=tmp_gt
    }
    else
    {
      saved_case_gt=tmp_gt
    }
  }
  gt_case_noise[,(((i-1)*n_epis+1):(i*n_epis))]=saved_case_gt
  gt_cntl_noise[,(((i-1)*n_epis+1):(i*n_epis))]=saved_cntl_gt
}

epi_case_noise=array(0,dim=c(n_samp,(n_loci_noise/n_epis)))
epi_cntl_noise=epi_case_noise
for(i in 1:n_samp)
{
  for(j in 1:(n_loci_noise/n_epis))
  {
    inc_case=1
    inc_cntl=1
    for(k in 1:n_epis)
    {
      fac_case=0
      fac_cntl=0
      if(gt_case_noise[i,(j-1)*n_epis+k]==2)
      {
        fac_case=1
      }
      inc_case=inc_case*fac_case
      if(gt_cntl_noise[i,(j-1)*n_epis+k]==2)
      {
        fac_cntl=1
      }
      inc_cntl=inc_cntl*fac_cntl
    }
    epi_case_noise[i,j]=inc_case
    epi_cntl_noise[i,j]=inc_cntl
  }
}
new_epi_case=cbind(epi_case,epi_case_noise)
new_epi_cntl=cbind(epi_cntl,epi_cntl_noise)
new_epi_gt=rbind(new_epi_case,new_epi_cntl)
write.table(new_epi_gt,file=paste("sim.epi.",noise_ratio,".txt",sep=""),col.names=FALSE,row.names=FALSE,sep="\t")
xx=apply(new_epi_gt,1,sum)
t.test(xx[1:n_samp],xx[(n_samp+1):n_indv])
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
legend("topright",cex=1,c("case group","control group"),pch=c(16,16),lty=c(1,1),col=c("blue","black"))
#compute AUC
library("AUC")
y_true=c(rep(1,n_samp),rep(0,n_samp))
x_rescaled=xx/max(xx)
auc(roc(x_rescaled,factor(y_true)))

