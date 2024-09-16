with Grille; use Grille;

package TAD_Pile is

   TAILLE_MAX : constant := 5000;
   type Type_Pile is private ;

   PILE_VIDE : exception;
   PILE_PLEINE : exception;

   -- construit une pile vide
   function construirePile return Type_Pile;

   -- retourne VRAI si une pile est vide
   function estVide (pile : in Type_Pile) return Boolean;

   -- retourne VRAI si une pile est pleine
   function estPleine (pile : in Type_Pile) return Boolean;

   -- retourne l'element le plus récent de la pile
   -- nécessite pile.nb_elements > 0
   -- lève l'exception PILE_VIDE si pile.nb_elements = 0
   function dernier (pile : in Type_Pile) return Type_Grille;

   -- ajoute un élément à la pile
   -- nécessite pile.nb_elements < pile.maximum_Size
   -- lève l'exception PILE_PLEINE si pile.nb_elements = pile.maximum_Size
   procedure empiler (pile : in out Type_Pile ; grille : in Type_Grille);

   -- supprime l'element le plus recent de la pile
   -- nécessite pile.nb_elements > 0
   procedure depiler (pile : in out Type_Pile);

private

   type Tableau is array (1 .. TAILLE_MAX) of Type_Grille;

   type Type_Pile is record
      elements          : Tableau;
      maximum_Size : Integer;
      nb_elements       : Integer   := 0;
   end record;

end TAD_Pile;
