function CsTc = CsT_Slicetsnetransform(CsTc)
%CST_SLICEPCA 
%   
[x,y]=size(CsTc.data);
KK=cell(numel(CsTc.par.slice.start:CsTc.par.slice.step:y-CsTc.par.slice.ini_dim),1);
data=CsTc.data;
per=CsTc.par.slice.perplex;
ini=CsTc.par.slice.ini_dim;
start=CsTc.par.slice.start;
step=CsTc.par.slice.step;
D = parallel.pool.DataQueue;
hwait=waitbar(0,'Principle component analysis for every slice');
afterEach(D, @nUpdateWaitbar);
N = numel(KK) ;
p = 1;
parfor i= start:step:y-ini
if sum(sum(data(sum(data>0,2)<y+2-i,:)))~=0;
KK{i}=tsnepca(data(sum(data>0,2)<y+2-i,:)',ini);    
send(D, i);
end
end
for i= start:step:y-ini
if sum(sum(data(sum(data>0,2)<y+2-i,:)))~=0;
CsTc.slice.R(i).gene=CsTc.gene(sum(data>0,2)<y+2-i,:);
CsTc.slice.R(i).sliceid=i;
end
end
permutation=CsTc.par.slice.permutation;
D = parallel.pool.DataQueue;
hwait=waitbar(0,'Permuation of tsnetransform');
nn=numel(CsTc.slice.R);
afterEach(D, @nUpdateWaitbar);
N = nn*permutation ;
p = 1;
KKs=KK;
for j=1:(permutation)
parfor i=1:nn
if sum(sum(data(sum(data>0,2)<y+2-i,:)))~=0;
KK{i}=tsnetransform(KKs{i},[],per,ini);
send(D, i);
end
end
for i=1:numel(CsTc.slice.R)
if sum(sum(data(sum(data>0,2)<y+2-i,:)))~=0;
CsTc.slice.R(i).tsner{j}=KK{i};
end
end    
end
function nUpdateWaitbar(~)
waitbar(p/N, hwait);
p = p + 1;
end
end
