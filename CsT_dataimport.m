function CsTc = CsT_dataimport(CsTc)
%CST_IMPORT 此处显示有关此函数的摘要
%   此处显示详细说明
D = importdata(CsTc.filename,'\v');
ad=regexp(CsTc.filename,'\.','split');
if isempty(CsTc.splittype)
switch ad{end}
case 'csv'
CsTc.splittype = ',';
case {'xlsx','xls','tsv','txt'}
CsTc.splittype = '\t';
otherwise
error('CsT only support .csv, Excel, .txt formation or any files which was given vertical and horizantal split charactors');
end
end
switch iscell(D)*10+isstruct(D)
case 10
datastart=findstart(D)+1;        
CsTc.data=dlmread(CsTc.filename,CsTc.splittype,datastart-1,1);
for i=datastart:numel(D)
qwe=regexp(D{i},CsTc.splittype,'split');
CsTc.gene(i-datastart+1)=qwe(1);
end
[x,y]=size(CsTc.data)      
if datastart>2
for i=1:datastart-2
l(i,:)=regexp(D{i},CsTc.splittype,'split');
end
for j=1:y
wes=['CsTc.label(',num2str(j),')=struct('];
for k=1:datastart-2
wes=[wes,'l{',num2str(k),',1},l{',num2str(k),',',num2str(j+1),'},'];
end
wes=[wes(1:end-1),');'];
eval(wes);
end
else
CsTc.label=[];
CsTc.labelname=[];
end
qwe=regexp(D{datastart-1},CsTc.splittype,'split');
CsTc.Cellid=qwe(2:end);   
case 1
if isstruct(D.data)
fe=fieldnames(D.data);
D.data=D.data.(fe{1});
D.textdata=D.textdata.(fe{1});
end
datastart=find(strcmp(D.textdata(:,1),'gene'))+1;
CsTc.data=D.data;
CsTc.gene=D.textdata(datastart:end,1);
CsTc.Cellid=D.textdata(datastart-1,2:end);
[x,y]=size(CsTc.data) ;
if datastart>2
for i=1:datastart-2
l=D.textdata(i,:);
for j=1:y
CsTc.label(j)=struct(l{1},l{j+1});
end
end
else
CsTc.label=[];
CsTc.labelname=[];
end
end
ee=CsTc.gene{1};
if numel(ee)>13
switch (ee(numel(ee)-11))
case 'T'
CsTc.par.annotation.genetype='TranscriptID';
case 'G'
CsTc.par.annotation.genetype='GeneID';
otherwise
CsTc.par.annotation.genetype='Symbol';
end
else
CsTc.par.annotation.genetype='Symbol';
end
end
function n=findstart(D);
n=1;
for i=1:numel(D)
qwe=D{i};
if ~strcmp(qwe(1:4),'gene')
n=n+1;
else
return
end
end
end
