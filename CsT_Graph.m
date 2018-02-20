function CsTc = CsT_Graph(CsTc)
%CST_GRAPH 此处显示有关此函数的摘要
%   此处显示详细说明
for i=1:numel(CsTc.slice.display)
idx(:,i)=CsTc.slice.display(i).idx;
end
idxh=idx;
for i=2:size(idx,2)
idxh(:,i)=idxh(:,i)+max(idxh(:,i-1));
end
for i=1:max(idxh(:))
for j=1:max(idxh(:))
[x1,y1]=find(idxh==i);
[x2,y2]=find(idxh==j);
csc(i,j)=numel(intersect(x1,x2))./sum(sum(idxh==j));
end
end
for i=1:max(idxh(:))
csc(i,i)=0;
nume(i)=sum((idxh(:)==i));
[x,y]=find(idxh==i);
marker(i)=CsTc.slice.display(y(1)).Markergene(1,idx(x(1),y(1)));

end

gg=csc>CsTc.par.graph.minlinkage;
im=(sum(sum(gg)+sum(gg'))>CsTc.par.graph.degree(1)).*(nume>CsTc.par.graph.degree(2))>0;
ggk=gg(im,im);
csck=csc(im,im);
[yu2(:,1),yu2(:,2)]=find(ggk>0);
for i=1:size(yu2,1)
yu2(i,3)=csck(yu2(i,1),yu2(i,2));
end
markerk=marker(im);
numek=nume(im);
idxhs=1:max(idxh(:));
idxhs=idxhs(im);
CsTc.graph.linkage=csck;
CsTc.graph.marker=markerk;
CsTc.graph.number=numek;
Nodes{1,1}='Nodes';
Nodes{1,2}='Marker';
Nodes{1,3}='Number';
Edges{1,1}='Source';
Edges{1,2}='Target';
Edges{1,3}='Linkage';
if sum(strcmp(fieldnames(CsTc),'label'))
Nodes=[Nodes,fieldnames(CsTc.label)'];
fn=(fieldnames(CsTc.label));
kj=zeros(numel(idxhs),numel(fn));
for n=1:numel(fn);
ck=cell(1,numel(CsTc.label));
for i=1:numel(CsTc.label)
ck{i}=CsTc.label(i).(fn{n});
end
C=unique(ck);
for i=1:numel(markerk)
[x,y]=find(idxh==idxhs(i));
ck1=ck(x);
for j=1:numel(ck1)
if isnumeric(C{1})
kj(i,n)=kj(i,n)+(sum(find(C==ck1{j})));
else
kj(i,n)=kj(i,n)+sum(find(strcmp(C,ck1{j})));
end      
            end
            kj(i,n)=kj(i,n)./numel(ck1);
        end
    end
end



xlswrite([CsTc.par.graph.outputname,'.xlsx'],Nodes,'Nodes','A1');
xlswrite([CsTc.par.graph.outputname,'.xlsx'],[1:numel(CsTc.graph.marker)]','Nodes','A2');
xlswrite([CsTc.par.graph.outputname,'.xlsx'],markerk','Nodes','B2');
xlswrite([CsTc.par.graph.outputname,'.xlsx'],numek','Nodes','C2');
if sum(strcmp(fieldnames(CsTc),'label'))
xlswrite([CsTc.par.graph.outputname,'.xlsx'],kj,'Nodes','D2');
end
xlswrite([CsTc.par.graph.outputname,'.xlsx'],Edges,'Edges','A1');
xlswrite([CsTc.par.graph.outputname,'.xlsx'],yu2,'Edges','A2');

            
        

    

end

