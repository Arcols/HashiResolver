pragma Ada_2012;
package body Orientation is

   -----------------------
   -- ValeurOrientation --
   -----------------------

   function ValeurOrientation (o : in Type_Orientation) return Integer is
   begin
      if o = NORD then
         return -1;
      elsif o = SUD then
         return 1;
      elsif o = EST then
         return -2;
      elsif o = OUEST then
         return 2;
      else
         return 0; -- Comportement par défaut pour les autres valeurs
      end if;
   end ValeurOrientation;

   ------------------------
   -- orientationInverse --
   ------------------------

   function orientationInverse
     (o : in Type_Orientation) return Type_Orientation
   is
   begin
      if o = NORD then
         return SUD;
      elsif o = SUD then
         return NORD;
      elsif o = EST then
         return OUEST;
      elsif o = OUEST then
         return EST;
      else
         raise Program_Error with "Orientation inconnue pour l'inversion";
      end if;
   end orientationInverse;

end Orientation;
