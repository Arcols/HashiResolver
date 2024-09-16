package body Resolution_Hashi is

   ---------------------------
   -- rechercherUneIleCible --
   ---------------------------
   procedure rechercherUneIleCible
     (G      : in Type_Grille; C : in Type_CaseHashi; O : in Type_Orientation;
      Trouve :    out Boolean; ile : out Type_CaseHashi)
   is
      caseCourante : Type_CaseHashi; -- case courante
      fini         : Boolean;
      Suivant      : Type_CaseHashi;
      TypeSuivant  : Type_TypeCase;
   begin
      --  initialisations
      fini := False;
      -- recherche du successeur
      caseCourante := C;
      while not fini and aUnSuivant (G, caseCourante, O) loop
         -- enregistrement du suivant
         Suivant     := obtenirSuivant (G, caseCourante, O);
         TypeSuivant := ObtenirTypeCase (Suivant);
         -- si c'est la mer je continue
         if estMer (TypeSuivant) then
            caseCourante := Suivant;
         else
            -- si c'est une ile
            if estIle (TypeSuivant) then
               -- si elle est complete c'est fini
               if estIleComplete (ObtenirIle (Suivant)) then
                  Trouve := False;
                  fini   := True;
               else
                  -- si elle n'est pas complete c'est OK
                  Trouve := True;
                  ile    := Suivant;
                  fini   := True;
               end if;
               -- si c'est un pont
            else
               if estPont (TypeSuivant) then
                  -- s'il est de valeur 2 c'est mort
                  if ObtenirPont (Suivant) = DEUX then
                     Trouve := False;
                     fini   := True;
                     -- il est de valeur 1
                  else
                     -- si son predecesseur est
                     -- de valeur 1 on continue
                     if (estPont (ObtenirTypeCase (caseCourante))
                         and then ObtenirPont (caseCourante) = UN)
                       or (EstIle(ObtenirTypeCase(CaseCourante)))
                     then
                        caseCourante := Suivant;
                     else
                        -- a moins que ce soit un croisement dans ce cas on
                        -- arrete
                        Trouve := False;
                        fini   := True;
                     end if;
                  end if;
               end if;
            end if;
         end if;
      end loop;
      -- N'a pas de suivant
      if not aUnSuivant (G, caseCourante, O) then
         Trouve := False;
      end if;
   end rechercherUneIleCible;
   ----------------------------------
   -- construireTableauSuccesseurs --
   ----------------------------------

   procedure construireTableauSuccesseurs
     (G : in     Type_Grille; C : Type_CaseHashi; s : out Type_Tab_Successeurs; NbPonts :    out Integer; NbNoeuds : out Integer)
   is
      Mer : Type_CaseHashi;
      ile : Type_CaseHashi;
      trouve : Boolean;


   begin
      Mer := ConstruireCase(ConstruireCoordonnees(0,0));
      NbPonts := 0;
      NbNoeuds := 0;
      rechercherUneIleCible(G,C,NORD,trouve,ile);
      if not trouve then
         s.NORD := Mer;
      else
         NbNoeuds := NbNoeuds +1;
         s.NORD := ile;
         if ObtenirValeur(ObtenirIle(ile)) > 1 and ObtenirValeur(ObtenirIle(C))>1 then
            NbPonts := NbPonts +2;
            s.pontsNord := 2;
         else
            NbPonts := NbPonts +1;
            s.pontsNord := 1;
         end if;
      end if;
      rechercherUneIleCible(G,C,SUD,trouve,ile);
      if not trouve then
         s.SUD := Mer;
      else
         NbNoeuds := NbNoeuds +1;
         s.SUD := ile;
         if ObtenirValeur(ObtenirIle(ile)) > 1 and ObtenirValeur(ObtenirIle(C))>1 then
            NbPonts := NbPonts +2;
            s.pontsSud := 2;
         else
            NbPonts := NbPonts +1;
            s.pontsSud := 1;
         end if;
      end if;

      rechercherUneIleCible(G,C,EST,trouve,ile);
      if not trouve then
         s.EST := Mer;
      else
         NbNoeuds := NbNoeuds +1;
         s.EST := ile;
         if ObtenirValeur(ObtenirIle(ile)) > 1 and ObtenirValeur(ObtenirIle(C))>1 then
            NbPonts := NbPonts +2;
            s.pontsEst := 2;
         else
            NbPonts := NbPonts +1;
            s.pontsEst := 1;
         end if;
      end if;

      rechercherUneIleCible(G,C,OUEST,trouve,ile);
      if not trouve then
         s.OUEST := Mer;
      else
         NbNoeuds := NbNoeuds +1;
         s.OUEST := ile;
         if ObtenirValeur(ObtenirIle(ile)) > 1 and ObtenirValeur(ObtenirIle(C))>1 then
            NbPonts := NbPonts +2;
            s.pontsOuest := 2;
         else
            NbPonts := NbPonts +1;
            s.pontsOuest := 1;
         end if;
      end if;

   end construireTableauSuccesseurs;

   ------------------------
   -- construireLeChemin --
   ------------------------

   procedure construireLeChemin
     (G     : in out Type_Grille; source : in out Type_CaseHashi;
      cible : in out Type_CaseHashi; pont : in Type_Pont;
      o     : in     Type_Orientation)
   is
      case_suivante : Type_CaseHashi := source;
   begin
      while not estIle(ObtenirTypeCase(obtenirSuivant(G, case_suivante, o))) loop
         case_suivante := obtenirSuivant(G, case_suivante, o);
         case_suivante := modifierPont(case_suivante, pont);
         G := modifierCase(G, case_suivante);
      end loop;
   end construireLeChemin;

   ------------------------
   -- connecterTousPonts --
   ------------------------
   procedure connecterTousPonts
     (G     : in out Type_Grille; source : in out Type_CaseHashi;
      Tab_Succes : in Type_Tab_Successeurs )
   is
      cible : Type_CaseHashi;
      ile_source : Type_Ile := ObtenirIle(source);
      ile_cible : Type_Ile;
      val_UN : Integer := obtenirValeur(UN);
      val_DEUX : Integer := obtenirValeur(DEUX);
   begin
      --Pour l'ile cible NORD
      cible := Tab_Succes.NORD;
      --Si la case est une ile
      if estIle(ObtenirTypeCase(cible)) then
         ile_cible := ObtenirIle(cible);
         --Si il n'y a qu'un pont potentiel entre ile source et ile cible
         if Tab_Succes.pontsNord = 1 then
            --Construire le pont
            construireLeChemin(G, source, cible, UN, NORD);
            --Mettre à jour les iles
            ile_source := modifierIle(ile_source,val_UN);
            ile_cible := modifierIle(ile_cible, val_UN);
            --Sinon si il y a deux ponts potentiels entre ile source et ile cible
         elsif Tab_Succes.pontsNord > 1 then
            --Construire les ponts
            construireLeChemin(G, source, cible, DEUX, NORD);
            --Mettre à jour les iles
            ile_source := modifierIle(ile_source,val_DEUX);
            ile_cible := modifierIle(ile_cible, val_DEUX);
         end if;
         --Mettre à jour la grille
         G := modifierCase(G,modifierIle(ConstruireCase(ObtenirCoordonnee(cible)), ile_cible));
      end if;

      --Pour l'ile cible SUD
      cible := Tab_Succes.SUD;
      --Si la case est une ile
      if estIle(ObtenirTypeCase(cible)) then
         ile_cible := ObtenirIle(cible);
         --Si il n'y a qu'un pont potentiel entre ile source et ile cible
         if Tab_Succes.pontsSud = 1 then
            --Construire le pont
            construireLeChemin(G, source, cible, UN, SUD);
            --Mettre à jour les iles
            ile_source := modifierIle(ile_source,val_UN);
            ile_cible := modifierIle(ile_cible, val_UN);
            --Sinon si il y a deux ponts potentiels entre ile source et ile cible
         elsif Tab_Succes.pontsSud > 1 then
            --Construire les ponts
            construireLeChemin(G, source, cible, DEUX, SUD);
            --Mettre à jour les iles
            ile_source := modifierIle(ile_source,val_DEUX);
            ile_cible := modifierIle(ile_cible, val_DEUX);
         end if;
         --Mettre à jour la grille
         G := modifierCase(G,modifierIle(ConstruireCase(ObtenirCoordonnee(cible)), ile_cible));
      end if;

      --Pour l'ile cible OUEST
      cible := Tab_Succes.OUEST;
      --Si la case est une ile
      if estIle(ObtenirTypeCase(cible)) then
         ile_cible := ObtenirIle(cible);
         --Si il n'y a qu'un pont potentiel entre ile source et ile cible
         if Tab_Succes.pontsOuest = 1 then
            --Construire le pont
            construireLeChemin(G, source, cible, UN, OUEST);
            --Mettre à jour les iles
            ile_source := modifierIle(ile_source,val_UN);
            ile_cible := modifierIle(ile_cible, val_UN);
            --Sinon si il y a deux ponts potentiels entre ile source et ile cible
         elsif Tab_Succes.pontsOuest > 1 then
            --Construire les ponts
            construireLeChemin(G, source, cible, DEUX, OUEST);
            --Mettre à jour les iles
            ile_source := modifierIle(ile_source,val_DEUX);
            ile_cible := modifierIle(ile_cible, val_DEUX);
         end if;
         --Mettre à jour la grille
         G := modifierCase(G,modifierIle(ConstruireCase(ObtenirCoordonnee(cible)), ile_cible));
      end if;

      --Pour l'ile cible EST
      cible := Tab_Succes.EST;
      --Si la case est une ile
      if estIle(ObtenirTypeCase(cible)) then
         ile_cible := ObtenirIle(cible);
         --Si il n'y a qu'un pont potentiel entre ile source et ile cible
         if Tab_Succes.pontsEst = 1 then
            --Construire le pont
            construireLeChemin(G, source, cible, UN, EST);
            --Mettre à jour les iles
            ile_source := modifierIle(ile_source,val_UN);
            ile_cible := modifierIle(ile_cible, val_UN);
            --Sinon si il y a deux ponts potentiels entre ile source et ile cible
         elsif Tab_Succes.pontsEst > 1 then
            --Construire les ponts
            construireLeChemin(G, source, cible, DEUX, EST);
            --Mettre à jour les iles
            ile_source := modifierIle(ile_source,val_DEUX);
            ile_cible := modifierIle(ile_cible, val_DEUX);
         end if;
         --Mettre à jour la grille
         G := modifierCase(G,modifierIle(ConstruireCase(ObtenirCoordonnee(cible)), ile_cible));
      end if;
      --Mettre à jour la grille
      G := modifierCase(G,modifierIle(ConstruireCase(ObtenirCoordonnee(source)), ile_source));
   end connecterTousPonts;

   -------------------------------
   -- connecterTousPontsDoubles --
   -------------------------------
   procedure connecterTousPontsDoubles
     (G     : in out Type_Grille; source : in out Type_CaseHashi;
      Tab_Succes : in Type_Tab_Successeurs )
   is
      cible : Type_CaseHashi;
      ile_source : Type_Ile := ObtenirIle(source);
      ile_cible : Type_Ile;
      val_DEUX : Integer := obtenirValeur(DEUX);

   begin
      --Pour l'ile cible NORD
      cible := Tab_Succes.NORD;

      --Si la case est une ile et nb pont potentiels avec ile cible < 1
      if estIle(ObtenirTypeCase(cible)) and then Tab_Succes.pontsNord > 1 then
         --Construire les ponts
         construireLeChemin(G, source, cible, DEUX, NORD);
         --mettre à jour les îles
         ile_source := modifierIle(ile_source,val_DEUX);
         ile_cible := ObtenirIle(cible);
         ile_cible := modifierIle(ile_cible, val_DEUX);
         --Mettre à jour la grille
         G := modifierCase(G,modifierIle(ConstruireCase(ObtenirCoordonnee(cible)), ile_cible));

      end if;
      --Pour l'ile cible SUD
      cible := Tab_Succes.SUD;
      --Si la case est une ile et nb pont potentiels avec ile cible < 1
      if estIle(ObtenirTypeCase(cible)) and then Tab_Succes.pontsSud > 1 then
         --Construire les ponts
         construireLeChemin(G, source, cible, DEUX, SUD);
         --mettre à jour les îles
         ile_source := modifierIle(ile_source,val_DEUX);
         ile_cible := ObtenirIle(cible);
         ile_cible := modifierIle(ile_cible, val_DEUX);
         --Mettre à jour la grille
         G := modifierCase(G,modifierIle(ConstruireCase(ObtenirCoordonnee(cible)), ile_cible));

      end if;
      --Pour l'ile cible OUEST
      cible := Tab_Succes.OUEST;
      --Si la case est une ile et nb pont potentiels avec ile cible < 1
      if estIle(ObtenirTypeCase(cible)) and then Tab_Succes.pontsOuest > 1 then
         --Construire les ponts
         construireLeChemin(G, source, cible, DEUX, OUEST);
         --mettre à jour les îles
         ile_source := modifierIle(ile_source,val_DEUX);
         ile_cible := ObtenirIle(cible);
         ile_cible := modifierIle(ile_cible, val_DEUX);
         --Mettre à jour la grille
         G := modifierCase(G,modifierIle(ConstruireCase(ObtenirCoordonnee(cible)), ile_cible));

      end if;
      --Pour l'ile cible EST
      cible := Tab_Succes.EST;
      --Si la case est une ile et nb pont potentiels avec ile cible < 1
      if estIle(ObtenirTypeCase(cible)) and then Tab_Succes.pontsEst > 1 then
         --Construire les ponts
         construireLeChemin(G, source, cible, DEUX, EST);
         --mettre à jour les îles
         ile_source := modifierIle(ile_source,val_DEUX);
         ile_cible := ObtenirIle(cible);
         ile_cible := modifierIle(ile_cible, val_DEUX);
         --Mettre à jour la grille
         G := modifierCase(G,modifierIle(ConstruireCase(ObtenirCoordonnee(cible)), ile_cible));

      end if;
      G := modifierCase(G,modifierIle(ConstruireCase(ObtenirCoordonnee(source)), ile_source));
   end connecterTousPontsDoubles;

   -------------------------------
   -- connecterTousPontsSimples --
   -------------------------------
   procedure connecterTousPontsSimples
     (G     : in out Type_Grille; source : in out Type_CaseHashi;
      Tab_Succes : in Type_Tab_Successeurs; modifier : in out Boolean)
   is
      cible : Type_CaseHashi;
      ile_source : Type_Ile := ObtenirIle(source);
      ile_cible : Type_Ile;
      val_UN : Integer := obtenirValeur(UN);

   begin
      --Pour l'ile cible NORD
      cible := Tab_Succes.NORD;

      --Si la case est une ile
      if estIle(ObtenirTypeCase(cible)) then
         --Contruire le pont
         construireLeChemin(G, source, cible, UN, NORD);
         --Mettre à jour les îles
         ile_source := modifierIle(ile_source,val_UN);
         ile_cible := ObtenirIle(cible);
         ile_cible := modifierIle(ile_cible, val_UN);
         --Mettre à jour la grille
         G := modifierCase(G,modifierIle(ConstruireCase(ObtenirCoordonnee(cible)), ile_cible));

         modifier:=True;
      end if;
      --Pour l'ile cible SUD
      cible := Tab_Succes.SUD;
      --Si la case est une ile
      if estIle(ObtenirTypeCase(cible)) then
         --Contruire le pont
         construireLeChemin(G, source, cible, UN, SUD);
         --Mettre à jour les îles
         ile_source := modifierIle(ile_source,val_UN);
         ile_cible := ObtenirIle(cible);
         ile_cible := modifierIle(ile_cible, val_UN);
         --Mettre à jour la grille
         G := modifierCase(G,modifierIle(ConstruireCase(ObtenirCoordonnee(cible)), ile_cible));

         modifier:=True;
      end if;
      --Pour l'ile cible OUEST
      cible := Tab_Succes.OUEST;
      --Si la case est une ile
      if estIle(ObtenirTypeCase(cible)) then
         --Contruire le pont
         construireLeChemin(G, source, cible, UN, OUEST);
         --Mettre à jour les îles
         ile_source := modifierIle(ile_source,val_UN);
         ile_cible := ObtenirIle(cible);
         ile_cible := modifierIle(ile_cible, val_UN);
         --Mettre à jour la grille
         G := modifierCase(G,modifierIle(ConstruireCase(ObtenirCoordonnee(cible)), ile_cible));

         modifier:=True;
      end if;
      --Pour l'ile cible EST
      cible := Tab_Succes.EST;
      --Si la case est une ile
      if estIle(ObtenirTypeCase(cible)) then
         --Contruire le pont
         construireLeChemin(G, source, cible, UN, EST);
         --Mettre à jour les îles
         ile_source := modifierIle(ile_source,val_UN);
         ile_cible := ObtenirIle(cible);
         ile_cible := modifierIle(ile_cible, val_UN);
         --Mettre à jour la grille
         G := modifierCase(G,modifierIle(ConstruireCase(ObtenirCoordonnee(cible)), ile_cible));

         modifier:=True;
      end if;
      G := modifierCase(G,modifierIle(ConstruireCase(ObtenirCoordonnee(source)), ile_source));
   end connecterTousPontsSimples;

   ---------------------------
   -- resolutionAlgoLogique --
   ---------------------------
   procedure resolutionAlgoLogique (G : in out Type_Grille; Trouve : out Boolean) is
      ligne : Integer;
      colonne : Integer;
      NumIle, nbPontDispo, nbIleAdj : Integer;
      Tab_Succes : Type_Tab_Successeurs;
      caseCourante : Type_CaseHashi;
      modifier : Boolean;
   begin
      ligne := 1;
      colonne := 1;
      modifier :=  TRUE;
      Trouve := False;

      while modifier loop
         modifier := FALSE;
         -- Pour toutes les cases de la grille
         for ligne in 1..nbLignes(G) loop
            for colonne in 1..nbColonnes(G) loop
               -- Si la case est une île alors
               caseCourante := ObtenirCase(G, ConstruireCoordonnees(ligne,colonne));
               if estIle(ObtenirTypeCase(caseCourante)) then
                  --Compter le nombre de pont(s) disponible(s) pour l'île;
                  NumIle := ObtenirValeur(ObtenirIle(caseCourante));
                  -- Faire la somme des îles disponibles adjacentes;
                  -- Faire la somme du nombre de pont(s) disponible(s) avec les île adjacentes;
                  construireTableauSuccesseurs(G, caseCourante, Tab_Succes, nbPontDispo, nbIleAdj);
                  -- Si nombre de pont(s) disponible(s) pour l'île = ( somme du nombre de pont(s) disponible(s) avec les île adjacentes )	alors
                  if NumIle = nbPontDispo and NumIle /= 0 then
                     connecterTousPonts(G, caseCourante, Tab_Succes);
                     modifier := TRUE;
                     --Si nombre de pont(s) disponible(s) pour l'île = (somme des îles disponibles adjacentes) *2 alors
                  elsif NumIle = nbIleAdj *2 and NumIle /= 0 then
                     --Connecter l'île actuelle avec les voisins restant avec des ponts doubles;
                     connecterTousPontsDoubles(G, caseCourante, Tab_Succes);
                     modifier := TRUE;
                     --Si nombre de pont(s) disponible(s) pour l'île = (somme des îles disponibles adjacentes) *2 -1 alors
                  elsif NumIle = ((nbIleAdj*2)-1) and NumIle /= 0 then
                     --Connecter l'île actuelle avec les voisins restant avec des ponts simples;
                     connecterTousPontsSimples(G, caseCourante, Tab_Succes,modifier);
                  end if;
               end if;
            end loop;
         end loop;
      end loop;
      Trouve := estComplete(G);
   end resolutionAlgoLogique;
   -------------------
   -- ResoudreHashi --
   -------------------

   procedure ResoudreHashi (G : in out Type_Grille; Trouve : out Boolean) is
      --GCP : Type_Grille;
      --pile : Type_Pile;

   begin
      Trouve := False;
      -- resolutionAlgoLogique(G, Trouve) = ETAPE 1
      resolutionAlgoLogique(G, Trouve);
      if not Trouve then
         -- copier la grille courante dans NewGrille    ETAPE 2
         --GPC := G
         -- Empiler la grille courante                   ETAPE 2
         -- empiler (pile, GPC);
         -- Pour toutes les cases de la NewGrille       ETAPE 3
            --for ligne in 1..nblignes(GPC) loop
                --for colonne in 1..nbColonnes(GPC) loop
                  -- Si la case est une île alors
                     -- Tant qu'il reste des ponts à relier       ETAPE 3
                       -- Placer un pont entre la caseCourante et une île ETAPE 4
                       -- ETAPE 1
                       -- ETAPE 2
                       -- ETAPE 3
                       -- Si aucun pont disponible faire,
                         -- Dépiler
                         -- ETAPE 4
                       -- fin si
                     -- fin tant que
                  -- fin si
                -- fin boucle
              -- fin boucle
         -- fin pour tout
         -- fin
         -- L'algorithme est en cours de traduction et d'amélioration
         null;
      end if;
   end ResoudreHashi;
end Resolution_Hashi;
