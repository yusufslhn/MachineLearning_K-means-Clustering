% % Mochamad Yusuf Solihin 1301150020 IF 3906
% % Tugas machine learning 1.3

% -----------------------------------------------------
% % import data_train dan data_test nya dari file excel
% -----------------------------------------------------
clc;
clear;

data_train = xlsread('datanya.xlsx','Sheet1','A1:B688');
data_test = xlsread('datanya.xlsx','Sheet2','A1:B100');


banyak_pindah = 0;

for k =1 :10 %coba SSE sampai K = 10
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
            [baris,kolom] = size(find(data_train(:,3) == i));
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
    
    for i = 1:k
        kumpulan_klaster = data_train(:,3);
        jarak_klaster = data_train(find(kumpulan_klaster==i),1:2);
        
        for j = 1:size(jarak_klaster,1)
            jarakcentroid(j,1) = (norm([centroid(i,1) centroid(i,2)]-[jarak_klaster(j,1) jarak_klaster(j,2)]))^2;
        end
        sorted(i,1) = sum(jarakcentroid(:,1));
    end
    jarakcentroid(:,:) = 0;
    SSEnya(k,2) = k;
    SSEnya(k,1) = sum(sorted(:,1));       
end

figure; hold on;
plot(SSEnya(:,2),SSEnya(:,1));
hold off;

clc