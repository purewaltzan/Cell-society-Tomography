function CsTc = CsT_Readannotation(CsTc)
%CST_ANNOTATIONIMPORT 此处显示有关此函数的摘要
%此处显示详细说明
%read annotaion%
species=CsTc.par.annotation.species;
switch upper(species)
case {'MICE','MOUSE','C57','MUS'}
CsTc.annotation.ensemblname = 'MouseEns.txt';
case {'HUMAN','HUS'}
CsTc.annotation.ensemblname = 'HumanEns.txt';
case {'RAT'}
CsTc.annotation.ensemblname = 'RatEns.txt';
case {'CHICKEN'}
CsTc.annotation.ensemblname = 'ChickenEns.txt';
case {'ZEBRAFISH'}
CsTc.annotation.ensemblname = 'ZebrafishEns.txt';
otherwise
if ~isempty(CsTc.ensemblname)
CsTc.annotation.ensemblname = CsTc.annotation.ensemblname;
else
error('Ensemble annotation file can not be found')
end
end
CsTc.annotation.content = formreader(CsTc.annotation.ensemblname);
switch CsTc.par.annotation.DoGeneselect
case {1,'on'}
if sum(strcmp(CsTc.annotation.content(1,:),'Transcript type'))==0;
error('There did not exists Transcript type column in ensembl annotation file')
else
CsTc.par.annotation.geneselect.transcripttype=unique(CsTc.annotation.content(2:end,(strcmp(CsTc.annotation.content(1,:),'Transcript type'))));
end
if sum(strcmp(CsTc.annotation.content(1,:),'Gene description'))==0;
error('There did not exists Gene description column in ensembl annotation file')
else
sw{1}='mitochondrially encoded';
sw{2}='RIKEN cDNA';
sw{3}='expressed sequence';
sw{4}='predicted gene';
sw{5}='ribosomal protein';
sw{6}='predicted pseudogene';
sw{7}='cDNA sequence';
sw{8}='EST '
CsTc.par.annotation.geneselect.genefunctionexclude=sw;
CsTc.annotation.content{1,size(CsTc.annotation,2)+1}='Source';
for i=1:(size(CsTc.annotation.content,1)-1);
qwert=CsTc.annotation.content{i+1,strcmp(CsTc.annotation.content(1,:),'Gene description')};
if ~isempty(regexp(qwert,'[')) && ~isempty(regexp(qwert,']'))
rewq=regexp(qwert(regexp(qwert,'[')+1:regexp(qwert,']')-1),'\;','split');
CsTc.annotation.content(i+1,strcmp(CsTc.annotation.content(1,:),'Source'))=rewq(1);
else
CsTc.annotation.content{i+1,strcmp(CsTc.annotation.content(1,:),'Source')}='Null';
end
end
CsTc.par.annotation.geneselect.source=unique(CsTc.annotation.content(2:end,(strcmp(CsTc.annotation.content(1,:),'Source'))));
end
otherwise
CsTc.par.annotation.geneselect=[];
end
end

