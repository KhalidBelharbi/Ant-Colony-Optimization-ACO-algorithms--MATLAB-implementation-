function [ Result ] = getMatriceAdjacent(path)

idF=fopen(path);
first=fscanf(idF,'%d',[2 1]);
ns=first(1,1);
na=first(2,1);
lecteur=fscanf(idF,'%d',[2,na]);
arete=lecteur';
mat=zeros(ns);
for i=1:na     
   mat(arete(i,1),arete(i,2))=1;
   mat(arete(i,2),arete(i,1))=1;
end


fclose(idF);
Result=mat;

end
