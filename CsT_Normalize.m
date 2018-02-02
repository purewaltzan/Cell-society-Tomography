function CsTc = CsT_Normalize(CsTc)
%CST_NORMALIZE 此处显示有关此函数的摘要
% 此处显示详细说明
switch CsTc.par.annotation.genetype
case 'TranscriptID'
if sum(strcmp(CsTc.annotation.content(1,:),'Transcript stable ID'))==0;
error('There did not exists Transcript stable ID column in ensembl annotation file')
else
KK='Transcript stable ID';
end
case 'GeneID'
if sum(strcmp(CsTc.annotation.content(1,:),'Gene stable ID'))==0;
error('There did not exists Transcript stable ID column in ensembl annotation file')
else
KK='Gene stable ID';
end
case 'Symbol'
if sum(strcmp(CsTc.annotation.content(1,:),'Gene name'))==0;
error('There did not exists Gene name column in ensembl annotation file')
else
KK='Gene name';
end
end
annotationgene=CsTc.annotation.content(:,strcmp(CsTc.annotation.content(1,:),KK));
annotationgene=upper(annotationgene);
[C,IC,IA]=intersect(upper(CsTc.gene),annotationgene);
for i=1:numel(C)
L=[];
qwert=find(strcmp(C{i},CsTc.annotation.content(:,strcmp(CsTc.annotation.content(1,:),KK))));
for j=1:numel(qwert)
L(j)=str2num(CsTc.annotation.content{qwert(j),strcmp(CsTc.annotation.content(1,:),'Transcript length (including UTRs and CDS)')});
end
if isempty(L);
L=0;
end
Cdslenth(i)=max(L);
end
CsTc.main.gene=CsTc.annotation.content(IA,strcmp(CsTc.annotation.content(1,:),'Gene name'));
CsTc.main.ID=CsTc.gene(IC);
CsTc.main.data=CsTc.data(IC,:);
CsTc.main.cdslenth=Cdslenth;
maskc=(sum(CsTc.main.data)<CsTc.par.Normalize.maxcounts).*(sum(CsTc.main.data)>CsTc.par.Normalize.mincounts).*(sum(CsTc.main.data>0)<CsTc.par.Normalize.maxgenes).*(sum(CsTc.main.data>0)>CsTc.par.Normalize.mingenes)>0;
CsTc.main.n.Cellid=CsTc.Cellid(maskc);
if ~isempty(CsTc.label)
CsTc.main.n.label=CsTc.label(maskc);
end
CsTc.main.n.data=CsTc.main.data(:,maskc);
switch CsTc.par.Normalize.Type
case {'CPM'}
CsTc.main.n.data=CsTc.main.n.data./(ones(size(CsTc.main.n.data,1),1)*sum(CsTc.main.n.data))*1000000;
case {'TPM'}
CsTc.main.n.data=CsTc.main.n.data./(CsTc.main.Cdslenth*sum(CsTc.main.n.data))*1000000;
otherwise
CsTc.main.n.data=CsTc.main.n.data;
end
switch CsTc.par.Normalize.transform
case 'log2'
CsTc.main.n.data=log2(CsTc.main.n.data+1);
case 'log10'
CsTc.main.n.data=log10(CsTc.main.n.data+1); 
otherwise
CsTc.main.n.data=CsTc.main.n.data;
end
switch numel(CsTc.par.Normalize.maskr)
case 0
maskr=sum(CsTc.main.n.data>2,2)>2;
case 1
maskr=sum(CsTc.main.n.data>CsTc.par.Normalize.maskr,2)>CsTc.par.Normalize.maskr;
case 2
maskr=sum(CsTc.main.n.data>CsTc.par.Normalize.maskr(1),2)>CsTc.par.Normalize.maskr(2);
end
CsTc.main.n.data=CsTc.main.n.data(maskr,:);
CsTc.main.n.gene=CsTc.main.gene(maskr);
CsTc.main.n.counts=CsTc.main.data(maskr,maskc);
end