function [solution,cout,MeilleursSolutionss] =ACO_Algorithme(matDistance,nbrIterMax,nbrAgents,alphaa,betta,Segma)
global alpha;
alpha=alphaa;
global beta;
beta=betta;
global matCout;
matCout = matDistance;
global ns;
ns = size(matDistance,1);
global PheroMat;
global Visibile;

NumberAgents=nbrAgents;
PheromoneMat=zeros(ns,ns);
PheromoneMat(:,:)=0.1;
PheroMat=PheromoneMat;

matVisibilite=1./matDistance;
Visibile=matVisibilite;

MeilleursSolutions=[];
while( nbrIterMax > 0 )
    matResultat=zeros(nbrAgents,ns+1);   %   la matrice de résultat pour chaque itération     
for indicAgent=1:nbrAgents       
               matResultat(indicAgent,1)=randi(ns,1,1);   % ns+1 car on a un cycle
               matResultat(indicAgent,end)=matResultat(indicAgent,1);
               tabou=[matResultat(indicAgent,1)];
               villeActuelle=matResultat(indicAgent,1);
               colonne=2;
               jaiCoisie=0;
             while(colonne<size(matResultat,2))                 
                  candidates=getVecteurChoix(tabou); % les villes candidates 
                 while(true)                                 
                          j=candidates(1,randi(size(candidates,2),1,1));
                          pro=Proba(villeActuelle,  j ,candidates);
                          if( pro==1  )
                               break;                              
                          end  
                         
                 end               
                       matResultat(indicAgent,colonne)=j;
                       tabou=[ tabou j];
                       colonne=colonne+1; 
                       villeActuelle=j;                      
             end          
end  % end for des agents    
    PheroMat=Segma*PheroMat;  % évaporation    
    distances=getVecteurLongeur(matResultat);    
    for i=1:size(matResultat,2)-1  % colonnes
       for j=1:size(matResultat,1) % lignes           
            PheroMat(matResultat(j,i),matResultat(j,i+1))=PheroMat(matResultat(j,i),matResultat(j,i+1))+1/distances(j,1);
       end        
    end   
    vectDist=distances';
    [vv,ind]=min(vectDist);
    MeilleursSolutions=[MeilleursSolutions;matResultat(ind,:)]; 
    nbrIterMax=nbrIterMax-1;
end





vectDistt=getVecteurLongeur(MeilleursSolutions)';    

 [vv,ind]=min(vectDistt);


solution=MeilleursSolutions(ind,:)
cout=vv
MeilleursSolutionss=MeilleursSolutions;

% 
% ***************  pour afficher tous les solutions avec leurs cout
% t=[MeilleursSolutionss';vectDistt];
% t'; 



end








function vect=getVecteurChoix(ListeTabou) % retourner la liste des villes candidates

global ns;


villes=[1:ns];

for i=1:size(ListeTabou,2)   
    for j=1:size(villes,2)        
       if(ListeTabou(1,i)==villes(1,j))
           villes(j)=[];
           break;
       end        
    end    
end

vect=villes;


end






function valeur = getSommePheroVisibilite(ville,listVillesCandidates)
    
   
  
    
  
    
    global PheroMat;
    global Visibile;
    
    val=0;
    for mm=1:size(listVillesCandidates,2)
        
        
        
        val=val+ PheroMat(ville,listVillesCandidates(1,mm)) *  Visibile(ville,listVillesCandidates(1,mm));
        
    end
    
    valeur=val;
end




function boolean=Proba(i,j,listVillesC)    
    global alpha;    
    global beta;    
    global PheroMat;
    global Visibile;
   
    tmp= (PheroMat(i,j)^alpha)*(Visibile(i,j)^beta) ;  
   
    
    tmp = tmp/getSommePheroVisibilite(i,listVillesC);
    
    valeuurAl=rand(1);
    
    if((valeuurAl^2) <= tmp)
        boolean=1;
    else
        boolean=0;
    end
        
end

 


function vectDistancesGlobales=getVecteurLongeur(matResultatt) % return vecteur colonne des distances

global matCout;

vecttt=[];

for elem=matResultatt'
    dist=0;
    
    for i=1:size(elem,1)-1
        dist = dist+matCout(elem(i,1),elem(i+1,1));
        
    end
    vecttt=[vecttt;dist];
    
end
vectDistancesGlobales=vecttt;


end









