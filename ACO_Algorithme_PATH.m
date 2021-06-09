function [solution,cout,MeilleursSolutionss] =ACO_Algorithme_PATH(path,nbrIterMax,nbrAgents,alphaa,betta,Segma)


[solution,cout,MeilleursSolutionss] =ACO_Algorithme(getMatriceDistances(path),nbrIterMax,nbrAgents,alphaa,betta,Segma);

end