%CsT_main_for_excample This is the transcripts of CsT analysis of exmple data.
CsTc = CsT_InitialCsTc('example.csv','Mus'); %Initialize paramaters of CsT. Filename and spacies name must be given in this processes to further analysis.
CsTc = CsT_dataimport(CsTc);
CsTc = CsT_Readannotation(CsTc);
CsTc.par.annotation.geneselect.transcripttype=CsTc.par.annotation.geneselect.transcripttype(31);
CsTc.par.annotation.geneselect.source=CsTc.par.annotation.geneselect.source(3);
CsTc = CsT_Selectgene(CsTc);
CsTc.par.Normalize.maxcounts=800000;
CsTc.par.Normalize.mincounts=80000;
CsTc = CsT_Normalize(CsTc);
CsTc = CsT_Deletefields1(CsTc);
CsTc = CsT_Slicetsnetransform(CsTc);
CsTc = CsT_Innerslicedistence(CsTc);
CsTc = CsT_Interslicedistence(CsTc);
CsTc.par.slice.display.dimension=3;
CsTc = CsT_Reducedim(CsTc);
CsTc = CsT_Clusterlayer(CsTc);
CsT_Showgene(CsTc,'Acan');
CsTc.par.display.markernum=10;
CM = CsT_InitialCC
CsTc = CsT_Cellcluster(CsTc,slice,CM);
CsTc.par.display.markernum=10;
load mappp
CsTc.par.display.colormap=mappp;
CsTc = CsT_Markergene(CsTc);
CsTc.par.graph.minlinkage=0.5
CsTc.par.graph.degree=[10,3]
CsTc.par.graph.outputname='graph'
CsTc = CsT_Graph(CsTc)
