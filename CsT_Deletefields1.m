function we = CsT_Deletefields1(CsTc);
%CST_DELETEFIELDS1 此处显示有关此函数的摘要
%   此处显示详细说明
we = CsTc.main.n;
we.par=CsTc.par;
we.par.slice.step=1;
we.par.slice.start=1;
we.par.slice.permutation=10;
we.par.slice.distenetreshould=1;
we.par.slice.sliceclusternum=10;
we.par.slice.ini_dim=30;
we.par.slice.perplex=50;
we.par.slice.disparsethreshold=1;
we.par.slice.minlinkage=5;
we.par.slice.display.ini_num=30;
we.par.slice.display.perplex=20;
we.par.display.dimension=3;
we.par.display.pvalue=0.05;
we.par.display.markernumbuer=5;
end

