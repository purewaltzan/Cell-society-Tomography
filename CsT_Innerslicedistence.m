function CsTc = CsT_Innerslicedistence(CsTc)
%CST_INNERSLICEDISTENCE 
%   
hwait=waitbar(0,'Calculate innerslice distence');
t=numel(CsTc.slice.R);
permutation=CsTc.par.slice.permutation;
perplex=CsTc.par.slice.perplex;
for i=1:numel(CsTc.slice.R)
for j=1:numel(CsTc.slice.R(i).tsner)
kw{j}=tsnepca(CsTc.slice.R(i).tsner{j},CsTc.par.slice.ini_dim);
end
DD=zeros(numel(CsTc.slice.R(i).tsner));
nn=numel(CsTc.slice.R(i).tsner);
parfor m=1:nn.^2
DD(m)=slicedistence(kw{floor((m-1)/permutation)+1},kw{m-(floor((m-1)/permutation))*permutation},perplex);
end
hwait=waitbar(i/numel(CsTc.slice.R),hwait,['Calculate innerslice distence of slice ',num2str(i)]);
CsTc.slice.R(i).Dmatrix=DD;
CsTc.slice.R(i).meandiscence=mean(DD(:));
CsTc.slice.R(i).rtsner=CsTc.slice.R(i).tsner{mean(DD)==min(mean(DD))};
clear DD
clear kw
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