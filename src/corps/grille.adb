pragma Ada_2012;
package body Grille is

   function ConstruireGrille (nbl : in Integer; nbc : in Integer) return Type_Grille is
      initialCase : Type_CaseHashi := ConstruireCase(ConstruireCoordonnees(0,0)); -- Initialisation d'une case par dÃÂ©faut
      grille : Type_Grille;
   begin
      if nbl <= 1 or nbl > TAILLE_MAX or nbc <= 1 or nbc > TAILLE_MAX then
         raise TAILLE_INVALIDE;
      end if;
      for ligne in 1..nbl loop
         for colonne in 1..nbc loop
            grille.g(ligne,colonne):=ConstruireCase(ConstruireCoordonnees(ligne,colonne));
         end loop;
      end loop;
      grille.nbl:=nbl;
      grille.nbc:=nbc;
      return grille;
   end ConstruireGrille;

   function nbLignes (G : Type_Grille) return Integer is
   begin
      return G.nbl;
   end nbLignes;

   function nbColonnes (G : Type_Grille) return Integer is
   begin
      return G.nbc;
   end nbColonnes;

   function estGrilleVide (G : in Type_Grille) return Boolean is
   begin
      if nbIle(G) = 0 then
         return True;
      else
         return False;
      end if;

   end estGrilleVide;

   -- Verifie si toutes les iles de la grille sont completes
   function estComplete (G : in Type_Grille) return Boolean is
   begin
      if estGrilleVide(G) then
         return False;

      elsif nbIle(G) = nbIleCompletes(G) then
         return True;
      else
         return False;
      end if;
   end estComplete;

   -- Compte le nombre total d'Ã®les dans la grille
   function nbIle (G : in Type_Grille) return Integer is
      count : Integer := 0;
   begin
      for ligne in 1..G.nbl loop
         for colonne in 1..G.nbc loop
            if estIle(ObtenirTypeCase(G.g(ligne,colonne))) then
               count := count + 1;
            end if;
         end loop;
      end loop;
      return count;
   end nbIle;

   -- Compte le nombre d'Ã®les complÃ¨tes dans la grille
   function nbIleCompletes (G : in Type_Grille) return Integer is
      count : Integer := 0;
   begin
      for ligne in 1..G.nbl loop
         for colonne in 1..G.nbc loop
            if estIle(ObtenirTypeCase(G.g(ligne,colonne))) then
               if estIleComplete(ObtenirIle(G.g(ligne,colonne))) then
                  count := count + 1;
               end if;
            end if;
         end loop;
      end loop;
      return count;
   end nbIleCompletes;

   -- Obtient la case Ã  une coordonnÃ©e donnÃ©e
   function ObtenirCase (G : in Type_Grille; Co : in Type_Coordonnee)
                          return Type_CaseHashi is
   begin
      return G.g(ObtenirLigne(Co), ObtenirColonne(Co));
   end ObtenirCase;



   function aUnSuivant
     (G : in Type_Grille; c : in Type_CaseHashi; o : Type_Orientation)
      return Boolean is
      coord : Type_Coordonnee := ObtenirCoordonnee(c);
   begin
      -- Vérifier la direction et l'existence d'une case adjacente
      if o = NORD and ObtenirLigne(coord) > 1 then
         return True;
      elsif o = SUD and ObtenirLigne(coord) < G.nbl then
         return True;
      elsif o = EST and ObtenirColonne(coord) < G.nbc then
         return True;
      elsif o = OUEST and ObtenirColonne(coord) > 1 then
         return True;
      end if;
      return False;
   end aUnSuivant;




function obtenirSuivant(G : in Type_Grille; c : in Type_CaseHashi; o : Type_Orientation) return Type_CaseHashi is
   coord_courante : Type_Coordonnee;
begin
   coord_courante := ObtenirCoordonnee(c);

   -- Utiliser les coordonnées pour trouver la case successeur dans la direction donnée
   if o = NORD then
      if ObtenirLigne(coord_courante) > 1 then
         coord_courante := ConstruireCoordonnees(ObtenirLigne(coord_courante)-1, ObtenirColonne(coord_courante));
         return ObtenirCase(G, coord_courante);
      else
         raise PAS_DE_SUIVANT;
      end if;
   elsif o = SUD then
      if ObtenirLigne(coord_courante) < nbLignes(G) then
         coord_courante := ConstruireCoordonnees(ObtenirLigne(coord_courante)+1, ObtenirColonne(coord_courante));
         return ObtenirCase(G, coord_courante);
      else
         raise PAS_DE_SUIVANT;
      end if;
   elsif o = EST then
      if ObtenirColonne(coord_courante) < nbColonnes(G) then
         coord_courante := ConstruireCoordonnees(ObtenirLigne(coord_courante), ObtenirColonne(coord_courante)+1);
         return ObtenirCase(G, coord_courante);
      else
         raise PAS_DE_SUIVANT;
      end if;
   elsif o = OUEST then
      if ObtenirColonne(coord_courante) > 1 then
         coord_courante := ConstruireCoordonnees(ObtenirLigne(coord_courante), ObtenirColonne(coord_courante)-1);
         return ObtenirCase(G, coord_courante);
      else
         raise PAS_DE_SUIVANT;
      end if;
   else
      raise PAS_DE_SUIVANT; -- Gérer toutes les autres orientations
   end if;
end obtenirSuivant;



   function modifierCase
     (G : in Type_Grille ; c : in Type_CaseHashi) return Type_Grille is
      coord : Type_Coordonnee;
      Gtest : Type_Grille;
   begin
      Gtest := G;
      -- Obtenir les coordonnées de la case à modifier
      coord := ObtenirCoordonnee(c);

      -- Vérifier si les coordonnées sont dans les limites de la grille
      if ObtenirLigne(coord) >= 1 and ObtenirLigne(coord) <= Gtest.nbl and
        ObtenirColonne(coord) >= 1 and ObtenirColonne(coord) <= Gtest.nbc then
         -- Mettre à jour la case dans la grille
         Gtest.g(ObtenirLigne(coord), ObtenirColonne(coord)) := c;
         return Gtest;
      else
         -- Gérer le cas où les coordonnées sont hors des limites
         raise Constraint_Error; -- ou toute autre exception appropriée
      end if;
   end modifierCase;

end Grille;
