# Cell society Tomography v1.0
26th,Jan,2018 by An Chengrui in Zhejiang University

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

2 User guide
