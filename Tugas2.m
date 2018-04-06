% % Mochamad Yusuf Solihin 1301150020 IF 3906
% % Tugas machine learning 1.3

% -----------------------------------------------------
% % import data_train dan data_test nya dari file excel
% -----------------------------------------------------
clear

data_train = xlsread('datanya.xlsx','Sheet1','A1:B688');
data_test = xlsread('datanya.xlsx','Sheet2','A1:B100');

% 5 adalah K yang optimum, 
% didapat dari hasil analisa grafik SSE selama 3x running
k = 5;
banyak_pindah = 0;

%ambil titik dari data train secara random untuk centroid awal
for i =1:k
    index = randperm(length(data_train),1);
    centroid(i,1) = data_train(index,1);
    centroid(i,2) = data_train(index,2);
end
awal_centroid = centroid;

for x = 1:1000
    current_centroid = centroid;
    %menghitung jarak setiap centroid 
    %nama centroid dimasukan kedalam tabel data_train kolom ke3
    for i = 1:size(data_train,1)
        for j = 1:k
            d(j,1) = norm([centroid(j,1) centroid(j,2)]-[data_train(i,1) data_train(i,2)]);
        end
        d_min = min(d(:,1));
        data_train(i,3) = find(d(:,1)==d_min);
    end

    %menjumlahkan setiap data dengan centroid terdekatnya
    data_train_sorted = sortrows(data_train,3);
    for i=1:k
        centroid(i,1) = sum(data_train(find(data_train(:,3)==i),1));
        centroid(i,2) = sum(data_train(find(data_train(:,3)==i),2));
    end

    %menghitung rata-rata tiap centroid untuk mendapat centroid yang baru
    for i = 1:k
        [baris,kolom] = size(find(data_train(:,3) == i))
        centroid(i,1) = centroid(i,1)/(baris);
        centroid(i,2) = centroid(i,2)/(baris);
    end

    
%     centroid_sebelumnya(:,:) = centroid(:,:);    
    if current_centroid(:,:) == centroid(:,:)
        break
    else
        banyak_pindah = banyak_pindah+1;
    end
end



%SKUY TESTING TESTING%
%--------------------%
for i = 1:size(data_test,1)
    for j = 1:k
        d_test(j,1) = norm([centroid(j,1) centroid(j,2)]-[data_test(i,1) data_test(i,2)]);
    end
    d_min_test = min(d_test(:,1));
    data_test(i,3) = find(d_test(:,1)==d_min_test);
end
      

%Tampilkan scatter dari data yang telah dicari
figure; hold on;
for i = 1:k
    scatter(data_train(find(data_train(:,3)==i),1),data_train(find(data_train(:,3)==i),2),'filled');
    scatter(centroid(i,1),centroid(i,2),'filled','black');
    scatter(data_test(find(data_test(:,3)==i),1),data_test(find(data_test(:,3)==i),2),'x');
end
scatter(awal_centroid(:,1),awal_centroid(:,2),'d','black');
hold off;
        
clc;

