clear all
cd '/Users/sigfus/Desktop/matfiles';
roi1 = 48;
roi2 = 70;
atlas = 'jhu';
modality = 'rest';

field_name = [modality '_' atlas];
idx = 1;
d = dir ('M*.mat');
for i = 1:length (d)
    l = load (d(i).name);
    if isfield (l, field_name)
        conn_field = l.(field_name);
        m = conn_field.r;
        conn(idx) = m(roi1, roi2);
        idx = idx + 1;
    end
end
fprintf ('Conection betwen %s and %s:\n', deblank(conn_field.label(roi1, :)), deblank(conn_field.label(roi2, :)));
disp (conn');
