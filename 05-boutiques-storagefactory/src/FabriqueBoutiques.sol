// SPDX-License-Identifier: MIT

pragma solidity 0.8.18;

import {Boutique} from "./Boutique.sol";

contract FabriqueBoutiques {

    // La fabrique garde la liste de toutes les boutiques créées.
    Boutique[] public listeDesBoutiques;
    
    // N’importe qui peut demander une nouvelle boutique avec un nom de son choix. 
    // L’appelant en devient le propriétaire.
    function nouvelleBoutique(string memory _nom) public {
        Boutique boutique = new Boutique(msg.sender, _nom);
        listeDesBoutiques.push(boutique);
    }

    // donner le nombre de boutiques
    function nombreDeboutique() public view returns(uint256) {
        return listeDesBoutiques.length;
    }

    // donner le propriétaire de la boutique à une position donnée
    function proprietaireDeLaBoutique(uint256 _index) public view returns(address) {
        return listeDesBoutiques[_index].proprietaire();
    }

    // donner la valeur totale de toutes les boutiques
    function valeurTotaleBoutiques() public view returns(uint256) {
        
        // initialise la valeurTotale à 0
        uint256 valeurTotale = 0;
        
        // boucle pour parcourir chaque élément du tableau de contrats
        // le point de départ : uint256 i = 0;
        // la condition d'arrêt : i < tableau.length; Tant que je n'ai pas dépassé le nombre total de boutique, je continue
        // le pas de course : i++ → Une fois que j'ai fini avec une boutique, je passe immédiatement à la suivante (+1).
        for (uint256 i = 0; i < listeDesBoutiques.length; i++) {
            
            // je demande à la boutique [i] de me donner la valeur de son stock
            valeurTotale += listeDesBoutiques[i].obtenirValeurStock();
        }
        // renvoi du resultat à la fin de la fonction
        return valeurTotale;
    }
}



// ===== Résultats de mes tests =====
// Comptes : A = 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2   B = 0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db
//
// 1. Nombre de boutiques : 2   
//    Propriétaire boutique 0 : 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2 (compte A)   
//    Propriétaire boutique 1 : 0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db (compte B)
//    Raison : nouvelleBoutique passe msg.sender (celui qui l’appelle) au constructor de Boutique, qui le range dans proprietaire. A a donc créé la boutique 0, B la boutique 1.
// 2. Valeur du stock : 350   Calcul : car 100×2 + 50×3
// 3. msg.sender = B, proprietaire = A, donc B == A est faux, et verification() annule
// 4. Vente de 1 : 1   Vente de 5 : revert 
//    Raison : Stock insuffisant
// 5. Valeur totale : 390   
//    Calcul : boutique 0 = 100x2 + 50x3 = 350, boutique 1 = 10×4 = 40, total = 350 + 40 = 390.
//    La fonction parcourt chaque boutique avec une boucle, appelle obtenirValeurStock() sur chacune, et additionne.
//    (fait par le calcul, pas exécuté dans Remix)
// 6. Appel reçu par Boutique envoyé par : la fabrique,   msg.sender = la fabrique, proprietaire = A   Résultat : échoue
//    L'appel reçu par Boutique est envoyé par la fabrique (pas par A).
//    Résultat : la transaction échoue. Le propriétaire (A) ne peut pas passer par la fabrique,
//    parce que Boutique voit la fabrique comme appelant, pas A.