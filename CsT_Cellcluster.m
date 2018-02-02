function CsTc = CsT_Cellcluster(CsTc,slice,CM)
%CST_CELLCLUSTER 此处显示有关此函数的摘要
%   此处显示详细说明
data=CsTc.slice.display(slice).tsnerf;
if isempty(CM.number)
    error('Cluster number is not given');
else
    if isempty(CM.methods)
        error('Cluster methods is not given')
    else
        switch upper(CM.methods)
            case {'KMEANS','KMEAN'}
                idx=kmeas(data,CM.number,'distance',CM.kmeans.distance,'start',CM.kmeans.start,'replicates',CM.kmeans,replicates,'emptyaction',CM.kmeans.emptyaction,'onlinephase',CM.kmeans.onlinephase,'options',CM.kmeans.options, 'maxiter',CM.kmeans.maxiter,'display',CM.kemas.display);
            case {'HYERARCHYCLUSTER','HYERARCHY CLUSTER','HCLUSTER','HC'}
                idx=clusterdata(data,'linkage',CM.hcluster.linkage,'distance',CM.hcluster.distance,CM.number);
            case {'DBCA','DENSITY','DENSEITY BASED','DENSEITYBASED'}
                [ rho,delt,dd ] = rhodelta( data,CM.DBCA.dc );
                idx = dcluster( rho,delt,CM.number,dd );
            otherwise
                error('Unsurpported Methods')
        end
    end
    if size(data,2)==2
        scatter(data(:,1),data(:,2),25,idx,'fill');
    else
        scatter3(data(:,1),data(:,2),data(:,3),25,idx,'fill');
    end
    CsTc.slice.display(slice).idx=idx; 
    CsTc.slice.display(slice).par=CM; 
end


end

