clear;
clc;
T = readtable('2challenge.csv');
data = table2array(T);

col_8 = isnan(data(:,8));
nan_ids = find(col_8 == 1);
data_new = [];
nan_idsblw10000 = length(find(nan_ids<=10000));
no_nan_ids = find(col_8 == 0);
no_nan_idsblw10000 = length(find(no_nan_ids<=10000));
%%
data_new = zeros(size(data));
for i = 1:15000
    if (isempty(find(nan_idsblw10000==i)))
        X = data(i, 2:7);
        dist = [];
        for j = 1:nan_idsblw10000
            Y = data(nan_ids(j), 2:7);
            dist = [dist; norm(X-Y)];
        end
        [dist_sorted, I] = sort(dist);
        idxs = nan_ids(I(1:10));
        label10 = data(idxs, 10);
        if length(find(label10 == 0)) > length(find(label10 == 1))
           label = 0;
        else
           label = 1;
        end
        data_new(i,:) = [data(i,1:9), label];
    else
        X = data(i, 2:9);
        dist = [];
        for j = 1:no_nan_idsblw10000
            Y = data(no_nan_ids(j), 2:9);
            dist = [dist; norm(X-Y)];
        end
        [dist_sorted, I] = sort(dist);
        idxs = no_nan_ids(I(1:10));
        label10 = data(idxs, 10);
        if length(find(label10 == 0)) > length(find(label10 == 1))
           label = 0;
        else
           label = 1;
        end
        data_new(i,:) = [data(i,1:9), label];        
    end
end
%%
correct_pc = length(find((data(1:10000, 10) - data_new(1:10000, 10))==0))/100;
data_first10000 = data_new(1:10000,10);