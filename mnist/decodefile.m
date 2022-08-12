function output = decodefile(filename, type)
fio = fopen(filename, 'r');
a = fread(fio, 'uint8');
if strcmp(type, 'image')
    output = a(17:end);
elseif strcmp(type, 'label')
    output = a(9:end);
else
    error('unsupported type');
end
