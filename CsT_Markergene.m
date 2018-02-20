function [CsTc] = CsT_Markergene(CsTc)
%CST_MARKERGENE 
%   
data=CsTc.data;
gene=CsTc.gene;
cdata=(data-mean(data,2))./std(data,0,2);
for i=1:numel(CsTc.slice.display);
idx=CsTc.slice.display(i).idx;
parfor j=1:numel(gene);
p(j)=kruskalwallis(data(j,:),idx,'off');
end
pdata=data(p<CsTc.par.display.pvalue,:);
cpdata=cdata(p<CsTc.par.display.pvalue,:);
pgene=gene(p<CsTc.par.display.pvalue);
AUC1=zeros(numel(pgene),max(idx));
AUC2=zeros(numel(pgene),max(idx));
for m=1:max(idx)
parfor n=1:numel(pgene);
[X,Y,T,AUC1(n,m)] = perfcurve(idx==m,(pdata(n,:)),1);
[X,Y,T,AUC2(n,m)] = perfcurve(idx==m,-(pdata(n,:)),0);
end
end
AUC=AUC1+AUC2;
[aaa,bbb]=sort(mean(AUC),'descend');
[ccc,ddd]=sort(AUC,'descend');
ss=[];
ii=[];
kk=zeros(size(pgene));
for j=1:max(idx)
ii=[ii,idx(idx==bbb(j))'];
ss=[ss,cpdata(:,idx==bbb(j))];
n=1;
while n<=CsTc.par.display.markernum
if kk(ddd(n,bbb(j)))==0;
kk(ddd(n,bbb(j)))=(j-1)*CsTc.par.display.markernum+n;
n=n+1;
else
n=n+1;
end
[i,j,n]
end
end
[eee,fff]=sort(kk);
ss=ss(fff,:);
gg=pgene(fff);
ss=ss(eee>0,:);
gg=gg(eee>0);
CsTc.slice.display(i).Heatmap=HeatMap(ss(:,end:-1:1),'Rowlabels',gg,'Columnlabels',ii(:,end:-1:1),'Colormap',CsTc.par.display.colormap,'DisplayRange',5);
CsTc.slice.display(i).Markergene=pgene(ddd(1:(min(CsTc.par.display.markernum,size(ddd,1))),:)); 
end
end