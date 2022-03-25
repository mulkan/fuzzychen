clc;clear all;close all;
format shortG
data = load('data.txt');
disp('data');
disp(data);
disp('Mencari Nilai Himpunan Semesta')
d1 = 3
d2 = 3
d_min = min(data)
d_max = max(data)
U =[d_min-d1 d_max+d2]
disp('Jumlah Interval')
jumlah_interval = round(1 + (3.322 * log10(length(data))))
disp('Lebar Interval')
lebar_interval = (d_max-d_min) / jumlah_interval

a = d_min-d1;
b = d_min+lebar_interval;
disp('universe of discourse');
U = [];
for j =1:jumlah_interval    
    nilai_tengah(j) = ceil(mean([a, b]));
    disp(['U' num2str(j) ': ' num2str(round(a)) ' - ' num2str(round(b)) ' nilai tengah A' num2str(j) ': ' num2str(nilai_tengah(j))]);
    U(j,:) = [a,b];
    fuzzy_sets(j) = nilai_tengah(j);
    a = b;
    b = a+lebar_interval;
end



fuzzifikasi = [];
disp('Tabel Hasil Fuzzifikasi');
for i=1:length(data)
    for j=1:jumlah_interval
        kiri = U(j,1);
        kanan = U(j,2);
        if data(i)>= kiri && data(i)<= kanan            
            fuzzifikasi(i) = j;
            disp([num2str(i) '.  ' num2str(data(i)) ': A' num2str(fuzzifikasi(i))])
            break;
        end
    end
end

fuzzy_logic_relationship=[fuzzifikasi(1:end-1)',fuzzifikasi(2:end)'];
disp('Tabel Fuzzy Logic Relationship (FLR)');
for i=1:length(fuzzy_logic_relationship)
    disp([num2str(i) '.  ' num2str(data(i)) ': A' num2str(fuzzy_logic_relationship(i,1)) '-> A' num2str(fuzzy_logic_relationship(i,2))]);
end


for i =1:jumlah_interval    
   flrg{i} = fuzzy_logic_relationship(fuzzy_logic_relationship(:,1)==i,2);
end


disp('Fuzzy Logic Relationship Group (FLRG)');
for i =1:jumlah_interval
   flrgs = unique(sort(flrg{i}))';
   disp(['Current State A' num2str(i) '->']);
   for j=1:length(flrgs)
        disp(['                  A' num2str(flrgs(j))]);
   end
   

end




disp('Hasil Defuzifikasi')
defuzzifikasi = [];
for i =1:jumlah_interval
   flrgs = unique(sort(flrg{i}))';   
   defuzzifikasi(i) = mean(fuzzy_sets(flrgs));
   disp(['Current State A' num2str(i) ' forecasted ' num2str(defuzzifikasi(i))]);    
end

forecasting = (defuzzifikasi(fuzzifikasi))';
disp('forecasting')
forecasting_akhir = zeros(length(forecasting)+1,1);
forecasting_akhir(1) = 0;
forecasting_akhir(2:end) = forecasting(1:end);

disp('Hasil Forecasting')
for i=1:length(data)
    disp([num2str(i) '.   ' num2str(data(i)) ' = ' num2str(forecasting_akhir(i))]);
end
disp(['Prediksi untuk data ke ' num2str(length(data)+1) ' = ' num2str(forecasting_akhir(end))])


% figure()
% plot(data(2:end))
% hold on
% plot(forecasting_akhir(2:end-1))
% legend('Aktual','Prediksi')
% ylabel('data Penduduk');
% title('Data Penduduk')


disp('Nilai hasil pelatihan')
disp('Nilai U')
disp(round(U))
disp('Nilai A Current State ')
for i=1:length(defuzzifikasi)
    disp(['A' num2str(i) '. ' num2str(defuzzifikasi(i))])
end

angka = 250000
disp('Prediksi');
for j=1:jumlah_interval
    kiri = U(j,1);
    kanan = U(j,2);
    if angka >= kiri && angka <= kanan            
        fuzzifikasi  = j;
        disp([num2str(angka) ': A' num2str(fuzzifikasi) ' -> ' num2str(defuzzifikasi(fuzzifikasi))])
        break;
    end
end


