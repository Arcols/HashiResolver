# HashiResolver

HashiResolver est un projet visant à résoudre des grilles de Hashiwokakero (Hashi) en utilisant un algorithme de logique développé par notre groupe. Ce projet ne fait pas appel à des méthodes de force brute ou similaires.

## Structure du projet

Le projet est structuré comme suit :
HashiResolver/ 
├── .gitattributes 
├── .gitignore 
├── content.txt 
├── hashi.gpr 
├── LICENSE 
├── README.md 
├── src/ │ 
    ├── corps/ 
    │ │ ├── casehashi.adb 
    │ │ ├── coordonnee.adb 
    │ │ ├── grille.adb 
    │ │ ├── ile.adb 
    │ │ ├── orientation.adb 
    │ │ ├── pont.adb 
    │ │ ├── resolution_hashi.adb 
    │ │ ├── tad_pile.adb 
    │ │ ├── typecase.adb 
    │ ├── specifications/ 
    │ │ ├── case.ads 
    │ │ ├── caseHashi.ads 
    │ │ ├── coordonnee.ads 
    │ │ ├── grille.ads 
    │ │ ├── ile.ads 
    │ │ ├── orientation.ads 
    │ │ ├── pile_entier.ads 
    │ │ ├── pont.ads 
    │ │ ├── resolution_hashi.ads 
    │ │ ├── TAD_Pile.ads 
    │ │ ├── typecase.ads 
    ├── tests/ 
    │ ├── tests_resolution/ 
    │ ├── Tests_TAD/
## Fonctionnalités

- Résolution des grilles de Hashi en utilisant un algorithme de logique.
- Gestion des coordonnées, orientations, îles, ponts et types de cases.
- Tests unitaires pour vérifier le bon fonctionnement des différentes parties du projet.

## Algorithme de résolution

L'algorithme de résolution des grilles de Hashi se trouve dans le fichier [src/corps/resolution_hashi.adb](src/corps/resolution_hashi.adb). Cet algorithme utilise des techniques de logique pour résoudre les grilles sans recourir à la force brute.

## Tests

Les tests unitaires pour les différentes parties du projet se trouvent dans le dossier [tests/Tests_TAD](tests/Tests_TAD). Pour exécuter tous les tests, utilisez le fichier [tests/Tests_TAD/run_all_tests.adb](tests/Tests_TAD/run_all_tests.adb).

## Installation

Pour installer et compiler le projet, suivez les étapes ci-dessous :

1. Clonez le dépôt :
    ```sh
    git clone <https://github.com/Arcols/HashiResolver>
    cd HashiResolver
    ```

2. Installez GNAT (compilateur Ada) si ce n'est pas déjà fait. Vous pouvez le télécharger depuis [GNAT Community](https://www.adacore.com/community).

3. Compilez le projet en utilisant le fichier de projet GNAT [hashi.gpr](hashi.gpr) :
    ```sh
    gnatmake -P hashi.gpr
    ```

4. Exécutez les tests :
    ```sh
    ./obj/run_all_tests
    ```

## Contributeurs

Ce projet a été développé par notre groupe dans le cadre d'un projet académique.

## Licence

Ce projet est sous licence MIT. Voir le fichier [LICENSE](./LICENSE) pour plus de détails.