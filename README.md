# Cell society Tomography v1.0
26th,Jan,2018 by An Chengrui in Zhejiang University
(c) An Chengrui, Zhejiang University, Hangzhou, China

1 Introduction and requirement
1.1 Introduction
Cell society Tomography (CsT) is a overlaped cluster analyze of single cell RNA-seq or any other high-dimensional data fitting Poisson's distribution. This tool considers paramaters with different variation seperatly rather than normalize them into unique variation, which similar to CT scanning every slice of human body. All the potential cluster will be recorded as probablity graph for futher biological testimony. 

1.2 Running Environment
CsT v1.0 can only run in MATLAB environment, no matter in Windows and Linux. But Windows is recomanded because it will show the waitbar with this version. Linux version with waitbar will be released soon and 
Because it needs lots of calculation, a server or workstation with CPUs with more than 15 threads and more than 32GB RAM is recommanded for small samples. If your data with more than 2000, please use super calculation center or cloud serve to deal with the task. 

1.3 Suitable data
1:single cell RNA-seq or any other high-dimensional data fitting Poisson's distribution
2:the feature number of samples fit to normal distribution
3:Deep sequencing (average feature number is more than 4000)

1.4 Package installation
Download all files in https://github.com/purewaltzan/Cell-society-Tomography/. Set path to this folder in MATLAB

2 User guide
2.1 Data prepareretion
CsT support .csv, .tsv, .xls or any other format with constant seperator whose string is coded by ASCII and number is coded by ASCII, double, single or Int. 
The table must be according to the formation below (for exmple .csv):
labelname1,label1.1,label1.2,...
labelname2,label2.1,label2.2,...
...
gene,cellname1,cellname2,...
genename1,data1.1,data1.2,...
genename2,data2.1,data2.2,...
....

Where block of 'gene' is very important for CsT to seperate labels and data. No capital here. Tabel also can starte with 'gene' if there is no labels for every cells.

2.2 Peremater intiation

N Perematers
CsTc.filename: full name of filename of table of gene expression. (Required)
CsTc.splittype: charactors for split cells. (Default: ',' for .csv, tab for .tsv, .xls and .xlsx)
CsTc.par.annotation.species: fragment source. (Required)
CsTc.par.annotation.DoGeneselect: (Defualt: 1)
CsTc.par.annotation.Uniontype: (Defualt: 'Gene')
CsTc.data: expression data matrix;
CsTc.gene: gene list;
CsTc.Cellid: name of samples;
CsTc.label: biologic label of samples;
CsTc.labelname: name of biologic label;
CsTc.par.Normalize.maxcounts: gate 
