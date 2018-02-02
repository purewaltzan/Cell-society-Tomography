function CsTc = CsT_Selectgene(CsTc)
%CST_SELECTGENE 此处显示有关此函数的摘要
% 此处显示详细说明
if ~isempty(CsTc.par.annotation.geneselect)
if numel(CsTc.par.annotation.geneselect.transcripttype)~=0
w=zeros(size(CsTc.annotation.content,1),1);
w(1)=1;
bn=w;
nb=w;
if sum(strcmp(CsTc.annotation.content(1,:),'Transcript type'))==0;
error('There did not exists Transcript type column in ensembl annotation file')
else
for i=1:numel(CsTc.par.annotation.geneselect.transcripttype)
w(2:end)=w(2:end)+strcmp(CsTc.annotation.content(2:end,strcmp(CsTc.annotation.content(1,:),'Transcript type')),CsTc.par.annotation.geneselect.transcripttype(i));
end
w=w>0+0;
end
if sum(strcmp(CsTc.annotation.content(1,:),'Source'))==0;
error('There did not exists Source column in ensembl annotation file')
else
for i=1:numel(CsTc.par.annotation.geneselect.source)
nb(2:end)=nb(2:end)+strcmp(CsTc.annotation.content(2:end,strcmp(CsTc.annotation.content(1,:),'Source')),CsTc.par.annotation.geneselect.source(i));
end
nb=nb>0+0;
end
if sum(strcmp(CsTc.annotation.content(1,:),'Gene description'))==0;
error('There did not exists Gene description column in ensembl annotation file')
else
wer=parallel.pool.DataQueue;
h = waitbar(0, 'Calculating inter slice distence');
afterEach(wer, @nUpdateWaitbar);
N=numel(CsTc.par.annotation.geneselect.genefunctionexclude).*(size(CsTc.annotation.content,1)-1)
ppp = 1;
ne=(CsTc.par.annotation.geneselect.genefunctionexclude);
nc=size(CsTc.annotation.content,1);
ann=CsTc.annotation.content(:,strcmp(CsTc.annotation.content(1,:),'Gene description'));
for i=1:numel(ne)
parfor j=1:nc-1
qwert=upper(ann{j+1,:});
if numel(qwert)>numel(ne{i})
if qwert(1:numel(ne{i}))==upper(ne{i});
bn(j+1)=bn(j+1)-1;
elseif numel(qwert)==0
bn(j+1)=bn(j+1)-1;
end
end
send(wer,j);
end
end
end
CsTc.annotation.content = CsTc.annotation.content(bn+(w.*nb>0)>0,:);
else
error('No transcripttype was selected')
end
end
function nUpdateWaitbar(~)
waitbar(ppp/N, h);
ppp = ppp + 1;
end 
end