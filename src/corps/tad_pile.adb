pragma Ada_2012;
package body TAD_Pile is

   --------------------
   -- construirePile --
   --------------------

   function construirePile return Type_Pile is
      pile : Type_Pile;
   begin
      pile.maximum_Size := TAILLE_MAX;
      return pile;
   end construirePile;

   -------------
   -- estVide --
   -------------

   function estVide (pile : in Type_Pile) return Boolean is
   begin
      if pile.nb_elements = 0 then
         return True;
      end if;
      return False;
   end estVide;

   ---------------
   -- estPleine --
   ---------------

   function estPleine (pile : in Type_Pile) return Boolean is
   begin
      if pile.nb_elements = pile.maximum_Size then
         return True;
      end if;
      return False;
   end estPleine;

   -------------
   -- dernier --
   -------------

   function dernier (pile : in Type_Pile) return Type_Grille is
   begin
      if estVide(pile) then
         raise PILE_VIDE;
      end if;
      return pile.elements(pile.nb_elements);
   end dernier;

   -------------
   -- empiler --
   -------------

   procedure empiler (pile : in out Type_Pile ; grille : in Type_Grille) is
   begin
      if estPleine(pile) then
         raise PILE_PLEINE;
      end if;
      if pile.nb_elements < pile.maximum_Size then
         pile.nb_elements := pile.nb_elements + 1;
         pile.elements(pile.nb_elements) := grille;
      end if;
   end empiler;

   -------------
   -- depiler --
   -------------

   procedure depiler (pile : in out Type_Pile) is
   begin
      if not estVide(pile) then
         pile.nb_elements := pile.nb_elements - 1;
      end if;
   end depiler;

end TAD_Pile;
