function CsTc = CsT_Interslicedistence(CsTc)
%CST_INTERSLICEDISTENC 此处显示有关此函数的摘要
%   此处显示详细说明
th=zeros(numel(CsTc.slice.R),1)==1;
wer=parallel.pool.DataQueue;
h = waitbar(0, 'Calculating inter slice distence');
afterEach(wer, @nUpdateWaitbar);
ppp = 1;
for i=1:numel(CsTc.slice.R)
th(i)=CsTc.slice.R(i).meandiscence<CsTc.par.slice.distenetreshould;
end
CsTc.slice.pathelite=find(th);
Slice=CsTc.slice.R(th);
nn=numel(Slice);
DD=zeros(nn);
kw=cell(numel(Slice),1);
for j=1:numel(Slice)
kw{j}=tsnepca(Slice(j).rtsner,CsTc.par.slice.ini_dim);
end
re=CsTc.par.slice.perplex;
N=nn.^2;
parfor m=1:nn.^2
DD(m)=slicedistence(kw{floor((m-1)/nn)+1},kw{m-(floor((m-1)/nn)*nn)},re);
send(wer, m);
end
DD=(DD+DD')/2;
CsTc.slice.interslicedistence=DD;
function nUpdateWaitbar(~)
waitbar(ppp/N, h);
ppp = ppp + 1;
end   
end
function cost1=slicedistence(X1,X2,perplex)
sum_X1 = sum(X1 .^ 2, 2);
D1 = bsxfun(@plus, sum_X1, bsxfun(@plus, sum_X1', -2 * (X1 * X1')));
sum_X2 = sum(X2 .^ 2, 2);
D2 = bsxfun(@plus, sum_X2, bsxfun(@plus, sum_X2', -2 * (X2 * X2')));
P1 = d2p(D1, perplex, 1e-5);                                           % compute affinities using fixed perplexity
clear D1
P2 = d2p(D2, perplex, 1e-5);                                           % compute affinities using fixed perplexity
clear D2
n = size(P1, 1);
P1(1:n + 1:end) = 0;                                 % set diagonal to zero
P1 = 0.5 * (P1 + P1');                                 % symmetrize P-values
P1 = max(P1 ./ sum(P1(:)), realmin);                   % make sure P-values sum to one
const1 = sum(P1(:) .* log(P1(:)));
P2(1:n + 1:end) = 0;                                 % set diagonal to zero
P2 = 0.5 * (P2 + P2');                                 % symmetrize P-values
P2 = max(P2 ./ sum(P2(:)), realmin);                   % make sure P-values sum to one
cost1 = const1 - sum(P1(:) .* log(P2(:)));
PP1=sum(P1 .* log(P1./P2));
end