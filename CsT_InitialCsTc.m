function CsTc = CsT_InitialCsTc(filename,species)
%CST_INITIALCSTC �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
CsTc.filename=filename;
CsTc.splittype=[];%������Ҫ��ȡ�����ľ��%
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

