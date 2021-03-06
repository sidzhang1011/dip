clc; clear; close all;

% (a)
Agroup = cell(3);
Agroup{1} = imread('letterA.tif');
Agroup{2} = imresize(Agroup{1}, 1.5, 'bilinear');
Agroup{3} = imrotate(Agroup{1}, 90, 'bilinear');
for i=1:3
    subplot(4,3,i), imshow(Agroup{i});
end

Cgroup = cell(3);
Cgroup{1} = imread('letterC.tif');
Cgroup{2} = imresize(Cgroup{1}, 1.5, 'bilinear');
Cgroup{3} = imrotate(Cgroup{1}, 90, 'bilinear');
for i=1:3
    subplot(4,3,3+i), imshow(Cgroup{i});
end


% (b)
Aphinorm = cell(3);
for i=1:3
    phi = invmoments(Agroup{i});
    Aphinorm{i} = -sign(phi) .* (log10(abs(phi)));
    subplot(4,3,6+i),
    plot([1:length(Aphinorm{i})], Aphinorm{i}, '--og', 'MarkerSize',10);
end
Aphi1 = Aphinorm{1}(1);
Asqrtphi2 = sqrt(Aphinorm{1}(2));

Cphinorm = cell(3);
for i=1:3
    phi = invmoments(Cgroup{i});
    Cphinorm{i} = -sign(phi) .* (log10(abs(phi)));
    subplot(4,3,9+i),
    plot([1:length(Cphinorm{i})], Cphinorm{i}, '--or', 'MarkerSize',10);
end
Cphi1 = Cphinorm{1}(1);
Csqrtphi2 = sqrt(Cphinorm{1}(2));

% (c)
Aphi1bigger = 0;
Asqrtphi2bigger = 0;
for k=1:50
    for i=1:3
        Atemp = imgaussfilt(Agroup{i});
        phi = invmoments(Atemp);
        Aphinorm{i} = -sign(phi) .* (log10(abs(phi)));

        Ctemp = imgaussfilt(Cgroup{i});
        phi = invmoments(Ctemp);
        Cphinorm{i} = -sign(phi) .* (log10(abs(phi)));
        
        if (Aphinorm{i}(1) > Cphinorm{i}(1))
            Aphi1bigger = Aphi1bigger + 1;
        end

        if ( sqrt(Aphinorm{i}(2)) > sqrt(Cphinorm{i}(2)) )
            Asqrtphi2bigger = Asqrtphi2bigger + 1;
        end

    end
end

if (Aphi1bigger == 150 && Asqrtphi2bigger == 150)
    disp('noise doesn''t affect result');
else
    disp('noise does affect result');
end

