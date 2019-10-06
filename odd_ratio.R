lnames = load(file = "for_offspring.RData")
lnames
epi_frq_case=apply(epi_case,2,sum)
epi_frq_cntl=apply(epi_cntl,2,sum)
n=length(epi_frq_case)
oddr=array(dim=c(n))
for(i in 1:n)
{
oddr[i]=(epi_frq_case[i]/(epi_frq_case[i]+epi_frq_cntl[i]))/((n_samp-epi_frq_case[i])/(n_indv-epi_frq_case[i]-epi_frq_cntl[i]))
if(is.na(oddr[i]))
{
oddr[i]=1
}
}
t.test(oddr,mu=1)
yy1=apply(epi_case,1,sum)
yy2=apply(epi_cntl,1,sum)
library("AUC")
y_true=c(rep(1,n_samp),rep(0,n_samp))
xx=c(yy1,yy2)
x_rescaled=xx/max(xx)
auc(roc(x_rescaled,factor(y_true)))