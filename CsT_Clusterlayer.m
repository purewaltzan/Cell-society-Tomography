function CsTc = CsT_Clusterlayer(CsTc)
%CST_CLUSTERLAYER 此处显示有关此函数的摘要
%   此处显示详细说明

kks=(sum(CsTc.slice.interslicedistence<CsTc.par.slice.disparsethreshold)>CsTc.par.slice.minlinkage);
DD=CsTc.slice.interslicedistence(kks,kks);
CsTc.slice.dispathelite=CsTc.slice.pathelite(kks);
Zl=linkage(DD,'single');
[CsTc.slice.dendrogram,CsTc.slice.cluster]=dendrogram(Zl,CsTc.par.slice.sliceclusternum);
clear kw
idx=[];
for i=1:CsTc.par.slice.sliceclusternum
    idx(i)=CsTc.slice.dispathelite(max(find(CsTc.slice.cluster==i)));
end
if sum(CsTc.slice.dispathelite==1)==0
    idx=[1,idx];
elseif CsTc.slice.cluster(2)~=1
        idx=[1,idx];
end
CsTc.slice.display=[];
CsTc.slice.display=CsTc.slice.R(idx);




end

