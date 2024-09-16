with Grille;     use Grille;
with Pont ; use Pont;
with CaseHashi; use CaseHashi;
with Orientation; use Orientation;
with TypeCase; use TypeCase;
with Ile; use ile;
with Coordonnee; use Coordonnee;
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;

package Resolution_Hashi is

   --type Type_Tab_Successeurs is private;
   type Type_Tab_Successeurs is record
      NORD : Type_CaseHashi;
      SUD : Type_CaseHashi;
      EST : Type_CaseHashi;
      OUEST : Type_CaseHashi;
      pontsNord: Integer;
      pontsSud: Integer;
      pontsEst: Integer;
      pontsOuest: Integer;
   end record;

   N_EST_PAS_UNE_ILE : exception ;
   PAS_D_ILE_CIBLE : exception ;

   -- retourne trouvÃ© Ã  VRAI si il existe une Ã®le non complÃ¨te
   -- qui succÃ¨de Ã  la case c de grille g pour l'orientation o
   -- si l'ile a Ã©tÃ© trouvÃ©e, alors ile est la case trouvÃ©e
   -- TrouvÃ© est Ã  FAUX si la case c n'a pas de suivant
   -- TrouvÃ© est Ã  FAUX si la case c a comme successeurs
   -- -- uniquement des cases MER OU
   -- -- une ile complete OU
   -- -- un ou plusieurs pont de valeur 2 OU
   -- -- un pont de valeur 1 prÃ©cÃ©dÃ© ou suivi de mer
   -- necessite c est une ile
   -- leve l'exception N_EST_PAS_UNE_ILE si c est une mer ou un pont
   procedure rechercherUneIleCible
     (G : in Type_Grille; C : in Type_CaseHashi; O : in Type_Orientation ;
      Trouve : out Boolean ; ile : out Type_CaseHashi);

   -- construit le tableau des succeseurs de la case c du graphe G
   -- si la case n'a pas de successeur dans une direction, la case
   -- retournée est une Mer de coodonnées (0,0)
   -- nbPont est le nombre de ponts successeurs potentiels
   -- nbNoeud est le nombre de noeuds successeurs potentiels
   procedure construireTableauSuccesseurs
     (G : in     Type_Grille; C : Type_CaseHashi; s : out Type_Tab_Successeurs;
      NbPonts :    out Integer; NbNoeuds : out Integer);

   -- modifie le graÄ¥e g en inscrivant des ponts de valeur pont
   -- entre la case source et la case cible
   -- en suivant l'orientation o
   procedure construireLeChemin
     (G     : in out Type_Grille; source : in out Type_CaseHashi;
      cible : in out Type_CaseHashi; pont : in Type_Pont;
      o     : in     Type_Orientation);

   --Connecte tous les ponts potentiels de l'ile source
   procedure connecterTousPonts
     (G     : in out Type_Grille; source : in out Type_CaseHashi;
      Tab_Succes : in Type_Tab_Successeurs );

   ----Connecter l'île actuelle avec les voisins potentiels avec des ponts simples
   procedure connecterTousPontsSimples
     (G     : in out Type_Grille; source : in out Type_CaseHashi;
      Tab_Succes : in Type_Tab_Successeurs; modifier : in out Boolean);

   --Connecter l'île actuelle avec les voisins potentiels avec des ponts doubles
   procedure connecterTousPontsDoubles
     (G     : in out Type_Grille; source : in out Type_CaseHashi;
      Tab_Succes : in Type_Tab_Successeurs );

   -- Lance la résolution d'une grille de Hashi en suivant l'algo de logique
   procedure resolutionAlgoLogique (G : in out Type_Grille; Trouve : out Boolean);

   -- RÃ©soud la grille g de Hashi
   -- Si tous les noeuds sont complets alors Trouve est a VRAI
   -- trouver est Ã  FAUX sinon
   procedure ResoudreHashi (G : in out Type_Grille; Trouve : out Boolean);

   --  private
   --     type Type_Tab_Successeurs is record
   --        NORD : Type_CaseHashi;
   --        SUD : Type_CaseHashi;
   --        EST : Type_CaseHashi;
   --        OUEST : Type_CaseHashi;
   --      end record;

end Resolution_Hashi;
