function CsTc = CsT_InitialCsTc(filename,species)
%CST_INITIALCSTC Initialize the paramaters of CsT
%   CsTc = CsT_InitialCsTc(filename,species) returns a struct 
CsTc.filename=filename;
CsTc.splittype=[];%这里需要读取参数的句柄%
CsTc.par.annotation.species=species;
CsTc.par.annotation.DoGeneselect=1;
CsTc.par.annotation.Uniontype='Gene'
CsTc.par.Normalize.maxcounts=inf;
CsTc.par.Normalize.mincounts=-inf;
CsTc.par.Normalize.maxgenes=inf;
CsTc.par.Normalize.mingenes=-inf;
CsTc.par.Normalize.Type='CPM'
CsTc.par.Normalize.maskr=[];
CsTc.par.Normalize.transform='Null';


end

